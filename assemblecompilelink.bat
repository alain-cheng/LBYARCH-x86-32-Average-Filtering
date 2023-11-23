nasm -f win32 imgAvgFilter.asm
gcc -c main.c -o main.obj -m32
gcc main.obj imgAvgFilter.obj -o imgAvgFilter.exe -m32