#!/usr/bin/env python3
import os
import sys
PSNR="/nfs/dev/evalvid/psnr"
SRC_YUV="/nfs/yuv/nv12_1080p_1000.yuv"
#SRC_YUV="/nfs/yuv/nv12_1920x1088_360.yuv"

H1V6_DIR="/nfs/h1v6"
H2V1_DIR="/nfs/h2v1"
H2V4_DIR="/nfs/h2v4"

H264_DECODER="/nfs/dev/socv/data/tools/vdec/hx170dec_pclinux"
H265_DECODER="/nfs/dev/socv/data/tools/vdec/g2dec"

OUT_PSNR_CSV="/nfs/yuv/out.csv"
OUT_SSIM_CSV="/nfs/yuv/out.csv"
WIDTH=1920
HEIGHT=1088
R_SPACE =5

def gen_excel(dat):
    pass

def decode_h264(stream, yuv):
    cmd= "%s -O%s %s"%(H264_DECODER, yuv, stream)
    os.system(cmd)
    pass
def decode_h265(stream, yuv):
    cmd = "%s -ibs -S -O%s %s" % (H265_DECODER, yuv, stream)
    os.system(cmd)
    pass

def cal_psnr_ssim(src, dst):
    cmd = "%s 1920  1088 420 %s %s"%(PSNR, src, dst)
    #tmp = "%s 2>&1"%cmd
    print("cal cmd ->%s"%cmd)
    buf = os.popen(cmd).readlines()
    psnr = ["psnr"]
    for i in range(1,R_SPACE):
        psnr.append("")
    for line in  buf:
        psnr.append(line.replace("\n", ""))
    print("psnr lines ->%d"%(len(psnr)))
    #print(psnr)

    cmd = "%s ssim"%cmd
    buf = os.popen(cmd).readlines()
    ssim = ["ssim"]
    for i in range(1,R_SPACE):
        ssim.append("")
    for line in  buf:
        ssim.append(line.replace("\n", ""))
    print("ssim lines ->%d"%(len(ssim)))
    #print(ssim)
    return [psnr ,ssim]

    pass
def write_data_file(fd, psnr ,ssim , header):
    temp = " , ".join(psnr)
    line = "%s,%s\n" % (header,temp)
    fd.write(line)
    temp = " , ".join(ssim)
    line = "%s,%s\n" % (header, temp)
    fd.write(line)

def cal_h1v6_data(type):#decode , cal, all
    cal_file_fd = None
    if(type in ["all","cal"]) :
        cal_file_name = "%s/psnr_ssim.csv"%H1V6_DIR
        cal_file_fd=  open(cal_file_name , "w+")
        print("open file result ->%s"%cal_file_name, cal_file_fd)
    stream_list = os.listdir(H1V6_DIR)
    for item in stream_list:
        if item.find("h264") < 0 :
            continue
        stream_file = os.path.join("%s/%s"%(H1V6_DIR, item))
        yuv_file=stream_file.replace("h264","yuv")
        print("stream ->%s  yuv->%s"%(stream_file, yuv_file ) )
        header =  "%s,%s"%("h1v6",item)
        if type == "decode" :
            decode_h264(stream_file, yuv_file)
        elif type == "cal" :
            print("cal psnr ssim")
            [ssim, psnr] = cal_psnr_ssim(SRC_YUV, yuv_file)
            write_data_file(cal_file_fd, psnr, ssim ,header)


        elif type == "all" :
            decode_h264(stream_file, yuv_file)
            [ssim, psnr] = cal_psnr_ssim(SRC_YUV, yuv_file)
            write_data_file(cal_file_fd, psnr, ssim, header)
    if cal_file_fd != None:
        cal_file_fd.close()


def cal_h2_data(dir, type):  # decode , cal, all
    cal_file_fd = None
    if (type in ["all", "cal"]):
        cal_file_name = "%s/psnr_ssim.csv" % dir
        cal_file_fd = open(cal_file_name, "w+")
    stream_list = os.listdir(dir)
    for item in stream_list:

        if item.find("hevc") < 0:
            continue
        stream_file = os.path.join("%s/%s" % (dir, item))
        yuv_file = stream_file.replace("hevc", "yuv")
        print("stream ->%s  yuv->%s" % (stream_file, yuv_file))
        header = ""
        if dir.find("h2v1"):
            header = "%s,%s" % ("h2v1", item)
        else:
            header = "%s,%s" % ("h2v4", item)
        if type == "decode":
            decode_h265(stream_file, yuv_file)
        elif type == "cal":
            [ssim, psnr] = cal_psnr_ssim(SRC_YUV, yuv_file)
            write_data_file(cal_file_fd, psnr, ssim, header)
        elif type == "all":
            decode_h265(stream_file, yuv_file)
            [ssim, psnr] = cal_psnr_ssim(SRC_YUV, yuv_file)
            write_data_file(cal_file_fd, psnr, ssim, header)

    if cal_file_fd != None:
        cal_file_fd.close()

def help():
    print("app dev_dir ssim/psnr");
if __name__ == "__main__":
    if len(sys.argv) != 3:
        help()
    if sys.argv[2] == "cal":
        print("cal psnr ssim")
    elif sys.argv[2] == "decode":
        print("just decode yuv")
    elif sys.argv[2] == "all":
        print("decode and call all")
    else:
        print("wrong cmp type")
        sys.exit(-1)
    if sys.argv[1] == "h1v6":
        print("cal h1v6")
        cal_h1v6_data(sys.argv[2])
    elif sys.argv[1] == "h2v1":
        print("cal h2v1")
        cal_h2_data(H2V1_DIR, sys.argv[2])
    elif sys.argv[1] == "h2v4":
        print("cal h2v4")
        cal_h2_data(H2V4_DIR, sys.argv[2])
    elif sys.argv[1] == "all":
        cal_h1v6_data(sys.argv[2])
        #cal_h2_data(H2V1_DIR,sys.argv[2])
        cal_h2_data(H2V4_DIR,sys.argv[2])
        pass

    else:
        print("not support ->%s"%sys.argv[1])
        sys.exit(-1)
