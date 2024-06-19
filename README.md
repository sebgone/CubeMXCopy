# CubeMxCopy

# Technology:
* Batch script
* Command Line Window

# Specification:

CubeMxCopy is a windows batch script which allows to simply <br>
copy or rename entire project created in CubeMX IDE. 

# Functionality:
* Take as arg_1 command for copying or renaming
* Take as arg_2 name of a project you want to copy or rename
* Take as arg_3 new name of a new project
* Steps print out in console
* Basic validation and error handling

# Steps:
1. Copy script to your CubeMX workspace directory.
2. Open cmd in that workspace directory.
3. Run the script with three arguments: option "name of existing project" "name of new project". <br>
    option: -r rename <br>
    option: -c copy

```bash
CubeMXCopy.bat -r "example project" "new project"
```
or

```bash
CubeMXCopy.bat -c "example project" "new project"
```

4. Import new project directory by CubeMX IDE.
5. Continue working on your new instance of a project.
