Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0691274E513
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 05:04:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3fp-0004Nh-Df; Mon, 10 Jul 2023 23:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3fn-0004Lx-QT
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3fl-0006q7-QJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689044657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hDssphsll+lAam4B/tMH+B7bVVlq/PMbKg0OqSwL2I=;
 b=BlyhMAjGuMZyaIrZ+3j7YwKHe3jvtu3SBPcfm9quqzje5okWw7IGCpDeqdSlpxlindUHWE
 hSPBfMePH/Eycv17NzTqueWoykNjrRkz8gWaTMZuDfdp3NmEuHhuDYqvexTirDtpLdlVjS
 kFywOS01+lStejsQK18B9CJSQsaPUnE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-abI84EkhP0SkyKq89J4Q8g-1; Mon, 10 Jul 2023 23:04:15 -0400
X-MC-Unique: abI84EkhP0SkyKq89J4Q8g-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b620465d0eso45884481fa.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 20:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044654; x=1691636654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hDssphsll+lAam4B/tMH+B7bVVlq/PMbKg0OqSwL2I=;
 b=H4JSj8u8FlmliZWXpvyEI6KGrR2Qx381eygEw+eBJfphoeykoXNPkP5t0DH3o0AP9I
 BUSWiiKZ5owhHEg2ogfNtVGuJQT4G8CFOpP3k+b6YVVoUwgJL6aEuTWzydZYM9/k9TDX
 Ff0Q5frXsgzWCb0fJW7RtmIJjvPvostKTu6diWbzjLuWBVTMlucDwG5GMfbboO6bvlHG
 ZHg42k6NeuoeV+HIMaNvv6CT+qX7qr+JS03L2VhQymQLwUy3aHLi6Mdf6FpIzFD29g66
 1rMMvMbrydjUfPOaVyYBcPLlFQ9HdxiAoP7w+e2MjJTvSt1/La/o/CylTzzQCJek7q4a
 bBYA==
X-Gm-Message-State: ABy/qLY/7XPDvLTX79s5TMbCiPILA+aDqAjD4c3Z65ZGhMRQr6Yrbuem
 sRmC9o9499AWipcrVDk1VGe4zPD9AxGoDoQ7sOMSTJC+UsmFYAKjg+vsvWX8yDVuI746R4Z8B2c
 6f8txWND3Ih3X8UoAi6T7BpLFWe1N56U=
X-Received: by 2002:a2e:7d15:0:b0:2b6:d7a0:c27d with SMTP id
 y21-20020a2e7d15000000b002b6d7a0c27dmr10688306ljc.37.1689044653871; 
 Mon, 10 Jul 2023 20:04:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEVPihVcDGxo61Gp4kqNdl9vPb+m+x4yd5bXuS3Iv3/562mcdVKlu5n/U46rBSovgdo6XpSeWrcB45aNlumoQ4=
X-Received: by 2002:a2e:7d15:0:b0:2b6:d7a0:c27d with SMTP id
 y21-20020a2e7d15000000b002b6d7a0c27dmr10688298ljc.37.1689044653542; Mon, 10
 Jul 2023 20:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
 <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
 <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
 <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
 <26c03cd4-5582-489c-9f4c-aeaf8e157b42@ovn.org>
 <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
 <CAJSP0QXPiNK2rH6_8bB7sjMpdQjT--oX0u4FkdaTj7Ew3qs8CA@mail.gmail.com>
 <CACGkMEuN_PeXZhqaN4EJP8rKRVK=wftpkH3--y267j9+7smCOw@mail.gmail.com>
 <CAJSP0QVg-mmtnMXZpxRKutbdgpdNeawJT45iQSp4cf=MRedZAQ@mail.gmail.com>
 <CACGkMEtdk-Qi+5M+pEa9v=S_ehRs=m7Ux4=Sf6aqk0EqNzyQ5g@mail.gmail.com>
 <CAJSP0QW22f18V0pXTO-w4BXONJ3wLCbczMjKSKCRnxiF+7W=eg@mail.gmail.com>
 <CACGkMEvCV6JcQ3LOQvCx=9KXKqE_SAQwzxFXe1c+PdSMH_KbDg@mail.gmail.com>
 <CAJSP0QUtCnE49YWA6PmVSExMaFf2VZi3St1Wysk9ruDS37ALHg@mail.gmail.com>
 <CACGkMEu1V4HBdP3JFYV-+Uec1s6f0U3fj5f9tV0FApQ+U8rbrw@mail.gmail.com>
 <CAJSP0QU-p_cKCevxTabKhfq9T2=UShLqcced-OCmfCx3dE+6rQ@mail.gmail.com>
 <CACGkMEv2u-pcFY_+Y-r6ODj6hjEDUhVG5VV-cX0Fko7VNPZ=0g@mail.gmail.com>
 <CAJSP0QXbq2s-VoWyPz7wWXCnhrt3nOMeoxdhUL8cerxm1sMfeg@mail.gmail.com>
 <CACGkMEsk65V4OiDB==fKSZ8us=FGz4u3Cj5un+2YYXep+OrQXw@mail.gmail.com>
 <CAJSP0QV1nYMKNkcphaLLH_te3Un_ep5not9pAW17zXEPaw2MsQ@mail.gmail.com>
In-Reply-To: <CAJSP0QV1nYMKNkcphaLLH_te3Un_ep5not9pAW17zXEPaw2MsQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jul 2023 11:04:02 +0800
Message-ID: <CACGkMEtf9Zu9ot=-ae+rcfkzX-z1bdVk8ODibCzp+H0V7R1aSw@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
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

On Mon, Jul 10, 2023 at 11:14=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Thu, 6 Jul 2023 at 21:43, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, Jul 7, 2023 at 3:08=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
> > >
> > > On Wed, 5 Jul 2023 at 02:02, Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Mon, Jul 3, 2023 at 5:03=E2=80=AFPM Stefan Hajnoczi <stefanha@gm=
ail.com> wrote:
> > > > >
> > > > > On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > > >
> > > > > > On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@gmail.com> wrote:
> > > > > > >
> > > > > > > On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <st=
efanha@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi=
 <stefanha@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajn=
oczi <stefanha@gmail.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowan=
g@redhat.com> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Ma=
ximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > > > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ily=
a Maximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > > > > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM J=
ason Wang <jasowang@redhat.com> wrote:
> > > > > > > > > > > > > > > >>>>
> > > > > > > > > > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM =
Ilya Maximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > > > >> It is noticeably more performant than a ta=
p with vhost=3Don in terms of PPS.
> > > > > > > > > > > > > > > >> So, that might be one case.  Taking into a=
ccount that just rcu lock and
> > > > > > > > > > > > > > > >> unlock in virtio-net code takes more time =
than a packet copy, some batching
> > > > > > > > > > > > > > > >> on QEMU side should improve performance si=
gnificantly.  And it shouldn't be
> > > > > > > > > > > > > > > >> too hard to implement.
> > > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > > >> Performance over virtual interfaces may po=
tentially be improved by creating
> > > > > > > > > > > > > > > >> a kernel thread for async Tx.  Similarly t=
o what io_uring allows.  Currently
> > > > > > > > > > > > > > > >> Tx on non-zero-copy interfaces is synchron=
ous, and that doesn't allow to
> > > > > > > > > > > > > > > >> scale well.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Interestingly, actually, there are a lot of=
 "duplication" between
> > > > > > > > > > > > > > > > io_uring and AF_XDP:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > 1) both have similar memory model (user reg=
ister)
> > > > > > > > > > > > > > > > 2) both use ring for communication
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > I wonder if we can let io_uring talks direc=
tly to AF_XDP.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Well, if we submit poll() in QEMU main loop v=
ia io_uring, then we can
> > > > > > > > > > > > > > > avoid cost of the synchronous Tx for non-zero=
-copy modes, i.e. for
> > > > > > > > > > > > > > > virtual interfaces.  io_uring thread in the k=
ernel will be able to
> > > > > > > > > > > > > > > perform transmission for us.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > It would be nice if we can use iothread/vhost o=
ther than the main loop
> > > > > > > > > > > > > > even if io_uring can use kthreads. We can avoid=
 the memory translation
> > > > > > > > > > > > > > cost.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The QEMU event loop (AioContext) has io_uring cod=
e
> > > > > > > > > > > > > (utils/fdmon-io_uring.c) but it's disabled at the=
 moment. I'm working
> > > > > > > > > > > > > on patches to re-enable it and will probably send=
 them in July. The
> > > > > > > > > > > > > patches also add an API to submit arbitrary io_ur=
ing operations so
> > > > > > > > > > > > > that you can do stuff besides file descriptor mon=
itoring. Both the
> > > > > > > > > > > > > main loop and IOThreads will be able to use io_ur=
ing on Linux hosts.
> > > > > > > > > > > >
> > > > > > > > > > > > Just to make sure I understand. If we still need a =
copy from guest to
> > > > > > > > > > > > io_uring buffer, we still need to go via memory API=
 for GPA which
> > > > > > > > > > > > seems expensive.
> > > > > > > > > > > >
> > > > > > > > > > > > Vhost seems to be a shortcut for this.
> > > > > > > > > > >
> > > > > > > > > > > I'm not sure how exactly you're thinking of using io_=
uring.
> > > > > > > > > > >
> > > > > > > > > > > Simply using io_uring for the event loop (file descri=
ptor monitoring)
> > > > > > > > > > > doesn't involve an extra buffer, but the packet paylo=
ad still needs to
> > > > > > > > > > > reside in AF_XDP umem, so there is a copy between gue=
st memory and
> > > > > > > > > > > umem.
> > > > > > > > > >
> > > > > > > > > > So there would be a translation from GPA to HVA (unless=
 io_uring
> > > > > > > > > > support 2 stages) which needs to go via qemu memory cor=
e. And this
> > > > > > > > > > part seems to be very expensive according to my test in=
 the past.
> > > > > > > > >
> > > > > > > > > Yes, but in the current approach where AF_XDP is implemen=
ted as a QEMU
> > > > > > > > > netdev, there is already QEMU device emulation (e.g. virt=
io-net)
> > > > > > > > > happening. So the GPA to HVA translation will happen anyw=
ay in device
> > > > > > > > > emulation.
> > > > > > > >
> > > > > > > > Just to make sure we're on the same page.
> > > > > > > >
> > > > > > > > I meant, AF_XDP can do more than e.g 10Mpps. So if we still=
 use the
> > > > > > > > QEMU netdev, it would be very hard to achieve that if we st=
ick to
> > > > > > > > using the Qemu memory core translations which need to take =
care about
> > > > > > > > too much extra stuff. That's why I suggest using vhost in i=
o threads
> > > > > > > > which only cares about ram so the translation could be very=
 fast.
> > > > > > >
> > > > > > > What does using "vhost in io threads" mean?
> > > > > >
> > > > > > It means a vhost userspace dataplane that is implemented via io=
 threads.
> > > > >
> > > > > AFAIK this does not exist today. QEMU's built-in devices that use
> > > > > IOThreads don't use vhost code. QEMU vhost code is for vhost kern=
el,
> > > > > vhost-user, or vDPA but not built-in devices that use IOThreads. =
The
> > > > > built-in devices implement VirtioDeviceClass callbacks directly a=
nd
> > > > > use AioContext APIs to run in IOThreads.
> > > >
> > > > Yes.
> > > >
> > > > >
> > > > > Do you have an idea for using vhost code for built-in devices? Ma=
ybe
> > > > > it's fastest if you explain your idea and its advantages instead =
of me
> > > > > guessing.
> > > >
> > > > It's something like I'd proposed in [1]:
> > > >
> > > > 1) a vhost that is implemented via IOThreads
> > > > 2) memory translation is done via vhost memory table/IOTLB
> > > >
> > > > The advantages are:
> > > >
> > > > 1) No 3rd application like DPDK application
> > > > 2) Attack surface were reduced
> > > > 3) Better understanding/interactions with device model for things l=
ike
> > > > RSS and IOMMU
> > > >
> > > > There could be some dis-advantages but it's not obvious to me :)
> > >
> > > Why is QEMU's native device emulation API not the natural choice for
> > > writing built-in devices? I don't understand why the vhost interface
> > > is desirable for built-in devices.
> >
> > Unless the memory helpers (like address translations) were optimized
> > fully to satisfy this 10M+ PPS.
> >
> > Not sure if this is too hard, but last time I benchmark, perf told me
> > most of the time spent in the translation.
> >
> > Using a vhost is a workaround since its memory model is much more
> > simpler so it can skip lots of memory sections like I/O and ROM etc.
>
> I see, that sounds like a question of optimization. Most DMA transfers
> will be to/from guest RAM and it seems like QEMU's memory API could be
> optimized for that case. PIO/MMIO dispatch could use a different API
> from DMA transfers, if necessary.

Probably.

>
> I don't think there is a fundamental reason why QEMU's own device
> emulation code cannot translate memory as fast as vhost devices can.

Yes, it can do what vhost can do. Starting from a vhost may help us to
know where we could go for the optimization of the memory core.

Thanks

>
> Stefan
>


