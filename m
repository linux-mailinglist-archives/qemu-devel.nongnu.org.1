Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B86678D5D0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 14:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbK1g-0000SN-KD; Wed, 30 Aug 2023 08:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbK1d-0000Rs-LK
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:10:21 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbK1a-0001uG-Ps
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 08:10:21 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1c4f4d67f5bso3640722fac.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 05:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693397417; x=1694002217; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sSgdYufStWRMS1tvobQt3ajwje2UjQpe3WA1/Lt1hs=;
 b=GTdCNIUbuXyaQaLiucTfXkX5GuEgatKGOBx6+ayPHKhpgBiNZMM/Cd+Df+xwQPg0Da
 JMPW9h0t7xu+pG2NJNZA/dqAdFhAGjS37iHMeWMsEpHQIze2OBY3pj7MIPvIvVQgiEyW
 ACEDd3GRXdXjktNuyIW8ddEfidY3yxV3EJ8fez3iziUIfzxIysmgOcC/IE7vWrggKoaX
 v1ct9XIZ4Xkx3xzZ6a68PKNBGbgcC7YkuClxh7lf3tBmt2cj39NSmftwAsrTDQ9gnvTW
 mYy0fSFHBoe0vCv21n8usu9M4W10Q9Rw1cfMdTVFBx/BvYcwi4hHUDIXh+6CcZTV90cG
 D85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693397417; x=1694002217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sSgdYufStWRMS1tvobQt3ajwje2UjQpe3WA1/Lt1hs=;
 b=HbRSENLnNLBbOaNEd31RuJOsNBr/fNvYJj0qZTG9f7EuTE6xsmEJ36Oo6ZW2lIeZZH
 Bv6Xp+I6nS8CWq9jz9DaGRmCZn/Hx4W26AusmWh3IPbJ0N16qJoYco7JVBXfgeufjdoC
 dxRm7igdVNcgChRBOriBtNrUs8PzL4XWoRvitcJskRTxOKGSerVekmFYpdEzTjKnNeym
 +g27/Ob8PQaaAIGmbKjNs7QORSiKccJv+U/gw5MkDxYP3fGDGIpGYal2uBG+Pkvt33lU
 xMmCxfCSZLsZ71EXv4qwEN59zUBwcx6g8sims+F7rh6qSnnRJnUpQYKRMfIMH/5xCJXS
 pzyQ==
X-Gm-Message-State: AOJu0YwlGdphZRHFlEizY1Xb3ohiLzdCwutrive+dokBp+PdQ6EVEMFv
 M2qpvm4lgHeXXbS+yFr9zA8Be8Mm5t2scpDUG2g=
X-Google-Smtp-Source: AGHT+IHl3xSn8J6/KtIX6s0rb3VIzEJwOq4LKb27Br9dcBTCk161r4gsbE3Y9BxR2SM6E7SEICSVzu6IxGwgIU4p5Y8=
X-Received: by 2002:a05:6870:b401:b0:1b7:27fd:cfff with SMTP id
 x1-20020a056870b40100b001b727fdcfffmr2572696oap.21.1693397417007; Wed, 30 Aug
 2023 05:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
In-Reply-To: <20230827182937.146450-8-lersek@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 30 Aug 2023 08:10:05 -0400
Message-ID: <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x29.google.com
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

On Sun, 27 Aug 2023 at 14:31, Laszlo Ersek <lersek@redhat.com> wrote:
>
> (1) The virtio-1.0 specification
> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> writes:
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

Why is virtiofsd monitoring the virtqueue and discarding requests
while it's disabled? This seems like a bug in the vhost-user backend
to me.

When the virtqueue is disabled, don't monitor the kickfd.

When the virtqueue transitions from disabled to enabled, the control
plane should self-trigger the kickfd so that any available buffers
will be processed.

QEMU uses this scheme to switch between vhost/IOThreads and built-in
virtqueue kick processing.

This approach is more robust than relying buffers being enqueued after
the virtqueue is enabled.

Stefan

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
> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index beb4b832245e..01e0ca90c538 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(struct vhost=
_dev *dev, int enable)
>              .num   =3D enable,
>          };
>
> -        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state=
, false);
> +        ret =3D vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state=
, true);
>          if (ret < 0) {
>              /*
>               * Restoring the previous state is likely infeasible, as wel=
l as

