Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 592147B5C66
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:15:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQEw-00070u-VG; Mon, 02 Oct 2023 17:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnQEu-00070T-DH
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:14:04 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnQEc-0000VU-FK
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:14:04 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6c4bad60a1aso108773a34.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 14:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696281219; x=1696886019; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7AfkFg3E5Nb++NgBpMvaLnU1ZrNC6e2RQPWuC2uH0mk=;
 b=OgJMPl1H7i/q2mz5cxBhQha91MM+lZ5RiXfn3P+acQ+zliAK6WX7zWRSnrsu+0fkmU
 AFJIq0Gwb2Hd3auqZ0vS7R5izFCerVeWKr+DXvbKz3ZBFSGRGtNSVfPnfzb4+SOYaitm
 r2TGIa+NJpFOTa96/bgppEUJjmqV8hP+2n1pqJh1tGOP4aNjyjZSbQZKe4XjEbvcE6BH
 ys6GEFMSEVjZ3EgLRS2niJ2cDIUAMHzEQlvI9htiNywt+OFw8j9UwJGVV/BNzM1mm+PB
 H5suYb84tEDmvdFJw2Itl7A/P7hA0xNCKk9vElHnMYoKb9Fd5i+07v2QuBxTaNZkqt4C
 /vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696281219; x=1696886019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7AfkFg3E5Nb++NgBpMvaLnU1ZrNC6e2RQPWuC2uH0mk=;
 b=lfB78wkxedFCVQvIPpD1+OERgRohMfvSbNsp7HSmQuNzl5+Za8b7tkeWZfHZalov8I
 kVGE3nvx1TLCFHagVIdEzF1zHU1ePCnvFTusDiptZyfIM4sFDFhNCtsYeK7+cZvv/BAh
 BV/hcLTj4hL4x1cPIdnruQAp+YGGBBQ+4I8sRqwMlmW+yR/Tz+k+ES8p/IrA7iJlh5yh
 PFj8xGEcSYUjIg3RMkJmKRNdESBvSfKRxeqE/aHO6FqSr/jbX/U4xwBJ3UcKMkl7L15g
 D8L81bUmaGXHm1zFycEd2jS6x4T3Mr4LTcd6tWd21ZU7deG1dIOEDU4MaY+gNGLLZaiK
 MFnA==
X-Gm-Message-State: AOJu0YwcQE1/IgYKsm6sd4o7JUXp2KzRXShxFHVXD8jEUFqQLo13CD0H
 A+phfCUqwkGvstZRrdKsF1SwPEgfBf3+MFDpujEiqcPd
X-Google-Smtp-Source: AGHT+IFJ3QNR8bD1fezsni7ec0khAZM+8gKi7fTEjdB7Ni68m7EOeeEwCE7sTiQhl67jWmDrb39HnWfHp35i4+mQRwU=
X-Received: by 2002:a05:6808:f89:b0:3af:795d:b74b with SMTP id
 o9-20020a0568080f8900b003af795db74bmr8188690oiw.50.1696281219045; Mon, 02 Oct
 2023 14:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
In-Reply-To: <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Oct 2023 17:13:26 -0400
Message-ID: <CAJSP0QU3jzFGnJ35Zbabf70Tbf+rPA_fvrA_eNxZ8TxOXQxZXA@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

One more question:

Why is the disabled state not needed by regular (non-vhost) virtio-net devi=
ces?

On Mon, 2 Oct 2023 at 17:12, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, 2 Oct 2023 at 02:49, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 11:37:50AM -0400, Stefan Hajnoczi wrote:
> > > On Wed, 30 Aug 2023 at 09:30, Laszlo Ersek <lersek@redhat.com> wrote:
> > > >
> > > > On 8/30/23 14:10, Stefan Hajnoczi wrote:
> > > > > On Sun, 27 Aug 2023 at 14:31, Laszlo Ersek <lersek@redhat.com> wr=
ote:
> > > > >>
> > > > >> (1) The virtio-1.0 specification
> > > > >> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html>=
 writes:
> > > > >>
> > > > >>> 3     General Initialization And Device Operation
> > > > >>> 3.1   Device Initialization
> > > > >>> 3.1.1 Driver Requirements: Device Initialization
> > > > >>>
> > > > >>> [...]
> > > > >>>
> > > > >>> 7. Perform device-specific setup, including discovery of virtqu=
eues for
> > > > >>>    the device, optional per-bus setup, reading and possibly wri=
ting the
> > > > >>>    device=E2=80=99s virtio configuration space, and population =
of virtqueues.
> > > > >>>
> > > > >>> 8. Set the DRIVER_OK status bit. At this point the device is =
=E2=80=9Clive=E2=80=9D.
> > > > >>
> > > > >> and
> > > > >>
> > > > >>> 4         Virtio Transport Options
> > > > >>> 4.1       Virtio Over PCI Bus
> > > > >>> 4.1.4     Virtio Structure PCI Capabilities
> > > > >>> 4.1.4.3   Common configuration structure layout
> > > > >>> 4.1.4.3.2 Driver Requirements: Common configuration structure l=
ayout
> > > > >>>
> > > > >>> [...]
> > > > >>>
> > > > >>> The driver MUST configure the other virtqueue fields before ena=
bling the
> > > > >>> virtqueue with queue_enable.
> > > > >>>
> > > > >>> [...]
> > > > >>
> > > > >> These together mean that the following sub-sequence of steps is =
valid for
> > > > >> a virtio-1.0 guest driver:
> > > > >>
> > > > >> (1.1) set "queue_enable" for the needed queues as the final part=
 of device
> > > > >> initialization step (7),
> > > > >>
> > > > >> (1.2) set DRIVER_OK in step (8),
> > > > >>
> > > > >> (1.3) immediately start sending virtio requests to the device.
> > > > >>
> > > > >> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FE=
ATURES
> > > > >> special virtio feature is negotiated, then virtio rings start in=
 disabled
> > > > >> state, according to
> > > > >> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#rin=
g-states>.
> > > > >> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are =
needed for
> > > > >> enabling vrings.
> > > > >>
> > > > >> Therefore setting "queue_enable" from the guest (1.1) is a *cont=
rol plane*
> > > > >> operation, which travels from the guest through QEMU to the vhos=
t-user
> > > > >> backend, using a unix domain socket.
> > > > >>
> > > > >> Whereas sending a virtio request (1.3) is a *data plane* operati=
on, which
> > > > >> evades QEMU -- it travels from guest to the vhost-user backend v=
ia
> > > > >> eventfd.
> > > > >>
> > > > >> This means that steps (1.1) and (1.3) travel through different c=
hannels,
> > > > >> and their relative order can be reversed, as perceived by the vh=
ost-user
> > > > >> backend.
> > > > >>
> > > > >> That's exactly what happens when OVMF's virtiofs driver (VirtioF=
sDxe) runs
> > > > >> against the Rust-language virtiofsd version 1.7.2. (Which uses v=
ersion
> > > > >> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the=
 vhost
> > > > >> crate.)
> > > > >>
> > > > >> Namely, when VirtioFsDxe binds a virtiofs device, it goes throug=
h the
> > > > >> device initialization steps (i.e., control plane operations), an=
d
> > > > >> immediately sends a FUSE_INIT request too (i.e., performs a data=
 plane
> > > > >> operation). In the Rust-language virtiofsd, this creates a race =
between
> > > > >> two components that run *concurrently*, i.e., in different threa=
ds or
> > > > >> processes:
> > > > >>
> > > > >> - Control plane, handling vhost-user protocol messages:
> > > > >>
> > > > >>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
> > > > >>   [crates/vhost-user-backend/src/handler.rs] handles
> > > > >>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's=
 "enabled"
> > > > >>   flag according to the message processed.
> > > > >>
> > > > >> - Data plane, handling virtio / FUSE requests:
> > > > >>
> > > > >>   The "VringEpollHandler::handle_event" method
> > > > >>   [crates/vhost-user-backend/src/event_loop.rs] handles the inco=
ming
> > > > >>   virtio / FUSE request, consuming the virtio kick at the same t=
ime. If
> > > > >>   the vring's "enabled" flag is set, the virtio / FUSE request i=
s
> > > > >>   processed genuinely. If the vring's "enabled" flag is clear, t=
hen the
> > > > >>   virtio / FUSE request is discarded.
> > > > >
> > > > > Why is virtiofsd monitoring the virtqueue and discarding requests
> > > > > while it's disabled?
> > > >
> > > > That's what the vhost-user spec requires:
> > > >
> > > > https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-st=
ates
> > > >
> > > > """
> > > > started but disabled: the back-end must process the ring without ca=
using
> > > > any side effects. For example, for a networking device, in the disa=
bled
> > > > state the back-end must not supply any new RX packets, but must pro=
cess
> > > > and discard any TX packets.
> > > > """
> > > >
> > > > This state is different from "stopped", where "the back-end must no=
t
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
> > > and enable") where virtio-net devices discard tx buffers. The disable=
d
> > > state seems to be specific to vhost-user and not covered in the VIRTI=
O
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
>
> > Yes, I am not sure this can apply to devices or queue types
> > other than virtio net. Maybe.
> >
> > When we say:
> >     must process the ring without causing any side effects.
> > then I think it would be better to say
> >     must process the ring if it can be done without causing
> >     guest visible side effects.
>
> Completing a tx buffer is guest-visible, so I'm confused by this statemen=
t.
>
> > processing rx ring would have a side effect of causing
> > guest to get malformed buffers, so we don't process it.
>
> Why are they malformed? Do you mean the rx buffers are stale (the
> guest driver has changed the number of queues and doesn't expect to
> receive them anymore)?
>
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
> > > > I didn't want to exclude that possiblity; that's why I included Eug=
enio,
> > > > German, Liu Jiang, and Sergio in the CC list.
> > > >
> > > > >
> > > > > When the virtqueue is disabled, don't monitor the kickfd.
> > > > >
> > > > > When the virtqueue transitions from disabled to enabled, the cont=
rol
> > > > > plane should self-trigger the kickfd so that any available buffer=
s
> > > > > will be processed.
> > > > >
> > > > > QEMU uses this scheme to switch between vhost/IOThreads and built=
-in
> > > > > virtqueue kick processing.
> > > > >
> > > > > This approach is more robust than relying buffers being enqueued =
after
> > > > > the virtqueue is enabled.
> > > >
> > > > I'm happy to drop the series if the virtiofsd maintainers agree tha=
t the
> > > > bug is in virtiofsd, and can propose a design to fix it. (I do thin=
k
> > > > that such a fix would require an architectural change.)
> > > >
> > > > FWIW, my own interpretation of the vhost-user spec (see above) was =
that
> > > > virtiofsd was right to behave the way it did, and that there was si=
mply
> > > > no way to prevent out-of-order delivery other than synchronizing th=
e
> > > > guest end-to-end with the vhost-user backend, concerning
> > > > VHOST_USER_SET_VRING_ENABLE.
> > > >
> > > > This end-to-end synchronization is present "naturally" in vhost-net=
,
> > > > where ioctl()s are automatically synchronous -- in fact *all* opera=
tions
> > > > on the control plane are synchronous. (Which is just a different wa=
y to
> > > > say that the guest is tightly coupled with the control plane.)
> > > >
> > > > Note that there has been at least one race like this before; see co=
mmit
> > > > 699f2e535d93 ("vhost: make SET_VRING_ADDR, SET_FEATURES send replie=
s",
> > > > 2021-09-04). Basically every pre-existent call to enforce_reply() i=
s a
> > > > cover-up for the vhost-user spec turning (somewhat recklessly?) mos=
t
> > > > operations into async ones.
> > > >
> > > > At some point this became apparent and so the REPLY_ACK flag was
> > > > introduced; see commit ca525ce5618b ("vhost-user: Introduce a new
> > > > protocol feature REPLY_ACK.", 2016-08-10). (That commit doesn't go =
into
> > > > details, but I'm pretty sure there was a similar race around SET_ME=
M_TABLE!)
> > > >
> > > > BTW even if we drop this series for QEMU, I don't think it will hav=
e
> > > > been in vain. The first few patches are cleanups which could be mer=
ged
> > > > for their own sake. And the last patch is essentially the proof of =
the
> > > > problem statement / analysis. It can be considered an elaborate bug
> > > > report for virtiofsd, *if* we decide the bug is in virtiofsd. I did=
 have
> > > > that avenue in mind as well, when writing the commit message / patc=
h.
> > > >
> > > > For now I'm going to post v2 -- that's not to say that I'm dismissi=
ng
> > > > your feedback (see above!), just want to get the latest version on-=
list.
> > > >
> > > > Thanks!
> > > > Laszlo
> > > >
> > > > >
> > > > > Stefan
> > > > >
> > > > >>
> > > > >> Note that OVMF enables the queue *first*, and sends FUSE_INIT *s=
econd*.
> > > > >> However, if the data plane processor in virtiofsd wins the race,=
 then it
> > > > >> sees the FUSE_INIT *before* the control plane processor took not=
ice of
> > > > >> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data=
 plane
> > > > >> processor. Therefore the latter drops FUSE_INIT on the floor, an=
d goes
> > > > >> back to waiting for further virtio / FUSE requests with epoll_wa=
it.
> > > > >> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a=
 deadlock.
> > > > >>
> > > > >> The deadlock is not deterministic. OVMF hangs infrequently durin=
g first
> > > > >> boot. However, OVMF hangs almost certainly during reboots from t=
he UEFI
> > > > >> shell.
> > > > >>
> > > > >> The race can be "reliably masked" by inserting a very small dela=
y -- a
> > > > >> single debug message -- at the top of "VringEpollHandler::handle=
_event",
> > > > >> i.e., just before the data plane processor checks the "enabled" =
field of
> > > > >> the vring. That delay suffices for the control plane processor t=
o act upon
> > > > >> VHOST_USER_SET_VRING_ENABLE.
> > > > >>
> > > > >> We can deterministically prevent the race in QEMU, by blocking O=
VMF inside
> > > > >> step (1.1) -- i.e., in the write to the "queue_enable" register =
-- until
> > > > >> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF'=
s VCPU
> > > > >> cannot advance to the FUSE_INIT submission before virtiofsd's co=
ntrol
> > > > >> plane processor takes notice of the queue being enabled.
> > > > >>
> > > > >> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
> > > > >>
> > > > >> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, an=
d waiting
> > > > >>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-us=
er feature
> > > > >>   has been negotiated, or
> > > > >>
> > > > >> - performing a separate VHOST_USER_GET_FEATURES *exchange*, whic=
h requires
> > > > >>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_A=
CK.
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
> > > > >> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(str=
uct vhost_dev *dev, int enable)
> > > > >>              .num   =3D enable,
> > > > >>          };
> > > > >>
> > > > >> -        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABL=
E, &state, false);
> > > > >> +        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABL=
E, &state, true);
> > > > >>          if (ret < 0) {
> > > > >>              /*
> > > > >>               * Restoring the previous state is likely infeasibl=
e, as well as
> > > > >
> > > >
> >

