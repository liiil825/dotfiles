#!/bin/bash

PUBLIC_KEY="PA0IIgu3utmogBria"
LOCATION=$1
TS=$(date +%s)
PARMS="location=$LOCATION&public_key=$PUBLIC_KEY&ts=$TS&ttl=300"
sign=$(echo -n "$PARMS" | openssl dgst -sha1 -hmac "$SENIVERSE_PRIVATE_KEY" -binary | openssl base64)
echo "sign=$sign"

API_URL="https://api.seniverse.com/v3/weather/now.json"

data=$(curl "$API_URL?$PARMS&sig=$sign")
# data='{"results":[{"location":{"id":"WT3Q0FW9ZJ3Q","name":"武汉","country":"CN","path":"武汉,武汉,湖北,中国","timezone":"Asia/Shanghai","timezone_offset":"+08:00"},"now":{"text":"多云","code":"4","temperature":"27"},"last_update":"2023-06-08T19:50:15+08:00"}]}'
echo "$data" | jq
# echo "$data" | jq -r '.results[0]'
# echo "$data" | jq -r '.results[0].now.code'
echo "$data" | jq -r '.results[0].now.temperature'

# code=$(echo "$data" | jq -r "resules['']")
# temperature=$(echo "$data" | jq | grep -E "\"temperature\"" | awk '{ print $2 }' | sd '"(.*)",{0,1}' '$1')
# "℃"
# 0 晴（国内城市白天晴） Sunny
# 1 晴（国内城市夜晚晴） Clear
# 2 晴（国外城市白天晴） Fair
# 3 晴（国外城市夜晚晴） Fair
# 4 多云 Cloudy
# 5 晴间多云 Partly Cloudy
# 6 晴间多云 Partly Cloudy
# 7 大部多云 Mostly Cloudy
# 8 大部多云 Mostly Cloudy
# 9 阴 Overcast
# 10 阵雨 Shower
# 11 雷阵雨 Thundershower
# 12 雷阵雨伴有冰雹 Thundershower with Hail
# 13 小雨 Light Rain
# 14 中雨 Moderate Rain
# 15 大雨 Heavy Rain
# 16 暴雨 Storm
# 17 大暴雨 Heavy Storm
# 18 特大暴雨 Severe Storm
# 19 冻雨 Ice Rain
# 20 雨夹雪 Sleet
# 21 阵雪 Snow Flurry
# 22 小雪 Light Snow
# 23 中雪 Moderate Snow
# 24 大雪 Heavy Snow
# 25 暴雪 Snowstorm
# 26 浮尘 Dust
# 27 扬沙 Sand
# 28 沙尘暴 Duststorm
# 29 强沙尘暴 Sandstorm
# 30 雾 Foggy
# 31 霾 Haze
# 32 风 Windy
# 33 大风 Blustery
# 34 飓风 Hurricane
# 35 热带风暴 Tropical Storm
# 36 龙卷风 Tornado
# 37 冷 Cold
# 38 热 Hot
# case "$code" in
# 1)
#   echo 1
#   ;;
# 2 | 3)
#   echo 2 or 3
#   ;;
# *)
#   echo default
#   ;;
# esac

# echo "code = $code"
# echo "temperature = $temperature"
