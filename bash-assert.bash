#!/usr/bin/env bash

open="\e["
close="\e[0m"
bold="1;"
light="0;"
red="31m"
green="32m"
yellow="33m"
lightGrey="37m"

declare -i fails=0
declare -i succ=0

function failure() {
    
    printf "\t\t${open}${bold}${red}%b${close}" "\u2716"
    printf "${open}${light}${lightGrey}  %s${close}\n" "Failure: ${message} "
    fails=$((fails + 1))
    
}
function success() {
    
    printf "\t\t${open}${bold}${green}%b${close}" "\u2714"
    printf "${open}${light}${lightGrey}  %s${close}\n" "Success: ${message} "
    succ=$((succ + 1))
}
function assert() {
    local subcom="${1}"

    # take out the first argument which is  subcom from ${@} 
    shift

    if [[ "$subcom" != "done" ]];then
	
	(( ${#@} <  2 )) && {
	    printf "%s\n" "Need at least 2 argument but got ${#@}"
	    exit 0;
	}
	
    fi
    

    local describe="${3}"
    local message="${4}"
    
    printf "\n"
    [[ ! -z "${describe}" ]] && {
	printf "\t${open}${light}${yellow}%s${close}\n\n" "${describe}"
	
    }
    
    case $subcom in
	expect)
	    local actual="${1}"
	    local expected="${2}"
	    
	    [[ "${actual}" != "${expected}" ]] && {
		failure "${message}"
	    } || {	
		success "${message}"
	    }
	    
	    ;;
	regex)
	    
	    local actual="${1}"
	    local regexp="${2}"

	    
	    [[ ! "${actual}" =~ ${regexp} ]] && {	
		failure "${message}"
	    } || {
		success "${message}"
	    }
	    
	    
	;;
	status)

	    local com="${1}"
	    local expectedStatus="${2}"

	    source ./utils.bash

	    expectedStatus=$(int "${expectedStatus}")
	    status=$?
	    
	    (( status == 0 )) && {

		declare -F ${com} &>/dev/null
		
		[[ $? == 0 ]] && {
		    
		    ${com} &>/dev/null
		    status=$?
		    
		    [[ "${status}" != "${expectedStatus}" ]] && {
			failure "${message}"
		    } || {
			success "${message}"
		    }
		    
		}  || {
		    
		    printf "\t\t\t${open}${light}${red}%s${close}\n" "Cannot run this test"
		}
		
	    } || {
		printf "\t\t\t${open}${light}${red}%s${close}\n" "Cannot run this test"
	    }
	    
	    ;;
	\done)
	    printf "\n\n"
	    printf "\t${open}${light}${red}%s %d${close}\n" "Fails: " "${fails}"
	    printf "\t${open}${light}${green}%s %d${close}\n" "Success: " "${succ}"
	    exit 0
    esac
}

