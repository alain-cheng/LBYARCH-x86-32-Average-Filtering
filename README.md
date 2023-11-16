# LBYARCH-x86-32-Average-Filtering

**Assembling, Compiling, and Linking**
```
nasm -f win32 <assembly file>.asm

gcc -c <c file>.c -o <c file>.obj -m32

gcc <c file>.obj <asm file>.obj -o <c file>.exe -m32

<c file>.exe
```