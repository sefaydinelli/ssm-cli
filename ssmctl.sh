#!/bin/bash
# AWS SSM Session Connector

echo "AWS SSM Session Connector"
echo ""

# list instances with default region
if [[ -z $1 ]] && [[ -z $2 ]]
then
    aws ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==`Name`]| [0].Value,InstanceId,State.Name]' --output table | sort -n
    echo "+----------------------------------+-----------------------+----------+"
    read -p "Copy the ID of the instance : " instance_id
    if [[ ${instance_id:0:1} == 'i' ]] && [[ ${instance_id:1:1} == '-' ]]
    then
        echo "Connecting to $instance_id with SSM...";
        aws ssm start-session --target $instance_id
    else
        echo "$instance_id is not an instance ID."
    fi
# help section
elif [[ $1 == 'help' ]] && [[ -z $2 ]]
then
    echo "Help section. WIP"
# select region and list instances
elif [[ $1 == '-r' ]] && [[ -z $2 ]]
then
    read -p "Enter the region [eu-central-1] : " aws_region
    aws_region=${aws_region:-eu-central-1}
    aws ec2 describe-instances --region $aws_region --query 'Reservations[].Instances[].[Tags[?Key==`Name`]| [0].Value,InstanceId,State.Name]' --output table | sort -n
    echo "+----------------------------------+-----------------------+----------+"
    read -p "Copy the ID of the instance : " instance_id
    if [[ ${instance_id:0:1} == 'i' ]] && [[ ${instance_id:1:1} == '-' ]]
    then
        echo "Connecting to $instance_id on $aws_region with SSM...";
        aws ssm start-session --region $aws_region --target $instance_id
    else
        echo "$instance_id is not an instance ID."
    fi
# select region and connect to instance
elif [[ $1 == '-r' ]] && [[ -n $2 ]]
then
    if [[ ${2:0:1} == 'i' ]] && [[ ${2:1:1} == '-' ]]
    then
        read -p "Enter the region [eu-central-1] : " aws_region
        aws_region=${aws_region:-eu-central-1}
        echo "Connecting to $2 on $aws_region with SSM";
        aws ssm start-session --region $aws_region --target $2
    else
        echo "$2 is not an instance ID."
    fi
# connect instance with default region
elif [[ $1 != '-r' ]] && [[ -n $1 ]] && [[ -z $2 ]]
then
    if [[ ${1:0:1} == 'i' ]] && [[ ${1:1:1} == '-' ]]
    then
        echo "Connecting to $1 with SSM";
        aws ssm start-session --target $1
    else
        echo "$1 is not an instance ID."
    fi
# wrong command execution
else
    echo "Wrong command execution. Please see the help section using 'ssmctl help' .."
    exit 1
fi
