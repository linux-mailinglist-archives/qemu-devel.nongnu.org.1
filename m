Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F974360C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:45:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8oB-0006BO-6n; Fri, 30 Jun 2023 03:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF8o8-00069e-VX
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:44:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF8o6-0001ZP-VR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688111082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/6AieSTlGFeV5YaGads7Gw7PTILpRNhtRBHqvW8Fyk=;
 b=P7NR3Kb4yUznTn7Us3WdZDte9mZQ2IKuXzNGd5HuoUR6tex+VB43og+EfjsC+gHTKeNvKa
 cUYBGMCCqdajkAO2u3WIeznG7qHbdlRzjfxM/q5bUYI491nV77boFfuk89IFxt+/26iUle
 8vNnZQ5eWr/mQck/qVJ0IW87KjokQYE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-RpnpMyc5MNutLSzHq-1i3w-1; Fri, 30 Jun 2023 03:44:38 -0400
X-MC-Unique: RpnpMyc5MNutLSzHq-1i3w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb913e8cddso1610221e87.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688111077; x=1690703077;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o/6AieSTlGFeV5YaGads7Gw7PTILpRNhtRBHqvW8Fyk=;
 b=hUobNdzufOa0JnGjhoE8mbKk/Mn1rVjplKAz0kUAdtbcRs3MQV7CoBcLpcejlwD3SE
 C7pT2BvzDO56pYEWH7OfxtkAQ20skhLgS6EYjSahXRkZyrVadRa/63l/lmGVtSzqqWfL
 5b/CTNQakFZ9yOpDPKGbpCChJV+wADFtNLNFhT0jEWK7kKWnjnJ44o47kKutPjBSjxby
 AuCm9FS0u7H5RLGxZYURWyq1oaBJ4QCNOi+Q/QDd/kfJdf49xr1/eNKGzirMevFF4VyI
 zvVEUYeahY/hwCTS1gHkAsDFZkhEapaiOZGYqjre7B2Qki9El2oZPKVar6bwF4Pqy/q3
 Lhrw==
X-Gm-Message-State: ABy/qLaKDxnncxLlfBg1m/S6VbiO9wNV4yimHzhG3ZC9cSZcDaCyyitA
 CQ0hmido6bY26/XF5tC3CJWlmN096xe32yLIOx4m5WSdlcqDdS0Rinq1DLO7+Sq4KsAtIOO4Utf
 sait3bwxI6UdZS+n3iAUvQesAoiWizus=
X-Received: by 2002:a05:651c:144:b0:2b4:6d59:7863 with SMTP id
 c4-20020a05651c014400b002b46d597863mr1315661ljd.25.1688111077228; 
 Fri, 30 Jun 2023 00:44:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFptgYNiOM+AarFxVE2E3/xZuasIJ+nESPjpVgX4uECFUve+Ja6zUN6s4rOVX0eqLbpka92TBWnKM0+Y/GCa0I=
X-Received: by 2002:a05:651c:144:b0:2b4:6d59:7863 with SMTP id
 c4-20020a05651c014400b002b46d597863mr1315647ljd.25.1688111076832; Fri, 30 Jun
 2023 00:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
 <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
 <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
 <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
 <26c03cd4-5582-489c-9f4c-aeaf8e157b42@ovn.org>
 <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
 <df817423-9b06-0649-6d82-b8308b64bdc5@ovn.org>
In-Reply-To: <df817423-9b06-0649-6d82-b8308b64bdc5@ovn.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 15:44:25 +0800
Message-ID: <CACGkMEtQumn9p13Li0DKr2AV-5O0VFvfe2FZdaLzETo+LKL9sQ@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 28, 2023 at 7:14=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> On 6/28/23 05:27, Jason Wang wrote:
> > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maximets@ovn.o=
rg> wrote:
> >>
> >> On 6/27/23 04:54, Jason Wang wrote:
> >>> On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.maximets@ovn=
.org> wrote:
> >>>>
> >>>> On 6/26/23 08:32, Jason Wang wrote:
> >>>>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> >>>>>>
> >>>>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.maximets@=
ovn.org> wrote:
> >>>>>>>
> >>>>>>> AF_XDP is a network socket family that allows communication direc=
tly
> >>>>>>> with the network device driver in the kernel, bypassing most or a=
ll
> >>>>>>> of the kernel networking stack.  In the essence, the technology i=
s
> >>>>>>> pretty similar to netmap.  But, unlike netmap, AF_XDP is Linux-na=
tive
> >>>>>>> and works with any network interfaces without driver modification=
s.
> >>>>>>> Unlike vhost-based backends (kernel, user, vdpa), AF_XDP doesn't
> >>>>>>> require access to character devices or unix sockets.  Only access=
 to
> >>>>>>> the network interface itself is necessary.
> >>>>>>>
> >>>>>>> This patch implements a network backend that communicates with th=
e
> >>>>>>> kernel by creating an AF_XDP socket.  A chunk of userspace memory
> >>>>>>> is shared between QEMU and the host kernel.  4 ring buffers (Tx, =
Rx,
> >>>>>>> Fill and Completion) are placed in that memory along with a pool =
of
> >>>>>>> memory buffers for the packet data.  Data transmission is done by
> >>>>>>> allocating one of the buffers, copying packet data into it and
> >>>>>>> placing the pointer into Tx ring.  After transmission, device wil=
l
> >>>>>>> return the buffer via Completion ring.  On Rx, device will take
> >>>>>>> a buffer form a pre-populated Fill ring, write the packet data in=
to
> >>>>>>> it and place the buffer into Rx ring.
> >>>>>>>
> >>>>>>> AF_XDP network backend takes on the communication with the host
> >>>>>>> kernel and the network interface and forwards packets to/from the
> >>>>>>> peer device in QEMU.
> >>>>>>>
> >>>>>>> Usage example:
> >>>>>>>
> >>>>>>>   -device virtio-net-pci,netdev=3Dguest1,mac=3D00:16:35:AF:AA:5C
> >>>>>>>   -netdev af-xdp,ifname=3Dens6f1np1,id=3Dguest1,mode=3Dnative,que=
ues=3D1
> >>>>>>>
> >>>>>>> XDP program bridges the socket with a network interface.  It can =
be
> >>>>>>> attached to the interface in 2 different modes:
> >>>>>>>
> >>>>>>> 1. skb - this mode should work for any interface and doesn't requ=
ire
> >>>>>>>          driver support.  With a caveat of lower performance.
> >>>>>>>
> >>>>>>> 2. native - this does require support from the driver and allows =
to
> >>>>>>>             bypass skb allocation in the kernel and potentially u=
se
> >>>>>>>             zero-copy while getting packets in/out userspace.
> >>>>>>>
> >>>>>>> By default, QEMU will try to use native mode and fall back to skb=
.
> >>>>>>> Mode can be forced via 'mode' option.  To force 'copy' even in na=
tive
> >>>>>>> mode, use 'force-copy=3Don' option.  This might be useful if ther=
e is
> >>>>>>> some issue with the driver.
> >>>>>>>
> >>>>>>> Option 'queues=3DN' allows to specify how many device queues shou=
ld
> >>>>>>> be open.  Note that all the queues that are not open are still
> >>>>>>> functional and can receive traffic, but it will not be delivered =
to
> >>>>>>> QEMU.  So, the number of device queues should generally match the
> >>>>>>> QEMU configuration, unless the device is shared with something
> >>>>>>> else and the traffic re-direction to appropriate queues is correc=
tly
> >>>>>>> configured on a device level (e.g. with ethtool -N).
> >>>>>>> 'start-queue=3DM' option can be used to specify from which queue =
id
> >>>>>>> QEMU should start configuring 'N' queues.  It might also be neces=
sary
> >>>>>>> to use this option with certain NICs, e.g. MLX5 NICs.  See the do=
cs
> >>>>>>> for examples.
> >>>>>>>
> >>>>>>> In a general case QEMU will need CAP_NET_ADMIN and CAP_SYS_ADMIN
> >>>>>>> capabilities in order to load default XSK/XDP programs to the
> >>>>>>> network interface and configure BTF maps.
> >>>>>>
> >>>>>> I think you mean "BPF" actually?
> >>>>
> >>>> "BPF Type Format maps" kind of makes some sense, but yes. :)
> >>>>
> >>>>>>
> >>>>>>>  It is possible, however,
> >>>>>>> to run only with CAP_NET_RAW.
> >>>>>>
> >>>>>> Qemu often runs without any privileges, so we need to fix it.
> >>>>>>
> >>>>>> I think adding support for SCM_RIGHTS via monitor would be a way t=
o go.
> >>>>
> >>>> I looked through the code and it seems like we can run completely
> >>>> non-privileged as far as kernel concerned.  We'll need an API
> >>>> modification in libxdp though.
> >>>>
> >>>> The thing is, IIUC, the only syscall that requires CAP_NET_RAW is
> >>>> a base socket creation.  Binding and other configuration doesn't
> >>>> require any privileges.  So, we could create a socket externally
> >>>> and pass it to QEMU.
> >>>
> >>> That's the way TAP works for example.
> >>>
> >>>>  Should work, unless it's an oversight from
> >>>> the kernel side that needs to be patched. :)  libxdp doesn't have
> >>>> a way to specify externally created socket today, so we'll need
> >>>> to change that.  Should be easy to do though.  I can explore.
> >>>
> >>> Please do that.
> >>
> >> I have a prototype:
> >>   https://github.com/igsilya/xdp-tools/commit/db73e90945e3aa5e451ac88c=
42c83cb9389642d3
> >>
> >> Need to test it out and then submit PR to xdp-tools project.
> >>
> >>>
> >>>>
> >>>> In case the bind syscall will actually need CAP_NET_RAW for some
> >>>> reason, we could change the kernel and allow non-privileged bind
> >>>> by utilizing, e.g. SO_BINDTODEVICE.  i.e., let the privileged
> >>>> process bind the socket to a particular device, so QEMU can't
> >>>> bind it to a random one.  Might be a good use case to allow even
> >>>> if not strictly necessary.
> >>>
> >>> Yes.
> >>
> >> Will propose something for a kernel as well.  We might want something
> >> more granular though, e.g. bind to a queue instead of a device.  In
> >> case we want better control in the device sharing scenario.
> >
> > I may miss something but the bind is already done at dev plus queue
> > right now, isn't it?
>
>
> Yes, the bind() syscall will bind socket to the dev+queue.  I was talking
> about SO_BINDTODEVICE that only ties the socket to a particular device,
> but not a queue.
>
> Assuming SO_BINDTODEVICE is implemented for AF_XDP sockets and
> assuming a privileged process does:
>
>   fd =3D socket(AF_XDP, ...);
>   setsockopt(fd, SOL_SOCKET, SO_BINDTODEVICE, <device>);
>
> And sends fd to a non-privileged process.  That non-privileged process
> will be able to call:
>
>   bind(fd, <device>, <random queue>);
>
> It will have to use the same device, but can choose any queue, if that
> queue is not already busy with another socket.
>
> So, I was thinking maybe implementing something like XDP_BINDTOQID option=
.
> This way the privileged process may call:
>
>   setsockopt(fd, SOL_XDP, XDP_BINDTOQID, <device>, <queue>);
>
> And later kernel will be able to refuse bind() for any other queue for
> this particular socket.

Not sure, if file descriptor passing works, we probably don't need another =
way.

>
> Not sure if that is necessary though.
> Since we're allocating the socket in the privileged process, that process
> may add the socket to the BPF map on the correct queue id.  This way the
> non-privileged process will not be able to receive any packets from any
> other queue on this socket, even if bound to it.  And no other AF_XDP
> socket will be able to be bound to that other queue as well.

I think that's by design, or anything wrong with this model?

> So, the
> rogue QEMU will be able to hog one extra queue, but it will not be able
> to intercept traffic any from it, AFAICT.  May not be a huge problem
> after all.
>
> SO_BINDTODEVICE would still be nice to have.  Especially for cases where
> we give the whole device to one VM.

Then we need to use AF_XDP in the guest which seems to be a different
topic. Alibaba is working on the AF_XDP support for virtio-net.

Thanks

>
> Best regards, Ilya Maximets.
>


