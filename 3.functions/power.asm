  .section .data
    # nothing here, no global variables in this program

  .section .text
  .globl _start
_start:
  pushl $2              # push the 2nd arg to the stack, value : 2 (power : 2)
  pushl $2              # push the 1st arg to the stack, value : 2 (x : 2)
  call power            # call the function with the 2 args
  addl $8, %esp         # move the stack pointer for 2 longs
                        # this essentially releases the memory for our 2 params
  pushl %eax            # eax holds the result of our function call, save this in the stack to reuse it later

  pushl $3
  pushl $2
  call power
  addl $8, %esp

  popl %ebx             # retrieve the result of our 1st function call from the top of the stack and put it in register ebx, the result of the 2nd function call is already in register eax

  addl %eax, %ebx       # add the two results, the sum is now in ebx

  movl $1, %eax         # put the value 1 in eax for the exit system call
  int $0x80             # call the system for exit, the value in ebx is returned


# power function definition : 

  .type power, @function    
power:
  pushl %ebp            # save the old base pointer register to the stack
  movl %esp, %ebp       # put the address of the top of the stack in base pointer
                        # the stuff we put in the stack after this are the local variables, they will be trashed at the end of the function call   
  subl $4, %esp         # substract the size of a long to esp, this makes room for one local variable of type long, at the top of the stack 
                                            # (the stack is reversed, going up means substracting values to esp)
  movl 8(%ebp), %ebx    # put the first argument of the function in ebx register (it was stored in the stack at ebp+8)
  movl 12(%ebp), %ecx   # put the 2nd argument of the function in ecx register

  movl %ebx, -4(%ebp)   # store the current result (our 1st param) in our local variable allocated 3 steps before
  
power_loop_start:
  cmpl $1, %ecx         # compare ecx to 1
  je end_power          # jump to end_power if they are equal
  movl -4(%ebp), %eax   # else move the current result value in eax
  imul %ebx, %eax       # multiply the current result and the first argument, the result of the operation will be in eax
  movl %eax, -4(%ebp)   # keep the new current result in the local variable
  decl %ecx             # decrement the power value by 1
  jmp power_loop_start  # redo the loop
  


end_power:
  movl -4(%ebp), %eax   # put the result of our function, previously stored in our local variable, in the eax register
  movl %ebp, %esp       # restore the stack pointer to its original value which was stored in the base register
  popl %ebp             # restore the base pointer
  ret                   # return



