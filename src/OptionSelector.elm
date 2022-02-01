module OptionSelector exposing (Model, Msg, init, update, view)

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
    }


type alias Option =
    { id : String, title : String }


init : Config -> ( Model, Cmd msg )
init { selectorId, selectorTitle, selectedIds, options } =
    ( { selectorId = selectorId
      , selectorTitle = selectorTitle
      , selectedIds = selectedIds
      , options = options
      }
    , Cmd.none
    )


type Msg
    = ToggleOption Option
    | Other


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

        Other ->
            ( model, Cmd.none )


view : Model -> Html Msg
view { selectorId, selectorTitle, selectedIds, options } =
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
    in
    section [ class "section" ]
        [ h2 [ class "subtitle" ] [ text selectorTitle ]
        , selectedOptions
        , span [ id selectorId ] [ text "Compare" ]
        , div [] <| List.map (\x -> viewOption (Set.member x.id selectedIds) x) options
        ]


viewOption : Bool -> Option -> Html Msg
viewOption isSelected option =
    div [] [ label [] [ input [ type_ "checkbox", checked isSelected, onClick (ToggleOption option) ] [], text option.title ] ]
