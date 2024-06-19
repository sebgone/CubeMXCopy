@echo off
REM This is a script for automatic copy project in MXcube IDE
REM script takes 3 arguments: ex.:
REM CubeMxCopy.bat -r "old project name" "new renamed project"
REM CubeMxCopy.bat -c "old project name" "new copied project"

setlocal

REM Change the directory to the specified folder
REM cd "path to workspace directory"

REM store arguments in the variables
REM quotation marks prevent and handling spaces in direcotry names
set  arg=%~1
set "old_project_name=%~2"
set "new_project_name=%~3"

rem validate input arguments and project names
if not "%~1"=="-r" if not "%~1"=="-c" goto :error
if "%~2"=="" goto :error
if "%~3"=="" goto :error

if exist "%new_project_name%" (

    echo Project name already exist.
    echo Change name and try again.
    exit /b 1
)

if not exist "%old_project_name%" (
    echo Project not found.
    exit /b 1
)

REM if argumnents are ok copy or rename project

call :action %arg%
goto :eof  

REM action function definition 
:action
set arg_param=%~1

echo Project directory found: "%old_project_name%"

if "%arg_param%"=="-c" (

    REM redirects output from xcopy command to >NUL, suppress output    
    xcopy /E /I "%old_project_name%" "%new_project_name%" >NUL
    echo Project copied

) else if "%arg_param%"=="-r" (
    
    REM rename project and go inside
    ren "%old_project_name%" "%new_project_name%"
    echo project renamed.
)
    
cd "%new_project_name%"

REM if exist delete Debug directory
if exist "Debug" (
    rmdir /S /Q "Debug"
    echo Debug directory deleted.
) else (
    echo No Debug directory.
)

REM if exist delete launch configuration files
if exist "*.launch" (
    del "*.launch"
    echo launch file deleted.
) else (
    echo No launch files.
)
    
REM Rename .ioc project file
if exist "%old_project_name%.ioc" (
    ren "%old_project_name%.ioc" "%new_project_name%.ioc"
    echo .ioc file renamed.
    
) else (
    echo ioc file missing.
)
    
REM Replace old project names in .cproject and .project files
REM Finding and replacing string by powershell command
if exist ".cproject" (
    powershell -Command "(Get-Content '.cproject') -replace '%old_project_name%', '%new_project_name%' | Set-Content '.cproject'"
    echo .cproject changed.
) else (
    echo .cproject file is missing.
)
    
if exist ".project" (
    powershell -Command "(Get-Content '.project') -replace '%old_project_name%', '%new_project_name%' | Set-Content '.project'"
    echo .project changed.
) else (
    echo .project file is missing.
)
goto :eof


REM error function definition
:error 
echo Incorrect numbers or format of arguments:
echo Try use this: 
echo %0 -r "old project name" "new renamed project"
echo %0 -c "old project name" "new copied project"
exit /b 1

endlocal