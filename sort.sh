#!/bin/bash


arr=($1)
n=${#arr[*]}

for (( i = n-1; i >= 0; i-- ))
do
    echo -n "${arr[i]} "
done


