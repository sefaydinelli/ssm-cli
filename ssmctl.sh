#!/bin/bash
# AWS SSM Session Connector

if [ -z $1 ]
then
    echo "AWS SSM Session Connector"
    read -p "Enter the region [eu-central-1] : " aws_region
    aws_region=${aws_region:-eu-central-1}
    aws ec2 describe-instances --region $aws_region --query 'Reservations[].Instances[].[Tags[?Key==`Name`]| [0].Value,InstanceId,State.Name]' --output table | sort -n
    echo "+----------------------------------+-----------------------+----------+"
    read -p "Copy the ID of the instance : " instance_id
    echo "Connecting to $instance_id on $aws_region with SSM...";
    aws ssm start-session --region $aws_region --target $instance_id
elif [ $1 == 'help' ]
then
    echo "Help section. WIP"
else
    echo "AWS SSM Session Connector"
    read -p "Enter the region [eu-central-1] : " aws_region
    aws_region=${aws_region:-eu-central-1}
    echo "Connecting to $1 on $aws_region with SSM";
    aws ssm start-session --region $aws_region --target $1
fi
