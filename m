Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77874A439
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHULS-0004py-G5; Thu, 06 Jul 2023 15:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qHULQ-0004pW-Pt
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:08:48 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qHULO-0007kh-L4
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:08:48 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5661eb57452so736919eaf.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688670525; x=1691262525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUbgpZh5dTtBBd7uLmpCSUUZI7z0IHuHHMpQZDeYxUg=;
 b=VXD1AJD+rs5sLNQm5C98O4dpzB7Rk8j+bbklui+5MbhFfNRLq92Idi7snij3y+9ngv
 1MyxvPUXID6B+f62u2uxlF/ZcqSKRBVDxH6+SBrEizggrMRZKpxacizKUJhrjOe7QciG
 c8X/xwuxtRIILJRl+QMVU0GKKwSS9lxg0KLklZPqiBjlc+53LXxveYFNryyB0++VBMHw
 dShLwR8uAky/hcwRVoW5LGAlEhLp4PVUVMJ/6x4toJ80Dc5F6S5gEvGL3s5Ks82RMbBb
 5OHMB7Kk6WNssRRJghCO+4fa+IP9rzPe4MOf44U+61092josZTu5GZbAx5n9CTI0BcX/
 oQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688670525; x=1691262525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUbgpZh5dTtBBd7uLmpCSUUZI7z0IHuHHMpQZDeYxUg=;
 b=Lh/ind/FzC73BPOT2bmjyJ7h9ny6atibK5K/eAP+rNXL9s1oF3i3vZx64rmbl629QJ
 MRRnTqCnfWauA20M1wov1o0YWLyr5tqK5ouBEkDdomaaKu8ZtjB3Rj71SU26Rp6RIIIs
 KwXy//T2eYsb3C0NZ4TiQe/9IVw3KlHTCbhcT83bDxD7jf2xm/P9a+/HLA0WPCVeWAv0
 zUFimNVenaWPgeh/P/6Uz/LemYb24zizsfqyF7zV7c0XLC+AsS0qd1PWNgov+r8AwZWJ
 8pJxcQ06wUzgU3SIfXjKC/W3f+6yhNA8lJ38pLDktmdp/9cWHWrizSyesF29pW+ZupmO
 K4tg==
X-Gm-Message-State: ABy/qLbtvgNosuLfEpUbVt1ZRdr9M0UUm9GJHtO6djnvqvaFci48uAHn
 in7PgkOzZ//JoLcPWgIBS1Vc3Xx5loZKPw9LIGk=
X-Google-Smtp-Source: APBJJlEIkQ42oHPsP5AIDeVfPFgAI5gJGTmAQllFi2lbl4L7XCZgbOMPWWuzZXF70vEjdDBw64n34nwktHZE4lh0mto=
X-Received: by 2002:a4a:4f53:0:b0:563:60c9:44e9 with SMTP id
 c80-20020a4a4f53000000b0056360c944e9mr2035890oob.1.1688670524606; Thu, 06 Jul
 2023 12:08:44 -0700 (PDT)
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
In-Reply-To: <CACGkMEv2u-pcFY_+Y-r6ODj6hjEDUhVG5VV-cX0Fko7VNPZ=0g@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 6 Jul 2023 15:08:32 -0400
Message-ID: <CAJSP0QXbq2s-VoWyPz7wWXCnhrt3nOMeoxdhUL8cerxm1sMfeg@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Jason Wang <jasowang@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc29.google.com
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

On Wed, 5 Jul 2023 at 02:02, Jason Wang <jasowang@redhat.com> wrote:
>
> On Mon, Jul 3, 2023 at 5:03=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
> >
> > On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefanha@gma=
il.com> wrote:
> > > >
> > > > On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> wrot=
e:
> > > > >
> > > > > On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stefanha=
@gmail.com> wrote:
> > > > > >
> > > > > > On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > > > >
> > > > > > > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stef=
anha@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <=
stefanha@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets=
 <i.maximets@ovn.org> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maxi=
mets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason W=
ang <jasowang@redhat.com> wrote:
> > > > > > > > > > > > >>>>
> > > > > > > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya M=
aximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > >> It is noticeably more performant than a tap with=
 vhost=3Don in terms of PPS.
> > > > > > > > > > > > >> So, that might be one case.  Taking into account=
 that just rcu lock and
> > > > > > > > > > > > >> unlock in virtio-net code takes more time than a=
 packet copy, some batching
> > > > > > > > > > > > >> on QEMU side should improve performance signific=
antly.  And it shouldn't be
> > > > > > > > > > > > >> too hard to implement.
> > > > > > > > > > > > >>
> > > > > > > > > > > > >> Performance over virtual interfaces may potentia=
lly be improved by creating
> > > > > > > > > > > > >> a kernel thread for async Tx.  Similarly to what=
 io_uring allows.  Currently
> > > > > > > > > > > > >> Tx on non-zero-copy interfaces is synchronous, a=
nd that doesn't allow to
> > > > > > > > > > > > >> scale well.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Interestingly, actually, there are a lot of "dupl=
ication" between
> > > > > > > > > > > > > io_uring and AF_XDP:
> > > > > > > > > > > > >
> > > > > > > > > > > > > 1) both have similar memory model (user register)
> > > > > > > > > > > > > 2) both use ring for communication
> > > > > > > > > > > > >
> > > > > > > > > > > > > I wonder if we can let io_uring talks directly to=
 AF_XDP.
> > > > > > > > > > > >
> > > > > > > > > > > > Well, if we submit poll() in QEMU main loop via io_=
uring, then we can
> > > > > > > > > > > > avoid cost of the synchronous Tx for non-zero-copy =
modes, i.e. for
> > > > > > > > > > > > virtual interfaces.  io_uring thread in the kernel =
will be able to
> > > > > > > > > > > > perform transmission for us.
> > > > > > > > > > >
> > > > > > > > > > > It would be nice if we can use iothread/vhost other t=
han the main loop
> > > > > > > > > > > even if io_uring can use kthreads. We can avoid the m=
emory translation
> > > > > > > > > > > cost.
> > > > > > > > > >
> > > > > > > > > > The QEMU event loop (AioContext) has io_uring code
> > > > > > > > > > (utils/fdmon-io_uring.c) but it's disabled at the momen=
t. I'm working
> > > > > > > > > > on patches to re-enable it and will probably send them =
in July. The
> > > > > > > > > > patches also add an API to submit arbitrary io_uring op=
erations so
> > > > > > > > > > that you can do stuff besides file descriptor monitorin=
g. Both the
> > > > > > > > > > main loop and IOThreads will be able to use io_uring on=
 Linux hosts.
> > > > > > > > >
> > > > > > > > > Just to make sure I understand. If we still need a copy f=
rom guest to
> > > > > > > > > io_uring buffer, we still need to go via memory API for G=
PA which
> > > > > > > > > seems expensive.
> > > > > > > > >
> > > > > > > > > Vhost seems to be a shortcut for this.
> > > > > > > >
> > > > > > > > I'm not sure how exactly you're thinking of using io_uring.
> > > > > > > >
> > > > > > > > Simply using io_uring for the event loop (file descriptor m=
onitoring)
> > > > > > > > doesn't involve an extra buffer, but the packet payload sti=
ll needs to
> > > > > > > > reside in AF_XDP umem, so there is a copy between guest mem=
ory and
> > > > > > > > umem.
> > > > > > >
> > > > > > > So there would be a translation from GPA to HVA (unless io_ur=
ing
> > > > > > > support 2 stages) which needs to go via qemu memory core. And=
 this
> > > > > > > part seems to be very expensive according to my test in the p=
ast.
> > > > > >
> > > > > > Yes, but in the current approach where AF_XDP is implemented as=
 a QEMU
> > > > > > netdev, there is already QEMU device emulation (e.g. virtio-net=
)
> > > > > > happening. So the GPA to HVA translation will happen anyway in =
device
> > > > > > emulation.
> > > > >
> > > > > Just to make sure we're on the same page.
> > > > >
> > > > > I meant, AF_XDP can do more than e.g 10Mpps. So if we still use t=
he
> > > > > QEMU netdev, it would be very hard to achieve that if we stick to
> > > > > using the Qemu memory core translations which need to take care a=
bout
> > > > > too much extra stuff. That's why I suggest using vhost in io thre=
ads
> > > > > which only cares about ram so the translation could be very fast.
> > > >
> > > > What does using "vhost in io threads" mean?
> > >
> > > It means a vhost userspace dataplane that is implemented via io threa=
ds.
> >
> > AFAIK this does not exist today. QEMU's built-in devices that use
> > IOThreads don't use vhost code. QEMU vhost code is for vhost kernel,
> > vhost-user, or vDPA but not built-in devices that use IOThreads. The
> > built-in devices implement VirtioDeviceClass callbacks directly and
> > use AioContext APIs to run in IOThreads.
>
> Yes.
>
> >
> > Do you have an idea for using vhost code for built-in devices? Maybe
> > it's fastest if you explain your idea and its advantages instead of me
> > guessing.
>
> It's something like I'd proposed in [1]:
>
> 1) a vhost that is implemented via IOThreads
> 2) memory translation is done via vhost memory table/IOTLB
>
> The advantages are:
>
> 1) No 3rd application like DPDK application
> 2) Attack surface were reduced
> 3) Better understanding/interactions with device model for things like
> RSS and IOMMU
>
> There could be some dis-advantages but it's not obvious to me :)

Why is QEMU's native device emulation API not the natural choice for
writing built-in devices? I don't understand why the vhost interface
is desirable for built-in devices.

>
> It's something like linking SPDK/DPDK to Qemu.

Sergio Lopez tried loading vhost-user devices as shared libraries that
run in the QEMU process. It worked as an experiment but wasn't pursued
further.

I think that might make sense in specific cases where there is an
existing vhost-user codebase that needs to run as part of QEMU.

In this case the AF_XDP code is new, so it's not a case of moving
existing code into QEMU.

>
> >
> > > > > > Regarding pinning - I wonder if that's something that can be re=
fined
> > > > > > in the kernel by adding an AF_XDP flag that enables on-demand p=
inning
> > > > > > of umem. That way only rx and tx buffers that are currently in =
use
> > > > > > will be pinned. The disadvantage is the runtime overhead to pin=
/unpin
> > > > > > pages. I'm not sure whether it's possible to implement this, I =
haven't
> > > > > > checked the kernel code.
> > > > >
> > > > > It requires the device to do page faults which is not commonly
> > > > > supported nowadays.
> > > >
> > > > I don't understand this comment. AF_XDP processes each rx/tx
> > > > descriptor. At that point it can getuserpages() or similar in order=
 to
> > > > pin the page. When the memory is no longer needed, it can put those
> > > > pages. No fault mechanism is needed. What am I missing?
> > >
> > > Ok, I think I kind of get you, you mean doing pinning while processin=
g
> > > rx/tx buffers? It's not easy since GUP itself is not very fast, it ma=
y
> > > hit PPS for sure.
> >
> > Yes. It's not as fast as permanently pinning rx/tx buffers, but it
> > supports unpinned guest RAM.
>
> Right, it's a balance between pin and PPS. PPS seems to be more
> important in this case.
>
> >
> > There are variations on this approach, like keeping a certain amount
> > of pages pinned after they have been used so the cost of
> > pinning/unpinning can be avoided when the same pages are reused in the
> > future, but I don't know how effective that is in practice.
> >
> > Is there a more efficient approach without relying on hardware page
> > fault support?
>
> I guess so, I see some slides that say device page fault is very slow.
>
> >
> > My understanding is that hardware page fault support is not yet
> > deployed. We'd be left with pinning guest RAM permanently or using a
> > runtime pinning/unpinning approach like I've described.
>
> Probably.
>
> Thanks
>
> >
> > Stefan
> >
>

