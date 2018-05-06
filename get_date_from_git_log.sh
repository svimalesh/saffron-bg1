#!/bin/bash

reporoot=`pwd`
cd ${reporoot}
last_commit_date=`git log | head -n 3 | grep "^Date:"`
echo "$last_commit_date"
last_commit_year=`echo ${last_commit_date} | tr -s ' ' | cut -d ' ' -f 6`
last_commit_month=`echo ${last_commit_date} | tr -s ' ' | cut -d ' ' -f 3`
echo "$last_commit_year"
echo "$last_commit_month"

case ${last_commit_month} in
  Jan) month_num=01 ;;
  Feb) month_num=02 ;;
  Mar) month_num=03 ;;
  Apr) month_num=04 ;;
  May) month_num=05 ;;
  Jun) month_num=06 ;;
  Jul) month_num=07 ;;
  Aug) month_num=08 ;;
  Sep) month_num=09 ;;
  Oct) month_num=10 ;;
  Nov) month_num=11 ;;
  Dec) month_num=12 ;;
esac

echo $month_num

year_n_month=${last_commit_year}${month_num}

echo "${year_n_month}"
