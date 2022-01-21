.386 
.model flat, stdcall 

;includem msvcrt.lib si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern printf : proc
extern scanf : proc
extern fopen : proc
extern fgets : proc
extern fprintf : proc
extern fclose : proc


;declaram simbolul start ca public - de acolo incepe executia
public start

.data 
	v dd 1000 dup (0)
	vn dd 1000 dup (0)
	s db 1000 dup (0)
	sn dd 1000 dup (0)
	text db 1000 dup (0)
	len_text db $-text
	mode_read db "r",0
	mode_write db "w",0
	fp dd 0
	fout dd 0
	path db "C:\Calculator_files\filename.txt",0
	path1 db "C:\Calculator_files\result.txt",0
	max_length dd 255
	okNumber db 0
	okMulDiv db 0
	result dd 0
	format1 db "%d",0
.data? 
   
.code 
start:
	
	;Read string from file 
	;Example: '12+25/5*2-3*2/6='
	
	;Open file
	call open_file
	
	;Save file descriptor
	mov fp,eax
	
	;Read text string from file and save it in text array
	call read_string
	
	;Close read file
	call close_read_file
	
	;Create value array and sign array
	;Example value array: 12,25,5,2,3,2,6
	;Example sign array: +,/,*,-,*,/
	call create_arrays
	
	;Execute first order operations like multiplication and division and create new value array and
	;new sign array
	;Example new value array: 12,10,1
	;        new sign array: +,-
	call first_order_operations
	
	;Execute second order operations like addition and subtraction and save result 
	call second_order_operations
	
	;Save result from eax in result variable
	mov result,eax
	
	;Open file result.txt
	call open_write_file
	
	;Save file descriptor
	mov fout,eax
	
	;Store result in result.txt
	call write_result
	
	;Close write file
	call close_write_file
	
	;mov ebx,0
	;mov ecx,0
	;mov edx,0

	push 0 
	call exit
	
	;Open file in order to read the string
	open_file proc
		push offset mode_read
		push offset path
		call fopen
		add esp,8
		ret
	open_file endp
	
	;Save string in text array
	read_string proc
		
		loop_read_string:
		
		push fp
		push max_length
		push offset text
		call fgets
		add esp,12
		
		;Verify if the string is already saved in filename.txt 
		lea esi,text
		mov ebx,0
		mov bl,[esi]
		cmp bl,0
		je loop_read_string
		
		ret
	read_string endp
	
	;Create value array and sign array
	create_arrays proc
	
		lea esi,text
		lea edi,v
		lea edx,s
		
		mov eax,0 ; Accumulator used to compose numbers/values
		
		loop1:
		
		;Move character to ebx. The character could either be sign or a value
		mov ebx,0
		mov bl,[esi]
		
		;Verify if character is sign or not
		cmp ebx,42
		jb not_sign
		cmp ebx,47
		ja not_sign
		
		;If sign, call sign procedure
		sign:
		call sign_func
		jmp loop1
		
		;If not sign, compare the character to '='
		not_sign:
		
		;If the character is '=', this will mark the end of process of populating the value and
		;sign array. Therefore, it will be checked whether there is a number in the process of
		;composition
		cmp ebx,61 ; =
		je verify_last_number
		
		;Boolean okNumber has the role to mark the fact that a number is being composed
		cmp okNumber,1
		je create_number
		mov okNumber,1
		
		;Create number procedure in order to compose the number
		create_number:
		call create_number_func
		jmp loop1
		
		;Verify if there is a number in the process of composition
		;That number will be stored in the value array
		verify_last_number:
		cmp okNumber,1
		jne done
		mov [edi],eax
	
		done:
		ret
	create_arrays endp
	
	;Execute first order operations like multiplication and division
	first_order_operations proc
		
		;Load effective address of value array, sign array, new value array and new sign array
		call load_addresses
		
		loop2:
		
		;Store in ebx the sign
		mov ebx,0
		mov bl,[edi]
		
		;If the sign array reaches value 0, that means that there are no signs left in the array
		cmp bl,0 
		je verify_add_values
		cmp bl,43 ;+
		je verify_add_values
		cmp bl,45 ;-
		je verify_add_values
		
		;The sign is '*' or '/' and okMulDiv marks the fact that a multiplication or division process
		;has started
		mul_or_div:
		cmp okMulDiv,1
		je continue
		mov okMulDiv,1
		mov eax,0
		mov al,[esi]
		
		continue:
		cmp bl,42 ; '*'
		je multiply
		cmp bl,47 ; '/'
		je division
		
		multiply:
		
		call multiply_func
		jmp loop2
		
		division:
		
		call division_func
		jmp loop2
		
		next:
		inc esi
		
		verify_add_values:
		
		cmp okMulDiv,1
		je add_values
		
		skip:
		
		call skip_func
		
		cmp ebx,0
		je done1
		
		inc esi
		inc edi
		inc ecx
		inc edx
		jmp loop2
		
		add_values:
		
		call add_values_func
		
		cmp ebx,0
		je done1
		jmp loop2
		
		done1:
		ret
	first_order_operations endp
	
	;Load effective address of value array, sign array, new value array and new sign array
	load_addresses proc
		lea esi,v
		lea edi,s
		lea ecx,vn
		lea edx,sn
		ret
	load_addresses endp
	
	;Push edx address on the stack in order to use edx for multiplication, and then pop the value from the stack back in edx
	multiply_func proc
		push edx
		mov edx,0
		inc esi
		mov ebx,0
		mov bl,[esi]
		mul ebx
		pop edx
		inc edi
		ret
	multiply_func endp
	
	;Push edx address on the stack in order to use edx for division, and then pop the value from the stack back in edx
	division_func proc
		push edx
		mov edx,0
		inc esi
		mov ebx,0
		mov bl,[esi]
		div ebx
		pop edx
		inc edi
		ret
	division_func endp
	
	;Put the value from value array in new value array and the sign from sign array in new sign array
	skip_func proc
		push ebx
		
		mov ebx,0
		mov bl,[esi]
		mov [ecx],ebx
		mov bl,[edi]
		mov [edx],ebx
		
		pop ebx
		ret
	skip_func endp
	
	;Put the new value composed and stored in eax in new value array and the sign in new sign array
	add_values_func proc
		mov [ecx],eax
		mov [edx],ebx
		inc esi
		inc edi
		inc ecx
		inc edx
		mov okMulDiv,0
		ret
	add_values_func endp
	
	;Execute second order operations like addition and subtraction and save result 
	second_order_operations proc
		
		call initiate_second_order_operations
		
		loop3:
		mov ebx,0
		mov bl,[edi]
		
		;If the value in new sign array is zero, that means the operation is finished
		cmp bl,0
		je done2
		cmp bl,43 ;+
		je addition
		cmp bl,45 ;-
		je subtraction
		
		addition:
		call addition_func
		jmp loop3
		
		subtraction:
		call subtraction_func
		jmp loop3
		
		done2:
		ret
	second_order_operations endp
	
	;Add the values from the new value array
	addition_func proc
		mov ecx,0
		mov cl,[esi]
		add eax,ecx
		inc esi
		inc edi
		ret
	addition_func endp
	
	;Subtract the values from the new value array
	subtraction_func proc
		mov ecx,0
		mov cl,[esi]
		sub eax,ecx
		inc esi
		inc edi
		ret
	subtraction_func endp
	
	initiate_second_order_operations proc
		lea esi,vn
		lea edi,sn
		
		mov eax,0
		mov al,[esi]
		inc esi
		ret
	initiate_second_order_operations endp
	
	;Store the sign in sign array and the value in the value array
	;and initiate okNumber to mark the fact that no number is being composed
	;and eax register is free
	sign_func proc
		mov [edx],bl
		inc edx
		mov [edi],eax
		mov eax,0
		mov okNumber,0
		inc edi
		inc esi
		ret
	sign_func endp
	
	;Get the value from the ASCII Code and add it to the existing number in eax
	create_number_func proc
		sub ebx,48 ; '1' -> 1 or '2' -> 2...
		imul eax,10
		add eax,ebx
		inc esi
		ret
	create_number_func endp
	
	write_result proc
		;fprintf(fptr,"%d",num);
		push result
		push offset format1
		push fout 
		call fprintf
		add esp,12
		ret
	write_result endp
	
	close_write_file proc
		push fout
		call fclose
		add esp,4
		ret
	close_write_file endp
	
	close_read_file proc
		push fp
		call fclose
		add esp,4
		ret
	close_read_file endp
	
	open_write_file proc
		push offset mode_write
		push offset path1
		call fopen
		add esp,8
		ret
	open_write_file endp
end start 


