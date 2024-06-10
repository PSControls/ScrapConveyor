

REM Define variables
set CONTAINER_NAME=nr-ScrapConveyor-container
set PROJECT_NAME=ScrapConveyor
set DEST_DIR=%HOMEPATH%\nr-projects\ScrapConveyor
set DOCKERFILE_URL=https://raw.githubusercontent.com/PSControls/ScrapConveyor/main/Dockerfile

REM Create the destination directory if it doesn't exist
if not exist "%DEST_DIR%" (
    mkdir "%DEST_DIR%"
)

REM Change to the destination directory
cd /d "%DEST_DIR%"

REM Download the Dockerfile
powershell -Command "Invoke-WebRequest -Uri %DOCKERFILE_URL% -OutFile \"%DEST_DIR%\Dockerfile\""

REM Verify the download
if exist "%DEST_DIR%\Dockerfile" (
    echo Dockerfile has been successfully downloaded to %DEST_DIR%
) else (
    echo Failed to download Dockerfile
    pause
)

REM Build the Docker image
docker build --no-cache -t node-red-project .

REM Check if the image was built successfully
if errorlevel 1 (
    echo Docker build failed
   pause
)

REM Check if a container with the same name already exists
for /f "tokens=* usebackq" %%i in (`docker ps -a -q -f "name=%CONTAINER_NAME%"`) do set EXISTING_CONTAINER=%%i

if not "%EXISTING_CONTAINER%"=="" (
    echo A container with the name %CONTAINER_NAME% already exists. Removing it...
    docker rm -f %CONTAINER_NAME%

    REM Check if the container was removed successfully
    if errorlevel 1 (
        echo Failed to remove existing container
        pause
    )
)

REM Run the Docker container
docker run --name %CONTAINER_NAME% -p 1880:1880 -d node-red-project


