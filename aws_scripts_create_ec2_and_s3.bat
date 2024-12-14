@echo off
echo Step 1: Configure AWS CLI
echo Configuring AWS CLI...
aws configure

echo Step 2: Verify Configuration
echo Verifying AWS CLI connection...
aws sts get-caller-identity

echo Step 3: Create an S3 Bucket
SET BUCKET_NAME=my-unique-bucket-name-009  
echo Creating S3 bucket: %BUCKET_NAME%
aws s3 mb s3://%BUCKET_NAME%

echo Step 4: List S3 Buckets
echo Listing S3 buckets...
aws s3 ls

echo Step 5: Create an EC2 Instance
SET AMI_ID=ami-053b12d3152c565i70cc7jhfkuf1  
SET INSTANCE_TYPE=t2.micro        
SET KEY_NAME=git-test-key         
SET SECURITY_GROUP=launch-wizard-1
echo Creating an EC2 instance...
FOR /F "tokens=*" %%i IN ('aws ec2 run-instances --image-id %AMI_ID% --instance-type %INSTANCE_TYPE% --key-name %KEY_NAME% --security-groups %SECURITY_GROUP% --query "Instances[0].InstanceId" --output text') DO SET INSTANCE_ID=%%i
echo EC2 Instance created with ID: %INSTANCE_ID%

echo Step 6: Start EC2 Instance (optional if not already running)
echo Starting EC2 instance...
aws ec2 start-instances --instance-ids %INSTANCE_ID%

echo Step 7: List IAM Users
echo Listing IAM users...
aws iam list-users

echo Step 8: List Lambda Functions
echo Listing Lambda functions...
aws lambda list-functions

echo Step 9: List EC2 Instances
echo Listing Lambda functions...
aws ec2 describe-instances

echo Script execution completed.
pause
