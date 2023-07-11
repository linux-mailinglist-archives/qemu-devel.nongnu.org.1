Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0A74E4FC
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 05:01:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3cm-00011D-Al; Mon, 10 Jul 2023 23:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3cj-000113-VU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qJ3cf-0006MV-Ub
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689044464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1ZzqXoYBzLDi9XZ0bYjZgwkaAo5xhKGCf7q/esRXQ4=;
 b=OmbJGzVd3YxV0MZnhX+FdvvbOux5wUr2JYcn1xw4LU/gEU82JZLUv1fUlr+nhQp4F+vFM4
 o64dSLGEALyRP9qymHVVvODG33pkQBmcFkcZcwaUjPYDXcT7Vu1s5ig7I6W7nGKQcFCL47
 BS6fVmY5PFyEJ8iw5jooZMUfA6mDaAI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-wWWjL8B-M92rMmTQbKAEmg-1; Mon, 10 Jul 2023 23:01:02 -0400
X-MC-Unique: wWWjL8B-M92rMmTQbKAEmg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b70bfcea94so35995921fa.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 20:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044461; x=1691636461;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y1ZzqXoYBzLDi9XZ0bYjZgwkaAo5xhKGCf7q/esRXQ4=;
 b=ffCTDj/vRgmaPnT/nqC+A0GHEhdMVhxTT539IQVeeoHm9gPywFJdL8BL35DVJAMd8U
 Wk+5QrWOE9iNiM/Xk+x0q+1GZ+Bs8n9kkh2jmM8xe3+RwOyssRDumYkOcCKbF6foO4M1
 Tahq++sQYfwVqgHXKjlXgPUT29y8ZTaNj8vpQ6BkD25wVcktyaYZ7dv9M8oUiuN0fydu
 4XIBFavqkAMkoyos15zzUoUXe5iIBNeeblXrHE+GfcFYLMaOkXT2iM1+c5Udm6yztKt7
 tSsJNhCDv+19JqK8nBd3+QvuCpHma40O5bvjHZ+0mutwUjwvq21TW76izwLkzmeyiklI
 M/5g==
X-Gm-Message-State: ABy/qLaPSw1FDPWze/zUljiZ+3CjkA4bkm5c2xFysgR2hq7xJ24kNnfm
 NASDScu1gzkdkGidFJ3G0M3RHuBU5vuPaV1phQm8WYUg41Kt5BELqpjeXMO2DBq89EGvlMDdoc4
 2V8fZnomhgfqtKsrIv16Uv8xvS0HFNtA=
X-Received: by 2002:a2e:9b15:0:b0:2b1:a89a:5f2b with SMTP id
 u21-20020a2e9b15000000b002b1a89a5f2bmr11912158lji.2.1689044460972; 
 Mon, 10 Jul 2023 20:01:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGf05UtpTAQ5qR76VBBfC491frKG3X2cW3M3XbaVNJgLXWht7aDWYYiCFnoI039DG03RsXKGW8JCM6INAiTfEU=
X-Received: by 2002:a2e:9b15:0:b0:2b1:a89a:5f2b with SMTP id
 u21-20020a2e9b15000000b002b1a89a5f2bmr11912143lji.2.1689044460589; Mon, 10
 Jul 2023 20:01:00 -0700 (PDT)
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
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Jul 2023 11:00:49 +0800
Message-ID: <CACGkMEsy951MJj0VNdhHL5aWeSpA2OA=mC8ptkVKm9uAOhpPHg@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
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

On Mon, Jul 10, 2023 at 6:55=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
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

It's only done for virtqueue metadata (desc, driver and device area),
we still need to do dma map for the packet buffer itself.

Thanks

>
> >
> >> i.e. we likely don't
> >> actually need to implement the whole vhost-virtio communication protoc=
ol
> >> in order to have faster memory access from the device emulation code.
> >> I mean, if vhost can access device memory faster, why device itself ca=
n't?
> >
> > I'm not saying it can't but it would end up with something similar to
> > vhost. And that's why I'm saying using vhost is a shortcut (at least
> > for a POC).
> >
> > Thanks
> >
> >>
> >> With that we could probably split the "datapath" part of the virtio-ne=
t
> >> emulation into a separate thread driven by iothread loop.
> >>
> >> Then add batch API for communication with a network backend (af-xdp) t=
o
> >> avoid per-packet calls.
> >>
> >> These are 3 more or less independent tasks that should allow the simil=
ar
> >> performance to a full fledged vhost control and dataplane implementati=
on
> >> inside QEMU.
> >>
> >> Or am I missing something? (Probably)
> >>
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>>>
> >>>>> It's something like linking SPDK/DPDK to Qemu.
> >>>>
> >>>> Sergio Lopez tried loading vhost-user devices as shared libraries th=
at
> >>>> run in the QEMU process. It worked as an experiment but wasn't pursu=
ed
> >>>> further.
> >>>>
> >>>> I think that might make sense in specific cases where there is an
> >>>> existing vhost-user codebase that needs to run as part of QEMU.
> >>>>
> >>>> In this case the AF_XDP code is new, so it's not a case of moving
> >>>> existing code into QEMU.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>>>> Regarding pinning - I wonder if that's something that can be r=
efined
> >>>>>>>>>> in the kernel by adding an AF_XDP flag that enables on-demand =
pinning
> >>>>>>>>>> of umem. That way only rx and tx buffers that are currently in=
 use
> >>>>>>>>>> will be pinned. The disadvantage is the runtime overhead to pi=
n/unpin
> >>>>>>>>>> pages. I'm not sure whether it's possible to implement this, I=
 haven't
> >>>>>>>>>> checked the kernel code.
> >>>>>>>>>
> >>>>>>>>> It requires the device to do page faults which is not commonly
> >>>>>>>>> supported nowadays.
> >>>>>>>>
> >>>>>>>> I don't understand this comment. AF_XDP processes each rx/tx
> >>>>>>>> descriptor. At that point it can getuserpages() or similar in or=
der to
> >>>>>>>> pin the page. When the memory is no longer needed, it can put th=
ose
> >>>>>>>> pages. No fault mechanism is needed. What am I missing?
> >>>>>>>
> >>>>>>> Ok, I think I kind of get you, you mean doing pinning while proce=
ssing
> >>>>>>> rx/tx buffers? It's not easy since GUP itself is not very fast, i=
t may
> >>>>>>> hit PPS for sure.
> >>>>>>
> >>>>>> Yes. It's not as fast as permanently pinning rx/tx buffers, but it
> >>>>>> supports unpinned guest RAM.
> >>>>>
> >>>>> Right, it's a balance between pin and PPS. PPS seems to be more
> >>>>> important in this case.
> >>>>>
> >>>>>>
> >>>>>> There are variations on this approach, like keeping a certain amou=
nt
> >>>>>> of pages pinned after they have been used so the cost of
> >>>>>> pinning/unpinning can be avoided when the same pages are reused in=
 the
> >>>>>> future, but I don't know how effective that is in practice.
> >>>>>>
> >>>>>> Is there a more efficient approach without relying on hardware pag=
e
> >>>>>> fault support?
> >>>>>
> >>>>> I guess so, I see some slides that say device page fault is very sl=
ow.
> >>>>>
> >>>>>>
> >>>>>> My understanding is that hardware page fault support is not yet
> >>>>>> deployed. We'd be left with pinning guest RAM permanently or using=
 a
> >>>>>> runtime pinning/unpinning approach like I've described.
> >>>>>
> >>>>> Probably.
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>>
> >>>>>> Stefan
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
>


