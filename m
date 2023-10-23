Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9DC7D2DD2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 11:15:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qur0H-00068p-LN; Mon, 23 Oct 2023 05:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qur0E-00067S-7h
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qur0C-0000hb-9a
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 05:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698052414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nn+fYJsDpVjw5mzNwZ3I3Eb7QWFFj3dSdiReSu1ZVQo=;
 b=NmwdjmHPBKFMI8YrYay8b1B9RIPE0EbdvitWC0lFD57aSj99BHMGCwRv43qklNokL5wgAq
 ++i+uJi1hjfMLTp12sCOCZdgcXuu9PpspY9eQ2eZxVm5Lu8yqnCIZReq/30TA0A3eT1tmZ
 hsJ9BsLPL2Tc4BKtr6y+dIFAOIldzcA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-N0u6m8-hMVGRI8bRC_JXfg-1; Mon, 23 Oct 2023 05:13:20 -0400
X-MC-Unique: N0u6m8-hMVGRI8bRC_JXfg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F261B185A78E;
 Mon, 23 Oct 2023 09:13:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C97E32166B26;
 Mon, 23 Oct 2023 09:13:18 +0000 (UTC)
Date: Mon, 23 Oct 2023 11:13:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: lv.mengzhao@zte.com.cn
Cc: stefanha@redhat.com, mst@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org, hu.jian@zte.com.cn, cv11411@126.com
Subject: Re: Re: [PATCH] virtio-blk: don't start dataplane during the stop of
 dataplane
Message-ID: <ZTY5LdHS0heABvRY@redhat.com>
References: <202310191528414853267@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310191528414853267@zte.com.cn>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Am 19.10.2023 um 09:28 hat lv.mengzhao@zte.com.cn geschrieben:
> On Tue, Oct 17, 2023 at 10:04PM +0800, stefanha@redhat.com wrote:
> > > From: hujian <hu.jian@zte.com.cn> 
> > >  
> > > During the stop of dataplane for virtio-blk, virtio_bus_cleanup_host_notifier() is be
> > > called to clean up notifier at the end, if polled ioeventfd, virtio_blk_handle_output()
> > > is used to handle io request. But due to s->dataplane_disabled is false, it will be
> > > returned directly, which drops io request.
> > > Backtrace:
> > > ->virtio_blk_data_plane_stop
> > >   ->virtio_bus_cleanup_host_notifier
> > >     ->virtio_queue_host_notifier_read
> > >       ->virtio_queue_notify_vq
> > >         ->vq->handle_output
> > >           ->virtio_blk_handle_output
> > >             ->if (s->dataplane  && !s->dataplane_stoped)
> > >               ->if (!s->dataplane_disabled)
> > >                 ->return *
> > >             ->virtio_blk_handle_output_do
> > > The above problem can occur when using "virsh reset" cmdline to reset guest, while
> > > guest does io.
> > > To fix this problem, don't try to start dataplane if s->stopping is true, and io would
> > > be handled by virtio_blk_handle_vq().
> > >  
> > > Signed-off-by: hujian <hu.jian@zte.com.cn> 
> > > ---
> > >  hw/block/virtio-blk.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > I have dropped this patch again after Fiona pointed out it does not
> > compile and Kevin noticed that handling requests from the main loop
> > thread while the I/O is still being processed in the IOThread is going
> > to cause thread-safety issues.
> > 
> > Can you explain the problem you are seeing in more detail? You run
> > "virsh reset" while the guest is doing I/O. Then what happens?
> > 
> > Stefan
> 
> 1 Compilation issues
> I'm sorry to be in such a hurry to submit the patch that I forgot to
> compile it locally.  Compilable patches are at the bottom.

The more worrying part is that without building it, you also can't have
tested it. How much testing did the new, compilable patch undergo?

> 2 Troubleshooting
> We have done a lifecycle test for the VM (QEMU version: 4.1.0, Host
> kernel version: 4.18), which is loop execution: virsh create -> virsh
> suspend -> virsh resume -> virsh reset -> virsh shutdown, and io
> stress test inside the virtual machine. After the loop is executed
> about 200 times, after "virsh reset" is executed, the virtual machine
> goes into emergency mode and fails to start normally. Theoretically,
> "virsh reset" may causes data loss of virtual machine, but not enough
> to put it into emergency mode.

QEMU 4.1.0 is quite old. Do you happen to know if the problem is still
reproducible on current git master (or 8.1.0)?

Though from your description of the bug and what the code looks like
today, I would expect so.

> Coincidentally, I happen to be fixing another different fault with the
> same phenomenon, which is caused by a our private patch, this patch
> calls virtio_blk_data_plane_ [stop|start] to operate the dataplane, if
> QEMU is processing io requests at same time, it may cause the loss of
> io requests.
> 
> Analyzing virtio_blk_data_plane_stop(),
> virtio_bus_cleanup_host_notifier() is used to clean up notifiers, and
> my understanding is that it would handle the remaining IO requests.

Well, as you found out, it doesn't actually do that in practice. I'm
not sure what the idea behind it was. Handling the remaining requests in
our case would be a problem because we're not in the right state to
handle requests.

> The stack is as follows, I add the print at the star line and find
> that virtio_blk_handle_output() returned directly instead of
> continuing to call virtio_blk_handle_vq() to handle io. So I modify
> the code here to make it don't return during the stop of dataplane,
> and our internal private patch works normally.
> 
> Backtrace:
> ->virtio_blk_data_plane_stop
>   ->virtio_bus_cleanup_host_notifier
>     ->virtio_queue_host_notifier_read
>       ->virtio_queue_notify_vq
>         ->vq->handle_output
>           ->virtio_blk_handle_output
>             ->if (s->dataplane  && !s->dataplane_stoped)
>               ->if (!s->dataplane_disabled)
>                 ->return *
>             ->virtio_blk_handle_vq
> 
> Back to the problem caused by the virsh reset, libvirt sends the
> "system_reset" QEMU monitor command to QEMU, and QEMU calls
> qmp_system_reset(), and eventually calls
> virtio_blk_data_plane_[stop|start] to reset devices. I suspect that io
> loss will also occur if QEMU still has io to process during the stop
> of dataplane. 

Hm... But why can the guest expect that requests are processed during a
hard reset? Intuitively dropping remaining requests after a certain
point where you do a reset doesn't sound like a problem.

> 3 Thread-safety issues
> virtio_blk_data_plane_stop() calls blk_set_aio_context() to switch bs
> back to the QEMU main loop after virtio_bus_cleanup_host_notifier(),
> so the remaining IO requests are still handling by iothread(if
> configured). I'm a little confused as to why there is thread-safety
> issues.

blk_set_aio_context() only tells the BlockBackend which iothread to
expect requests from. The device needs to take care to actually send
requests from the same thread that it promised to the BlockBackend. In
your stack trace, we still promise that requests come from the iothread,
but we're actually trying to process them in the main thread:
virtio_blk_data_plane_stop() runs in the main thread and indirectly
calls virtio_blk_handle_output(), so with your fix, they would be
handled in the main thread before blk_set_aio_context() was called. This
isn't right.

We would have to delay processing requests until after we have
completely switched back to the non-dataplane mode. And after thinking a
bit about this, this seems to be exactly what the current code is doing:
In fact, returning from virtio_blk_handle_output() doesn't drop the
request. It just means that we're not processing it right now, it still
remains queued (there is no virtqueue_pop() involved when we return
early).

So I think returning there early is the right thing to do.

I'm not entirely sure where your problem happens. What would make most
sense is that virtio_blk_reset() throws away the requests. But throwing
away unprocessed requests is exactly what I would expect from a reset,
so I don't really see a problem in that.

We probably need to dig a bit deeper to figure out why your guest has a
problem with this. Can you give some details about the guest? Like which
OS, filesystem, other storage related configuration etc.? At this point
it sounds a bit like a guest side bug.

> Lastly, please CC to cv11411@126.com, this is my private email, so I
> can contact with you in my free time, Thanks.

Ok. What I usually do in such cases is that I already CC myself with the
alternative address to make sure that nobody forgets to add it while
replying.

Kevin


