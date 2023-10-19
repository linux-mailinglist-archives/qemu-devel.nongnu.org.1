Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DAA7CF882
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:15:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRvD-0008Ub-9H; Thu, 19 Oct 2023 08:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qtRuw-0008Ou-Bg
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qtRut-00085f-NN
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697717658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vCjHXQ67dfjwM4d28yPczalsclVjgKxSY8S0DPjLQK0=;
 b=Gci15tlYpG3sHJPdWmb9iipG72NWnDB1R9xLyoOXJeFf9+0IaJKw4yLLMd/HINjn0dOkL6
 t/d/bLUTQYDr2Y/YbRSYRgYyhR5KPIDKA7VkblW5SapkWXPa8XiVV9L62mWlNyhuZfcu4O
 lTNHZrm0lgJyzU9xmepciTOFcsq2uKk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-bneKH_gsPPuB5GMg9F43iQ-1; Thu, 19 Oct 2023 08:14:14 -0400
X-MC-Unique: bneKH_gsPPuB5GMg9F43iQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EE4129AA381;
 Thu, 19 Oct 2023 12:14:14 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E30732026D4C;
 Thu, 19 Oct 2023 12:14:12 +0000 (UTC)
Date: Thu, 19 Oct 2023 14:14:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: deadlock when using iothread during backup_clean()
Message-ID: <ZTEdk5gKXlIrKNm8@redhat.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
 <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
 <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
 <2ca4eb06-75c3-7bd8-972b-b37af47743dc@yandex-team.ru>
 <71e3112d-3d3f-fd55-4099-6765d4f22205@proxmox.com>
 <76f9678d-ed92-418e-8d1e-c6dc55f83279@proxmox.com>
 <ZS56FzuqZSApXBbc@redhat.com>
 <c2a6c1b6-0438-488f-bba3-1014ffdadbce@proxmox.com>
 <ZS6YFtYKyFLbfrrP@redhat.com>
 <3e1c941b-2b76-4f85-88cb-4a2a968eb3e6@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1c941b-2b76-4f85-88cb-4a2a968eb3e6@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 18.10.2023 um 11:42 hat Fiona Ebner geschrieben:
> Am 17.10.23 um 16:20 schrieb Kevin Wolf:
> > Am 17.10.2023 um 15:37 hat Fiona Ebner geschrieben:
> >> Am 17.10.23 um 14:12 schrieb Kevin Wolf:
> >>> Am 17.10.2023 um 12:18 hat Fiona Ebner geschrieben:
> >>>> I ran into similar issues now with mirror, (both deadlocks and stuck
> >>>> guest IO at other times), and interestingly, also during job start.
> >>>>
> >>>> Also had a backtrace similar to [0] once, so I took a closer look.
> >>>> Probably was obvious to others already, but for the record:
> >>>>
> >>>> 1. the graph is locked by the main thread
> >>>> 2. the iothread holds the AioContext lock
> >>>> 3. the main thread waits on the AioContext lock
> >>>> 4. the iothread waits for coroutine spawned by blk_is_available()
> >>>
> >>> Where does this blk_is_available() in the iothread come from? Having it
> >>> wait without dropping the AioContext lock sounds like something that
> >>> we'd want to avoid. Ideally, devices using iothreads shouldn't use
> >>> synchronous requests at all, but I think scsi-disk might have some of
> >>> them.
> >>>
> >>
> >> It's part of the request handling in virtio-scsi:
> >>
> >>> #0  0x00007ff7f5f55136 in __ppoll (fds=0x7ff7e40030c0, nfds=8, timeout=<optimized out>, sigmask=0x0) at ../sysdeps/unix/sysv/linux/ppoll.c:42
> >>> #1  0x00005587132615ab in qemu_poll_ns (fds=0x7ff7e40030c0, nfds=8, timeout=-1) at ../util/qemu-timer.c:339
> >>> #2  0x000055871323e8b1 in fdmon_poll_wait (ctx=0x55871598d5e0, ready_list=0x7ff7f288ebe0, timeout=-1) at ../util/fdmon-poll.c:79
> >>> #3  0x000055871323e1ed in aio_poll (ctx=0x55871598d5e0, blocking=true) at ../util/aio-posix.c:670
> >>> #4  0x0000558713089efa in bdrv_poll_co (s=0x7ff7f288ec90) at /home/febner/repos/qemu/block/block-gen.h:43
> >>> #5  0x000055871308c362 in blk_is_available (blk=0x55871599e2f0) at block/block-gen.c:1426
> >>> #6  0x0000558712f6843b in virtio_scsi_ctx_check (s=0x558716c049c0, d=0x55871581cd30) at ../hw/scsi/virtio-scsi.c:290
> > 
> > Oh... So essentially for an assertion.
> > 
> > I wonder if the blk_is_available() check introduced in 2a2d69f490c is
> > even necessary any more, because BlockBackend has its own AioContext
> > now. And if blk_bs(blk) != NULL isn't what we actually want to check if
> > the check is necessary, because calling bdrv_is_inserted() doesn't seem
> > to have been intended. blk_bs() wouldn't have to poll.
> > 
> 
> Could virtio_scsi_hotunplug() be an issue with removing or modifying
> the check? There's a call there which sets the blk's AioContext to
> qemu_get_aio_context(). Or are we sure that the assert in
> virtio_scsi_ctx_check() can't be reached after that?

I think that would be the kind of bug that the assertion tries to
catch, because then we would be sending requests to blk from a thread
that doesn't match its AioContext (which will be allowed soon, but not
quite yet).

Before resetting the AioContext, virtio_scsi_hotunplug() calls
qdev_simple_device_unplug_cb(), which unrealizes the SCSI device. This
calls scsi_qdev_unrealize() -> scsi_device_purge_requests(), which in
turn drains blk and cancels all pending requests. So there should be
nothing left that could call into virtio_scsi_ctx_check() any more.

The other argument is that after unrealize, virtio_scsi_device_get()
would return NULL anyway, so even if a request were still pending, it
would just fail instead of accessing the unplugged device.

> >>> #7  0x0000558712f697e4 in virtio_scsi_handle_cmd_req_prepare (s=0x558716c049c0, req=0x7ff7e400b650) at ../hw/scsi/virtio-scsi.c:788
> >>> #8  0x0000558712f699b0 in virtio_scsi_handle_cmd_vq (s=0x558716c049c0, vq=0x558716c0d2a8) at ../hw/scsi/virtio-scsi.c:831
> >>> #9  0x0000558712f69bcb in virtio_scsi_handle_cmd (vdev=0x558716c049c0, vq=0x558716c0d2a8) at ../hw/scsi/virtio-scsi.c:867
> >>> #10 0x0000558712f96812 in virtio_queue_notify_vq (vq=0x558716c0d2a8) at ../hw/virtio/virtio.c:2263
> >>> #11 0x0000558712f99b75 in virtio_queue_host_notifier_read (n=0x558716c0d31c) at ../hw/virtio/virtio.c:3575
> >>> #12 0x000055871323d8b5 in aio_dispatch_handler (ctx=0x55871598d5e0, node=0x558716771000) at ../util/aio-posix.c:372
> >>> #13 0x000055871323d988 in aio_dispatch_ready_handlers (ctx=0x55871598d5e0, ready_list=0x7ff7f288eeb0) at ../util/aio-posix.c:401
> >>
> >>
> >>>> As for why it doesn't progress, blk_co_is_available_entry() uses
> >>>> bdrv_graph_co_rdlock() and can't get it, because the main thread has the
> >>>> write lock. Should be fixed once the AioContext locks are gone, but not
> >>>> sure what should be done to avoid it until then.
> >>>
> >>> Then the nested event loop in blk_is_available() would probably be
> >>> enough to make progress, yes.
> >>>
> >>> Maybe we could actually drop the lock (and immediately reacquire it) in
> >>> AIO_WAIT_WHILE() even if we're in the home thread? That should give the
> >>> main thread a chance to make progress.
> >>
> >> Seems to work :) I haven't run into the issue with the following change
> >> anymore, but I have to say, running into that specific deadlock only
> >> happened every 10-15 tries or so before. Did 30 tests now. But
> >> unfortunately, the stuck IO issue is still there.
> >>
> >>> diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
> >>> index 5449b6d742..da159501ca 100644
> >>> --- a/include/block/aio-wait.h
> >>> +++ b/include/block/aio-wait.h
> >>> @@ -88,7 +88,13 @@ extern AioWait global_aio_wait;
> >>>      smp_mb__after_rmw();                                           \
> >>>      if (ctx_ && in_aio_context_home_thread(ctx_)) {                \
> >>>          while ((cond)) {                                           \
> >>> +            if (unlock && ctx_) {                                  \
> >>> +                aio_context_release(ctx_);                         \
> >>> +            }                                                      \
> >>>              aio_poll(ctx_, true);                                  \
> >>> +            if (unlock && ctx_) {                                  \
> >>> +                aio_context_acquire(ctx_);                         \
> >>> +            }                                                      \
> >>>              waited_ = true;                                        \
> >>>          }                                                          \
> >>>      } else {                                                       \
> > 
> > For reacquiring the lock, I really meant "immediately". Calling
> > aio_poll() without the lock is wrong.
> 
> Unfortunately, then it's not enough, because the call to aio_poll() is
> blocking and because the lock is held during that call, the very same
> deadlock can still happen.

Oh, right. What we would need is an aio_poll() that drops the lock
while it blocks, pretty much like the main loop does with the BQL. I
seem to remember that this was an intentional difference, but I don't
remember why.

Paolo, I'm sure you remember?

> > 
> > What does the stuck I/O look like? Is it stuck in the backend, i.e. the
> > device started requests that never complete? Or stuck from the guest
> > perspective, i.e. the device never checks for new requests?
> > 
> 
> AFAICT, from the guest perspective.
> 
> > I don't really have an idea immediately, we'd have to find out where the
> > stuck I/O stops being processed.
> > 
> 
> I've described it in an earlier mail in this thread:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg01900.html
> 
> Quoting from there:
> 
> > After the IO was stuck in the guest, I used bdrv_next_all_states() to
> > iterate over the states and there's only the bdrv_raw and the
> > bdrv_host_device. For both, tracked_requests was empty.

And bs->in_flight and blk->in_flight are 0, too?

Is anything quiesced?

> > What is also very interesting is that the IO isn't always dead
> > immediately. It can be that the fio command still runs with lower speed
> > for a while (sometimes even up to about a minute, but most often about
> > 10-15 seconds or so). During that time, I still can see calls to
> > virtio_scsi_handle_cmd() and blk_aio_write_entry(). Then they suddenly stop.
> 
> Noting again that (at least for backup) it happens with both virtio-blk
> and virtio-scsi and with both aio=io_uring and aio=threads. I also tried
> different host kernels 5.15, 6.2 and 6.5 and guest kernels 5.10 and 6.1.

You say "at least for backup". Did you see the bug for other job types,
too?

Kevin


