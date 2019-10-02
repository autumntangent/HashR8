# HASHR8  

## README

**A simple shell script to assist with generating/creating MD5 hash lists, either randomly or with given strings.**


## About

HASHR8 is a **BASH** script that will easily generate a hash list either randomly, with given strings, or both.
The default hashing algorithm used is **MD5**.  

You can change the **$PATH** to the **$HASHLIST** at any time while running the script OR you can change it in the script by 
doing this:  
> nano/vim HASHR8.sh  
You can change this by inputting your desired value under the **$VARIABLES** that are named:  
> PATH=""  
> HASHLIST=""  

All hashes will be **APPENDED** to the given $HASHLIST, so all hashes and/or other content will remain in the file. 

**This script has only been tested on MACOSX/UNIX systems using BASH.**

## Configuration && Running The Script

Running the script is pretty simple:

   git clone https://github.com/autumntangent/HashR8.git  
   cd HashR8  
   chmod 755 HashR8.sh  
   OR chmod +x HashR8.sh  
   #*This step is needed to give your user execute permission, either one will work*  
   ./HashR8.sh  


**Voila!** That's all you need to run the script without changing any configuration.

## Tweaking

I left comments throughout the script to assist with tweaking if need be.



