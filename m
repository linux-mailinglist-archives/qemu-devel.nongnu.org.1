Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E297B5D35
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 00:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnRWg-0003lr-AV; Mon, 02 Oct 2023 18:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnRWb-0003hl-3y
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnRWY-0008NL-JD
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696286181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WorMZ6uZZB08KuCb2QzIZ22qLLwKc7cthThFmo+BbnY=;
 b=flWqJWQe6LTm925lu4qHPp1T+EGV9f0wqP2x+LLMGPtHa+CDk17Vm1vcBwIz6C14uasM1R
 8KaY1UKcNygcFhVju03Q31OfJQK6HpkAE0CyaL/6HUoHhhAmMHF9GYgDijpENe8NILzRVt
 oNKIJeaa9Y+cpBu7BXyx71Ajap8c0cY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-Rxt97jCoOGi36er9e7frJA-1; Mon, 02 Oct 2023 18:36:19 -0400
X-MC-Unique: Rxt97jCoOGi36er9e7frJA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32337a3929aso206490f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 15:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696286178; x=1696890978;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WorMZ6uZZB08KuCb2QzIZ22qLLwKc7cthThFmo+BbnY=;
 b=w+tfeWOcDYIaNy3WrXN+EqINSy+dFi4DZ7anO7ECaa2sw/qVmj3iBCAXHakmXQke8b
 8rUbWtGgPHOYfkSzlmird46OzxVyfucChuxVzyktRkiN85VYgrbqEfdoIvjSfwnh9K2q
 ETdCQpRvqptAFUxplnsq5hUl2H/IRZZg9bd4woaU22ZIQnSflIbhAJ/IwC/ZV4/jDqdr
 vEVNgzVz8+N94YBpa6UGrnVg9Sb2XfY4F4j88YMcIenDk19h58iewaYAMzGFC3LnceaD
 UMQbIG11W8CbzpI2dj/csk6jfuznH5ioE5OiIeplazXYVAxHmoBFdlWIg8EXm2UBiqZO
 1OSA==
X-Gm-Message-State: AOJu0Yxrpwm4NayJXQ/ovlWIZBOmGN5tgCMOsvr3jgFBLIS8u8Vh8ZOs
 L/DSNYvsDnod/eKOTr+Ai+YuV7K33ZMbw/8E1CmSAgC8+kX66YCPeee5kwVT9a9kddtjn0JxAHo
 wJKyujLsRMMf51nM=
X-Received: by 2002:a5d:628a:0:b0:323:1d8a:3d87 with SMTP id
 k10-20020a5d628a000000b003231d8a3d87mr12625524wru.4.1696286178323; 
 Mon, 02 Oct 2023 15:36:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYep+fV0Qm2+tmqQiUA2MdERV9M7NF9br3RIXhEa8e3M7kI1ucsbP7tNfOv1UZ91q7Y2xMYw==
X-Received: by 2002:a5d:628a:0:b0:323:1d8a:3d87 with SMTP id
 k10-20020a5d628a000000b003231d8a3d87mr12625506wru.4.1696286177855; 
 Mon, 02 Oct 2023 15:36:17 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 n7-20020adff087000000b0031c6e1ea4c7sm11778496wro.90.2023.10.02.15.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 15:36:17 -0700 (PDT)
Date: Mon, 2 Oct 2023 18:36:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231002183410-mutt-send-email-mst@kernel.org>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Mon, Oct 02, 2023 at 05:12:27PM -0400, Stefan Hajnoczi wrote:
> On Mon, 2 Oct 2023 at 02:49, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 11:37:50AM -0400, Stefan Hajnoczi wrote:
> > > On Wed, 30 Aug 2023 at 09:30, Laszlo Ersek <lersek@redhat.com> wrote:
> > > >
> > > > On 8/30/23 14:10, Stefan Hajnoczi wrote:
> > > > > On Sun, 27 Aug 2023 at 14:31, Laszlo Ersek <lersek@redhat.com> wrote:
> > > > >>
> > > > >> (1) The virtio-1.0 specification
> > > > >> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> writes:
> > > > >>
> > > > >>> 3     General Initialization And Device Operation
> > > > >>> 3.1   Device Initialization
> > > > >>> 3.1.1 Driver Requirements: Device Initialization
> > > > >>>
> > > > >>> [...]
> > > > >>>
> > > > >>> 7. Perform device-specific setup, including discovery of virtqueues for
> > > > >>>    the device, optional per-bus setup, reading and possibly writing the
> > > > >>>    device’s virtio configuration space, and population of virtqueues.
> > > > >>>
> > > > >>> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
> > > > >>
> > > > >> and
> > > > >>
> > > > >>> 4         Virtio Transport Options
> > > > >>> 4.1       Virtio Over PCI Bus
> > > > >>> 4.1.4     Virtio Structure PCI Capabilities
> > > > >>> 4.1.4.3   Common configuration structure layout
> > > > >>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
> > > > >>>
> > > > >>> [...]
> > > > >>>
> > > > >>> The driver MUST configure the other virtqueue fields before enabling the
> > > > >>> virtqueue with queue_enable.
> > > > >>>
> > > > >>> [...]
> > > > >>
> > > > >> These together mean that the following sub-sequence of steps is valid for
> > > > >> a virtio-1.0 guest driver:
> > > > >>
> > > > >> (1.1) set "queue_enable" for the needed queues as the final part of device
> > > > >> initialization step (7),
> > > > >>
> > > > >> (1.2) set DRIVER_OK in step (8),
> > > > >>
> > > > >> (1.3) immediately start sending virtio requests to the device.
> > > > >>
> > > > >> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
> > > > >> special virtio feature is negotiated, then virtio rings start in disabled
> > > > >> state, according to
> > > > >> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
> > > > >> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
> > > > >> enabling vrings.
> > > > >>
> > > > >> Therefore setting "queue_enable" from the guest (1.1) is a *control plane*
> > > > >> operation, which travels from the guest through QEMU to the vhost-user
> > > > >> backend, using a unix domain socket.
> > > > >>
> > > > >> Whereas sending a virtio request (1.3) is a *data plane* operation, which
> > > > >> evades QEMU -- it travels from guest to the vhost-user backend via
> > > > >> eventfd.
> > > > >>
> > > > >> This means that steps (1.1) and (1.3) travel through different channels,
> > > > >> and their relative order can be reversed, as perceived by the vhost-user
> > > > >> backend.
> > > > >>
> > > > >> That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
> > > > >> against the Rust-language virtiofsd version 1.7.2. (Which uses version
> > > > >> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
> > > > >> crate.)
> > > > >>
> > > > >> Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
> > > > >> device initialization steps (i.e., control plane operations), and
> > > > >> immediately sends a FUSE_INIT request too (i.e., performs a data plane
> > > > >> operation). In the Rust-language virtiofsd, this creates a race between
> > > > >> two components that run *concurrently*, i.e., in different threads or
> > > > >> processes:
> > > > >>
> > > > >> - Control plane, handling vhost-user protocol messages:
> > > > >>
> > > > >>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
> > > > >>   [crates/vhost-user-backend/src/handler.rs] handles
> > > > >>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
> > > > >>   flag according to the message processed.
> > > > >>
> > > > >> - Data plane, handling virtio / FUSE requests:
> > > > >>
> > > > >>   The "VringEpollHandler::handle_event" method
> > > > >>   [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
> > > > >>   virtio / FUSE request, consuming the virtio kick at the same time. If
> > > > >>   the vring's "enabled" flag is set, the virtio / FUSE request is
> > > > >>   processed genuinely. If the vring's "enabled" flag is clear, then the
> > > > >>   virtio / FUSE request is discarded.
> > > > >
> > > > > Why is virtiofsd monitoring the virtqueue and discarding requests
> > > > > while it's disabled?
> > > >
> > > > That's what the vhost-user spec requires:
> > > >
> > > > https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states
> > > >
> > > > """
> > > > started but disabled: the back-end must process the ring without causing
> > > > any side effects. For example, for a networking device, in the disabled
> > > > state the back-end must not supply any new RX packets, but must process
> > > > and discard any TX packets.
> > > > """
> > > >
> > > > This state is different from "stopped", where "the back-end must not
> > > > process the ring at all".
> > > >
> > > > The spec also says,
> > > >
> > > > """
> > > > If VHOST_USER_F_PROTOCOL_FEATURES has been negotiated, the ring is
> > > > initialized in a disabled state and is enabled by
> > > > VHOST_USER_SET_VRING_ENABLE with parameter 1.
> > > > """
> > > >
> > > > AFAICT virtiofsd follows this requirement.
> > >
> > > Hi Michael,
> > > You documented the disabled ring state in QEMU commit commit
> > > c61f09ed855b5009f816242ce281fd01586d4646 ("vhost-user: clarify start
> > > and enable") where virtio-net devices discard tx buffers. The disabled
> > > state seems to be specific to vhost-user and not covered in the VIRTIO
> > > specification.
> > >
> > > Do you remember what the purpose of the disabled state was? Why is it
> > > necessary to discard tx buffers instead of postponing ring processing
> > > until the virtqueue is enabled?
> > >
> > > My concern is that the semantics are unclear for virtqueue types that
> > > are different from virtio-net rx/tx. Even the virtio-net controlq
> > > would be problematic - should buffers be silently discarded with
> > > VIRTIO_NET_OK or should they fail?
> > >
> > > Thanks,
> > > Stefan
> >
> > I think I got it now.
> > This weird state happens when linux first queues packets
> > on multiple queues, then changes max queues to 1, queued packets need
> > to still be freed eventually.
> 
> Can you explain what is happening in the guest driver, QEMU, and the
> vhost-user-net device in more detail? I don't understand the scenario.

guest changes max vq pairs making it smaller
qemu disables ring

> > Yes, I am not sure this can apply to devices or queue types
> > other than virtio net. Maybe.
> >
> > When we say:
> >     must process the ring without causing any side effects.
> > then I think it would be better to say
> >     must process the ring if it can be done without causing
> >     guest visible side effects.
> 
> Completing a tx buffer is guest-visible, so I'm confused by this statement.

yes but it's not immediately guest visible whether packet was
transmitted or discarded.

> > processing rx ring would have a side effect of causing
> > guest to get malformed buffers, so we don't process it.
> 
> Why are they malformed? Do you mean the rx buffers are stale (the
> guest driver has changed the number of queues and doesn't expect to
> receive them anymore)?

there's no way to consume an rx buffer without supplying
an rx packet to guest.

> > processing command queue - we can't fail for sure since
> > that is guest visible. but practically we don't do this
> > for cvq.
> >
> > what should happen for virtiofsd? I don't know -
> > I am guessing discarding would have a side effect
> > so should not happen.
> >
> >
> >
> >
> > > >
> > > > > This seems like a bug in the vhost-user backend to me.
> > > >
> > > > I didn't want to exclude that possiblity; that's why I included Eugenio,
> > > > German, Liu Jiang, and Sergio in the CC list.
> > > >
> > > > >
> > > > > When the virtqueue is disabled, don't monitor the kickfd.
> > > > >
> > > > > When the virtqueue transitions from disabled to enabled, the control
> > > > > plane should self-trigger the kickfd so that any available buffers
> > > > > will be processed.
> > > > >
> > > > > QEMU uses this scheme to switch between vhost/IOThreads and built-in
> > > > > virtqueue kick processing.
> > > > >
> > > > > This approach is more robust than relying buffers being enqueued after
> > > > > the virtqueue is enabled.
> > > >
> > > > I'm happy to drop the series if the virtiofsd maintainers agree that the
> > > > bug is in virtiofsd, and can propose a design to fix it. (I do think
> > > > that such a fix would require an architectural change.)
> > > >
> > > > FWIW, my own interpretation of the vhost-user spec (see above) was that
> > > > virtiofsd was right to behave the way it did, and that there was simply
> > > > no way to prevent out-of-order delivery other than synchronizing the
> > > > guest end-to-end with the vhost-user backend, concerning
> > > > VHOST_USER_SET_VRING_ENABLE.
> > > >
> > > > This end-to-end synchronization is present "naturally" in vhost-net,
> > > > where ioctl()s are automatically synchronous -- in fact *all* operations
> > > > on the control plane are synchronous. (Which is just a different way to
> > > > say that the guest is tightly coupled with the control plane.)
> > > >
> > > > Note that there has been at least one race like this before; see commit
> > > > 699f2e535d93 ("vhost: make SET_VRING_ADDR, SET_FEATURES send replies",
> > > > 2021-09-04). Basically every pre-existent call to enforce_reply() is a
> > > > cover-up for the vhost-user spec turning (somewhat recklessly?) most
> > > > operations into async ones.
> > > >
> > > > At some point this became apparent and so the REPLY_ACK flag was
> > > > introduced; see commit ca525ce5618b ("vhost-user: Introduce a new
> > > > protocol feature REPLY_ACK.", 2016-08-10). (That commit doesn't go into
> > > > details, but I'm pretty sure there was a similar race around SET_MEM_TABLE!)
> > > >
> > > > BTW even if we drop this series for QEMU, I don't think it will have
> > > > been in vain. The first few patches are cleanups which could be merged
> > > > for their own sake. And the last patch is essentially the proof of the
> > > > problem statement / analysis. It can be considered an elaborate bug
> > > > report for virtiofsd, *if* we decide the bug is in virtiofsd. I did have
> > > > that avenue in mind as well, when writing the commit message / patch.
> > > >
> > > > For now I'm going to post v2 -- that's not to say that I'm dismissing
> > > > your feedback (see above!), just want to get the latest version on-list.
> > > >
> > > > Thanks!
> > > > Laszlo
> > > >
> > > > >
> > > > > Stefan
> > > > >
> > > > >>
> > > > >> Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
> > > > >> However, if the data plane processor in virtiofsd wins the race, then it
> > > > >> sees the FUSE_INIT *before* the control plane processor took notice of
> > > > >> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
> > > > >> processor. Therefore the latter drops FUSE_INIT on the floor, and goes
> > > > >> back to waiting for further virtio / FUSE requests with epoll_wait.
> > > > >> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.
> > > > >>
> > > > >> The deadlock is not deterministic. OVMF hangs infrequently during first
> > > > >> boot. However, OVMF hangs almost certainly during reboots from the UEFI
> > > > >> shell.
> > > > >>
> > > > >> The race can be "reliably masked" by inserting a very small delay -- a
> > > > >> single debug message -- at the top of "VringEpollHandler::handle_event",
> > > > >> i.e., just before the data plane processor checks the "enabled" field of
> > > > >> the vring. That delay suffices for the control plane processor to act upon
> > > > >> VHOST_USER_SET_VRING_ENABLE.
> > > > >>
> > > > >> We can deterministically prevent the race in QEMU, by blocking OVMF inside
> > > > >> step (1.1) -- i.e., in the write to the "queue_enable" register -- until
> > > > >> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
> > > > >> cannot advance to the FUSE_INIT submission before virtiofsd's control
> > > > >> plane processor takes notice of the queue being enabled.
> > > > >>
> > > > >> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
> > > > >>
> > > > >> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
> > > > >>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
> > > > >>   has been negotiated, or
> > > > >>
> > > > >> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
> > > > >>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
> > > > >>
> > > > >> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> > > > >> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> > > > >> Cc: German Maglione <gmaglione@redhat.com>
> > > > >> Cc: Liu Jiang <gerry@linux.alibaba.com>
> > > > >> Cc: Sergio Lopez Pascual <slp@redhat.com>
> > > > >> Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > >> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > > > >> ---
> > > > >>  hw/virtio/vhost-user.c | 2 +-
> > > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >>
> > > > >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > >> index beb4b832245e..01e0ca90c538 100644
> > > > >> --- a/hw/virtio/vhost-user.c
> > > > >> +++ b/hw/virtio/vhost-user.c
> > > > >> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
> > > > >>              .num   = enable,
> > > > >>          };
> > > > >>
> > > > >> -        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
> > > > >> +        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
> > > > >>          if (ret < 0) {
> > > > >>              /*
> > > > >>               * Restoring the previous state is likely infeasible, as well as
> > > > >
> > > >
> >


