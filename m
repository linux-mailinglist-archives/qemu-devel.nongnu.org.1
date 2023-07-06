Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3C9749D2A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:16:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOom-0000E3-VH; Thu, 06 Jul 2023 09:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qHOok-0000AC-Vo; Thu, 06 Jul 2023 09:14:42 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qHOof-00015E-MI; Thu, 06 Jul 2023 09:14:42 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 26DEB469A0;
 Thu,  6 Jul 2023 15:14:24 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, t.lamprecht@proxmox.com,
 qemu-stable@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH] qemu_cleanup: begin drained section after vm_shutdown()
Date: Thu,  6 Jul 2023 15:14:18 +0200
Message-Id: <20230706131418.423713-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

in order to avoid requests being stuck in a BlockBackend's request
queue during cleanup. Having such requests can lead to a deadlock [0]
with a virtio-scsi-pci device using iothread that's busy with IO when
initiating a shutdown with QMP 'quit'.

There is a race where such a queued request can continue sometime
(maybe after bdrv_child_free()?) during bdrv_root_unref_child() [1].
The completion will hold the AioContext lock and wait for the BQL
during SCSI completion, but the main thread will hold the BQL and
wait for the AioContext as part of bdrv_root_unref_child(), leading to
the deadlock [0].

[0]:

> Thread 3 (Thread 0x7f3bbd87b700 (LWP 135952) "qemu-system-x86"):
> #0  __lll_lock_wait (futex=futex@entry=0x564183365f00 <qemu_global_mutex>, private=0) at lowlevellock.c:52
> #1  0x00007f3bc1c0d843 in __GI___pthread_mutex_lock (mutex=0x564183365f00 <qemu_global_mutex>) at ../nptl/pthread_mutex_lock.c:80
> #2  0x0000564182939f2e in qemu_mutex_lock_impl (mutex=0x564183365f00 <qemu_global_mutex>, file=0x564182b7f774 "../softmmu/physmem.c", line=2593) at ../util/qemu-thread-posix.c:94
> #3  0x000056418247cc2a in qemu_mutex_lock_iothread_impl (file=0x564182b7f774 "../softmmu/physmem.c", line=2593) at ../softmmu/cpus.c:504
> #4  0x00005641826d5325 in prepare_mmio_access (mr=0x5641856148a0) at ../softmmu/physmem.c:2593
> #5  0x00005641826d6fe7 in address_space_stl_internal (as=0x56418679b310, addr=4276113408, val=16418, attrs=..., result=0x0, endian=DEVICE_LITTLE_ENDIAN) at /home/febner/repos/qemu/memory_ldst.c.inc:318
> #6  0x00005641826d7154 in address_space_stl_le (as=0x56418679b310, addr=4276113408, val=16418, attrs=..., result=0x0) at /home/febner/repos/qemu/memory_ldst.c.inc:357
> #7  0x0000564182374b07 in pci_msi_trigger (dev=0x56418679b0d0, msg=...) at ../hw/pci/pci.c:359
> #8  0x000056418237118b in msi_send_message (dev=0x56418679b0d0, msg=...) at ../hw/pci/msi.c:379
> #9  0x0000564182372c10 in msix_notify (dev=0x56418679b0d0, vector=8) at ../hw/pci/msix.c:542
> #10 0x000056418243719c in virtio_pci_notify (d=0x56418679b0d0, vector=8) at ../hw/virtio/virtio-pci.c:77
> #11 0x00005641826933b0 in virtio_notify_vector (vdev=0x5641867a34a0, vector=8) at ../hw/virtio/virtio.c:1985
> #12 0x00005641826948d6 in virtio_irq (vq=0x5641867ac078) at ../hw/virtio/virtio.c:2461
> #13 0x0000564182694978 in virtio_notify (vdev=0x5641867a34a0, vq=0x5641867ac078) at ../hw/virtio/virtio.c:2473
> #14 0x0000564182665b83 in virtio_scsi_complete_req (req=0x7f3bb000e5d0) at ../hw/scsi/virtio-scsi.c:115
> #15 0x00005641826670ce in virtio_scsi_complete_cmd_req (req=0x7f3bb000e5d0) at ../hw/scsi/virtio-scsi.c:641
> #16 0x000056418266736b in virtio_scsi_command_complete (r=0x7f3bb0010560, resid=0) at ../hw/scsi/virtio-scsi.c:712
> #17 0x000056418239aac6 in scsi_req_complete (req=0x7f3bb0010560, status=2) at ../hw/scsi/scsi-bus.c:1526
> #18 0x000056418239e090 in scsi_handle_rw_error (r=0x7f3bb0010560, ret=-123, acct_failed=false) at ../hw/scsi/scsi-disk.c:242
> #19 0x000056418239e13f in scsi_disk_req_check_error (r=0x7f3bb0010560, ret=-123, acct_failed=false) at ../hw/scsi/scsi-disk.c:265
> #20 0x000056418239e482 in scsi_dma_complete_noio (r=0x7f3bb0010560, ret=-123) at ../hw/scsi/scsi-disk.c:340
> #21 0x000056418239e5d9 in scsi_dma_complete (opaque=0x7f3bb0010560, ret=-123) at ../hw/scsi/scsi-disk.c:371
> #22 0x00005641824809ad in dma_complete (dbs=0x7f3bb000d9d0, ret=-123) at ../softmmu/dma-helpers.c:107
> #23 0x0000564182480a72 in dma_blk_cb (opaque=0x7f3bb000d9d0, ret=-123) at ../softmmu/dma-helpers.c:127
> #24 0x00005641827bf78a in blk_aio_complete (acb=0x7f3bb00021a0) at ../block/block-backend.c:1563
> #25 0x00005641827bfa5e in blk_aio_write_entry (opaque=0x7f3bb00021a0) at ../block/block-backend.c:1630
> #26 0x000056418295638a in coroutine_trampoline (i0=-1342102448, i1=32571) at ../util/coroutine-ucontext.c:177
> #27 0x00007f3bc0caed40 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #28 0x00007f3bbd8757f0 in ?? ()
> #29 0x0000000000000000 in ?? ()
>
> Thread 1 (Thread 0x7f3bbe3e9280 (LWP 135944) "qemu-system-x86"):
> #0  __lll_lock_wait (futex=futex@entry=0x5641856f2a00, private=0) at lowlevellock.c:52
> #1  0x00007f3bc1c0d8d1 in __GI___pthread_mutex_lock (mutex=0x5641856f2a00) at ../nptl/pthread_mutex_lock.c:115
> #2  0x0000564182939f2e in qemu_mutex_lock_impl (mutex=0x5641856f2a00, file=0x564182c0e319 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:94
> #3  0x000056418293a140 in qemu_rec_mutex_lock_impl (mutex=0x5641856f2a00, file=0x564182c0e319 "../util/async.c", line=728) at ../util/qemu-thread-posix.c:149
> #4  0x00005641829532d5 in aio_context_acquire (ctx=0x5641856f29a0) at ../util/async.c:728
> #5  0x000056418279d5df in bdrv_set_aio_context_commit (opaque=0x5641856e6e50) at ../block.c:7493
> #6  0x000056418294e288 in tran_commit (tran=0x56418630bfe0) at ../util/transactions.c:87
> #7  0x000056418279d880 in bdrv_try_change_aio_context (bs=0x5641856f7130, ctx=0x56418548f810, ignore_child=0x0, errp=0x0) at ../block.c:7626
> #8  0x0000564182793f39 in bdrv_root_unref_child (child=0x5641856f47d0) at ../block.c:3242
> #9  0x00005641827be137 in blk_remove_bs (blk=0x564185709880) at ../block/block-backend.c:914
> #10 0x00005641827bd689 in blk_remove_all_bs () at ../block/block-backend.c:583
> #11 0x0000564182798699 in bdrv_close_all () at ../block.c:5117
> #12 0x000056418248a5b2 in qemu_cleanup () at ../softmmu/runstate.c:821
> #13 0x0000564182738603 in qemu_default_main () at ../softmmu/main.c:38
> #14 0x0000564182738631 in main (argc=30, argv=0x7ffd675a8a48) at ../softmmu/main.c:48
>
> (gdb) p *((QemuMutex*)0x5641856f2a00)
> $1 = {lock = {__data = {__lock = 2, __count = 2, __owner = 135952, ...
> (gdb) p *((QemuMutex*)0x564183365f00)
> $2 = {lock = {__data = {__lock = 2, __count = 0, __owner = 135944, ...

[1]:

> Thread 1 "qemu-system-x86" hit Breakpoint 5, bdrv_drain_all_end () at ../block/io.c:551
> #0  bdrv_drain_all_end () at ../block/io.c:551
> #1  0x00005569810f0376 in bdrv_graph_wrlock (bs=0x0) at ../block/graph-lock.c:156
> #2  0x00005569810bd3e0 in bdrv_replace_child_noperm (child=0x556982e2d7d0, new_bs=0x0) at ../block.c:2897
> #3  0x00005569810bdef2 in bdrv_root_unref_child (child=0x556982e2d7d0) at ../block.c:3227
> #4  0x00005569810e8137 in blk_remove_bs (blk=0x556982e42880) at ../block/block-backend.c:914
> #5  0x00005569810e7689 in blk_remove_all_bs () at ../block/block-backend.c:583
> #6  0x00005569810c2699 in bdrv_close_all () at ../block.c:5117
> #7  0x0000556980db45b2 in qemu_cleanup () at ../softmmu/runstate.c:821
> #8  0x0000556981062603 in qemu_default_main () at ../softmmu/main.c:38
> #9  0x0000556981062631 in main (argc=30, argv=0x7ffd7a82a418) at ../softmmu/main.c:48
> [Switching to Thread 0x7fe76dab2700 (LWP 103649)]
>
> Thread 3 "qemu-system-x86" hit Breakpoint 4, blk_inc_in_flight (blk=0x556982e42880) at ../block/block-backend.c:1505
> #0  blk_inc_in_flight (blk=0x556982e42880) at ../block/block-backend.c:1505
> #1  0x00005569810e8f36 in blk_wait_while_drained (blk=0x556982e42880) at ../block/block-backend.c:1312
> #2  0x00005569810e9231 in blk_co_do_pwritev_part (blk=0x556982e42880, offset=3422961664, bytes=4096, qiov=0x556983028060, qiov_offset=0, flags=0) at ../block/block-backend.c:1402
> #3  0x00005569810e9a4b in blk_aio_write_entry (opaque=0x556982e2cfa0) at ../block/block-backend.c:1628
> #4  0x000055698128038a in coroutine_trampoline (i0=-2090057872, i1=21865) at ../util/coroutine-ucontext.c:177
> #5  0x00007fe770f50d40 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
> #6  0x00007ffd7a829570 in ?? ()
> #7  0x0000000000000000 in ?? ()

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Does there need to be another bdrv_flush_all() like there is in
do_vm_stop() since that is now not inside the final drained section
anymore?

 softmmu/runstate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index a9fbcf4862..f3bd862818 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -802,21 +802,21 @@ void qemu_cleanup(void)
      */
     blk_exp_close_all();
 
+
+    /* No more vcpu or device emulation activity beyond this point */
+    vm_shutdown();
+    replay_finish();
+
     /*
      * We must cancel all block jobs while the block layer is drained,
      * or cancelling will be affected by throttling and thus may block
      * for an extended period of time.
-     * vm_shutdown() will bdrv_drain_all(), so we may as well include
-     * it in the drained section.
+     * Begin the drained section after vm_shutdown() to avoid requests being
+     * stuck in the BlockBackend's request queue.
      * We do not need to end this section, because we do not want any
      * requests happening from here on anyway.
      */
     bdrv_drain_all_begin();
-
-    /* No more vcpu or device emulation activity beyond this point */
-    vm_shutdown();
-    replay_finish();
-
     job_cancel_sync_all();
     bdrv_close_all();
 
-- 
2.30.2



