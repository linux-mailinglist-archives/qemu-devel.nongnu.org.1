Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0174E511
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 05:03:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3eC-0002SU-Nv; Mon, 10 Jul 2023 23:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3eA-0002Iq-Ok
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3e8-0006Xq-J5
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689044555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wcyp/LGiMuUc0rZj1TD1oQcAAU45m8401Yr4YwOmGwo=;
 b=afa1k0kZuZOHVqsJ6+OhmkT6TkGFZ/IHTe73DlK/AHfgaxkj4SE+QnZ52O8A+BOR+yD//W
 FXruZ3U24w/m/kJ88XlpVZFhi4SivasfWNyk5oB4Kcm6S8fse9ZA2ftaABIuZXEmZ5FFPR
 ijNd8GYAfMUxwOFqFRTXOEF+BokcEKk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-nrDJninKOUKC4Pp9baeIhw-1; Mon, 10 Jul 2023 23:02:34 -0400
X-MC-Unique: nrDJninKOUKC4Pp9baeIhw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b707829eb9so47117931fa.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 20:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044552; x=1691636552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wcyp/LGiMuUc0rZj1TD1oQcAAU45m8401Yr4YwOmGwo=;
 b=Ggw7Tgal6nrIEh5eXyU+X0LCunuKGxR+N/l1Oz7/R0sdt2ZZAHeHGl3fRp4TTZ+uG0
 zj/geC34e1vgaY2dZ6BXwFMl1Bl7xnKljbC1XrqHGRwUpQxwx1KAi2E9ff9nFyiOuXqA
 /MRbwx1WhqixuCUMXeNgVHFH3OVP7lkWOuneiYvB2wY5ehtm7yx7kwiLgoB8bl7fVXYC
 2+muL88MW4sorIk0PGVpTj2KGjdRCMH0yMZTQKNYTJBzjohlqxjVH43cbMjH8nqaHXrC
 RDaaUwkwlPCpTwdtLNZxfhe3qB+WtsA3JsWmhaDxuyrb/3SAH/J8O2HuMFbDaTme+3to
 iFCA==
X-Gm-Message-State: ABy/qLZNpmJI82RQBqT9+0uu0cXo/2I8KRMZVz0ivPO/kol3KGa/KWJQ
 RhkC8vhytUDnaT+WwAWzTwpVHpThVCJ+8N49XpnbujAqj5g1BsdNZaVZTwaSwNEdYS+JDH4JFJY
 HL02fvE8pKd3eEr3JVfGzb5mIhKXsRTRpZCkZdT6bug==
X-Received: by 2002:a2e:a405:0:b0:2b7:65:fca2 with SMTP id
 p5-20020a2ea405000000b002b70065fca2mr11864120ljn.49.1689044552289; 
 Mon, 10 Jul 2023 20:02:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHY1Ha8c/FbtCrYx7IGqlXmrHJLS+URE3OkBYSVnf2VibgVAjfO48NByZs/JjkN9qC7XuJOTS8MDVkjfJ713+E=
X-Received: by 2002:a2e:a405:0:b0:2b7:65:fca2 with SMTP id
 p5-20020a2ea405000000b002b70065fca2mr11864109ljn.49.1689044551950; 
 Mon, 10 Jul 2023 20:02:31 -0700 (PDT)
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
 <CAJSP0QUmT7nXJ8xEJMabYOeEq3fNpyJ=MYbgm2g+3CgsH5cUYg@mail.gmail.com>
In-Reply-To: <CAJSP0QUmT7nXJ8xEJMabYOeEq3fNpyJ=MYbgm2g+3CgsH5cUYg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jul 2023 11:02:20 +0800
Message-ID: <CACGkMEuX_z8Fct0F4DZ+6kpPMxfwYa5o5r7_kMy-yPyQW6YO2g@mail.gmail.com>
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

On Mon, Jul 10, 2023 at 11:21=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.co=
m> wrote:
>
> On Mon, 10 Jul 2023 at 06:55, Ilya Maximets <i.maximets@ovn.org> wrote:
> >
> > On 7/10/23 05:51, Jason Wang wrote:
> > > On Fri, Jul 7, 2023 at 7:21=E2=80=AFPM Ilya Maximets <i.maximets@ovn.=
org> wrote:
> > >>
> > >> On 7/7/23 03:43, Jason Wang wrote:
> > >>> On Fri, Jul 7, 2023 at 3:08=E2=80=AFAM Stefan Hajnoczi <stefanha@gm=
ail.com> wrote:
> > >>>>
> > >>>> On Wed, 5 Jul 2023 at 02:02, Jason Wang <jasowang@redhat.com> wrot=
e:
> > >>>>>
> > >>>>> On Mon, Jul 3, 2023 at 5:03=E2=80=AFPM Stefan Hajnoczi <stefanha@=
gmail.com> wrote:
> > >>>>>>
> > >>>>>> On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> w=
rote:
> > >>>>>>>
> > >>>>>>> On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@gmail.com> wrote:
> > >>>>>>>>
> > >>>>>>>> On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com>=
 wrote:
> > >>>>>>>>>
> > >>>>>>>>> On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stef=
anha@gmail.com> wrote:
> > >>>>>>>>>>
> > >>>>>>>>>> On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.co=
m> wrote:
> > >>>>>>>>>>>
> > >>>>>>>>>>> On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <st=
efanha@gmail.com> wrote:
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.=
com> wrote:
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <=
stefanha@gmail.com> wrote:
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redha=
t.com> wrote:
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <=
i.maximets@ovn.org> wrote:
> > >>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>> On 6/27/23 04:54, Jason Wang wrote:
> > >>>>>>>>>>>>>>>>> On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets=
 <i.maximets@ovn.org> wrote:
> > >>>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>>> On 6/26/23 08:32, Jason Wang wrote:
> > >>>>>>>>>>>>>>>>>>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang =
<jasowang@redhat.com> wrote:
> > >>>>>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>>>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maxim=
ets <i.maximets@ovn.org> wrote:
> > >>>>>>>>>>>>>>>>>> It is noticeably more performant than a tap with vho=
st=3Don in terms of PPS.
> > >>>>>>>>>>>>>>>>>> So, that might be one case.  Taking into account tha=
t just rcu lock and
> > >>>>>>>>>>>>>>>>>> unlock in virtio-net code takes more time than a pac=
ket copy, some batching
> > >>>>>>>>>>>>>>>>>> on QEMU side should improve performance significantl=
y.  And it shouldn't be
> > >>>>>>>>>>>>>>>>>> too hard to implement.
> > >>>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>>> Performance over virtual interfaces may potentially =
be improved by creating
> > >>>>>>>>>>>>>>>>>> a kernel thread for async Tx.  Similarly to what io_=
uring allows.  Currently
> > >>>>>>>>>>>>>>>>>> Tx on non-zero-copy interfaces is synchronous, and t=
hat doesn't allow to
> > >>>>>>>>>>>>>>>>>> scale well.
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> Interestingly, actually, there are a lot of "duplicat=
ion" between
> > >>>>>>>>>>>>>>>>> io_uring and AF_XDP:
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> 1) both have similar memory model (user register)
> > >>>>>>>>>>>>>>>>> 2) both use ring for communication
> > >>>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>>> I wonder if we can let io_uring talks directly to AF_=
XDP.
> > >>>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>>> Well, if we submit poll() in QEMU main loop via io_uri=
ng, then we can
> > >>>>>>>>>>>>>>>> avoid cost of the synchronous Tx for non-zero-copy mod=
es, i.e. for
> > >>>>>>>>>>>>>>>> virtual interfaces.  io_uring thread in the kernel wil=
l be able to
> > >>>>>>>>>>>>>>>> perform transmission for us.
> > >>>>>>>>>>>>>>>
> > >>>>>>>>>>>>>>> It would be nice if we can use iothread/vhost other tha=
n the main loop
> > >>>>>>>>>>>>>>> even if io_uring can use kthreads. We can avoid the mem=
ory translation
> > >>>>>>>>>>>>>>> cost.
> > >>>>>>>>>>>>>>
> > >>>>>>>>>>>>>> The QEMU event loop (AioContext) has io_uring code
> > >>>>>>>>>>>>>> (utils/fdmon-io_uring.c) but it's disabled at the moment=
. I'm working
> > >>>>>>>>>>>>>> on patches to re-enable it and will probably send them i=
n July. The
> > >>>>>>>>>>>>>> patches also add an API to submit arbitrary io_uring ope=
rations so
> > >>>>>>>>>>>>>> that you can do stuff besides file descriptor monitoring=
. Both the
> > >>>>>>>>>>>>>> main loop and IOThreads will be able to use io_uring on =
Linux hosts.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> Just to make sure I understand. If we still need a copy f=
rom guest to
> > >>>>>>>>>>>>> io_uring buffer, we still need to go via memory API for G=
PA which
> > >>>>>>>>>>>>> seems expensive.
> > >>>>>>>>>>>>>
> > >>>>>>>>>>>>> Vhost seems to be a shortcut for this.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> I'm not sure how exactly you're thinking of using io_uring=
.
> > >>>>>>>>>>>>
> > >>>>>>>>>>>> Simply using io_uring for the event loop (file descriptor =
monitoring)
> > >>>>>>>>>>>> doesn't involve an extra buffer, but the packet payload st=
ill needs to
> > >>>>>>>>>>>> reside in AF_XDP umem, so there is a copy between guest me=
mory and
> > >>>>>>>>>>>> umem.
> > >>>>>>>>>>>
> > >>>>>>>>>>> So there would be a translation from GPA to HVA (unless io_=
uring
> > >>>>>>>>>>> support 2 stages) which needs to go via qemu memory core. A=
nd this
> > >>>>>>>>>>> part seems to be very expensive according to my test in the=
 past.
> > >>>>>>>>>>
> > >>>>>>>>>> Yes, but in the current approach where AF_XDP is implemented=
 as a QEMU
> > >>>>>>>>>> netdev, there is already QEMU device emulation (e.g. virtio-=
net)
> > >>>>>>>>>> happening. So the GPA to HVA translation will happen anyway =
in device
> > >>>>>>>>>> emulation.
> > >>>>>>>>>
> > >>>>>>>>> Just to make sure we're on the same page.
> > >>>>>>>>>
> > >>>>>>>>> I meant, AF_XDP can do more than e.g 10Mpps. So if we still u=
se the
> > >>>>>>>>> QEMU netdev, it would be very hard to achieve that if we stic=
k to
> > >>>>>>>>> using the Qemu memory core translations which need to take ca=
re about
> > >>>>>>>>> too much extra stuff. That's why I suggest using vhost in io =
threads
> > >>>>>>>>> which only cares about ram so the translation could be very f=
ast.
> > >>>>>>>>
> > >>>>>>>> What does using "vhost in io threads" mean?
> > >>>>>>>
> > >>>>>>> It means a vhost userspace dataplane that is implemented via io=
 threads.
> > >>>>>>
> > >>>>>> AFAIK this does not exist today. QEMU's built-in devices that us=
e
> > >>>>>> IOThreads don't use vhost code. QEMU vhost code is for vhost ker=
nel,
> > >>>>>> vhost-user, or vDPA but not built-in devices that use IOThreads.=
 The
> > >>>>>> built-in devices implement VirtioDeviceClass callbacks directly =
and
> > >>>>>> use AioContext APIs to run in IOThreads.
> > >>>>>
> > >>>>> Yes.
> > >>>>>
> > >>>>>>
> > >>>>>> Do you have an idea for using vhost code for built-in devices? M=
aybe
> > >>>>>> it's fastest if you explain your idea and its advantages instead=
 of me
> > >>>>>> guessing.
> > >>>>>
> > >>>>> It's something like I'd proposed in [1]:
> > >>>>>
> > >>>>> 1) a vhost that is implemented via IOThreads
> > >>>>> 2) memory translation is done via vhost memory table/IOTLB
> > >>>>>
> > >>>>> The advantages are:
> > >>>>>
> > >>>>> 1) No 3rd application like DPDK application
> > >>>>> 2) Attack surface were reduced
> > >>>>> 3) Better understanding/interactions with device model for things=
 like
> > >>>>> RSS and IOMMU
> > >>>>>
> > >>>>> There could be some dis-advantages but it's not obvious to me :)
> > >>>>
> > >>>> Why is QEMU's native device emulation API not the natural choice f=
or
> > >>>> writing built-in devices? I don't understand why the vhost interfa=
ce
> > >>>> is desirable for built-in devices.
> > >>>
> > >>> Unless the memory helpers (like address translations) were optimize=
d
> > >>> fully to satisfy this 10M+ PPS.
> > >>>
> > >>> Not sure if this is too hard, but last time I benchmark, perf told =
me
> > >>> most of the time spent in the translation.
> > >>>
> > >>> Using a vhost is a workaround since its memory model is much more
> > >>> simpler so it can skip lots of memory sections like I/O and ROM etc=
.
> > >>
> > >> So, we can have a thread running as part of QEMU process that implem=
ents
> > >> vhost functionality for a virtio-net device.  And this thread has an
> > >> optimized way to access memory.  What prevents current virtio-net em=
ulation
> > >> code accessing memory in the same optimized way?
> > >
> > > Current emulation using memory core accessors which needs to take car=
e
> > > of a lot of stuff like MMIO or even P2P. Such kind of stuff is not
> > > considered since day0 of vhost. You can do some experiment on this e.=
g
> > > just dropping packets after fetching it from the TX ring.
> >
> > If I'm reading that right, virtio implementation is using address space
> > caching by utilizing a memory listener and pre-translated addresses of
> > interesting memory regions.  Then it's performing address_space_read_ca=
ched,
> > which is bypassing all the memory address translation logic on a cache =
hit.
> > That sounds pretty similar to how memory table is prepared for vhost.
>
> Exactly, but only for the vring memory structures (avail, used, and
> descriptor rings in the Split Virtqueue Layout).

Yes. It should speed up somehow.

>
> The packet headers and payloads are still translated using the
> uncached virtqueue_pop() -> dma_memory_map() -> address_space_map()
> API.
>
> Running a tx packet drop benchmark as Jason suggested and checking if
> memory translation is a bottleneck seems worthwhile. Improving
> dma_memory_map() performance would speed up all built-in QEMU devices.

+1

>
> Jason: When you noticed this bottleneck, were you using a normal
> virtio-net-pci device without vIOMMU?

Normal virtio-net-pci device without vIOMMU.

Thanks

>
> Stefan
>


