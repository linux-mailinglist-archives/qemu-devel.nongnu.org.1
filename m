Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3737B854F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:31:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4lz-0000aE-Cl; Wed, 04 Oct 2023 12:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo4lj-0000Xj-Kn
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo4le-0001dx-AX
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696437031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2XbOgwtKKTotNdO9TL1jfo8sF9UQDRgbkhDVuIiEoc=;
 b=TqIqeBW9S8OYT2cGdAdbSGKtDqh1lxbGHF4AuRDkrJ/OIPnM6HEMHhj7gYioCFoeTfDu6C
 4GzROqkpduFNRjfyVaMVKElzAK4dtX1Os9tIW0iBkWykxUdM8K9NZJlZpOYy4KFrZd/jRv
 J2leqNm99pIERTCbDieZgv1lRsR2XhQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-nR0_ReF_OCOaNZT-8I6xcg-1; Wed, 04 Oct 2023 12:30:19 -0400
X-MC-Unique: nR0_ReF_OCOaNZT-8I6xcg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3251bc06680so26266f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437018; x=1697041818;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2XbOgwtKKTotNdO9TL1jfo8sF9UQDRgbkhDVuIiEoc=;
 b=HlA/SuI2ypk65JdQxmrnRORrK8RXWMmBtWerpFd3Gpmvumqopld4GGmFi2PVvsfvKq
 5oocys74Lq9c/EVdszhqmSaASphoZLpgaDav0UXvmWrFyY4tbXvIEmfMDNJ4ZP3Oc9H1
 JexMf938CgOj0kgRdzyJDA/UnvFdXg2ZoP2i5dWl28cO8MlGz7Yk8NKcun25vASQWw/X
 d2PxUZ51CzI7h7EIYiuUWWxnaluDUrlhcsAggS8QVIzpE/x5Q13odF11995kYouAwuZ1
 lDrjdhR7Lqd0JeLeCPH5sKfStx/skFSpU4tZWrW92F7Ft+h78hi/MbA88NK6gnrfFEel
 peDg==
X-Gm-Message-State: AOJu0Yw+HrmMJ6XP4POvlQNs7+dMgd2/PdRAZfO9KeJI4GAAIhHtO7g/
 YCeQ+I61CFVekzWJjhxRTVuHEl1/cpmtuBKD1ZddZw0rycndgctXkxxq1cfu6voaqUvIsX/NBf5
 zTiiXRXcS2niRYBY=
X-Received: by 2002:a05:6000:114d:b0:324:8502:6355 with SMTP id
 d13-20020a056000114d00b0032485026355mr2556354wrx.46.1696437018746; 
 Wed, 04 Oct 2023 09:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYp85yBGtglPr5WS9TZDBwgeWWNzBZgM6+sNGCXDp0RMpLD2NMhpE+VP46BJ4tryOznlocgQ==
X-Received: by 2002:a05:6000:114d:b0:324:8502:6355 with SMTP id
 d13-20020a056000114d00b0032485026355mr2556328wrx.46.1696437018352; 
 Wed, 04 Oct 2023 09:30:18 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 p9-20020adfcc89000000b00326028b4dd5sm4361478wrj.113.2023.10.04.09.30.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:30:16 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:30:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231004122927-mutt-send-email-mst@kernel.org>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <20231003104045-mutt-send-email-mst@kernel.org>
 <CAJSP0QUmU1zq=b2QxFSmF_hJ9hDT5G2TcK3R33r=gzcNhOKEpw@mail.gmail.com>
 <67502261-0e48-60e1-f5d4-10f7f3bd164e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67502261-0e48-60e1-f5d4-10f7f3bd164e@redhat.com>
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

On Wed, Oct 04, 2023 at 12:15:48PM +0200, Laszlo Ersek wrote:
> On 10/3/23 17:55, Stefan Hajnoczi wrote:
> > On Tue, 3 Oct 2023 at 10:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Sun, Aug 27, 2023 at 08:29:37PM +0200, Laszlo Ersek wrote:
> >>> (1) The virtio-1.0 specification
> >>> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> writes:
> >>>
> >>>> 3     General Initialization And Device Operation
> >>>> 3.1   Device Initialization
> >>>> 3.1.1 Driver Requirements: Device Initialization
> >>>>
> >>>> [...]
> >>>>
> >>>> 7. Perform device-specific setup, including discovery of virtqueues for
> >>>>    the device, optional per-bus setup, reading and possibly writing the
> >>>>    device’s virtio configuration space, and population of virtqueues.
> >>>>
> >>>> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
> >>>
> >>> and
> >>>
> >>>> 4         Virtio Transport Options
> >>>> 4.1       Virtio Over PCI Bus
> >>>> 4.1.4     Virtio Structure PCI Capabilities
> >>>> 4.1.4.3   Common configuration structure layout
> >>>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
> >>>>
> >>>> [...]
> >>>>
> >>>> The driver MUST configure the other virtqueue fields before enabling the
> >>>> virtqueue with queue_enable.
> >>>>
> >>>> [...]
> >>>
> >>> These together mean that the following sub-sequence of steps is valid for
> >>> a virtio-1.0 guest driver:
> >>>
> >>> (1.1) set "queue_enable" for the needed queues as the final part of device
> >>> initialization step (7),
> >>>
> >>> (1.2) set DRIVER_OK in step (8),
> >>>
> >>> (1.3) immediately start sending virtio requests to the device.
> >>>
> >>> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
> >>> special virtio feature is negotiated, then virtio rings start in disabled
> >>> state, according to
> >>> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
> >>> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
> >>> enabling vrings.
> >>>
> >>> Therefore setting "queue_enable" from the guest (1.1) is a *control plane*
> >>> operation, which travels from the guest through QEMU to the vhost-user
> >>> backend, using a unix domain socket.
> >>>
> >>> Whereas sending a virtio request (1.3) is a *data plane* operation, which
> >>> evades QEMU -- it travels from guest to the vhost-user backend via
> >>> eventfd.
> >>>
> >>> This means that steps (1.1) and (1.3) travel through different channels,
> >>> and their relative order can be reversed, as perceived by the vhost-user
> >>> backend.
> >>>
> >>> That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
> >>> against the Rust-language virtiofsd version 1.7.2. (Which uses version
> >>> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
> >>> crate.)
> >>>
> >>> Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
> >>> device initialization steps (i.e., control plane operations), and
> >>> immediately sends a FUSE_INIT request too (i.e., performs a data plane
> >>> operation). In the Rust-language virtiofsd, this creates a race between
> >>> two components that run *concurrently*, i.e., in different threads or
> >>> processes:
> >>>
> >>> - Control plane, handling vhost-user protocol messages:
> >>>
> >>>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
> >>>   [crates/vhost-user-backend/src/handler.rs] handles
> >>>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
> >>>   flag according to the message processed.
> >>>
> >>> - Data plane, handling virtio / FUSE requests:
> >>>
> >>>   The "VringEpollHandler::handle_event" method
> >>>   [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
> >>>   virtio / FUSE request, consuming the virtio kick at the same time. If
> >>>   the vring's "enabled" flag is set, the virtio / FUSE request is
> >>>   processed genuinely. If the vring's "enabled" flag is clear, then the
> >>>   virtio / FUSE request is discarded.
> >>>
> >>> Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
> >>> However, if the data plane processor in virtiofsd wins the race, then it
> >>> sees the FUSE_INIT *before* the control plane processor took notice of
> >>> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
> >>> processor. Therefore the latter drops FUSE_INIT on the floor, and goes
> >>> back to waiting for further virtio / FUSE requests with epoll_wait.
> >>> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.
> >>>
> >>> The deadlock is not deterministic. OVMF hangs infrequently during first
> >>> boot. However, OVMF hangs almost certainly during reboots from the UEFI
> >>> shell.
> >>>
> >>> The race can be "reliably masked" by inserting a very small delay -- a
> >>> single debug message -- at the top of "VringEpollHandler::handle_event",
> >>> i.e., just before the data plane processor checks the "enabled" field of
> >>> the vring. That delay suffices for the control plane processor to act upon
> >>> VHOST_USER_SET_VRING_ENABLE.
> >>>
> >>> We can deterministically prevent the race in QEMU, by blocking OVMF inside
> >>> step (1.1) -- i.e., in the write to the "queue_enable" register -- until
> >>> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
> >>> cannot advance to the FUSE_INIT submission before virtiofsd's control
> >>> plane processor takes notice of the queue being enabled.
> >>>
> >>> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
> >>>
> >>> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
> >>>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
> >>>   has been negotiated, or
> >>>
> >>> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
> >>>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
> >>>
> >>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> >>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> >>> Cc: German Maglione <gmaglione@redhat.com>
> >>> Cc: Liu Jiang <gerry@linux.alibaba.com>
> >>> Cc: Sergio Lopez Pascual <slp@redhat.com>
> >>> Cc: Stefano Garzarella <sgarzare@redhat.com>
> >>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> >>
> >>
> >> So you want me to hold on to this patch 7/7 for now?
> >> And maybe merge rest of the patchset?
> > 
> > Up to Laszlo, but I wanted to mention that I support merging this
> > patch series. A ring has not been enabled/disabled until the back-end
> > replies, so I think this patch series makes sense.
> 
> Sorry, I didn't get to see this part of the discussion yesterday, and
> now I see that Michael has gone ahead with a PR that contains v2 of this
> set. The night before yesterday I posted v3
> <https://patchwork.ozlabs.org/project/qemu-devel/cover/20231002203221.17241-1-lersek@redhat.com/>,
> with commit message updates / improvements only (based on feedback), so
> please merge that one.
> 
> Thanks!
> Laszlo


OK. I'll need to do another PR soonish since a bunch of patchsets
which I wanted in this PR had issues and I had to drop them.
v3 will be there.

-- 
MST


