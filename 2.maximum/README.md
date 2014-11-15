maximum.asm
=========

find the maximum value among a list of int hardcoded
give the result in the return value of the process : 

./maximum
echo $?

concepts introduced:
=========

##registers : 

edi, indexing register, used to store the iterator on the integer array

eax, contains the next value to be compared to the maximum value as of now

ebx, contains the result, also contains the return value of the exit system call

##instructions :

je, jump if equal

jl, jump if lower

jle, jump if lower or equal

same fore jg, jge, all these are used in conjuction with:

cmpl, compare two values 

jmp, simple jump

movl, move a value into a register

int, interrupt, we use it for system calls with value 0x80

