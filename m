Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0902574D5DC
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:40:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6O-0005Ra-1q; Mon, 10 Jul 2023 08:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qIq5z-0004Rr-Jo
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:27 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qIq5u-0004qV-DD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:34:27 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 2E78E428D3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 14:34:12 +0200 (CEST)
Message-ID: <db5140a2-6947-564b-afba-e0edda31c515@proxmox.com>
Date: Mon, 10 Jul 2023 14:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Subject: strace showing QEMU process doing >99% ppoll
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,
since a while we have about a dozen people reporting [0] VMs rarely
getting stuck with the QEMU process looping and just doing ppoll() and
not much else (example strace [1] output and stacktrace [2]).

Just wanted to ask if anybody here has seen something similar or ideas
what could go wrong? There seem to be at least two different issues:

1. QEMU process looping calling only ppoll, guest completely
non-responsive. I think QMP still working normally, but I had no debug
access to these unfortunately.

2. Also QEMU looping around ppool, but the PLT (process linkage table)
is corrupted [3]. I did have debug access to such a machine and saw the
jump to the wrong address first hand. Call into _ppoll() results landing
in the middle of internal_fallocate64 instead and the vCPU threads end
up in preadv64v2() (note that the flags=44672 very much looks like
KVM_RUN being AE80 in hex). AFAIU that memory should be read-only so
maybe a kernel bug (the machine I debugged was running on host kernel 5.15)?

It's difficult to see many commonalities in the reports:

I think all reporters are using KVM and mostly (the Proxmox build of)
QEMU 7.2 and 8.0. Issues reported for both AMD and Intel hosts and both
with Linux and Windows guests. Mostly for longer-running guests, but the
issue is very rare. Some people said everything was okay while they were
running host kernel 5.15, but had issues with 5.19 and 6.2, but others
had issues while running 5.15 too. Not sure if relevant, but as drives,
most people use virtio-scsi-pci, some with iothread, some without, some
with aio=io_uring, some without.

Best Regards,
Fiona

[0]: https://forum.proxmox.com/threads/127459/

[1]:

> strace -c -p $(cat /var/run/qemu-server/191.pid)
> strace: Process 50940 attached
> ^Cstrace: Process 50940 detached
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  99.71   19.739996       10527      1875           ppoll
>   0.17    0.034197           4      6938           write
>   0.07    0.013513           7      1698           recvmsg
>   0.05    0.009642           5      1876        40 read
>   0.00    0.000076           2        33           sendmsg
>   0.00    0.000036           4         8           accept4
>   0.00    0.000030           3         8           close
>   0.00    0.000013           0        16           fcntl
>   0.00    0.000009           1         8           getsockname
> ------ ----------- ----------- --------- --------- ----------------
> 100.00   19.797512        1588     12460        40 total
> 

Different one, no read errors, but still only ppoll

> strace -c -p $(cat /var/run/qemu-server/$ID.pid)
> strace: Process 38494 attached
> ^Cstrace: Process 38494 detached
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  99.71   19.803374       34621       572           ppoll
>   0.14    0.028442          13      2136           write
>   0.08    0.016147          29       549           read
>   0.06    0.012145          23       523           recvmsg
>   0.00    0.000007           0        10           sendmsg
>   0.00    0.000002           1         2           close
>   0.00    0.000001           0         2           accept4
>   0.00    0.000000           0         2           getsockname
>   0.00    0.000000           0         4           fcntl
> ------ ----------- ----------- --------- --------- ----------------
> 100.00   19.860118        5226      3800           total

[2]:

>  gdb --batch --ex 't a a bt' -p $(cat /var/run/qemu-server/191.pid)
> [New LWP 50941]
> [New LWP 50948]
> [New LWP 50949]
> [New LWP 51267]
> [New LWP 51269]
> [New LWP 51270]
> [New LWP 51271]
> [New LWP 51274]
> [New LWP 51283]
> [New LWP 2639435]
> [New LWP 1133766]
> [New LWP 1148438]
> [New LWP 1153824]
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
> 0x00007efd30182a66 in __ppoll (fds=0x565319eca320, nfds=145, timeout=<optimized out>, timeout@entry=0x7fff11a5e1e0, sigmask=sigmask@entry=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:44
> 44      ../sysdeps/unix/sysv/linux/ppoll.c: No such file or directory.
> 
> Thread 14 (Thread 0x7efd24d54700 (LWP 1153824) "iou-wrk-50948"):
> #0  0x0000000000000000 in ?? ()
> Backtrace stopped: Cannot access memory at address 0x0
> 
> Thread 13 (Thread 0x7efd1ffff700 (LWP 1148438) "iou-wrk-50949"):
> #0  0x0000000000000000 in ?? ()
> Backtrace stopped: Cannot access memory at address 0x0
> 
> Thread 12 (Thread 0x7efd1ffff700 (LWP 1133766) "iou-wrk-50949"):
> #0  0x0000000000000000 in ?? ()
> Backtrace stopped: Cannot access memory at address 0x0
> 
> Thread 11 (Thread 0x7efd24d54700 (LWP 2639435) "iou-wrk-50948"):
> #0  0x0000000000000000 in ?? ()
> Backtrace stopped: Cannot access memory at address 0x0
> 
> Thread 10 (Thread 0x7ef90afbf700 (LWP 51283) "vnc_worker"):
> #0  futex_wait_cancelable (private=0, expected=0, futex_word=0x56531971294c) at ../sysdeps/nptl/futex-internal.h:186
> #1  __pthread_cond_wait_common (abstime=0x0, clockid=0, mutex=0x565319712958, cond=0x565319712920) at pthread_cond_wait.c:508
> #2  __pthread_cond_wait (cond=cond@entry=0x565319712920, mutex=mutex@entry=0x565319712958) at pthread_cond_wait.c:638
> #3  0x00005653187a99cb in qemu_cond_wait_impl (cond=0x565319712920, mutex=0x565319712958, file=0x565318820434 "../ui/vnc-jobs.c", line=248) at ../util/qemu-thread-posix.c:220
> #4  0x00005653182385c3 in vnc_worker_thread_loop (queue=0x565319712920) at ../ui/vnc-jobs.c:248
> #5  0x0000565318239288 in vnc_worker_thread (arg=arg@entry=0x565319712920) at ../ui/vnc-jobs.c:361
> #6  0x00005653187a8e89 in qemu_thread_start (args=0x7ef90afba3f0) at ../util/qemu-thread-posix.c:505
> #7  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #8  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 9 (Thread 0x7efd1d1ff700 (LWP 51274) "SPICE Worker"):
> #0  0x00007efd3018296f in __GI___poll (fds=0x7ef900001ff0, nfds=2, timeout=2147483647) at ../sysdeps/unix/sysv/linux/poll.c:29
> #1  0x00007efd315f80ae in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #2  0x00007efd315f840b in g_main_loop_run () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #3  0x00007efd31ca1fe7 in ?? () from /lib/x86_64-linux-gnu/libspice-server.so.1
> #4  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #5  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 8 (Thread 0x7efd1dffb700 (LWP 51271) "CPU 3/KVM"):
> #0  0x00007efd30184237 in ioctl () at ../sysdeps/unix/syscall-template.S:120
> #1  0x0000565318621997 in kvm_vcpu_ioctl (cpu=cpu@entry=0x5653196eea10, type=type@entry=44672) at ../accel/kvm/kvm-all.c:3035
> #2  0x0000565318621b01 in kvm_cpu_exec (cpu=cpu@entry=0x5653196eea10) at ../accel/kvm/kvm-all.c:2850
> #3  0x000056531862317d in kvm_vcpu_thread_fn (arg=arg@entry=0x5653196eea10) at ../accel/kvm/kvm-accel-ops.c:51
> #4  0x00005653187a8e89 in qemu_thread_start (args=0x7efd1dff63f0) at ../util/qemu-thread-posix.c:505
> #5  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #6  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 7 (Thread 0x7efd1e7fc700 (LWP 51270) "CPU 2/KVM"):
> #0  0x00007efd30184237 in ioctl () at ../sysdeps/unix/syscall-template.S:120
> #1  0x0000565318621997 in kvm_vcpu_ioctl (cpu=cpu@entry=0x5653196e6d20, type=type@entry=44672) at ../accel/kvm/kvm-all.c:3035
> #2  0x0000565318621b01 in kvm_cpu_exec (cpu=cpu@entry=0x5653196e6d20) at ../accel/kvm/kvm-all.c:2850
> #3  0x000056531862317d in kvm_vcpu_thread_fn (arg=arg@entry=0x5653196e6d20) at ../accel/kvm/kvm-accel-ops.c:51
> #4  0x00005653187a8e89 in qemu_thread_start (args=0x7efd1e7f73f0) at ../util/qemu-thread-posix.c:505
> #5  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #6  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 6 (Thread 0x7efd1effd700 (LWP 51269) "CPU 1/KVM"):
> #0  0x00007efd30184237 in ioctl () at ../sysdeps/unix/syscall-template.S:120
> #1  0x0000565318621997 in kvm_vcpu_ioctl (cpu=cpu@entry=0x5653196deee0, type=type@entry=44672) at ../accel/kvm/kvm-all.c:3035
> #2  0x0000565318621b01 in kvm_cpu_exec (cpu=cpu@entry=0x5653196deee0) at ../accel/kvm/kvm-all.c:2850
> #3  0x000056531862317d in kvm_vcpu_thread_fn (arg=arg@entry=0x5653196deee0) at ../accel/kvm/kvm-accel-ops.c:51
> #4  0x00005653187a8e89 in qemu_thread_start (args=0x7efd1eff83f0) at ../util/qemu-thread-posix.c:505
> #5  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #6  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 5 (Thread 0x7efd1f7fe700 (LWP 51267) "CPU 0/KVM"):
> #0  0x00007efd30184237 in ioctl () at ../sysdeps/unix/syscall-template.S:120
> #1  0x0000565318621997 in kvm_vcpu_ioctl (cpu=cpu@entry=0x5653196af6c0, type=type@entry=44672) at ../accel/kvm/kvm-all.c:3035
> #2  0x0000565318621b01 in kvm_cpu_exec (cpu=cpu@entry=0x5653196af6c0) at ../accel/kvm/kvm-all.c:2850
> #3  0x000056531862317d in kvm_vcpu_thread_fn (arg=arg@entry=0x5653196af6c0) at ../accel/kvm/kvm-accel-ops.c:51
> #4  0x00005653187a8e89 in qemu_thread_start (args=0x7efd1f7f93f0) at ../util/qemu-thread-posix.c:505
> #5  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #6  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 4 (Thread 0x7efd1ffff700 (LWP 50949) "kvm"):
> #0  0x00007efd30182a66 in __ppoll (fds=0x7efd1741a310, nfds=8, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:44
> #1  0x00005653187bde6d in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
> #2  0x00005653187a6999 in fdmon_poll_wait (ctx=0x5653194cd000, ready_list=0x7efd1fffa368, timeout=-1) at ../util/fdmon-poll.c:80
> #3  0x00005653187a6076 in aio_poll (ctx=0x5653194cd000, blocking=blocking@entry=true) at ../util/aio-posix.c:660
> #4  0x000056531865f946 in iothread_run (opaque=opaque@entry=0x5653194cb260) at ../iothread.c:67
> #5  0x00005653187a8e89 in qemu_thread_start (args=0x7efd1fffa3f0) at ../util/qemu-thread-posix.c:505
> #6  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #7  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 3 (Thread 0x7efd24d54700 (LWP 50948) "kvm"):
> #0  0x00007efd30182a66 in __ppoll (fds=0x7efd18003000, nfds=8, timeout=<optimized out>, timeout@entry=0x0, sigmask=sigmask@entry=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:44
> #1  0x00005653187bde6d in ppoll (__ss=0x0, __timeout=0x0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
> #2  0x00005653187a6999 in fdmon_poll_wait (ctx=0x5653194ca670, ready_list=0x7efd24d4f368, timeout=-1) at ../util/fdmon-poll.c:80
> #3  0x00005653187a6076 in aio_poll (ctx=0x5653194ca670, blocking=blocking@entry=true) at ../util/aio-posix.c:660
> #4  0x000056531865f946 in iothread_run (opaque=opaque@entry=0x56531939fd00) at ../iothread.c:67
> #5  0x00005653187a8e89 in qemu_thread_start (args=0x7efd24d4f3f0) at ../util/qemu-thread-posix.c:505
> #6  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #7  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 2 (Thread 0x7efd25656700 (LWP 50941) "call_rcu"):
> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> #1  0x00005653187aa04a in qemu_futex_wait (val=<optimized out>, f=<optimized out>) at /build/pve-qemu/pve-qemu-kvm-7.2.0/include/qemu/futex.h:29
> #2  qemu_event_wait (ev=ev@entry=0x56531900b328 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:430
> #3  0x00005653187b294a in call_rcu_thread (opaque=opaque@entry=0x0) at ../util/rcu.c:261
> #4  0x00005653187a8e89 in qemu_thread_start (args=0x7efd256513f0) at ../util/qemu-thread-posix.c:505
> #5  0x00007efd3026eea7 in start_thread (arg=<optimized out>) at pthread_create.c:477
> #6  0x00007efd3018ea2f in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> Thread 1 (Thread 0x7efd257b91c0 (LWP 50940) "kvm"):
> #0  0x00007efd30182a66 in __ppoll (fds=0x565319eca320, nfds=145, timeout=<optimized out>, timeout@entry=0x7fff11a5e1e0, sigmask=sigmask@entry=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:44
> #1  0x00005653187bde11 in ppoll (__ss=0x0, __timeout=0x7fff11a5e1e0, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/x86_64-linux-gnu/bits/poll2.h:77
> #2  qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=1552585705) at ../util/qemu-timer.c:351
> #3  0x00005653187bb675 in os_host_main_loop_wait (timeout=1552585705) at ../util/main-loop.c:315
> #4  main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:606
> #5  0x00005653183d8191 in qemu_main_loop () at ../softmmu/runstate.c:739
> #6  0x0000565318211aa7 in qemu_default_main () at ../softmmu/main.c:37
> #7  0x00007efd300b6d0a in __libc_start_main (main=0x56531820cc60 <main>, argc=82, argv=0x7fff11a5e3a8, init=<optimized out>, fini=<optimized out>, rtld_fini=<optimized out>, stack_end=0x7fff11a5e398) at ../csu/libc-start.c:308
> #8  0x00005653182119da in _start ()
> [Inferior 1 (process 50940) detached]

[3]: PLT corruption!?

> Thread 3 (Thread 0x7ff54a87b700 (LWP 38670) "CPU 0/KVM"):
> #0  0x00007ff555ef25f7 in preadv64v2 (fd=-137845280, vector=0x558ff4f8f817, count=0, offset=1, flags=44672) at ../sysdeps/unix/sysv/linux/preadv64v2.c:31
> #1  0x0000000000000000 in ?? ()
> 
> Thread 1 (Thread 0x7ff54b2df040 (LWP 38494) "kvm"):
> #0  0x00007ff555ef0e26 in internal_fallocate64 (fd=-137380896, offset=80, len=140735731015936) at ../sysdeps/posix/posix_fallocate64.c:36
> #1  0x0000000000000000 in ?? ()



