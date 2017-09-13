//
//  main.m
//  JailbreakDetection
//
//  Created by Augusta Bogie on 2/13/16.
//  Copyright © 2016 Augusta Bogie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/sysctl.h>
#include <stdlib.h>
#import <dlfcn.h>

typedef int (*ptrace_ptr_t)(int request, pid_t pid, caddr_t addr, int data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif  // !defined(PT_DENY_ATTACH)

void disable_gdb();

static int is_debugger_present(void)
{
    int name[4];
    struct kinfo_proc info;
    size_t info_size = sizeof(info);
    
    info.kp_proc.p_flag = 0;
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    
    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        perror("sysctl");
        exit(-1);
    }
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

void disable_gdb()
{
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    printf("ARGH!!! you try to attach to me USING GDB! ~ @MasBog");
    dlclose(handle);
}

int main3(int argc, char *argv[])
{
    return -1;
}

int main(int argc, char * argv[]) {
    if (is_debugger_present())
    {
        printf("ARGH!!! you try to attach to me USING DEBUGGER! ~ @MasBog");
        return -1;
    }else{
        disable_gdb();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
