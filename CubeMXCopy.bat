@echo off
REM This is a script for automatic copy project in MXcube IDE

setlocal

REM Change the directory to the specified folder
REM cd "path to workspace directory"

REM store arguments in the variables
REM quotation marks prevent and handling spaces in direcotry names
set "old_project_name=%~1"
set "new_project_name=%~2"

if exist "%new_project_name%" (

    echo Project name already exist.
    echo Change name and try again.
    exit /b
)

REM check if first argument "project directory you want to copy" exist
if exist "%old_project_name%" (

    echo Project directory found: "%old_project_name%"
    
REM redirects output from xcopy command to >NUL, suppress output    
    xcopy /E /I "%old_project_name%" "%old_project_name%_copy" >NUL
    echo Project copied
    
REM rename project and go inside
    ren "%old_project_name%_copy" "%new_project_name%"
    echo Copied project renamed.
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
    
) else (
    echo Project not found.
)

endlocal