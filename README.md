# Generating Vala Project

**valagen** is shell tool for creating Vala project.

Developed in **[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))** code: **100%**.

[![valagen shell checker](https://github.com/vroncevic/valagen/workflows/valagen%20shell%20checker/badge.svg)](https://github.com/vroncevic/valagen/actions?query=workflow%3A%22valagen+shell+checker%22)

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

Navigate to release **[page](https://github.com/vroncevic/valagen/releases)** download and extract release archive.

To install **valagen** type the following:

```
tar xvzf valagen-x.y.z.tar.gz
cd valagen-x.y.z
cp -R ~/sh_tool/bin/   /root/scripts/valagen/ver.1.0/
cp -R ~/sh_tool/conf/  /root/scripts/valagen/ver.1.0/
cp -R ~/sh_tool/log/   /root/scripts/valagen/ver.1.0/
```

![alt tag](https://raw.githubusercontent.com/vroncevic/valagen/dev/docs/setup_tree.png)

Or You can use docker to create image/container.

[![valagen docker checker](https://github.com/vroncevic/valagen/workflows/valagen%20docker%20checker/badge.svg)](https://github.com/vroncevic/valagen/actions?query=workflow%3A%22valagen+docker+checker%22)

### Usage

```
# Create symlink for shell tool
ln -s /root/scripts/valagen/ver.1.0/bin/valagen.sh /root/bin/valagen

# Setting PATH
export PATH=${PATH}:/root/bin/

# Creating Vala project
valagen MyApp
```

### Dependencies

**valagen** requires next modules and libraries:
* sh_util [https://github.com/vroncevic/sh_util](https://github.com/vroncevic/sh_util)

### Shell tool structure

**valagen** is based on MOP.

Code structure:
```
.
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
│   └── valagen_util.cfg
└── log/
    └── valagen.log
```

### Docs

[![Documentation Status](https://readthedocs.org/projects/valagen/badge/?version=latest)](https://valagen.readthedocs.io/projects/valagen/en/latest/?badge=latest)

More documentation and info at:
* [https://valagen.readthedocs.io/en/latest/](https://valagen.readthedocs.io/en/latest/)
* [https://www.gnu.org/software/bash/manual/](https://www.gnu.org/software/bash/manual/)

### Copyright and licence

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Copyright (C) 2016 by [vroncevic.github.io/valagen](https://vroncevic.github.io/valagen)

**valagen** is free software; you can redistribute it and/or modify
it under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

