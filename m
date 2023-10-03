Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 568207B6BE8
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:42:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngad-0001j6-4r; Tue, 03 Oct 2023 10:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qngaZ-0001iF-SW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qngaU-0000zx-Kl
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696344085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Ukgq7BfGKvmiAb1h1EQeoTLNqvwUUzsYFbXYYRdZFE=;
 b=S5r8WNpRrpw0i1NLcJpNJOCaqMCFpH5G7AueCE/UJwYxsYtK8WjEcv9cWmh4fnHglNGzcr
 53z25LpAOYhum4f0bSeWzHl5dB4+/qs8dWlBqUlfPK0KiH9p4l+7c+UbFN2rbEr1YUlPyd
 X5c5HkqZy5MIrhkqiQ8ZUkn1BR+koJk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-YrhY8itmN5yEUg5-_PsCXg-1; Tue, 03 Oct 2023 10:41:24 -0400
X-MC-Unique: YrhY8itmN5yEUg5-_PsCXg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so814215f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696344083; x=1696948883;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ukgq7BfGKvmiAb1h1EQeoTLNqvwUUzsYFbXYYRdZFE=;
 b=lBfEvCQ2oJt7xMt9goI2cFU4+zZJFS5ulBWEZc0n5Wn/WFwpfne/7kNnCOocytyDD+
 1nkN5rBJ2sWNK9iy28Yh0K4+CMa5YTYlFbneeIJznkvxlBr2eZjIPepITphIgFiK4gsI
 w/xPFuXRjuo5lLuF6LWcHhgyU5b0NMvMph73BW8VOGGc3Blr2OW39QKlYaz2HcwlM7bc
 ac4WBc3SbRgPifWSgC3/mmHEdTjbm87MmxULYpCh7oq9Qh9UjQkyLdND1EgStG2chb5W
 JTH29sxGZMeAQWxlFi5FTAwVxKchs0Na2JdQHJiM8DWaEvCGpHplIwsGnwO10P0h0uQH
 SIkQ==
X-Gm-Message-State: AOJu0YwqNJktpp5QEa0fU90PXeqBLgfLjv5DhvHhw5NVT+ao+3fGawJ1
 t9/gvpasusi98i0LERJJVPmAlBV8+W+a64zsUYmN4epJFgP8PqTnGJYTLYrSFljschhaqm7W7CR
 qMhYbTGamet0jaWxLdj7pFmQ=
X-Received: by 2002:a5d:45c9:0:b0:31f:f326:766b with SMTP id
 b9-20020a5d45c9000000b0031ff326766bmr12449287wrs.6.1696344082756; 
 Tue, 03 Oct 2023 07:41:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGkc9tkGOal62Mg8utiGr8xosGaBWFNYzIKEVRnNBpIleahCS4Sj13UzF8t8ueVwhX2UQ3qw==
X-Received: by 2002:a5d:45c9:0:b0:31f:f326:766b with SMTP id
 b9-20020a5d45c9000000b0031ff326766bmr12449275wrs.6.1696344082402; 
 Tue, 03 Oct 2023 07:41:22 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d4290000000b00325b29a6441sm1723351wrq.82.2023.10.03.07.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 07:41:21 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:41:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <20231003104045-mutt-send-email-mst@kernel.org>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230827182937.146450-8-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> >    device’s virtio configuration space, and population of virtqueues.
> >
> > 8. Set the DRIVER_OK status bit. At this point the device is “live”.
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
> > The driver MUST configure the other virtqueue fields before enabling the
> > virtqueue with queue_enable.
> >
> > [...]
> 
> These together mean that the following sub-sequence of steps is valid for
> a virtio-1.0 guest driver:
> 
> (1.1) set "queue_enable" for the needed queues as the final part of device
> initialization step (7),
> 
> (1.2) set DRIVER_OK in step (8),
> 
> (1.3) immediately start sending virtio requests to the device.
> 
> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
> special virtio feature is negotiated, then virtio rings start in disabled
> state, according to
> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
> enabling vrings.
> 
> Therefore setting "queue_enable" from the guest (1.1) is a *control plane*
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
> That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
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
>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
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
> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.
> 
> The deadlock is not deterministic. OVMF hangs infrequently during first
> boot. However, OVMF hangs almost certainly during reboots from the UEFI
> shell.
> 
> The race can be "reliably masked" by inserting a very small delay -- a
> single debug message -- at the top of "VringEpollHandler::handle_event",
> i.e., just before the data plane processor checks the "enabled" field of
> the vring. That delay suffices for the control plane processor to act upon
> VHOST_USER_SET_VRING_ENABLE.
> 
> We can deterministically prevent the race in QEMU, by blocking OVMF inside
> step (1.1) -- i.e., in the write to the "queue_enable" register -- until
> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
> cannot advance to the FUSE_INIT submission before virtiofsd's control
> plane processor takes notice of the queue being enabled.
> 
> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
> 
> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
>   has been negotiated, or
> 
> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
> Cc: Eugenio Perez Martin <eperezma@redhat.com>
> Cc: German Maglione <gmaglione@redhat.com>
> Cc: Liu Jiang <gerry@linux.alibaba.com>
> Cc: Sergio Lopez Pascual <slp@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>


So you want me to hold on to this patch 7/7 for now?
And maybe merge rest of the patchset?

> ---
>  hw/virtio/vhost-user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index beb4b832245e..01e0ca90c538 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>              .num   = enable,
>          };
>  
> -        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
> +        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
>          if (ret < 0) {
>              /*
>               * Restoring the previous state is likely infeasible, as well as


