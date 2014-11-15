functions.asm
=========


concepts introduced:
=========

##registers :

esp, the stack register, contains a pointer to the top of the stack

ebp, the base pointer register, used to store the old value of esp when we do a function calls, to permit us to trash the part of the stack that we used by this function to store its local variables. it is also used to get the address of the function parameters. it is a beacon to delimit the memory local to a function from the outside memory

## instructions :

pushl, put something at the top of the stack, esp is incremented as needed

popl, remove something from the tope of the stack, esp is decreased as needed

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
Parameter #N     <--- N*4+4(%ebp)

...

Parameter 2      <--- 12(%ebp)

Parameter 1      <--- 8(%ebp)

Return Address   <--- 4(%ebp), where we need to go back to after the function call

Old %ebp         <--- (%ebp), we will restore this value in ebp after the function call, 
                                          and reset the top of the stack here as well

Local Variable 1 <--- -4(%ebp)

Local Variable 2 <--- -8(%ebp) and (%esp), top of the stack
```





