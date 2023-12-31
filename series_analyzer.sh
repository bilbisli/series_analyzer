#!/bin/bash


###########↓yoni↓###########

#validation


function validate_series()
{
	local MIN_SERIES_SIZE=3
	local -n a="$1"
	local result=true
	local ret_status=0
	local int_re="^[+]?([1-9][0-9]*|0)$"

	if [[ "${#a[@]}" -lt "$MIN_SERIES_SIZE" ]]; then
		result=false
	else
		for (( i=0 ; i < ${#a[@]} && result == true; i++ )) do
			if [[ ! "${a[i]}" =~ $int_re ]]; then
			    result=false
			fi
		done
	fi
		    
	echo "$result"
	    
}


#--------------------------------------------------------------
function sort_series()
{
    local -n arr="$1"
    echo "${arr[@]}" | tr " " "\n" | sort -n | tr "\n" " "
}

#------------------------------------------------------------


function display()
{
	local -n arr="$1"
	echo ${arr[*]}
}

#-------------------------------------------------------------


####################################
###########↓saw↓###########
function average()
{
	local -n num_arr="$1"
	local ret_status=0
	for number in "${num_arr[@]}"; do
   	 	sum=$((sum + number))
	done
	
	(( avg = $sum / ${#num_arr[@]}))
	echo "The average is : $avg"
	
	return $ret_status
}


function series_sum()
{
	local -n num_arr="$1"
	local ret_status=0	
	
	for number in "${num_arr[@]}"; do
   	 	sum=$((sum + number))
	done
	
	echo "The sum is : $sum"
	
	return $ret_status
}


####################################
###########↓israel↓###########

function input_series()
{
	local -n input_series_series="$1"	# avoid circular name reference (don't give the series the same name sent)
	local input_series=()
	local ret_status=0
	local valid_series=false
	
	while [[ "$valid_series" == false ]]; do
		input_series_series=()
		read -p "Enter a series (atleast 3 positive numbers separated by spaces): " input_series
		input_series_series+=(${input_series[@]})
		valid_series=$(validate_series input_series_series)
		if [[ "$valid_series" == false ]]; then
			echo "Error : invalid series" >> /dev/stderr
		fi
	done
	
	return $ret_status
}

function get_series()
{
	local -n get_series_series="$1"		# avoid circular name reference (don't give the series the same name sent)
	local ret_status=0
	local val_result=false
	
	if [[ "${#get_series_series[@]}" -eq 0 ]]; then
		input_series get_series_series
	fi

	if [[ "`validate_series get_series_series`" == false ]]; then
		echo "Error : invalid series" >> /dev/stderr
		input_series get_series_series
	fi
	
	return $ret_status
}

function series_length()
{
	local ret_status=0
	local -n series_length_series="$1"		# avoid circular name reference (don't give the series the same name sent)
	
	echo "The series length is: ${#series_length_series[@]}"
	
	return $ret_status
}

####################################
###########↓inna↓###########
 function max()
 {
 
	 local -n arr="$1"
	 local max_val=${arr[0]}
	 
	 for n in "${arr[@]}" ; do
	 	if [[ "$n" -gt "$max_val" ]]; then
			max_val=$n
		fi
	 done
	 
	 echo "The maximum value is: $max_val"
}
		 
function min()
{
	local -n arr="$1"
	local min_val=${arr[0]}
	
	for n in "${arr[@]}" ; do
		if [[ "$n" -lt "$min_val" ]]; then
			min_val=$n
		fi
	done 
	
	echo "The minimum value is: $min_val"
}


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
	local operations=("input_series" "display" "sort_series" "max" "min" "average" "series_length" "series_sum")
	local operations+=('exit')
	
	# get the array via input / sent parameters
	get_series series
	
	while [[ "$keep_running_flag" == true ]]; do
		# menu presentation
		echo "Choose an item:"
		for (( i=0 ; i < ${#operations[@]} ; i++ )) do
			echo -e "\t$(($i + 1))) ${options[i]}"
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

