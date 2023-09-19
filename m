Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A57507A604C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:56:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiYNt-0006vx-H9; Tue, 19 Sep 2023 06:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiYNp-0006v3-UK
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qiYNn-0008B6-3e
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695120905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=we0Pi0iYgzFQhArvLov9qWCSJxy3x9NNODxRERAQ00w=;
 b=fwO0QySg0LppyAIyDDA8ZftLF5HflTWpGD7nsbmB9zaNjaXRkmnsjuJ7V5x5LZEfv0YBhj
 mOjdKFbD7sm7khWaDukyQZE1y8Fmyj5RMXCGc+Xy88KRZpH0lKu39Tsofh9PPFl9iYK314
 s/L92wE1kKJCla/286k2x/3R/GL4IU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-Ftu5NpitOTSEvs8HnP7peA-1; Tue, 19 Sep 2023 06:55:02 -0400
X-MC-Unique: Ftu5NpitOTSEvs8HnP7peA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1EFC802D38;
 Tue, 19 Sep 2023 10:55:01 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B85F820268CC;
 Tue, 19 Sep 2023 10:55:00 +0000 (UTC)
Date: Tue, 19 Sep 2023 12:54:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Levon <levon@movementarian.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Hanna Czenczek <hreitz@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Deadlock with SATA CD I/O and eject
Message-ID: <ZQl+A0nys2v7UzeN@redhat.com>
References: <ZQiIxERjYmZb0v4l@movementarian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQiIxERjYmZb0v4l@movementarian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 18.09.2023 um 19:28 hat John Levon geschrieben:
> 
> Observed with base of qemu 6.2.0, but from code inspection it looks to me like
> it's still current in upstream master. Apologies if I have missed a fix in this
> area.
> 
> Symptom: run a UEFI-booted SATA CD Windows installer. When it hits "Loading
> files.." screen, run an eject e.g.
> 
> virsh qemu-monitor-command 64c6e190-ea7f-49e2-b2d5-6ba1814b00ae '{"execute":"eject", "arguments": { "id": "sata0-0-0" } }'
> 
> qemu will get stuck like so:
> 
> gdb) bt
> #0  0x00007f8ba4b16036 in ppoll () from /lib64/libc.so.6
> #1  0x0000561813c48ed5 in ppoll (__ss=0x0, __timeout=0x7ffcbd981a70, __nfds=<optimized out>, __fds=<optimized out>) at /usr/include/bits/poll2.h:62
> #2  qemu_poll_ns (fds=<optimized out>, nfds=<optimized out>, timeout=timeout@entry=999896128) at ../util/qemu-timer.c:348
> #3  0x0000561813c29be9 in fdmon_poll_wait (ctx=0x56181516e070, ready_list=0x7ffcbd981af0, timeout=999896128) at ../util/fdmon-poll.c:80
> #4  0x0000561813c297e1 in aio_poll (ctx=ctx@entry=0x56181516e070, blocking=blocking@entry=true) at ../util/aio-posix.c:607
> #5  0x0000561813ae2fad in bdrv_do_drained_begin (poll=true, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x56181533fcc0) at ../block/io.c:483
> #6  bdrv_do_drained_begin (bs=0x56181533fcc0, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at ../block/io.c:446
> #7  0x0000561813ad9982 in blk_drain (blk=0x5618161c1f10) at ../block/block-backend.c:1741
> #8  0x0000561813ad9b8c in blk_remove_bs (blk=blk@entry=0x5618161c1f10) at ../block/block-backend.c:852
> #9  0x000056181382b8ab in blockdev_remove_medium (has_device=<optimized out>, device=<optimized out>, has_id=<optimized out>, id=<optimized out>, errp=0x7ffcbd981c78) at ../block/qapi-sysemu.c:232
> #10 0x000056181382bfb1 in qmp_eject (has_device=<optimized out>, device=0x0, has_id=<optimized out>, id=0x561815e6efe0 "sata0-0-0", has_force=<optimized out>, force=<optimized out>, errp=0x7ffcbd981c78) at ../block/qapi-sysemu.c:45
> 
> We are stuck forever here:
> 
>  351 static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
>  352                                   bool poll)
> ...
>  380     if (poll) {
>  381         BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, parent));
>  382     }
> 
> Because the blk root's ->in_flight is 1, as tested by the condition
> blk_root_drained_poll().
> 
> 
> Our blk->in_flight user is stuck here:
> 
> 1298 static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
> ...
> 1310         blk_dec_in_flight(blk);
> 1311         qemu_co_queue_wait(&blk->queued_requests, &blk->queued_requests_lock);
> 1312         blk_inc_in_flight(blk);
> 
> Note that before entering this stanza, blk->in_flight was 2. This turns out to
> be due to the ide atapi code. In particular, the guest VM is generating lots of
> read I/O. The "first IO" arrives into blk via:
> 
> cd_read_sector()->ide_buffered_readv()->blk_aio_preadv()
> 
> This initial IO completes:
> 
> blk_aio_read_entry()->blk_aio_complete()
> 
> 1560 static void blk_aio_complete(BlkAioEmAIOCB *acb)
> 1561 {
> 1562     if (acb->has_returned) {
> 1563         acb->common.cb(acb->common.opaque, acb->rwco.ret);
> 1564         blk_dec_in_flight(acb->rwco.blk);
> 1565         qemu_aio_unref(acb);
> 1566     }
> 1567 }
> 
> Line 1564 is what we need to move blk->in_flight down to zero, but that is never
> reached! This is because of what happens at :1563
> 
> acm->common.cb()->cd_read_sector_cb()->ide_atapi_cmd_reply_end()->cd_read_sector_sync()->blk_pread()
> 
> That is, the IO callback in the atapi code itself triggers more - synchronous - IO.
> 
> In the meantime, we start processing the blk_drain() code, so by the time this
> blk_pread() actually gets handled, quiesce is set, and we get stuck in the
> blk_wait_while_drained().
> 
> I don't know the qemu block stack well enough to propose an actual fix.
> 
> Experimentally, waiting for ->in_flight to drop to zero *before* we quiesce in
> blk_remove_bs() via an AIO_WAIT_WHILE() avoids the symptom, but I'm pretty sure
> that's just a band-aid instead of fixing the deadlock.
> 
> Any suggestions/clues/thoughts?

Related discussion: https://lists.gnu.org/archive/html/qemu-block/2023-03/msg00284.html

Actually, it seems we never fixed that problem either?

Back then I suggested that blk_drain*() should disable request queuing
because its callers don't want to quiesce the BlockBackend, but rather
get their own requests completed. I think this approach would solve this
one as well.

Your experiment with moving the queuing later is basically what Paolo
suggested, though I'd still argue it's not the right thing to do because
while it seems to mostly work with both use cases of drain (give me
exclusive access vs. wait for my requests to complete), it's not optimal
for either one.

Kevin


