#include <stdio.h>
#include <windows.h>

extern void imgAvgFilter(int* input_image, int* filtered_image, int image_size_x, int image_size_y, int sampling_window_size)

int main() {
	int x, y, n; 	// image size x and y + the sampling window size (n)
	int* input_image;
	int* filtered_image;
	
	// TODOs: initialize variables
	input_image = (int*)malloc(/*sizeof(*input_image)*/);
	filtered_image = (int*)malloc(/*sizeof(*filtered_image)*/);
	
	/* 
	 * TODO:
	 * Populate input_image here
	 **/
	 
	 
	// call
	imgAvgFilter(input_image, filtered_image, x, y, n);
	
	
	// TODO: Print filtered_image
	for(int i=0; i<x; i++) {
		
		for(int j=0; j<y; j++) {
			
		}
		
	}
}
