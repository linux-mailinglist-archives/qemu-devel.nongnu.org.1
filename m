Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E2E73F104
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 04:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDyr8-0004uZ-VE; Mon, 26 Jun 2023 22:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qDyr6-0004uE-63
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:55:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qDyr2-0002Fj-Ho
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:54:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687834493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T3XNn9DieGotzzZLytMyx94bq8tN9zyLYDAZV+FLNcw=;
 b=GIEtt7fS9KT9yv5/UT3oeE//i7x+od1280SzehURWzsIyj9KnvHQCzychcWVZszTtilUia
 3m5DGbhhnoHCYRQreK9srHPCKdyj3fqKB8bXtA6V/2I3eXvlf8nMgsZR2G13CRKuck+YFV
 t20JexRSKFS9T40cKpJ6tI5eNzQn/6k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-UwslIDwMO_WoZRS5FW_DbQ-1; Mon, 26 Jun 2023 22:54:51 -0400
X-MC-Unique: UwslIDwMO_WoZRS5FW_DbQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fb3f3a87d4so1002730e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 19:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687834490; x=1690426490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3XNn9DieGotzzZLytMyx94bq8tN9zyLYDAZV+FLNcw=;
 b=g7g6GRJ6kAyXk4Ilu6S0nfqzTHGUilz38X89MVxFWShyAIgVkp7KbHTFsmZ5LEu5Fw
 Z7UkNzYQK0Wulo5C/a04O7203CLqkvr2heDBF+xgyn7GUAW4ZkG4e7+0sjUPt9oA6gw3
 RoJXeqf0CMIA9YX+2MTYTJ4qWrmX7M+noWlgsupmolYz8DzWTgzEUwSJO2jHG1VEWc7L
 ycxRox/q6yQPm5aNoiwtUciX2qPkZrIeZB5TcG6LiGnKQ5qFQejdT/gtRHS6Jbyap9xw
 +11N8OYPjJvLtqvUYhi37j4DTksjolOgLWaiM3ipvFbEjVNslYBUXTskfm93d6QEF2kl
 7A+g==
X-Gm-Message-State: AC+VfDy1X4V2nnMqeykT0zzUygWK7nwQpfePsWH07GhH5ZrvWlLkCl6G
 dKTPnZ79wk97oAJ4uDxF2+vgdLnFLLeeiT01i46a2+NyI0N/Xv3KAdoBRCFtbhWWpJPSs5Yf1Ji
 CnC8cLkVC7QNJoM/PsBtdePT9+Pa8xoY=
X-Received: by 2002:a19:5007:0:b0:4f8:52a8:d123 with SMTP id
 e7-20020a195007000000b004f852a8d123mr10473757lfb.12.1687834490193; 
 Mon, 26 Jun 2023 19:54:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5TPkMm7wUnTZ4iAfeRTzh6FZ8cIBzwBC2k0q/AHDRpEEMIWUVhnjvmIb+k3deF26Mj0LWqpJxsCQQrXsD/vw0=
X-Received: by 2002:a19:5007:0:b0:4f8:52a8:d123 with SMTP id
 e7-20020a195007000000b004f852a8d123mr10473750lfb.12.1687834489770; Mon, 26
 Jun 2023 19:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
 <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
 <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
In-Reply-To: <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 10:54:38 +0800
Message-ID: <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: permerror client-ip=216.145.221.124;
 envelope-from=jasowang@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_FAIL=0.001, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 6/26/23 08:32, Jason Wang wrote:
> > On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> >>
> >> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.maximets@ovn.=
org> wrote:
> >>>
> >>> AF_XDP is a network socket family that allows communication directly
> >>> with the network device driver in the kernel, bypassing most or all
> >>> of the kernel networking stack.  In the essence, the technology is
> >>> pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-native
> >>> and works with any network interfaces without driver modifications.
> >>> Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
> >>> require access to character devices or unix sockets.  Only access to
> >>> the network interface itself is necessary.
> >>>
> >>> This patch implements a network backend that communicates with the
> >>> kernel by creating an AF_XDP socket.  A chunk of userspace memory
> >>> is shared between QEMU and the host kernel.  4 ring buffers (Tx, Rx,
> >>> Fill and Completion) are placed in that memory along with a pool of
> >>> memory buffers for the packet data.  Data transmission is done by
> >>> allocating one of the buffers, copying packet data into it and
> >>> placing the pointer into Tx ring.  After transmission, device will
> >>> return the buffer via Completion ring.  On Rx, device will take
> >>> a buffer form a pre-populated Fill ring, write the packet data into
> >>> it and place the buffer into Rx ring.
> >>>
> >>> AF_XDP network backend takes on the communication with the host
> >>> kernel and the network interface and forwards packets to/from the
> >>> peer device in QEMU.
> >>>
> >>> Usage example:
> >>>
> >>>   -device virtio-net-pci,netdev=3Dguest1,mac=3D00:16:35:AF:AA:5C
> >>>   -netdev af-xdp,ifname=3Dens6f1np1,id=3Dguest1,mode=3Dnative,queues=
=3D1
> >>>
> >>> XDP program bridges the socket with a network interface.  It can be
> >>> attached to the interface in 2 different modes:
> >>>
> >>> 1. skb - this mode should work for any interface and doesn't require
> >>>          driver support.  With a caveat of lower performance.
> >>>
> >>> 2. native - this does require support from the driver and allows to
> >>>             bypass skb allocation in the kernel and potentially use
> >>>             zero-copy while getting packets in/out userspace.
> >>>
> >>> By default, QEMU will try to use native mode and fall back to skb.
> >>> Mode can be forced via 'mode' option.  To force 'copy' even in native
> >>> mode, use 'force-copy=3Don' option.  This might be useful if there is
> >>> some issue with the driver.
> >>>
> >>> Option 'queues=3DN' allows to specify how many device queues should
> >>> be open.  Note that all the queues that are not open are still
> >>> functional and can receive traffic, but it will not be delivered to
> >>> QEMU.  So, the number of device queues should generally match the
> >>> QEMU configuration, unless the device is shared with something
> >>> else and the traffic re-direction to appropriate queues is correctly
> >>> configured on a device level (e.g. with ethtool -N).
> >>> 'start-queue=3DM' option can be used to specify from which queue id
> >>> QEMU should start configuring 'N' queues.  It might also be necessary
> >>> to use this option with certain NICs, e.g. MLX5 NICs.  See the docs
> >>> for examples.
> >>>
> >>> In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
> >>> capabilities in order to load default XSK/XDP programs to the
> >>> network interface and configure BTF maps.
> >>
> >> I think you mean "BPF" actually?
>
> "BPF Type Format maps" kind of makes some sense, but yes. :)
>
> >>
> >>>  It is possible, however,
> >>> to run only with CAP_NET_RAW.
> >>
> >> Qemu often runs without any privileges, so we need to fix it.
> >>
> >> I think adding support for SCM_RIGHTS via monitor would be a way to go=
.
>
> I looked through the code and it seems like we can run completely
> non-privileged as far as kernel concerned.  We'll need an API
> modification in libxdp though.
>
> The thing is, IIUC, the only syscall that requires CAP_NET_RAW is
> a base socket creation.  Binding and other configuration doesn't
> require any privileges.  So, we could create a socket externally
> and pass it to QEMU.

That's the way TAP works for example.

>  Should work, unless it's an oversight from
> the kernel side that needs to be patched. :)  libxdp doesn't have
> a way to specify externally created socket today, so we'll need
> to change that.  Should be easy to do though.  I can explore.

Please do that.

>
> In case the bind syscall will actually need CAP_NET_RAW for some
> reason, we could change the kernel and allow non-privileged bind
> by utilizing, e.g. SO_BINDTODEVICE.  i.e., let the privileged
> process bind the socket to a particular device, so QEMU can't
> bind it to a random one.  Might be a good use case to allow even
> if not strictly necessary.

Yes.

>
> >>
> >>
> >>> For that to work, an external process
> >>> with admin capabilities will need to pre-load default XSK program
> >>> and pass an open file descriptor for this program's 'xsks_map' to
> >>> QEMU process on startup.  Network backend will need to be configured
> >>> with 'inhibit=3Don' to avoid loading of the programs.  The file
> >>> descriptor for 'xsks_map' can be passed via 'xsks-map-fd=3DN' option.
> >>>
> >>> There are few performance challenges with the current network backend=
s.
> >>>
> >>> First is that they do not support IO threads.
> >>
> >> The current networking codes needs some major recatoring to support IO
> >> threads which I'm not sure is worthwhile.
> >>
> >>> This means that data
> >>> path is handled by the main thread in QEMU and may slow down other
> >>> work or may be slowed down by some other work.  This also means that
> >>> taking advantage of multi-queue is generally not possible today.
> >>>
> >>> Another thing is that data path is going through the device emulation
> >>> code, which is not really optimized for performance.  The fastest
> >>> "frontend" device is virtio-net.  But it's not optimized for heavy
> >>> traffic either, because it expects such use-cases to be handled via
> >>> some implementation of vhost (user, kernel, vdpa).  In practice, we
> >>> have virtio notifications and rcu lock/unlock on a per-packet basis
> >>> and not very efficient accesses to the guest memory.  Communication
> >>> channels between backend and frontend devices do not allow passing
> >>> more than one packet at a time as well.
> >>>
> >>> Some of these challenges can be avoided in the future by adding bette=
r
> >>> batching into device emulation or by implementing vhost-af-xdp varian=
t.
> >>
> >> It might require you to register(pin) the whole guest memory to XSK or
> >> there could be a copy. Both of them are sub-optimal.
>
> A single copy by itself shouldn't be a huge problem, right?

Probably.

> vhost-user and -kernel do copy packets.
>
> >>
> >> A really interesting project is to do AF_XDP passthrough, then we
> >> don't need to care about pin and copy and we will get ultra speed in
> >> the guest. (But again, it might needs BPF support in virtio-net).
>
> I suppose, if we're doing pass-through we need a new device type and a
> driver in the kernel/dpdk.  There is no point pretending it's a
> virtio-net and translating between different ring layouts.

Yes.

>  Or is there?
>
> >>
> >>>
> >>> There are also a few kernel limitations.  AF_XDP sockets do not
> >>> support any kinds of checksum or segmentation offloading.  Buffers
> >>> are limited to a page size (4K), i.e. MTU is limited.  Multi-buffer
> >>> support is not implemented for AF_XDP today.  Also, transmission in
> >>> all non-zero-copy modes is synchronous, i.e. done in a syscall.
> >>> That doesn't allow high packet rates on virtual interfaces.
> >>>
> >>> However, keeping in mind all of these challenges, current implementat=
ion
> >>> of the AF_XDP backend shows a decent performance while running on top
> >>> of a physical NIC with zero-copy support.
> >>>
> >>> Test setup:
> >>>
> >>> 2 VMs running on 2 physical hosts connected via ConnectX6-Dx card.
> >>> Network backend is configured to open the NIC directly in native mode=
.
> >>> The driver supports zero-copy.  NIC is configured to use 1 queue.
> >>>
> >>> Inside a VM - iperf3 for basic TCP performance testing and dpdk-testp=
md
> >>> for PPS testing.
> >>>
> >>> iperf3 result:
> >>>  TCP stream      : 19.1 Gbps
> >>>
> >>> dpdk-testpmd (single queue, single CPU core, 64 B packets) results:
> >>>  Tx only         : 3.4 Mpps
> >>>  Rx only         : 2.0 Mpps
> >>>  L2 FWD Loopback : 1.5 Mpps
> >>
> >> I don't object to merging this backend (considering we've already
> >> merged netmap) once the code is fine, but the number is not amazing so
> >> I wonder what is the use case for this backend?
>
> I don't think there is a use case right now that would significantly bene=
fit
> from the current implementation, so I'm fine if the merge is postponed.

Just to be clear, I don't want to postpone this if we decide to
invest/enhance it. I will go through the codes and get back.

> It is noticeably more performant than a tap with vhost=3Don in terms of P=
PS.
> So, that might be one case.  Taking into account that just rcu lock and
> unlock in virtio-net code takes more time than a packet copy, some batchi=
ng
> on QEMU side should improve performance significantly.  And it shouldn't =
be
> too hard to implement.
>
> Performance over virtual interfaces may potentially be improved by creati=
ng
> a kernel thread for async Tx.  Similarly to what io_uring allows.  Curren=
tly
> Tx on non-zero-copy interfaces is synchronous, and that doesn't allow to
> scale well.

Interestingly, actually, there are a lot of "duplication" between
io_uring and AF_XDP:

1) both have similar memory model (user register)
2) both use ring for communication

I wonder if we can let io_uring talks directly to AF_XDP.

>
> So, I do think that there is a potential in this backend.
>
> The main benefit, assuming we can reach performance comparable with other
> high-performance backends (vhost-user), I think, is the fact that it's
> Linux-native and doesn't require talking with any other devices
> (like chardevs/sockets), except for a network interface itself. i.e. it
> could be easier to manage in complex environments.

Yes.

>
> > A more ambitious method is to reuse DPDK via dedicated threads, then
> > we can reuse any of its PMD like AF_XDP.
>
> Linking with DPDK will make configuration much more complex.  I don't
> think it makes sense to bring it in for AF_XDP specifically.  Might be
> a separate project though, sure.

Right.

Thanks

>
> Best regards, Ilya Maximets.
>


