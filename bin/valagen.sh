#!/bin/bash
#
# @brief   Vala project generator
# @version ver.1.0
# @date    Thu Jan 14 22:26:32 2016
# @company Frobas IT Department, www.frobas.com 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=$UTIL_ROOT/sh-util-srv/$UTIL_VERSION
UTIL_LOG=$UTIL/log

. $UTIL/bin/devel.sh
. $UTIL/bin/usage.sh
. $UTIL/bin/checkroot.sh
. $UTIL/bin/logging.sh
. $UTIL/bin/loadconf.sh
. $UTIL/bin/loadutilconf.sh
. $UTIL/bin/progressbar.sh

VALAGEN_TOOL=valagen
VALAGEN_VERSION=ver.1.0
VALAGEN_HOME=$UTIL_ROOT/$VALAGEN_TOOL/$VALAGEN_VERSION
VALAGEN_CFG=$VALAGEN_HOME/conf/$VALAGEN_TOOL.cfg
VALAGEN_UTIL_CFG=$VALAGEN_HOME/conf/${VALAGEN_TOOL}_util.cfg
VALAGEN_LOG=$VALAGEN_HOME/log

declare -A VALAGEN_USAGE=(
	[USAGE_TOOL]="__$VALAGEN_TOOL"
	[USAGE_ARG1]="[PROJECT_NAME] Name of project"
	[USAGE_ARG2]="[PROJECT_PATH] Project root folder"
	[USAGE_ARG3]="[COMMENT]      Short description"
	[USAGE_EX_PRE]="# Generating vala project"
	[USAGE_EX]="__$VALAGEN_TOOL ftool /opt/ \"Font generator\""
)

declare -A VALAGEN_LOG=(
	[LOG_TOOL]="$VALAGEN_TOOL"
	[LOG_FLAG]="info"
	[LOG_PATH]="$VALAGEN_LOG"
	[LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
	[BAR_WIDTH]=50
	[MAX_PERCENT]=100
	[SLEEP]=0.01
)

TOOL_DBG="false"

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
# @brief  Generating autogen.sh file
# @param  None
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_autogen_sh
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
#   # notify admin | user
# else
#   # false
#   # return $NOT_SUCCESS
#   # or
#   # exit 128
# fi
#
function __gen_autogen_sh() {
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	local PROJECT_HOME="${VALA_PROJECT[PATH]}/${VALA_PROJECT[NAME]}"
	local AUTOGEN_SH="$PROJECT_HOME/${VALA_PROJECT[AUTOGEN]}"
	if [ "$TOOL_DBG" == "true" ]; then
		MSG="Checking [$AUTOGEN_SH]"
		printf "$DQUE" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
    if [ -f "$AUTOGEN_SH" ]; then
        printf "%s\n" "[already exist]"
		MSG="[$VALA_PROJECT[NAME]] $AUTOGEN_SH already exist"
		if [ "${configvalagen[LOGGING]}" == "true" ]; then
			VALAGEN_LOG[LOG_MSGE]=$MSG
			VALAGEN_LOG[LOG_FLAG]="error"
			__logging VALAGEN_LOG
		fi
        return $NOT_SUCCESS
    fi
    local DATE=$(date)
	if [ "$TOOL_DBG" == "true" ]; then
		printf "%s\n" "[not exist]"
		MSG="Generating [$AUTOGEN_SH]"
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
	local AUTOGEN_SH_FILE="
#!/bin/bash
# Powered by $TOOL_FROM_COMPANY 
# $DATE
# Project ${VALA_PROJECT[NAME]}
#
set -e
test -n \"\$srcdir\" || srcdir=\`dirname \"\$0\"\`
test -n \"\$srcdir\" || srcdir=.
olddir=\`pwd\`
cd \"\$srcdir\"
autoreconf --force --install
cd \"\$olddir\"
if test -z \"\$NOCONFIGURE\"; then
  \"\$srcdir\"/configure \"\$@\"
fi
"
	echo -e "$AUTOGEN_SH_FILE" > "$AUTOGEN_SH"
	if [ "$TOOL_DBG" == "true" ]; then
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set owner [$AUTOGEN_SH]"
	fi
	local PRFX_CMD="chown"
	local OWNER="${configvalagenutil[USER]}.${configvalagenutil[GROUP]}"
	eval "$PRFX_CMD $OWNER $AUTOGEN_SH"
    if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set permission [$AUTOGEN_SH]"
	fi
    chmod 700 "$AUTOGEN_SH"
    if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DEND" "$VALAGEN_TOOL" "$FUNC" "Done"
	fi
	MSG="[$VALA_PROJECT[NAME]] Generated $AUTOGEN_SH"
	if [ "${configvalagen[LOGGING]}" == "true" ]; then
		VALAGEN_LOG[LOG_MSGE]=$MSG
		VALAGEN_LOG[LOG_FLAG]="info"
		__logging VALAGEN_LOG
	fi
    return $SUCCESS
}

#
# @brief  Generating configure.ac file
# @param  None
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_configure_ac
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
#   # notify admin | user
# else
#   # false
#   # return $NOT_SUCCESS
#   # or
#   # exit 128
# fi
#
function __gen_configure_ac() {
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	local PROJECT_HOME="${VALA_PROJECT[PATH]}/${VALA_PROJECT[NAME]}"
	local CONFIGURE_AC="$PROJECT_HOME/${VALA_PROJECT[CONFIG]}"
	if [ "$TOOL_DBG" == "true" ]; then
		MSG="Checking [$CONFIGURE_AC]"
		printf "$DQUE" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
    if [ -f "$CONFIGURE_AC" ]; then
        printf "%s\n" "[already exist]"
		MSG="[$VALA_PROJECT[NAME]] $CONFIGURE_AC already exist"
		if [ "${configvalagen[LOGGING]}" == "true" ]; then
			VALAGEN_LOG[LOG_MSGE]=$MSG
			VALAGEN_LOG[LOG_FLAG]="error"
			__logging VALAGEN_LOG
		fi
        return $NOT_SUCCESS
    fi
    local DATE=$(date)
    if [ "$TOOL_DBG" == "true" ]; then
		printf "%s\n" "[not exist]"
		MSG="Generating [$CONFIGURE_AC]"
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
	local CONFIGURE_AC_FILE="
#
# Powered by $TOOL_FROM_COMPANY 
# $DATE
# Project ${VALA_PROJECT[NAME]}
#
AC_INIT([${VALA_PROJECT[NAME]}], 1.0)
AM_INIT_AUTOMAKE([1.10 no-define foreign dist-xz no-dist-gzip])
AC_PROG_CC
AM_PROG_VALAC([0.16])
PKG_CHECK_MODULES(gtk, gtk+-3.0)
AC_CONFIG_FILES([Makefile ${VALA_PROJECT[NAME]}.desktop])
AC_OUTPUT
"
	echo -e "$CONFIGURE_AC_FILE" > "$CONFIGURE_AC"
	if [ "$TOOL_DBG" == "true" ]; then
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set owner [$CONFIGURE_AC]"
	fi
	local PRFX_CMD="chown"
	local OWNER="${configvalagenutil[USER]}.${configvalagenutil[GROUP]}"
	eval "$PRFX_CMD $OWNER $CONFIGURE_AC"
	if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set permission [$CONFIGURE_AC]"
	fi
    chmod 700 "$CONFIGURE_AC"
    if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DEND" "$VALAGEN_TOOL" "$FUNC" "Done"
	fi
	MSG="[$VALA_PROJECT[NAME]] Generated $CONFIGURE_AC"
	if [ "${configvalagen[LOGGING]}" == "true" ]; then
		VALAGEN_LOG[LOG_MSGE]=$MSG
		VALAGEN_LOG[LOG_FLAG]="info"
		__logging VALAGEN_LOG
	fi
    return $SUCCESS
}

#
# @brief  Generating app.desktop.in file
# @param  None
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_desktop_in
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
#   # notify admin | user
# else
#   # false
#   # return $NOT_SUCCESS
#   # or
#   # exit 128
# fi
#
function __gen_desktop_in() {
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	local PROJECT_HOME="${VALA_PROJECT[PATH]}/${VALA_PROJECT[NAME]}"
	local DESKTOP_IN="$PROJECT_HOME/${VALA_PROJECT[DESKTOP]}"
	if [ "$TOOL_DBG" == "true" ]; then
		MSG="Checking [$DESKTOP_IN]"
		printf "$DQUE" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
    if [ -f "$DESKTOP_IN" ]; then
        printf "%s\n" "[already exist]"
		MSG="[$VALA_PROJECT[NAME]] $DESKTOP_IN already exist"
		if [ "${configvalagen[LOGGING]}" == "true" ]; then
			VALAGEN_LOG[LOG_MSGE]=$MSG
			VALAGEN_LOG[LOG_FLAG]="error"
			__logging VALAGEN_LOG
		fi
        return $NOT_SUCCESS
    fi
    local DATE=$(date)
    if [ "$TOOL_DBG" == "true" ]; then
		printf "%s\n" "[not exist]"
		MSG="Generating [$DESKTOP_IN]"
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
	local DESKTOP_IN_FILE="
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
"
	echo -e "$DESKTOP_IN_FILE" > "$DESKTOP_IN"
    if [ "$TOOL_DBG" == "true" ]; then
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set owner [$DESKTOP_IN]"
	fi
	local PRFX_CMD="chown"
	local OWNER="${configvalagenutil[USER]}.${configvalagenutil[GROUP]}"
	eval "$PRFX_CMD $OWNER $DESKTOP_IN"
	if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set permission [$DESKTOP_IN]"
	fi
    chmod 700 "$DESKTOP_IN"
    if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DEND" "$VALAGEN_TOOL" "$FUNC" "Done"
	fi
	MSG="[$VALA_PROJECT[NAME]] Generated $DESKTOP_IN"
	if [ "${configvalagen[LOGGING]}" == "true" ]; then
		VALAGEN_LOG[LOG_MSGE]=$MSG
		VALAGEN_LOG[LOG_FLAG]="info"
		__logging VALAGEN_LOG
	fi
    return $SUCCESS
}

#
# @brief  Generating Makefile.am file
# @param  None
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_makefile_am
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
#   # notify admin | user
# else
#   # false
#   # return $NOT_SUCCESS
#   # or
#   # exit 128
# fi
#
function __gen_makefile_am() {
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	local PROJECT_HOME="${VALA_PROJECT[PATH]}/${VALA_PROJECT[NAME]}"
	local MAKEFILE_AM="$PROJECT_HOME/${VALA_PROJECT[MAKE]}"
	if [ "$TOOL_DBG" == "true" ]; then
		MSG="Checking [$MAKEFILE_AM]"
		printf "$DQUE" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
    if [ -f "$MAKEFILE_AM" ]; then
        printf "%s\n" "[already exist]"
		MSG="[$VALA_PROJECT[NAME]] $MAKEFILE_AM already exist"
		if [ "${configvalagen[LOGGING]}" == "true" ]; then
			VALAGEN_LOG[LOG_MSGE]=$MSG
			VALAGEN_LOG[LOG_FLAG]="error"
			__logging VALAGEN_LOG
		fi
        return $NOT_SUCCESS
    fi
    local DATE=$(date)
    if [ "$TOOL_DBG" == "true" ]; then
		printf "%s\n" "[not exist]"
		MSG="Generating [$MAKEFILE_AM]"
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
	local MAKEFILE_AM_FILE="
#
# Powered by $TOOL_FROM_COMPANY 
# $DATE
# Project ${VALA_PROJECT[NAME]}
#
bin_PROGRAMS = ${VALA_PROJECT[NAME]}
${VALA_PROJECT[NAME]}_CFLAGS = \$(gtk_CFLAGS)
${VALA_PROJECT[NAME]}_LDADD = \$(gtk_LIBS)
${VALA_PROJECT[NAME]}_VALAFLAGS = --pkg gtk+-3.0
${VALA_PROJECT[NAME]}_SOURCES = ${VALA_PROJECT[NAME]}.vala
desktopdir = \$(datadir)/applications
desktop_DATA = \
	${VALA_PROJECT[NAME]}.desktop
"
	echo -e "$MAKEFILE_AM_FILE" > "$MAKEFILE_AM"
	if [ "$TOOL_DBG" == "true" ]; then
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set owner [$MAKEFILE_AM]"
	fi
	local PRFX_CMD="chown"
	local OWNER="${configvalagenutil[USER]}.${configvalagenutil[GROUP]}"
	eval "$PRFX_CMD $OWNER $MAKEFILE_AM"
	if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set permission [$MAKEFILE_AM]"
	fi
    chmod 700 "$MAKEFILE_AM"
    if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DEND" "$VALAGEN_TOOL" "$FUNC" "Done"
	fi
	MSG="[$VALA_PROJECT[NAME]] Generated $MAKEFILE_AM"
	if [ "${configvalagen[LOGGING]}" == "true" ]; then
		VALAGEN_LOG[LOG_MSGE]=$MSG
		VALAGEN_LOG[LOG_FLAG]="info"
		__logging VALAGEN_LOG
	fi
    return $SUCCESS
}

#
# @brief  Generating README file
# @param  None
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_readme 
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
#   # notify admin | user
# else
#   # false
#   # return $NOT_SUCCESS
#   # or
#   # exit 128
# fi
#
function __gen_readme() {
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	local PROJECT_HOME="${VALA_PROJECT[PATH]}/${VALA_PROJECT[NAME]}"
	local README="$PROJECT_HOME/${VALA_PROJECT[README]}"
	if [ "$TOOL_DBG" == "true" ]; then
		MSG="Checking [$README]"
		printf "$DQUE" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
    if [ -f "$README" ]; then
        printf "%s\n" "[already exist]"
		MSG="[$VALA_PROJECT[NAME]] $README already exist"
		if [ "${configvalagen[LOGGING]}" == "true" ]; then
			VALAGEN_LOG[LOG_MSGE]=$MSG
			VALAGEN_LOG[LOG_FLAG]="info"
			__logging VALAGEN_LOG
		fi
        return $NOT_SUCCESS
    fi
    local DATE=$(date)
    if [ "$TOOL_DBG" == "true" ]; then
		printf "%s\n" "[not exist]"
		MSG="Generating [$README]"
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
	local README_FILE="
#
# Powered by $TOOL_FROM_COMPANY 
# $DATE
# Project ${VALA_PROJECT[NAME]}
#
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

# Running \"make\" links all the appropriate libraries.
# Running \"make install\", installs the application in 
/home/your_username/.local/bin
# and installs the ${VALA_PROJECT[NAME]}.desktop file in 
/home/your_username/.local/share/applications
# You can run the app by typing \"${VALA_PROJECT[NAME]}\" in the Overview.

# To uninstall, type:

make uninstall

# To create a tarball type:

make distcheck

# This will create ${VALA_PROJECT[NAME]}-1.0.tar.xz
"
	echo -e "$README_FILE" > "$README"
	if [ "$TOOL_DBG" == "true" ]; then
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set owner [$README]"
	fi
	local PRFX_CMD="chown"
	local OWNER="${configvalagenutil[USER]}.${configvalagenutil[GROUP]}"
	eval "$PRFX_CMD $OWNER $README"
	if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set permission [$README]"
	fi
    chmod 700 "$README"
    if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DEND" "$VALAGEN_TOOL" "$FUNC" "Done"
	fi
	MSG="[$VALA_PROJECT[NAME]] Generated $README"
	if [ "${configvalagen[LOGGING]}" == "true" ]; then
		VALAGEN_LOG[LOG_MSGE]=$MSG
		VALAGEN_LOG[LOG_FLAG]="info"
		__logging VALAGEN_LOG
	fi
    return $SUCCESS
}

#
# @brief  Generating Vala source file
# @param  None
# @retval Success return 0, else 1
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __gen_vala_code 
# local STATUS=$?
#
# if [ $STATUS -eq $SUCCESS ]; then
#   # true
#   # notify admin | user
# else
#   # false
#   # return $NOT_SUCCESS
#   # or
#   # exit 128
# fi
#
function __gen_vala_code() {
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	local PROJECT_HOME="${VALA_PROJECT[PATH]}/${VALA_PROJECT[NAME]}"
	local VALA_CODE="$PROJECT_HOME/${VALA_PROJECT[CODE]}"
	if [ "$TOOL_DBG" == "true" ]; then
		MSG="Checking [$VALA_CODE]"
		printf "$DQUE" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
    if [ -f "$VALA_CODE" ]; then
        printf "%s\n" "[already exist]"
		MSG="[$VALA_PROJECT[NAME]] $VALA_CODE already exist"
		if [ "${configvalagen[LOGGING]}" == "true" ]; then
			VALAGEN_LOG[LOG_MSGE]=$MSG
			VALAGEN_LOG[LOG_FLAG]="error"
			__logging VALAGEN_LOG
		fi
        return $NOT_SUCCESS
    fi
    local DATE=$(date)
    if [ "$TOOL_DBG" == "true" ]; then
		printf "%s\n" "[not exist]"
		MSG="Generating [$VALA_CODE]"
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
	fi
	local VALA_CODE_FILE="
/**
 * Automatic generated ${VALA_PROJECT[NAME]}.vala
 * Powered by $TOOL_FROM_COMPANY 
 * $DATE
 * Project ${VALA_PROJECT[NAME]}
 */
public class ${VALA_PROJECT[NAME]} : Gtk.Application {
    protected override void activate () {
        var window = new Gtk.ApplicationWindow (this);
        var label = new Gtk.Label (\"Simple test!\");
        window.add (label);
        window.set_title (\"Welcome to GNOME\");
        window.set_default_size (200, 100);
        window.show_all ();
    }
}

public int main (string[] args) {
    return new ${VALA_PROJECT[NAME]} ().run (args);
}
"
	echo -e "$VALA_CODE_FILE" > "$VALA_CODE"
	if [ "$TOOL_DBG" == "true" ]; then
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set owner [$VALA_CODE]"
	fi
	local PRFX_CMD="chown"
	local OWNER="${configvalagenutil[USER]}.${configvalagenutil[GROUP]}"
	eval "$PRFX_CMD $OWNER $VALA_CODE"
	if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "Set permission [$VALA_CODE]"
	fi
    chmod 700 "$VALA_CODE"
    if [ "$TOOL_DBG" == "true" ]; then            
		printf "$DEND" "$VALAGEN_TOOL" "$FUNC" "Done"
	fi
	MSG="[$VALA_PROJECT[NAME]] Generated $VALA_CODE"
	if [ "${configvalagen[LOGGING]}" == "true" ]; then
		VALAGEN_LOG[LOG_MSGE]=$MSG
		VALAGEN_LOG[LOG_FLAG]="info"
		__logging VALAGEN_LOG
	fi
    return $SUCCESS
}

#
# @brief   Main function 
# @param   None
# @exitval Function __valagen exit with integer value
#			0   - tool finished with success operation 
#			128 - missing argument(s) from cli 
#			129 - provided wrong argument (check dir)
#			130 - failed to load tool script configuration from file 
#			131 - failed to load tool script utilities configuration from file
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __valagen 
#
function __valagen() {
	local FUNC=${FUNCNAME[0]}
	local MSG="None"
	if [ "${VALA_PROJECT[NAME]}" != "None" ] && 
	   [ "${VALA_PROJECT[PATH]}" != "None" ] &&
	   [ "${VALA_PROJECT[COMMENT]}" != "None" ]; then
		if [ -n "${VALA_PROJECT[NAME]}" ] &&
		   [ -n "${VALA_PROJECT[PATH]}" ] &&
           [ -n "${VALA_PROJECT[COMMENT]}" ]; then
			MSG="Loading basic and util configuration"
			printf "$SEND" "$VALAGEN_TOOL" "$MSG"
			__progressbar PB_STRUCTURE
			printf "%s\n\n" ""
			declare -A configvalagen=()
			__loadconf $VALAGEN_CFG configvalagen
			local STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				MSG="Failed to load tool script configuration"
				if [ "$TOOL_DBG" == "true" ]; then
					printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
				else
					printf "$SEND" "$VALAGEN_TOOL" "$MSG"
				fi
				exit 130
			fi
			declare -A configvalagenutil=()
			__loadutilconf $VALAGEN_UTIL_CFG configvalagenutil
			STATUS=$?
			if [ $STATUS -eq $NOT_SUCCESS ]; then
				MSG="Failed to load tool script utilities configuration"
				if [ "$TOOL_DBG" == "true" ]; then
					printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
				else
					printf "$SEND" "$VALAGEN_TOOL" "$MSG"
				fi
				exit 131
			fi
			MSG="Generating new Vala project [${VALA_PROJECT[NAME]}]"
			if [ "${configvalagen[LOGGING]}" == "true" ]; then
				VALAGEN_LOG[LOG_MSGE]=$MSG
				VALAGEN_LOG[LOG_FLAG]="info"
				__logging VALAGEN_LOG
			fi
		   	if [ "$TOOL_DBG" == "true" ]; then
				MSG="Checking dir [${VALA_PROJECT[PATH]}/]"
				printf "$DQUE" "$VALAGEN_TOOL" "$FUNC" "$MSG"
		   	fi
			if [ -d "${VALA_PROJECT[PATH]}/" ]; then
				printf "%s\n" "[ok]"
				local PROJECT_HOME="${VALA_PROJECT[PATH]}/${VALA_PROJECT[NAME]}"
				if [ "$TOOL_DBG" == "true" ]; then
					MSG="Creating dir [$PROJECT_HOME]"
					printf "$DSTA" "$UTIL_ADDNEWTOOL" "$FUNC" "$MSG"
				fi
				mkdir "$PROJECT_HOME/"
				if [ "$TOOL_DBG" == "true" ]; then
					MSG="Set owner [$PROJECT_HOME/]"
					printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
				fi
				local PRFX_CMD="chown"
				local OWNER="${configvalagenutil[USER]}.${configvalagenutil[GROUP]}"
				eval "$PRFX_CMD $OWNER $PROJECT_HOME/"
				if [ "$TOOL_DBG" == "true" ]; then
					MSG="Set permission [$PROJECT_HOME/]"
					printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
				fi
				chmod 700 "$PROJECT_HOME/"
				__gen_autogen_sh
				local STATUS=$?
				if [ $STATUS -eq $SUCCESS ]; then
					__gen_configure_ac
					STATUS=$?
					if [ $STATUS -eq $SUCCESS ]; then
						__gen_desktop_in
						STATUS=$?
						if [ $STATUS -eq $SUCCESS ]; then
							__gen_makefile_am
							STATUS=$?
							if [ $STATUS -eq $SUCCESS ]; then
								__gen_readme
								STATUS=$?
								if [ $STATUS -eq $SUCCESS ]; then
									VALA_PROJECT[CODE]="${VALA_PROJECT[NAME]}.vala"
									__gen_vala_code
									STATUS=$?
									if [ $STATUS -eq $SUCCESS ]; then
										if [ "$TOOL_DBG" == "true" ]; then
											printf "$DEND" "$VALAGEN_TOOL" "$FUNC" "Done"
										fi
										exit 0
									fi
								fi
							fi
						fi
					fi
				fi
			fi
			if [ "$TOOL_DBG" == "true" ]; then
				printf "%s\n" "[not exist]"
				MSG="Generate [${VALA_PROJECT[PATH]}/]"
				printf "$DSTA" "$VALAGEN_TOOL" "$FUNC" "$MSG"
			fi
			MSG="[$VALA_PROJECT[NAME]] [${VALA_PROJECT[PATH]}/ does not exist"
			if [ "${configvalagen[LOGGING]}" == "true" ]; then
				VALAGEN_LOG[MSG]=$MSG
				VALAGEN_LOG[FLAG]="error"
				__logging VALAGEN_LOG
			fi
			exit 129
		fi
	fi
	__usage VALAGEN_USAGE
	exit 128
}

#
# @brief   Main entry point
# @params  Values required project name, project path and comment
# @exitval Script tool valagen exit with integer value
#			0   - tool finished with success operation 
#			127 - run tool script as root user from cli
#			128 - missing argument(s) from cli 
#			129 - provided wrong argument (check dir)
#			130 - failed to load tool script configuration from file 
#			131 - failed to load tool script utilities configuration from file
#
VALA_PROJECT[NAME]="$1"
VALA_PROJECT[PATH]="$2"
VALA_PROJECT[COMMENT]="$3"

printf "\n%s\n%s\n\n" "$VALAGEN_TOOL $VALAGEN_VERSION" "`date`"
__checkroot
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__valagen
fi

exit 127

