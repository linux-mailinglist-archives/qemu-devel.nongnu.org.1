Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27EA7B5E08
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 02:17:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnT6M-0003kx-Na; Mon, 02 Oct 2023 20:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnT6L-0003ko-0h
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:17:25 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnT6I-00018n-0k
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 20:17:24 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57be3d8e738so189091eaf.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696292241; x=1696897041; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ld3C26nZS4YnzOS8A8lu+mEVBh00G8T1JVQGtEQ4dI=;
 b=FKhrRgyeza8om3T+Z02dcY+ojLkxPUkiJFBS/uXhqFeHHDeyRxXZql/IYSIr7aD5aO
 8E4v3vL4Xyl2QFqXdFmy8HUKGt/xxNnUPvJrEPYdYtZquGt3/JPxpSzlFPaBdrJxF1Fy
 rpgx/2JWgyBgL8QgjcM5uAhavUApq+PL9hOBtO8hK/3TXl93R4K7KJvpPvashV9kJpzx
 Qs7XwBkO0Tq3sYnRMhljlCtWGGmz+7A/bmI7czO/U8tMVgxTwuXZZ1uW/o+prtSzfoYK
 ApErJnPo9ebemKhnUXiY6fk6Z3QwMbahqr8j5lF08v6wuUZ+Ckdipj1L91T5UkkXlYZE
 7zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696292241; x=1696897041;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ld3C26nZS4YnzOS8A8lu+mEVBh00G8T1JVQGtEQ4dI=;
 b=KidSmhMy32TpoX/nWaPqBIYV844L55vo+EBWlY6NTlhwiBN0DFfxGwqe7C9kaR0uPW
 FL7Nn1KunxgW5ofCu0xKwCgnsoW0EI7OwZqTqJbEwT7JrSFgv63LoGJEYMzK/H3AfPbe
 fkuhM5q3OWHdB53bkEnkC9p9mKLeWaIKWECjH6j71JeLRHDvziye5d0AcE7rqszd8SNg
 tR2xgFCDv5zs+jps5HQvfcWh1gqA4bD1+7sVa/8yqcmSbflTS3NmNUAtSVUrf81iq4jM
 j6ue2kqD+RmJaCKkfU8FvanmEQgxkGktrNr6rkjAz1UzIJgAN0gtFpsUD23zeTHAnBPk
 eNew==
X-Gm-Message-State: AOJu0YwKr4GbnQFdLx1KbarfFqL2z/0pulvZK1j7Y9J0mZToA8saV7ev
 zwYcxSGc7wkFmp/4zAtRMqV9ZRPjxBDb6sI65zM=
X-Google-Smtp-Source: AGHT+IEOXF1qDos5/DejQnxeAJF73tnjCOqDu7HAZV3E6WWk4J1+73Zvrgd1gYBIHxdpUX3r78Gn3a8WHfOw308bgzI=
X-Received: by 2002:a4a:305b:0:b0:57b:dcc4:8f1 with SMTP id
 z27-20020a4a305b000000b0057bdcc408f1mr12161182ooz.8.1696292240528; Mon, 02
 Oct 2023 17:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
 <20231002183410-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231002183410-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Oct 2023 20:17:07 -0400
Message-ID: <CAJSP0QVFkJ6LVPCXMY5uj5XLn4G00gVHd0n21pBT_tRUPj75Ww@mail.gmail.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 2 Oct 2023 at 18:36, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Oct 02, 2023 at 05:12:27PM -0400, Stefan Hajnoczi wrote:
> > On Mon, 2 Oct 2023 at 02:49, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Wed, Aug 30, 2023 at 11:37:50AM -0400, Stefan Hajnoczi wrote:
> > > > On Wed, 30 Aug 2023 at 09:30, Laszlo Ersek <lersek@redhat.com> wrot=
e:
> > > > >
> > > > > On 8/30/23 14:10, Stefan Hajnoczi wrote:
> > > > > > On Sun, 27 Aug 2023 at 14:31, Laszlo Ersek <lersek@redhat.com> =
wrote:
> > > > > >>
> > > > > >> (1) The virtio-1.0 specification
> > > > > >> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.htm=
l> writes:
> > > > > >>
> > > > > >>> 3     General Initialization And Device Operation
> > > > > >>> 3.1   Device Initialization
> > > > > >>> 3.1.1 Driver Requirements: Device Initialization
> > > > > >>>
> > > > > >>> [...]
> > > > > >>>
> > > > > >>> 7. Perform device-specific setup, including discovery of virt=
queues for
> > > > > >>>    the device, optional per-bus setup, reading and possibly w=
riting the
> > > > > >>>    device=E2=80=99s virtio configuration space, and populatio=
n of virtqueues.
> > > > > >>>
> > > > > >>> 8. Set the DRIVER_OK status bit. At this point the device is =
=E2=80=9Clive=E2=80=9D.
> > > > > >>
> > > > > >> and
> > > > > >>
> > > > > >>> 4         Virtio Transport Options
> > > > > >>> 4.1       Virtio Over PCI Bus
> > > > > >>> 4.1.4     Virtio Structure PCI Capabilities
> > > > > >>> 4.1.4.3   Common configuration structure layout
> > > > > >>> 4.1.4.3.2 Driver Requirements: Common configuration structure=
 layout
> > > > > >>>
> > > > > >>> [...]
> > > > > >>>
> > > > > >>> The driver MUST configure the other virtqueue fields before e=
nabling the
> > > > > >>> virtqueue with queue_enable.
> > > > > >>>
> > > > > >>> [...]
> > > > > >>
> > > > > >> These together mean that the following sub-sequence of steps i=
s valid for
> > > > > >> a virtio-1.0 guest driver:
> > > > > >>
> > > > > >> (1.1) set "queue_enable" for the needed queues as the final pa=
rt of device
> > > > > >> initialization step (7),
> > > > > >>
> > > > > >> (1.2) set DRIVER_OK in step (8),
> > > > > >>
> > > > > >> (1.3) immediately start sending virtio requests to the device.
> > > > > >>
> > > > > >> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_=
FEATURES
> > > > > >> special virtio feature is negotiated, then virtio rings start =
in disabled
> > > > > >> state, according to
> > > > > >> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#r=
ing-states>.
> > > > > >> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages ar=
e needed for
> > > > > >> enabling vrings.
> > > > > >>
> > > > > >> Therefore setting "queue_enable" from the guest (1.1) is a *co=
ntrol plane*
> > > > > >> operation, which travels from the guest through QEMU to the vh=
ost-user
> > > > > >> backend, using a unix domain socket.
> > > > > >>
> > > > > >> Whereas sending a virtio request (1.3) is a *data plane* opera=
tion, which
> > > > > >> evades QEMU -- it travels from guest to the vhost-user backend=
 via
> > > > > >> eventfd.
> > > > > >>
> > > > > >> This means that steps (1.1) and (1.3) travel through different=
 channels,
> > > > > >> and their relative order can be reversed, as perceived by the =
vhost-user
> > > > > >> backend.
> > > > > >>
> > > > > >> That's exactly what happens when OVMF's virtiofs driver (Virti=
oFsDxe) runs
> > > > > >> against the Rust-language virtiofsd version 1.7.2. (Which uses=
 version
> > > > > >> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of t=
he vhost
> > > > > >> crate.)
> > > > > >>
> > > > > >> Namely, when VirtioFsDxe binds a virtiofs device, it goes thro=
ugh the
> > > > > >> device initialization steps (i.e., control plane operations), =
and
> > > > > >> immediately sends a FUSE_INIT request too (i.e., performs a da=
ta plane
> > > > > >> operation). In the Rust-language virtiofsd, this creates a rac=
e between
> > > > > >> two components that run *concurrently*, i.e., in different thr=
eads or
> > > > > >> processes:
> > > > > >>
> > > > > >> - Control plane, handling vhost-user protocol messages:
> > > > > >>
> > > > > >>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
> > > > > >>   [crates/vhost-user-backend/src/handler.rs] handles
> > > > > >>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring=
's "enabled"
> > > > > >>   flag according to the message processed.
> > > > > >>
> > > > > >> - Data plane, handling virtio / FUSE requests:
> > > > > >>
> > > > > >>   The "VringEpollHandler::handle_event" method
> > > > > >>   [crates/vhost-user-backend/src/event_loop.rs] handles the in=
coming
> > > > > >>   virtio / FUSE request, consuming the virtio kick at the same=
 time. If
> > > > > >>   the vring's "enabled" flag is set, the virtio / FUSE request=
 is
> > > > > >>   processed genuinely. If the vring's "enabled" flag is clear,=
 then the
> > > > > >>   virtio / FUSE request is discarded.
> > > > > >
> > > > > > Why is virtiofsd monitoring the virtqueue and discarding reques=
ts
> > > > > > while it's disabled?
> > > > >
> > > > > That's what the vhost-user spec requires:
> > > > >
> > > > > https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-=
states
> > > > >
> > > > > """
> > > > > started but disabled: the back-end must process the ring without =
causing
> > > > > any side effects. For example, for a networking device, in the di=
sabled
> > > > > state the back-end must not supply any new RX packets, but must p=
rocess
> > > > > and discard any TX packets.
> > > > > """
> > > > >
> > > > > This state is different from "stopped", where "the back-end must =
not
> > > > > process the ring at all".
> > > > >
> > > > > The spec also says,
> > > > >
> > > > > """
> > > > > If VHOST_USER_F_PROTOCOL_FEATURES has been negotiated, the ring i=
s
> > > > > initialized in a disabled state and is enabled by
> > > > > VHOST_USER_SET_VRING_ENABLE with parameter 1.
> > > > > """
> > > > >
> > > > > AFAICT virtiofsd follows this requirement.
> > > >
> > > > Hi Michael,
> > > > You documented the disabled ring state in QEMU commit commit
> > > > c61f09ed855b5009f816242ce281fd01586d4646 ("vhost-user: clarify star=
t
> > > > and enable") where virtio-net devices discard tx buffers. The disab=
led
> > > > state seems to be specific to vhost-user and not covered in the VIR=
TIO
> > > > specification.
> > > >
> > > > Do you remember what the purpose of the disabled state was? Why is =
it
> > > > necessary to discard tx buffers instead of postponing ring processi=
ng
> > > > until the virtqueue is enabled?
> > > >
> > > > My concern is that the semantics are unclear for virtqueue types th=
at
> > > > are different from virtio-net rx/tx. Even the virtio-net controlq
> > > > would be problematic - should buffers be silently discarded with
> > > > VIRTIO_NET_OK or should they fail?
> > > >
> > > > Thanks,
> > > > Stefan
> > >
> > > I think I got it now.
> > > This weird state happens when linux first queues packets
> > > on multiple queues, then changes max queues to 1, queued packets need
> > > to still be freed eventually.
> >
> > Can you explain what is happening in the guest driver, QEMU, and the
> > vhost-user-net device in more detail? I don't understand the scenario.
>
> guest changes max vq pairs making it smaller
> qemu disables ring

The purpose of the "ignore rx, discard tx" semantics is still unclear
to me. Can you explain why we do this?

Stefan

> > > Yes, I am not sure this can apply to devices or queue types
> > > other than virtio net. Maybe.
> > >
> > > When we say:
> > >     must process the ring without causing any side effects.
> > > then I think it would be better to say
> > >     must process the ring if it can be done without causing
> > >     guest visible side effects.
> >
> > Completing a tx buffer is guest-visible, so I'm confused by this statem=
ent.
>
> yes but it's not immediately guest visible whether packet was
> transmitted or discarded.
>
> > > processing rx ring would have a side effect of causing
> > > guest to get malformed buffers, so we don't process it.
> >
> > Why are they malformed? Do you mean the rx buffers are stale (the
> > guest driver has changed the number of queues and doesn't expect to
> > receive them anymore)?
>
> there's no way to consume an rx buffer without supplying
> an rx packet to guest.

Stefan

> > > processing command queue - we can't fail for sure since
> > > that is guest visible. but practically we don't do this
> > > for cvq.
> > >
> > > what should happen for virtiofsd? I don't know -
> > > I am guessing discarding would have a side effect
> > > so should not happen.
> > >
> > >
> > >
> > >
> > > > >
> > > > > > This seems like a bug in the vhost-user backend to me.
> > > > >
> > > > > I didn't want to exclude that possiblity; that's why I included E=
ugenio,
> > > > > German, Liu Jiang, and Sergio in the CC list.
> > > > >
> > > > > >
> > > > > > When the virtqueue is disabled, don't monitor the kickfd.
> > > > > >
> > > > > > When the virtqueue transitions from disabled to enabled, the co=
ntrol
> > > > > > plane should self-trigger the kickfd so that any available buff=
ers
> > > > > > will be processed.
> > > > > >
> > > > > > QEMU uses this scheme to switch between vhost/IOThreads and bui=
lt-in
> > > > > > virtqueue kick processing.
> > > > > >
> > > > > > This approach is more robust than relying buffers being enqueue=
d after
> > > > > > the virtqueue is enabled.
> > > > >
> > > > > I'm happy to drop the series if the virtiofsd maintainers agree t=
hat the
> > > > > bug is in virtiofsd, and can propose a design to fix it. (I do th=
ink
> > > > > that such a fix would require an architectural change.)
> > > > >
> > > > > FWIW, my own interpretation of the vhost-user spec (see above) wa=
s that
> > > > > virtiofsd was right to behave the way it did, and that there was =
simply
> > > > > no way to prevent out-of-order delivery other than synchronizing =
the
> > > > > guest end-to-end with the vhost-user backend, concerning
> > > > > VHOST_USER_SET_VRING_ENABLE.
> > > > >
> > > > > This end-to-end synchronization is present "naturally" in vhost-n=
et,
> > > > > where ioctl()s are automatically synchronous -- in fact *all* ope=
rations
> > > > > on the control plane are synchronous. (Which is just a different =
way to
> > > > > say that the guest is tightly coupled with the control plane.)
> > > > >
> > > > > Note that there has been at least one race like this before; see =
commit
> > > > > 699f2e535d93 ("vhost: make SET_VRING_ADDR, SET_FEATURES send repl=
ies",
> > > > > 2021-09-04). Basically every pre-existent call to enforce_reply()=
 is a
> > > > > cover-up for the vhost-user spec turning (somewhat recklessly?) m=
ost
> > > > > operations into async ones.
> > > > >
> > > > > At some point this became apparent and so the REPLY_ACK flag was
> > > > > introduced; see commit ca525ce5618b ("vhost-user: Introduce a new
> > > > > protocol feature REPLY_ACK.", 2016-08-10). (That commit doesn't g=
o into
> > > > > details, but I'm pretty sure there was a similar race around SET_=
MEM_TABLE!)
> > > > >
> > > > > BTW even if we drop this series for QEMU, I don't think it will h=
ave
> > > > > been in vain. The first few patches are cleanups which could be m=
erged
> > > > > for their own sake. And the last patch is essentially the proof o=
f the
> > > > > problem statement / analysis. It can be considered an elaborate b=
ug
> > > > > report for virtiofsd, *if* we decide the bug is in virtiofsd. I d=
id have
> > > > > that avenue in mind as well, when writing the commit message / pa=
tch.
> > > > >
> > > > > For now I'm going to post v2 -- that's not to say that I'm dismis=
sing
> > > > > your feedback (see above!), just want to get the latest version o=
n-list.
> > > > >
> > > > > Thanks!
> > > > > Laszlo
> > > > >
> > > > > >
> > > > > > Stefan
> > > > > >
> > > > > >>
> > > > > >> Note that OVMF enables the queue *first*, and sends FUSE_INIT =
*second*.
> > > > > >> However, if the data plane processor in virtiofsd wins the rac=
e, then it
> > > > > >> sees the FUSE_INIT *before* the control plane processor took n=
otice of
> > > > > >> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the da=
ta plane
> > > > > >> processor. Therefore the latter drops FUSE_INIT on the floor, =
and goes
> > > > > >> back to waiting for further virtio / FUSE requests with epoll_=
wait.
> > > > > >> Meanwhile OVMF is stuck waiting for the FUSET_INIT response --=
 a deadlock.
> > > > > >>
> > > > > >> The deadlock is not deterministic. OVMF hangs infrequently dur=
ing first
> > > > > >> boot. However, OVMF hangs almost certainly during reboots from=
 the UEFI
> > > > > >> shell.
> > > > > >>
> > > > > >> The race can be "reliably masked" by inserting a very small de=
lay -- a
> > > > > >> single debug message -- at the top of "VringEpollHandler::hand=
le_event",
> > > > > >> i.e., just before the data plane processor checks the "enabled=
" field of
> > > > > >> the vring. That delay suffices for the control plane processor=
 to act upon
> > > > > >> VHOST_USER_SET_VRING_ENABLE.
> > > > > >>
> > > > > >> We can deterministically prevent the race in QEMU, by blocking=
 OVMF inside
> > > > > >> step (1.1) -- i.e., in the write to the "queue_enable" registe=
r -- until
> > > > > >> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVM=
F's VCPU
> > > > > >> cannot advance to the FUSE_INIT submission before virtiofsd's =
control
> > > > > >> plane processor takes notice of the queue being enabled.
> > > > > >>
> > > > > >> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
> > > > > >>
> > > > > >> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, =
and waiting
> > > > > >>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-=
user feature
> > > > > >>   has been negotiated, or
> > > > > >>
> > > > > >> - performing a separate VHOST_USER_GET_FEATURES *exchange*, wh=
ich requires
> > > > > >>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY=
_ACK.
> > > > > >>
> > > > > >> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> > > > > >> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> > > > > >> Cc: German Maglione <gmaglione@redhat.com>
> > > > > >> Cc: Liu Jiang <gerry@linux.alibaba.com>
> > > > > >> Cc: Sergio Lopez Pascual <slp@redhat.com>
> > > > > >> Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > > > >> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > > > > >> ---
> > > > > >>  hw/virtio/vhost-user.c | 2 +-
> > > > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >>
> > > > > >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > > > >> index beb4b832245e..01e0ca90c538 100644
> > > > > >> --- a/hw/virtio/vhost-user.c
> > > > > >> +++ b/hw/virtio/vhost-user.c
> > > > > >> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(s=
truct vhost_dev *dev, int enable)
> > > > > >>              .num   =3D enable,
> > > > > >>          };
> > > > > >>
> > > > > >> -        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENA=
BLE, &state, false);
> > > > > >> +        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENA=
BLE, &state, true);
> > > > > >>          if (ret < 0) {
> > > > > >>              /*
> > > > > >>               * Restoring the previous state is likely infeasi=
ble, as well as
> > > > > >
> > > > >
> > >
>

