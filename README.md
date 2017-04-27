码流测试工具简介
=============

目的是使用testbench和c model自动化验证特定的序列编码效果，该工具编码过程可以运行在evb和PC上进行图像编码，并且可以使用自动化工具计算出对应的PSNR和SSIM数据．通过定义对应的case文件，可以针对不同的参数进行对应的数据验证.
工具包获取
----
QTS/tools/video_quality_analysis

工具包内容
----
##工具包含如下组件：

| 工具 |　作用  | 备注  |
| --- | --- | --- |
| encode.sh |　编码脚本，用来进行自动化编码测试 |  可以在evb和PC上分别调用对应的工具进行测试 |
| pic_cmp.py |　分析工具，自动解码视频，计算psnr和ssim |  |
| psnr |
| src |　常用工具远吗,如PSRN和YUV420像素转换工具｜　　｜
| c_model |　编解码c model所有的工具 |  |
| case |　测试用例文件夹  | 每个文件对应一个测试用例  |


EVB建议工作模式
----

PC nfs server + evb ,即所有的二进制程序和数据全部放置在pc上,这样方便数据的修改和后处理(如二进制程序的即时修改或者yuv数据的临时修正),只在evb执行相关的命令即可.

## 各种数据建议存放位置:

| 数据类型 |　作用  | 备注  |
| --- | --- | --- |
| YUV数据 | PC:/nfs/yuv/ | nfs共享/nfs |
| 输出stream | PC: /nfs/out/ |  nfs共享/nfs |
| evb testbench | PC:/nfs/bin |  |
| evb encode lib so | PC:/nfs/lib | 通过export LD_LIBRARY_PATH 支持 ,稍后附代码 |
| case | PC:/nfs/** | |

## 相关命令
EVB环境设置工具:/nfs/bin/env.sh,建议放置在PC上,需要chmod +x xxx给予可执行权限.

/nfs/bin/env.sh
```cpp
#!/bin/sh
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/nfs/lib
export LD_LIBRARY_PATH
```
EVB执行如下代码后,便可以在EVB上直接运行PC上的nfs代码:
```cpp
donfs
source /nfs/bin/env.sh   ## 导入动态库搜索路径
/nfs/bin/testbench_xxxx
```
case文件格式简介
----
case文件中定义了执行testbench各种参数,注意结尾保留一个回车,如下表(如果需要支持更多参数,按照格式添加并修改encode.sh即可):
| 参数 | 作用  | 备注  |
| --- | --- | --- |
| width | 输入yuv图像宽度 | --- |
| height | 输入yuv图像高度 | --- |
| src_yuv | yuv数据位置 | --- |
| dest_dir | 结果输出文件夹 | 文件夹内会按照编码器模块划分二级目录,所有的stream,解码后的yuv,和计算后的PSNR等信息都会存放在此 |
| max_qp | 最大qp | 51 |
| min_qp | 最小qp | 10 |
| start_frame | start index | --- |
| end_frame | end index | --- |
| fps | 帧率 | 架子,暂未支持 |
| intra_interval | i帧间隔 | 架子,暂未支持 |
| pc_mode | 当前case调用PC上的C model运行 | --- |
| br_list | 目标码率列表 | 逗号分割,kbps |

demo数据如下:
```cpp
width 1920
height 1088
src_yuv /nfs/yuv/nv12_1920x1088_360.yuv
dest_dir /nfs/out/ipc_day
max_qp 51
min_qp 10
start_frame 0
end_frame 100
fps 15
intra_interval 15
pc_mode 0
br_list 300,500,800,1000
```

encode.sh 使用方法
----
encode.sh使用/bin/sh解析执行,方便在pc和evb上同时使用,调用方法如下:<br>
```cpp
#./encode.sh  case_file  dev
支持的dev包含: h1v6/h2v1/h2v4
````
命令会自动解析case_file中指定的参数,最后在所有的编码数据存放在case_file中指定的dest_dir对应的dev下边

pic_cmp.py使用方法
----
pic_cmp.sh使用python3编写,用于调用解码器的c model对case_file指定生成的数据进行解码并分析,生成对应的yuv解码数据和PSNR和SSIM信息在对应目录下,使用方法如下:<br>
```cpp
./pic_cmp.py dev  mode case_file
支持的dev包含:
            h1v6
            h2v1
            h2v4
支持的mode包含:
            cal      --> 计算psnr,yuv解码过
            decode   --> 仅仅进行解码
            all      --> 解码并计算psnr
```


