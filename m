Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A517797628
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHQm-00051s-OP; Thu, 07 Sep 2023 12:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qeHQh-00050r-9Y
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qeHQc-0001IQ-Iz
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694102416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=26VjuMjZkybRnfUIoJep5JkEfQM3tfSs7wsInkvu6aw=;
 b=JzZ0RMmEltH1GWDI3I6nlFBvL67wghfUUra2fjiZXLyvPosc+K7eFVve4RREGF9pD3u5TA
 Ai/P6TRQ9T+BBuB/vAeBc/J6p17GzSAt2LKyz7QecfHpiwFMMDI8U3lRwxHgI2PcJ8Pm6F
 B4jrZaoKxgZXImlYA8wrDf5X2ZNbbVs=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-1KthMohENhK60hUewvNOlA-1; Thu, 07 Sep 2023 12:00:13 -0400
X-MC-Unique: 1KthMohENhK60hUewvNOlA-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-c8f360a07a2so1174110276.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102413; x=1694707213;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26VjuMjZkybRnfUIoJep5JkEfQM3tfSs7wsInkvu6aw=;
 b=Aj4f0FoObrr/c7pj6xZrDU5rJpqt82na00B5ICxMVnj1zf9E/0LuRaA95kk3iY3pS9
 HsPdkcNE5+VU9WDY78gB9GsWMXqhogl7OaE+FNjo4Djkil9uriMtqGEn9HYQfSlovCR2
 TvarM0oGOcJzWZ1b5O3+0iQstRxlRMg9c2EPjicStJzEMdAnJW8f2J6lnF2ue/fxIZ90
 ZTFcZaRk0tlGDiBjAE2jaSuKCpY4CAk6GkZK62DfTipKcEFVpiO9gzYI0OLbENV5arr9
 a8tCjzIYDY5Yh3o+YthOhBSDAjH3l4+xc6KNV8KRKyU++ibYeOdTksS1aSyaSKqt0oqW
 DY6w==
X-Gm-Message-State: AOJu0Yw3OE/u7jHtok3CS/XzyL7gZgnbeOMM99QpWbH4vv/VfmAh9F1v
 bezcwYkubziFINQsK7gsTfecNQ+KbY6IBtTMHB4ICZM85P9Ym05mfz/xD4mt3a8bMZGZgZXk5zp
 jWSdd+8iMGbkYwxkSV5G1aHrLUqv2M88=
X-Received: by 2002:a25:b191:0:b0:d7b:3298:8e12 with SMTP id
 h17-20020a25b191000000b00d7b32988e12mr18786353ybj.7.1694102412866; 
 Thu, 07 Sep 2023 09:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYJ7V/oe4WwzQgC3hlZwdNDKLuxzgQJpGn8jIdPGC8XnjycZRjCL4e0EvPYeyHjMkJEIB0wz8Dy4TAqmRyxJU=
X-Received: by 2002:a25:b191:0:b0:d7b:3298:8e12 with SMTP id
 h17-20020a25b191000000b00d7b32988e12mr18786326ybj.7.1694102412516; Thu, 07
 Sep 2023 09:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-8-lersek@redhat.com>
In-Reply-To: <20230830134055.106812-8-lersek@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 7 Sep 2023 17:59:35 +0200
Message-ID: <CAJaqyWe9X_qneUA-ToiSVNEZ23+cjbqVrheOhOQ8mCWF8dfrLA@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>, 
 Sergio Lopez Pascual <slp@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Wed, Aug 30, 2023 at 3:41=E2=80=AFPM Laszlo Ersek <lersek@redhat.com> wr=
ote:
>
> (1) The virtio-1.2 specification
> <http://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html> writes:
>
> > 3     General Initialization And Device Operation
> > 3.1   Device Initialization
> > 3.1.1 Driver Requirements: Device Initialization
> >
> > [...]
> >
> > 7. Perform device-specific setup, including discovery of virtqueues for
> >    the device, optional per-bus setup, reading and possibly writing the
> >    device=E2=80=99s virtio configuration space, and population of virtq=
ueues.
> >
> > 8. Set the DRIVER_OK status bit. At this point the device is =E2=80=9Cl=
ive=E2=80=9D.
>
> and
>
> > 4         Virtio Transport Options
> > 4.1       Virtio Over PCI Bus
> > 4.1.4     Virtio Structure PCI Capabilities
> > 4.1.4.3   Common configuration structure layout
> > 4.1.4.3.2 Driver Requirements: Common configuration structure layout
> >
> > [...]
> >
> > The driver MUST configure the other virtqueue fields before enabling th=
e
> > virtqueue with queue_enable.
> >
> > [...]
>
> (The same statements are present in virtio-1.0 identically, at
> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html>.)
>
> These together mean that the following sub-sequence of steps is valid for
> a virtio-1.0 guest driver:
>
> (1.1) set "queue_enable" for the needed queues as the final part of devic=
e
> initialization step (7),
>
> (1.2) set DRIVER_OK in step (8),
>
> (1.3) immediately start sending virtio requests to the device.
>
> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
> special virtio feature is negotiated, then virtio rings start in disabled
> state, according to
> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>=
.
> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed fo=
r
> enabling vrings.
>
> Therefore setting "queue_enable" from the guest (1.1) is a *control plane=
*
> operation, which travels from the guest through QEMU to the vhost-user
> backend, using a unix domain socket.
>

The code looks good to me, but this part of the message is not precise
if I understood it correctly.

Guest PCI "queue_enable" writes remain in the qemu virtio device model
until the guest writes DRIVER_OK to the status. I'm referring to
hw/virtio/virtio-pci.c:virtio_pci_common_write, case
VIRTIO_PCI_COMMON_Q_ENABLE. From there, virtio_queue_enable just saves
the info in VirtIOPCIProxy.

After the needed queues are enabled, the guest writes DRIVER_OK status
bit. Then, the vhost backend is started and qemu sends the
VHOST_USER_SET_VRING_ENABLE through the unix socket. And that is the
source of the message that is racing with the dataplane.

I didn't confirm it with virtiofs through tracing / debugging, so I
may be missing something.

Even with the small nit, the code fixes the problem.

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Whereas sending a virtio request (1.3) is a *data plane* operation, which
> evades QEMU -- it travels from guest to the vhost-user backend via
> eventfd.
>
> This means that steps (1.1) and (1.3) travel through different channels,
> and their relative order can be reversed, as perceived by the vhost-user
> backend.
>
> That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) run=
s
> against the Rust-language virtiofsd version 1.7.2. (Which uses version
> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
> crate.)
>
> Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
> device initialization steps (i.e., control plane operations), and
> immediately sends a FUSE_INIT request too (i.e., performs a data plane
> operation). In the Rust-language virtiofsd, this creates a race between
> two components that run *concurrently*, i.e., in different threads or
> processes:
>
> - Control plane, handling vhost-user protocol messages:
>
>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
>   [crates/vhost-user-backend/src/handler.rs] handles
>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled=
"
>   flag according to the message processed.
>
> - Data plane, handling virtio / FUSE requests:
>
>   The "VringEpollHandler::handle_event" method
>   [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
>   virtio / FUSE request, consuming the virtio kick at the same time. If
>   the vring's "enabled" flag is set, the virtio / FUSE request is
>   processed genuinely. If the vring's "enabled" flag is clear, then the
>   virtio / FUSE request is discarded.
>
> Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
> However, if the data plane processor in virtiofsd wins the race, then it
> sees the FUSE_INIT *before* the control plane processor took notice of
> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
> processor. Therefore the latter drops FUSE_INIT on the floor, and goes
> back to waiting for further virtio / FUSE requests with epoll_wait.
> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock=
.
>
> The deadlock is not deterministic. OVMF hangs infrequently during first
> boot. However, OVMF hangs almost certainly during reboots from the UEFI
> shell.
>
> The race can be "reliably masked" by inserting a very small delay -- a
> single debug message -- at the top of "VringEpollHandler::handle_event",
> i.e., just before the data plane processor checks the "enabled" field of
> the vring. That delay suffices for the control plane processor to act upo=
n
> VHOST_USER_SET_VRING_ENABLE.
>
> We can deterministically prevent the race in QEMU, by blocking OVMF insid=
e
> step (1.1) -- i.e., in the write to the "queue_enable" register -- until
> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
> cannot advance to the FUSE_INIT submission before virtiofsd's control
> plane processor takes notice of the queue being enabled.
>
> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
>
> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user featur=
e
>   has been negotiated, or
>
> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which require=
s
>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>
> Notes:
>     v2:
>
>     - pick up R-b from Stefano
>
>     - update virtio spec reference from 1.0 to 1.2 (also keep the 1.0 ref=
)
>       in the commit message; re-check the quotes / section headers [Stefa=
no]
>
>     - summarize commit message in code comment [Stefano]
>
>  hw/virtio/vhost-user.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 18e15a9bb359..41842eb023b5 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1235,7 +1235,21 @@ static int vhost_user_set_vring_enable(struct vhos=
t_dev *dev, int enable)
>              .num   =3D enable,
>          };
>
> -        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state=
, false);
> +        /*
> +         * SET_VRING_ENABLE travels from guest to QEMU to vhost-user bac=
kend /
> +         * control plane thread via unix domain socket. Virtio requests =
travel
> +         * from guest to vhost-user backend / data plane thread via even=
tfd.
> +         * Even if the guest enables the ring first, and pushes its firs=
t virtio
> +         * request second (conforming to the virtio spec), the data plan=
e thread
> +         * in the backend may see the virtio request before the control =
plane
> +         * thread sees the queue enablement. This causes (in fact, requi=
res) the
> +         * data plane thread to discard the virtio request (it arrived o=
n a
> +         * seemingly disabled queue). To prevent this out-of-order deliv=
ery,
> +         * don't let the guest proceed to pushing the virtio request unt=
il the
> +         * backend control plane acknowledges enabling the queue -- IOW,=
 pass
> +         * wait_for_reply=3Dtrue below.
> +         */
> +        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state=
, true);
>          if (ret < 0) {
>              /*
>               * Restoring the previous state is likely infeasible, as wel=
l as


