#!/bin/bash
SHENMIND_API_TOKEN="b518880c4762276bcf3041b309745929706989962a6b0bdda1a100a4e1ffa4cd"
predictionId="-k6jDE2uhkb4aaPMIjvwTw=="

cancelUrl="https://mmdatong.com/api/protected/prediction/cancelPrediction"


curl -X POST "$cancelUrl" \
    -H "Authorization: $SHENMIND_API_TOKEN" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "predictionId=$predictionId"
