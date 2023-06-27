Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4DF74069C
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 00:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEHRG-0006GK-7V; Tue, 27 Jun 2023 18:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qEHRD-0006G6-KN
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 18:45:31 -0400
Received: from relay5-d.mail.gandi.net ([2001:4b98:dc4:8::225])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qEHRA-0003Sn-Ni
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 18:45:31 -0400
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
X-GND-Sasl: i.maximets@ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62A7B1C0002;
 Tue, 27 Jun 2023 22:45:22 +0000 (UTC)
Message-ID: <26c03cd4-5582-489c-9f4c-aeaf8e157b42@ovn.org>
Date: Wed, 28 Jun 2023 00:46:11 +0200
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
From: Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
In-Reply-To: <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2001:4b98:dc4:8::225;
 envelope-from=i.maximets@ovn.org; helo=relay5-d.mail.gandi.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.103,
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

On 6/27/23 04:54, Jason Wang wrote:
> On Mon, Jun 26, 2023 at 9:17 PM Ilya Maximets <i.maximets@ovn.org> wrote:
>>
>> On 6/26/23 08:32, Jason Wang wrote:
>>> On Sun, Jun 25, 2023 at 3:06 PM Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>> On Fri, Jun 23, 2023 at 5:58 AM Ilya Maximets <i.maximets@ovn.org> wrote:
>>>>>
>>>>> AF_XDP is a network socket family that allows communication directly
>>>>> with the network device driver in the kernel, bypassing most or all
>>>>> of the kernel networking stack.  In the essence, the technology is
>>>>> pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-native
>>>>> and works with any network interfaces without driver modifications.
>>>>> Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
>>>>> require access to character devices or unix sockets.  Only access to
>>>>> the network interface itself is necessary.
>>>>>
>>>>> This patch implements a network backend that communicates with the
>>>>> kernel by creating an AF_XDP socket.  A chunk of userspace memory
>>>>> is shared between QEMU and the host kernel.  4 ring buffers (Tx, Rx,
>>>>> Fill and Completion) are placed in that memory along with a pool of
>>>>> memory buffers for the packet data.  Data transmission is done by
>>>>> allocating one of the buffers, copying packet data into it and
>>>>> placing the pointer into Tx ring.  After transmission, device will
>>>>> return the buffer via Completion ring.  On Rx, device will take
>>>>> a buffer form a pre-populated Fill ring, write the packet data into
>>>>> it and place the buffer into Rx ring.
>>>>>
>>>>> AF_XDP network backend takes on the communication with the host
>>>>> kernel and the network interface and forwards packets to/from the
>>>>> peer device in QEMU.
>>>>>
>>>>> Usage example:
>>>>>
>>>>>   -device virtio-net-pci,netdev=guest1,mac=00:16:35:AF:AA:5C
>>>>>   -netdev af-xdp,ifname=ens6f1np1,id=guest1,mode=native,queues=1
>>>>>
>>>>> XDP program bridges the socket with a network interface.  It can be
>>>>> attached to the interface in 2 different modes:
>>>>>
>>>>> 1. skb - this mode should work for any interface and doesn't require
>>>>>          driver support.  With a caveat of lower performance.
>>>>>
>>>>> 2. native - this does require support from the driver and allows to
>>>>>             bypass skb allocation in the kernel and potentially use
>>>>>             zero-copy while getting packets in/out userspace.
>>>>>
>>>>> By default, QEMU will try to use native mode and fall back to skb.
>>>>> Mode can be forced via 'mode' option.  To force 'copy' even in native
>>>>> mode, use 'force-copy=on' option.  This might be useful if there is
>>>>> some issue with the driver.
>>>>>
>>>>> Option 'queues=N' allows to specify how many device queues should
>>>>> be open.  Note that all the queues that are not open are still
>>>>> functional and can receive traffic, but it will not be delivered to
>>>>> QEMU.  So, the number of device queues should generally match the
>>>>> QEMU configuration, unless the device is shared with something
>>>>> else and the traffic re-direction to appropriate queues is correctly
>>>>> configured on a device level (e.g. with ethtool -N).
>>>>> 'start-queue=M' option can be used to specify from which queue id
>>>>> QEMU should start configuring 'N' queues.  It might also be necessary
>>>>> to use this option with certain NICs, e.g. MLX5 NICs.  See the docs
>>>>> for examples.
>>>>>
>>>>> In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
>>>>> capabilities in order to load default XSK/XDP programs to the
>>>>> network interface and configure BTF maps.
>>>>
>>>> I think you mean "BPF" actually?
>>
>> "BPF Type Format maps" kind of makes some sense, but yes. :)
>>
>>>>
>>>>>  It is possible, however,
>>>>> to run only with CAP_NET_RAW.
>>>>
>>>> Qemu often runs without any privileges, so we need to fix it.
>>>>
>>>> I think adding support for SCM_RIGHTS via monitor would be a way to go.
>>
>> I looked through the code and it seems like we can run completely
>> non-privileged as far as kernel concerned.  We'll need an API
>> modification in libxdp though.
>>
>> The thing is, IIUC, the only syscall that requires CAP_NET_RAW is
>> a base socket creation.  Binding and other configuration doesn't
>> require any privileges.  So, we could create a socket externally
>> and pass it to QEMU.
> 
> That's the way TAP works for example.
> 
>>  Should work, unless it's an oversight from
>> the kernel side that needs to be patched. :)  libxdp doesn't have
>> a way to specify externally created socket today, so we'll need
>> to change that.  Should be easy to do though.  I can explore.
> 
> Please do that.

I have a prototype:
  https://github.com/igsilya/xdp-tools/commit/db73e90945e3aa5e451ac88c42c83cb9389642d3

Need to test it out and then submit PR to xdp-tools project.

> 
>>
>> In case the bind syscall will actually need CAP_NET_RAW for some
>> reason, we could change the kernel and allow non-privileged bind
>> by utilizing, e.g. SO_BINDTODEVICE.  i.e., let the privileged
>> process bind the socket to a particular device, so QEMU can't
>> bind it to a random one.  Might be a good use case to allow even
>> if not strictly necessary.
> 
> Yes.

Will propose something for a kernel as well.  We might want something
more granular though, e.g. bind to a queue instead of a device.  In
case we want better control in the device sharing scenario.

> 
>>
>>>>
>>>>
>>>>> For that to work, an external process
>>>>> with admin capabilities will need to pre-load default XSK program
>>>>> and pass an open file descriptor for this program's 'xsks_map' to
>>>>> QEMU process on startup.  Network backend will need to be configured
>>>>> with 'inhibit=on' to avoid loading of the programs.  The file
>>>>> descriptor for 'xsks_map' can be passed via 'xsks-map-fd=N' option.
>>>>>
>>>>> There are few performance challenges with the current network backends.
>>>>>
>>>>> First is that they do not support IO threads.
>>>>
>>>> The current networking codes needs some major recatoring to support IO
>>>> threads which I'm not sure is worthwhile.
>>>>
>>>>> This means that data
>>>>> path is handled by the main thread in QEMU and may slow down other
>>>>> work or may be slowed down by some other work.  This also means that
>>>>> taking advantage of multi-queue is generally not possible today.
>>>>>
>>>>> Another thing is that data path is going through the device emulation
>>>>> code, which is not really optimized for performance.  The fastest
>>>>> "frontend" device is virtio-net.  But it's not optimized for heavy
>>>>> traffic either, because it expects such use-cases to be handled via
>>>>> some implementation of vhost (user, kernel, vdpa).  In practice, we
>>>>> have virtio notifications and rcu lock/unlock on a per-packet basis
>>>>> and not very efficient accesses to the guest memory.  Communication
>>>>> channels between backend and frontend devices do not allow passing
>>>>> more than one packet at a time as well.
>>>>>
>>>>> Some of these challenges can be avoided in the future by adding better
>>>>> batching into device emulation or by implementing vhost-af-xdp variant.
>>>>
>>>> It might require you to register(pin) the whole guest memory to XSK or
>>>> there could be a copy. Both of them are sub-optimal.
>>
>> A single copy by itself shouldn't be a huge problem, right?
> 
> Probably.
> 
>> vhost-user and -kernel do copy packets.
>>
>>>>
>>>> A really interesting project is to do AF_XDP passthrough, then we
>>>> don't need to care about pin and copy and we will get ultra speed in
>>>> the guest. (But again, it might needs BPF support in virtio-net).
>>
>> I suppose, if we're doing pass-through we need a new device type and a
>> driver in the kernel/dpdk.  There is no point pretending it's a
>> virtio-net and translating between different ring layouts.
> 
> Yes.
> 
>>  Or is there?
>>
>>>>
>>>>>
>>>>> There are also a few kernel limitations.  AF_XDP sockets do not
>>>>> support any kinds of checksum or segmentation offloading.  Buffers
>>>>> are limited to a page size (4K), i.e. MTU is limited.  Multi-buffer
>>>>> support is not implemented for AF_XDP today.  Also, transmission in
>>>>> all non-zero-copy modes is synchronous, i.e. done in a syscall.
>>>>> That doesn't allow high packet rates on virtual interfaces.
>>>>>
>>>>> However, keeping in mind all of these challenges, current implementation
>>>>> of the AF_XDP backend shows a decent performance while running on top
>>>>> of a physical NIC with zero-copy support.
>>>>>
>>>>> Test setup:
>>>>>
>>>>> 2 VMs running on 2 physical hosts connected via ConnectX6-Dx card.
>>>>> Network backend is configured to open the NIC directly in native mode.
>>>>> The driver supports zero-copy.  NIC is configured to use 1 queue.
>>>>>
>>>>> Inside a VM - iperf3 for basic TCP performance testing and dpdk-testpmd
>>>>> for PPS testing.
>>>>>
>>>>> iperf3 result:
>>>>>  TCP stream      : 19.1 Gbps
>>>>>
>>>>> dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
>>>>>  Tx only         : 3.4 Mpps
>>>>>  Rx only         : 2.0 Mpps
>>>>>  L2 FWD Loopback : 1.5 Mpps
>>>>
>>>> I don't object to merging this backend (considering we've already
>>>> merged netmap) once the code is fine, but the number is not amazing so
>>>> I wonder what is the use case for this backend?
>>
>> I don't think there is a use case right now that would significantly benefit
>> from the current implementation, so I'm fine if the merge is postponed.
> 
> Just to be clear, I don't want to postpone this if we decide to
> invest/enhance it. I will go through the codes and get back.

Ack.  Thanks.

> 
>> It is noticeably more performant than a tap with vhost=on in terms of PPS.
>> So, that might be one case.  Taking into account that just rcu lock and
>> unlock in virtio-net code takes more time than a packet copy, some batching
>> on QEMU side should improve performance significantly.  And it shouldn't be
>> too hard to implement.
>>
>> Performance over virtual interfaces may potentially be improved by creating
>> a kernel thread for async Tx.  Similarly to what io_uring allows.  Currently
>> Tx on non-zero-copy interfaces is synchronous, and that doesn't allow to
>> scale well.
> 
> Interestingly, actually, there are a lot of "duplication" between
> io_uring and AF_XDP:
> 
> 1) both have similar memory model (user register)
> 2) both use ring for communication
> 
> I wonder if we can let io_uring talks directly to AF_XDP.

Well, if we submit poll() in QEMU main loop via io_uring, then we can
avoid cost of the synchronous Tx for non-zero-copy modes, i.e. for
virtual interfaces.  io_uring thread in the kernel will be able to
perform transmission for us.

But yeah, there are way too many way too similar ring buffer interfaces
in the kernel.

> 
>>
>> So, I do think that there is a potential in this backend.
>>
>> The main benefit, assuming we can reach performance comparable with other
>> high-performance backends (vhost-user), I think, is the fact that it's
>> Linux-native and doesn't require talking with any other devices
>> (like chardevs/sockets), except for a network interface itself. i.e. it
>> could be easier to manage in complex environments.
> 
> Yes.
> 
>>
>>> A more ambitious method is to reuse DPDK via dedicated threads, then
>>> we can reuse any of its PMD like AF_XDP.
>>
>> Linking with DPDK will make configuration much more complex.  I don't
>> think it makes sense to bring it in for AF_XDP specifically.  Might be
>> a separate project though, sure.
> 
> Right.
> 
> Thanks
> 
>>
>> Best regards, Ilya Maximets.
>>
> 


