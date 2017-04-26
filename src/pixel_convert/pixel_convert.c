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
#include <string.h>
#define  FILL_Y_DATA 0x00
#define  FILL_UV_DATA  0x80
void help(char *app){
	printf("usage :\n");
	printf("\t %s in_w in_h out_w out_y in_file:\n", app);
}
#define BUFFER_SIZE  1024000

int convert_x_in_larger_out(FILE *in, FILE *out, int in_w, int in_h, int out_w, int out_h, int num){
	printf("%d %s\n",__LINE__, __func__);

	return 0;
}
int convert_x_out_larger_in(FILE *in, FILE *out, int in_w, int in_h, int out_w, int out_h, int num){
	printf("%d %s\n",__LINE__, __func__);

	return 0;
}
int convert_x_in_equal_out(FILE *in, FILE *out, int in_w, int in_h, int out_w, int out_h, int num){
	printf("%d %s\n",__LINE__, __func__);
	char *buf = malloc(out_w * out_h);
	if(buf == NULL){
		printf("malloc buffer error\n");
		return -1;
	}
	size_t result;
	size_t y_size = out_w * out_h;
	size_t uv_size = y_size / 2;
	if(in_h >= out_h){
		y_size = out_w  * out_h;
		uv_size = y_size / 2;
		size_t y_seek = in_w *(in_h - out_h);
		size_t uv_seek = y_seek / 2;
		printf("copy info -> %ld  %ld %ld %ld\n", y_size, uv_size, y_seek, uv_seek);
		for(int i = 0; i < num; i++){
			//copy y
			result = fread(buf, y_size, 1, in);
			if( y_size != result){
				printf("read size error ->%ld %ld\n", y_size, result);
				goto error_2;
			}
			result = fwrite(buf, y_size, 1, out);
			if(result != y_size){
				printf("write file error ->%ld %ld\n", y_size, result);
				goto error_2;
			}
			fseek(in, y_seek, SEEK_CUR);
			result = fread(buf, uv_size, 1, in);
			if( uv_size != result){
				printf("read size error ->%ld %ld\n", uv_size, result);
				goto error_2;
			}
			result = fwrite(buf, uv_size, 1, out);
			if(result != uv_size){
				printf("write file error ->%ld %ld\n", uv_size, result);
				goto error_2;
			}
			fseek(in, uv_seek, SEEK_CUR);
		}
	}
	else{
		y_size = in_w  * in_h;
		uv_size = y_size / 2;
		size_t y_fill_size = out_w *(out_h - in_h);
		size_t uv_fill_size = y_fill_size / 2;
		printf("copy fill info -> %ld  %ld %ld %ld\n", y_size, uv_size, y_fill_size, uv_fill_size);
		for(int i = 0; i < num; i++){
			//copy y
			result = fread(buf, 1, y_size, in);
			if( y_size != result){
				printf("read size error ->%ld %ld\n", y_size, result);
				goto error_2;
			}
			result = fwrite(buf, 1, y_size, out);
			if(result != y_size){
				printf("write file error ->%ld %ld\n", y_size, result);
				goto error_2;
			}
			memset(buf, FILL_Y_DATA, y_fill_size);
			result = fwrite(buf, 1, y_fill_size, out);
			if(result != y_fill_size){
				printf("write file error ->%ld %ld\n", y_fill_size, result);
				goto error_2;
			}
			result = fread(buf,1,  uv_size, in);
			if( uv_size != result){
				printf("read size error ->%ld %ld\n", uv_size, result);
				goto error_2;
			}
			result = fwrite(buf, 1, uv_size, out);
			if(result != uv_size){
				printf("write file error ->%ld %ld\n", uv_size, result);
				goto error_2;
			}
			memset(buf, FILL_UV_DATA, uv_fill_size);
			result = fwrite(buf, 1, uv_fill_size, out);
			if(result != uv_fill_size){
				printf("write file error ->%ld %ld\n", uv_fill_size, result);
				goto error_2;
			}
		}



	}
	free(buf);
	printf("out file size ->%ld\n", ftell(out));
	return num;
error_2:
	free(buf);
	return -1;
}
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
	int out_frame_num = 0;
	if(argc == 7){
		out_frame_num = atoi(argv[6]);
		printf("frame num ->%d\n", out_frame_num);
	}
	if(out_w % 2 != 0 || out_h %2 != 0){
		printf("out res max can be divided by 2\n");
		return 0;
	}
	if(in_w % 2 != 0 || in_h %2 != 0){
		printf("in res max can be divided by 2\n");
		return 0;
	}
	int y_size = out_w * out_h;
	int uv_size = y_size / 2;
	FILE *in_fd = fopen(in_file, "r");
	if(in_fd == NULL ){
		printf("open in file error ->%s\n", in_file);
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
	char out_file[128];
	sprintf(out_file, "%s_%dx%d_%d.yuv", in_file, out_w, out_h, out_frame_num);
	printf("out  file ->%s\n", out_file);
	FILE *out_fd = fopen(out_file, "w+");
	if(out_fd == NULL ){
		printf("open out file error ->%s\n", out_file);
		return 0;
	}

	if(in_w = out_w){
		convert_x_in_equal_out(in_fd, out_fd, in_w, in_h, out_w, out_h, out_frame_num);
	}
	else if(in_w < out_w){
		convert_x_out_larger_in(in_fd, out_fd, in_w, in_h, out_w, out_h, out_frame_num);
	}
	else{
		convert_x_in_larger_out(in_fd, out_fd, in_w, in_h, out_w, out_h, out_frame_num);
	}


	fclose(in_fd);
	fflush(out_fd);
	fclose(out_fd);
	return 0;
}
