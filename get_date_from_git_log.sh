#!/bin/bash

month_selected=$1
year_selected=$2

reporoot=`pwd`
cd ${reporoot}
last_commit_date=`git log | head -n 3 | grep "^Date:"`
echo "$last_commit_date"
last_commit_year=`echo ${last_commit_date} | tr -s ' ' | cut -d ' ' -f 6`
last_commit_month=`echo ${last_commit_date} | tr -s ' ' | cut -d ' ' -f 3`
echo "$last_commit_year"
echo "$last_commit_month"

convert_month()
{
case $1 in
  Jan) month_num=01 ;;
  Feb) month_num=02 ;;
  Mar) month_num=03 ;;
  Apr) month_num=04 ;;
  May) month_num=05 ;;
  Jun|June) month_num=06 ;;
  Jul) month_num=07 ;;
  Aug) month_num=08 ;;
  Sep) month_num=09 ;;
  Oct) month_num=10 ;;
  Nov) month_num=11 ;;
  Dec) month_num=12 ;;
esac

echo $month_num
}

convert_month ${last_commit_month}
year_n_month=${last_commit_year}${month_num}

echo "${year_n_month}"

convert_month ${month_selected}
selected_year_n_month=${year_selected}${month_num}
echo "${selected_year_n_month}"

if [[ "${selected_year_n_month}" -le "${year_n_month}" ]]; then
	echo "Branch is older"
	
fi
