Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E22CE73D7CB
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfmx-0002kp-9g; Mon, 26 Jun 2023 02:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qDfms-0002ka-Ld
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qDfmq-0008JK-B8
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687761199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJ+YP+W9kjsK6gh1UebLHHuFjfap7UanJBUcGl2nzDw=;
 b=dP44yFH+Wmcv3dbDDDDuShGepVVqzxUwY+5Btql6ip+M+kKAMD8r0i7VJ4Jmch9jY/q7jn
 F2I3F/ubiBn0yhws6KxqMJyFRnnYwnqX1C3KSVMS9wsDa6zIqFHfnnr6ZHpmQwbO2+/NYP
 rDs6f1SyxeYO6KJVgqTEgktp19pd9Mk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-hJfAtd_INQ2mr4ZFuWKZGA-1; Mon, 26 Jun 2023 02:33:12 -0400
X-MC-Unique: hJfAtd_INQ2mr4ZFuWKZGA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6a5ceddcdso1427351fa.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 23:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687761191; x=1690353191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJ+YP+W9kjsK6gh1UebLHHuFjfap7UanJBUcGl2nzDw=;
 b=FC4xVYufV/NmCfwZB5RvV5djJ5J9XIv7guXsfCZjtYYAmK9qS+VHmcxDCM7ztoE7D9
 gvMjApDYI9taLY3BARGlYDnFNe7BdIch85BPEJ34q+WMIU+Bf11aHWn4GpPoDXHiSYH6
 X3bX6wNbu5G6zOxTN7g2fmM5EQSMjEIj6XbzW6CA3rutkTdDVUqvRLBEIpN4VbY+7hBt
 noFrt1c9Qnw7DS5d610KIHEgUZYyLwJnL0z6SCRDuk8uN/M6JfMIx60FadBYaMT2Ui7I
 A/t67304shnSfstCtTJL2YT/dwiCAjTW6ESB6ENkDY6b0DtMUPryzZ0/aaEmqoYKQ9P3
 d1kw==
X-Gm-Message-State: AC+VfDxOKTECsnWVktBo9OgPcsoR/rMTYI7ICOw6wf5Nbj+CcgsvUgkd
 mOkmThfkJCta5uWuHKzxWiclZ11yz4V5YZHwIB1gHVwmhRAaJ5q6AQlD3Y7yaXHCkmZqQa0sMWR
 JGnku7slRojhXMa4gdoqUNh6Og6qFb14=
X-Received: by 2002:a2e:3a09:0:b0:2b5:8c49:757e with SMTP id
 h9-20020a2e3a09000000b002b58c49757emr6522091lja.0.1687761191426; 
 Sun, 25 Jun 2023 23:33:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6FfljwjS+TlkrJtMs+slRwPdGVty4WpsPrOCGMHQsnlGfXqcWmHw6YqRpcstMMX6ba1Rg4l1NajZ4FenbUeds=
X-Received: by 2002:a2e:3a09:0:b0:2b5:8c49:757e with SMTP id
 h9-20020a2e3a09000000b002b58c49757emr6522076lja.0.1687761191056; Sun, 25 Jun
 2023 23:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
In-Reply-To: <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 26 Jun 2023 14:32:59 +0800
Message-ID: <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org=
> wrote:
> >
> > AF_XDP is a network socket family that allows communication directly
> > with the network device driver in the kernel, bypassing most or all
> > of the kernel networking stack.  In the essence, the technology is
> > pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-native
> > and works with any network interfaces without driver modifications.
> > Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
> > require access to character devices or unix sockets.  Only access to
> > the network interface itself is necessary.
> >
> > This patch implements a network backend that communicates with the
> > kernel by creating an AF_XDP socket.  A chunk of userspace memory
> > is shared between QEMU and the host kernel.  4 ring buffers (Tx, Rx,
> > Fill and Completion) are placed in that memory along with a pool of
> > memory buffers for the packet data.  Data transmission is done by
> > allocating one of the buffers, copying packet data into it and
> > placing the pointer into Tx ring.  After transmission, device will
> > return the buffer via Completion ring.  On Rx, device will take
> > a buffer form a pre-populated Fill ring, write the packet data into
> > it and place the buffer into Rx ring.
> >
> > AF_XDP network backend takes on the communication with the host
> > kernel and the network interface and forwards packets to/from the
> > peer device in QEMU.
> >
> > Usage example:
> >
> >   -device virtio-net-pci,netdev=3Dguest1,mac=3D00:16:35:AF:AA:5C
> >   -netdev af-xdp,ifname=3Dens6f1np1,id=3Dguest1,mode=3Dnative,queues=3D=
1
> >
> > XDP program bridges the socket with a network interface.  It can be
> > attached to the interface in 2 different modes:
> >
> > 1. skb - this mode should work for any interface and doesn't require
> >          driver support.  With a caveat of lower performance.
> >
> > 2. native - this does require support from the driver and allows to
> >             bypass skb allocation in the kernel and potentially use
> >             zero-copy while getting packets in/out userspace.
> >
> > By default, QEMU will try to use native mode and fall back to skb.
> > Mode can be forced via 'mode' option.  To force 'copy' even in native
> > mode, use 'force-copy=3Don' option.  This might be useful if there is
> > some issue with the driver.
> >
> > Option 'queues=3DN' allows to specify how many device queues should
> > be open.  Note that all the queues that are not open are still
> > functional and can receive traffic, but it will not be delivered to
> > QEMU.  So, the number of device queues should generally match the
> > QEMU configuration, unless the device is shared with something
> > else and the traffic re-direction to appropriate queues is correctly
> > configured on a device level (e.g. with ethtool -N).
> > 'start-queue=3DM' option can be used to specify from which queue id
> > QEMU should start configuring 'N' queues.  It might also be necessary
> > to use this option with certain NICs, e.g. MLX5 NICs.  See the docs
> > for examples.
> >
> > In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
> > capabilities in order to load default XSK/XDP programs to the
> > network interface and configure BTF maps.
>
> I think you mean "BPF" actually?
>
> >  It is possible, however,
> > to run only with CAP_NET_RAW.
>
> Qemu often runs without any privileges, so we need to fix it.
>
> I think adding support for SCM_RIGHTS via monitor would be a way to go.
>
>
> > For that to work, an external process
> > with admin capabilities will need to pre-load default XSK program
> > and pass an open file descriptor for this program's 'xsks_map' to
> > QEMU process on startup.  Network backend will need to be configured
> > with 'inhibit=3Don' to avoid loading of the programs.  The file
> > descriptor for 'xsks_map' can be passed via 'xsks-map-fd=3DN' option.
> >
> > There are few performance challenges with the current network backends.
> >
> > First is that they do not support IO threads.
>
> The current networking codes needs some major recatoring to support IO
> threads which I'm not sure is worthwhile.
>
> > This means that data
> > path is handled by the main thread in QEMU and may slow down other
> > work or may be slowed down by some other work.  This also means that
> > taking advantage of multi-queue is generally not possible today.
> >
> > Another thing is that data path is going through the device emulation
> > code, which is not really optimized for performance.  The fastest
> > "frontend" device is virtio-net.  But it's not optimized for heavy
> > traffic either, because it expects such use-cases to be handled via
> > some implementation of vhost (user, kernel, vdpa).  In practice, we
> > have virtio notifications and rcu lock/unlock on a per-packet basis
> > and not very efficient accesses to the guest memory.  Communication
> > channels between backend and frontend devices do not allow passing
> > more than one packet at a time as well.
> >
> > Some of these challenges can be avoided in the future by adding better
> > batching into device emulation or by implementing vhost-af-xdp variant.
>
> It might require you to register(pin) the whole guest memory to XSK or
> there could be a copy. Both of them are sub-optimal.
>
> A really interesting project is to do AF_XDP passthrough, then we
> don't need to care about pin and copy and we will get ultra speed in
> the guest. (But again, it might needs BPF support in virtio-net).
>
> >
> > There are also a few kernel limitations.  AF_XDP sockets do not
> > support any kinds of checksum or segmentation offloading.  Buffers
> > are limited to a page size (4K), i.e. MTU is limited.  Multi-buffer
> > support is not implemented for AF_XDP today.  Also, transmission in
> > all non-zero-copy modes is synchronous, i.e. done in a syscall.
> > That doesn't allow high packet rates on virtual interfaces.
> >
> > However, keeping in mind all of these challenges, current implementatio=
n
> > of the AF_XDP backend shows a decent performance while running on top
> > of a physical NIC with zero-copy support.
> >
> > Test setup:
> >
> > 2 VMs running on 2 physical hosts connected via ConnectX6-Dx card.
> > Network backend is configured to open the NIC directly in native mode.
> > The driver supports zero-copy.  NIC is configured to use 1 queue.
> >
> > Inside a VM - iperf3 for basic TCP performance testing and dpdk-testpmd
> > for PPS testing.
> >
> > iperf3 result:
> >  TCP stream      : 19.1 Gbps
> >
> > dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
> >  Tx only         : 3.4 Mpps
> >  Rx only         : 2.0 Mpps
> >  L2 FWD Loopback : 1.5 Mpps
>
> I don't object to merging this backend (considering we've already
> merged netmap) once the code is fine, but the number is not amazing so
> I wonder what is the use case for this backend?

A more ambitious method is to reuse DPDK via dedicated threads, then
we can reuse any of its PMD like AF_XDP.

Thanks

>
> Thanks


