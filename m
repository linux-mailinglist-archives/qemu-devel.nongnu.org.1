Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561E7CC092
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 12:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qshA0-00077I-1r; Tue, 17 Oct 2023 06:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qsh9x-00074V-C7; Tue, 17 Oct 2023 06:18:45 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qsh9u-0001bX-WA; Tue, 17 Oct 2023 06:18:45 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 239CF42111;
 Tue, 17 Oct 2023 12:18:40 +0200 (CEST)
Message-ID: <76f9678d-ed92-418e-8d1e-c6dc55f83279@proxmox.com>
Date: Tue, 17 Oct 2023 12:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: deadlock when using iothread during backup_clean()
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
 <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
 <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
 <2ca4eb06-75c3-7bd8-972b-b37af47743dc@yandex-team.ru>
 <71e3112d-3d3f-fd55-4099-6765d4f22205@proxmox.com>
In-Reply-To: <71e3112d-3d3f-fd55-4099-6765d4f22205@proxmox.com>
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

Am 06.10.23 um 14:18 schrieb Fiona Ebner:
> Am 04.10.23 um 19:08 schrieb Vladimir Sementsov-Ogievskiy:
>> On 28.09.23 11:06, Fiona Ebner wrote:
>>> For fixing the backup cancel deadlock, I tried the following:
>>>
>>>> diff --git a/blockjob.c b/blockjob.c
>>>> index 58c5d64539..fd6132ebfe 100644
>>>> --- a/blockjob.c
>>>> +++ b/blockjob.c
>>>> @@ -198,7 +198,9 @@ void block_job_remove_all_bdrv(BlockJob *job)
>>>>        * one to make sure that such a concurrent access does not attempt
>>>>        * to process an already freed BdrvChild.
>>>>        */
>>>> +    aio_context_release(job->job.aio_context);
>>>>       bdrv_graph_wrlock(NULL);
>>>> +    aio_context_acquire(job->job.aio_context);
>>>>       while (job->nodes) {
>>>>           GSList *l = job->nodes;
>>>>           BdrvChild *c = l->data;
>>>
>>> but it's not enough unfortunately. And I don't just mean with the later
>>> deadlock during bdrv_close() (via bdrv_cbw_drop()) as mentioned in the
>>> other mail.
>>>
>>> Even when I got lucky and that deadlock didn't trigger by chance or with
>>> an additional change to try and avoid that one
>>>
>>>> diff --git a/block.c b/block.c
>>>> index e7f349b25c..02d2c4e777 100644
>>>> --- a/block.c
>>>> +++ b/block.c
>>>> @@ -5165,7 +5165,7 @@ static void bdrv_close(BlockDriverState *bs)
>>>>           bs->drv = NULL;
>>>>       }
>>>>   -    bdrv_graph_wrlock(NULL);
>>>> +    bdrv_graph_wrlock(bs);
>>>>       QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
>>>>           bdrv_unref_child(bs, child);
>>>>       }
>>>
>>> often guest IO would get completely stuck after canceling the backup.
>>> There's nothing obvious to me in the backtraces at that point, but it
>>> seems the vCPU and main threads running like usual, while the IO thread
>>> is stuck in aio_poll(), i.e. never returns from the __ppoll() call. This
>>> would happen with both, a VirtIO SCSI and a VirtIO block disk and with
>>> both aio=io_uring and aio=threads.
>>
>> When IO is stuck, it may be helpful to look at bs->tracked_requests list
>> in gdb. If there are requests, each one has field .co, which points to
>> the coroutine of request.
> 
> After the IO was stuck in the guest, I used bdrv_next_all_states() to
> iterate over the states and there's only the bdrv_raw and the
> bdrv_host_device. For both, tracked_requests was empty.
> 
> What is also very interesting is that the IO isn't always dead
> immediately. It can be that the fio command still runs with lower speed
> for a while (sometimes even up to about a minute, but most often about
> 10-15 seconds or so). During that time, I still can see calls to
> virtio_scsi_handle_cmd() and blk_aio_write_entry(). Then they suddenly stop.
> 
>>>
>>> I should also mention I'm using
>>>
>>>> fio --name=file --size=4k --direct=1 --rw=randwrite --bs=4k
>>>> --ioengine=psync --numjobs=5 --runtime=6000 --time_based
>>>
>>> inside the guest during canceling of the backup.
> 
> One single time, it got stuck polling while canceling [0]. I usually
> need to do the backup+cancel a few times, because the IO doesn't get
> stuck each time, so this was a subsequent invocation. The reentrancy to
> virtio_scsi_handle_cmd()/etc. seems strange at a first glance. Can that
> be normal?
> 

I ran into similar issues now with mirror, (both deadlocks and stuck
guest IO at other times), and interestingly, also during job start.

Also had a backtrace similar to [0] once, so I took a closer look.
Probably was obvious to others already, but for the record:

1. the graph is locked by the main thread
2. the iothread holds the AioContext lock
3. the main thread waits on the AioContext lock
4. the iothread waits for coroutine spawned by blk_is_available()

As for why it doesn't progress, blk_co_is_available_entry() uses
bdrv_graph_co_rdlock() and can't get it, because the main thread has the
write lock. Should be fixed once the AioContext locks are gone, but not
sure what should be done to avoid it until then.

I'm still trying to figure out what happens in the cases where the guest
IO gets stuck. I should mention that I'm not experiencing the issues
when disabling graph locking. It's rather obvious for the deadlocks, but
I also can't reproduce the issues with stuck guest IO. Did it on top of
QEMU 8.1.1, because stuff like bdrv_schedule_unref() came in later and I
didn't want to mess that up :)

> Best Regards,
> Fiona
> 
> [0]:
> 
>> Thread 3 (Thread 0x7ff7f28946c0 (LWP 1815909) "qemu-system-x86"):
>> #0  0x00007ff7f5f55136 in __ppoll (fds=0x7ff7e40030c0, nfds=8, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
>> #1  0x00005587132615ab in qemu_poll_ns (fds=0x7ff7e40030c0, nfds=8, timeout=-1) at ../util/qemu-timer.c:339
>> #2  0x000055871323e8b1 in fdmon_poll_wait (ctx=0x55871598d5e0, ready_list=0x7ff7f288ebe0, timeout=-1) at ../util/fdmon-poll.c:79
>> #3  0x000055871323e1ed in aio_poll (ctx=0x55871598d5e0, blocking=true) at ../util/aio-posix.c:670
>> #4  0x0000558713089efa in bdrv_poll_co (s=0x7ff7f288ec90) at /home/febner/repos/qemu/block/block-gen.h:43
>> #5  0x000055871308c362 in blk_is_available (blk=0x55871599e2f0) at block/block-gen.c:1426
>> #6  0x0000558712f6843b in virtio_scsi_ctx_check (s=0x558716c049c0, d=0x55871581cd30) at ../hw/scsi/virtio-scsi.c:290
>> #7  0x0000558712f697e4 in virtio_scsi_handle_cmd_req_prepare (s=0x558716c049c0, req=0x7ff7e400b650) at ../hw/scsi/virtio-scsi.c:788
>> #8  0x0000558712f699b0 in virtio_scsi_handle_cmd_vq (s=0x558716c049c0, vq=0x558716c0d2a8) at ../hw/scsi/virtio-scsi.c:831
>> #9  0x0000558712f69bcb in virtio_scsi_handle_cmd (vdev=0x558716c049c0, vq=0x558716c0d2a8) at ../hw/scsi/virtio-scsi.c:867
>> #10 0x0000558712f96812 in virtio_queue_notify_vq (vq=0x558716c0d2a8) at ../hw/virtio/virtio.c:2263
>> #11 0x0000558712f99b75 in virtio_queue_host_notifier_read (n=0x558716c0d31c) at ../hw/virtio/virtio.c:3575
>> #12 0x000055871323d8b5 in aio_dispatch_handler (ctx=0x55871598d5e0, node=0x558716771000) at ../util/aio-posix.c:372
>> #13 0x000055871323d988 in aio_dispatch_ready_handlers (ctx=0x55871598d5e0, ready_list=0x7ff7f288eeb0) at ../util/aio-posix.c:401
>> #14 0x000055871323e3ff in aio_poll (ctx=0x55871598d5e0, blocking=true) at ../util/aio-posix.c:723
>> #15 0x0000558713089efa in bdrv_poll_co (s=0x7ff7f288ef60) at /home/febner/repos/qemu/block/block-gen.h:43
>> #16 0x000055871308c362 in blk_is_available (blk=0x55871599e2f0) at block/block-gen.c:1426
>> #17 0x0000558712f6843b in virtio_scsi_ctx_check (s=0x558716c049c0, d=0x55871581cd30) at ../hw/scsi/virtio-scsi.c:290
>> #18 0x0000558712f697e4 in virtio_scsi_handle_cmd_req_prepare (s=0x558716c049c0, req=0x7ff7e401c800) at ../hw/scsi/virtio-scsi.c:788
>> #19 0x0000558712f699b0 in virtio_scsi_handle_cmd_vq (s=0x558716c049c0, vq=0x558716c0d210) at ../hw/scsi/virtio-scsi.c:831
>> #20 0x0000558712f69bcb in virtio_scsi_handle_cmd (vdev=0x558716c049c0, vq=0x558716c0d210) at ../hw/scsi/virtio-scsi.c:867
>> #21 0x0000558712f96812 in virtio_queue_notify_vq (vq=0x558716c0d210) at ../hw/virtio/virtio.c:2263
>> #22 0x0000558712f99b75 in virtio_queue_host_notifier_read (n=0x558716c0d284) at ../hw/virtio/virtio.c:3575
>> #23 0x000055871323d8b5 in aio_dispatch_handler (ctx=0x55871598d5e0, node=0x5587162b5d80) at ../util/aio-posix.c:372
>> #24 0x000055871323d988 in aio_dispatch_ready_handlers (ctx=0x55871598d5e0, ready_list=0x7ff7f288f180) at ../util/aio-posix.c:401
>> #25 0x000055871323e3ff in aio_poll (ctx=0x55871598d5e0, blocking=true) at ../util/aio-posix.c:723
>> #26 0x00005587130878bf in iothread_run (opaque=0x55871563d6b0) at ../iothread.c:63
>> #27 0x00005587132434c0 in qemu_thread_start (args=0x55871598dc70) at ../util/qemu-thread-posix.c:541
>> #28 0x00007ff7f5ee2044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
>> #29 0x00007ff7f5f625fc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>>
>> Thread 2 (Thread 0x7ff7f31966c0 (LWP 1815908) "qemu-system-x86"):
>> #0  syscall () at ../sysdeps/unix/sysv/linux/x86_64/syscall.S:38
>> #1  0x0000558713243126 in qemu_futex_wait (f=0x558713c963f8 <rcu_call_ready_event>, val=4294967295) at /home/febner/repos/qemu/include/qemu/futex.h:29
>> #2  0x000055871324330d in qemu_event_wait (ev=0x558713c963f8 <rcu_call_ready_event>) at ../util/qemu-thread-posix.c:464
>> #3  0x00005587132506c4 in call_rcu_thread (opaque=0x0) at ../util/rcu.c:278
>> #4  0x00005587132434c0 in qemu_thread_start (args=0x5587156aeaa0) at ../util/qemu-thread-posix.c:541
>> #5  0x00007ff7f5ee2044 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
>> #6  0x00007ff7f5f625fc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
>>
>> Thread 1 (Thread 0x7ff7f33fa340 (LWP 1815907) "qemu-system-x86"):
>> #0  futex_wait (private=0, expected=2, futex_word=0x55871598d640) at ../sysdeps/nptl/futex-internal.h:146
>> #1  __GI___lll_lock_wait (futex=futex@entry=0x55871598d640, private=0) at ./nptl/lowlevellock.c:49
>> #2  0x00007ff7f5ee532a in lll_mutex_lock_optimized (mutex=0x55871598d640) at ./nptl/pthread_mutex_lock.c:48
>> #3  ___pthread_mutex_lock (mutex=0x55871598d640) at ./nptl/pthread_mutex_lock.c:128
>> #4  0x0000558713242772 in qemu_mutex_lock_impl (mutex=0x55871598d640, file=0x55871351bfb9 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:94
>> #5  0x00005587132429a2 in qemu_rec_mutex_lock_impl (mutex=0x55871598d640, file=0x55871351bfb9 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:149
>> #6  0x000055871325c23d in aio_context_acquire (ctx=0x55871598d5e0) at ../util/async.c:728
>> #7  0x00005587130d1956 in bdrv_drain_all_end () at ../block/io.c:567
>> #8  0x00005587130cf1e8 in bdrv_graph_wrlock (bs=0x5587168255f0) at ../block/graph-lock.c:156
>> #9  0x0000558713099c8f in bdrv_close (bs=0x5587168255f0) at ../block.c:5169
>> #10 0x000055871309ad5a in bdrv_delete (bs=0x5587168255f0) at ../block.c:5609
>> #11 0x000055871309df21 in bdrv_unref (bs=0x5587168255f0) at ../block.c:7178
>> #12 0x00005587130ca195 in bdrv_cbw_drop (bs=0x5587168255f0) at ../block/copy-before-write.c:566
>> #13 0x00005587130b8430 in backup_clean (job=0x558716d54210) at ../block/backup.c:105
>> #14 0x00005587130a58b9 in job_clean (job=0x558716d54210) at ../job.c:836
>> #15 0x00005587130a5962 in job_finalize_single_locked (job=0x558716d54210) at ../job.c:863
>> #16 0x00005587130a5c7c in job_completed_txn_abort_locked (job=0x558716d54210) at ../job.c:970
>> #17 0x00005587130a60f5 in job_completed_locked (job=0x558716d54210) at ../job.c:1080
>> #18 0x00005587130a61aa in job_exit (opaque=0x558716d54210) at ../job.c:1103
>> #19 0x000055871325b0cf in aio_bh_call (bh=0x7ff7e4004bd0) at ../util/async.c:169
>> #20 0x000055871325b1ea in aio_bh_poll (ctx=0x55871571a8a0) at ../util/async.c:216
>> #21 0x000055871323da97 in aio_dispatch (ctx=0x55871571a8a0) at ../util/aio-posix.c:423
>> #22 0x000055871325b629 in aio_ctx_dispatch (source=0x55871571a8a0, callback=0x0, user_data=0x0) at ../util/async.c:358
>> #23 0x00007ff7f72bf7a9 in g_main_context_dispatch () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
>> #24 0x000055871325cde4 in glib_pollfds_poll () at ../util/main-loop.c:290
>> #25 0x000055871325ce61 in os_host_main_loop_wait (timeout=1412902959) at ../util/main-loop.c:313
>> #26 0x000055871325cf6f in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
>> #27 0x0000558712d813de in qemu_main_loop () at ../softmmu/runstate.c:772
>> #28 0x000055871303811b in qemu_default_main () at ../softmmu/main.c:37
>> #29 0x0000558713038151 in main (argc=57, argv=0x7fffd393e828) at ../softmmu/main.c:48
>> (gdb) p ((AioContext*)0x55871598d5e0)->lock
>> $1 = {m = {lock = {__data = {__lock = 2, __count = 2, __owner = 1815909, __nusers = 1, __kind = 1, 
>>         __spins = 0, __elision = 0, __list = {__prev = 0x0, __next = 0x0}}, 
>>       __size = "\002\000\000\000\002\000\000\000e\265\033\000\001\000\000\000\001", '\000' <repeats 22 times>, __align = 8589934594}, file = 0x0, line = 0, initialized = true}}
> 
> 
> 


