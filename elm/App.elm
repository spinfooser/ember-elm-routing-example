module App exposing (..)

import Html exposing (Html, a, button, code, div, h1, li, text, ul)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http
import Navigation
import UrlParser as Url exposing (int, s, string, stringParam, top, (</>))


main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { history : List (Maybe Route)
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( Model [ Url.parseHash route location ]
    , Cmd.none
    )



-- URL PARSING


type Route
    = Home
    | RouteA String
    | RouteB Int


route : Url.Parser (Route -> a) a
route =
    Url.oneOf
        [ Url.map Home top
        , Url.map RouteA (s "routeA" </> string)
        , Url.map RouteB (s "routeB" </> int)
        ]



-- UPDATE


type Msg
    = NewUrl String
    | UrlChange Navigation.Location


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewUrl url ->
            ( model
            , Navigation.newUrl url
            )

        UrlChange location ->
            let
                log =
                    Debug.log "Router change detected by elm!" location
            in
                ( { model | history = Url.parseHash route location :: model.history }
                , Cmd.none
                )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Links" ]
        , ul [] (List.map viewLink [ "#", "#routeB/42", "#routeB/37", "#routeA/cats" ])
        , h1 [] [ text "History" ]
        , ul [] (List.map viewRoute model.history)
        ]


viewLink : String -> Html Msg
viewLink url =
    li [] [ button [ onClick (NewUrl url) ] [ text url ] ]


viewRoute : Maybe Route -> Html msg
viewRoute maybeRoute =
    case maybeRoute of
        Nothing ->
            li [] [ text "Invalid URL" ]

        Just route ->
            li [] [ code [] [ text (routeToString route) ] ]


routeToString : Route -> String
routeToString route =
    case route of
        Home ->
            "home"

        RouteA search ->
            "search for " ++ Http.encodeUri search

        RouteB id ->
            "routeA with id " ++ toString id
