module Basic exposing (..)

import AlertTimerMessage exposing (Msg)
import Html exposing (..)
import Html.Events exposing (..)


type Msg
    = AlertTimer AlertTimerMessage.Msg
    | AddNewMessage Float


type alias Model =
    { alert_messages : AlertTimerMessage.Model }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick <| AddNewMessage 5 ] [ text "5 s" ]
        , button [ onClick <| AddNewMessage 2 ] [ text "2 s" ]
        , Html.map AlertTimer (AlertTimerMessage.view model.alert_messages)
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AlertTimer msg ->
            let
                ( updateModal, subCmd ) =
                    AlertTimerMessage.update msg model.alert_messages
            in
                { model | alert_messages = updateModal } ! [ Cmd.map AlertTimer subCmd ]

        AddNewMessage time ->
            let
                newMsg =
                    AlertTimerMessage.AddNewMessage time <| div [] [ text "MSG Teste" ]

                ( updateModal, subCmd ) =
                    AlertTimerMessage.update newMsg model.alert_messages
            in
                { model | alert_messages = updateModal } ! [ Cmd.map AlertTimer subCmd ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


initial : Model
initial =
    Model AlertTimerMessage.modelInit


main : Program Never Model Msg
main =
    program
        { init = ( initial, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
