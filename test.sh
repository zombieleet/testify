source ./assert-unit.bash
s() {
    echo "hi"
    return 3
}
d() {
    echo "Hello World"
}
assert expect "victory" "victory" "Test Case to Check if Favour equals Victory" "it succeeds"
assert expect "$(s)" "$(d)" "Check function output" "it fails"
assert status s "3" "Check return status" "it returns 3"
assert regex  "victory" "[[:alpha:]]" "Test Regex" "match regex"
assert done
