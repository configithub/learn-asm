  .section .data


  .section .text
  .globl _start
_start:

  pushl $5                    # push number 5 to the stack
  call factorial              # call the factorial function
  addl $4, %esp               # move back 4 bytes (1 long int) the stack pointer
                              # to release the function param (5)
  
  pushl %eax                  # keep the result on the stack
  
  pushl $2
  call factorial
  addl $4, %esp

  popl %ebx                   # retrieve the first result from the stack put it in ebx, the other is in eax

  addl %eax, %ebx             # add the two results, the sum is now in ebx

  movl $1, %eax               # put 1 in eax to prepare the exit system call
  int $0x80                   # call interrupt 0x80 to call the system
  
  


  .type factorial, @function
factorial:

  pushl %ebp                  # save current value of the base pointer to the stack
  movl %esp, %ebp             # set the new base pointer to the top of the stack, any value put in the stack from here is local to the function


  movl 8(%ebp), %eax          # first param of the function is 8(%ebp), return value is 4(%ebp)
  cmpl $1, %eax
  je factorial_exit
  decl %eax
  pushl %eax
  call factorial  
  popl %ebx                   # we need to clean the stack manually,
  incl %ebx
  imul %ebx, %eax             # return value of the function should be in eax


factorial_exit:

  movl %ebp, %esp
  popl %ebp
  ret




