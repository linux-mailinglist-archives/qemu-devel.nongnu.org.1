Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE39283DA9E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jan 2024 14:20:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTM6V-0003GK-Vw; Fri, 26 Jan 2024 08:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTM6N-0003EW-RP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:18:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rTM6L-000413-9d
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 08:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706275111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FgUPFBhD4Y81DH+QhopsCurpAIOnn/5E43L6+jU8SEk=;
 b=C4DMpsqosx+pk7BAmal5wQixvIky145yseP2xDWxDC27Vbm78zxwtWNUginzM+Bd+4hVkF
 9mCMGD4xfn32IX1d1w4HiKhGGMHomxEcyroIitwlp6OJ5jN1MZYpHThseetMnNOhQMW0AD
 GJZiQ3WK37gsEoMUUJM0cXKTLV27hto=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-5SaLOUdcPyWQSccqax8fFw-1; Fri, 26 Jan 2024 08:18:30 -0500
X-MC-Unique: 5SaLOUdcPyWQSccqax8fFw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF136185A782;
 Fri, 26 Jan 2024 13:18:29 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 057CD492BC9;
 Fri, 26 Jan 2024 13:18:28 +0000 (UTC)
Date: Fri, 26 Jan 2024 14:18:27 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PULL 11/33] scsi: only access SCSIDevice->requests from one
 thread
Message-ID: <ZbOxI9Ar-YDn51Z0@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
 <20231221212339.164439-12-kwolf@redhat.com>
 <73e752b2-a037-4b10-a903-56fa6ad75c6e@redhat.com>
 <Za_zAj11uwavd2va@redhat.com>
 <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08a66849-f190-4756-9b01-666f0d66afb6@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 25.01.2024 um 18:32 hat Hanna Czenczek geschrieben:
> On 23.01.24 18:10, Kevin Wolf wrote:
> > Am 23.01.2024 um 17:40 hat Hanna Czenczek geschrieben:
> > > On 21.12.23 22:23, Kevin Wolf wrote:
> > > > From: Stefan Hajnoczi<stefanha@redhat.com>
> > > > 
> > > > Stop depending on the AioContext lock and instead access
> > > > SCSIDevice->requests from only one thread at a time:
> > > > - When the VM is running only the BlockBackend's AioContext may access
> > > >     the requests list.
> > > > - When the VM is stopped only the main loop may access the requests
> > > >     list.
> > > > 
> > > > These constraints protect the requests list without the need for locking
> > > > in the I/O code path.
> > > > 
> > > > Note that multiple IOThreads are not supported yet because the code
> > > > assumes all SCSIRequests are executed from a single AioContext. Leave
> > > > that as future work.
> > > > 
> > > > Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> > > > Reviewed-by: Eric Blake<eblake@redhat.com>
> > > > Message-ID:<20231204164259.1515217-2-stefanha@redhat.com>
> > > > Signed-off-by: Kevin Wolf<kwolf@redhat.com>
> > > > ---
> > > >    include/hw/scsi/scsi.h |   7 +-
> > > >    hw/scsi/scsi-bus.c     | 181 ++++++++++++++++++++++++++++-------------
> > > >    2 files changed, 131 insertions(+), 57 deletions(-)
> > > My reproducer for https://issues.redhat.com/browse/RHEL-3934 now breaks more
> > > often because of this commit than because of the original bug, i.e. when
> > > repeatedly hot-plugging and unplugging a virtio-scsi and a scsi-hd device,
> > > this tends to happen when unplugging the scsi-hd:
> > > 
> > > {"execute":"device_del","arguments":{"id":"stg0"}}
> > > {"return": {}}
> > > qemu-system-x86_64: ../block/block-backend.c:2429: blk_get_aio_context:
> > > Assertion `ctx == blk->ctx' failed.
> 
> [...]
> 
> > > I don’t know anything about the problem yet, but as usual, I like
> > > speculation and discovering how wrong I was later on, so one thing I came
> > > across that’s funny about virtio-scsi is that requests can happen even while
> > > a disk is being attached or detached.  That is, Linux seems to probe all
> > > LUNs when a new virtio-scsi device is being attached, and it won’t stop just
> > > because a disk is being attached or removed.  So maybe that’s part of the
> > > problem, that we get a request while the BB is being detached, and
> > > temporarily in an inconsistent state (BDS context differs from BB context).
> > I don't know anything about the problem either, but since you already
> > speculated about the cause, let me speculate about the solution:
> > Can we hold the graph writer lock for the tran_commit() call in
> > bdrv_try_change_aio_context()? And of course take the reader lock for
> > blk_get_aio_context(), but that should be completely unproblematic.
> 
> Actually, now that completely unproblematic part is giving me trouble.  I
> wanted to just put a graph lock into blk_get_aio_context() (making it a
> coroutine with a wrapper)

Which is the first thing I neglected and already not great. We have
calls of blk_get_aio_context() in the SCSI I/O path, and creating a
coroutine and doing at least two context switches simply for this call
is a lot of overhead...

> but callers of blk_get_aio_context() generally assume the context is
> going to stay the BB’s context for as long as their AioContext *
> variable is in scope.

I'm not so sure about that. And taking another step back, I'm actually
also not sure how much it still matters now that they can submit I/O
from any thread.

Maybe the correct solution is to remove the assertion from
blk_get_aio_context() and just always return blk->ctx. If it's in the
middle of a change, you'll either get the old one or the new one. Either
one is fine to submit I/O from, and if you care about changes for other
reasons (like SCSI does), then you need explicit code to protect it
anyway (which SCSI apparently has, but it doesn't work).

> I was tempted to think callers know what happens to the BB they pass
> to blk_get_aio_context(), and it won’t change contexts so easily, but
> then I remembered this is exactly what happens in this case; we run
> scsi_device_for_each_req_async_bh() in one thread (which calls
> blk_get_aio_context()), and in the other, we change the BB’s context.

Let's think a bit more about scsi_device_for_each_req_async()
specifically. This is a function that runs in the main thread. Nothing
will change any AioContext assignment if it doesn't call it. It wants to
make sure that scsi_device_for_each_req_async_bh() is called in the
same AioContext where the virtqueue is processed, so it schedules a BH
and waits for it.

Waiting for it means running a nested event loop that could do anything,
including changing AioContexts. So this is what needs the locking, not
the blk_get_aio_context() call in scsi_device_for_each_req_async_bh().
If we lock before the nested event loop and unlock in the BH, the check
in the BH can become an assertion. (It is important that we unlock in
the BH rather than after waiting because if something takes the writer
lock, we need to unlock during the nested event loop of bdrv_wrlock() to
avoid a deadlock.)

And spawning a coroutine for this looks a lot more acceptable because
it's on a slow path anyway.

In fact, we probably don't technically need a coroutine to take the
reader lock here. We can have a new graph lock function that asserts
that there is no writer (we know because we're running in the main loop)
and then atomically increments the reader count. But maybe that already
complicates things again...

> It seems like there are very few blk_* functions right now that
> require taking a graph lock around it, so I’m hesitant to go that
> route.  But if we’re protecting a BB’s context via the graph write
> lock, I can’t think of a way around having to take a read lock
> whenever reading a BB’s context, and holding it for as long as we
> assume that context to remain the BB’s context.  It’s also hard to
> figure out how long that is, case by case; for example, dma_blk_read()
> schedules an AIO function in the BB context; but we probably don’t
> care that this context remains the BB’s context until the request is
> done.  In the case of scsi_device_for_each_req_async_bh(), we already
> take care to re-schedule it when it turns out the context is outdated,
> so it does seem quite important here, and we probably want to keep the
> lock until after the QTAILQ_FOREACH_SAFE() loop.

Maybe we need to audit all callers. Fortunately, there don't seem to be
too many. At least not direct ones...

> On a tangent, this TOCTTOU problem makes me wary of other blk_*
> functions that query information.  For example, fuse_read() (in
> block/export/fuse.c) truncates requests to the BB length.  But what if
> the BB length changes concurrently between blk_getlength() and
> blk_pread()?  While we can justify using the graph lock for a BB’s
> AioContext, we can’t use it for other metadata like its length.

Hm... Is "tough luck" an acceptable answer? ;-)

Kevin


