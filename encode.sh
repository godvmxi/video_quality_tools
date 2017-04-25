#!/bin/sh

HEIGHT="null"
WIDTH="default"
SRC_YUV=
DEST_DIR=
MAX_QP=
MIN_QP=
BR_LIST=

read_para_from_file(){
	#cat $1 | while read line 
	lines=`cat $1`
	while read line 
	do
		echo $line
		t_name=`echo $line |awk -F ' ' '{print $1}'`
		t_value=`echo $line |awk -F ' ' '{print $2}'`
		echo "k-v :$t_name -> $t_value"
		if [ $t_name = "width" ] ; then
			echo "1 ->"$WIDTH
			WIDTH=$t_value
			echo "1 ->"$WIDTH
			continue
		fi
		if [ $t_name = "height" ] ; then
			echo "2 ->"$HEIGHT
			HEIGHT=$t_value
			echo "2 ->"$HEIGHT
			continue
		fi
		if [ $t_name = "src_yuv" ] ; then
			SRC_YUV=$t_value
			echo "3 ->"$SRC_YUV
			continue
		fi
		if [ $t_name = "dest_dir" ] ; then
			DEST_DIR=$t_value
			echo "4"
			continue
		fi
		if [ $t_name = "max_qp" ] ; then
			MIN_QP=$t_value
			echo "5"
			continue
		fi
		if [ $t_name = "min_qp" ] ; then
			MAX_QP=$t_value
			echo "6"
			continue
		fi
		if [ $t_name = "br_list" ] ; then
			BR_LIST=$t_value
			echo "7"
			continue
		fi
		echo "get nothing -> "$line
	done  < $1
}
show_global_para(){
	echo "show global var ->"
	echo "WIDTH -> $WIDTH"
	echo "HEIGHT -> $HEIGHT"
	echo "SRC_YUV -> $SRC_YUV"
	echo "DEST_DIR -> $DEST_DIR"
	echo "MAX_QP -> $MAX_QP"
	echo "MIN_QP -> $MIN_QP"
	echo "BR_LIST -> $BR_LIST"
}

read_para_from_file $1
show_global_para
