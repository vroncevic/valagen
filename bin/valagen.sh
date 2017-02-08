#!/bin/bash
#
# @brief   Generate Vala Project
# @version ver.1.0
# @date    Thu Jan 14 22:26:32 2016
# @company Frobas IT Department, www.frobas.com 2016
# @author  Vladimir Roncevic <vladimir.roncevic@frobas.com>
#
UTIL_ROOT=/root/scripts
UTIL_VERSION=ver.1.0
UTIL=${UTIL_ROOT}/sh_util/${UTIL_VERSION}
UTIL_LOG=${UTIL}/log

.	${UTIL}/bin/devel.sh
.	${UTIL}/bin/usage.sh
.	${UTIL}/bin/check_root.sh
.	${UTIL}/bin/check_tool.sh
.	${UTIL}/bin/logging.sh
.	${UTIL}/bin/load_conf.sh
.	${UTIL}/bin/load_util_conf.sh
.	${UTIL}/bin/progress_bar.sh

VALAGEN_TOOL=valagen
VALAGEN_VERSION=ver.1.0
VALAGEN_HOME=${UTIL_ROOT}/${VALAGEN_TOOL}/${VALAGEN_VERSION}
VALAGEN_CFG=${VALAGEN_HOME}/conf/${VALAGEN_TOOL}.cfg
VALAGEN_UTIL_CFG=${VALAGEN_HOME}/conf/${VALAGEN_TOOL}_util.cfg
VALAGEN_LOG=${VALAGEN_HOME}/log

declare -A VALAGEN_USAGE=(
	[USAGE_TOOL]="__${VALAGEN_TOOL}"
	[USAGE_ARG1]="[PROJECT_NAME] Name of project"
	[USAGE_ARG2]="[PROJECT_PATH] Project root folder"
	[USAGE_ARG3]="[COMMENT] Short description"
	[USAGE_EX_PRE]="# Generating vala project"
	[USAGE_EX]="__${VALAGEN_TOOL} ftool /opt/ \"Font generator\""
)

declare -A VALAGEN_LOGGING=(
	[LOG_TOOL]="${VALAGEN_TOOL}"
	[LOG_FLAG]="info"
	[LOG_PATH]="${VALAGEN_LOG}"
	[LOG_MSGE]="None"
)

declare -A PB_STRUCTURE=(
	[BW]=50
	[MP]=100
	[SLEEP]=0.01
)

TOOL_DBG="false"
TOOL_LOG="false"
TOOL_NOTIFY="false"

declare -A VPROJECT=(
	[NAME]="None"
	[PATH]="None"
	[AUTOGEN]="autogen.sh"
	[CONFIGURE]="configure.ac"
	[DESKTOP]="desktop.in"
	[MAKEFILE]="Makefile.am"
	[README]="README"
	[COMMENT]="None"
	[CODE]="None"
)

#
# @brief   Main function 
# @param   None
# @exitval Function __valagen exit with integer value
#			0   - tool finished with success operation
#			128 - missing argument(s) from cli
#			129 - failed to load tool script configuration from files
#			130 - failed to load project set configuration from file
#			131 - missing target directory
#
# @usage
# @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#
# __valagen
#
function __valagen() {
	local FUNC=${FUNCNAME[0]} MSG="None" STATUS
	declare -A VPROJECT_STRUCT=(
		[1]="${VPROJECT[NAME]}" [2]="${VPROJECT[PATH]}"
		[3]="${VPROJECT[COMMENT]}" [4]="${VPROJECT[CODE]}"
	)
	__check_strings VPROJECT_STRUCT
	STATUS=$?
	if [ $STATUS -eq $SUCCESS ]; then
		local FUNC=${FUNCNAME[0]} MSG="None" STATUS_CONF STATUS_CONF_UTIL
		MSG="Loading basic and util configuration!"
		__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
		__progress_bar PB_STRUCTURE
		declare -A config_valagen=()
		__load_conf "$VALAGEN_CFG" config_valagen
		STATUS_CONF=$?
		declare -A config_valagen_util=()
		__load_util_conf "$VALAGEN_UTIL_CFG" config_valagen_util
		STATUS_CONF_UTIL=$?
		declare -A STATUS_STRUCTURE=(
			[1]=$STATUS_CONF [2]=$STATUS_CONF_UTIL
		)
		__check_status STATUS_STRUCTURE
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$VALAGEN_TOOL"
			exit 129
		fi
		TOOL_LOG=${config_valagen[LOGGING]}
		TOOL_DBG=${config_valagen[DEBUGGING]}
		TOOL_NOTIFY=${config_valagen[EMAILING]}
		local PROJECT_SET=${config_valagen_util[PROJECT_SET]}
		declare -A project_set=()
		__load_util_conf "${VALAGEN_HOME}/conf/${PROJECT_SET}" project_set
		STATUS=$?
		if [ $STATUS -eq $NOT_SUCCESS ]; then
			MSG="Force exit!"
			__info_debug_message_end "$MSG" "$FUNC" "$VALAGEN_TOOL"
			exit 130
		fi
		MSG="Generating project structure!"
		__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
		MSG="Checking directory [${VPROJECT[PATH]}/]?"
		__info_debug_message_que "$MSG" "$FUNC" "$VALAGEN_TOOL"
		if [ -d "${VPROJECT[PATH]}/" ]; then
			MSG="[ok]"
			__info_debug_message_ans "$MSG" "$FUNC" "$VALAGEN_TOOL"
			local PHOME="${VPROJECT[PATH]}/${VPROJECT[NAME]}"
			MSG="Generating directory [${PHOME}/]"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			mkdir "${PHOME}/"
			local AUTHOR_NAME=${config_valagen_util[AUTHOR_NAME]} DATE=`date`
			local AUTHOR_EMAIL=${config_valagen_util[AUTHOR_EMAIL]} AL
			local ASHT=${project_set[AUTOGEN_SH]} HASH="#" BSLASH="\\"
			local ASHF="${PHOME}/${VPROJECT[AUTOGEN]}" TAB="	" TREE
			local ASHTF="${VALAGEN_HOME}/conf/${ASHT}"
			MSG="Generating file [${ASHF}]"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			while read AL
			do
				eval echo "${AL}" >> ${ASHF}
			done < ${ASHTF}
			local CT=${project_set[CONFIGURE_AC]}
			local CF="${PHOME}/${VPROJECT[CONFIGURE]}" CL
			local CTF="${VALAGEN_HOME}/conf/${CT}"
			MSG="Generating file [${CF}]"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			while read CL
			do
				eval echo "${CL}" >> ${CF}
			done < ${CTF}
			local DT=${project_set[DESKTOP_IN]}
			local DF="${PHOME}/${VPROJECT[NAME]}.${VPROJECT[DESKTOP]}" DL
			local DTF="${VALAGEN_HOME}/conf/${DT}"
			MSG="Generating file [${DF}]"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			while read DL
			do
				eval echo "${DL}" >> ${DF}
			done < ${DTF}
			local MSF="${PHOME}/${VPROJECT[MAKEFILE]}"
			local MST=${project_set[MAKEFILE_AMS]}
			local MSTF="${VALAGEN_HOME}/conf/${MST}" MSL
			MSG="Generating file [${MSF}]"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			while read MSL
			do
				eval echo "${MSL}" >> ${MSF}
			done < ${MSTF}
			local VT=${project_set[V_SOURCE]} VF="${PHOME}/${VPROJECT[CODE]}"
			local VTF="${VALAGEN_HOME}/conf/${VT}" VL
			MSG="Generating file [${VF}]"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			while read VL
			do
				eval echo "${VL}" >> ${VF}
			done < ${VTF}
			local RT=${project_set[README]} RF="${PHOME}/${VPROJECT[README]}"
			local RTF="${VALAGEN_HOME}/conf/${RT}" RL
			MSG="Generating file [${RF}]"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			while read RL
			do
				eval echo "${RL}" >> ${RF}
			done < ${RTF}
			MSG="Set owner!"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			local USRID=${config_valagen_util[GID]}
			local GRPID=${config_valagen_util[UID]}
			eval "chown -R ${USRID}.${GRPID} ${PHOME}/"
			MSG="Set permission!"
			__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
			eval "chmod -R 700 ${PHOME}/"
			__info_debug_message_end "Done" "$FUNC" "$VALAGEN_TOOL"
			TREE=$(which tree)
			__check_tool "${TREE}"
			STATUS=$?
			if [ $STATUS -eq $SUCCESS ]; then
				eval "${TREE} -L 3 ${PHOME}/"
			fi
			exit 0
		fi
		MSG="[not ok]"
		__info_debug_message_ans "$MSG" "$FUNC" "$VALAGEN_TOOL"
		MSG="Generate directory [${VPROJECT[PATH]}/]"
		__info_debug_message "$MSG" "$FUNC" "$VALAGEN_TOOL"
		MSG="Force exit!"
		__info_debug_message_end "$MSG" "$FUNC" "$VALAGEN_TOOL"
		exit 131
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
#			129 - failed to load tool script configuration from files
#			130 - failed to load project set configuration from file
#			131 - missing target directory
#
VPROJECT[NAME]="$1"
VPROJECT[PATH]="$2"
VPROJECT[COMMENT]="$3"
VPROJECT[CODE]="${1}.vala"

printf "\n%s\n%s\n\n" "${VALAGEN_TOOL} ${VALAGEN_VERSION}" "`date`"
__check_root
STATUS=$?
if [ $STATUS -eq $SUCCESS ]; then
	__valagen
fi

exit 127

