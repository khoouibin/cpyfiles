## cp_files filename num_start num_end

if (($# < 3)) 
then
	echo " e.g.:  ./cp_files <filename_path> <num_start> <num_end>"
	exit 1;
fi

arg_filename_en=0
arg_num_range_en=0
i_num_start=0
i_num_end=0
str_filename=''
re='^[0-9]+$'

for arg in "$@"; do
	concatenated+="$arg "
done
echo "input arguments:  $concatenated"

for file in *
do
	if [ "$1" = $file ]
	then
		echo "$file... path is found"
		arg_filename_en=1
		str_filename=$1
	fi
done

if [[ $2 =~ $re ]] ; then
	i_num_start=$(($2))
else
	echo "$2 :not a integer num" >&2
fi

if [[ $3 =~ $re ]] ; then
	i_num_end=$(($3))
else
	echo "$3 :not a integer num" >&2
fi

if [[ $i_num_end -gt $i_num_start ]] ; then
	arg_num_range_en=1
else
	echo "$i_num_end < $i_num_start (illegal num range)" >&2
fi

if [[ $arg_num_range_en -eq 1 ]] ; then
	echo "start cp..."
	for i in $(seq -f "%04g" $i_num_start $i_num_end)
	do
		printf "%s_\n" "$i" | xargs -r -I PFX cp ${str_filename} PFX${str_filename:0}
		printf "%s_\n" "$i" | xargs -r -I PFX echo "new file name: " PFX${str_filename:0}
	done

fi

echo "end of cp files"
exit 1;

