module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Set exposing (Set)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


type alias Model =
    { selectedIds : Set String }


type alias Option =
    { id : String, title : String }


init : () -> ( Model, Cmd msg )
init _ =
    ( { selectedIds = Set.singleton "2" }, Cmd.none )


type Msg
    = Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html.Html msg
view model =
    div [ class "column" ]
        [ viewOptionSelector "selector-id-1" "Overall" model.selectedIds dataOverall
        , viewOptionSelector "selector-id-2" "Category 1" model.selectedIds dataCategory1
        , viewOptionSelector "selector-id-3" "Category 2" model.selectedIds dataCategory2
        , viewOptionSelector "selector-id-4" "Category 3" model.selectedIds dataCategory3
        ]


viewOptionSelector : String -> String -> Set String -> List Option -> Html msg
viewOptionSelector selectorId selectorTitle selectedIds options =
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
        , span [ id selectorId ] [ text "Compare" ]
        , selectedOptions
        ]


dataOverall : List Option
dataOverall =
    [ { id = "1", title = "Option 1" }
    , { id = "2", title = "Option 2" }
    , { id = "3", title = "Option 3" }
    , { id = "4", title = "Option 4" }
    , { id = "5", title = "Option 5" }
    , { id = "6", title = "Option 6" }
    , { id = "7", title = "Option 7" }
    , { id = "8", title = "Option 8" }
    , { id = "9", title = "Option 9" }
    , { id = "10", title = "Option 10" }
    ]


dataCategory1 : List Option
dataCategory1 =
    [ { id = "1", title = "Option 1" }
    , { id = "2", title = "Option 2" }
    , { id = "3", title = "Option 3" }
    , { id = "4", title = "Option 4" }
    , { id = "5", title = "Option 5" }
    , { id = "6", title = "Option 6" }
    , { id = "7", title = "Option 7" }
    , { id = "8", title = "Option 8" }
    , { id = "9", title = "Option 9" }
    ]


dataCategory2 : List Option
dataCategory2 =
    [ { id = "1", title = "Option 1" }
    , { id = "2", title = "Option 2" }
    , { id = "3", title = "Option 3" }
    , { id = "4", title = "Option 4" }
    , { id = "5", title = "Option 5" }
    , { id = "6", title = "Option 6" }
    , { id = "7", title = "Option 7" }
    , { id = "8", title = "Option 8" }
    ]


dataCategory3 : List Option
dataCategory3 =
    [ { id = "1", title = "Option 1" }
    , { id = "2", title = "Option 2" }
    , { id = "3", title = "Option 3" }
    , { id = "4", title = "Option 4" }
    , { id = "5", title = "Option 5" }
    , { id = "6", title = "Option 6" }
    , { id = "7", title = "Option 7" }
    ]
