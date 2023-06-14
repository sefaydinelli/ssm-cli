#!/bin/bash
# AWS SSM Session Connector

function list_instances {
    aws ec2 describe-instances --region "$1" --filters Name=instance-state-name,Values=running --query 'Reservations[*].Instances[*].[Tags[?Key==`Name`]| [0].Value,InstanceId,PrivateIpAddress,PublicIpAddress]' --output table | sort -n
    echo "+------------------------------------------+----------------------+----------------+------------------+"
}

function connect_instance {
    if [[ ${1:0:1} == 'i' ]] && [[ ${1:1:1} == '-' ]]; then
        echo "Connecting to $1 on $2 with SSM...";
        aws ssm start-session --region "$2" --target "$1"
    else
        echo "$1 is not an instance ID."
    fi
}

echo "AWS SSM Session Connector"
echo ""

# list instances with default region
if [[ -z $1 ]]; then
    list_instances
    read -p "Copy the ID of the instance : " instance_id
    connect_instance "$instance_id"
# help section
elif [[ $1 == 'help' ]]; then
    echo "ssm                  :  List all instances in default region. "
    echo "ssm <instance_id>    :  Connect to instance with instance ID on default region."
    echo "ssm -r <region>      :  Select region and list all instances on that region."
    echo "ssm -r <region> <instance_id> :  Select region and connect to instance with instance ID on selected region."
# select region and list instances
elif [[ $1 == '-r' ]] && [[ -z $3 ]]; then
    list_instances "$2"
    read -p "Copy the ID of the instance : " instance_id
    connect_instance "$instance_id" "$2"
# select region and connect to instance
elif [[ $1 == '-r' ]] && [[ -n $3 ]]; then
    connect_instance "$3" "$2"
# connect instance with default region
elif [[ -n $1 ]]; then
    connect_instance "$1"
# wrong command execution
else
    echo "Wrong command execution. Please see the help section using 'ssm help' .."
    exit 1
fi
