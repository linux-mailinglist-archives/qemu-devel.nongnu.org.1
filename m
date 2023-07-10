Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C674D9A4
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:15:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsbM-0006Wi-K9; Mon, 10 Jul 2023 11:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qIsbJ-0006Uy-5H
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:14:57 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qIsbH-0004vX-74
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:14:56 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5661eb57452so2810456eaf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689002093; x=1691594093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+eQNQQ1fyyKdnQEl5UcajFIMm7aoxtxnXVN9BDS2sU=;
 b=Ay6SjiP8YgK9QKsJwQ7opvcrUCK2EZUm04flLEYJ2ed23+0U2PDHO7bzfCPS6kNuLL
 YV3iCBXf0H3aN5Kub3uRvSpjHVYy5g2I8VIUU7pZpMYYvfsKH3cY0gl/0sVmIOsRPgql
 VAjgYcTifUm+k5PNvnTGnRHiv6JmdXfVdG/CvIINvGzqadMs9+HKQP4O+5aMox2DKoL6
 9vJjQCUHRAuKvpBXHH4JwxAERB5D6SpMwqjvDcw07b0Y66XxwpgRuSoIBdFf33bq49h6
 SUtBiO7k6iF2EWwmNISaa/28MdrV8cRpSlYXjUNDfmgAlyoWwTwWB9f+tC0Lb7y/OKbf
 lgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689002093; x=1691594093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r+eQNQQ1fyyKdnQEl5UcajFIMm7aoxtxnXVN9BDS2sU=;
 b=S+wwGCwT3G+U0tENTJlBLJFvK+hwdKDTdr6BLlLRC9RvgXrrYso9j5TRTJOvJ6Be5e
 LkjY9qXYuaiQxtv1UI0v5XA0nZBpjVy9MVFoU7QJvt0nNsG46bP2i68t0KyozHBxVpnE
 EX4iaNYr/qoDCPP55dUY6zq3yFvMC8pkTVndn4cWj5TUKJHSuEP3itfMySy5wdu3w2zp
 KaAI76j3YOAfr/aKFZWOcbAEOAZOt3ci3hbR1y7q4AN2vmSiDx0SB7YGkgE6I88vVFFD
 NYdUMRfbdHPsKfI5dG7vcPXM4xYtZAvtz/ISc/AM0lqpKdjGXGCq7fjJbdP0r0DZ3bOj
 b0gw==
X-Gm-Message-State: ABy/qLYVSdJCA97HGMsZb4x6QzyKZt9xxMsktS+rwIg4UtDT+LfnIrQQ
 NzCeS3bIiVJBXap6NZMG1B0p/xTjiJJH18CTmgc=
X-Google-Smtp-Source: APBJJlGJ9SPTLdPiJqYjZXvcgIBkgnw/DIyAQdzGPeSYllTyY1mdJrB9TWEVU1X5UrGBXXQTp5s7EwvmalHOdBGGMNQ=
X-Received: by 2002:a4a:4992:0:b0:565:84b0:845d with SMTP id
 z140-20020a4a4992000000b0056584b0845dmr8485219ooa.6.1689002093419; Mon, 10
 Jul 2023 08:14:53 -0700 (PDT)
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
In-Reply-To: <CACGkMEsk65V4OiDB==fKSZ8us=FGz4u3Cj5un+2YYXep+OrQXw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Jul 2023 11:14:41 -0400
Message-ID: <CAJSP0QV1nYMKNkcphaLLH_te3Un_ep5not9pAW17zXEPaw2MsQ@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Jason Wang <jasowang@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 6 Jul 2023 at 21:43, Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Jul 7, 2023 at 3:08=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> >
> > On Wed, 5 Jul 2023 at 02:02, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Jul 3, 2023 at 5:03=E2=80=AFPM Stefan Hajnoczi <stefanha@gmai=
l.com> wrote:
> > > >
> > > > On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> wrot=
e:
> > > > >
> > > > > On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefanha=
@gmail.com> wrote:
> > > > > >
> > > > > > On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > > > >
> > > > > > > On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stef=
anha@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <=
stefanha@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoc=
zi <stefanha@gmail.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maxi=
mets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya =
Maximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > > > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jas=
on Wang <jasowang@redhat.com> wrote:
> > > > > > > > > > > > > > >>>>
> > > > > > > > > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Il=
ya Maximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > > >> It is noticeably more performant than a tap =
with vhost=3Don in terms of PPS.
> > > > > > > > > > > > > > >> So, that might be one case.  Taking into acc=
ount that just rcu lock and
> > > > > > > > > > > > > > >> unlock in virtio-net code takes more time th=
an a packet copy, some batching
> > > > > > > > > > > > > > >> on QEMU side should improve performance sign=
ificantly.  And it shouldn't be
> > > > > > > > > > > > > > >> too hard to implement.
> > > > > > > > > > > > > > >>
> > > > > > > > > > > > > > >> Performance over virtual interfaces may pote=
ntially be improved by creating
> > > > > > > > > > > > > > >> a kernel thread for async Tx.  Similarly to =
what io_uring allows.  Currently
> > > > > > > > > > > > > > >> Tx on non-zero-copy interfaces is synchronou=
s, and that doesn't allow to
> > > > > > > > > > > > > > >> scale well.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Interestingly, actually, there are a lot of "=
duplication" between
> > > > > > > > > > > > > > > io_uring and AF_XDP:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > 1) both have similar memory model (user regis=
ter)
> > > > > > > > > > > > > > > 2) both use ring for communication
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I wonder if we can let io_uring talks directl=
y to AF_XDP.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Well, if we submit poll() in QEMU main loop via=
 io_uring, then we can
> > > > > > > > > > > > > > avoid cost of the synchronous Tx for non-zero-c=
opy modes, i.e. for
> > > > > > > > > > > > > > virtual interfaces.  io_uring thread in the ker=
nel will be able to
> > > > > > > > > > > > > > perform transmission for us.
> > > > > > > > > > > > >
> > > > > > > > > > > > > It would be nice if we can use iothread/vhost oth=
er than the main loop
> > > > > > > > > > > > > even if io_uring can use kthreads. We can avoid t=
he memory translation
> > > > > > > > > > > > > cost.
> > > > > > > > > > > >
> > > > > > > > > > > > The QEMU event loop (AioContext) has io_uring code
> > > > > > > > > > > > (utils/fdmon-io_uring.c) but it's disabled at the m=
oment. I'm working
> > > > > > > > > > > > on patches to re-enable it and will probably send t=
hem in July. The
> > > > > > > > > > > > patches also add an API to submit arbitrary io_urin=
g operations so
> > > > > > > > > > > > that you can do stuff besides file descriptor monit=
oring. Both the
> > > > > > > > > > > > main loop and IOThreads will be able to use io_urin=
g on Linux hosts.
> > > > > > > > > > >
> > > > > > > > > > > Just to make sure I understand. If we still need a co=
py from guest to
> > > > > > > > > > > io_uring buffer, we still need to go via memory API f=
or GPA which
> > > > > > > > > > > seems expensive.
> > > > > > > > > > >
> > > > > > > > > > > Vhost seems to be a shortcut for this.
> > > > > > > > > >
> > > > > > > > > > I'm not sure how exactly you're thinking of using io_ur=
ing.
> > > > > > > > > >
> > > > > > > > > > Simply using io_uring for the event loop (file descript=
or monitoring)
> > > > > > > > > > doesn't involve an extra buffer, but the packet payload=
 still needs to
> > > > > > > > > > reside in AF_XDP umem, so there is a copy between guest=
 memory and
> > > > > > > > > > umem.
> > > > > > > > >
> > > > > > > > > So there would be a translation from GPA to HVA (unless i=
o_uring
> > > > > > > > > support 2 stages) which needs to go via qemu memory core.=
 And this
> > > > > > > > > part seems to be very expensive according to my test in t=
he past.
> > > > > > > >
> > > > > > > > Yes, but in the current approach where AF_XDP is implemente=
d as a QEMU
> > > > > > > > netdev, there is already QEMU device emulation (e.g. virtio=
-net)
> > > > > > > > happening. So the GPA to HVA translation will happen anyway=
 in device
> > > > > > > > emulation.
> > > > > > >
> > > > > > > Just to make sure we're on the same page.
> > > > > > >
> > > > > > > I meant, AF_XDP can do more than e.g 10Mpps. So if we still u=
se the
> > > > > > > QEMU netdev, it would be very hard to achieve that if we stic=
k to
> > > > > > > using the Qemu memory core translations which need to take ca=
re about
> > > > > > > too much extra stuff. That's why I suggest using vhost in io =
threads
> > > > > > > which only cares about ram so the translation could be very f=
ast.
> > > > > >
> > > > > > What does using "vhost in io threads" mean?
> > > > >
> > > > > It means a vhost userspace dataplane that is implemented via io t=
hreads.
> > > >
> > > > AFAIK this does not exist today. QEMU's built-in devices that use
> > > > IOThreads don't use vhost code. QEMU vhost code is for vhost kernel=
,
> > > > vhost-user, or vDPA but not built-in devices that use IOThreads. Th=
e
> > > > built-in devices implement VirtioDeviceClass callbacks directly and
> > > > use AioContext APIs to run in IOThreads.
> > >
> > > Yes.
> > >
> > > >
> > > > Do you have an idea for using vhost code for built-in devices? Mayb=
e
> > > > it's fastest if you explain your idea and its advantages instead of=
 me
> > > > guessing.
> > >
> > > It's something like I'd proposed in [1]:
> > >
> > > 1) a vhost that is implemented via IOThreads
> > > 2) memory translation is done via vhost memory table/IOTLB
> > >
> > > The advantages are:
> > >
> > > 1) No 3rd application like DPDK application
> > > 2) Attack surface were reduced
> > > 3) Better understanding/interactions with device model for things lik=
e
> > > RSS and IOMMU
> > >
> > > There could be some dis-advantages but it's not obvious to me :)
> >
> > Why is QEMU's native device emulation API not the natural choice for
> > writing built-in devices? I don't understand why the vhost interface
> > is desirable for built-in devices.
>
> Unless the memory helpers (like address translations) were optimized
> fully to satisfy this 10M+ PPS.
>
> Not sure if this is too hard, but last time I benchmark, perf told me
> most of the time spent in the translation.
>
> Using a vhost is a workaround since its memory model is much more
> simpler so it can skip lots of memory sections like I/O and ROM etc.

I see, that sounds like a question of optimization. Most DMA transfers
will be to/from guest RAM and it seems like QEMU's memory API could be
optimized for that case. PIO/MMIO dispatch could use a different API
from DMA transfers, if necessary.

I don't think there is a fundamental reason why QEMU's own device
emulation code cannot translate memory as fast as vhost devices can.

Stefan

