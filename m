Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B61387D221F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUfo-0001hK-Vl; Sun, 22 Oct 2023 05:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUfi-0001b5-MP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUff-0000GC-84
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySJRsoNBBcgqyKONkpVDvYCkflnLmxrOPirjci4NdfM=;
 b=TOX3SVC+QOxR5I8HE/vfhtHysK/O5bGq0YAMGAue8eCSBE5DPGgNWeAlYBGQIYqgufILAu
 r/4lqO4wG7B6qralDZBK1uOGDTdGhL7Hyf1lL4yroxRNrPp6iDDD4ueYHkllgG+aO4n/9N
 io2uVGlb68+Rm+wS1g0PyXaSE1x69Ik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-diWT7_bhPn6LGWJHl0NznA-1; Sun, 22 Oct 2023 05:22:51 -0400
X-MC-Unique: diWT7_bhPn6LGWJHl0NznA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so1134120f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966569; x=1698571369;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ySJRsoNBBcgqyKONkpVDvYCkflnLmxrOPirjci4NdfM=;
 b=N6yt/lnrOQl6buaRop0F8kTrzl//Its92j7vLf0fof5ahvGnQxClBTH0kbqxE/9Xq7
 rDeYfufPmtmWsrp93IV1Zge8LpSZAeFz1di/8w2zofhl/IUuDCkfi30OWNMQkwSg9xZP
 JgTOOfSzGz+hXRVVYgC3DQYY5UZWjfyynEwhDQaThsPLBhatXJ9HhThFklbqLcANqiYd
 Sg7t1QISgL66zvox+ii+6erKRVkm5K9gg7F+O7Wt0d9U3v7aE6D6U4ID5B3FMbcja5k2
 eP/CDHdYrmB+tz7dQWmgqbFUzBI4js1aFBRkweieQsIU7uV8meE6nbs7VJCq4iFcOqk0
 773Q==
X-Gm-Message-State: AOJu0YxxTB+MeVQjISpUWmHNTObBiRzKRA5/bw6y4cBvNFxnFchf8j+L
 rRbW9WMFZJdgxgZ/g8YkEhMFOp+JAZa0IcBC7ARbCCc9gsX/QGShTygH4EB70SSQP3yQ7QL/LRe
 VNIFsLQeKA1G8iaS6CEwYq0IAFFxGG0QR3SkbfVUW9+dg8QmCQi5o7qJChWthj8cYtaiV
X-Received: by 2002:adf:b346:0:b0:32d:cb21:4e99 with SMTP id
 k6-20020adfb346000000b0032dcb214e99mr8337509wrd.13.1697966569408; 
 Sun, 22 Oct 2023 02:22:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5lKvmfRR8knKYSSJQjtYGRBvoOltrKKbiKVXLLbsoaJVjyzUzpi/SGoU6QGVZczFD13itww==
X-Received: by 2002:adf:b346:0:b0:32d:cb21:4e99 with SMTP id
 k6-20020adfb346000000b0032dcb214e99mr8337493wrd.13.1697966569084; 
 Sun, 22 Oct 2023 02:22:49 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 c16-20020a05600c0ad000b004063c9f68f2sm6464206wmr.26.2023.10.22.02.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:22:48 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:22:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
Subject: [PULL v3 14/62] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Message-ID: <d7dc0682f5cb549ea9afdc418f95412e83cc5e8c.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Laszlo Ersek <lersek@redhat.com>

(1) The virtio-1.2 specification
<http://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html> writes:

> 3     General Initialization And Device Operation
> 3.1   Device Initialization
> 3.1.1 Driver Requirements: Device Initialization
>
> [...]
>
> 7. Perform device-specific setup, including discovery of virtqueues for
>    the device, optional per-bus setup, reading and possibly writing the
>    device’s virtio configuration space, and population of virtqueues.
>
> 8. Set the DRIVER_OK status bit. At this point the device is “live”.

and

> 4         Virtio Transport Options
> 4.1       Virtio Over PCI Bus
> 4.1.4     Virtio Structure PCI Capabilities
> 4.1.4.3   Common configuration structure layout
> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>
> [...]
>
> The driver MUST configure the other virtqueue fields before enabling the
> virtqueue with queue_enable.
>
> [...]

(The same statements are present in virtio-1.0 identically, at
<http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html>.)

These together mean that the following sub-sequence of steps is valid for
a virtio-1.0 guest driver:

(1.1) set "queue_enable" for the needed queues as the final part of device
initialization step (7),

(1.2) set DRIVER_OK in step (8),

(1.3) immediately start sending virtio requests to the device.

(2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
special virtio feature is negotiated, then virtio rings start in disabled
state, according to
<https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
enabling vrings.

Therefore setting "queue_enable" from the guest (1.1) -- which is
technically "buffered" on the QEMU side until the guest sets DRIVER_OK
(1.2) -- is a *control plane* operation, which -- after (1.2) -- travels
from the guest through QEMU to the vhost-user backend, using a unix domain
socket.

Whereas sending a virtio request (1.3) is a *data plane* operation, which
evades QEMU -- it travels from guest to the vhost-user backend via
eventfd.

This means that operations ((1.1) + (1.2)) and (1.3) travel through
different channels, and their relative order can be reversed, as perceived
by the vhost-user backend.

That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
against the Rust-language virtiofsd version 1.7.2. (Which uses version
0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
crate.)

Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
device initialization steps (i.e., control plane operations), and
immediately sends a FUSE_INIT request too (i.e., performs a data plane
operation). In the Rust-language virtiofsd, this creates a race between
two components that run *concurrently*, i.e., in different threads or
processes:

- Control plane, handling vhost-user protocol messages:

  The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
  [crates/vhost-user-backend/src/handler.rs] handles
  VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
  flag according to the message processed.

- Data plane, handling virtio / FUSE requests:

  The "VringEpollHandler::handle_event" method
  [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
  virtio / FUSE request, consuming the virtio kick at the same time. If
  the vring's "enabled" flag is set, the virtio / FUSE request is
  processed genuinely. If the vring's "enabled" flag is clear, then the
  virtio / FUSE request is discarded.

Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
However, if the data plane processor in virtiofsd wins the race, then it
sees the FUSE_INIT *before* the control plane processor took notice of
VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
processor. Therefore the latter drops FUSE_INIT on the floor, and goes
back to waiting for further virtio / FUSE requests with epoll_wait.
Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.

The deadlock is not deterministic. OVMF hangs infrequently during first
boot. However, OVMF hangs almost certainly during reboots from the UEFI
shell.

The race can be "reliably masked" by inserting a very small delay -- a
single debug message -- at the top of "VringEpollHandler::handle_event",
i.e., just before the data plane processor checks the "enabled" field of
the vring. That delay suffices for the control plane processor to act upon
VHOST_USER_SET_VRING_ENABLE.

We can deterministically prevent the race in QEMU, by blocking OVMF inside
step (1.2) -- i.e., in the write to the device status register that
"unleashes" queue enablement -- until VHOST_USER_SET_VRING_ENABLE actually
*completes*. That way OVMF's VCPU cannot advance to the FUSE_INIT
submission before virtiofsd's control plane processor takes notice of the
queue being enabled.

Wait for VHOST_USER_SET_VRING_ENABLE completion by:

- setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
  for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
  has been negotiated, or

- performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
  a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
Cc: Eugenio Perez Martin <eperezma@redhat.com>
Cc: German Maglione <gmaglione@redhat.com>
Cc: Liu Jiang <gerry@linux.alibaba.com>
Cc: Sergio Lopez Pascual <slp@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Albert Esteve <aesteve@redhat.com>
[lersek@redhat.com: work Eugenio's explanation into the commit message,
 about QEMU containing step (1.1) until step (1.2)]
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231002203221.17241-8-lersek@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 7e452849fa..427ee0ebfb 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1225,7 +1225,21 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
             .num   = enable,
         };
 
-        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
+        /*
+         * SET_VRING_ENABLE travels from guest to QEMU to vhost-user backend /
+         * control plane thread via unix domain socket. Virtio requests travel
+         * from guest to vhost-user backend / data plane thread via eventfd.
+         * Even if the guest enables the ring first, and pushes its first virtio
+         * request second (conforming to the virtio spec), the data plane thread
+         * in the backend may see the virtio request before the control plane
+         * thread sees the queue enablement. This causes (in fact, requires) the
+         * data plane thread to discard the virtio request (it arrived on a
+         * seemingly disabled queue). To prevent this out-of-order delivery,
+         * don't let the guest proceed to pushing the virtio request until the
+         * backend control plane acknowledges enabling the queue -- IOW, pass
+         * wait_for_reply=true below.
+         */
+        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
         if (ret < 0) {
             /*
              * Restoring the previous state is likely infeasible, as well as
-- 
MST


