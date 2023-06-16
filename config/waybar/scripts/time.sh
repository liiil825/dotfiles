#!/usr/bin/env sh

weekday=$(date +%w)
case "$weekday" in
1)
  weekday="星期一"
  ;;
2)
  weekday="星期二"
  ;;
3)
  weekday="星期三"
  ;;
4)
  weekday="星期四"
  ;;
5)
  weekday="星期五"
  ;;
6)
  weekday="星期六"
  ;;
*)
  weekday="星期日"
  ;;
esac

echo "$(date '+%H:%M') $weekday"
