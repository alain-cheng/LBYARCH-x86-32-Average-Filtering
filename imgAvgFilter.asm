global _imgAvgFilter
segment .data
divisor db 9
x_size dd 0
y_size dd 0
total dd 0
sampling dd 3
x_traverse dd 0
y_traverse dd 0
counter db 1                        ; To keep track of the # of cycles for the SamplingLoop
segment .text
_imgAvgFilter:
    push ebp
    mov ebp, esp
    
    mov esi, [ebp+8]	           ; input_image
    mov edi, [ebp+12]	           ; filtered_image
    mov eax, [ebp+16]               ; image_size_x
    mov ebx, [ebp+20]               ; image_size_y
    mov edx, [ebp+24]               ; sampling_window_size
    
    lea ecx, [x_size]               ; free up eax and store value into var x_size
    mov [ecx], eax
    lea ecx, [y_size]               ; free up ebx ... into var y_size
    mov [ecx], ebx
    lea ecx, [sampling]             ; free up edx ... into sampling
    mov [ecx], edx
    
    mov eax, [x_size]
    mov ebx, [y_size]
    imul eax, ebx                   ; total
    lea ecx, [total]
    mov [ecx], eax
    
    call populate
    
    mov eax, [x_size]    
    imul eax, 4
    lea ecx, [x_traverse]           ; (no purpose yet)
    mov [ecx], eax
    
    mov ebx, [x_size]     
    imul ebx, 4
    lea ecx, [y_traverse]           ; for searching the next row (the # of pixels directly below it)
    mov [ecx], ebx
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    ; TODOs: Logic for average filtering
    mov esi, [ebp+8]	           ; input_image
    mov edi, [ebp+12]	           ; filtered_image
    mov al, [x_size]
    mov bl, [y_size]
    sub bl, 2
    mul bl
    mov ch, al                  ; number of samplings needed [x*(y-2)] - 2
    sub ch, 2
    mov ebx, [y_traverse]
    
    xor eax, eax
SamplingLoop: 
    ; Sampling Window Segment
    mov dx, [esi+0]             ; 1st pixel
    add ax, dx                  ; Sum collector
    mov dx, [esi+4]             ; 2nd
    add ax, dx
    mov dx, [esi+8]             ; 3rd
    add ax, dx
    mov dx, [esi+0+ebx]         ; 4th   
    add ax, dx
    mov dx, [esi+4+ebx]         ; 5th (middle)
    add ax, dx
    mov dx, [esi+8+ebx]         ; 6th
    add ax, dx
    mov dx, [esi+0+ebx+ebx]     ; 7th
    add ax, dx
    mov dx, [esi+4+ebx+ebx]     ; 8th
    add ax, dx
    mov dx, [esi+8+ebx+ebx]     ; 9th
    add ax, dx
    
    ; Averaging Segment
    xor edx, edx            ; Clear EDX for division
    mov dx, 9 				; divisor - size of box
	shr dx, 1
	add ax, dx				; add divisor/2 to dividend - combined total of numbers
	
	mov dl, 9 				; divisor
    div dl					; average
    ; Finding the middle of the sampling window          
    mov edi, [ebp+12]       ; filtered_image
    add edi, ebx            ; move edi 1 pixel down
    mov cl, [counter]
    move_right:             ; move edi 1 pixel to the right each based on how far to the right is the sampling
        add edi, 4
        dec cl
        cmp cl, 0
        jne move_right
    
    mov byte [edi], al           ; Insert value in the middle of the current sampling window
    
    ; move sampling window to the right by 1 px and clear some registers for the next pass
    add esi, 4
    xor eax, eax
    inc byte [counter]
    
    ; loop again
    dec ch
    cmp ch, 0
jne SamplingLoop

    call restore_borders ; restore borders after averaging
    
return:                                   
    mov esp, ebp
    pop ebp
    ret

populate: ; initializes filtered_image
    mov ecx, [total]
    p_L1:
    mov edx, [esi]
    mov dword [edi], edx
    add esi, 4
    add edi, 4
    loop p_L1
    ret 0
    
restore_borders: ; restores the left and right borders from input image
    ; left corner focus
	mov esi, [ebp+8] ; reset esi and edi to original positions
	mov edi, [ebp+12]
	
	mov ecx, [y_size]
	
	mov ebx, [y_traverse] ; enough bits for next row
	
    p_L2: ; focuses on left corner
    mov edx, [esi]
    mov dword [edi], edx
	add esi, ebx ; y-traverse
    add edi, ebx
    loop p_L2
	
	; right corner focus
	mov esi, [ebp+8] ; reset esi and edi to original positions
	mov edi, [ebp+12]
	
	mov ecx, [y_size]
	
	mov ebx, [x_size]
	mov eax, 4
	mul ebx
	mov ebx, edx
	add esi, ebx
	add edi, ebx
	sub edi, 4 ; x-size*4 - 4 (to account for excess position bits)
	sub esi, 4
	
	mov ebx, [y_traverse]
	
	p_L3: ; focuses on right corner
    mov edx, [esi]
    mov dword [edi], edx
	add esi, ebx ; y-traverse
    add edi, ebx
    loop p_L3
	
	
    ret 0