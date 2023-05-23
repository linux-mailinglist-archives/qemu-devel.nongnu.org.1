Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B6570E0E6
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UFK-0007U1-7Z; Tue, 23 May 2023 11:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q1UFE-0007Hu-SV; Tue, 23 May 2023 11:48:17 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1q1UFB-0006I2-UT; Tue, 23 May 2023 11:48:16 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C0E1346AF4;
 Tue, 23 May 2023 17:48:10 +0200 (CEST)
Message-ID: <a8d5c6d5-1965-3665-3ec1-f1367e44b828@proxmox.com>
Date: Tue, 23 May 2023 17:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] migration: for snapshots, hold the BQL during setup
 callbacks
Content-Language: en-US
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, leobras@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, stefanha@redhat.com,
 fam@euphon.net, qemu-block@nongnu.org, pbonzini@redhat.com,
 t.lamprecht@proxmox.com, Kevin Wolf <kwolf@redhat.com>
References: <20230505134652.140884-1-f.ebner@proxmox.com>
 <ZFUZuiubiReBGucl@x1n> <87v8h0aea6.fsf@secure.mitica>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <87v8h0aea6.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 10.05.23 um 08:31 schrieb Juan Quintela:
> I am more towards revert completely
> 9b0950375277467fd74a9075624477ae43b9bb22
> 
> and call it a day.  On migration we don't use coroutines on the sending
> side (I mean the migration code, the block layer uses coroutines for
> everything/anything).
> 

So I was preparing v2 for this patch, also taking the BQL during setup
for migration to avoid the conditional locking. But it turns out that
the original issue (i.e. snapshot code running in the vCPU thread) is
not solved completely. (And this is not only the issue with the
virito-net I ran into the other time [0])

This time I ran it without the net device and ended up with a hang [1].
I think what happens is the following, but am not sure:

vCPU thread
calls vm_stop(RUN_STATE_SAVE_VM)

main thread
calls pause_all_vcpus() and starts waiting

vCPU thread
finished doing the snapshot and calls vm_start()

Now the main thread will never progress, because all_vcpus_paused() was
never true.

Not sure what can be done about that and not sure if there are other
code paths were a vCPU thread could trigger vm_stop() followed by
vm_start() without stopping itself in between?

Best Regards,
Fiona

[0]: https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg00140.html

[1]:

> Thread 1 (Thread 0x7ffff359e2c0 (LWP 121263) "qemu-system-x86"):
> #0  __futex_abstimed_wait_common64 (private=0, cancel=true, abstime=0x0, op=393, expected=0, futex_word=0x555556a1f868 <qemu_pause_cond+40>) at ./nptl/futex-internal.c:57
> #1  __futex_abstimed_wait_common (futex_word=futex_word@entry=0x555556a1f868 <qemu_pause_cond+40>, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0, cancel=cancel@entry=true) at ./nptl/futex-internal.c:87
> #2  0x00007ffff62ded9b in __GI___futex_abstimed_wait_cancelable64 (futex_word=futex_word@entry=0x555556a1f868 <qemu_pause_cond+40>, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0) at ./nptl/futex-internal.c:139
> #3  0x00007ffff62e13f8 in __pthread_cond_wait_common (abstime=0x0, clockid=0, mutex=0x555556a1f7a0 <qemu_global_mutex>, cond=0x555556a1f840 <qemu_pause_cond>) at ./nptl/pthread_cond_wait.c:503
> #4  ___pthread_cond_wait (cond=0x555556a1f840 <qemu_pause_cond>, mutex=0x555556a1f7a0 <qemu_global_mutex>) at ./nptl/pthread_cond_wait.c:618
> #5  0x000055555605ef9d in qemu_cond_wait_impl (cond=0x555556a1f840 <qemu_pause_cond>, mutex=0x555556a1f7a0 <qemu_global_mutex>, file=0x5555561d483b "../softmmu/cpus.c", line=573) at ../util/qemu-thread-posix.c:225
> #6  0x0000555555b36891 in pause_all_vcpus () at ../softmmu/cpus.c:573
> #7  0x0000555555b35ef3 in do_vm_stop (state=RUN_STATE_SAVE_VM, send_stop=true) at ../softmmu/cpus.c:262
> #8  0x0000555555b36cab in vm_stop (state=RUN_STATE_SAVE_VM) at ../softmmu/cpus.c:676
> #9  0x0000555555b443ed in main_loop_should_exit (status=0x7fffffffd944) at ../softmmu/runstate.c:723
> #10 0x0000555555b4443e in qemu_main_loop () at ../softmmu/runstate.c:735
> #11 0x0000555555e57ec3 in qemu_default_main () at ../softmmu/main.c:37
> #12 0x0000555555e57ef9 in main (argc=56, argv=0x7fffffffdaa8) at ../softmmu/main.c:48
> (gdb) bt
> #0  resume_all_vcpus () at ../softmmu/cpus.c:592
> #1  0x0000555555b36d85 in vm_start () at ../softmmu/cpus.c:724
> #2  0x0000555555b932ee in save_snapshot (name=0x7fff5c197340 "snap0", overwrite=false, vmstate=0x7fff5c302ca0 "sata0", has_devices=true, devices=0x7fff5c1968d0, errp=0x7fff5c39aec8) at ../migration/savevm.c:2992
> #3  0x0000555555b93c49 in snapshot_save_job_bh (opaque=0x7fff5c39ae00) at ../migration/savevm.c:3255
> #4  0x000055555607733f in aio_bh_call (bh=0x7fff5c1f9560) at ../util/async.c:169
> #5  0x000055555607745a in aio_bh_poll (ctx=0x555556b806b0) at ../util/async.c:216
> #6  0x000055555605a95c in aio_poll (ctx=0x555556b806b0, blocking=true) at ../util/aio-posix.c:732
> #7  0x0000555555ea7e70 in bdrv_poll_co (s=0x7ffff0ee7e50) at /home/febner/repos/qemu/block/block-gen.h:43
> #8  0x0000555555eaaa76 in blk_pwrite (blk=0x555556df79a0, offset=189440, bytes=512, buf=0x7fff6322e400, flags=0) at block/block-gen.c:1754
> #9  0x00005555559077c9 in pflash_update (pfl=0x555556dda2e0, offset=189440, size=1) at ../hw/block/pflash_cfi01.c:394
> #10 0x0000555555907ecd in pflash_write (pfl=0x555556dda2e0, offset=189507, value=114, width=1, be=0) at ../hw/block/pflash_cfi01.c:522
> #11 0x0000555555908479 in pflash_mem_write_with_attrs (opaque=0x555556dda2e0, addr=189507, value=114, len=1, attrs=...) at ../hw/block/pflash_cfi01.c:681
> #12 0x0000555555da3c17 in memory_region_write_with_attrs_accessor (mr=0x555556dda6a0, addr=189507, value=0x7ffff0ee8068, size=1, shift=0, mask=255, attrs=...) at ../softmmu/memory.c:514
> #13 0x0000555555da3e33 in access_with_adjusted_size (addr=189507, value=0x7ffff0ee8068, size=1, access_size_min=1, access_size_max=4, access_fn=0x555555da3b1b <memory_region_write_with_attrs_accessor>, mr=0x555556dda6a0, attrs=...) at ../softmmu/memory.c:569
> #14 0x0000555555da711b in memory_region_dispatch_write (mr=0x555556dda6a0, addr=189507, data=114, op=MO_8, attrs=...) at ../softmmu/memory.c:1540
> #15 0x0000555555db45dc in flatview_write_continue (fv=0x555557f53f80, addr=4290962499, attrs=..., ptr=0x7ffff7fbc028, len=1, addr1=189507, l=1, mr=0x555556dda6a0) at ../softmmu/physmem.c:2641
> #16 0x0000555555db473f in flatview_write (fv=0x555557f53f80, addr=4290962499, attrs=..., buf=0x7ffff7fbc028, len=1) at ../softmmu/physmem.c:2683
> #17 0x0000555555db4aef in address_space_write (as=0x555556a27780 <address_space_memory>, addr=4290962499, attrs=..., buf=0x7ffff7fbc028, len=1) at ../softmmu/physmem.c:2779
> #18 0x0000555555db4b5c in address_space_rw (as=0x555556a27780 <address_space_memory>, addr=4290962499, attrs=..., buf=0x7ffff7fbc028, len=1, is_write=true) at ../softmmu/physmem.c:2789
> #19 0x0000555555e4869b in kvm_cpu_exec (cpu=0x555556f2b050) at ../accel/kvm/kvm-all.c:3036
> #20 0x0000555555e4b40e in kvm_vcpu_thread_fn (arg=0x555556f2b050) at ../accel/kvm/kvm-accel-ops.c:51
> #21 0x000055555605f7e5 in qemu_thread_start (args=0x555556e0f0f0) at ../util/qemu-thread-posix.c:541
> #22 0x00007ffff62e1fd4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:442
> #23 0x00007ffff63625bc in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:81
After continuing, the main thread still waits:

> (gdb) bt
> #0  __futex_abstimed_wait_common64 (private=0, cancel=true, abstime=0x0, op=393, expected=0, futex_word=0x555556a1f868 <qemu_pause_cond+40>) at ./nptl/futex-internal.c:57
> #1  __futex_abstimed_wait_common (futex_word=futex_word@entry=0x555556a1f868 <qemu_pause_cond+40>, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0, cancel=cancel@entry=true) at ./nptl/futex-internal.c:87
> #2  0x00007ffff62ded9b in __GI___futex_abstimed_wait_cancelable64 (futex_word=futex_word@entry=0x555556a1f868 <qemu_pause_cond+40>, expected=expected@entry=0, clockid=clockid@entry=0, abstime=abstime@entry=0x0, private=private@entry=0) at ./nptl/futex-internal.c:139
> #3  0x00007ffff62e13f8 in __pthread_cond_wait_common (abstime=0x0, clockid=0, mutex=0x555556a1f7a0 <qemu_global_mutex>, cond=0x555556a1f840 <qemu_pause_cond>) at ./nptl/pthread_cond_wait.c:503
> #4  ___pthread_cond_wait (cond=0x555556a1f840 <qemu_pause_cond>, mutex=0x555556a1f7a0 <qemu_global_mutex>) at ./nptl/pthread_cond_wait.c:618
> #5  0x000055555605ef9d in qemu_cond_wait_impl (cond=0x555556a1f840 <qemu_pause_cond>, mutex=0x555556a1f7a0 <qemu_global_mutex>, file=0x5555561d483b "../softmmu/cpus.c", line=573) at ../util/qemu-thread-posix.c:225
> #6  0x0000555555b36891 in pause_all_vcpus () at ../softmmu/cpus.c:573
> #7  0x0000555555b35ef3 in do_vm_stop (state=RUN_STATE_SAVE_VM, send_stop=true) at ../softmmu/cpus.c:262
> #8  0x0000555555b36cab in vm_stop (state=RUN_STATE_SAVE_VM) at ../softmmu/cpus.c:676
> #9  0x0000555555b443ed in main_loop_should_exit (status=0x7fffffffd944) at ../softmmu/runstate.c:723
> #10 0x0000555555b4443e in qemu_main_loop () at ../softmmu/runstate.c:735
> #11 0x0000555555e57ec3 in qemu_default_main () at ../softmmu/main.c:37
> #12 0x0000555555e57ef9 in main (argc=56, argv=0x7fffffffdaa8) at ../softmmu/main.c:48




