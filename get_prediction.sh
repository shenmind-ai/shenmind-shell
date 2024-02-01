#!/bin/bash
SHENMIND_API_TOKEN="xxxxxxxxxxxxxxxxxxxxx"
predictionId="-k6jDE2uhkb4aaPMIjvwTw=="

queryPredictionUrl="https://mmdatong.com/api/protected/prediction/queryPrediction"
getPredictionOutput() {
  predictionId=$1
  apiToken=$2
  url="${queryPredictionUrl}?predictionId=${predictionId}"

  response=$(curl -s -X GET "$url" \
    -H "Authorization: $apiToken")

  prediction=$(echo "$response" | jq -r '.data')
  if [ $? -eq 0 ] && [ "$prediction" != "null" ]; then
    echo "$prediction"
  else
    echo "Fail to get prediction: $response" >&2
    exit 1
  fi
}

while true; do
    echo $predictionId
    prediction=$(getPredictionOutput "$predictionId" "$SHENMIND_API_TOKEN")
    echo $prediction

    status=$(echo "$prediction" | jq -r '.status')
    if [ "$status" = "succeeded" ]; then
        echo "$prediction"
        break
    else
        sleep 1
    fi
done
