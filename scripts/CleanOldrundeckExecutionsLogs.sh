#!/bin/bash

#Declare variables
rd_cli_path=/apps/rundeck/rundeck-master/cli/rd-1.1.7/bin
rd_url=http://shgfdev01:4440
rd_user=admin
rd_passwd=admin
rd_http_timeout=300
rd_project=$2
rd_job_name=$3
older_than_to_del=$1 # supported formats are days (<n>d), week (<n>w) and month (<n>m)
executions_to_keep=$4

export PATH=$PATH:${rd_cli_path}
export RD_URL=${rd_url} RD_USER=${rd_user} RD_PASSWORD=${rd_passwd} RD_HTTP_TIMEOUT=${rd_http_timeout}

total_executions=$(rd executions query -j ${rd_job_name} -p ${rd_project} --noninteractive --autopage | wc -l)
echo "Total executions : ${total_executions}"
echo "Executions to keep : ${executions_to_keep}"

older_executions=$(rd executions query --older ${older_than_to_del} -j ${rd_job_name} -p ${rd_project} --noninteractive --autopage | wc -l)
echo "older_executions : ${older_executions}"

eligible_to_delete=$((${total_executions}-${executions_to_keep}))

if [ ${older_executions} -gt ${eligible_to_delete} ]
then
  # Exclude the executions to keep from delete list
  executions_to_delete=${eligible_to_delete}
else
  executions_to_delete=${older_executions}
fi

echo "Executions to delete = ${executions_to_delete}"

if [ ${executions_to_delete} -le 0 ]
then
  echo "No executions to delete"
  exit
fi

# Bulk delete of more execution logs at a time may impact performance of rundeck
# Delete 200 executions at a time.

iterations=$((${executions_to_delete}/200))
for ((i=0;i<=${iterations};i++))
do
  echo "$i"
done
