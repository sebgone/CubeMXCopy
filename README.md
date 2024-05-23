# CubeMxCopy

# Technology:
* Batch script
* Command Line Window

# Specification:

CubeMxCopy is a windows batch script which allows to simply <br>
copy entire project created in CubeMX IDE. 

# Functionality:
* Take as arg_1 name of a project you want to copy
* Take as arg_2 new name of a new project
* Steps print out in console
* Basic validation and error handling

# Steps:
1. Copy script to your CubeMX workspace directory.
2. Open cmd in that workspace directory.
3. Run the script with two arguments: "name of existing project" "name of new project". <br>
```bash
CubeMXCopy.bat "example project" "new project"
```
4. Import new project directory by CubeMX IDE.
5. Continue working on your new instance of a project.
