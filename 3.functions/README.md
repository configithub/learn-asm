functions.asm
=========


concepts introduced:
=========

##registers :

esp, the stack register, contains a pointer to the top of the stack

ebp, the base pointer register, used to store the old value of esp when we do a function calls, to permit us to trash the part of the stack that was used by this function to store its local variables. it is also used to get the address of the function parameters. it is a beacon to delimit the memory local to a function from the outside memory

it contains the address next to which we can find the local variables and function params of the currently called function (on top and below respectively)

## instructions :

pushl, put something at the top of the stack, esp is incremented as needed

popl, remove something from the tope of the stack, esp is decreased as needed, put the corresponding value in the given register

ex: popl eax, remove the top of the stack and put the value that was here into the eax register

## indirect adressing mode :

movl (%esp), eax

this puts the value pointed by register esp, which is the value stored at the top of the stack by definition of esp, in the eax register

movl 4(%esp), eax

this puts the value pointed by register address (esp+4), or the second value stored from the top of the stack, if the stack holds long integers (i.e. 4 bytes)

## function call :

before calling a function, all the function parameters are stored (in reverse order) on the stack, followed by the return adress

after the return adress we store the old value of the base point register : ebp

after the old ebp, we reserve memory space for the local variables of the function

```
[smaller addresses]
Local Variable 2 <--- -8(%ebp) and (%esp), top of the stack
Local Variable 1 <--- -4(%ebp)
Old %esp         <--- (%ebp), we will restore this value in esp after the function call,
                                          and popl esb back
Return Address   <--- 4(%ebp), where we need to go back to after the function call
Parameter 1      <--- 8(%ebp)
Parameter 2      <--- 12(%ebp)
...
Parameter #N     <--- N*4+4(%ebp)
[bigger addresses]
```

The stack is stored backwards : smaller address are at the top. New values are pushed to it at the top.

## function return :

```
movl %ebp, %esp     # bring back the stack pointer to where it was before the function call
popl %ebp           # put the base pointer here 
ret                 # return
```



