/*
 * =====================================================================================
 *
 *       Filename:  pixel_strip.c
 *
 *    Description:  strip yuv data 
 *
 *        Version:  1.0
 *        Created:  2017年04月26日 10时42分06秒
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *        Company:  
 *
 * =====================================================================================
 */
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

void help(char *app){
	printf("usage :\n");
	printf("\t %s in_w in_h out_w out_y in_file:\n", app);
}
#define BUFFER_SIZE  1024000
int main(int argc, char** argv){
	if(argc < 5){
		help(argv[0]);
		return 0;
	}
	int in_w = atoi(argv[1]);
	int in_h = atoi(argv[2]);
	int out_w = atoi(argv[3]);
	int out_h = atoi(argv[4]);
	char* in_file = argv[5];
	printf("in   res  ->%5d * %5d\n", in_w, in_h);
	printf("out  res  ->%5d * %5d\n", out_w, out_h);
	printf("in   file ->%s\n", in_file);
	char out_file[128];
	sprintf(out_file, "%s_%d_%d.yuv", in_file, out_w, out_h);
	printf("out  file ->%s\n", out_file);
	int out_frame_num = 0;
	if(argc == 7){
		out_frame_num = atoi(argv[6]);
		printf("frame num ->%d\n", out_frame_num);
	}
	if(out_w % 2 != 0 || out_h %2 != 0){
		printf("out res max can be divided by 2\n");
		return 0;
	}
	int y_size = out_w * out_h;
	int uv_size = y_size / 2;
	char temp_buf[BUFFER_SIZE];
	FILE *in_fd = fopen(in_file, "r");
	if(in_fd == NULL ){
		printf("open in file error ->%s\n", in_file);
		return 0;
	}
	FILE *out_fd = fopen(out_file, "w+");
	if(out_fd == NULL ){
		printf("open out file error ->%s\n", out_file);
		return 0;
	}
	long in_file_size;
	fseek(in_fd, 0, SEEK_END);
	in_file_size = ftell(in_fd);
	rewind(in_fd);
	printf("input file size ->%8ld\n", in_file_size);
	int in_file_frame_num = in_file_size / (in_w * in_h * 3 / 2);
	printf("in  file frame num ->%d\n", in_file_frame_num);
	if(out_frame_num == 0 ){
		out_frame_num = in_file_frame_num;
	}
	if(in_file_frame_num < out_frame_num ){
		out_frame_num = in_file_frame_num;
	}
	printf("out file frame num ->%d\n", out_frame_num);



	fclose(in_fd);
	fclose(out_fd);
	return 0;
}
