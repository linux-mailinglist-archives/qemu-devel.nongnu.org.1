Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4836779869E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:55:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qea4T-0007xD-Gx; Fri, 08 Sep 2023 07:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qea4R-0007x2-6Z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:54:43 -0400
Received: from relay6-d.mail.gandi.net ([2001:4b98:dc4:8::226])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qea4O-0005Fy-0Z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:54:42 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6B227C0003;
 Fri,  8 Sep 2023 11:54:35 +0000 (UTC)
Message-ID: <a336fc61-2f3c-86f6-a769-ff9c10271ad6@ovn.org>
Date: Fri, 8 Sep 2023 13:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: i.maximets@ovn.org, qemu-devel@nongnu.org
Subject: Re: [PULL 12/17] net: add initial support for AF_XDP network backend
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230908064507.14596-1-jasowang@redhat.com>
 <20230908064507.14596-13-jasowang@redhat.com> <ZPsJ+TxDYO24T5Yp@redhat.com>
From: Ilya Maximets <i.maximets@ovn.org>
In-Reply-To: <ZPsJ+TxDYO24T5Yp@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: neutral client-ip=2001:4b98:dc4:8::226;
 envelope-from=i.maximets@ovn.org; helo=relay6-d.mail.gandi.net
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_NEUTRAL=0.779 autolearn=ham autolearn_force=no
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

On 9/8/23 13:48, Daniel P. Berrangé wrote:
> On Fri, Sep 08, 2023 at 02:45:02PM +0800, Jason Wang wrote:
>> From: Ilya Maximets <i.maximets@ovn.org>
>>
>> AF_XDP is a network socket family that allows communication directly
>> with the network device driver in the kernel, bypassing most or all
>> of the kernel networking stack.  In the essence, the technology is
>> pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-native
>> and works with any network interfaces without driver modifications.
>> Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
>> require access to character devices or unix sockets.  Only access to
>> the network interface itself is necessary.
>>
>> This patch implements a network backend that communicates with the
>> kernel by creating an AF_XDP socket.  A chunk of userspace memory
>> is shared between QEMU and the host kernel.  4 ring buffers (Tx, Rx,
>> Fill and Completion) are placed in that memory along with a pool of
>> memory buffers for the packet data.  Data transmission is done by
>> allocating one of the buffers, copying packet data into it and
>> placing the pointer into Tx ring.  After transmission, device will
>> return the buffer via Completion ring.  On Rx, device will take
>> a buffer form a pre-populated Fill ring, write the packet data into
>> it and place the buffer into Rx ring.
>>
>> AF_XDP network backend takes on the communication with the host
>> kernel and the network interface and forwards packets to/from the
>> peer device in QEMU.
>>
>> Usage example:
>>
>>   -device virtio-net-pci,netdev=guest1,mac=00:16:35:AF:AA:5C
>>   -netdev af-xdp,ifname=ens6f1np1,id=guest1,mode=native,queues=1
>>
>> XDP program bridges the socket with a network interface.  It can be
>> attached to the interface in 2 different modes:
>>
>> 1. skb - this mode should work for any interface and doesn't require
>>          driver support.  With a caveat of lower performance.
>>
>> 2. native - this does require support from the driver and allows to
>>             bypass skb allocation in the kernel and potentially use
>>             zero-copy while getting packets in/out userspace.
>>
>> By default, QEMU will try to use native mode and fall back to skb.
>> Mode can be forced via 'mode' option.  To force 'copy' even in native
>> mode, use 'force-copy=on' option.  This might be useful if there is
>> some issue with the driver.
>>
>> Option 'queues=N' allows to specify how many device queues should
>> be open.  Note that all the queues that are not open are still
>> functional and can receive traffic, but it will not be delivered to
>> QEMU.  So, the number of device queues should generally match the
>> QEMU configuration, unless the device is shared with something
>> else and the traffic re-direction to appropriate queues is correctly
>> configured on a device level (e.g. with ethtool -N).
>> 'start-queue=M' option can be used to specify from which queue id
>> QEMU should start configuring 'N' queues.  It might also be necessary
>> to use this option with certain NICs, e.g. MLX5 NICs.  See the docs
>> for examples.
>>
>> In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
>> or CAP_BPF capabilities in order to load default XSK/XDP programs to
>> the network interface and configure BPF maps.  It is possible, however,
>> to run with no capabilities.  For that to work, an external process
>> with enough capabilities will need to pre-load default XSK program,
>> create AF_XDP sockets and pass their file descriptors to QEMU process
>> on startup via 'sock-fds' option.  Network backend will need to be
>> configured with 'inhibit=on' to avoid loading of the program.
>> QEMU will need 32 MB of locked memory (RLIMIT_MEMLOCK) per queue
>> or CAP_IPC_LOCK.
>>
>> There are few performance challenges with the current network backends.
>>
>> First is that they do not support IO threads.  This means that data
>> path is handled by the main thread in QEMU and may slow down other
>> work or may be slowed down by some other work.  This also means that
>> taking advantage of multi-queue is generally not possible today.
>>
>> Another thing is that data path is going through the device emulation
>> code, which is not really optimized for performance.  The fastest
>> "frontend" device is virtio-net.  But it's not optimized for heavy
>> traffic either, because it expects such use-cases to be handled via
>> some implementation of vhost (user, kernel, vdpa).  In practice, we
>> have virtio notifications and rcu lock/unlock on a per-packet basis
>> and not very efficient accesses to the guest memory.  Communication
>> channels between backend and frontend devices do not allow passing
>> more than one packet at a time as well.
>>
>> Some of these challenges can be avoided in the future by adding better
>> batching into device emulation or by implementing vhost-af-xdp variant.
>>
>> There are also a few kernel limitations.  AF_XDP sockets do not
>> support any kinds of checksum or segmentation offloading.  Buffers
>> are limited to a page size (4K), i.e. MTU is limited.  Multi-buffer
>> support implementation for AF_XDP is in progress, but not ready yet.
>> Also, transmission in all non-zero-copy modes is synchronous, i.e.
>> done in a syscall.  That doesn't allow high packet rates on virtual
>> interfaces.
>>
>> However, keeping in mind all of these challenges, current implementation
>> of the AF_XDP backend shows a decent performance while running on top
>> of a physical NIC with zero-copy support.
>>
>> Test setup:
>>
>> 2 VMs running on 2 physical hosts connected via ConnectX6-Dx card.
>> Network backend is configured to open the NIC directly in native mode.
>> The driver supports zero-copy.  NIC is configured to use 1 queue.
>>
>> Inside a VM - iperf3 for basic TCP performance testing and dpdk-testpmd
>> for PPS testing.
>>
>> iperf3 result:
>>  TCP stream      : 19.1 Gbps
>>
>> dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
>>  Tx only         : 3.4 Mpps
>>  Rx only         : 2.0 Mpps
>>  L2 FWD Loopback : 1.5 Mpps
>>
>> In skb mode the same setup shows much lower performance, similar to
>> the setup where pair of physical NICs is replaced with veth pair:
>>
>> iperf3 result:
>>   TCP stream      : 9 Gbps
>>
>> dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
>>   Tx only         : 1.2 Mpps
>>   Rx only         : 1.0 Mpps
>>   L2 FWD Loopback : 0.7 Mpps
>>
>> Results in skb mode or over the veth are close to results of a tap
>> backend with vhost=on and disabled segmentation offloading bridged
>> with a NIC.
> 
> 
>> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
>> index 02262bc..811a7fe 100644
>> --- a/tests/docker/dockerfiles/debian-amd64.docker
>> +++ b/tests/docker/dockerfiles/debian-amd64.docker
>> @@ -98,6 +98,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>                        libvirglrenderer-dev \
>>                        libvte-2.91-dev \
>>                        libxen-dev \
>> +                      libxdp-dev \
>>                        libzstd-dev \
>>                        llvm \
>>                        locales \
> 
> As the comment at the top of the file states - this is auto-generated
> by lcitool and must not be hand editted like this.

Sorry, missed that part of the process initially.  I see how that works now.

> 
> Check out docs/devel/testing.rst which has guidance on the process
> for adding new package deps with lcitool/libvirt-ci.

Will do, thanks!

> 
> With regards,
> Daniel


