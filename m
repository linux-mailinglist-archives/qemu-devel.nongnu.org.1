Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CE073CB64
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 16:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD4HG-0005u8-4I; Sat, 24 Jun 2023 10:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qD4H7-0005t5-D8; Sat, 24 Jun 2023 10:30:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qD4H5-0000N7-4s; Sat, 24 Jun 2023 10:30:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A7B0E893;
 Sat, 24 Jun 2023 17:29:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4E6B9F265;
 Sat, 24 Jun 2023 17:29:42 +0300 (MSK)
Message-ID: <6ec3dab5-06a2-1295-ce01-6a89550e26fc@tls.msk.ru>
Date: Sat, 24 Jun 2023 17:29:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: qemu-system-ppc64 option -smp 2 broken with commit
 20b6643324a79860dcdfe811ffe4a79942bca21e
Content-Language: en-US
To: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com
References: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

23.06.2023 14:09, Anushree Mathur wrote:
> Hi everyone,
> 
> I was trying to boot rhel9.3 image with upstream qemu-system-ppc64 -smp 2 option and observed a segfault (qemu crash).
> 
> qemu command line used:
> 
> qemu-system-ppc64 -name Rhel9.3.ppc64le -smp 2 -m 16G -vga none -nographic -machine pseries -cpu POWER10 -accel tcg -device virtio-scsi-pci -drive 
> file=/home/rh93.qcow2,if=none,format=qcow2,id=hd0 -device scsi-hd,drive=hd0 -boot c
> 
> After doing a git bisect, I found the first bad commit which introduced this issue is below:
> 
> [qemu]# git bisect good
> 20b6643324a79860dcdfe811ffe4a79942bca21e is the first bad commit
> commit 20b6643324a79860dcdfe811ffe4a79942bca21e
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Dec 5 17:45:02 2022 -0600
> 
>      tcg/ppc: Reorg goto_tb implementation

I've got another case which leads to this same commit, with similar results,
on a debian ppc64 machine with qemu 8.0 and master.

The crash doesn't happen every time, sometimes it needs 20+ iterations
to trigger (so my bisection was rather painful, initially pointing to
an entirely innocent commit).  So far it only occurs on actual ppc64
machine, - I weren't able to reproduce it on amd64.

Sometimes (more often) it ends with SIGSEGV, but sometimes it also fails
with Illegal Instruction.  Examining it with gdb - it looks more like a
stack corruption.

I triggered it by just booting a linux system. When it fails, most often
it fails somewhere at the end of boot, but sometimes it does that the moment
kernel spawns /init from initramfs and that one (a shell script) executes
first program.



[  OK  ] Finished systemd-journal-f…ush Journal to Persistent Storage.
          Starting systemd-tmpfiles-… Volatile Files and Directories...
[  OK  ] Finished systemd-udev-trig…e - Coldplug All udev Devices.
[  OK  ] Finished systemd-tmpfiles-…te Volatile Files and Directories.
          Starting systemd-resolved.…e - Network Name Resolution...
          Starting systemd-update-ut…rd System Boot/Shutdown in UTMP...
[  OK  ] Started systemd-udevd.serv…nager for Device Events and Files.
          Starting systemd-networkd.…ice - Network Configuration...
Segmentation fault (core dumped)

...
Core was generated by `qemu-system-ppc64 -append root=LABEL=debvm rw -nographic -smp 2 -machine accel='.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x00007fff3462395c in code_gen_buffer ()
[Current thread is 1 (Thread 0x7fff79c6e7c0 (LWP 922586))]
(gdb) bt
#0  0x00007fff3462395c in code_gen_buffer ()
#1  0x00000001076cbd2c in cpu_tb_exec (cpu=cpu@entry=0x1001d98b320, itb=itb@entry=0x7fff4b378480 <code_gen_buffer+383812548>,
     tb_exit=tb_exit@entry=0x7fff79c6d8c0) at accel/tcg/cpu-exec.c:460
#2  0x00000001076cc348 in cpu_loop_exec_tb (tb_exit=0x7fff79c6d8c0, last_tb=<synthetic pointer>, pc=140736355546736,
     tb=0x7fff4b378480 <code_gen_buffer+383812548>, cpu=<optimized out>) at accel/tcg/cpu-exec.c:893
#3  cpu_exec_loop (cpu=cpu@entry=0x1001d98b320, sc=sc@entry=0x7fff79c6da10) at accel/tcg/cpu-exec.c:1013
#4  0x00000001076ccd98 in cpu_exec_setjmp (cpu=cpu@entry=0x1001d98b320, sc=sc@entry=0x7fff79c6da10)
     at accel/tcg/cpu-exec.c:1043
#5  0x00000001076cd5ec in cpu_exec (cpu=0x1001d98b320) at accel/tcg/cpu-exec.c:1069
#6  0x0000000107705d30 in tcg_cpus_exec (cpu=0x1001d98b320) at accel/tcg/tcg-accel-ops.c:81
#7  0x0000000107705f20 in mttcg_cpu_thread_fn (arg=0x1001d98b320) at accel/tcg/tcg-accel-ops-mttcg.c:95
#8  0x000000010793ed7c in qemu_thread_start (args=<optimized out>) at util/qemu-thread-posix.c:541
#9  0x00007fff81673d0c in ?? () from /lib/powerpc64le-linux-gnu/libc.so.6
#10 0x00007fff81724350 in clone () from /lib/powerpc64le-linux-gnu/libc.so.6

(gdb) l
32	
33	int qemu_default_main(void)
34	{
35	   int status;
36	
37	   status = qemu_main_loop();
38	   qemu_cleanup();
39	
40	   return status;
41	}

(gdb) frame 1
#1  0x00000001076cbd2c in cpu_tb_exec (cpu=cpu@entry=0x1001d98b320, itb=itb@entry=0x7fff4b378480 <code_gen_buffer+383812548>,
     tb_exit=tb_exit@entry=0x7fff79c6d8c0) at accel/tcg/cpu-exec.c:460
460	   ret = tcg_qemu_tb_exec(env, tb_ptr);
(gdb) l
455	   if (qemu_loglevel_mask(CPU_LOG_TB_CPU | CPU_LOG_EXEC)) {
456	       log_cpu_exec(log_pc(cpu, itb), cpu, itb);
457	   }
458	
459	   qemu_thread_jit_execute();
460	   ret = tcg_qemu_tb_exec(env, tb_ptr);
461	   cpu->can_do_io = 1;
462	   qemu_plugin_disable_mem_helpers(cpu);
463	   /*
464	    * TODO: Delay swapping back to the read-write region of the TB


(this is 8.0.2, the same happens with master).

Here, frame#0 appears corrupt.

Other attempts, sometimes stack frame is corrupt to a way so gdb can't decode it
at all.

I need help debugging this further.

Thanks,

/mjt

