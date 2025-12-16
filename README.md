# Generating Vala Project

<img align="right" src="https://raw.githubusercontent.com/vroncevic/valagen/dev/docs/valagen_logo.png" width="25%">

**valagen** is shell tool for creating Vala project.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![valagen_shell_checker](https://github.com/vroncevic/valagen/actions/workflows/valagen_shell_checker.yml/badge.svg)](https://github.com/vroncevic/valagen/actions/workflows/valagen_shell_checker.yml)

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

[![GitHub issues open](https://img.shields.io/github/issues/vroncevic/valagen.svg)](https://github.com/vroncevic/valagen/issues) [![GitHub contributors](https://img.shields.io/github/contributors/vroncevic/valagen.svg)](https://github.com/vroncevic/valagen/graphs/contributors)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**

- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Shell tool structure](#shell-tool-structure)
- [Docs](#docs)
- [Copyright and licence](#copyright-and-licence)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### Installation

![Debian Linux OS](https://raw.githubusercontent.com/vroncevic/valagen/dev/docs/debtux.png)

Navigate to release **[page](https://github.com/vroncevic/valagen/releases)** download and extract release archive.

To install **valagen** type the following

```bash
tar xvzf valagen-3.0.tar.gz
cd valagen-3.0
cp -R ~/sh_tool/bin/   /root/scripts/valagen/ver.3.0/
cp -R ~/sh_tool/conf/  /root/scripts/valagen/ver.3.0/
cp -R ~/sh_tool/log/   /root/scripts/valagen/ver.3.0/
```

Self generated setup script and execution

```bash
./valagen_setup.sh

[setup] installing App/Tool/Script valagen
	Tue Dec 16 06:17:29 PM CET 2025
[setup] clean up App/Tool/Script structure
[setup] copy App/Tool/Script structure
[setup] remove github editor configuration files
[setup] set App/Tool/Script permission
[setup] create symbolic link of App/Tool/Script
[setup] done

/root/scripts/valagen/ver.3.0/
├── bin/
│   └── valagen.sh
├── conf/
│   ├── project_set.cfg
│   ├── template/
│   │   ├── autogen.template
│   │   ├── configure_ac.template
│   │   ├── desktop_in.template
│   │   ├── makefile_am.template
│   │   ├── readme.template
│   │   ├── v_editorconfig.template
│   │   └── v_source.template
│   ├── valagen.cfg
│   ├── valagen.logo
│   └── valagen_util.cfg
└── log/
    └── valagen.log

4 directories, 15 files
lrwxrwxrwx 1 root root 44 Dec 16 06:17 /root/bin/valagen -> /root/scripts/valagen/ver.3.0/bin/valagen.sh
```

Or You can use docker to create image/container.

### Usage

```bash
# Create symlink for shell tool
ln -s /root/scripts/valagen/ver.3.0/bin/valagen.sh /root/bin/valagen

# Setting PATH
export PATH=${PATH}:/root/bin/

# Creating Vala project
valagen ftool "/opt" "Font generator"
                                                                                                                                                                 
valagen ver.3.0
Tue Dec 16 06:17:49 PM CET 2025

[check_root] Check permission for current session? [ok]
[check_root] Done
                                                              
                       ██                                     
                      ░██                                     
   ██    ██  ██████   ░██  ██████    █████   █████  ███████   
  ░██   ░██ ░░░░░░██  ░██ ░░░░░░██  ██░░░██ ██░░░██░░██░░░██  
  ░░██ ░██   ███████  ░██  ███████ ░██  ░██░███████ ░██  ░██  
   ░░████   ██░░░░██  ░██ ██░░░░██ ░░██████░██░░░░  ░██  ░██  
    ░░██   ░░████████ ███░░████████ ░░░░░██░░██████ ███  ░██  
     ░░     ░░░░░░░░ ░░░  ░░░░░░░░   █████  ░░░░░░ ░░░   ░░   
                                    ░░░░░                     
	                                     
	Info   github.io/valagen ver.3.0
	Issue  github.io/issue
	Author vroncevic.github.io

[valagen] Loading basic and util configuration!
100% [================================================]

[load_conf] Loading App/Tool/Script configuration!
[check_cfg] Checking configuration file [/root/scripts/valagen/ver.3.0/conf/valagen.cfg] [ok]
[check_cfg] Done

[load_conf] Done

[load_util_conf] Load module configuration!
[check_cfg] Checking configuration file [/root/scripts/valagen/ver.3.0/conf/valagen_util.cfg] [ok]
[check_cfg] Done

[load_util_conf] Done

[load_util_conf] Load module configuration!
[check_cfg] Checking configuration file [/root/scripts/valagen/ver.3.0/conf/project_set.cfg] [ok]
[check_cfg] Done

[load_util_conf] Done

[valagen] Generating project structure!
[valagen] Checking directory [/opt/]? [ok]
[valagen] Generating directory [/opt/ftool/]
[valagen] Generating file [/opt/ftool/autogen.sh]
[valagen] Generating file [/opt/ftool/configure.ac]
[valagen] Generating file [/opt/ftool/ftool.desktop.in]
[valagen] Generating file [/opt/ftool/Makefile.am]
[valagen] Generating file [/opt/ftool/ftool.vala]
[valagen] Generating file [/opt/ftool/.editorconfig]
[valagen] Generating file [/opt/ftool/README]
[valagen] Set owner!
[valagen] Set permission!
[logging] Checking directory [/root/scripts/valagen/ver.3.0/log/]? [ok]
[logging] Write info log!
[logging] Done

[valagen] Done

[check_tool] Checking tool [/usr/bin/tree]? [ok]
[check_tool] Done

/opt/ftool/
├── autogen.sh
├── configure.ac
├── ftool.desktop.in
├── ftool.vala
├── Makefile.am
└── README

1 directories, 6 files
```

### Dependencies

**valagen** requires next modules and libraries
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**valagen** is based on MOP.

Shell tool structure

```bash
sh_tool/
├── bin/
│   └── valagen.sh
├── conf/
│   ├── project_set.cfg
│   ├── template/
│   │   ├── autogen.template
│   │   ├── configure_ac.template
│   │   ├── desktop_in.template
│   │   ├── makefile_am.template
│   │   ├── readme.template
│   │   ├── v_editorconfig.template
│   │   └── v_source.template
│   ├── valagen.cfg
│   ├── valagen.logo
│   └── valagen_util.cfg
└── log/
    └── valagen.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/valagen/badge/?version=latest)](https://valagen.readthedocs.io/projects/valagen/en/latest/?badge=latest)

More documentation and info at
* [https://valagen.readthedocs.io/en/latest/](https://valagen.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 - 2026 by [vroncevic.github.io/valagen](https://vroncevic.github.io/valagen)

**valagen** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

Lets help and support FSF.

[![Free Software Foundation](https://raw.githubusercontent.com/vroncevic/valagen/dev/docs/fsf-logo_1.png)](https://my.fsf.org/)

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://my.fsf.org/donate/)
