module OptionSelector exposing (Model, Msg, Option, init, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Set exposing (Set)


type alias Config =
    { selectorId : String
    , selectorTitle : String
    , selectedIds : Set String
    , options : List Option
    }


type alias Model =
    { selectorId : String
    , selectorTitle : String
    , selectedIds : Set String
    , options : List Option
    , isOpen : Bool
    }


type alias Option =
    { id : String, title : String }


init : Config -> ( Model, Cmd msg )
init { selectorId, selectorTitle, selectedIds, options } =
    ( { selectorId = selectorId
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
view { selectorId, selectorTitle, selectedIds, options, isOpen } =
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
                span [ onClick CloseDropdown ] [ text "Compare" ]

            else
                span [ onClick OpenDropdown ] [ text "Compare" ]

        dropdown : Html Msg
        dropdown =
            if isOpen then
                div [ id selectorId ] <| List.map (\x -> viewOption (Set.member x.id selectedIds) x) options

            else
                emptyHtml
    in
    section [ class "section" ]
        [ h2 [ class "subtitle" ] [ text selectorTitle ]
        , selectedOptions
        , btn
        , dropdown
        ]


viewOption : Bool -> Option -> Html Msg
viewOption isSelected option =
    div [] [ label [] [ input [ type_ "checkbox", checked isSelected, onClick (ToggleOption option) ] [], text option.title ] ]
