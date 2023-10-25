Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1007D6B82
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 14:29:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvczd-0005DI-9l; Wed, 25 Oct 2023 08:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qvczS-0005B9-JQ; Wed, 25 Oct 2023 08:28:02 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qvczO-00038v-7s; Wed, 25 Oct 2023 08:28:00 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id ACE4D45EBB;
 Wed, 25 Oct 2023 14:27:46 +0200 (CEST)
Message-ID: <3d4cfc31-beb9-4b89-b185-13c6e01ede49@proxmox.com>
Date: Wed, 25 Oct 2023 14:27:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] mirror: allow switching from background to active
 mode
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <ZTEwzi8x6cFfP9+e@redhat.com>
 <b81617df-2a68-4a89-9518-8441e01aaa0f@proxmox.com>
In-Reply-To: <b81617df-2a68-4a89-9518-8441e01aaa0f@proxmox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 23.10.23 um 13:39 schrieb Fiona Ebner:
> Am 19.10.23 um 15:36 schrieb Kevin Wolf:
>> Most of this series looks good to me. Apart from the comments I made in
>> the individual patches, I would like to see iotests coverage of changing
>> the mirroring mode. At the least to show that the query result changes,
>> but ideally also that requests really block after switchting to active.
>> I think with a throttled target node and immediately reading the target
>> when the write request completes we should be able to check this.
>>
> 
> I'll try to work something out for v4.
> 

I'm having a bit of a hard time unfortunately. I created a throttle
group with

>                 'iops-total': iops,
>                 'iops-total-max': iops

and used that for the 'throttle' driver for the target. I then tried
issuing requests via qemu_io

>             self.vm.hmp_qemu_io('mirror-top',
>                                 f'aio_write -P 1 {req_size * i} {req_size * (i + 1)}')

but when I create more requests than the 'iops' limit (to ensure that
not all are completed immediately), it will get stuck when draining the
temporary BlockBackend used by qemu_io [0]. Note this is while still in
background mode.

I also wanted to have request going on while the copy mode is changed
and for that, I was able to work around the issue by creating an NBD
export of the source like in iotest 151 and issuing the requests to the
NBD socket instead.

But after I switch to active mode and when I issue more than the 'iops'
limit requests to the NBD export then, it also seems to get stuck,
visible during shutdown when it tries to close the export[1].

Happy about any hints/suggestions :)

Best Regards,
Fiona

[0]:

> Thread 4 (Thread 0x7f0101f876c0 (LWP 46638) "qemu-system-x86"):
> #0  0x00007f010decbc02 in __GI___sigtimedwait (set=set@entry=0x7f0101f822e0, info=info@entry=0x7f0101f82210, timeout=timeout@entry=0x0) at ../sysdeps/unix/sysv/linux/sigtimedwait.c:31
> #1  0x00007f010decb31c in __GI___sigwait (set=0x7f0101f822e0, sig=0x7f0101f822d0) at ../sysdeps/unix/sysv/linux/sigwait.c:28
> #2  0x00005612182e2c96 in dummy_cpu_thread_fn (arg=0x561219892a90) at ../accel/dummy-cpus.c:50
> #3  0x0000561218729f03 in qemu_thread_start (args=0x56121989bc80) at ../util/qemu-thread-posix.c:541
> #4  0x00007f010df18044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #5  0x00007f010df9861c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 3 (Thread 0x7f01027886c0 (LWP 46637) "qemu-system-x86"):
> #0  0x00007f010df8b05f in __GI___poll (fds=0x7f00f4003320, nfds=3, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
> #1  0x00007f010f2009ae in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #2  0x00007f010f200cef in g_main_loop_run () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #3  0x000056121856b683 in iothread_run (opaque=0x5612194df940) at ../iothread.c:70
> #4  0x0000561218729f03 in qemu_thread_start (args=0x56121955c1d0) at ../util/qemu-thread-posix.c:541
> #5  0x00007f010df18044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #6  0x00007f010df9861c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 2 (Thread 0x7f010308a6c0 (LWP 46636) "qemu-system-x86"):
> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> #1  0x0000561218729b69 in qemu_futex_wait (f=0x561219185498 <rcu_call_ready_event>, val=4294967295) at /home/febner/repos/qemu/include/qemu/futex.h:29
> #2  0x0000561218729d50 in qemu_event_wait (ev=0x561219185498 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:464
> #3  0x0000561218737107 in call_rcu_thread (opaque=0x0) at ../util/rcu.c:278
> #4  0x0000561218729f03 in qemu_thread_start (args=0x5612194c35b0) at ../util/qemu-thread-posix.c:541
> #5  0x00007f010df18044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #6  0x00007f010df9861c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 1 (Thread 0x7f01031f81c0 (LWP 46635) "qemu-system-x86"):
> #0  0x00007f010df8b156 in __ppoll (fds=0x561219fe4060, nfds=1, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
> #1  0x000056121874808e in qemu_poll_ns (fds=0x561219fe4060, nfds=1, timeout=62500000) at ../util/qemu-timer.c:351
> #2  0x00005612187252f4 in fdmon_poll_wait (ctx=0x56121955e540, ready_list=0x7ffe4c596330, timeout=62500000) at ../util/fdmon-poll.c:79
> #3  0x0000561218724c30 in aio_poll (ctx=0x56121955e540, blocking=true) at ../util/aio-posix.c:670
> #4  0x00005612185b614f in bdrv_do_drained_begin (bs=0x5612198b9da0, parent=0x0, poll=true) at ../block/io.c:399
> #5  0x00005612185b626b in bdrv_drained_begin (bs=0x5612198b9da0) at ../block/io.c:412
> #6  0x00005612185a7277 in blk_drain (blk=0x56121a22abd0) at ../block/block-backend.c:2086
> #7  0x00005612185a3bdf in blk_unref (blk=0x56121a22abd0) at ../block/block-backend.c:553
> #8  0x000056121824f7e2 in hmp_qemu_io (mon=0x7ffe4c596630, qdict=0x5612198c0410) at ../block/monitor/block-hmp-cmds.c:621
> #9  0x00005612182b7224 in handle_hmp_command_exec (mon=0x7ffe4c596630, cmd=0x561219099a00 <hmp_cmds+6080>, qdict=0x5612198c0410) at ../monitor/hmp.c:1106
> #10 0x00005612182b7451 in handle_hmp_command (mon=0x7ffe4c596630, cmdline=0x56121a0dfbc8 "mirror-top \"aio_write -P 1 8192 8704\"") at ../monitor/hmp.c:1158
> #11 0x00005612182b8a3e in qmp_human_monitor_command (command_line=0x56121a0dfbc0 "qemu-io mirror-top \"aio_write -P 1 8192 8704\"", has_cpu_index=false, cpu_index=0, errp=0x7ffe4c596740) at ../monitor/qmp-cmds.c:182
> #12 0x00005612186d12e6 in qmp_marshal_human_monitor_command (args=0x7f00f4005e70, ret=0x7f0102889d98, errp=0x7f0102889d90) at qapi/qapi-commands-misc.c:347
> #13 0x00005612187171d2 in do_qmp_dispatch_bh (opaque=0x7f0102889e30) at ../qapi/qmp-dispatch.c:128
> #14 0x0000561218741b1b in aio_bh_call (bh=0x56121a3cf2c0) at ../util/async.c:169
> #15 0x0000561218741c36 in aio_bh_poll (ctx=0x56121955e540) at ../util/async.c:216
> #16 0x00005612187244da in aio_dispatch (ctx=0x56121955e540) at ../util/aio-posix.c:423
> #17 0x0000561218742075 in aio_ctx_dispatch (source=0x56121955e540, callback=0x0, user_data=0x0) at ../util/async.c:358
> #18 0x00007f010f2007a9 in g_main_context_dispatch () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #19 0x0000561218743830 in glib_pollfds_poll () at ../util/main-loop.c:290
> #20 0x00005612187438ad in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> #21 0x00005612187439bb in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> #22 0x00005612182610e7 in qemu_main_loop () at ../system/runstate.c:782
> #23 0x000056121851ab0e in qemu_default_main () at ../system/main.c:37
> #24 0x000056121851ab49 in main (argc=20, argv=0x7ffe4c596b68) at ../system/main.c:48

[1]:

Note there's also threads 6-18 which are also worker threads with a
similar backtrace as thread 5.

> Thread 5 (Thread 0x7f867ffff6c0 (LWP 48159) "qemu-system-x86"):
> #0  __futex_abstimed_wait_common64 (private=0, cancel=true, abstime=0x7f867fffa300, op=393, expected=0, futex_word=0x562994eef7a8) at ./nptl/futex-internal.c:57
> #1  __futex_abstimed_wait_common (futex_word=futex_word@entry=0x562994eef7a8, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x7f867fffa300, private=private@entry=0, cancel=cancel@entry=true) at ./nptl/futex-internal.c:87
> #2  0x00007f86aa314e0b in __GI___futex_abstimed_wait_cancelable64 (futex_word=futex_word@entry=0x562994eef7a8, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x7f867fffa300, private=private@entry=0) at ./nptl/futex-internal.c:139
> #3  0x00007f86aa31774c in __pthread_cond_wait_common (abstime=0x7f867fffa300, clockid=0, mutex=0x562994eef710, cond=0x562994eef780) at ./nptl/pthread_cond_wait.c:503
> #4  ___pthread_cond_timedwait64 (cond=0x562994eef780, mutex=0x562994eef710, abstime=0x7f867fffa300) at ./nptl/pthread_cond_wait.c:643
> #5  0x000056299413676e in qemu_cond_timedwait_ts (cond=0x562994eef780, mutex=0x562994eef710, ts=0x7f867fffa300, file=0x562994412d1d "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:239
> #6  0x0000562994136809 in qemu_cond_timedwait_impl (cond=0x562994eef780, mutex=0x562994eef710, ms=10000, file=0x562994412d1d "../util/thread-pool.c", line=90) at ../util/qemu-thread-posix.c:253
> #7  0x00005629941538ac in worker_thread (opaque=0x562994eef700) at ../util/thread-pool.c:90
> #8  0x0000562994136f03 in qemu_thread_start (args=0x562995710f80) at ../util/qemu-thread-posix.c:541
> #9  0x00007f86aa318044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #10 0x00007f86aa39861c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 4 (Thread 0x7f869e3c66c0 (LWP 48157) "qemu-system-x86"):
> #0  0x00007f86aa2cbc02 in __GI___sigtimedwait (set=set@entry=0x7f869e3c12e0, info=info@entry=0x7f869e3c1210, timeout=timeout@entry=0x0) at ../sysdeps/unix/sysv/linux/sigtimedwait.c:31
> #1  0x00007f86aa2cb31c in __GI___sigwait (set=0x7f869e3c12e0, sig=0x7f869e3c12d0) at ../sysdeps/unix/sysv/linux/sigwait.c:28
> #2  0x0000562993cefc96 in dummy_cpu_thread_fn (arg=0x5629951f7a90) at ../accel/dummy-cpus.c:50
> #3  0x0000562994136f03 in qemu_thread_start (args=0x562995200c80) at ../util/qemu-thread-posix.c:541
> #4  0x00007f86aa318044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #5  0x00007f86aa39861c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 3 (Thread 0x7f869ebc76c0 (LWP 48156) "qemu-system-x86"):
> #0  0x00007f86aa38b05f in __GI___poll (fds=0x7f8690003320, nfds=2, timeout=-1) at ../sysdeps/unix/sysv/linux/poll.c:29
> #1  0x00007f86ab63f9ae in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #2  0x00007f86ab63fcef in g_main_loop_run () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #3  0x0000562993f78683 in iothread_run (opaque=0x562994e44940) at ../iothread.c:70
> #4  0x0000562994136f03 in qemu_thread_start (args=0x562994ec11d0) at ../util/qemu-thread-posix.c:541
> #5  0x00007f86aa318044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #6  0x00007f86aa39861c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 2 (Thread 0x7f869f4c96c0 (LWP 48155) "qemu-system-x86"):
> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
> #1  0x0000562994136b69 in qemu_futex_wait (f=0x562994b92498 <rcu_call_ready_event>, val=4294967295) at /home/febner/repos/qemu/include/qemu/futex.h:29
> #2  0x0000562994136d50 in qemu_event_wait (ev=0x562994b92498 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:464
> #3  0x0000562994144107 in call_rcu_thread (opaque=0x0) at ../util/rcu.c:278
> #4  0x0000562994136f03 in qemu_thread_start (args=0x562994e285b0) at ../util/qemu-thread-posix.c:541
> #5  0x00007f86aa318044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #6  0x00007f86aa39861c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 
> Thread 1 (Thread 0x7f869f6371c0 (LWP 48154) "qemu-system-x86"):
> #0  0x00007f86aa38b156 in __ppoll (fds=0x562994e3b260, nfds=1, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
> #1  0x000056299415508e in qemu_poll_ns (fds=0x562994e3b260, nfds=1, timeout=62500000) at ../util/qemu-timer.c:351
> #2  0x00005629941322f4 in fdmon_poll_wait (ctx=0x562994ec3540, ready_list=0x7fffe1a38d20, timeout=62500000) at ../util/fdmon-poll.c:79
> #3  0x0000562994131c30 in aio_poll (ctx=0x562994ec3540, blocking=true) at ../util/aio-posix.c:670
> #4  0x0000562993f6a48b in blk_exp_close_all_type (type=BLOCK_EXPORT_TYPE__MAX) at ../block/export/export.c:315
> #5  0x0000562993f6a4ba in blk_exp_close_all () at ../block/export/export.c:320
> #6  0x0000562993c6e26b in qemu_cleanup (status=0) at ../system/runstate.c:853
> #7  0x0000562993f27b1b in qemu_default_main () at ../system/main.c:38
> #8  0x0000562993f27b49 in main (argc=20, argv=0x7fffe1a38f48) at ../system/main.c:48


