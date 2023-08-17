# CS 3030 Flex Bash Programming Assignment 2

## Purpose and Skills

In this assignment, we will practice working with your development environment as well as put in to practice the skills we learned this module. This lab will help you practice the following skills that are essential to navigate a Linux system and basic Bash concepts.

- Utilize wildcard expansion in Bash to match and manipulate files and directories efficiently.
- Understand and apply files and folder permissions, including, read, write, and execute permissions for users, groups, and others.
- Define and utilize functions in scripts to encapsulate reusable code and improve script modularity. 
- Perform file manipulation operations, such as renaming, copying, moving, and deleting files and directories
- Command line arguments effectively.

This lab will also help you to become familiar with the following important content knowledge in CS:

- Working in a Linux system
- Review basic programming concepts
- Use Source Version Control (SVC) such as `git` ahd `GitHub`

## Task 1: Creating a Backup Script

As the new intern in the `WSU IT Department`, you have been assigned the task of creating a script to backup specific files. These files are located in the `data` folder and follow a naming convention: `data_NN.EXT`, where `NN` represents a numeric value, and `EXT` indicates the file extension. Your script will allow users to filter these files based on their preferences and create backup copies of the selected files in a `log` folder.


### Step 1: Defining the Help Function**

Your first task involves informing users about the functionality of the script. To achieve this, you need to define a `help()` function that provides a clear usage message. This message will outline how the script should be utilized and highlight the available command-line options. Additionally, it will offer a sample usage command to illustrate the correct syntax for running the script. This usage message serves as a reference for users to understand how to provide inputs and arguments when executing the script.

**Instructions:**

1. Open your preferred text editor or integrated development environment (IDE).
2. Create a new Bash script file named `ca.sh`.
3. Define a `help()` function within the script to display usage instructions.
4. Save the script and give it executable permissions using `chmod +x ca.sh`.

**Sample Usage:**

```bash
 ./ca.sh --help
Usage: ca.sh [-l NUM] [-u NUM] [-e EXT]
You need to provide a range of file numbers and an extension
Sample usage: ./ca.sh -l 10 -u 15 -e csv                                                              
```

By defining the `help()` function with a comprehensive usage message, you will enable users to understand the script's purpose, command-line options, and how to correctly run the script. This will contribute to a smoother experience for users interacting with your backup script.


 ## Task 2: Defining User Options Using `getopts`

Your next task is to define user options using the `getopts` command. These options will allow users to filter the file names that need to be processed. Your script should provide support for three distinct options: one for the lower file number, one for the higher file number, and one for the file extension. The combination of the lower and higher numbers will create a range that filters the files.

**Instructions:**

1. Open your existing `ca.sh` file in your preferred text editor or integrated development environment (IDE).
2. Modify the script to incorporate the use of `getopts` for processing command-line options.
    - `-l` option that indicates the lower bound number (requires an argument)
    - `-u` option that indicates the upper bound number (requires an argument)
    - `-e` option that indicates the file extension (requires an argument) 
    - Note: You script should check for invalid options, as well as for valid options

3. Save the script.

**Sample Usage:**

```bash
# No options
./ca.sh
Usage: ca.sh [-l NUM] [-u NUM] [-e EXT]
You need to provide a range of file numbers and an extension
Sample usage: ./ca.sh -l 10 -u 15 -e csv
```

```bash
# Some options, but not all
./ca.sh -l 15 -e
Option l: Lower bound (15)
Invalid Option
Usage: ca.sh [-l NUM] [-u NUM] [-e EXT]
You need to provide a range of file numbers and an extension
Sample usage: ./ca.sh -l 10 -u 15 -e csv
```

```bash
# Invalid option
./ca.sh -l 15 -u 30 -t csv
Option l: Lower bound (15)
Option u: Upper bound (30)
Invalid Option
Usage: ca.sh [-l NUM] [-u NUM] [-e EXT]
You need to provide a range of file numbers and an extension
Sample usage: ./ca.sh -l 10 -u 15 -e csv
```

```bash
# All good options
 ./ca.sh -l 15 -u 30 -e csv
Option l: Lower bound (15)
Option u: Upper bound (30)
Option e: File extension (csv)
Done
```

By incorporating `getopts` to handle command-line options, your script will allow users to specify the lower bound, upper bound, and file extension to effectively filter the files to be processed. The script will also handle invalid options and missing arguments, ensuring a more user-friendly experience.

## Task 3: Defining Logging Folder Structure

In this task, you will define the logging folder structure for your backup files. For instance, if the script is executed on `08/17/2023`, the logging folder structure should be organized as follows:

```bash
log
└── 2023
    └── 08
        └── 17
```

To achieve this, you will create a function named `checking_log_folder()` that assesses whether the required folder structure exists in the current working directory. If the structure is not present, the function will create the `log` folder along with the appropriate subfolders based on the date.

**Instructions:**

1. Open your existing `ca.sh` file in your preferred text editor or integrated development environment (IDE).
2. Add the `checking_log_folder()`  function to the script to define the logging folder structure. Add some logging along the way. 

3. Save the script.

**Sample Usage:**

When you execute your script, the `checking_log_folder()` function will ensure that the required logging folder structure exists in the current working directory. If the structure is absent, the function will create the necessary `log` folder along with the corresponding subfolders for the current date.

```bash
./ca.sh -l 15 -u 30 -e csv
Option l: Lower bound (15)
Option u: Upper bound (30)
Option e: File extension (csv)
Checking log/2023/08/17 structure
Missing folder. Creating one
Done
```

## Task 4: Define the Filter Function

In this task, you will define the `filter_files()` function. This function will be responsible for selecting specific files from the `data` folder based on the provided input conditions. Additionally, the function will create backup copies of the selected files within the established logging folder structure.

**Instructions:**

1. Open your existing `ca.sh` file in your preferred text editor or integrated development environment (IDE).
2. Add the following function to the script to define the `filter_files()` function:
3. Save the script.

**Sample Usage:**

Once you execute your script and invoke the `filter_files()` function, it will loop through the files in the `data` folder. For each file, it will extract the numeric value and extension from the file name and compare them against the provided input conditions. If the conditions are met, the function will create backup copies of the selected files within the established logging folder structure.

```bash
./ca.sh -l 15 -u 30 -e csv
Option l: Lower bound (15)
Option u: Upper bound (30)
Option e: File extension (csv)
Checking log/2023/08/17 structure
Missing folder. Creating one
Filtering files range [15-30] for extension csv
Done
```

In this case, we are filtering files from number `15` to `30` with the `csv` extension. Your logging folder should be as follows: 

```bash
> tree log
log
└── 2023
    └── 08
        └── 17
            ├── data_15.csv
            ├── data_16.csv
            ├── data_17.csv
            ├── data_18.csv
            ├── data_19.csv
            ├── data_20.csv
            ├── data_21.csv
            ├── data_22.csv
            ├── data_23.csv
            ├── data_24.csv
            ├── data_25.csv
            ├── data_26.csv
            ├── data_27.csv
            ├── data_28.csv
            ├── data_29.csv
            └── data_30.csv

3 directories, 16 files
```

Note: You could install the `tree` binary using this command: `sudo apt install tree`
