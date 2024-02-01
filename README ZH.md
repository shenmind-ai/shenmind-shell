## Shenmind Api 的 Shell 脚本


### 简介
这个项目是一个用于ShenMind AI API的命令行客户端，旨在帮助用户更轻松地与ShenMind API进行交互，探索和利用AI模型，并开发自己的应用程序。

### 使用样例

#### 1. 创建预测
```shell
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

```


#### 2. 查询预测结果


```shell
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

````

