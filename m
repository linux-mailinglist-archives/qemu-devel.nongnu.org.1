Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB158797D62
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 22:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeLb2-0005zZ-Io; Thu, 07 Sep 2023 16:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qeLb0-0005zJ-93
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 16:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qeLax-0004ue-2i
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 16:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694118438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzt3zVnRPKaBESI1QQTnnLgYs+8rw+H3g8nx4+KAhT8=;
 b=edMQggnj87JAB05wyLpaxqW2gcefSdcuBjGcHH6GSf55K2nyES7+TvHdccWrG3Q5y/prpL
 R43BQ2xG2TMMcei3bHn0+yrqugLUDP8WuLiYd1F2xD9DMZq16QfjFG0Tbn0ApkVI/hp6cM
 Iqgd7EBoA7h924aT96m7BrkT4CPQp5w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-AoKFaRWRNZynWAyJsxF1lQ-1; Thu, 07 Sep 2023 16:27:16 -0400
X-MC-Unique: AoKFaRWRNZynWAyJsxF1lQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A4CD8E4EA0;
 Thu,  7 Sep 2023 20:27:16 +0000 (UTC)
Received: from [10.39.192.43] (unknown [10.39.192.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B4EA4060E1;
 Thu,  7 Sep 2023 20:27:13 +0000 (UTC)
Message-ID: <4f1b737e-09c8-8776-c4d7-a6dcd56e5819@redhat.com>
Date: Thu, 7 Sep 2023 22:27:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230830134055.106812-1-lersek@redhat.com>
 <20230830134055.106812-8-lersek@redhat.com>
 <CAJaqyWe9X_qneUA-ToiSVNEZ23+cjbqVrheOhOQ8mCWF8dfrLA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAJaqyWe9X_qneUA-ToiSVNEZ23+cjbqVrheOhOQ8mCWF8dfrLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On 9/7/23 17:59, Eugenio Perez Martin wrote:
> On Wed, Aug 30, 2023 at 3:41 PM Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> (1) The virtio-1.2 specification
>> <http://docs.oasis-open.org/virtio/virtio/v1.2/virtio-v1.2.html> writes:
>>
>>> 3     General Initialization And Device Operation
>>> 3.1   Device Initialization
>>> 3.1.1 Driver Requirements: Device Initialization
>>>
>>> [...]
>>>
>>> 7. Perform device-specific setup, including discovery of virtqueues for
>>>    the device, optional per-bus setup, reading and possibly writing the
>>>    device’s virtio configuration space, and population of virtqueues.
>>>
>>> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
>>
>> and
>>
>>> 4         Virtio Transport Options
>>> 4.1       Virtio Over PCI Bus
>>> 4.1.4     Virtio Structure PCI Capabilities
>>> 4.1.4.3   Common configuration structure layout
>>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>>>
>>> [...]
>>>
>>> The driver MUST configure the other virtqueue fields before enabling the
>>> virtqueue with queue_enable.
>>>
>>> [...]
>>
>> (The same statements are present in virtio-1.0 identically, at
>> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html>.)
>>
>> These together mean that the following sub-sequence of steps is valid for
>> a virtio-1.0 guest driver:
>>
>> (1.1) set "queue_enable" for the needed queues as the final part of device
>> initialization step (7),
>>
>> (1.2) set DRIVER_OK in step (8),
>>
>> (1.3) immediately start sending virtio requests to the device.
>>
>> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
>> special virtio feature is negotiated, then virtio rings start in disabled
>> state, according to
>> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
>> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
>> enabling vrings.
>>
>> Therefore setting "queue_enable" from the guest (1.1) is a *control plane*
>> operation, which travels from the guest through QEMU to the vhost-user
>> backend, using a unix domain socket.
>>
> 
> The code looks good to me, but this part of the message is not precise
> if I understood it correctly.
> 
> Guest PCI "queue_enable" writes remain in the qemu virtio device model
> until the guest writes DRIVER_OK to the status. I'm referring to
> hw/virtio/virtio-pci.c:virtio_pci_common_write, case
> VIRTIO_PCI_COMMON_Q_ENABLE. From there, virtio_queue_enable just saves
> the info in VirtIOPCIProxy.
> 
> After the needed queues are enabled, the guest writes DRIVER_OK status
> bit. Then, the vhost backend is started and qemu sends the
> VHOST_USER_SET_VRING_ENABLE through the unix socket. And that is the
> source of the message that is racing with the dataplane.

OK, so this means that 1.1 is "buffered" in QEMU until 1.2, but the race
between 1.2 and 1.3 is just the same.

I can reword the commit message to take this into account.

Thanks!
Laszlo

> 
> I didn't confirm it with virtiofs through tracing / debugging, so I
> may be missing something.
> 
> Even with the small nit, the code fixes the problem.
> 
> Acked-by: Eugenio Pérez <eperezma@redhat.com>
> 
>> Whereas sending a virtio request (1.3) is a *data plane* operation, which
>> evades QEMU -- it travels from guest to the vhost-user backend via
>> eventfd.
>>
>> This means that steps (1.1) and (1.3) travel through different channels,
>> and their relative order can be reversed, as perceived by the vhost-user
>> backend.
>>
>> That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
>> against the Rust-language virtiofsd version 1.7.2. (Which uses version
>> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
>> crate.)
>>
>> Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
>> device initialization steps (i.e., control plane operations), and
>> immediately sends a FUSE_INIT request too (i.e., performs a data plane
>> operation). In the Rust-language virtiofsd, this creates a race between
>> two components that run *concurrently*, i.e., in different threads or
>> processes:
>>
>> - Control plane, handling vhost-user protocol messages:
>>
>>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
>>   [crates/vhost-user-backend/src/handler.rs] handles
>>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
>>   flag according to the message processed.
>>
>> - Data plane, handling virtio / FUSE requests:
>>
>>   The "VringEpollHandler::handle_event" method
>>   [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
>>   virtio / FUSE request, consuming the virtio kick at the same time. If
>>   the vring's "enabled" flag is set, the virtio / FUSE request is
>>   processed genuinely. If the vring's "enabled" flag is clear, then the
>>   virtio / FUSE request is discarded.
>>
>> Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
>> However, if the data plane processor in virtiofsd wins the race, then it
>> sees the FUSE_INIT *before* the control plane processor took notice of
>> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
>> processor. Therefore the latter drops FUSE_INIT on the floor, and goes
>> back to waiting for further virtio / FUSE requests with epoll_wait.
>> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.
>>
>> The deadlock is not deterministic. OVMF hangs infrequently during first
>> boot. However, OVMF hangs almost certainly during reboots from the UEFI
>> shell.
>>
>> The race can be "reliably masked" by inserting a very small delay -- a
>> single debug message -- at the top of "VringEpollHandler::handle_event",
>> i.e., just before the data plane processor checks the "enabled" field of
>> the vring. That delay suffices for the control plane processor to act upon
>> VHOST_USER_SET_VRING_ENABLE.
>>
>> We can deterministically prevent the race in QEMU, by blocking OVMF inside
>> step (1.1) -- i.e., in the write to the "queue_enable" register -- until
>> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
>> cannot advance to the FUSE_INIT submission before virtiofsd's control
>> plane processor takes notice of the queue being enabled.
>>
>> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
>>
>> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
>>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
>>   has been negotiated, or
>>
>> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
>>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
>> Cc: German Maglione <gmaglione@redhat.com>
>> Cc: Liu Jiang <gerry@linux.alibaba.com>
>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> Notes:
>>     v2:
>>
>>     - pick up R-b from Stefano
>>
>>     - update virtio spec reference from 1.0 to 1.2 (also keep the 1.0 ref)
>>       in the commit message; re-check the quotes / section headers [Stefano]
>>
>>     - summarize commit message in code comment [Stefano]
>>
>>  hw/virtio/vhost-user.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 18e15a9bb359..41842eb023b5 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -1235,7 +1235,21 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>>              .num   = enable,
>>          };
>>
>> -        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
>> +        /*
>> +         * SET_VRING_ENABLE travels from guest to QEMU to vhost-user backend /
>> +         * control plane thread via unix domain socket. Virtio requests travel
>> +         * from guest to vhost-user backend / data plane thread via eventfd.
>> +         * Even if the guest enables the ring first, and pushes its first virtio
>> +         * request second (conforming to the virtio spec), the data plane thread
>> +         * in the backend may see the virtio request before the control plane
>> +         * thread sees the queue enablement. This causes (in fact, requires) the
>> +         * data plane thread to discard the virtio request (it arrived on a
>> +         * seemingly disabled queue). To prevent this out-of-order delivery,
>> +         * don't let the guest proceed to pushing the virtio request until the
>> +         * backend control plane acknowledges enabling the queue -- IOW, pass
>> +         * wait_for_reply=true below.
>> +         */
>> +        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
>>          if (ret < 0) {
>>              /*
>>               * Restoring the previous state is likely infeasible, as well as
> 


