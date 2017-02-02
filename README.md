# bash-assert

testify is a lightweight unit testing framework for bash

# Usage

clone this repository `git clone https://github.com/zombieleet/testify.git`

create a test file then source testify.bash and the script you want to test in the test file


```bash
	# myscript.bash
	function Name() {
		fName="$1"
		lName="$2"

		if [[ -z "$fName" ]];then
			return 5
		fi
	
		if [[ -z "$lName" ]];then
			return 3
		fi

		echo "$fName $lName"
		return 0
	}


```


```bash
	# test.bash
	source ./myscript.bash
	source ./testify.bash
	assert expect "$(Name 'Jane' 'Doe')" "John Doe" "Test for Name Function" "should fail"
	assert expect "$(Name 'Jane' 'Doe')" "Jane Doe" "Test for Name Function" "should succeed"
	assert status "Name" "5" "Test for status code" "should return 5"
	assert status "Name 'Jane' 'Doe'" "0" "Test for Status Code" "should return 0"
	assert status "Name 'Jane' " "3" "Test for Status Code" "should return 3"
	assert status "Name 'Jane' 'Doe'" "12" "Test for Status Code" "it should fail"
	assert regex "$(Name 'Jane' 'Doe')" "Jane" "Test for Regexp" "it should match"
	assert regex "123victory" "\W" "Test for Regexp Non Word Character" "it should fail if match failes"
	assert done


	
```

# Commands

all subcommands to the assert functions requres 4 arguments, the first argument is the actual value to test for, while the second argument 
is the expected value, the thrid argument is a description of the test , while the fourth argument is a short description of what the test output should be

**expect** Compares two values
       
 	`assert expect "$(Name 'Jane' 'Doe')" "John Doe" "Test for Name Function" "should fail"`
	
	To test the output of a function you have to use command substitution

	You can also test single values

	`assert expect "victory" "favour" "Test for Name comparison" "This should fail"`
	
	testing for mathematical expressions
	
	`assert expect "$((2+2))" "4" "Test for Simple Math Operation" "It should succeed"`
	

**regex** Does a regular expression match. The second argument to this subcommand should be a regular expression

	`assert regex "What is the difference between 6 and half a dozen" "[[:digit:]]" "Match Number Regular Expression" "It should succeed"`


**status** Test for any status code. The second argument should be the expected status code. The first argument to this subcommand should be a command name, and it should not be passed as a command substitution but it should be passed as just a string wrapped in double quotes.
The arguments to the function should also be in the double quotes. Arguments with spaced should be wrapped in single quotes

	`assert status "ls ." "0" "List in current dir" "it should return 0"`

**done** This should be last subcommand to call, it does not require any argument


# LICENSE

GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or  (at your option) any later version.


