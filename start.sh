#!/usr/bin/env bash

api_key="APITT5TaPCDdfsr"
api_secret="WyGjhbNnUdu1fxCRxMoEbhSeVboIMzc6OPnRsmq78UG"
room_name="test_room"
identity="test_participant"

poetry update
docker-compose up -d

token=$(livekit-cli create-token --api-key APITT5TaPCDdfsr --api-secret WyGjhbNnUdu1fxCRxMoEbhSeVboIMzc6OPnRsmq78UG --join --room "$room_name" --identity "$identity" --valid-for 24h | tail -n 1 | cut -w -f3)
python3 -m webbrowser "https://meet.livekit.io/?url=ws%3A%2F%2Flocalhost%3A7880&token=11#/room?url=ws%3A%2F%2Flocalhost%3A7880&token=$token&audioEnabled=true"

sleep 3

track_id=$(livekit-cli get-participant --url http://127.0.0.1:7880 --api-key "$api_key" --api-secret "$api_secret" --room "$room_name" --identity "$identity" | jq -r '.tracks[0].sid')
echo "Track id: $track_id"

######## Track Egress - WebSocket ########
echo "{\"room_name\": \"$room_name\", \"track_id\": \"$track_id\", \"websocket_url\": \"ws://ingest:8000/ws\" }" > request.json

livekit-cli start-track-egress --url http://127.0.0.1:7880 --api-key "$api_key" --api-secret "$api_secret" --request request.json
docker-compose logs -f livekit
trap "docker-compose down" EXIT

go run main.go --host=http://127.0.0.1:7880 --api-key=APITT5TaPCDdfsr --api-secret=WyGjhbNnUdu1fxCRxMoEbhSeVboIMzc6OPnRsmq78UG --room-name=test_room --identity=admin-test
