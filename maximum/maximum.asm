  .section .data
data_items:
  .long 1,7,15,26,3,14,55,36,0              # the list of integer to process, 0 indicates the end of the list


  .section .text
  .globl _start
_start:
  movl $0, %edi                             # edi is the indexing register, it will hold our iterator
  movl data_items(,%edi,4), %eax            # pick the value pointed by our iterator and put it in eax
  movl %eax, %ebx                           # ebx will hold the result, for now put in our first value

start_loop:
  cmpl $0, %eax                             # is 0 in eax ? 
  je loop_exit                              # if yes, jump to loop_exit
  incl %edi                                 # if no, increment our iterator
  movl data_items(,%edi,4), %eax            # pick next value and put it in eax
  cmpl %ebx, %eax                           # compare eax and ebx
  jle start_loop                            # if eax <= ebx, start the loop again
  movl %eax, %ebx                           # else put the value of eax in ebx, that is our new maximum
  jmp start_loop                            # and jump to the beginning of the loop

loop_exit:
  movl $1, %eax                             # exit system call will be called, its return valie is already in ebx
  int $0x80                                 # call the system
  
  
  
