@echo off

:: Set environmental variable for project directory
set "PROJECT_DIR=%USERPROFILE%\nr-projects"

:: Create the directory
if not exist "%PROJECT_DIR%" (
	echo Creating project directory
	mkdir "%PROJECT_DIR%"
)

cd "%PROJECT_DIR%"

git clone https://github.com/PSControls/ScrapConveyor.git

:: Confirm completion
echo Github repo has been cloned to %PROJECT_DIR%

:: build Docker image
echo Docker image is being built.

@echo on

docker build --no-cache -t nr-scrap-conveyor .

::error check for successful build
if errorlevel 1 (
	echo Docker image failed to build.
	pause	
	exit /b 1
)
else echo Docker image built successfully. 

@echo off

::check if a container with the same name already exists
for /f "tokens=* usebackq" %%i in (`docker ps -a -q -f "name=%CONTAINER_NAME%"`) do set EXISTING_CONTAINER=%%i

if not "%EXISTING_CONTAINER%"=="" (
    echo A container with the name %CONTAINER_NAME% already exists. Removing it...
    docker rm -f %CONTAINER_NAME%

    ::check if the container was removed successfully
    if errorlevel 1 (
        echo Failed to remove existing container
        pause
        exit /b 1
    )
)

::run the Docker container
docker run --name %CONTAINER_NAME% -p 1880:1880 -d node-red-project

echo A docker container is up and running the NODE-RED project '%PROJECT_NAME%' on port 1880.
pause