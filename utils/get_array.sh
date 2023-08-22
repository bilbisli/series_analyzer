#! /bin/bash


function get_array()
{
	local -n arr="$1"
	local input_arr=()
	local ret_status=0
	
	if [[ "${#arr[@]}" -eq 0 ]]; then
		read -p "Enter a series (atleast 3 positive numbers separated by spaces): " input_arr
		arr+=${input_arr}
	fi
		
	# TODO: validate arr
	# if validation not good change return status
	
	return $ret_status
}

function main()
{
	local outside_arr=(${@})
	get_array outside_arr
	local ret_status="$?"
	
	echo "(${outside_arr[@]})" 
	
	exit "$ret_status"
}


# in case of running as a script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi

