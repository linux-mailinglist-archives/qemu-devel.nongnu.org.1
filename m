Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 813BC78D478
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbH88-0000oY-9R; Wed, 30 Aug 2023 05:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbH86-0000oO-7a
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qbH81-0002Tz-V7
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693386284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+0x7Cu4EiSy/S26LHid/h6/ndl96DjhC2WXDSK1enPI=;
 b=U0Nz9cGlp68BcsZJYwJ1gGD4taDbIqRAhCkrUmCBr+VLIZYfbVXAik1Oqnf1Ro40OjRpfx
 ucM6DcL9VZSCu1BOohBSvQvmOBlztMSxHmDJZd3cEEIsjRy3m1OT4/0q5TRRSenfpC4S8S
 /y5Wv2OsbRc8CpfziOTof6oz+r6KEUI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-aRVWwIjxPb6cIYrnJ_hZQA-1; Wed, 30 Aug 2023 05:04:43 -0400
X-MC-Unique: aRVWwIjxPb6cIYrnJ_hZQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B7F53C0C4B0;
 Wed, 30 Aug 2023 09:04:43 +0000 (UTC)
Received: from [10.39.192.65] (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A11DD63F6C;
 Wed, 30 Aug 2023 09:04:41 +0000 (UTC)
Message-ID: <84f296ef-2819-7da3-2578-817926494555@redhat.com>
Date: Wed, 30 Aug 2023 11:04:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
Content-Language: en-US
From: Laszlo Ersek <lersek@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Liu Jiang <gerry@linux.alibaba.com>,
 Sergio Lopez Pascual <slp@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <b24315a1-906d-f3af-02e5-e6788765639c@redhat.com>
 <ed6da820-91c2-3546-0cd3-359c90d99347@redhat.com>
In-Reply-To: <ed6da820-91c2-3546-0cd3-359c90d99347@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

On 8/30/23 10:59, Laszlo Ersek wrote:
> On 8/30/23 10:41, Laszlo Ersek wrote:
>> I'm adding Stefan to the CC list, and an additional piece of explanation
>> below:
>>
>> On 8/27/23 20:29, Laszlo Ersek wrote:
>>> (1) The virtio-1.0 specification
>>> <http://docs.oasis-open.org/virtio/virtio/v1.0/virtio-v1.0.html> writes:
>>>
>>>> 3     General Initialization And Device Operation
>>>> 3.1   Device Initialization
>>>> 3.1.1 Driver Requirements: Device Initialization
>>>>
>>>> [...]
>>>>
>>>> 7. Perform device-specific setup, including discovery of virtqueues for
>>>>    the device, optional per-bus setup, reading and possibly writing the
>>>>    device’s virtio configuration space, and population of virtqueues.
>>>>
>>>> 8. Set the DRIVER_OK status bit. At this point the device is “live”.
>>>
>>> and
>>>
>>>> 4         Virtio Transport Options
>>>> 4.1       Virtio Over PCI Bus
>>>> 4.1.4     Virtio Structure PCI Capabilities
>>>> 4.1.4.3   Common configuration structure layout
>>>> 4.1.4.3.2 Driver Requirements: Common configuration structure layout
>>>>
>>>> [...]
>>>>
>>>> The driver MUST configure the other virtqueue fields before enabling the
>>>> virtqueue with queue_enable.
>>>>
>>>> [...]
>>>
>>> These together mean that the following sub-sequence of steps is valid for
>>> a virtio-1.0 guest driver:
>>>
>>> (1.1) set "queue_enable" for the needed queues as the final part of device
>>> initialization step (7),
>>>
>>> (1.2) set DRIVER_OK in step (8),
>>>
>>> (1.3) immediately start sending virtio requests to the device.
>>>
>>> (2) When vhost-user is enabled, and the VHOST_USER_F_PROTOCOL_FEATURES
>>> special virtio feature is negotiated, then virtio rings start in disabled
>>> state, according to
>>> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#ring-states>.
>>> In this case, explicit VHOST_USER_SET_VRING_ENABLE messages are needed for
>>> enabling vrings.
>>>
>>> Therefore setting "queue_enable" from the guest (1.1) is a *control plane*
>>> operation, which travels from the guest through QEMU to the vhost-user
>>> backend, using a unix domain socket.
>>>
>>> Whereas sending a virtio request (1.3) is a *data plane* operation, which
>>> evades QEMU -- it travels from guest to the vhost-user backend via
>>> eventfd.
>>>
>>> This means that steps (1.1) and (1.3) travel through different channels,
>>> and their relative order can be reversed, as perceived by the vhost-user
>>> backend.
>>>
>>> That's exactly what happens when OVMF's virtiofs driver (VirtioFsDxe) runs
>>> against the Rust-language virtiofsd version 1.7.2. (Which uses version
>>> 0.10.1 of the vhost-user-backend crate, and version 0.8.1 of the vhost
>>> crate.)
>>>
>>> Namely, when VirtioFsDxe binds a virtiofs device, it goes through the
>>> device initialization steps (i.e., control plane operations), and
>>> immediately sends a FUSE_INIT request too (i.e., performs a data plane
>>> operation). In the Rust-language virtiofsd, this creates a race between
>>> two components that run *concurrently*, i.e., in different threads or
>>> processes:
>>>
>>> - Control plane, handling vhost-user protocol messages:
>>>
>>>   The "VhostUserSlaveReqHandlerMut::set_vring_enable" method
>>>   [crates/vhost-user-backend/src/handler.rs] handles
>>>   VHOST_USER_SET_VRING_ENABLE messages, and updates each vring's "enabled"
>>>   flag according to the message processed.
>>>
>>> - Data plane, handling virtio / FUSE requests:
>>>
>>>   The "VringEpollHandler::handle_event" method
>>>   [crates/vhost-user-backend/src/event_loop.rs] handles the incoming
>>>   virtio / FUSE request, consuming the virtio kick at the same time. If
>>>   the vring's "enabled" flag is set, the virtio / FUSE request is
>>>   processed genuinely. If the vring's "enabled" flag is clear, then the
>>>   virtio / FUSE request is discarded.
>>>
>>> Note that OVMF enables the queue *first*, and sends FUSE_INIT *second*.
>>> However, if the data plane processor in virtiofsd wins the race, then it
>>> sees the FUSE_INIT *before* the control plane processor took notice of
>>> VHOST_USER_SET_VRING_ENABLE and green-lit the queue for the data plane
>>> processor. Therefore the latter drops FUSE_INIT on the floor, and goes
>>> back to waiting for further virtio / FUSE requests with epoll_wait.
>>> Meanwhile OVMF is stuck waiting for the FUSET_INIT response -- a deadlock.
>>
>> I can explain why this issue has not been triggered by / witnessed with
>> the Linux guest driver for virtiofs ("fs/fuse/virtio_fs.c").
>>
>> That driver registers *two* driver (callback) structures, a virtio
>> driver, and a filesystem driver.
>>
>> (1) The virtio driver half initializes the virtio device, and takes a
>> note of the particular virtio filesystem, remembering its "tag". See
>> virtio_fs_probe() -> virtio_device_ready(), and then virtio_fs_probe()
>> -> virtio_fs_add_instance().
>>
>> Importantly, at this time, no FUSE_INIT request is sent.
>>
>> (2) The filesystem driver half has a totally independent entry point.
>> The relevant parts (after the driver registration) are:
>>
>> (a) virtio_fs_get_tree() -> virtio_fs_find_instance(), and
>>
>> (b) if the "tag" was found, (b) virtio_fs_get_tree() ->
>> virtio_fs_fill_super() -> fuse_send_init().
>>
>> Importantly, this occurs when guest userspace (i.e., an interactive
>> user, or a userspace automatism such as systemd) tries to mount a
>> *concrete* virtio filesystem, identified by its tag (such as in "mount
>> -t virtiofs TAG /mount/point").
>>
>>
>> This means that there is an *abritrarily long* delay between (1)
>> VHOST_USER_SET_VRING_ENABLE (which QEMU sends to virtiofsd while the
>> guest is inside virtio_fs_probe()) and (2) FUSE_INIT (which the guest
>> kernel driver sends to virtiofsd while inside virtio_fs_get_tree()).
>>
>> That huge delay is plenty for masking the race.
>>
>> But the race is there nonetheless.
> 
> Furthermore, the race was not seen in the C-language virtiofsd
> implementation (removed in QEMU commit
> e0dc2631ec4ac718ebe22ddea0ab25524eb37b0e) for the following reason:
> 
> The C language virtiofsd *did not care* about
> VHOST_USER_SET_VRING_ENABLE at all:
> 
> - Upon VHOST_USER_GET_VRING_BASE, vu_get_vring_base_exec() in
> libvhost-user would call fv_queue_set_started() in virtiofsd, and the
> latter would start the data plane thread fv_queue_thread().

Sorry, not on VHOST_USER_GET_VRING_BASE, but on
VHOST_USER_SET_VRING_KICK / VHOST_USER_VRING_KICK. But that doesn't
change the rest of the argument, namely that VHOST_USER_SET_VRING_ENABLE
had no effect whatsoever on the C-language virtiofsd.

Laszlo

> 
> - Upon VHOST_USER_SET_VRING_ENABLE, vu_set_vring_enable_exec() in
> libvhost-user would set the "enable" field, but not call back into
> virtiofsd. And virtiofsd ("tools/virtiofsd/fuse_virtio.c") nowhere
> checks the "enable" field.
> 
> In summary, the C-language virtiofsd didn't implement queue enablement
> in a conformant way. The Rust-language version does, but that exposes a
> race in how QEMU sends VHOST_USER_SET_VRING_ENABLE. The race is
> triggered by the OVMF guest driver, and not triggered by the Linux guest
> driver (since the latter introduces an unbounded delay between vring
> enablement and FUSE_INIT submission).
> 
> Laszlo
> 
>>
>>
>> Also note that this race does not exist for vhost-net. For vhost-net,
>> AIUI, such queue operations are handled with ioctl()s, and ioctl()s are
>> synchronous by nature. Cf.
>> <https://qemu-project.gitlab.io/qemu/interop/vhost-user.html#vhost-user-protocol-f-reply-ack>:
>>
>> "The original vhost-user specification only demands replies for certain
>> commands. This differs from the vhost protocol implementation where
>> commands are sent over an ioctl() call and block until the back-end has
>> completed."
>>
>> Laszlo
>>
>>>
>>> The deadlock is not deterministic. OVMF hangs infrequently during first
>>> boot. However, OVMF hangs almost certainly during reboots from the UEFI
>>> shell.
>>>
>>> The race can be "reliably masked" by inserting a very small delay -- a
>>> single debug message -- at the top of "VringEpollHandler::handle_event",
>>> i.e., just before the data plane processor checks the "enabled" field of
>>> the vring. That delay suffices for the control plane processor to act upon
>>> VHOST_USER_SET_VRING_ENABLE.
>>>
>>> We can deterministically prevent the race in QEMU, by blocking OVMF inside
>>> step (1.1) -- i.e., in the write to the "queue_enable" register -- until
>>> VHOST_USER_SET_VRING_ENABLE actually *completes*. That way OVMF's VCPU
>>> cannot advance to the FUSE_INIT submission before virtiofsd's control
>>> plane processor takes notice of the queue being enabled.
>>>
>>> Wait for VHOST_USER_SET_VRING_ENABLE completion by:
>>>
>>> - setting the NEED_REPLY flag on VHOST_USER_SET_VRING_ENABLE, and waiting
>>>   for the reply, if the VHOST_USER_PROTOCOL_F_REPLY_ACK vhost-user feature
>>>   has been negotiated, or
>>>
>>> - performing a separate VHOST_USER_GET_FEATURES *exchange*, which requires
>>>   a backend response regardless of VHOST_USER_PROTOCOL_F_REPLY_ACK.
>>>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:vhost)
>>> Cc: Eugenio Perez Martin <eperezma@redhat.com>
>>> Cc: German Maglione <gmaglione@redhat.com>
>>> Cc: Liu Jiang <gerry@linux.alibaba.com>
>>> Cc: Sergio Lopez Pascual <slp@redhat.com>
>>> Cc: Stefano Garzarella <sgarzare@redhat.com>
>>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>>> ---
>>>  hw/virtio/vhost-user.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>>> index beb4b832245e..01e0ca90c538 100644
>>> --- a/hw/virtio/vhost-user.c
>>> +++ b/hw/virtio/vhost-user.c
>>> @@ -1235,7 +1235,7 @@ static int vhost_user_set_vring_enable(struct vhost_dev *dev, int enable)
>>>              .num   = enable,
>>>          };
>>>  
>>> -        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, false);
>>> +        ret = vhost_set_vring(dev, VHOST_USER_SET_VRING_ENABLE, &state, true);
>>>          if (ret < 0) {
>>>              /*
>>>               * Restoring the previous state is likely infeasible, as well as
>>
> 


