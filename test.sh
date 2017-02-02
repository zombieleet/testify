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
assert expect "$((2+2))" "4" "Test for Simple Math Operation" "It should succeed"
assert regex "What is the difference between 6 and half a dozen" "[[:digit:]]" "Match Number Regular Expression" "It should succeed"
assert status "ls ." "0" "List in current dir" "it should return 0"
assert done
