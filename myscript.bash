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
