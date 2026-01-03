# Super Nintendo Build System for Sublime Text

Various scripts for building SNES ROMs from code editors. This is using the wla-65816 assembler and linker. 
Note that this only works with a single object (ie main.asm becomes main.o), and doesn't take into account .spc (sound) code. 
I believe this also assumes the wla assembler and linker are in your PATH.

A(n old) demo of the Sublime Text version can be found [here](https://www.youtube.com/watch?v=Syg1kzBPyXU)

## note the following: 
- the Sublime Text version assumes a syntax of an old version of wlalink and wla-65816. 

## notes for vscode
- this is a shell script
- it assumes wlalink and wla-65816 are in your PATH. 
- I have tested it with wla-65816 v.10.6 (syntax may be slightly different at some point in the future?)
- I have copied the shell script to my PATH and then removed the .sh extension
- you can invoke it with debug or release. 
    - I have .sfc files associated with NO$SNS (a debugging emulator)
    - I have .smc files associated with ZSNES (my "recreational" emulator)
- it assumes you are in terminal and in the folder where your files live
    - it assumes your main code is in main.asm
    - it assumes you have a file called header.inc with the internal rom name (this is used to create the file name)
    - it assumes you want to put the rom file into a folder called ROM at the same level
- the script adds a timestamp to the file name, assuming you are debugging.


