#!/bin/bash


$CONTAINER_NAME="nr-ScrapConveyor-container"
$PROJECT_NAME="ScrapConveyor"
$DEST_DIR="$env:HOMEPATH\nr-projects\ScrapConveyor"
$DOCKERFILE_URL="https://raw.githubusercontent.com/PSControls/ScrapConveyor/main/Dockerfile"

# Create the destination directory if it doesn't exist
if (-not (Test-Path $DEST_DIR)) {
    New-Item -ItemType Directory -Path $DEST_DIR
}

# Change to the destination directory
Set-Location -Path $destDir


# Download the Dockerfile
Invoke-WebRequest -Uri $DOCKERFILE_URL -OutFile "$DEST_DIR\Dockerfile"

# Verify the download
if (Test-Path "$DEST_DIR\Dockerfile") {
    Write-Output "Dockerfile has been successfully downloaded to $DEST_DIR"
} else {
    Write-Error "Failed to download Dockerfile"
    exit 1
}


# Build the Docker image
docker build --no-cache -t node-red-project .


# Check if the image was built successfully
if ($LASTEXITCODE -ne 0) {
    Write-Error "Docker build failed"
    exit 1
}


# Check if a container with the same name already exists
$existingContainer = docker ps -a -q -f "name=$containerName"

if ($existingContainer) {
    Write-Output "A container with the name $containerName already exists. Removing it..."
    docker rm -f $existingContainer

    # Check if the container was removed successfully
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to remove existing container"
        exit 1
    }
}


# Run the Docker container
docker run --name $CONTAINER_NAME -p 1880:1880 -d node-red-project
