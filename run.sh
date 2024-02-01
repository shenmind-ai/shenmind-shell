#!/bin/bash
SHENMIND_API_TOKEN="xxxxxxxxxxxxxxxxxxxxx"
uploadUrl="https://mmdatong.com/api/protected/storage/uploadFile"
createPredictionUrl="https://mmdatong.com/api/protected/prediction/createPrediction"

uploadFile() {
  key=$1
  filePath=$2
  apiToken=$3

  response=$(curl -s -X POST "$uploadUrl" \
    -H "Authorization: $apiToken" \
    -F "file=@$filePath" \
    -F "key=$key")

  storageId=$(echo "$response" | jq -r '.data[0]')

  if [ $? -eq 0 ] && [ "$storageId" != "null" ]; then
    echo "$storageId"
  else
    echo "Fail to upload file: $response" >&2
    exit 1
  fi
}

declare -A files=(
  ["image_path"]="test.png"
)
for key in "${!files[@]}"; do
  filePath="${files[$key]}"
  data[$key]=$(uploadFile "$key" "$filePath" "$SHENMIND_API_TOKEN")
done


curl -s -X POST "$createPredictionUrl" \
    -H "Authorization: $SHENMIND_API_TOKEN" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "modelId=yP1jM07UrYuQ6xHZ-lqYSQ==" \
    -d "prompt=the product is for sale" \
    -d "image_path=${data["image_path"]}" 
    


    




