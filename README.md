# Assignment 1 — Linux, Bash & Networking Diagnostic Toolkit

## Project Overview

This project is a Bash-based Linux diagnostic toolkit developed as part of **Assignment 1: Linux, Bash & Networking**.

The toolkit provides three diagnostic scripts for collecting system information, monitoring disk usage, and performing basic network checks. Each script obtains information dynamically from the Linux system at runtime and records useful operations in the project's logging directory.

The project demonstrates practical knowledge of:

* Linux commands and system administration
* Bash scripting
* Command-line argument handling
* Input validation
* Exit codes
* Disk monitoring
* DNS and hostname resolution
* Network connectivity testing
* TCP port connectivity checks
* Logging
* Git and GitHub workflow

## Assignment Objectives

The objective of this assignment was to build a Linux diagnostic toolkit using Bash.

The toolkit was required to:

1. Collect detailed system information.
2. Check disk usage against a user-defined threshold.
3. Perform basic network diagnostics.
4. Validate user input and handle invalid input safely.
5. Create useful logs containing timestamps and descriptions of operations.
6. Use Git with meaningful commits and at least one feature branch.
7. Provide clear project documentation.

## Project Structure

```text
assignment-1/
├── README.md
├── system-info.sh
├── disk-check.sh
├── network-check.sh
├── grade.sh
└── logs/
    └── .gitkeep
```

The `logs/` directory is used to store diagnostic logs generated during script execution.

## Prerequisites

The project is designed to run in a Linux environment.

The following tools and commands are used by the scripts:

* Bash
* `hostname`
* `whoami`
* `date`
* `uname`
* `uptime`
* `lscpu`
* `free`
* `df`
* `awk`
* `getent`
* `ping`
* `ip`
* `timeout`

To run the scripts, Bash must be available.

Check the Bash version with:

```bash
bash --version
```

## Setup

Clone the repository:

```bash
git clone git@github.com:Adedoyin007/asignment-1.git
```

Move into the project directory:

```bash
cd asignment-1
```

Make the scripts executable if necessary:

```bash
chmod +x system-info.sh disk-check.sh network-check.sh grade.sh
```

## System Information Diagnostic

The `system-info.sh` script collects information directly from the Linux system at runtime.

Run:

```bash
./system-info.sh
```

### Information Collected

The script displays:

* Hostname
* Current user
* Current date and time
* Operating system information
* Kernel version
* System uptime
* CPU information
* Memory information
* Current working directory

The information is generated dynamically rather than being hard-coded.

### Linux Commands Used

Examples of commands used by the script include:

```bash
hostname
whoami
date
uname -a
uptime
lscpu
free -h
pwd
```

This provides a quick overview of the current Linux environment.

## Disk Usage Diagnostic

The `disk-check.sh` script checks disk usage against a threshold supplied by the user.

### Usage

```bash
./disk-check.sh <threshold> [path]
```

### Arguments

* `<threshold>` — Required disk usage threshold.
* `[path]` — Optional filesystem path.
* The default path is `/`.

Example:

```bash
./disk-check.sh 80
```

This checks the disk usage of the default filesystem and compares it with an 80% threshold.

Check a specific path:

```bash
./disk-check.sh 80 /home
```

### Validation

The threshold must:

* Be an integer.
* Be between `1` and `100`.

Invalid input returns exit code `2`.

Examples of invalid input include:

```bash
./disk-check.sh
./disk-check.sh abc
./disk-check.sh 0
./disk-check.sh 101
```

### Exit Behaviour

The script follows this behaviour:

| Condition                                   | Exit Code |
| ------------------------------------------- | --------: |
| Disk usage is below the threshold           |       `0` |
| Disk usage reaches or exceeds the threshold |  Non-zero |
| Invalid input                               |       `2` |

### Disk Usage Information

Disk usage is obtained from the Linux system using commands such as:

```bash
df
awk
```

The script extracts the percentage of disk usage and compares it with the threshold provided by the user.

## Network Diagnostic

The `network-check.sh` script performs basic network diagnostics for a hostname or IP address.

### Usage

```bash
./network-check.sh <hostname-or-ip> [port]
```

Examples:

```bash
./network-check.sh google.com
```

Or with a TCP port:

```bash
./network-check.sh google.com 443
```

## Host Validation and Resolution

The script first validates that a host argument was provided.

It then attempts to resolve the hostname and display the resolved address.

This helps confirm that DNS or hostname resolution is working.

Example checks include:

* Hostname resolution
* Resolved IP address display
* Basic connectivity testing

## Basic Connectivity Check

After resolving the host, the script performs a basic connectivity check.

This helps determine whether the specified host can be reached from the current system.

The connectivity check uses Linux networking utilities such as:

```bash
ping
```

The script handles connectivity failures without crashing.

## Network Interface Information

The script also displays information about the available network interfaces.

This information is obtained using:

```bash
ip addr
```

The output can be useful for identifying:

* Network interfaces
* Assigned IP addresses
* Interface status
* Local network configuration

## TCP Port Connectivity Check

An optional port can be supplied as the second argument.

Example:

```bash
./network-check.sh google.com 443
```

The script validates that the supplied port is within the valid TCP port range:

```text
1–65535
```

Invalid ports return a non-zero exit status.

Examples of invalid ports include:

```bash
./network-check.sh google.com 0
./network-check.sh google.com 65536
./network-check.sh google.com abc
```

When a valid port is supplied, the script performs a basic TCP connectivity check.

## Logging

The project includes a `logs/` directory for recording diagnostic operations.

Log entries contain:

* A timestamp
* A description of the operation performed

The `logs/` directory is used to store diagnostic logs generated during script execution. Log files, such as `operations.log`, are created and updated at runtime by the diagnostic scripts.

Example log information may include:

```text
[Timestamp] System information check completed
[Timestamp] Disk usage check performed
[Timestamp] Network diagnostic performed
```

The `logs/.gitkeep` file ensures that the otherwise empty `logs/` directory is retained in the Git repository.

## Error Handling

Input validation and safe error handling are important parts of the toolkit.

### Disk Script

The disk diagnostic validates:

* Missing threshold
* Non-numeric threshold
* Threshold below `1`
* Threshold above `100`

Invalid input returns exit code `2`.

### Network Script

The network diagnostic validates:

* Missing host
* Invalid or unresolved host
* Invalid port values
* Non-numeric ports
* Ports outside the range `1–65535`

The script is designed to return a non-zero result for invalid input or failed operations rather than crashing unexpectedly.

## Exit Codes

The scripts use exit codes to communicate the result of an operation.

| Exit Code | Meaning                                   |
| --------- | ----------------------------------------- |
| `0`       | Successful operation                      |
| Non-zero  | Operational failure or unsuccessful check |
| `2`       | Invalid input or invalid arguments        |

## Usage Examples

### Display System Information

```bash
./system-info.sh
```

### Check Disk Usage

```bash
./disk-check.sh 80
```

### Check Disk Usage for a Specific Path

```bash
./disk-check.sh 90 /home
```

### Perform a Network Check

```bash
./network-check.sh localhost
```

### Check a Remote Host

```bash
./network-check.sh google.com
```

### Check TCP Port Connectivity

```bash
./network-check.sh google.com 443
```

## Local Grading

The project includes a `grade.sh` script for validating the assignment requirements.

Make the scripts executable:

```bash
chmod +x grade.sh *.sh
```

Run the grader:

```bash
./grade.sh
```

The local grader checks areas including:

* Required project files
* Bash syntax
* Executable permissions
* System information output
* Disk argument validation
* Disk usage behaviour
* Network argument validation
* Host resolution
* Logging
* Basic Git history

## Git Workflow

The project was developed using Git and GitHub.

The Git workflow included:

* Meaningful commits during development
* A non-main feature branch
* Development and testing on the feature branch
* Merging completed work back into the `main` branch

The assignment requirement specifies at least five meaningful commits, which demonstrates incremental development rather than placing the entire project into a single commit.

Example Git commands used during development include:

```bash
git status
git add .
git commit -m "Meaningful commit message"
git branch
git checkout -b feature/example
git checkout main
git merge feature/example
git push
```

## Skills Demonstrated

This project demonstrates practical skills in several areas.

### Linux

* System information retrieval
* Disk usage monitoring
* CPU inspection
* Memory inspection
* Network interface inspection

### Bash Scripting

* Variables
* Command substitution
* Functions
* Conditional statements
* Command-line arguments
* Optional arguments
* Input validation
* Exit codes

### Networking

* Hostname resolution
* IP address lookup
* Basic connectivity testing
* Network interface inspection
* TCP port validation
* TCP connectivity testing

### Error Handling

* Missing argument detection
* Numeric validation
* Range validation
* Non-zero exit codes
* Safe handling of failed operations

### Logging

* Timestamped operations
* Persistent diagnostic records
* Simple audit trail of script activity

### Git and GitHub

* Incremental commits
* Feature branch workflow
* Branch merging
* Remote repository management

## Lessons Learned

Through this project, I gained practical experience in building command-line diagnostic tools with Bash.

Key lessons included:

* Linux commands can be combined into reusable automation scripts.
* Input validation is important for preventing unexpected script behaviour.
* Exit codes make scripts easier to test and automate.
* Disk thresholds can be used to identify potential storage problems.
* DNS resolution and connectivity checks help diagnose network problems.
* TCP port checks provide a basic method of verifying service availability.
* Logging provides useful evidence of script operations.
* Git branches and meaningful commits help organise development work.

## Conclusion

This project delivers a lightweight Linux diagnostic toolkit built with Bash.

The toolkit provides three core capabilities:

1. **System diagnostics** through `system-info.sh`.
2. **Disk monitoring** through `disk-check.sh`.
3. **Network diagnostics** through `network-check.sh`.

The project combines Linux administration, Bash scripting, networking, input validation, error handling, logging, and Git workflow practices into a practical command-line toolkit.

It was designed to meet the Assignment 1 requirements while providing a reusable foundation for basic Linux system diagnostics.
