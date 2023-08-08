Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D017736A3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCSg-0001H6-Hh; Mon, 07 Aug 2023 22:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTCSe-0001Gs-IN
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTCSb-0003Fe-Q8
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691461716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8jdc4g3f4UYubDvW3IBMXzIT/XbJO5VAapwuSvbHZk=;
 b=hbi34d0JYDUAgdtOlM0lGlPykidsDFITPtWDg/pB2rCy53Q8ITvd7Tw3/KtFrL+j/hpoff
 Ii9RhQdNam9HJB4/HDNCFYTnKRTUrGEaGyZt9xsirJp/f3S7yw7mQ2dJBbctlbl+qnJD6i
 xtwmWrx+275G6/jwrYq9s1UyzD2PGEo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-HFaurxyyMSqWW3WE9BSylQ-1; Mon, 07 Aug 2023 22:28:32 -0400
X-MC-Unique: HFaurxyyMSqWW3WE9BSylQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ba0f27a4c9so21681181fa.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 19:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691461711; x=1692066511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k8jdc4g3f4UYubDvW3IBMXzIT/XbJO5VAapwuSvbHZk=;
 b=ZP2E2nslbG4YdAH86Rqt40EsJQrTUupEjShSlFmo4dBqlrvkng1s0fdWQ77RUPQNqw
 DxP28wOC6JPSwSlz3fCNG7WxVKojdMxbikZePq+n0+iVuXumaVf7XHLYiwIYgiAUdvX8
 55nWTUplyxqqny5Y2tgPrGYAFSfDUOnA8cdiMOKmkuNS+TqHC6QIDqLwO1NIe9MyB7I5
 n6MxcED8TBnuP1N/PbBk3pOVUO0XRcFwROBmvl9U0JzqrW+CWZCL0CbBhSWDFp7fu1Lu
 lqGOk/8+rAI6wqmToPTUKkKUjKqkgjog/DKkkPQpgPyfNk38WfDquB3b48m4t7WBcDVh
 taeA==
X-Gm-Message-State: AOJu0YwVRqW9jBCWBjUW1iBQ211SnmPyCBrHD83CSLo3p4R3WqLNXqso
 P35aVVcWPnXNs7D2v8Iv04eQyPHolGGs2WmCr3pd1w6OUyDxtLFmlbTcBsTsxJPArD9spcFidS7
 9O9IWiC3vtoKZirs6K1Oe1CmfPT7CHPE=
X-Received: by 2002:a2e:90c2:0:b0:2b5:81bc:43a8 with SMTP id
 o2-20020a2e90c2000000b002b581bc43a8mr7507700ljg.0.1691461711051; 
 Mon, 07 Aug 2023 19:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG69um5vcP8k1nMXuZ7Az5D0+TJT2IN5CDX5h1Dj6obshB+cyq+tSHf6YDyYlvHvkolZ8tC1a8lr0dnTzrF53M=
X-Received: by 2002:a2e:90c2:0:b0:2b5:81bc:43a8 with SMTP id
 o2-20020a2e90c2000000b002b581bc43a8mr7507686ljg.0.1691461710701; Mon, 07 Aug
 2023 19:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230804182110.2627049-1-i.maximets@ovn.org>
In-Reply-To: <20230804182110.2627049-1-i.maximets@ovn.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 8 Aug 2023 10:28:19 +0800
Message-ID: <CACGkMEusFonOKcmOY92PVrPF47xLjMfff8TOh3FDCZ9L+0JvoA@mail.gmail.com>
Subject: Re: [PATCH v3] net: add initial support for AF_XDP network backend
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Sat, Aug 5, 2023 at 2:20=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
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
>   -device virtio-net-pci,netdev=3Dguest1,mac=3D00:16:35:AF:AA:5C
>   -netdev af-xdp,ifname=3Dens6f1np1,id=3Dguest1,mode=3Dnative,queues=3D1
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
> mode, use 'force-copy=3Don' option.  This might be useful if there is
> some issue with the driver.
>
> Option 'queues=3DN' allows to specify how many device queues should
> be open.  Note that all the queues that are not open are still
> functional and can receive traffic, but it will not be delivered to
> QEMU.  So, the number of device queues should generally match the
> QEMU configuration, unless the device is shared with something
> else and the traffic re-direction to appropriate queues is correctly
> configured on a device level (e.g. with ethtool -N).
> 'start-queue=3DM' option can be used to specify from which queue id
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
> configured with 'inhibit=3Don' to avoid loading of the program.
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
> backend with vhost=3Don and disabled segmentation offloading bridged
> with a NIC.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>
> Version 3:
>
>   - Bump requirements to libxdp 1.4.0+.  Having that, removed all
>     the conditional compilation parts, since all the needed APIs
>     are available in this version of libxdp.
>
>   - Also removed the ability to pass xsks map fd, since ability
>     to just pass socket fds is now always available and it doesn't
>     require any capabilities untile manipulations with BPF maps.
>
>   - Updated documentation to not call out specific vendors, memory
>     numbers or specific required capabilities.
>
>   - Changed logic of returning peeked at but unused descriptors.
>
>   - Minor cleanups.
>

Queued this for 8.2.

Thanks


