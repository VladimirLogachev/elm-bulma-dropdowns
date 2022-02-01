module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)


main : Html.Html msg
main =
    div [ class "column" ]
        [ section [ class "section" ]
            [ h2 [ class "subtitle" ] [ text "Overall" ]
            , span [] [ text "Compare" ]
            , p [] [ text "Selected: ", text <| String.join ", " dataOverall ]
            ]
        ]


dataOverall : List String
dataOverall =
    [ "Option 1"
    , "Option 2"
    , "Option 3"
    , "Option 4"
    , "Option 5"
    , "Option 6"
    , "Option 7"
    , "Option 8"
    , "Option 9"
    , "Option 10"
    ]


dataCategory1 : List String
dataCategory1 =
    [ "Option 1"
    , "Option 2"
    , "Option 3"
    , "Option 4"
    , "Option 5"
    , "Option 6"
    , "Option 7"
    , "Option 8"
    , "Option 9"
    ]


dataCategory2 : List String
dataCategory2 =
    [ "Option 1"
    , "Option 2"
    , "Option 3"
    , "Option 4"
    , "Option 5"
    , "Option 6"
    , "Option 7"
    , "Option 8"
    ]


dataCategory3 : List String
dataCategory3 =
    [ "Option 1"
    , "Option 2"
    , "Option 3"
    , "Option 4"
    , "Option 5"
    , "Option 6"
    , "Option 7"
    ]
