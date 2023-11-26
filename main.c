#include <stdio.h>
#include <windows.h>

extern void imgAvgFilter(int* input_image, int* filtered_image, int image_size_x, int image_size_y, int sampling_window_size);

int main() {
	int x, y, n = 9; 	// image size x and y + the sampling window size (n)
	int i, j;
	int* input_image;
	int* filtered_image;
	int total;
	
	// TODOs: initialize variables
	do{
		printf("Enter x size of picture: ");
		scanf("%d", &x);
		if(x < 3){
			printf("Invalid size of x.\n");
		}
	}while(x < 3);
	
	do{
		printf("Enter y size of picture: ");
		scanf("%d", &y);
		
		if(y < 3){
			printf("Invalid size of y.\n");
		}
	}while(y < 3);
	
	total = x*y; // total size of picture
	
	input_image = (int*)malloc(total*sizeof(*input_image));
	filtered_image = (int*)malloc(total*sizeof(*filtered_image));
	
	/* 
	 * TODO:
	 * Populate input_image here
	 **/
	printf("Enter the %d values of the picture: ", total);
	for(i = 0; i < x; ++i) {
		for(j = 0; j < y; ++j) {
			scanf("%d", input_image + (i*y) + j);
		}
	}
	
	// debugging
	printf("Input Image: \n");
	for(i = 0; i < y; i++) {
		for(j = 0; j < x; j++) {
			printf("%d ", *(input_image + (i*x) + j));
		}
		printf("\n");
	}
	
	printf("\n");
	 
	// call
	imgAvgFilter(input_image, filtered_image, x, y, n);
	
	// TODO: Print filtered_image
	printf("Filtered Image: \n");
	for(i=0; i<y; i++) {
		for(j=0; j<x; j++) {
			printf("%d ", *(filtered_image + (i*x) + j));
		}
		printf("\n");
	}
	
}
