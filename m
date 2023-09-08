Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E3798696
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZyH-0004Jn-Kn; Fri, 08 Sep 2023 07:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeZyG-0004Je-4d
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qeZyC-0003hs-Ub
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694173695;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=EElGjQrfRh9/zxXRtOJMNtfsHVdo4QGNrVTDQYEG3DE=;
 b=bMBs4wQWRvy6PXhCnLD6xC5v3T855YhQAayJcAdReaPa1Y5waEtX5a0k2vCNr/gUsU5t8B
 yZ4w+S8P/lGpmSWgpVR6wtV7HxDnQQgKvKhUP1Vj9indiY6BBy13fmkpejZGDc1mW2W051
 NDddsgs3T4GAYzoqwOd9RSMMJXEXT7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-qZKTTiDFMe-x4nBmKFGsUw-1; Fri, 08 Sep 2023 07:48:12 -0400
X-MC-Unique: qZKTTiDFMe-x4nBmKFGsUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 738A7800888;
 Fri,  8 Sep 2023 11:48:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9A9863F6C;
 Fri,  8 Sep 2023 11:48:11 +0000 (UTC)
Date: Fri, 8 Sep 2023 12:48:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Maximets <i.maximets@ovn.org>
Subject: Re: [PULL 12/17] net: add initial support for AF_XDP network backend
Message-ID: <ZPsJ+TxDYO24T5Yp@redhat.com>
References: <20230908064507.14596-1-jasowang@redhat.com>
 <20230908064507.14596-13-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230908064507.14596-13-jasowang@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 08, 2023 at 02:45:02PM +0800, Jason Wang wrote:
> From: Ilya Maximets <i.maximets@ovn.org>
> 
> AF_XDP is a network socket family that allows communication directly
> with the network device driver in the kernel, bypassing most or all
> of the kernel networking stack.  In the essence, the technology is
> pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-native
> and works with any network interfaces without driver modifications.
> Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
> require access to character devices or unix sockets.  Only access to
> the network interface itself is necessary.
> 
> This patch implements a network backend that communicates with the
> kernel by creating an AF_XDP socket.  A chunk of userspace memory
> is shared between QEMU and the host kernel.  4 ring buffers (Tx, Rx,
> Fill and Completion) are placed in that memory along with a pool of
> memory buffers for the packet data.  Data transmission is done by
> allocating one of the buffers, copying packet data into it and
> placing the pointer into Tx ring.  After transmission, device will
> return the buffer via Completion ring.  On Rx, device will take
> a buffer form a pre-populated Fill ring, write the packet data into
> it and place the buffer into Rx ring.
> 
> AF_XDP network backend takes on the communication with the host
> kernel and the network interface and forwards packets to/from the
> peer device in QEMU.
> 
> Usage example:
> 
>   -device virtio-net-pci,netdev=guest1,mac=00:16:35:AF:AA:5C
>   -netdev af-xdp,ifname=ens6f1np1,id=guest1,mode=native,queues=1
> 
> XDP program bridges the socket with a network interface.  It can be
> attached to the interface in 2 different modes:
> 
> 1. skb - this mode should work for any interface and doesn't require
>          driver support.  With a caveat of lower performance.
> 
> 2. native - this does require support from the driver and allows to
>             bypass skb allocation in the kernel and potentially use
>             zero-copy while getting packets in/out userspace.
> 
> By default, QEMU will try to use native mode and fall back to skb.
> Mode can be forced via 'mode' option.  To force 'copy' even in native
> mode, use 'force-copy=on' option.  This might be useful if there is
> some issue with the driver.
> 
> Option 'queues=N' allows to specify how many device queues should
> be open.  Note that all the queues that are not open are still
> functional and can receive traffic, but it will not be delivered to
> QEMU.  So, the number of device queues should generally match the
> QEMU configuration, unless the device is shared with something
> else and the traffic re-direction to appropriate queues is correctly
> configured on a device level (e.g. with ethtool -N).
> 'start-queue=M' option can be used to specify from which queue id
> QEMU should start configuring 'N' queues.  It might also be necessary
> to use this option with certain NICs, e.g. MLX5 NICs.  See the docs
> for examples.
> 
> In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
> or CAP_BPF capabilities in order to load default XSK/XDP programs to
> the network interface and configure BPF maps.  It is possible, however,
> to run with no capabilities.  For that to work, an external process
> with enough capabilities will need to pre-load default XSK program,
> create AF_XDP sockets and pass their file descriptors to QEMU process
> on startup via 'sock-fds' option.  Network backend will need to be
> configured with 'inhibit=on' to avoid loading of the program.
> QEMU will need 32 MB of locked memory (RLIMIT_MEMLOCK) per queue
> or CAP_IPC_LOCK.
> 
> There are few performance challenges with the current network backends.
> 
> First is that they do not support IO threads.  This means that data
> path is handled by the main thread in QEMU and may slow down other
> work or may be slowed down by some other work.  This also means that
> taking advantage of multi-queue is generally not possible today.
> 
> Another thing is that data path is going through the device emulation
> code, which is not really optimized for performance.  The fastest
> "frontend" device is virtio-net.  But it's not optimized for heavy
> traffic either, because it expects such use-cases to be handled via
> some implementation of vhost (user, kernel, vdpa).  In practice, we
> have virtio notifications and rcu lock/unlock on a per-packet basis
> and not very efficient accesses to the guest memory.  Communication
> channels between backend and frontend devices do not allow passing
> more than one packet at a time as well.
> 
> Some of these challenges can be avoided in the future by adding better
> batching into device emulation or by implementing vhost-af-xdp variant.
> 
> There are also a few kernel limitations.  AF_XDP sockets do not
> support any kinds of checksum or segmentation offloading.  Buffers
> are limited to a page size (4K), i.e. MTU is limited.  Multi-buffer
> support implementation for AF_XDP is in progress, but not ready yet.
> Also, transmission in all non-zero-copy modes is synchronous, i.e.
> done in a syscall.  That doesn't allow high packet rates on virtual
> interfaces.
> 
> However, keeping in mind all of these challenges, current implementation
> of the AF_XDP backend shows a decent performance while running on top
> of a physical NIC with zero-copy support.
> 
> Test setup:
> 
> 2 VMs running on 2 physical hosts connected via ConnectX6-Dx card.
> Network backend is configured to open the NIC directly in native mode.
> The driver supports zero-copy.  NIC is configured to use 1 queue.
> 
> Inside a VM - iperf3 for basic TCP performance testing and dpdk-testpmd
> for PPS testing.
> 
> iperf3 result:
>  TCP stream      : 19.1 Gbps
> 
> dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
>  Tx only         : 3.4 Mpps
>  Rx only         : 2.0 Mpps
>  L2 FWD Loopback : 1.5 Mpps
> 
> In skb mode the same setup shows much lower performance, similar to
> the setup where pair of physical NICs is replaced with veth pair:
> 
> iperf3 result:
>   TCP stream      : 9 Gbps
> 
> dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
>   Tx only         : 1.2 Mpps
>   Rx only         : 1.0 Mpps
>   L2 FWD Loopback : 0.7 Mpps
> 
> Results in skb mode or over the veth are close to results of a tap
> backend with vhost=on and disabled segmentation offloading bridged
> with a NIC.


> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/dockerfiles/debian-amd64.docker
> index 02262bc..811a7fe 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -98,6 +98,7 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>                        libvirglrenderer-dev \
>                        libvte-2.91-dev \
>                        libxen-dev \
> +                      libxdp-dev \
>                        libzstd-dev \
>                        llvm \
>                        locales \

As the comment at the top of the file states - this is auto-generated
by lcitool and must not be hand editted like this.

Check out docs/devel/testing.rst which has guidance on the process
for adding new package deps with lcitool/libvirt-ci.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


