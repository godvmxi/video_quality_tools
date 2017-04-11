#!/bin/sh 
H2V8=/nfs/bin/testbench_hevc_v8
H2V1=/nfs/bin/testbench_hevc_v1
H1V6=/nfs/bin/testbench_h1v6_264
IN_YUV=/nfs/yuv/nv12_1920p.yuv
MAX_FRAME=20
encode_h2v4(){
	bps=$1
	kbps=`expr $bps / 1000`
	out_file="/nfs/h2v4/bps${kbps}k.hevc"
	echo "#####################encode -> $bps : $kbps k  -->$out_file"
	$H2V8 -i $IN_YUV -a 1 -b $MAX_FRAME -L 180 --intraQpDelta 0 --bitPerSecond  $bps  --tolMovingBitRate 2 --picSkip 0 -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o $out_file
}
encode_h2v1(){
	bps=$1
	kbps=`expr $bps / 1000`
	out_file="/nfs/h2v1/bps${kbps}k.hevc"
	echo "#####################encode -> $bps : $kbps k  -->$out_file"
	$H2V1 -i $IN_YUV -a 1 -b $MAX_FRAME -L 180 --intraQpDelta 0 --bitPerSecond  $bps  --picSkip 0 -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15  -g 15  -C 1  -o $out_file


}
encode_h1v6(){
	bps=$1
	kbps=`expr $bps / 1000`
	out_file="/nfs/h1v6/bps${kbps}k.h264"
	echo "#####################encode h1v6 -> $bps : $kbps k  -->$out_file"
	$H1V6 -i $IN_YUV -a 1 -b $MAX_FRAME -L 40 --intraQpDelta 0 --bitPerSecond  $bps   --picSkip 0 --picRc 1 --mbRc 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 -o $out_file


}
test_h2v4(){
	
	encode_h2v4   12000000
	encode_h2v4   14000000
	encode_h2v4   16000000
	encode_h2v4   18000000
	encode_h2v4   20000000
	encode_h2v4   22000000
	encode_h2v4   24000000
	encode_h2v4   28000000
	encode_h2v4   32000000
	encode_h2v4   36000000
	encode_h2v4   40000000

}

test_h1v6(){
	echo "h1v6"
	
	encode_h1v6   28000000
	encode_h1v6   32000000
	encode_h1v6   36000000
	encode_h1v6   40000000
}
test_h2v1(){
	echo "h2v1"
	encode_h2v1     300000
	encode_h2v1     500000
	encode_h2v1     800000
	encode_h2v1    1000000
	encode_h2v1    1500000
	encode_h2v1    2000000
	encode_h2v1    3000000
	encode_h2v1    4000000
	encode_h2v1    6000000
	encode_h2v1    8000000
	encode_h2v1   10000000
	encode_h2v1   12000000
	encode_h2v1   14000000
	encode_h2v1   16000000
	encode_h2v1   18000000
	encode_h2v1   20000000
	encode_h2v1   22000000
	encode_h2v1   24000000
	encode_h2v1   28000000
	encode_h2v1   32000000
	encode_h2v1   36000000
	encode_h2v1   40000000
}

test2(){
	encode_h2v1     300000
	encode_h2v1     500000
	encode_h2v4     800000
	encode_h2v4    1000000
	encode_h2v4    1500000
	encode_h2v4    2000000
	encode_h2v4    3000000
	encode_h2v4    4000000
	encode_h2v4    6000000
	encode_h2v4    8000000
	encode_h2v4   10000000
	/////
	encode_h1v6     300000
	encode_h1v6     500000
	encode_h1v6     800000
	encode_h1v6    1000000
	encode_h1v6    1500000
	encode_h1v6    2000000
	encode_h1v6    3000000
	encode_h1v6    4000000
	encode_h1v6    6000000
	encode_h1v6    8000000
	encode_h1v6   10000000
	encode_h1v6   12000000
	encode_h1v6   14000000
	encode_h1v6   16000000
	encode_h1v6   18000000
	encode_h1v6   20000000
	encode_h1v6   22000000
	encode_h1v6   24000000
}
test_$1
