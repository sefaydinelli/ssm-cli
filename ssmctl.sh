#!/bin/bash
# AWS SSM Session Connector

if [ -z $1 ] && [ -z $2 ]
then
    echo "AWS SSM Session Connector"
    read -p "Enter the region [eu-central-1] : " aws_region
    aws_region=${aws_region:-eu-central-1}
    aws ec2 describe-instances --region $aws_region --query 'Reservations[].Instances[].[Tags[?Key==`Name`]| [0].Value,InstanceId,State.Name]' --output table | sort -n
    echo "+----------------------------------+-----------------------+----------+"
    read -p "Copy the ID of the instance : " instance_id
    echo "Connecting to $instance_id on $aws_region with SSM...";
    aws ssm start-session --region $aws_region --target $instance_id
elif [ $1 == 'help' ] && [ -z $2 ]
then
    echo "Help section. WIP"
elif [ $1 == '-r' ] && [ -z $2 ]
then
    echo "AWS SSM Session Connector"
    read -p "Enter the region [eu-central-1] : " aws_region
    aws_region=${aws_region:-eu-central-1}
    aws ec2 describe-instances --region $aws_region --query 'Reservations[].Instances[].[Tags[?Key==`Name`]| [0].Value,InstanceId,State.Name]' --output table | sort -n
    echo "+----------------------------------+-----------------------+----------+"
    read -p "Copy the ID of the instance : " instance_id
    echo "Connecting to $instance_id on $aws_region with SSM...";
    aws ssm start-session --region $aws_region --target $instance_id
elif [ $1 == '-r' ] && [ -n $2 ]
then
    echo "AWS SSM Session Connector"
    read -p "Enter the region [eu-central-1] : " aws_region
    aws_region=${aws_region:-eu-central-1}
    echo "Connecting to $2 on $aws_region with SSM";
    aws ssm start-session --region $aws_region --target $2
elif [ $1 != '-r' ] && [ -n $1 ] && [ -z $2 ]
then
    echo "AWS SSM Session Connector"
    echo "Connecting to $1 with SSM";
    aws ssm start-session --target $1
else
    echo "Wrong selection. Please see the help section using 'ssmctl help' .."
    exit 1
fi
