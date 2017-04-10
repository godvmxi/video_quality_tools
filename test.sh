#!/bin/sh 
H2V4=/nfs/bin/testbench_hevc_v8
H2V1=/nfs/bin/testbench_hevc_v2
H1V6=/nfse/bin/testbench_h
IN_YUV=/nfs/yuv/nv12_1920p.yuv
MAX_FRAME=45
test_h2v4(){
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond    300000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps300k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond    500000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps500k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond    800000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps800k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond    800000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 30 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps800k_2.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   1000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps1000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   1500000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps1500k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   2000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps2000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   2500000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps2500k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   3000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps3000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   4000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps4000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   6000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps6000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond   8000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps8000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 100000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps10000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 100000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps12000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 140000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps14000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 160000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps16000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 180000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps18000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 200000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps20000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 220000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps22000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 240000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps24000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 280000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps28000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 320000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps32000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 360000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps36000k.hevc
	/nfs/bin/testbench_hevc_v8 -i $IN_YUV -b $MAX_FRAME -L 123 --bitPerSecond 400000000  --tolMovingBitRate 1  -U 1 -u 1  -w 1920 -h 1088 -x 1920 -y 1088 -l 1   --intraPicRate 15 -f 15 -j 15 -g 15  -C 1 --gopSize 1 --monitorFrames 15 -o /nfs/h2v4/bps40000k.hevc

}
test_h1v6(){
	echo "h1v6"
}
test_h2v1(){
	echo "h2v1"
}

test_h2v4
