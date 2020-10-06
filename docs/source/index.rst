valagen
--------

**valagen** is shell tool for creating Vala project.

Developed in `bash <https://en.wikipedia.org/wiki/Bash_(Unix_shell)>`_ code: **100%**.

|GitHub shell checker|

.. |GitHub shell checker| image:: https://github.com/vroncevic/valagen/workflows/valagen%20shell%20checker/badge.svg
   :target: https://github.com/vroncevic/valagen/actions?query=workflow%3A%22valagen+shell+checker%22

The README is used to introduce the tool and provide instructions on
how to install the tool, any machine dependencies it may have and any
other information that should be provided before the tool is installed.

|GitHub issues| |Documentation Status| |GitHub contributors|

.. |GitHub issues| image:: https://img.shields.io/github/issues/vroncevic/valagen.svg
   :target: https://github.com/vroncevic/valagen/issues

.. |GitHub contributors| image:: https://img.shields.io/github/contributors/vroncevic/valagen.svg
   :target: https://github.com/vroncevic/valagen/graphs/contributors

.. |Documentation Status| image:: https://readthedocs.org/projects/valagen/badge/?version=latest
   :target: https://valagen.readthedocs.io/projects/valagen/en/latest/?badge=latest

.. toctree::
    :hidden:

    self

Installation
-------------

Navigate to release `page`_ download and extract release archive.

.. _page: https://github.com/vroncevic/valagen/releases

To install **valagen** type the following:

.. code-block:: bash

   tar xvzf valagen-x.y.z.tar.gz
   cd valagen-x.y.z
   cp -R ~/sh_tool/bin/   /root/scripts/valagen/ver.1.0/
   cp -R ~/sh_tool/conf/  /root/scripts/valagen/ver.1.0/
   cp -R ~/sh_tool/log/   /root/scripts/valagen/ver.1.0/

Or You can use Docker to create image/container.

|GitHub docker checker|

.. |GitHub docker checker| image:: https://github.com/vroncevic/valagen/workflows/valagen%20docker%20checker/badge.svg
   :target: https://github.com/vroncevic/valagen/actions?query=workflow%3A%22valagen+docker+checker%22

Dependencies
-------------

**valagen** requires next modules and libraries:
    sh_util `https://github.com/vroncevic/sh_util <https://github.com/vroncevic/sh_util>`_

Shell tool structure
---------------------

**valagen** is based on MOP.

Code structure:

.. code-block:: bash

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

Copyright and licence
----------------------

|License: GPL v3| |License: Apache 2.0|

.. |License: GPL v3| image:: https://img.shields.io/badge/License-GPLv3-blue.svg
   :target: https://www.gnu.org/licenses/gpl-3.0

.. |License: Apache 2.0| image:: https://img.shields.io/badge/License-Apache%202.0-blue.svg
   :target: https://opensource.org/licenses/Apache-2.0

Copyright (C) 2016 by `vroncevic.github.io/valagen <https://vroncevic.github.io/valagen>`_

**valagen** is free software; you can redistribute it and/or modify it
under the same terms as Bash itself, either Bash version 4.2.47 or,
at your option, any later version of Bash 4 you may have available.

