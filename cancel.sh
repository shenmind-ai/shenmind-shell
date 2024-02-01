#!/bin/bash
SHENMIND_API_TOKEN="xxxxxxxxxxxxxxxxxxxxx"
predictionId="S6gDFnzwHiZvLEdyMBE6Qw=="

cancelUrl="https://mmdatong.com/api/protected/prediction/cancelPrediction"


curl -X POST "$cancelUrl" \
    -H "Authorization: $SHENMIND_API_TOKEN" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "predictionId=$predictionId"
