#!/bin/sh 
H2V4=/nfs/bin/testbench_hevc_v8
H2V1=/nfs/bin/testbench_hevc_v2
H1V6=/nfse/bin/testbench_h
IN_YUV=/nfs/yuv/nv12_1920p.yuv
MAX_FRAME=40
encode_h2v4(){
	bps=$1
	kbps=`expr $bps / 1000`
	out_file="/nfs/h2v4/bps${kbps}k.hevc"
	echo "#####################encode -> $bps : $kbps k  -->$out_file"
	
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -a 1 -b $MAX_FRAME -L 180 --intraQpDelta 0 --bitPerSecond  $bps  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o $out_file
}
test_h2v4(){
	encode_h2v4    8000000
	encode_h2v4   10000000
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
test2(){
	encode_h2v4     300000
	encode_h2v4     500000
	encode_h2v4     800000
	encode_h2v4    1000000
	encode_h2v4    1500000
	encode_h2v4    2000000
	encode_h2v4    3000000
	encode_h2v4    4000000
	encode_h2v4    6000000
	encode_h2v4    8000000
}
test_h1v6(){
	echo "h1v6"
}
test_h2v1(){
	echo "h2v1"
}

test_h2v4
