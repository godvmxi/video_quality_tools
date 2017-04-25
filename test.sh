#!/bin/sh 
H2V8=/nfs/bin/testbench_hevc_v8
H2V1=/nfs/bin/testbench_hevc_v1
H1V6=/nfs/bin/testbench_h1v6_264
#IN_YUV=/nfs/yuv/nv12_1080p_1000.yuv
IN_YUV=/nfs/yuv/nv12_1920x1088_360.yuv
IN_YUV=/nfs/yuv/nv
MAX_FRAME=100
#18
encode_h2v4(){
	kbps=$1
	bps=`expr $kbps \* 1000`
	fsize=`printf "%05d\n" $kbps`
	out_file="/nfs/h2v4/${fsize}k.h265"
	echo "#####################encode -> $bps : $kbps k  -->$out_file"
	$H2V8 -a  0 -b $MAX_FRAME -L 180 --intraQpDelta 0 --bitPerSecond  $bps  -d  \
	--tolMovingBitRate 2 --picSkip 0 -U 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15   --gopSize 1 --monitorFrames 15  -o $out_file -i $IN_YUV 
}
encode_h2v1(){
	kbps=$1
	bps=`expr $kbps \* 1000`
	fsize=`printf "%05d\n" $kbps`
	out_file="/nfs/h2v1/${fsize}k.h265"
	echo "#####################encode -> $bps : $kbps k  -->$out_file"
	$H2V1 -a  0 -b $MAX_FRAME -L 180 --intraQpDelta 0 --bitPerSecond  $bps -f 15:1 -F 15:1\
	 --picSkip 0 --picRc 1   -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15  -g 15   -o $out_file -i $IN_YUV 
}
encode_h1v6(){
	kbps=$1
	bps=`expr $kbps \* 1000`
	fsize=`printf "%05d\n" $kbps`
	out_file="/nfs/h1v6/${fsize}k.h264"
	echo "#####################encode h1v6 -> $bps : $kbps k  -->$out_file"
	$H1V6 -i $IN_YUV -a 0 -b $MAX_FRAME -d -L 40 --intraQpDelta 0 --bitPerSecond  $bps   --picSkip 0 --picRc 1 --mbRc 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 -o $out_file
}
test_h2v4(){
	encode_h2v4     300	
	encode_h2v4     500
	encode_h2v4     800
	encode_h2v4    1000
	encode_h2v4    1500
	encode_h2v4    2000
	encode_h2v4    2500
	encode_h2v4    3000
	encode_h2v4    4000
	encode_h2v4    5000
	encode_h2v4    6000
	encode_h2v4    7000
	encode_h2v4    8000
	encode_h2v4    9000
	encode_h2v4   10000
	return 
	encode_h2v4    2000
	encode_h2v4    3000
	encode_h2v4    4000
	encode_h2v4    6000
	encode_h2v4    8000
	encode_h2v4   10000
}


test_h1v6(){
	echo "h1v6"
	
	encode_h1v6     300
	encode_h1v6     500
	encode_h1v6     800
	encode_h1v6    1000
	encode_h1v6    1500
	encode_h1v6    2000
	encode_h1v6    2500
	encode_h1v6    3000
	encode_h1v6    4000
	encode_h1v6    5000
	encode_h1v6    6000
	encode_h1v6    7000
	encode_h1v6    8000
	encode_h1v6    9000
	encode_h1v6   10000
	return
	encode_h1v6   14000
	encode_h1v6   16000
	encode_h1v6   18000
	encode_h1v6   20000
	encode_h1v6   22000
	encode_h1v6   24000

	
}
test_h1v6e(){
	encode_h1v6   28000
	encode_h1v6   32000
	encode_h1v6   36000
	encode_h1v6   40000
}
test_h2v1(){
	echo "h2v1"
	encode_h2v1     300
	encode_h2v1     500
	encode_h2v1     800
	encode_h2v1    1000
	encode_h2v1    1500
	encode_h2v1    2000
	encode_h2v1    2500
	encode_h2v1    3000
	encode_h2v1    4000
	encode_h2v1    5000
	encode_h2v1    6000
	encode_h2v1    7000
	encode_h2v1    8000
	encode_h2v1    9000
	encode_h2v1   10000
	return
	encode_h2v1   14000
	encode_h2v1   16000
	encode_h2v1   18000
	encode_h2v1   20000
	encode_h2v1   22000
	encode_h2v1   24000
	encode_h2v1   28000
	encode_h2v1   32000
	encode_h2v1   36000
	encode_h2v1   40000
}

test2(){
	
	/////
	encode_h1v6     300
	encode_h1v6     500
	encode_h1v6     800
	encode_h1v6    1000
	encode_h1v6    1500
	encode_h1v6    2000
	encode_h1v6    3000
	encode_h1v6    4000
	encode_h1v6    6000
	encode_h1v6    8000
	encode_h1v6   10000
	encode_h1v6   12000
	encode_h1v6   14000
	encode_h1v6   16000
	encode_h1v6   18000
	encode_h1v6   20000
	encode_h1v6   22000
	encode_h1v6   24000
}
test_$1
#encode_h2v4  $2
