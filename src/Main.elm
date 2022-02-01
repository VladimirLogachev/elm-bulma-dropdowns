module Main exposing (main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import OptionSelector
import Set


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


type alias Model =
    { selectorOverall : OptionSelector.Model
    , selectorCategory1 : OptionSelector.Model
    , selectorCategory2 : OptionSelector.Model
    , selectorCategory3 : OptionSelector.Model
    }


type alias Option =
    { id : String, title : String }


init : () -> ( Model, Cmd msg )
init _ =
    let
        ( selectorOverall, cmdOverall ) =
            OptionSelector.init
                { selectorId = "selector-id-0"
                , selectorTitle = "Overall"
                , selectedIds = Set.empty
                , options = dataOverall
                }

        ( selectorCategory1, cmdCategory1 ) =
            OptionSelector.init
                { selectorId = "selector-id-1"
                , selectorTitle = "Category 1"
                , selectedIds = Set.empty
                , options = dataCategory1
                }

        ( selectorCategory2, cmdCategory2 ) =
            OptionSelector.init
                { selectorId = "selector-id-2"
                , selectorTitle = "Category 2"
                , selectedIds = Set.empty
                , options = dataCategory2
                }

        ( selectorCategory3, cmdCategory3 ) =
            OptionSelector.init
                { selectorId = "selector-id-3"
                , selectorTitle = "Category 3"
                , selectedIds = Set.empty
                , options = dataCategory3
                }
    in
    ( { selectorOverall = selectorOverall
      , selectorCategory1 = selectorCategory1
      , selectorCategory2 = selectorCategory2
      , selectorCategory3 = selectorCategory3
      }
    , Cmd.batch
        [ cmdOverall
        , cmdCategory1
        , cmdCategory2
        , cmdCategory3
        ]
    )


type Msg
    = SelectorOverallMsg OptionSelector.Msg
    | SelectorCategory1Msg OptionSelector.Msg
    | SelectorCategory2Msg OptionSelector.Msg
    | SelectorCategory3Msg OptionSelector.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectorOverallMsg subMsg ->
            let
                ( subModel, subCmd ) =
                    OptionSelector.update subMsg model.selectorOverall
            in
            ( { model | selectorOverall = subModel }, Cmd.map SelectorOverallMsg subCmd )

        SelectorCategory1Msg subMsg ->
            let
                ( subModel, subCmd ) =
                    OptionSelector.update subMsg model.selectorCategory1
            in
            ( { model | selectorCategory1 = subModel }, Cmd.map SelectorCategory1Msg subCmd )

        SelectorCategory2Msg subMsg ->
            let
                ( subModel, subCmd ) =
                    OptionSelector.update subMsg model.selectorCategory2
            in
            ( { model | selectorCategory2 = subModel }, Cmd.map SelectorCategory2Msg subCmd )

        SelectorCategory3Msg subMsg ->
            let
                ( subModel, subCmd ) =
                    OptionSelector.update subMsg model.selectorCategory3
            in
            ( { model | selectorCategory3 = subModel }, Cmd.map SelectorCategory3Msg subCmd )


view : Model -> Html.Html Msg
view model =
    div [ class "container" ]
        [ Html.map SelectorOverallMsg <| OptionSelector.view model.selectorOverall
        , Html.map SelectorCategory1Msg <| OptionSelector.view model.selectorCategory1
        , Html.map SelectorCategory2Msg <| OptionSelector.view model.selectorCategory2
        , Html.map SelectorCategory3Msg <| OptionSelector.view model.selectorCategory3
        ]



-- DATA


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
