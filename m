Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C88F279208D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 08:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdPaW-0001S2-D2; Tue, 05 Sep 2023 02:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qdPaM-0001RA-Nh
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qdPaI-0001RH-Pf
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693895445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkmogD3gAauft644MrTSJziKRmTuuI5T8pFi4/0M1us=;
 b=JGH1TKrWjm7tlf5KN4TxjmRWLwRIKy51Mx5A26oKI2ZNEnFwc1SXJl0Ho0HOkdKRuI6YE7
 Hc2xfODnqNqqQ7JSjmbFOgb6e5WeSZm/VoMnVpiIoyFkr+i8brWlwU3SPGEeAkGjrz3PLu
 8VmE48rHOOo8AHdUDW1y8Y8YUH07OR8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-k2V17qJGMf2Uq3Xqe9oDnQ-1; Tue, 05 Sep 2023 02:30:43 -0400
X-MC-Unique: k2V17qJGMf2Uq3Xqe9oDnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93A193820F08;
 Tue,  5 Sep 2023 06:30:43 +0000 (UTC)
Received: from [10.39.192.226] (unknown [10.39.192.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5A172026D4B;
 Tue,  5 Sep 2023 06:30:41 +0000 (UTC)
Message-ID: <90e566a6-2ac9-5adf-233c-085df81526c0@redhat.com>
Date: Tue, 5 Sep 2023 08:30:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
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

Michael,

On 8/30/23 17:37, Stefan Hajnoczi wrote:
> On Wed, 30 Aug 2023 at 09:30, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> On 8/30/23 14:10, Stefan Hajnoczi wrote:
>>> On Sun, 27 Aug 2023 at 14:31, Laszlo Ersek <lersek@redhat.com> wrote:
>>>>
>>>> (1) The virtio-1.0 specification
>>>> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> writes:
>>>>
>>>>> 3     General Initialization And Device Operation
>>>>> 3.1   Device Initialization
>>>>> 3.1.1 Driver Requirements: Device Initialization
>>>>>
>>>>> [...]
>>>>>
>>>>> 7. Perform device-specific setup, including discovery of virtqueues for
>>>>>    the device, optional per-bus setup, reading and possibly writing the
>>>>>    device’s virtio configuration space, and population of virtqueues.
>>>>>
>>>>> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
>>>>
>>>> and
>>>>
>>>>> 4         Virtio Transport Options
>>>>> 4.1       Virtio Over PCI Bus
>>>>> 4.1.4     Virtio Structure PCI Capabilities
>>>>> 4.1.4.3   Common configuration structure layout
>>>>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>>>>>
>>>>> [...]
>>>>>
>>>>> The driver MUST configure the other virtqueue fields before enabling the
>>>>> virtqueue with queue_enable.
>>>>>
>>>>> [...]
>>>>
>>>> These together mean that the following sub-sequence of steps is valid for
>>>> a virtio-1.0 guest driver:
>>>>
>>>> (1.1) set "queue_enable" for the needed queues as the final part of device
>>>> initialization step (7),
>>>>
>>>> (1.2) set DRIVER_OK in step (8),
>>>>
>>>> (1.3) immediately start sending virtio requests to the device.
>>>>
>>>> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
>>>> special virtio feature is negotiated, then virtio rings start in disabled
>>>> state, according to
>>>> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
>>>> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
>>>> enabling vrings.
>>>>
>>>> Therefore setting "queue_enable" from the guest (1.1) is a *control plane*
>>>> operation, which travels from the guest through QEMU to the vhost-user
>>>> backend, using a unix domain socket.
>>>>
>>>> Whereas sending a virtio request (1.3) is a *data plane* operation, which
>>>> evades QEMU -- it travels from guest to the vhost-user backend via
>>>> eventfd.
>>>>
>>>> This means that steps (1.1) and (1.3) travel through different channels,
>>>> and their relative order can be reversed, as perceived by the vhost-user
>>>> backend.
>>>>
>>>> That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
>>>> against the Rust-language virtiofsd version 1.7.2. (Which uses version
>>>> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
>>>> crate.)
>>>>
>>>> Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
>>>> device initialization steps (i.e., control plane operations), and
>>>> immediately sends a FUSE_INIT request too (i.e., performs a data plane
>>>> operation). In the Rust-language virtiofsd, this creates a race between
>>>> two components that run *concurrently*, i.e., in different threads or
>>>> processes:
>>>>
>>>> - Control plane, handling vhost-user protocol messages:
>>>>
>>>>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
>>>>   [crates/vhost-user-backend/src/handler.rs] handles
>>>>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
>>>>   flag according to the message processed.
>>>>
>>>> - Data plane, handling virtio / FUSE requests:
>>>>
>>>>   The "VringEpollHandler::handle_event" method
>>>>   [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
>>>>   virtio / FUSE request, consuming the virtio kick at the same time. If
>>>>   the vring's "enabled" flag is set, the virtio / FUSE request is
>>>>   processed genuinely. If the vring's "enabled" flag is clear, then the
>>>>   virtio / FUSE request is discarded.
>>>
>>> Why is virtiofsd monitoring the virtqueue and discarding requests
>>> while it's disabled?
>>
>> That's what the vhost-user spec requires:
>>
>> https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states
>>
>> """
>> started but disabled: the back-end must process the ring without causing
>> any side effects. For example, for a networking device, in the disabled
>> state the back-end must not supply any new RX packets, but must process
>> and discard any TX packets.
>> """
>>
>> This state is different from "stopped", where "the back-end must not
>> process the ring at all".
>>
>> The spec also says,
>>
>> """
>> If VHOST_USER_F_PROTOCOL_FEATURES has been negotiated, the ring is
>> initialized in a disabled state and is enabled by
>> VHOST_USER_SET_VRING_ENABLE with parameter 1.
>> """
>>
>> AFAICT virtiofsd follows this requirement.
> 
> Hi Michael,
> You documented the disabled ring state in QEMU commit commit
> c61f09ed855b5009f816242ce281fd01586d4646 ("vhost-user: clarify start
> and enable") where virtio-net devices discard tx buffers. The disabled
> state seems to be specific to vhost-user and not covered in the VIRTIO
> specification.
> 
> Do you remember what the purpose of the disabled state was? Why is it
> necessary to discard tx buffers instead of postponing ring processing
> until the virtqueue is enabled?
> 
> My concern is that the semantics are unclear for virtqueue types that
> are different from virtio-net rx/tx. Even the virtio-net controlq
> would be problematic - should buffers be silently discarded with
> VIRTIO_NET_OK or should they fail?

Can you comment please?

Thanks
Laszlo


>>> This seems like a bug in the vhost-user backend to me.
>>
>> I didn't want to exclude that possiblity; that's why I included Eugenio,
>> German, Liu Jiang, and Sergio in the CC list.
>>
>>>
>>> When the virtqueue is disabled, don't monitor the kickfd.
>>>
>>> When the virtqueue transitions from disabled to enabled, the control
>>> plane should self-trigger the kickfd so that any available buffers
>>> will be processed.
>>>
>>> QEMU uses this scheme to switch between vhost/IOThreads and built-in
>>> virtqueue kick processing.
>>>
>>> This approach is more robust than relying buffers being enqueued after
>>> the virtqueue is enabled.
>>
>> I'm happy to drop the series if the virtiofsd maintainers agree that the
>> bug is in virtiofsd, and can propose a design to fix it. (I do think
>> that such a fix would require an architectural change.)
>>
>> FWIW, my own interpretation of the vhost-user spec (see above) was that
>> virtiofsd was right to behave the way it did, and that there was simply
>> no way to prevent out-of-order delivery other than synchronizing the
>> guest end-to-end with the vhost-user backend, concerning
>> VHOST_USER_SET_VRING_ENABLE.
>>
>> This end-to-end synchronization is present "naturally" in vhost-net,
>> where ioctl()s are automatically synchronous -- in fact *all* operations
>> on the control plane are synchronous. (Which is just a different way to
>> say that the guest is tightly coupled with the control plane.)
>>
>> Note that there has been at least one race like this before; see commit
>> 699f2e535d93 ("vhost: make SET_VRING_ADDR, SET_FEATURES send replies",
>> 2021-09-04). Basically every pre-existent call to enforce_reply() is a
>> cover-up for the vhost-user spec turning (somewhat recklessly?) most
>> operations into async ones.
>>
>> At some point this became apparent and so the REPLY_ACK flag was
>> introduced; see commit ca525ce5618b ("vhost-user: Introduce a new
>> protocol feature REPLY_ACK.", 2016-08-10). (That commit doesn't go into
>> details, but I'm pretty sure there was a similar race around SET_MEM_TABLE!)
>>
>> BTW even if we drop this series for QEMU, I don't think it will have
>> been in vain. The first few patches are cleanups which could be merged
>> for their own sake. And the last patch is essentially the proof of the
>> problem statement / analysis. It can be considered an elaborate bug
>> report for virtiofsd, *if* we decide the bug is in virtiofsd. I did have
>> that avenue in mind as well, when writing the commit message / patch.
>>
>> For now I'm going to post v2 -- that's not to say that I'm dismissing
>> your feedback (see above!), just want to get the latest version on-list.
>>
>> Thanks!
>> Laszlo
>>
>>>
>>> Stefan
>>>
>>>>
>>>> Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
>>>> However, if the data plane processor in virtiofsd wins the race, then it
>>>> sees the FUSE_INIT *before* the control plane processor took notice of
>>>> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
>>>> processor. Therefore the latter drops FUSE_INIT on the floor, and goes
>>>> back to waiting for further virtio / FUSE requests with epoll_wait.
>>>> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.
>>>>
>>>> The deadlock is not deterministic. OVMF hangs infrequently during first
>>>> boot. However, OVMF hangs almost certainly during reboots from the UEFI
>>>> shell.
>>>>
>>>> The race can be "reliably masked" by inserting a very small delay -- a
>>>> single debug message -- at the top of "VringEpollHandler::handle_event",
>>>> i.e., just before the data plane processor checks the "enabled" field of
>>>> the vring. That delay suffices for the control plane processor to act upon
>>>> VHOST_USER_SET_VRING_ENABLE.
>>>>
>>>> We can deterministically prevent the race in QEMU, by blocking OVMF inside
>>>> step (1.1) -- i.e., in the write to the "queue_enable" register -- until
>>>> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
>>>> cannot advance to the FUSE_INIT submission before virtiofsd's control
>>>> plane processor takes notice of the queue being enabled.
>>>>
>>>> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
>>>>
>>>> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
>>>>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
>>>>   has been negotiated, or
>>>>
>>>> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
>>>>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
>>>>
>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>>>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
>>>> Cc: German Maglione <gmaglione@redhat.com>
>>>> Cc: Liu Jiang <gerry@linux.alibaba.com>
>>>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>>>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>>> ---
>>>>  hw/virtio/vhost-user.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>>> index beb4b832245e..01e0ca90c538 100644
>>>> --- a/hw/virtio/vhost-user.c
>>>> +++ b/hw/virtio/vhost-user.c
>>>> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>>>>              .num   = enable,
>>>>          };
>>>>
>>>> -        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
>>>> +        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
>>>>          if (ret < 0) {
>>>>              /*
>>>>               * Restoring the previous state is likely infeasible, as well as
>>>
>>
> 


