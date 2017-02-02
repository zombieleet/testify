#!/usr/bin/env bash

open="\e["
close="\e[0m"
bold="1;"
light="0;"
red="31m"
green="32m"
yellow="33m"

function assert() {
    local subcom="${1}"

    # take out the first argument which is  subcom from ${@} 
    shift
    
    (( ${#@} <  2 )) && {
	printf "%s\n" "Need at least 2 argument to equal but got ${#@}"
	exit 0;
    }
    

    local message="${3}"
    
    printf "\n"
    [[ ! -z "${message}" ]] && {
	printf "\t\t${open}${light}${yellow}%s${close}\n\n" "${message}"
	
    }
	    
    case $subcom in
	expect)
	    local actual="${1}"
	    local expected="${2}"
	    [[ "${actual}" != "${expected}" ]] && {
		printf \
		    "${open}${light}${red}%s${close}\n" \
		    "Failure: \"${actual}\" does not equal \"${expected}\" "	
	    } || {
		printf \
		    "${open}${light}${green}%s${close}\n" \
		    "Success: \"${actual}\" equals \"${expected}\" "
	    }
	;;
	regex)
	    
	    local actual="${1}"
	    local regexp="${2}"

	    [[ ! "${actual}" =~ "${regexp}" ]] && {
		
		printf \
		    "${open}${light}${red}%s${close}\n" \
		    "Failure: \"${actual}\" does not match \"${regexp}\" "		
	    } || {
		
		printf \
		    "${open}${light}${green}%s${close}\n" \
		    "Success: \"${actual}\" matches \"${regexp}\" "
		
	    }
	    
	;;
	status)

	    local com="${1}"
	    local expectedStatus="${2}"

	    source ./utils.bash

	    expectedStatus=$(int "${expectedStatus}")
	    status=$?
	    
	    (( status == 0 )) && {
		#${com}
		declare -F ${com} &>/dev/null
		
		[[ $? == 0 ]] && {
		    
		    ${com} &>/dev/null
		    status=$?
		    
		    [[ "${status}" != "${expectedStatus}" ]] && {
			printf \
			    "${open}${light}${red}%s${close}\n" \
			    "Failure: return code for \"${com}\" is not \"${expectedStatus}\" "
		    } || {
			printf \
			    "${open}${light}${green}%s${close}\n" \
			    "Success: return code for \"${com}\" is \"${expectedStatus}\" "		    
		    }
		    
		}  || {
		    
		    printf "${open}${light}${red}%s${close}\n" "Cannot run this test"
		}
		
	    } || {
		printf "${open}${light}${red}%s${close}\n" "Cannot run this test"
	    }
	    
	    
    esac
}
s() {
    echo "hi"
    return 3
}
d() {
    echo "Hello World"
}
assert expect "victory" "victory" "Test Case to Check if Favour equals Victory"
assert expect "$(s)" "$(d)" "Check function output"
assert status s "3" "Check return status"
assert regex  "victory" ".*y" "Test Regex"
