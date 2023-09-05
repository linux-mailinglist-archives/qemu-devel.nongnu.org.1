Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426C77921C3
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSs7-0002Rw-6V; Tue, 05 Sep 2023 06:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdSs4-0002RM-Bu; Tue, 05 Sep 2023 06:01:20 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qdSs1-00055W-Cl; Tue, 05 Sep 2023 06:01:20 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5763742110;
 Tue,  5 Sep 2023 12:01:05 +0200 (CEST)
Message-ID: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
Date: Tue, 5 Sep 2023 12:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: deadlock when using iothread during backup_clean()
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
To: QEMU Developers <qemu-devel@nongnu.org>
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

Hi,

as the title says, a deadlock is possible in backup_clean() when using a
drive with an IO thread. The main thread keeps waiting in
bdrv_graph_wrlock() for reader_count() to become 0, while the IO thread
waits for its AioContext lock, which the main thread holds (because it
also is the backup job's AioContext). See the stack trace below [1].

The reason why it happens becomes clear with following commit message:

> commit 31b2ddfea304afc498aca8cac171020ef33eb89b
> Author: Kevin Wolf <kwolf@redhat.com>
> Date:   Mon Jun 5 10:57:10 2023 +0200
> 
>     graph-lock: Unlock the AioContext while polling
>     
>     If the caller keeps the AioContext lock for a block node in an iothread,
>     polling in bdrv_graph_wrlock() deadlocks if the condition isn't
>     fulfilled immediately.
>     
>     Now that all callers make sure to actually have the AioContext locked
>     when they call bdrv_replace_child_noperm() like they should, we can
>     change bdrv_graph_wrlock() to take a BlockDriverState whose AioContext
>     lock the caller holds (NULL if it doesn't) and unlock it temporarily
>     while polling.
>

and noting that bdrv_graph_wrlock() is called with bs being NULL while
the caller holds the IO thread's AioContext lock.

The question is where should the IO thread's AioContext lock be dropped
by the main thread? The "Graph locking part 4 (node management)" series
[0] (also reproduced the dealock with that applied) moves the
bdrv_graph_wrlock() further up to block_job_remove_all_bdrv(), but it
still passes along NULL as the argument.

Can we assume block_job_remove_all_bdrv() to always hold the job's
AioContext? And if yes, can we just tell bdrv_graph_wrlock() that it
needs to release that before polling to fix the deadlock?

Best Regards,
Fiona

[0]: https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02831.html

[1]:

IO thread:

> Thread 3 (Thread 0x7fa2209596c0 (LWP 119031) "qemu-system-x86"):
> #0  futex_wait (private=0, expected=2, futex_word=0x5648fc93b2c0) at ../sysdeps/nptl/futex-internal.h:146
> #1  __GI___lll_lock_wait (futex=futex@entry=0x5648fc93b2c0, private=0) at ./nptl/lowlevellock.c:49
> #2  0x00007fa2240e532a in lll_mutex_lock_optimized (mutex=0x5648fc93b2c0) at ./nptl/pthread_mutex_lock.c:48
> #3  ___pthread_mutex_lock (mutex=0x5648fc93b2c0) at ./nptl/pthread_mutex_lock.c:128
> #4  0x00005648fa1742f8 in qemu_mutex_lock_impl (mutex=0x5648fc93b2c0, file=0x5648fa446579 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:94
> #5  0x00005648fa174528 in qemu_rec_mutex_lock_impl (mutex=0x5648fc93b2c0, file=0x5648fa446579 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:149
> #6  0x00005648fa18dd6f in aio_context_acquire (ctx=0x5648fc93b260) at ../util/async.c:728
> #7  0x00005648fa18dce4 in aio_co_enter (ctx=0x5648fc93b260, co=0x7fa217f49210) at ../util/async.c:710
> #8  0x00005648fa18dc31 in aio_co_wake (co=0x7fa217f49210) at ../util/async.c:695
> #9  0x00005648fa08e4a2 in luring_process_completions (s=0x5648fdf2dd00) at ../block/io_uring.c:216
> #10 0x00005648fa08e6c7 in luring_process_completions_and_submit (s=0x5648fdf2dd00) at ../block/io_uring.c:268
> #11 0x00005648fa08e727 in qemu_luring_completion_cb (opaque=0x5648fdf2dd00) at ../block/io_uring.c:284
> #12 0x00005648fa16f433 in aio_dispatch_handler (ctx=0x5648fc93b260, node=0x5648fdf2de50) at ../util/aio-posix.c:372
> #13 0x00005648fa16f506 in aio_dispatch_ready_handlers (ctx=0x5648fc93b260, ready_list=0x7fa220954180) at ../util/aio-posix.c:401
> #14 0x00005648fa16ff7d in aio_poll (ctx=0x5648fc93b260, blocking=true) at ../util/aio-posix.c:723
> #15 0x00005648f9fbaa59 in iothread_run (opaque=0x5648fc5ed6b0) at ../iothread.c:63
> #16 0x00005648fa175046 in qemu_thread_start (args=0x5648fc93b8f0) at ../util/qemu-thread-posix.c:541
> #17 0x00007fa2240e2044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #18 0x00007fa2241625fc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
> 

main thread:

> Thread 1 (Thread 0x7fa2214bf340 (LWP 119029) "qemu-system-x86"):
> #0  0x00007fa224155136 in __ppoll (fds=0x5648fdf2ce50, nfds=2, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
> #1  0x00005648fa193102 in qemu_poll_ns (fds=0x5648fdf2ce50, nfds=2, timeout=-1) at ../util/qemu-timer.c:339
> #2  0x00005648fa17042f in fdmon_poll_wait (ctx=0x5648fc6c9740, ready_list=0x7ffff2757260, timeout=-1) at ../util/fdmon-poll.c:79
> #3  0x00005648fa16fd6b in aio_poll (ctx=0x5648fc6c9740, blocking=true) at ../util/aio-posix.c:670
> #4  0x00005648f9ffc0bc in bdrv_graph_wrlock (bs=0x0) at ../block/graph-lock.c:145
> #5  0x00005648f9fc78fa in bdrv_replace_child_noperm (child=0x5648fd729fd0, new_bs=0x0) at ../block.c:2897
> #6  0x00005648f9fc8487 in bdrv_root_unref_child (child=0x5648fd729fd0) at ../block.c:3227
> #7  0x00005648f9fd4b50 in block_job_remove_all_bdrv (job=0x5648fe0b6960) at ../blockjob.c:208
> #8  0x00005648f9feb11b in backup_clean (job=0x5648fe0b6960) at ../block/backup.c:104
> #9  0x00005648f9fd8632 in job_clean (job=0x5648fe0b6960) at ../job.c:836
> #10 0x00005648f9fd86db in job_finalize_single_locked (job=0x5648fe0b6960) at ../job.c:863
> #11 0x00005648f9fd89f5 in job_completed_txn_abort_locked (job=0x5648fe0b6960) at ../job.c:970
> #12 0x00005648f9fd8e6e in job_completed_locked (job=0x5648fe0b6960) at ../job.c:1080
> #13 0x00005648f9fd8f23 in job_exit (opaque=0x5648fe0b6960) at ../job.c:1103
> #14 0x00005648fa18cc01 in aio_bh_call (bh=0x7f9f68202010) at ../util/async.c:169
> #15 0x00005648fa18cd1c in aio_bh_poll (ctx=0x5648fc6c9740) at ../util/async.c:216
> #16 0x00005648fa16f615 in aio_dispatch (ctx=0x5648fc6c9740) at ../util/aio-posix.c:423
> #17 0x00005648fa18d15b in aio_ctx_dispatch (source=0x5648fc6c9740, callback=0x0, user_data=0x0) at ../util/async.c:358
> #18 0x00007fa22533e7a9 in g_main_context_dispatch () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #19 0x00005648fa18e916 in glib_pollfds_poll () at ../util/main-loop.c:290
> #20 0x00005648fa18e993 in os_host_main_loop_wait (timeout=991053) at ../util/main-loop.c:313
> #21 0x00005648fa18eaa1 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> #22 0x00005648f9cb027d in qemu_main_loop () at ../softmmu/runstate.c:732
> #23 0x00005648f9f6aff9 in qemu_default_main () at ../softmmu/main.c:37
> #24 0x00005648f9f6b02f in main (argc=55, argv=0x7ffff2757848) at ../softmmu/main.c:48

which still holds the IO thread's AioContext

> (gdb) p ((AioContext*)0x5648fc93b260)->lock
> $10 = {m = {lock = {__data = {__lock = 2, __count = 1, __owner = 119029, __nusers = 1, __kind = 1, __spins = 0, __elision = 0, __list = {__prev = 0x0, __next = 0x0}}, 
>       __size = "\002\000\000\000\001\000\000\000\365\320\001\000\001\000\000\000\001", '\000' <repeats 22 times>, __align = 4294967298}, file = 0x0, line = 0, initialized = true}}

which is also the job's AioContext

> (gdb) p ((Job*)0x5648fe0b6960)->aio_context
> $13 = (AioContext *) 0x5648fc93b260


