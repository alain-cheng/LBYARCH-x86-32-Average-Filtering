#include <stdio.h>
#include <windows.h>

extern void imgAvgFilter(int* input_image, int* filtered_image, int image_size_x, int image_size_y, int sampling_window_size);

int main() {
	int x, y, n; 	// image size x and y + the sampling window size (n)
	int i, j;
	int* input_image;
	int* filtered_image;
	
	// TODOs: initialize variables
	printf("Enter x size of picture: ");
	scanf("%d", &x);
	
	printf("Enter y size of picture: ");
	scanf("%d", &y);
	n = x*y; // total size of picture
	
	input_image = (int*)malloc(n*sizeof(*input_image));
	filtered_image = (int*)malloc(n*sizeof(*filtered_image));
	
	/* 
	 * TODO:
	 * Populate input_image here
	 **/
	printf("Enter values of the picture: ");
	for(i = 0; i < x; ++i) {
		for(j = 0; j < y; ++j) {
			scanf("%d", input_image + (i*x) + j);
		}
	}
	
	 
	// call
	imgAvgFilter(input_image, filtered_image, x, y, n);
	
	
	// TODO: Print filtered_image
	for(i=0; i<x; i++) {
		
		for(j=0; j<y; j++) {
			printf("%d ", *(filtered_image + (i*x) + j));
		}
		printf("\n");
	}
}
