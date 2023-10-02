Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 451247B5C65
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 23:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnQDf-0006Zd-3f; Mon, 02 Oct 2023 17:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnQDc-0006Z0-Hk
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:12:44 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnQDZ-0000Rv-Bo
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 17:12:43 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3af8b498d30so149816b6e.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696281159; x=1696885959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25SDXXGmLpBmT97uPb0CHiL+Uxtpw99fbvMblWUGuWQ=;
 b=bbeSJWMQD1dsLbxlck3LzovILlcW43xBXw861rhyz+MVOBfXeLt9E+yiHjMr1k3o3H
 EufvQbW12g+4R2pK1VJr7rSU7OrNPRvxMlVjeT7L7TKTIOOULwGzK/0U/dWjKM7TuYHR
 4FXI048FokjJcOJmhdsEEOovA0oA19uLnawucVv+dzjRJnUlTNYq1pzXockh4SIOImWi
 9XqU20r93m06Wwlc+Uy3KveYu/cqUKSEdK3HtVRIb78JRwGd3/6j44mngFFsTY+19IT0
 nr2yP67hL4cyUGpq+0bQXKxG38oSWZpq17Ge/SKPgQc3BEjF7tl0LurQNQShX/xEmEuW
 aEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696281159; x=1696885959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25SDXXGmLpBmT97uPb0CHiL+Uxtpw99fbvMblWUGuWQ=;
 b=Z5VB5x2HTlUtbjZH5K0COfZ7w5M44qdAwmVOK8bATtap5SY69UW5Zk9kZ4E0xPvsQY
 37iTP7S0xrh6orlKSPrnUVIA3tFTt7xSuEsUvbk1zkfRQl1oZlNrfgEOIIa3EjhlAmj1
 /SLEPI8NLUzqTArKWC2l0uOM+2NX+Z917/I/GTca7121RZoHLqS50GE/SrD6+htk7ky+
 4iQjzNmzemTHVtQaOSxKDcR/tj32xOwsRTgqhCiNjIHLoyiaHteVDVxm0HD8rbm5HWDL
 uFxvO8x1/JgpwAENgy5WoOgxrc/pFD9m3JbmeW4p7pFpk6InqoKKGEmFHBTA9v4ae7F5
 e6YQ==
X-Gm-Message-State: AOJu0Yy35yliQH4Lvfp+Z8Ui0ICt2WT5XjXWFiUrzoHRX1ibAcPv5Rzu
 uVOClYXD8pIhI2cBvc/G3pnu+/XsFiBY+l4T9Xw=
X-Google-Smtp-Source: AGHT+IEaEhrH6frWl3nKEFJNdlFJrBo7AFuw0PmlNKnCIaziQi518jesw6C1BaiqGhNlQYaB/At3+yTQeNAjmT3SNd8=
X-Received: by 2002:a05:6808:308d:b0:3a4:6b13:b721 with SMTP id
 bl13-20020a056808308d00b003a46b13b721mr14476717oib.46.1696281159410; Mon, 02
 Oct 2023 14:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231002015259-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 2 Oct 2023 17:12:27 -0400
Message-ID: <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x229.google.com
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

On Mon, 2 Oct 2023 at 02:49, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 11:37:50AM -0400, Stefan Hajnoczi wrote:
> > On Wed, 30 Aug 2023 at 09:30, Laszlo Ersek <lersek@redhat.com> wrote:
> > >
> > > On 8/30/23 14:10, Stefan Hajnoczi wrote:
> > > > On Sun, 27 Aug 2023 at 14:31, Laszlo Ersek <lersek@redhat.com> wrot=
e:
> > > >>
> > > >> (1) The virtio-1.0 specification
> > > >> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> w=
rites:
> > > >>
> > > >>> 3     General Initialization And Device Operation
> > > >>> 3.1   Device Initialization
> > > >>> 3.1.1 Driver Requirements: Device Initialization
> > > >>>
> > > >>> [...]
> > > >>>
> > > >>> 7. Perform device-specific setup, including discovery of virtqueu=
es for
> > > >>>    the device, optional per-bus setup, reading and possibly writi=
ng the
> > > >>>    device=E2=80=99s virtio configuration space, and population of=
 virtqueues.
> > > >>>
> > > >>> 8. Set the DRIVER_OK status bit. At this point the device is =E2=
=80=9Clive=E2=80=9D.
> > > >>
> > > >> and
> > > >>
> > > >>> 4         Virtio Transport Options
> > > >>> 4.1       Virtio Over PCI Bus
> > > >>> 4.1.4     Virtio Structure PCI Capabilities
> > > >>> 4.1.4.3   Common configuration structure layout
> > > >>> 4.1.4.3.2 Driver Requirements: Common configuration structure lay=
out
> > > >>>
> > > >>> [...]
> > > >>>
> > > >>> The driver MUST configure the other virtqueue fields before enabl=
ing the
> > > >>> virtqueue with queue_enable.
> > > >>>
> > > >>> [...]
> > > >>
> > > >> These together mean that the following sub-sequence of steps is va=
lid for
> > > >> a virtio-1.0 guest driver:
> > > >>
> > > >> (1.1) set "queue_enable" for the needed queues as the final part o=
f device
> > > >> initialization step (7),
> > > >>
> > > >> (1.2) set DRIVER_OK in step (8),
> > > >>
> > > >> (1.3) immediately start sending virtio requests to the device.
> > > >>
> > > >> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEAT=
URES
> > > >> special virtio feature is negotiated, then virtio rings start in d=
isabled
> > > >> state, according to
> > > >> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-=
states>.
> > > >> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are ne=
eded for
> > > >> enabling vrings.
> > > >>
> > > >> Therefore setting "queue_enable" from the guest (1.1) is a *contro=
l plane*
> > > >> operation, which travels from the guest through QEMU to the vhost-=
user
> > > >> backend, using a unix domain socket.
> > > >>
> > > >> Whereas sending a virtio request (1.3) is a *data plane* operation=
, which
> > > >> evades QEMU -- it travels from guest to the vhost-user backend via
> > > >> eventfd.
> > > >>
> > > >> This means that steps (1.1) and (1.3) travel through different cha=
nnels,
> > > >> and their relative order can be reversed, as perceived by the vhos=
t-user
> > > >> backend.
> > > >>
> > > >> That's exactly what happens when OVMF's virtiofs driver (VirtioFsD=
xe) runs
> > > >> against the Rust-language virtiofsd version 1.7.2. (Which uses ver=
sion
> > > >> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the v=
host
> > > >> crate.)
> > > >>
> > > >> Namely, when VirtioFsDxe binds a virtiofs device, it goes through =
the
> > > >> device initialization steps (i.e., control plane operations), and
> > > >> immediately sends a FUSE_INIT request too (i.e., performs a data p=
lane
> > > >> operation). In the Rust-language virtiofsd, this creates a race be=
tween
> > > >> two components that run *concurrently*, i.e., in different threads=
 or
> > > >> processes:
> > > >>
> > > >> - Control plane, handling vhost-user protocol messages:
> > > >>
> > > >>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
> > > >>   [crates/vhost-user-backend/src/handler.rs] handles
> > > >>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "=
enabled"
> > > >>   flag according to the message processed.
> > > >>
> > > >> - Data plane, handling virtio / FUSE requests:
> > > >>
> > > >>   The "VringEpollHandler::handle_event" method
> > > >>   [crates/vhost-user-backend/src/event_loop.rs] handles the incomi=
ng
> > > >>   virtio / FUSE request, consuming the virtio kick at the same tim=
e. If
> > > >>   the vring's "enabled" flag is set, the virtio / FUSE request is
> > > >>   processed genuinely. If the vring's "enabled" flag is clear, the=
n the
> > > >>   virtio / FUSE request is discarded.
> > > >
> > > > Why is virtiofsd monitoring the virtqueue and discarding requests
> > > > while it's disabled?
> > >
> > > That's what the vhost-user spec requires:
> > >
> > > https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-stat=
es
> > >
> > > """
> > > started but disabled: the back-end must process the ring without caus=
ing
> > > any side effects. For example, for a networking device, in the disabl=
ed
> > > state the back-end must not supply any new RX packets, but must proce=
ss
> > > and discard any TX packets.
> > > """
> > >
> > > This state is different from "stopped", where "the back-end must not
> > > process the ring at all".
> > >
> > > The spec also says,
> > >
> > > """
> > > If VHOST_USER_F_PROTOCOL_FEATURES has been negotiated, the ring is
> > > initialized in a disabled state and is enabled by
> > > VHOST_USER_SET_VRING_ENABLE with parameter 1.
> > > """
> > >
> > > AFAICT virtiofsd follows this requirement.
> >
> > Hi Michael,
> > You documented the disabled ring state in QEMU commit commit
> > c61f09ed855b5009f816242ce281fd01586d4646 ("vhost-user: clarify start
> > and enable") where virtio-net devices discard tx buffers. The disabled
> > state seems to be specific to vhost-user and not covered in the VIRTIO
> > specification.
> >
> > Do you remember what the purpose of the disabled state was? Why is it
> > necessary to discard tx buffers instead of postponing ring processing
> > until the virtqueue is enabled?
> >
> > My concern is that the semantics are unclear for virtqueue types that
> > are different from virtio-net rx/tx. Even the virtio-net controlq
> > would be problematic - should buffers be silently discarded with
> > VIRTIO_NET_OK or should they fail?
> >
> > Thanks,
> > Stefan
>
> I think I got it now.
> This weird state happens when linux first queues packets
> on multiple queues, then changes max queues to 1, queued packets need
> to still be freed eventually.

Can you explain what is happening in the guest driver, QEMU, and the
vhost-user-net device in more detail? I don't understand the scenario.

> Yes, I am not sure this can apply to devices or queue types
> other than virtio net. Maybe.
>
> When we say:
>     must process the ring without causing any side effects.
> then I think it would be better to say
>     must process the ring if it can be done without causing
>     guest visible side effects.

Completing a tx buffer is guest-visible, so I'm confused by this statement.

> processing rx ring would have a side effect of causing
> guest to get malformed buffers, so we don't process it.

Why are they malformed? Do you mean the rx buffers are stale (the
guest driver has changed the number of queues and doesn't expect to
receive them anymore)?

> processing command queue - we can't fail for sure since
> that is guest visible. but practically we don't do this
> for cvq.
>
> what should happen for virtiofsd? I don't know -
> I am guessing discarding would have a side effect
> so should not happen.
>
>
>
>
> > >
> > > > This seems like a bug in the vhost-user backend to me.
> > >
> > > I didn't want to exclude that possiblity; that's why I included Eugen=
io,
> > > German, Liu Jiang, and Sergio in the CC list.
> > >
> > > >
> > > > When the virtqueue is disabled, don't monitor the kickfd.
> > > >
> > > > When the virtqueue transitions from disabled to enabled, the contro=
l
> > > > plane should self-trigger the kickfd so that any available buffers
> > > > will be processed.
> > > >
> > > > QEMU uses this scheme to switch between vhost/IOThreads and built-i=
n
> > > > virtqueue kick processing.
> > > >
> > > > This approach is more robust than relying buffers being enqueued af=
ter
> > > > the virtqueue is enabled.
> > >
> > > I'm happy to drop the series if the virtiofsd maintainers agree that =
the
> > > bug is in virtiofsd, and can propose a design to fix it. (I do think
> > > that such a fix would require an architectural change.)
> > >
> > > FWIW, my own interpretation of the vhost-user spec (see above) was th=
at
> > > virtiofsd was right to behave the way it did, and that there was simp=
ly
> > > no way to prevent out-of-order delivery other than synchronizing the
> > > guest end-to-end with the vhost-user backend, concerning
> > > VHOST_USER_SET_VRING_ENABLE.
> > >
> > > This end-to-end synchronization is present "naturally" in vhost-net,
> > > where ioctl()s are automatically synchronous -- in fact *all* operati=
ons
> > > on the control plane are synchronous. (Which is just a different way =
to
> > > say that the guest is tightly coupled with the control plane.)
> > >
> > > Note that there has been at least one race like this before; see comm=
it
> > > 699f2e535d93 ("vhost: make SET_VRING_ADDR, SET_FEATURES send replies"=
,
> > > 2021-09-04). Basically every pre-existent call to enforce_reply() is =
a
> > > cover-up for the vhost-user spec turning (somewhat recklessly?) most
> > > operations into async ones.
> > >
> > > At some point this became apparent and so the REPLY_ACK flag was
> > > introduced; see commit ca525ce5618b ("vhost-user: Introduce a new
> > > protocol feature REPLY_ACK.", 2016-08-10). (That commit doesn't go in=
to
> > > details, but I'm pretty sure there was a similar race around SET_MEM_=
TABLE!)
> > >
> > > BTW even if we drop this series for QEMU, I don't think it will have
> > > been in vain. The first few patches are cleanups which could be merge=
d
> > > for their own sake. And the last patch is essentially the proof of th=
e
> > > problem statement / analysis. It can be considered an elaborate bug
> > > report for virtiofsd, *if* we decide the bug is in virtiofsd. I did h=
ave
> > > that avenue in mind as well, when writing the commit message / patch.
> > >
> > > For now I'm going to post v2 -- that's not to say that I'm dismissing
> > > your feedback (see above!), just want to get the latest version on-li=
st.
> > >
> > > Thanks!
> > > Laszlo
> > >
> > > >
> > > > Stefan
> > > >
> > > >>
> > > >> Note that OVMF enables the queue *first*, and sends FUSE_INIT *sec=
ond*.
> > > >> However, if the data plane processor in virtiofsd wins the race, t=
hen it
> > > >> sees the FUSE_INIT *before* the control plane processor took notic=
e of
> > > >> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data p=
lane
> > > >> processor. Therefore the latter drops FUSE_INIT on the floor, and =
goes
> > > >> back to waiting for further virtio / FUSE requests with epoll_wait=
.
> > > >> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a d=
eadlock.
> > > >>
> > > >> The deadlock is not deterministic. OVMF hangs infrequently during =
first
> > > >> boot. However, OVMF hangs almost certainly during reboots from the=
 UEFI
> > > >> shell.
> > > >>
> > > >> The race can be "reliably masked" by inserting a very small delay =
-- a
> > > >> single debug message -- at the top of "VringEpollHandler::handle_e=
vent",
> > > >> i.e., just before the data plane processor checks the "enabled" fi=
eld of
> > > >> the vring. That delay suffices for the control plane processor to =
act upon
> > > >> VHOST_USER_SET_VRING_ENABLE.
> > > >>
> > > >> We can deterministically prevent the race in QEMU, by blocking OVM=
F inside
> > > >> step (1.1) -- i.e., in the write to the "queue_enable" register --=
 until
> > > >> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's =
VCPU
> > > >> cannot advance to the FUSE_INIT submission before virtiofsd's cont=
rol
> > > >> plane processor takes notice of the queue being enabled.
> > > >>
> > > >> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
> > > >>
> > > >> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and =
waiting
> > > >>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user=
 feature
> > > >>   has been negotiated, or
> > > >>
> > > >> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which =
requires
> > > >>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK=
.
> > > >>
> > > >> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> > > >> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> > > >> Cc: German Maglione <gmaglione@redhat.com>
> > > >> Cc: Liu Jiang <gerry@linux.alibaba.com>
> > > >> Cc: Sergio Lopez Pascual <slp@redhat.com>
> > > >> Cc: Stefano Garzarella <sgarzare@redhat.com>
> > > >> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > > >> ---
> > > >>  hw/virtio/vhost-user.c | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> > > >> index beb4b832245e..01e0ca90c538 100644
> > > >> --- a/hw/virtio/vhost-user.c
> > > >> +++ b/hw/virtio/vhost-user.c
> > > >> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(struc=
t vhost_dev *dev, int enable)
> > > >>              .num   =3D enable,
> > > >>          };
> > > >>
> > > >> -        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE,=
 &state, false);
> > > >> +        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE,=
 &state, true);
> > > >>          if (ret < 0) {
> > > >>              /*
> > > >>               * Restoring the previous state is likely infeasible,=
 as well as
> > > >
> > >
>

