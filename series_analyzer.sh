#!/bin/bash


###########↓yoni↓###########

#validation


validate_series(){

	local a="$1"
	local result=true
	local ret_status=0
	local int_re="^[+]?([1-9][0-9]*|0)$"

		   
	if [[ ! "${a[@]}" =~ $int_re ]]; then
	    result=false
	fi
		    
	echo "$result"
	    
}

function get_array()
{
	local -n arr="$1"
	local input_arr=()
	local ret_status=0
	
	if [[ "${#arr[@]}" -eq 0 ]]; then
		read -p "Enter a series (atleast 3 positive numbers separated by spaces): " input_arr
		arr+=${input_arr}
	fi
		
	
	return $ret_status
}

--------------------------------------------------------------
sort() {

local arr=($1)
local n=${#arr[*]}

for (( i = n-1; i >= 0; i-- ))
do
    echo -n "${arr[i]} "
done

}

------------------------------------------------------------


disply() {


local arr=($1)
echo ${arr[*]}

}

-------------------------------------------------------------


####################################
###########↓saw↓###########



####################################
###########↓israel↓###########

function input_series()
{
	local -n input_series_series="$1"	# avoid circular name reference (don't give the series the same name sent)
	local input_series=()
	local ret_status=0
	
	input_series_series=()
	read -p "Enter a series (atleast 3 positive numbers separated by spaces): " input_series
	input_series_series+=${input_series}
	
	# TODO: validate series - validate_series
	# if validation not good change return status - validate_series series
	if [[ "" ]]; then
		echo -n ""
	fi
	
	return $ret_status
}

function get_series()
{
	local -n get_series_series="$1"		# avoid circular name reference (don't give the series the same name sent)
	local ret_status=0
	
	if [[ "${#get_series_series[@]}" -eq 0 ]]; then
		input_series get_series_series
	fi
		
	# TODO: validate series - validate_series
	# if validation not good change return status - validate_series series
	if [[ "" ]]; then
		echo -n ""
	fi
	
	return $ret_status
}

function series_length()
{
	local ret_status=0
	local series_length_series="$1"	# avoid circular name reference (don't give the series the same name sent)
	
	echo "The series length is: ${#get_series_series[@]}"
	
	return $ret_status
}

####################################
###########↓inna↓###########



####################################
###########↓israel↓###########


function menu()
{
	local keep_running_flag=true
	local exit_option="Exit"
	local ret_status=1							# successful return status (0) only when exit option is chosen from menu
	local result=0
	local series=(${@})
	
	local options=("Input a Series" "Display series" "Display sorted series" "Display max value of series" "Display min value of series" "Display average value of series" "Display number of elements in the series" "Display series' sum")
	local options+=("$exit_option")
	local operations=("input_series" "display_series" "sorted_series" "series_max_val" "series_min_val" "series_avg_val" "num_of_elements" "siries_sum")
	local operations+=('exit')
	
	# get the array via input / sent parameters
	get_series series
	echo "${series[@]}"
	
	while [[ "$keep_running_flag" == true ]]; do
		# menu presentation
		echo "Choose an item:"
		for (( i=0 ; i < ${#operations[@]} ; i++ )) do
			echo -e "\t$(($i + 1))) ${operations[i]}"
		done
		
		# menu choice
		read -p "Choice: " choice
		if [[ "$choice" == [1-${#operations[@]}] ]]; then
			echo "Option chosen: ${options[choice - 1]}"

			if [[ "${options[choice - 1]}" == "$exit_option" ]]; then	# exit condition
				keep_running_flag=false
				ret_status=0						# successful return status (0)
			else								# operations
				# operands validation
				${operations[choice - 1]} series
			fi
		else
			echo "Error - no such option."  >> /dev/stderr
		fi
		echo -e "\n#################################################\n"
	done
	
	return $ret_status
}


function main()
{
	menu "${@}"
	local ret_status="$?"

	exit "$ret_status"
}


# in case of running as a script
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "${@}"
fi

