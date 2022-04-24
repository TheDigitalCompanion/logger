#include <stdlib.h>
#include <stdio.h>
#include <dlfcn.h>
#include "std_libc.h"

#ifndef RTLD_DEFAULT
#  define RTLD_DEFAULT ((void *) 0)
#endif

/* this is test case              */
int main(int argc, char **argv)
{
   if(argc < 2)
   {
      printf("Usage: %s <program> [ arg1 arg2 ... argN ]>\n", argv[0]);
      exit(1); 
   }
   
   void *handle = dlopen(STD_LIBC_PATH, RTLD_LAZY);

   //simple test to see if the func in memory matches libc.so.6
   if(dlsym(handle, "execve") == dlsym(RTLD_DEFAULT, "execve"))
   {
      /* not overridden, setup LD_PRELOAD  */
      putenv("LD_PRELOAD=" LOGGER_PATH "/logger.so");
      
      nanosleep(100);
      printf("setting up LD_PRELOAD (ctrl + c to escape)\n");
      execv(argv[0], argv);
      perror("execv");
      exit(1);
   }
   
   printf("execute: %s\n", argv[1]);
   execv(argv[1], argv+1);
   perror("execv");
   
   return 1;   
}

