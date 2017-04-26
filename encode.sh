#!/bin/sh

HEIGHT="null"
WIDTH="default"
SRC_YUV=
DEST_DIR=
MAX_QP=
MIN_QP=
BR_LIST=
START_FRAME=0
END_FRAME=9
PC_MODE=0

SH_DIR=$(cd `dirname $0`; pwd)
echo "curent scipt dir -> $SH_DIR"
#evb testbench
H2V4=/nfs/bin/testbench_hevc_v8
H2V1=/nfs/bin/testbench_hevc_v1
H1V6=/nfs/bin/testbench_h1v6_264

H1V6_C_MODEL=$SH_DIR/c_model/h264_testenc_v6
H2V1_C_MODEL=$SH_DIR/c_model/
H2V4_C_MODEL=$SH_DIR/c_model/hevc_testenc_v4

read_para_from_file(){
	#cat $1 | while read line 
	lines=`cat $1`
	while read line 
	do
		#echo $line
		t_name=`echo $line |awk -F ' ' '{print $1}'`
		t_value=`echo $line |awk -F ' ' '{print $2}'`
		#echo "k-v :$t_name -> $t_value"
		if [ $t_name = "width" ] ; then
			WIDTH=$t_value
		#	echo "1 ->"$WIDTH
			continue
		fi
		if [ $t_name = "height" ] ; then
			HEIGHT=$t_value
			#echo "2 ->"$HEIGHT
			continue
		fi
		if [ $t_name = "src_yuv" ] ; then
			SRC_YUV=$t_value
			#echo "3 ->"$SRC_YUV
			continue
		fi
		if [ $t_name = "dest_dir" ] ; then
			DEST_DIR=$t_value
			#echo "4"
			continue
		fi
		if [ $t_name = "min_qp" ] ; then
			MIN_QP=$t_value
			#echo "5"
			continue
		fi
		if [ $t_name = "max_qp" ] ; then
			MAX_QP=$t_value
			#echo "6"
			continue
		fi
		if [ $t_name = "start_frame" ] ; then
			START_FRAME=$t_value
			#echo "6"
			continue
		fi
		if [ $t_name = "end_frame" ] ; then
			END_FRAME=$t_value
			#echo "6"
			continue
		fi
		if [ $t_name = "pc_mode" ] ; then
			PC_MODE=$t_value
			#echo "6"
			continue
		fi
		if [ $t_name = "br_list" ] ; then
			#BR_LIST=$t_value
			echo $t_value
			BR_LIST=`echo $t_value | sed  "s/,/ /g"`
			#echo "7"
			continue
		fi
		echo "#####not handle para -> "$line"  ,will add later"
	done  < $1
}
show_global_para(){
	echo "##############################"
	echo "show global var "
	echo "WIDTH -> $WIDTH"
	echo "HEIGHT -> $HEIGHT"
	echo "SRC_YUV -> $SRC_YUV"
	echo "DEST_DIR -> $DEST_DIR"
	echo "MAX_QP -> $MAX_QP"
	echo "MIN_QP -> $MIN_QP"
	echo "START_FRAME -> $START_FRAME"
	echo "END_FRAME -> $END_FRAME"
	echo "PC_MODE -> $PC_MODE"
	echo "BR_LIST -> $BR_LIST"
	echo "##############################"
	echo
}

#18
encode_h2v4(){
	temp_dir="$DEST_DIR/h2v4"
	mkdir -p $temp_dir
	chmod 777 -R $temp_dir    > /dev/null 2>&1
	kbps=$1
	bps=`expr $kbps \* 1000`
	fsize=`printf "%05d\n" $kbps`
	out_file="$temp_dir/${fsize}k.h265"
	echo "#####################encode -> $bps : $kbps k  -->$out_file"
	if [ $PC_MODE -eq 1 ] ;then 
		echo "PC  MODE"
		APP=$H2V4_C_MODEL
	else
		echo "EVB MODE"
		APP=$H2V4
	fi
	echo "APP->  $APP"
	echo "CMD ->"$APP -i $SRC_YUV -a $START_FRAME -b $END_FRAME -n $MIN_QP -m $MAX_QP -d -L 40 --intraQpDelta 0 --bitPerSecond  $bps   --picSkip 0 --picRc 1 --mbRc 1  -w $WIDTH -h $HEIGHT -x $WIDTH -y $HEIGHT -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 -o $out_file
	
	
	$APP -a  $START_FRAME -b $END_FRAME -L 180  -n $MIN_QP -m $MAX_QP --intraQpDelta 0 --bitPerSecond  $bps  -d  \
	--tolMovingBitRate 2 --picSkip 0 -U 1  -w $WIDTH -h $HEIGHT -x $WIDTH -y $HEIGHT -l 1   --intraPicRate 15 -f 15 -j 15 -g 15   --gopSize 1 --monitorFrames 15  -o $out_file -i $SRC_YUV 
}
encode_h2v1(){
	temp_dir="$DEST_DIR/h2v1"
	mkdir -p $temp_dir
	chmod 777 -R $temp_dir
	kbps=$1
	bps=`expr $kbps \* 1000`
	fsize=`printf "%05d\n" $kbps`
	out_file="$temp_dir/${fsize}k.h265"
	echo "#####################encode -> $bps : $kbps k  -->$out_file"
	if [ $PC_MODE -eq 1 ] ;then 
		echo "PC  MODE"
		APP=$H2V1_C_MODEL
	else
		echo "EVB MODE"
		APP=$H2V1
	fi
	echo "APP->  $APP"
	echo "CMD ->"$APP -i $SRC_YUV -a $START_FRAME -b $END_FRAME -n $MIN_QP -m $MAX_QP -d -L 40 --intraQpDelta 0 --bitPerSecond  $bps   --picSkip 0 --picRc 1 --mbRc 1  -w $WIDTH -h $HEIGHT -x $WIDTH -y $HEIGHT -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 -o $out_file
	
	$APP -a  $START_FRAME -b $END_FRAME  -n $MIN_QP -m $MAX_QP -L 180 --intraQpDelta 0 --bitPerSecond  $bps -f 15:1 -F 15:1\
	 --picSkip 0 --picRc 1   -w $WIDTH -h $HEIGHT -x $WIDTH -y $HEIGHT -l 1   --intraPicRate 15 -f 15  -g 15   -o $out_file -i $SRC_YUV 
}
encode_h1v6(){
	temp_dir="$DEST_DIR/h1v6"
	mkdir -p $temp_dir
	chmod 777 -R $temp_dir
	kbps=$1
	bps=`expr $kbps \* 1000`
	fsize=`printf "%05d\n" $kbps`
	out_file="$temp_dir/${fsize}k.h264"

	echo "#####################encode h1v6 -> $bps : $kbps k  -->$out_file"
	if [ $PC_MODE -eq 1 ] ;then 
		echo "PC  MODE"
		APP=$H1V6_C_MODEL
	else
		echo "EVB MODE"
		APP=$H1V6
	fi
	echo "APP->  $APP"
	echo "CMD ->"$APP -i $SRC_YUV -a $START_FRAME -b $END_FRAME -n $MIN_QP -m $MAX_QP -d -L 40 --intraQpDelta 0 --bitPerSecond  $bps   --picSkip 0 --picRc 1 --mbRc 1  -w $WIDTH -h $HEIGHT -x $WIDTH -y $HEIGHT -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 -o $out_file
	

	$APP -i $SRC_YUV -a $START_FRAME -b $END_FRAME -n $MIN_QP -m $MAX_QP -d -L 40 --intraQpDelta 0 --bitPerSecond  $bps   --picSkip 0 --picRc 1 --mbRc 1  -w $WIDTH -h $HEIGHT -x $WIDTH -y $HEIGHT -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 -o $out_file
}

read_para_from_file $1
show_global_para 
for bitrate in `echo $BR_LIST`
do
	echo "XXXXXXXXXXXXXXXXXXX--->$bitrate<---XXXXXXXXXXXXXXXXXXXXX"
	encode_$2 $bitrate
done
