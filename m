Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4574D9CA
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 17:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIshz-0007ne-3K; Mon, 10 Jul 2023 11:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qIshp-0007kL-Ua
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:21:43 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qIshn-0007wN-2y
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 11:21:41 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5657d8ecdd3so2985143eaf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 08:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689002498; x=1691594498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=te2/r9prtObL84b8ndAWxqzmSD1mwQzUs7cigrzjWAk=;
 b=GEsaOzNEBPDHr/WcbJsZZ6aqxUxWe/Y/f3vDrXdXCfVh6Yk4f8s82DaeR0DOgWsRtH
 9FWIunptkV28+nfy91RYDmkYfPjK8RC6Krd0QbUdcL4iUgitivu8ssq11rXi1yAYnr6d
 w4hOLefOATF5CHs2Zqd7RKhSy/2M+3lPudTqzuLcWTpQ8TLsPHWfRUH6Jb9FhbLEtO9/
 6U7pvw/IB8Wf+vnW3PJDuNOjWeFgzV1DDfb2c0g3dwencQ69vJMPn0KxKDSSRB9molWg
 aljMTdUMBc9i4WyQi1zy7Cn3VBoWAlvRef80NuZDESQisiXhnCqi03QyD6HxhEmnxi0B
 fnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689002498; x=1691594498;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=te2/r9prtObL84b8ndAWxqzmSD1mwQzUs7cigrzjWAk=;
 b=NK41QwRXEiGmYdA1FV4AZCdCfpqjg4c+YAq4tut7qQjgj+jt5CI64S/Vp1YfbXy41K
 axIltF9X+ZV8KomAPUFYuPrtpbSUa3hjNX/5436NF1DrngAMeP22qd8smtZcZICZzZxo
 xHp4pjc9vbo5ITCHqOV1WYaSHZzDtqDTCmCo4LWMGIhHx1LEPHS+2s/B9hFihWfKXBi7
 NRoq2ytJ1Zw86qS3nQUwvr+paJR+dxc7Rls6/NroZXfgWX1O5n8JjNWnoTdpJ/BhFMw6
 jErNK+YOYnLLAL9H1aDe5zfWxxV2/2wEONqqnENO+PWE3N5UbxLf3ONprfTKAEM8/mqU
 cvFA==
X-Gm-Message-State: ABy/qLYhYCC0rgNkVZFpQA7v0DBWdHdEwhnfUuOYz6fYbmyrXjJlLUW5
 r8LScO93N813qb65Xb3PBr1+NjN5cMaJjiMQ+84=
X-Google-Smtp-Source: APBJJlFIEO0RbBNvZWLXm3znhti4VwNlbS2lp/VCx4UsUFLq9GoWC2UFmafSejdRVMolWgsVj4XkG84wqUzc+qSrXCs=
X-Received: by 2002:a4a:45ce:0:b0:565:a620:4efa with SMTP id
 y197-20020a4a45ce000000b00565a6204efamr7915706ooa.6.1689002497692; Mon, 10
 Jul 2023 08:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
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
 <005e9be8-74f6-5d68-f839-4f3b369c1672@ovn.org>
 <CACGkMEth7yqzFoivMZefu0khb2+RfkHAOs8uONwc6qpojXhV6Q@mail.gmail.com>
 <8788dbb9-1e6a-9917-65a5-22fc22d7fad9@ovn.org>
In-Reply-To: <8788dbb9-1e6a-9917-65a5-22fc22d7fad9@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 10 Jul 2023 11:21:25 -0400
Message-ID: <CAJSP0QUmT7nXJ8xEJMabYOeEq3fNpyJ=MYbgm2g+3CgsH5cUYg@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2e.google.com
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

On Mon, 10 Jul 2023 at 06:55, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> On 7/10/23 05:51, Jason Wang wrote:
> > On Fri, Jul 7, 2023 at 7:21=E2=80=AFPM Ilya Maximets <i.maximets@ovn.or=
g> wrote:
> >>
> >> On 7/7/23 03:43, Jason Wang wrote:
> >>> On Fri, Jul 7, 2023 at 3:08=E2=80=AFAM Stefan Hajnoczi <stefanha@gmai=
l.com> wrote:
> >>>>
> >>>> On Wed, 5 Jul 2023 at 02:02, Jason Wang <jasowang@redhat.com> wrote:
> >>>>>
> >>>>> On Mon, Jul 3, 2023 at 5:03=E2=80=AFPM Stefan Hajnoczi <stefanha@gm=
ail.com> wrote:
> >>>>>>
> >>>>>> On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> wro=
te:
> >>>>>>>
> >>>>>>> On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefanha=
@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> w=
rote:
> >>>>>>>>>
> >>>>>>>>> On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@gmail.com> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com>=
 wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stef=
anha@gmail.com> wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>> On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.co=
m> wrote:
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <st=
efanha@gmail.com> wrote:
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.=
com> wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.=
maximets@ovn.org> wrote:
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> On 6/27/23 04:54, Jason Wang wrote:
> >>>>>>>>>>>>>>>>> On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <=
i.maximets@ovn.org> wrote:
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> On 6/26/23 08:32, Jason Wang wrote:
> >>>>>>>>>>>>>>>>>>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <j=
asowang@redhat.com> wrote:
> >>>>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximet=
s <i.maximets@ovn.org> wrote:
> >>>>>>>>>>>>>>>>>> It is noticeably more performant than a tap with vhost=
=3Don in terms of PPS.
> >>>>>>>>>>>>>>>>>> So, that might be one case.  Taking into account that =
just rcu lock and
> >>>>>>>>>>>>>>>>>> unlock in virtio-net code takes more time than a packe=
t copy, some batching
> >>>>>>>>>>>>>>>>>> on QEMU side should improve performance significantly.=
  And it shouldn't be
> >>>>>>>>>>>>>>>>>> too hard to implement.
> >>>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>>> Performance over virtual interfaces may potentially be=
 improved by creating
> >>>>>>>>>>>>>>>>>> a kernel thread for async Tx.  Similarly to what io_ur=
ing allows.  Currently
> >>>>>>>>>>>>>>>>>> Tx on non-zero-copy interfaces is synchronous, and tha=
t doesn't allow to
> >>>>>>>>>>>>>>>>>> scale well.
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> Interestingly, actually, there are a lot of "duplicatio=
n" between
> >>>>>>>>>>>>>>>>> io_uring and AF_XDP:
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> 1) both have similar memory model (user register)
> >>>>>>>>>>>>>>>>> 2) both use ring for communication
> >>>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>>> I wonder if we can let io_uring talks directly to AF_XD=
P.
> >>>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>>> Well, if we submit poll() in QEMU main loop via io_uring=
, then we can
> >>>>>>>>>>>>>>>> avoid cost of the synchronous Tx for non-zero-copy modes=
, i.e. for
> >>>>>>>>>>>>>>>> virtual interfaces.  io_uring thread in the kernel will =
be able to
> >>>>>>>>>>>>>>>> perform transmission for us.
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> It would be nice if we can use iothread/vhost other than =
the main loop
> >>>>>>>>>>>>>>> even if io_uring can use kthreads. We can avoid the memor=
y translation
> >>>>>>>>>>>>>>> cost.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> The QEMU event loop (AioContext) has io_uring code
> >>>>>>>>>>>>>> (utils/fdmon-io_uring.c) but it's disabled at the moment. =
I'm working
> >>>>>>>>>>>>>> on patches to re-enable it and will probably send them in =
July. The
> >>>>>>>>>>>>>> patches also add an API to submit arbitrary io_uring opera=
tions so
> >>>>>>>>>>>>>> that you can do stuff besides file descriptor monitoring. =
Both the
> >>>>>>>>>>>>>> main loop and IOThreads will be able to use io_uring on Li=
nux hosts.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Just to make sure I understand. If we still need a copy fro=
m guest to
> >>>>>>>>>>>>> io_uring buffer, we still need to go via memory API for GPA=
 which
> >>>>>>>>>>>>> seems expensive.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Vhost seems to be a shortcut for this.
> >>>>>>>>>>>>
> >>>>>>>>>>>> I'm not sure how exactly you're thinking of using io_uring.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Simply using io_uring for the event loop (file descriptor mo=
nitoring)
> >>>>>>>>>>>> doesn't involve an extra buffer, but the packet payload stil=
l needs to
> >>>>>>>>>>>> reside in AF_XDP umem, so there is a copy between guest memo=
ry and
> >>>>>>>>>>>> umem.
> >>>>>>>>>>>
> >>>>>>>>>>> So there would be a translation from GPA to HVA (unless io_ur=
ing
> >>>>>>>>>>> support 2 stages) which needs to go via qemu memory core. And=
 this
> >>>>>>>>>>> part seems to be very expensive according to my test in the p=
ast.
> >>>>>>>>>>
> >>>>>>>>>> Yes, but in the current approach where AF_XDP is implemented a=
s a QEMU
> >>>>>>>>>> netdev, there is already QEMU device emulation (e.g. virtio-ne=
t)
> >>>>>>>>>> happening. So the GPA to HVA translation will happen anyway in=
 device
> >>>>>>>>>> emulation.
> >>>>>>>>>
> >>>>>>>>> Just to make sure we're on the same page.
> >>>>>>>>>
> >>>>>>>>> I meant, AF_XDP can do more than e.g 10Mpps. So if we still use=
 the
> >>>>>>>>> QEMU netdev, it would be very hard to achieve that if we stick =
to
> >>>>>>>>> using the Qemu memory core translations which need to take care=
 about
> >>>>>>>>> too much extra stuff. That's why I suggest using vhost in io th=
reads
> >>>>>>>>> which only cares about ram so the translation could be very fas=
t.
> >>>>>>>>
> >>>>>>>> What does using "vhost in io threads" mean?
> >>>>>>>
> >>>>>>> It means a vhost userspace dataplane that is implemented via io t=
hreads.
> >>>>>>
> >>>>>> AFAIK this does not exist today. QEMU's built-in devices that use
> >>>>>> IOThreads don't use vhost code. QEMU vhost code is for vhost kerne=
l,
> >>>>>> vhost-user, or vDPA but not built-in devices that use IOThreads. T=
he
> >>>>>> built-in devices implement VirtioDeviceClass callbacks directly an=
d
> >>>>>> use AioContext APIs to run in IOThreads.
> >>>>>
> >>>>> Yes.
> >>>>>
> >>>>>>
> >>>>>> Do you have an idea for using vhost code for built-in devices? May=
be
> >>>>>> it's fastest if you explain your idea and its advantages instead o=
f me
> >>>>>> guessing.
> >>>>>
> >>>>> It's something like I'd proposed in [1]:
> >>>>>
> >>>>> 1) a vhost that is implemented via IOThreads
> >>>>> 2) memory translation is done via vhost memory table/IOTLB
> >>>>>
> >>>>> The advantages are:
> >>>>>
> >>>>> 1) No 3rd application like DPDK application
> >>>>> 2) Attack surface were reduced
> >>>>> 3) Better understanding/interactions with device model for things l=
ike
> >>>>> RSS and IOMMU
> >>>>>
> >>>>> There could be some dis-advantages but it's not obvious to me :)
> >>>>
> >>>> Why is QEMU's native device emulation API not the natural choice for
> >>>> writing built-in devices? I don't understand why the vhost interface
> >>>> is desirable for built-in devices.
> >>>
> >>> Unless the memory helpers (like address translations) were optimized
> >>> fully to satisfy this 10M+ PPS.
> >>>
> >>> Not sure if this is too hard, but last time I benchmark, perf told me
> >>> most of the time spent in the translation.
> >>>
> >>> Using a vhost is a workaround since its memory model is much more
> >>> simpler so it can skip lots of memory sections like I/O and ROM etc.
> >>
> >> So, we can have a thread running as part of QEMU process that implemen=
ts
> >> vhost functionality for a virtio-net device.  And this thread has an
> >> optimized way to access memory.  What prevents current virtio-net emul=
ation
> >> code accessing memory in the same optimized way?
> >
> > Current emulation using memory core accessors which needs to take care
> > of a lot of stuff like MMIO or even P2P. Such kind of stuff is not
> > considered since day0 of vhost. You can do some experiment on this e.g
> > just dropping packets after fetching it from the TX ring.
>
> If I'm reading that right, virtio implementation is using address space
> caching by utilizing a memory listener and pre-translated addresses of
> interesting memory regions.  Then it's performing address_space_read_cach=
ed,
> which is bypassing all the memory address translation logic on a cache hi=
t.
> That sounds pretty similar to how memory table is prepared for vhost.

Exactly, but only for the vring memory structures (avail, used, and
descriptor rings in the Split Virtqueue Layout).

The packet headers and payloads are still translated using the
uncached virtqueue_pop() -> dma_memory_map() -> address_space_map()
API.

Running a tx packet drop benchmark as Jason suggested and checking if
memory translation is a bottleneck seems worthwhile. Improving
dma_memory_map() performance would speed up all built-in QEMU devices.

Jason: When you noticed this bottleneck, were you using a normal
virtio-net-pci device without vIOMMU?

Stefan

