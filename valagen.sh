#!/bin/bash
#
# @brief   Vala Project Generator
# @version ver.1.0
# @date    Thu Jan 14 22:26:32 2016
# @company Frobas IT Department, www.frobas.com 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#

SUCCESS=0
NOT_SUCCESS=1

declare -A VALA_PROJECT=(
    [NAME]="none"
    [PATH]="none"
    [AUTOGEN]="autogen.sh"
    [CONFIG]="configure.ac"
    [DESKTOP]="desktop.in"
    [MAKE]="Makefile.am"
    [README]="README"
    [COMMENT]="none"
    [CODE]="none"
)

#
# @brief Generating autogen.sh file
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_autogen_sh
# STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
# else
#   # false
# fi
#
function __gen_autogen_sh() {
    if [ -f "${VALA_PROJECT[PATH]}/${VALA_PROJECT[AUTOGEN]}" ]; then
        printf "%s\n" "already exist ${VALA_PROJECT[PATH]}/${VALA_PROJECT[AUTOGEN]}"
        return $NOT_SUCCESS
    fi
    cat<<EOF>>"${VALA_PROJECT[PATH]}/${VALA_PROJECT[AUTOGEN]}"
#!/bin/bash
# Powered by Frobas
set -e
test -n "\$srcdir" || srcdir=\`dirname "\$0"\`
test -n "\$srcdir" || srcdir=.
olddir=\`pwd\`
cd "\$srcdir"
autoreconf --force --install
cd "\$olddir"
if test -z "\$NOCONFIGURE"; then
  "\$srcdir"/configure "\$@"
fi

EOF
    printf "%s\n" "generated ${VALA_PROJECT[PATH]}/${VALA_PROJECT[AUTOGEN]}"
    return $SUCCESS
}

#
# @brief Generating configure.ac file
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_configure_ac
# STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
# else
#   # false
# fi
#
function __gen_configure_ac() {
    if [ -f "${VALA_PROJECT[PATH]}/${VALA_PROJECT[CONFIG]}" ]; then
        printf "%s\n" "already exist ${VALA_PROJECT[PATH]}/${VALA_PROJECT[CONFIG]}"
        return $NOT_SUCCESS
    fi
    cat<<EOF>>"${VALA_PROJECT[PATH]}/${VALA_PROJECT[CONFIG]}"
# Powered by Frobas
AC_INIT([${VALA_PROJECT[NAME]}], 1.0)
AM_INIT_AUTOMAKE([1.10 no-define foreign dist-xz no-dist-gzip])
AC_PROG_CC
AM_PROG_VALAC([0.16])
PKG_CHECK_MODULES(gtk, gtk+-3.0)
AC_CONFIG_FILES([Makefile ${VALA_PROJECT[NAME]}.desktop])
AC_OUTPUT
EOF
    printf "%s\n" "generated ${VALA_PROJECT[PATH]}/${VALA_PROJECT[CONFIG]}"
    return $SUCCESS
}

#
# @brief Generating app.desktop.in file
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_desktop_in
# STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
# else
#   # false
# fi
#
function __gen_desktop_in() {
    if [ -f "${VALA_PROJECT[PATH]}/${VALA_PROJECT[DESKTOP]}" ]; then
        printf "%s\n" "already exist ${VALA_PROJECT[PATH]}/${VALA_PROJECT[DESKTOP]}"
        return $NOT_SUCCESS
    fi
    cat<<EOF>>"${VALA_PROJECT[PATH]}/${VALA_PROJECT[DESKTOP]}"
[Desktop Entry]
Version=1.0
Encoding=UTF-8
Name=${VALA_PROJECT[NAME]}
Comment=${VALA_PROJECT[COMMENT]}
Exec=@prefix@/bin/${VALA_PROJECT[NAME]}
Icon=application-default-icon
Terminal=false
Type=Application
StartupNotify=true
Categories=GNOME;GTK;Utility;
EOF
    printf "%s\n" "generated ${VALA_PROJECT[PATH]}/${VALA_PROJECT[DESKTOP]}"
    return $SUCCESS
}

#
# @brief Generating Makefile.am file
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_makefile_am
# STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
# else
#   # false
# fi
#
function __gen_makefile_am() {
    if [ -f "${VALA_PROJECT[PATH]}/${VALA_PROJECT[MAKE]}" ]; then
        printf "%s\n" "already exist ${VALA_PROJECT[PATH]}/${VALA_PROJECT[MAKE]}"
        return $NOT_SUCCESS
    fi
    cat<<EOF>>"${VALA_PROJECT[PATH]}/${VALA_PROJECT[MAKE]}"
bin_PROGRAMS = ${VALA_PROJECT[NAME]}
${VALA_PROJECT[NAME]}_CFLAGS = \$(gtk_CFLAGS)
${VALA_PROJECT[NAME]}_LDADD = \$(gtk_LIBS)
${VALA_PROJECT[NAME]}_VALAFLAGS = --pkg gtk+-3.0
${VALA_PROJECT[NAME]}_SOURCES = ${VALA_PROJECT[NAME]}.vala
desktopdir = \$(datadir)/applications
desktop_DATA = \
	${VALA_PROJECT[NAME]}.desktop
EOF
    printf "%s\n" "generated ${VALA_PROJECT[PATH]}/${VALA_PROJECT[MAKE]}"
    return $SUCCESS
}

#
# @brief Generating README file
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_readme 
# STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
# else
#   # false
# fi
#
function __gen_readme() {
    if [ -f "${VALA_PROJECT[PATH]}/${VALA_PROJECT[README]}" ]; then
        printf "%s\n" "already exist ${VALA_PROJECT[PATH]}/${VALA_PROJECT[README]}"
        return $NOT_SUCCESS
    fi
    cat<<EOF>>"${VALA_PROJECT[PATH]}/${VALA_PROJECT[README]}"
# Powered by Frobas
# To build and install this program:

./autogen.sh --prefix=/home/your_username/.local
make
make install

# Running the first line above creates the following files:

aclocal.m4
autom4te.cache
config.log
config.status
configure
depcomp
${VALA_PROJECT[NAME]}
${VALA_PROJECT[NAME]}.c
${VALA_PROJECT[NAME]}.desktop
${VALA_PROJECT[NAME]}-${VALA_PROJECT[NAME]}.o
${VALA_PROJECT[NAME]}_vala.stamp
install-sh
missing
Makefile.in
Makefile

# Running "make" links all the appropriate libraries.
# Running "make install", installs the application in /home/your_username/.local/bin
# and installs the hello-world.desktop file in /home/your_username/.local/share/applications
# You can now run the application by typing "Hello World" in the Overview.

# To uninstall, type:

make uninstall

# To create a tarball type:

make distcheck

# This will create hello-world-1.0.tar.xz

EOF
    printf "%s\n" "generated ${VALA_PROJECT[PATH]}/${VALA_PROJECT[README]}"
    return $SUCCESS
}

#
# @brief Generating Vala source file
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_vala_code 
# STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
# else
#   # false
# fi
#
function __gen_vala_code() {
    if [ -f "${VALA_PROJECT[PATH]}/${VALA_PROJECT[CODE]}" ]; then
        printf "%s\n" "already exist ${VALA_PROJECT[PATH]}/${VALA_PROJECT[CODE]}"
        return $NOT_SUCCESS
    fi
    cat<<EOF>>"${VALA_PROJECT[PATH]}/${VALA_PROJECT[CODE]}"
/**
 * Automatic generated ${VALA_PROJECT[NAME]}.vala
 * Powered by Frobas 
 */
public class ${VALA_PROJECT[NAME]} : Gtk.Application {
    protected override void activate () {
        var window = new Gtk.ApplicationWindow (this);
        var label = new Gtk.Label ("Simple test!");
        window.add (label);
        window.set_title ("Welcome to GNOME");
        window.set_default_size (200, 100);
        window.show_all ();
    }
}

public int main (string[] args) {
    return new ${VALA_PROJECT[NAME]} ().run (args);
}

EOF
    printf "%s\n" "generated ${VALA_PROJECT[PATH]}/${VALA_PROJECT[CODE]}"
    return $SUCCESS
}

#
# @brief Main entry point
# @params required project name, project path and comment
#
VALA_PROJECT[NAME]="$1"
VALA_PROJECT[PATH]="$2/$1"
VALA_PROJECT[COMMENT]="$3"

if [ $# -ne 3 ]; then
    printf "%s\n" "[usage]: ${BASH_SOURCE[0]} [PROJECT NAME] [PROJECT PATH] [COMMENT]"
    exit 127
fi

if [ -d "$2" ]; then
    mkdir "${VALA_PROJECT[PATH]}/"
    __gen_autogen_sh
    STATUS_AUTOGEN=$?
    if [ $STATUS_AUTOGEN -eq $SUCCESS ]; then
        __gen_configure_ac
        STATUS_CONFIGURE=$?
        if [ $STATUS_CONFIGURE -eq $SUCCESS ]; then
            __gen_desktop_in
            STATUS_DESKTOP=$?
            if [ $STATUS_DESKTOP -eq $SUCCESS ]; then
                __gen_makefile_am
                STATUS_MAKEFILE=$?
                if [ $STATUS_MAKEFILE -eq $SUCCESS ]; then
                    __gen_readme
                    STATUS_README=$?
                    if [ $STATUS_README -eq $SUCCESS ]; then
                        VALA_PROJECT[CODE]="${VALA_PROJECT[NAME]}.vala"
                        __gen_vala_code
                        STATUS_VALA_CODE=$?
                        if [ $STATUS_VALA_CODE -eq $SUCCESS ]; then
                            printf "%s\n" "done..."
                        fi
                    fi
                fi
            fi
        fi
    fi
else
    printf "%s\n" "directory ${VALA_PROJECT[PATH]} doesn't exist"
    exit 128
fi

exit 0
