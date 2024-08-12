Import-Module AWS.Tools.S3

$region = "us-east-1"

$bucketName = Read-Host -Prompt 'Enter the s3 bucket name'

Write-Host "AWS regiont: $region"
Write-Host "S3 bucket: $bucketName"

New-S3Bucket -BucketName $bucketName -Region $region
function BucketExist {
    $bucket = getS3Bucket -bucketName $bucketName -ErrorAction silentlyContinue
    return $null -ne $bucket
}

if(-not(BucketExist)){
    Write-Host " Bicket does not exsit..."
    New-S3Bucket -bucketName $bucketName -Region $region
}else {
    "bucket already exist..."
}
# Create a new file 
$fileName = 'myfile.txt'
$fileContent = 'Hello world'
Set-Content -Path $fileName -value $fileContent 

write-S3object -BucketName $bucketName -File $fileName -key fileName