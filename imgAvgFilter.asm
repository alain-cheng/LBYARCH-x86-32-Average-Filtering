global _imgAvgFilter
segment .data
divisor db 9
x_size dd 0
y_size dd 0
sampling dd 0
segment .text
_imgAvgFilter:
    push ebp
    mov ebp, esp
    
    mov esi, [ebp+8]	; input_image
    mov edi, [ebp+12]	; filtered_image
    mov eax, [ebp+16]    ; image_size_x
    mov ebx, [ebp+20]    ; image_size_y
    mov edx, [ebp+24]    ; sampling_window_size
    
    lea ecx, [x_size]    ; free up eax and store value into var x_size
    mov [ecx], eax
    lea ecx, [y_size]    ; free up ebx ... into var y_size
    mov [ecx], ebx
    lea ecx, [sampling]  ; free up edx ... into sampling
    mov [ecx], edx
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    ; TODOs: Logic for average filtering
    mov eax, [x_size]
    mov ebx, [y_size]
    imul eax, ebx
    mov ecx, eax            ; total
L1: ; There is no vector traversal yet, at best it currently only supports a 3x3 image
    mov ax, [esi]           ; reads values of input_image into filtered_image
    add dx, ax              ; sum collector
    mov dword [edi], eax
    add esi, 4
    add edi, 4
    loop L1
    
    ; SUM (EDX) div sampling window size (default 9)
    mov ax, dx
    mov dl, [sampling]
    div dl
    
    mov edi, [ebp+12]   ; find filtered_image again
    mov [edi+16], al    ; insert average value on the middle

RETURN:                                                  
    mov esp, ebp
    pop ebp
    ret
