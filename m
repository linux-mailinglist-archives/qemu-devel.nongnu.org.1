Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F17B7CE1
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 12:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyrK-0000Kw-4w; Wed, 04 Oct 2023 06:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnyrE-0000AU-S8
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnyr8-0003Xl-Rw
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 06:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696414310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0bn6WiEvtHuMrxowVTNVE2g/vSY4K/ScbjSI2aRe0E=;
 b=XyNg+BXmiEZCz4lOI6FO5yRJAUD+YsoNAcqzouKmOR2FinEQwufYupp5COFkxm4fFUgOLw
 yXlKu7gV/eX6KGX4xQvsaWBLviUXV6BepilpIunqIToB2DBsPNtaSyWCOQGxNbCDXfkbHb
 iklQCGLNrhjYa4D9gpg2VO+ON4Xjpwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-1oqOcKhFPvSHu-RuGnZI2Q-1; Wed, 04 Oct 2023 06:11:48 -0400
X-MC-Unique: 1oqOcKhFPvSHu-RuGnZI2Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 171A8185A78E;
 Wed,  4 Oct 2023 10:11:48 +0000 (UTC)
Received: from [10.39.195.2] (unknown [10.39.195.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AB92400E89;
 Wed,  4 Oct 2023 10:11:46 +0000 (UTC)
Message-ID: <d7c0aa1f-8158-1688-9ce3-d6b5b04d8ae5@redhat.com>
Date: Wed, 4 Oct 2023 12:11:44 +0200
MIME-Version: 1.0
Subject: Re: [PULL 30/63] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
 <c1ac504f912c8975a764290187bef9fa8bedb8e0.1696408966.git.mst@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <c1ac504f912c8975a764290187bef9fa8bedb8e0.1696408966.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
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

On 10/4/23 10:44, Michael S. Tsirkin wrote:
> From: Laszlo Ersek <lersek@redhat.com>
> 
> (1) The virtio-1.2 specification
> <http://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html> writes:
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
> and
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
> (The same statements are present in virtio-1.0 identically, at
> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html>.)
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
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> Message-Id: <20230830134055.106812-8-lersek@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index ae0734d461..eb983ae295 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1214,7 +1214,21 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>              .num   = enable,
>          };
>  
> -        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
> +        /*
> +         * SET_VRING_ENABLE travels from guest to QEMU to vhost-user backend /
> +         * control plane thread via unix domain socket. Virtio requests travel
> +         * from guest to vhost-user backend / data plane thread via eventfd.
> +         * Even if the guest enables the ring first, and pushes its first virtio
> +         * request second (conforming to the virtio spec), the data plane thread
> +         * in the backend may see the virtio request before the control plane
> +         * thread sees the queue enablement. This causes (in fact, requires) the
> +         * data plane thread to discard the virtio request (it arrived on a
> +         * seemingly disabled queue). To prevent this out-of-order delivery,
> +         * don't let the guest proceed to pushing the virtio request until the
> +         * backend control plane acknowledges enabling the queue -- IOW, pass
> +         * wait_for_reply=true below.
> +         */
> +        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
>          if (ret < 0) {
>              /*
>               * Restoring the previous state is likely infeasible, as well as

This is not the latest version (v3) of this set -- please see
<https://patchwork.ozlabs.org/project/qemu-devel/cover/20231002203221.17241-1-lersek@redhat.com/>.

Thanks,
Laszlo


