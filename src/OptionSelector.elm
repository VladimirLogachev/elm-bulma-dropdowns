module OptionSelector exposing (Model, Msg, Option, init, subscriptions, update, view)

import Browser.Events
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Decode as Decode
import Set exposing (Set)


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.isOpen then
        isOutsideElement model.domElementId
            |> Decode.andThen (\() -> Decode.succeed CloseDropdown)
            |> Browser.Events.onMouseUp

    else
        Sub.none


isOutsideElement : String -> Decode.Decoder ()
isOutsideElement domElementId =
    let
        isOutsideElementAndParentNodes : String -> Decode.Decoder Bool
        isOutsideElementAndParentNodes checkDomElementId =
            Decode.oneOf
                [ Decode.field "id" Decode.string
                    |> Decode.andThen
                        (\id ->
                            if checkDomElementId == id then
                                -- Quickly "succeed" decoding with failing result
                                -- to avoid extra (unnecessary) decoding attempts with parent nodes
                                Decode.succeed False

                            else
                                Decode.fail "check parent node"
                        )
                , Decode.lazy (\_ -> isOutsideElementAndParentNodes checkDomElementId |> Decode.field "parentNode")
                , Decode.succeed True
                ]
    in
    Decode.field "target" (isOutsideElementAndParentNodes domElementId)
        |> Decode.andThen
            (\isOutside ->
                if isOutside then
                    Decode.succeed ()

                else
                    Decode.fail "inside"
            )


type alias Config =
    { domElementId : String
    , selectorTitle : String
    , selectedIds : Set String
    , options : List Option
    }


type alias Model =
    { domElementId : String
    , selectorTitle : String
    , selectedIds : Set String
    , options : List Option
    , isOpen : Bool
    }


type alias Option =
    { id : String, title : String }


init : Config -> ( Model, Cmd msg )
init { domElementId, selectorTitle, selectedIds, options } =
    ( { domElementId = domElementId
      , selectorTitle = selectorTitle
      , selectedIds = selectedIds
      , options = options
      , isOpen = False
      }
    , Cmd.none
    )


type Msg
    = ToggleOption Option
    | OpenDropdown
    | CloseDropdown


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleOption option ->
            let
                selectedIds : Set String
                selectedIds =
                    if Set.member option.id model.selectedIds then
                        Set.remove option.id model.selectedIds

                    else
                        Set.insert option.id model.selectedIds
            in
            ( { model | selectedIds = selectedIds }, Cmd.none )

        OpenDropdown ->
            ( { model | isOpen = True }, Cmd.none )

        CloseDropdown ->
            ( { model | isOpen = False }, Cmd.none )


emptyHtml : Html msg
emptyHtml =
    text ""


view : Model -> Html Msg
view { domElementId, selectorTitle, selectedIds, options, isOpen } =
    let
        selectedOptions : Html msg
        selectedOptions =
            p []
                [ text "Selected: "
                , options
                    |> List.filter (\x -> Set.member x.id selectedIds)
                    |> List.map .title
                    |> String.join ", "
                    |> text
                ]

        btn : Html Msg
        btn =
            if isOpen then
                button [ class "button is-rounded is-info", onClick CloseDropdown ] [ text "Compare" ]

            else
                button [ class "button is-rounded", onClick OpenDropdown ] [ text "Compare" ]

        dropdown : Html Msg
        dropdown =
            if isOpen then
                div [ class "dropdown-container" ]
                    [ div [ id domElementId, class "option-list box" ] <|
                        List.map (\x -> viewOption (Set.member x.id selectedIds) x) options
                    ]

            else
                emptyHtml
    in
    section [ class "section box" ]
        [ h2 [ class "subtitle" ] [ text selectorTitle ]
        , selectedOptions
        , btn
        , dropdown
        ]


viewOption : Bool -> Option -> Html Msg
viewOption isSelected option =
    div [] [ label [] [ input [ type_ "checkbox", checked isSelected, onClick (ToggleOption option) ] [], text option.title ] ]
