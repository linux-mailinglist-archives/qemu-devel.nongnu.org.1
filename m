Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89109822C4C
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 12:41:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKzbz-0005rj-7J; Wed, 03 Jan 2024 06:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rKzbv-0005rH-3c; Wed, 03 Jan 2024 06:40:35 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1rKzbq-0005aB-BR; Wed, 03 Jan 2024 06:40:34 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A13E648CD4;
 Wed,  3 Jan 2024 12:40:18 +0100 (CET)
Message-ID: <016ac3d1-f6c1-48eb-a714-fb777dff7012@proxmox.com>
Date: Wed, 3 Jan 2024 12:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 pbonzini@redhat.com, Fam Zheng <fam@euphon.net>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <142d6078-1bb9-4116-ac87-7daac16f12d8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Am 02.01.24 um 16:24 schrieb Hanna Czenczek:
> 
> I’ve attached the preliminary patch that I didn’t get to send (or test
> much) last year.  Not sure if it has the same CPU-usage-spike issue
> Fiona was seeing, the only functional difference is that I notify the vq
> after attaching the notifiers instead of before.
> 

Applied the patch on top of c12887e1b0 ("block-coroutine-wrapper: use
qemu_get_current_aio_context()") because it conflicts with b6948ab01d
("virtio-blk: add iothread-vq-mapping parameter").

I'm happy to report that I cannot reproduce the CPU-usage-spike issue
with the patch, but I did run into an assertion failure when trying to
verify that it fixes my original stuck-guest-IO issue. See below for the
backtrace [0]. Hanna wrote in https://issues.redhat.com/browse/RHEL-3934

> I think it’s sufficient to simply call virtio_queue_notify_vq(vq) after the virtio_queue_aio_attach_host_notifier(vq, ctx) call, because both virtio-scsi’s and virtio-blk’s .handle_output() implementations acquire the device’s context, so this should be directly callable from any context.

I guess this is not true anymore now that the AioContext locking was
removed?

Back to the CPU-usage-spike issue: I experimented around and it doesn't
seem to matter whether I notify the virt queue before or after attaching
the notifiers. But there's another functional difference. My patch
called virtio_queue_notify() which contains this block:

>     if (vq->host_notifier_enabled) {
>         event_notifier_set(&vq->host_notifier);
>     } else if (vq->handle_output) {
>         vq->handle_output(vdev, vq);

In my testing, the first branch was taken, calling event_notifier_set().
Hanna's patch uses virtio_queue_notify_vq() and there,
vq->handle_output() will be called. That seems to be the relevant
difference regarding the CPU-usage-spike issue.

Best Regards,
Fiona

[0]:

> #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
> #1  0x00007ffff60e3d9f in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
> #2  0x00007ffff6094f32 in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> #3  0x00007ffff607f472 in __GI_abort () at ./stdlib/abort.c:79
> #4  0x00007ffff607f395 in __assert_fail_base (fmt=0x7ffff61f3a90 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", 
>     assertion=assertion@entry=0x555556246bf8 "ctx == qemu_get_current_aio_context()", 
>     file=file@entry=0x555556246baf "../system/dma-helpers.c", line=line@entry=123, 
>     function=function@entry=0x555556246c70 <__PRETTY_FUNCTION__.1> "dma_blk_cb") at ./assert/assert.c:92
> #5  0x00007ffff608de32 in __GI___assert_fail (assertion=0x555556246bf8 "ctx == qemu_get_current_aio_context()", 
>     file=0x555556246baf "../system/dma-helpers.c", line=123, function=0x555556246c70 <__PRETTY_FUNCTION__.1> "dma_blk_cb")
>     at ./assert/assert.c:101
> #6  0x0000555555b83425 in dma_blk_cb (opaque=0x55555804f150, ret=0) at ../system/dma-helpers.c:123
> #7  0x0000555555b839ec in dma_blk_io (ctx=0x555557404310, sg=0x5555588ca6f8, offset=70905856, align=512, 
>     io_func=0x555555a94a87 <scsi_dma_readv>, io_func_opaque=0x55555817ea00, cb=0x555555a8d99f <scsi_dma_complete>, opaque=0x55555817ea00, 
>     dir=DMA_DIRECTION_FROM_DEVICE) at ../system/dma-helpers.c:236
> #8  0x0000555555a8de9a in scsi_do_read (r=0x55555817ea00, ret=0) at ../hw/scsi/scsi-disk.c:431
> #9  0x0000555555a8e249 in scsi_read_data (req=0x55555817ea00) at ../hw/scsi/scsi-disk.c:501
> #10 0x0000555555a897e3 in scsi_req_continue (req=0x55555817ea00) at ../hw/scsi/scsi-bus.c:1478
> #11 0x0000555555d8270e in virtio_scsi_handle_cmd_req_submit (s=0x555558669af0, req=0x5555588ca6b0) at ../hw/scsi/virtio-scsi.c:828
> #12 0x0000555555d82937 in virtio_scsi_handle_cmd_vq (s=0x555558669af0, vq=0x555558672550) at ../hw/scsi/virtio-scsi.c:870
> #13 0x0000555555d829a9 in virtio_scsi_handle_cmd (vdev=0x555558669af0, vq=0x555558672550) at ../hw/scsi/virtio-scsi.c:883
> #14 0x0000555555db3784 in virtio_queue_notify_vq (vq=0x555558672550) at ../hw/virtio/virtio.c:2268
> #15 0x0000555555d8346a in virtio_scsi_drained_end (bus=0x555558669d88) at ../hw/scsi/virtio-scsi.c:1179
> #16 0x0000555555a8a549 in scsi_device_drained_end (sdev=0x555558105000) at ../hw/scsi/scsi-bus.c:1774
> #17 0x0000555555a931db in scsi_disk_drained_end (opaque=0x555558105000) at ../hw/scsi/scsi-disk.c:2369
> #18 0x0000555555ee439c in blk_root_drained_end (child=0x5555574065d0) at ../block/block-backend.c:2829
> #19 0x0000555555ef0ac3 in bdrv_parent_drained_end_single (c=0x5555574065d0) at ../block/io.c:74
> #20 0x0000555555ef0b02 in bdrv_parent_drained_end (bs=0x555557409f80, ignore=0x0) at ../block/io.c:89
> #21 0x0000555555ef1b1b in bdrv_do_drained_end (bs=0x555557409f80, parent=0x0) at ../block/io.c:421
> #22 0x0000555555ef1b5a in bdrv_drained_end (bs=0x555557409f80) at ../block/io.c:428
> #23 0x0000555555efcf64 in mirror_exit_common (job=0x5555588b8220) at ../block/mirror.c:798
> #24 0x0000555555efcfde in mirror_abort (job=0x5555588b8220) at ../block/mirror.c:814
> #25 0x0000555555ec53ea in job_abort (job=0x5555588b8220) at ../job.c:825
> #26 0x0000555555ec54d5 in job_finalize_single_locked (job=0x5555588b8220) at ../job.c:855
> #27 0x0000555555ec57cb in job_completed_txn_abort_locked (job=0x5555588b8220) at ../job.c:958
> #28 0x0000555555ec5c20 in job_completed_locked (job=0x5555588b8220) at ../job.c:1065
> #29 0x0000555555ec5cd5 in job_exit (opaque=0x5555588b8220) at ../job.c:1088
> #30 0x000055555608342e in aio_bh_call (bh=0x7fffe400dfd0) at ../util/async.c:169
> #31 0x0000555556083549 in aio_bh_poll (ctx=0x55555718ade0) at ../util/async.c:216
> #32 0x0000555556065203 in aio_dispatch (ctx=0x55555718ade0) at ../util/aio-posix.c:423
> #33 0x0000555556083988 in aio_ctx_dispatch (source=0x55555718ade0, callback=0x0, user_data=0x0) at ../util/async.c:358
> #34 0x00007ffff753e7a9 in g_main_context_dispatch () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
> #35 0x00005555560850ae in glib_pollfds_poll () at ../util/main-loop.c:290
> #36 0x000055555608512b in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:313
> #37 0x0000555556085239 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:592
> #38 0x0000555555b8d501 in qemu_main_loop () at ../system/runstate.c:782
> #39 0x0000555555e55587 in qemu_default_main () at ../system/main.c:37
> #40 0x0000555555e555c2 in main (argc=68, argv=0x7fffffffd8b8) at ../system/main.c:48


