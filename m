Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1F378D429
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGjr-00042O-VK; Wed, 30 Aug 2023 04:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGjq-00042E-8f
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qbGjn-0005Q4-Hy
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693384783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TVMzPZDkdEMTz6HcDBURkre4d2jrnQPEZedOEu5BRk=;
 b=Snc3YHtVA/LcMcVfoXhu4Ik7akIr1ZFSwQjY3kvQ4iHsTqd9vaEm7yQEGKabT3w0LR4y4l
 fuNZD5wma0HOMd8M0A+SaYRihQP/G1zqLRfM8SjK5TKUO+amm4WFRV6VvrEzuzjBukimHp
 koGw+aeN5pzT1gne/6KS5BZmTBE3YHc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-zldP_hiUPKuKZpsVe-OZsA-1; Wed, 30 Aug 2023 04:39:41 -0400
X-MC-Unique: zldP_hiUPKuKZpsVe-OZsA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51da39aa6dcso4205439a12.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 01:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693384780; x=1693989580;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4TVMzPZDkdEMTz6HcDBURkre4d2jrnQPEZedOEu5BRk=;
 b=EtPboFCvO/tzZi1y7k9XB3BJ0rVR6nQbSE95fxJ5DM2IU6uAFSGk7P1vZBgxqRWnfr
 YVNGJ5I8Y7fsf6/cuXQjSoc3ufs3+WAIi1JQhArP/2Ue0PSRcNBd4ugHDXVhTWa+MuQo
 VthcJtxCDCpOwXIjiUbsKiPyyfTC9SeA62ZJPEkoJ1sfFkanq5DGWuQO8/QjqL0xmdN4
 lcZB59iNJ1Wbw5DSY4c1qHkdQDRox2xr5WI0jLy46Wl2YhkhtQwKo6hi2v5cupBJB2vG
 LVc/sfS19El7nuFL2xrFVNqVcVIBnRbTGas0XL/4+RuHL54LixAleFlkV88/KbuzVPKm
 lGOw==
X-Gm-Message-State: AOJu0Yz7OvbRHBgRGPBItUl1jyiRS6ukNUj5KXGka440Zfm9SwL9piBT
 K72d8LMWAEti0i6jCJo4mqHTUS+gIXm2ZbNpNihL44d5C7igs/qqKI5wkOB3JrlfT4xjEBShdIy
 3GJLg2YdhwvCbHlDcYyaTB+M=
X-Received: by 2002:a17:907:7804:b0:9a5:c8ad:20c1 with SMTP id
 la4-20020a170907780400b009a5c8ad20c1mr1185650ejc.9.1693384780107; 
 Wed, 30 Aug 2023 01:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDL9gSg7p1xIVG+XOI6nBYf/9Uwhg/EDpRoPfte3h7FQjUTzF/jbPyUWpHiT4Us/cyhxp6w==
X-Received: by 2002:a17:907:7804:b0:9a5:c8ad:20c1 with SMTP id
 la4-20020a170907780400b009a5c8ad20c1mr1185634ejc.9.1693384779826; 
 Wed, 30 Aug 2023 01:39:39 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 i27-20020a1709063c5b00b009928b4e3b9fsm6906361ejg.114.2023.08.30.01.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 01:39:39 -0700 (PDT)
Date: Wed, 30 Aug 2023 10:39:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <wi7txoigehny6xw5owzz4gt6ayrmxfwryc7cbgzc2ndcqkdbxs@7cnl4po6gf2g>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230827182937.146450-8-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

On Sun, Aug 27, 2023 at 08:29:37PM +0200, Laszlo Ersek wrote:
>(1) The virtio-1.0 specification
><http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> writes:

What about referring the latest spec available now (1.2)?

>
>> 3     General Initialization And Device Operation
>> 3.1   Device Initialization
>> 3.1.1 Driver Requirements: Device Initialization
>>
>> [...]
>>
>> 7. Perform device-specific setup, including discovery of virtqueues for
>>    the device, optional per-bus setup, reading and possibly writing the
>>    device’s virtio configuration space, and population of virtqueues.
>>
>> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
>
>and
>
>> 4         Virtio Transport Options
>> 4.1       Virtio Over PCI Bus
>> 4.1.4     Virtio Structure PCI Capabilities
>> 4.1.4.3   Common configuration structure layout
>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>>
>> [...]
>>
>> The driver MUST configure the other virtqueue fields before enabling the
>> virtqueue with queue_enable.
>>
>> [...]
>
>These together mean that the following sub-sequence of steps is valid for
>a virtio-1.0 guest driver:
>
>(1.1) set "queue_enable" for the needed queues as the final part of device
>initialization step (7),
>
>(1.2) set DRIVER_OK in step (8),
>
>(1.3) immediately start sending virtio requests to the device.
>
>(2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
>special virtio feature is negotiated, then virtio rings start in disabled
>state, according to
><https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
>In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
>enabling vrings.
>
>Therefore setting "queue_enable" from the guest (1.1) is a *control plane*
>operation, which travels from the guest through QEMU to the vhost-user
>backend, using a unix domain socket.
>
>Whereas sending a virtio request (1.3) is a *data plane* operation, which
>evades QEMU -- it travels from guest to the vhost-user backend via
>eventfd.
>
>This means that steps (1.1) and (1.3) travel through different channels,
>and their relative order can be reversed, as perceived by the vhost-user
>backend.
>
>That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
>against the Rust-language virtiofsd version 1.7.2. (Which uses version
>0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
>crate.)
>
>Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
>device initialization steps (i.e., control plane operations), and
>immediately sends a FUSE_INIT request too (i.e., performs a data plane
>operation). In the Rust-language virtiofsd, this creates a race between
>two components that run *concurrently*, i.e., in different threads or
>processes:
>
>- Control plane, handling vhost-user protocol messages:
>
>  The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
>  [crates/vhost-user-backend/src/handler.rs] handles
>  VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
>  flag according to the message processed.
>
>- Data plane, handling virtio / FUSE requests:
>
>  The "VringEpollHandler::handle_event" method
>  [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
>  virtio / FUSE request, consuming the virtio kick at the same time. If
>  the vring's "enabled" flag is set, the virtio / FUSE request is
>  processed genuinely. If the vring's "enabled" flag is clear, then the
>  virtio / FUSE request is discarded.
>
>Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
>However, if the data plane processor in virtiofsd wins the race, then it
>sees the FUSE_INIT *before* the control plane processor took notice of
>VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
>processor. Therefore the latter drops FUSE_INIT on the floor, and goes
>back to waiting for further virtio / FUSE requests with epoll_wait.
>Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.
>
>The deadlock is not deterministic. OVMF hangs infrequently during first
>boot. However, OVMF hangs almost certainly during reboots from the UEFI
>shell.
>
>The race can be "reliably masked" by inserting a very small delay -- a
>single debug message -- at the top of "VringEpollHandler::handle_event",
>i.e., just before the data plane processor checks the "enabled" field of
>the vring. That delay suffices for the control plane processor to act upon
>VHOST_USER_SET_VRING_ENABLE.
>
>We can deterministically prevent the race in QEMU, by blocking OVMF inside
>step (1.1) -- i.e., in the write to the "queue_enable" register -- until
>VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
>cannot advance to the FUSE_INIT submission before virtiofsd's control
>plane processor takes notice of the queue being enabled.
>
>Wait for VHOST_USER_SET_VRING_ENABLE completion by:
>
>- setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
>  for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
>  has been negotiated, or
>
>- performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
>  a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.

Thanks for the excellent analysis (and fix of course!).

>
>Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>Cc: Eugenio Perez Martin <eperezma@redhat.com>
>Cc: German Maglione <gmaglione@redhat.com>
>Cc: Liu Jiang <gerry@linux.alibaba.com>
>Cc: Sergio Lopez Pascual <slp@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>---
> hw/virtio/vhost-user.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>index beb4b832245e..01e0ca90c538 100644
>--- a/hw/virtio/vhost-user.c
>+++ b/hw/virtio/vhost-user.c
>@@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>             .num   = enable,
>         };
>

How about adding a small comment here summarizing the commit message in
a few lines?

Should we cc stable for this fix?


In any case, the fix LGTM, so:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>-        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
>+        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
>         if (ret < 0) {
>             /*
>              * Restoring the previous state is likely infeasible, as well as


