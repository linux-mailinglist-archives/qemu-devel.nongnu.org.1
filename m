Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE9E7B6D81
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhkR-00036C-Ai; Tue, 03 Oct 2023 11:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnhkH-00031f-8a
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:55:37 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnhkE-00066A-Tn
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:55:37 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3af64a4c97eso654423b6e.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696348529; x=1696953329; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3b+PWJ8t/AhfL2VKSoK9GbwiB65pCBa6BBo1r1kdO1s=;
 b=Ij8y8Y/OCYPOBoz7Ne4iKDcd4avPBlSLHGBfc2MQzaf0rbb5brdTTxZYlA+MJztJkk
 5npTQ3iZ3AsS9uxwGZESauvNZNjgePoKyeXLlt+fuOoyvWejT5lg4XWzdtbkfc3yu1KQ
 Yro9QMIX6qu5dU/NJ7rYLG2plG5eWxAgDjdIKMNvkKIoNfcVBNjycrMiNuXgeE75RZd7
 CNgxcj/PBdhONpNv83pGrUoP2vmZGjVHwq3s0cdPTTL8GLst6jz2BkyBj+zSLFblvXYb
 p/MC4k3C/I3vM/3Y/9KPBpQiKocbWKEVGMfrcMHKQvW7KwxWC/+YSOExqmazmcYzP+YK
 lvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696348529; x=1696953329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3b+PWJ8t/AhfL2VKSoK9GbwiB65pCBa6BBo1r1kdO1s=;
 b=E9ElP/sKI96GxjwCKglMCLrRw5sfVYMjvZgOxcLz4kDXUfwFGRGOY/xsog8w3zkUTO
 xj0mdHD20kjWveaNr+F8peGca3p4ZRI5BpeySUlpbj5j5HOUGMRHVIchIZNdPjIRADwr
 TTBkFH3E5OGkTz8km5WfBJQWAqoYFfZAG0avt4cUQIMpwfBHeQpnl/ymkL5JdoUgwom3
 tUvdg521ONJFia2u5S9Mpz1VHwhhLHx1NBeMJNaxb34hhs6FuFQfCl73DPwjPQyMsfOb
 W3jjAKP7OHE5jeKERGbbkAlRdF/DPjyfY+1KUsoA0WD9hSUrAor/7mwgNfbfoDQQq6w7
 x0tw==
X-Gm-Message-State: AOJu0YzvVfJRxvmEl1jcwE/aza1lwFPaVtA0BCL/TuMEQEqbQQiMYqVL
 U5jfU0ai25bZV3+uzfto2EjgWvXTbzzu17N7iIQ=
X-Google-Smtp-Source: AGHT+IG9pBULDwWn1/c6PCUZHP6n/YmrJXMYeQcxgHoKGf34vObpS/+F1PA0354r24adShnm+u8e9PNZUKZeBV52eAQ=
X-Received: by 2002:a05:6808:10c7:b0:3a7:6213:6897 with SMTP id
 s7-20020a05680810c700b003a762136897mr18604558ois.11.1696348529375; Tue, 03
 Oct 2023 08:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <20231003104045-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231003104045-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Oct 2023 11:55:17 -0400
Message-ID: <CAJSP0QUmU1zq=b2QxFSmF_hJ9hDT5G2TcK3R33r=gzcNhOKEpw@mail.gmail.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x233.google.com
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

On Tue, 3 Oct 2023 at 10:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sun, Aug 27, 2023 at 08:29:37PM +0200, Laszlo Ersek wrote:
> > (1) The virtio-1.0 specification
> > <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> writes=
:
> >
> > > 3     General Initialization And Device Operation
> > > 3.1   Device Initialization
> > > 3.1.1 Driver Requirements: Device Initialization
> > >
> > > [...]
> > >
> > > 7. Perform device-specific setup, including discovery of virtqueues f=
or
> > >    the device, optional per-bus setup, reading and possibly writing t=
he
> > >    device=E2=80=99s virtio configuration space, and population of vir=
tqueues.
> > >
> > > 8. Set the DRIVER_OK status bit. At this point the device is =E2=80=
=9Clive=E2=80=9D.
> >
> > and
> >
> > > 4         Virtio Transport Options
> > > 4.1       Virtio Over PCI Bus
> > > 4.1.4     Virtio Structure PCI Capabilities
> > > 4.1.4.3   Common configuration structure layout
> > > 4.1.4.3.2 Driver Requirements: Common configuration structure layout
> > >
> > > [...]
> > >
> > > The driver MUST configure the other virtqueue fields before enabling =
the
> > > virtqueue with queue_enable.
> > >
> > > [...]
> >
> > These together mean that the following sub-sequence of steps is valid f=
or
> > a virtio-1.0 guest driver:
> >
> > (1.1) set "queue_enable" for the needed queues as the final part of dev=
ice
> > initialization step (7),
> >
> > (1.2) set DRIVER_OK in step (8),
> >
> > (1.3) immediately start sending virtio requests to the device.
> >
> > (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
> > special virtio feature is negotiated, then virtio rings start in disabl=
ed
> > state, according to
> > <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-state=
s>.
> > In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed =
for
> > enabling vrings.
> >
> > Therefore setting "queue_enable" from the guest (1.1) is a *control pla=
ne*
> > operation, which travels from the guest through QEMU to the vhost-user
> > backend, using a unix domain socket.
> >
> > Whereas sending a virtio request (1.3) is a *data plane* operation, whi=
ch
> > evades QEMU -- it travels from guest to the vhost-user backend via
> > eventfd.
> >
> > This means that steps (1.1) and (1.3) travel through different channels=
,
> > and their relative order can be reversed, as perceived by the vhost-use=
r
> > backend.
> >
> > That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) r=
uns
> > against the Rust-language virtiofsd version 1.7.2. (Which uses version
> > 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
> > crate.)
> >
> > Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
> > device initialization steps (i.e., control plane operations), and
> > immediately sends a FUSE_INIT request too (i.e., performs a data plane
> > operation). In the Rust-language virtiofsd, this creates a race between
> > two components that run *concurrently*, i.e., in different threads or
> > processes:
> >
> > - Control plane, handling vhost-user protocol messages:
> >
> >   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
> >   [crates/vhost-user-backend/src/handler.rs] handles
> >   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabl=
ed"
> >   flag according to the message processed.
> >
> > - Data plane, handling virtio / FUSE requests:
> >
> >   The "VringEpollHandler::handle_event" method
> >   [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
> >   virtio / FUSE request, consuming the virtio kick at the same time. If
> >   the vring's "enabled" flag is set, the virtio / FUSE request is
> >   processed genuinely. If the vring's "enabled" flag is clear, then the
> >   virtio / FUSE request is discarded.
> >
> > Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
> > However, if the data plane processor in virtiofsd wins the race, then i=
t
> > sees the FUSE_INIT *before* the control plane processor took notice of
> > VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
> > processor. Therefore the latter drops FUSE_INIT on the floor, and goes
> > back to waiting for further virtio / FUSE requests with epoll_wait.
> > Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlo=
ck.
> >
> > The deadlock is not deterministic. OVMF hangs infrequently during first
> > boot. However, OVMF hangs almost certainly during reboots from the UEFI
> > shell.
> >
> > The race can be "reliably masked" by inserting a very small delay -- a
> > single debug message -- at the top of "VringEpollHandler::handle_event"=
,
> > i.e., just before the data plane processor checks the "enabled" field o=
f
> > the vring. That delay suffices for the control plane processor to act u=
pon
> > VHOST_USER_SET_VRING_ENABLE.
> >
> > We can deterministically prevent the race in QEMU, by blocking OVMF ins=
ide
> > step (1.1) -- i.e., in the write to the "queue_enable" register -- unti=
l
> > VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
> > cannot advance to the FUSE_INIT submission before virtiofsd's control
> > plane processor takes notice of the queue being enabled.
> >
> > Wait for VHOST_USER_SET_VRING_ENABLE completion by:
> >
> > - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiti=
ng
> >   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feat=
ure
> >   has been negotiated, or
> >
> > - performing a separate VHOST_USER_GET_FEATURES *exchange*, which requi=
res
> >   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
> >
> > Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> > Cc: Eugenio Perez Martin <eperezma@redhat.com>
> > Cc: German Maglione <gmaglione@redhat.com>
> > Cc: Liu Jiang <gerry@linux.alibaba.com>
> > Cc: Sergio Lopez Pascual <slp@redhat.com>
> > Cc: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>
>
> So you want me to hold on to this patch 7/7 for now?
> And maybe merge rest of the patchset?

Up to Laszlo, but I wanted to mention that I support merging this
patch series. A ring has not been enabled/disabled until the back-end
replies, so I think this patch series makes sense.

Stefan

