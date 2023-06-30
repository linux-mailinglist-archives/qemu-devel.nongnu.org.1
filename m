Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8368743E27
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:01:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFFcR-0007eF-Qx; Fri, 30 Jun 2023 11:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qFFc2-0007ap-1p
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:00:52 -0400
Received: from relay8-d.mail.gandi.net ([2001:4b98:dc4:8::228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qFFby-0004Jg-J5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:00:40 -0400
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3E2E1BF208;
 Fri, 30 Jun 2023 15:00:32 +0000 (UTC)
Message-ID: <460144ee-bf89-728f-f57f-4a4ec2be33d0@ovn.org>
Date: Fri, 30 Jun 2023 17:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: i.maximets@ovn.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
 <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
 <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
 <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
 <26c03cd4-5582-489c-9f4c-aeaf8e157b42@ovn.org>
 <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
 <df817423-9b06-0649-6d82-b8308b64bdc5@ovn.org>
 <CACGkMEtQumn9p13Li0DKr2AV-5O0VFvfe2FZdaLzETo+LKL9sQ@mail.gmail.com>
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
In-Reply-To: <CACGkMEtQumn9p13Li0DKr2AV-5O0VFvfe2FZdaLzETo+LKL9sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2001:4b98:dc4:8::228;
 envelope-from=i.maximets@ovn.org; helo=relay8-d.mail.gandi.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_NEUTRAL=0.779,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/30/23 09:44, Jason Wang wrote:
> On Wed, Jun 28, 2023 at 7:14 PM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 6/28/23 05:27, Jason Wang wrote:
>>> On Wed, Jun 28, 2023 at 6:45 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>
>>>> On 6/27/23 04:54, Jason Wang wrote:
>>>>> On Mon, Jun 26, 2023 at 9:17 PM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>
>>>>>> On 6/26/23 08:32, Jason Wang wrote:
>>>>>>> On Sun, Jun 25, 2023 at 3:06 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Fri, Jun 23, 2023 at 5:58 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>>>>>
>>>>>>>>> AF_XDP is a network socket family that allows communication directly
>>>>>>>>> with the network device driver in the kernel, bypassing most or all
>>>>>>>>> of the kernel networking stack.  In the essence, the technology is
>>>>>>>>> pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-native
>>>>>>>>> and works with any network interfaces without driver modifications.
>>>>>>>>> Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
>>>>>>>>> require access to character devices or unix sockets.  Only access to
>>>>>>>>> the network interface itself is necessary.
>>>>>>>>>
>>>>>>>>> This patch implements a network backend that communicates with the
>>>>>>>>> kernel by creating an AF_XDP socket.  A chunk of userspace memory
>>>>>>>>> is shared between QEMU and the host kernel.  4 ring buffers (Tx, Rx,
>>>>>>>>> Fill and Completion) are placed in that memory along with a pool of
>>>>>>>>> memory buffers for the packet data.  Data transmission is done by
>>>>>>>>> allocating one of the buffers, copying packet data into it and
>>>>>>>>> placing the pointer into Tx ring.  After transmission, device will
>>>>>>>>> return the buffer via Completion ring.  On Rx, device will take
>>>>>>>>> a buffer form a pre-populated Fill ring, write the packet data into
>>>>>>>>> it and place the buffer into Rx ring.
>>>>>>>>>
>>>>>>>>> AF_XDP network backend takes on the communication with the host
>>>>>>>>> kernel and the network interface and forwards packets to/from the
>>>>>>>>> peer device in QEMU.
>>>>>>>>>
>>>>>>>>> Usage example:
>>>>>>>>>
>>>>>>>>>   -device virtio-net-pci,netdev=guest1,mac=00:16:35:AF:AA:5C
>>>>>>>>>   -netdev af-xdp,ifname=ens6f1np1,id=guest1,mode=native,queues=1
>>>>>>>>>
>>>>>>>>> XDP program bridges the socket with a network interface.  It can be
>>>>>>>>> attached to the interface in 2 different modes:
>>>>>>>>>
>>>>>>>>> 1. skb - this mode should work for any interface and doesn't require
>>>>>>>>>          driver support.  With a caveat of lower performance.
>>>>>>>>>
>>>>>>>>> 2. native - this does require support from the driver and allows to
>>>>>>>>>             bypass skb allocation in the kernel and potentially use
>>>>>>>>>             zero-copy while getting packets in/out userspace.
>>>>>>>>>
>>>>>>>>> By default, QEMU will try to use native mode and fall back to skb.
>>>>>>>>> Mode can be forced via 'mode' option.  To force 'copy' even in native
>>>>>>>>> mode, use 'force-copy=on' option.  This might be useful if there is
>>>>>>>>> some issue with the driver.
>>>>>>>>>
>>>>>>>>> Option 'queues=N' allows to specify how many device queues should
>>>>>>>>> be open.  Note that all the queues that are not open are still
>>>>>>>>> functional and can receive traffic, but it will not be delivered to
>>>>>>>>> QEMU.  So, the number of device queues should generally match the
>>>>>>>>> QEMU configuration, unless the device is shared with something
>>>>>>>>> else and the traffic re-direction to appropriate queues is correctly
>>>>>>>>> configured on a device level (e.g. with ethtool -N).
>>>>>>>>> 'start-queue=M' option can be used to specify from which queue id
>>>>>>>>> QEMU should start configuring 'N' queues.  It might also be necessary
>>>>>>>>> to use this option with certain NICs, e.g. MLX5 NICs.  See the docs
>>>>>>>>> for examples.
>>>>>>>>>
>>>>>>>>> In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
>>>>>>>>> capabilities in order to load default XSK/XDP programs to the
>>>>>>>>> network interface and configure BTF maps.
>>>>>>>>
>>>>>>>> I think you mean "BPF" actually?
>>>>>>
>>>>>> "BPF Type Format maps" kind of makes some sense, but yes. :)
>>>>>>
>>>>>>>>
>>>>>>>>>  It is possible, however,
>>>>>>>>> to run only with CAP_NET_RAW.
>>>>>>>>
>>>>>>>> Qemu often runs without any privileges, so we need to fix it.
>>>>>>>>
>>>>>>>> I think adding support for SCM_RIGHTS via monitor would be a way to go.
>>>>>>
>>>>>> I looked through the code and it seems like we can run completely
>>>>>> non-privileged as far as kernel concerned.  We'll need an API
>>>>>> modification in libxdp though.
>>>>>>
>>>>>> The thing is, IIUC, the only syscall that requires CAP_NET_RAW is
>>>>>> a base socket creation.  Binding and other configuration doesn't
>>>>>> require any privileges.  So, we could create a socket externally
>>>>>> and pass it to QEMU.
>>>>>
>>>>> That's the way TAP works for example.
>>>>>
>>>>>>  Should work, unless it's an oversight from
>>>>>> the kernel side that needs to be patched. :)  libxdp doesn't have
>>>>>> a way to specify externally created socket today, so we'll need
>>>>>> to change that.  Should be easy to do though.  I can explore.
>>>>>
>>>>> Please do that.
>>>>
>>>> I have a prototype:
>>>>   https://github.com/igsilya/xdp-tools/commit/db73e90945e3aa5e451ac88c42c83cb9389642d3
>>>>
>>>> Need to test it out and then submit PR to xdp-tools project.

The change is now accepted:
  https://github.com/xdp-project/xdp-tools/commit/740c839806a02517da5bce7bd0ccaba908b3f675

I can update the QEMU patch with support for passing socket fds.  It may
look like this:

 -netved af-xdp,eth0,queues=2,inhibit=on,sock-fds=fd1,fd2

We'll need an fd per queue.  And we may require these fds to be already
added to the xsks map, so QEMU doesn't need xsks-map-fd.

I'd say we'll need to compile support for that conditionally based on
availability of xsk_umem__create_with_fd() as it may not be available
in distributions for some time.
Alternative is to require libxdp >= 1.4.0, which is not released yet.

The last restriction will be that QEMU will need 32 MB of RLIMIT_MEMLOCK
per queue for umem registration, but that should not be a huge deal, right?
Alternative is to have CAP_IPC_LOCK.


And I'd keep the xsks-map-fd parameter for setups that do not have latest
libxdp and can allow CAP_NET_RAW.  So, they could still do:

 -netdev af-xdp,eth0,queues=2,inhibit=on,xsks-map-fd=fd

What do you think?


>>>>
>>>>>
>>>>>>
>>>>>> In case the bind syscall will actually need CAP_NET_RAW for some
>>>>>> reason, we could change the kernel and allow non-privileged bind
>>>>>> by utilizing, e.g. SO_BINDTODEVICE.  i.e., let the privileged
>>>>>> process bind the socket to a particular device, so QEMU can't
>>>>>> bind it to a random one.  Might be a good use case to allow even
>>>>>> if not strictly necessary.
>>>>>
>>>>> Yes.
>>>>
>>>> Will propose something for a kernel as well.  We might want something
>>>> more granular though, e.g. bind to a queue instead of a device.  In
>>>> case we want better control in the device sharing scenario.
>>>
>>> I may miss something but the bind is already done at dev plus queue
>>> right now, isn't it?
>>
>>
>> Yes, the bind() syscall will bind socket to the dev+queue.  I was talking
>> about SO_BINDTODEVICE that only ties the socket to a particular device,
>> but not a queue.
>>
>> Assuming SO_BINDTODEVICE is implemented for AF_XDP sockets and
>> assuming a privileged process does:
>>
>>   fd = socket(AF_XDP, ...);
>>   setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, <device>);
>>
>> And sends fd to a non-privileged process.  That non-privileged process
>> will be able to call:
>>
>>   bind(fd, <device>, <random queue>);
>>
>> It will have to use the same device, but can choose any queue, if that
>> queue is not already busy with another socket.
>>
>> So, I was thinking maybe implementing something like XDP_BINDTOQID option.
>> This way the privileged process may call:
>>
>>   setsockopt(fd, SOL_XDP, XDP_BINDTOQID, <device>, <queue>);
>>
>> And later kernel will be able to refuse bind() for any other queue for
>> this particular socket.
> 
> Not sure, if file descriptor passing works, we probably don't need another way.
> 
>>
>> Not sure if that is necessary though.
>> Since we're allocating the socket in the privileged process, that process
>> may add the socket to the BPF map on the correct queue id.  This way the
>> non-privileged process will not be able to receive any packets from any
>> other queue on this socket, even if bound to it.  And no other AF_XDP
>> socket will be able to be bound to that other queue as well.
> 
> I think that's by design, or anything wrong with this model?

No, should be fine.  I'll posted a simple SO_BINDTODEVICE change to bpf-next
as an RFC for now since the tree is closed:
  https://lore.kernel.org/netdev/20230630145831.2988845-1-i.maximets@ovn.org/

Will re-send a non-RFC once it is open (after 10th of July, IIRC).

> 
>> So, the
>> rogue QEMU will be able to hog one extra queue, but it will not be able
>> to intercept traffic any from it, AFAICT.  May not be a huge problem
>> after all.
>>
>> SO_BINDTODEVICE would still be nice to have.  Especially for cases where
>> we give the whole device to one VM.
> 
> Then we need to use AF_XDP in the guest which seems to be a different
> topic. Alibaba is working on the AF_XDP support for virtio-net.
> 
> Thanks
> 
>>
>> Best regards, Ilya Maximets.
>>
> 


