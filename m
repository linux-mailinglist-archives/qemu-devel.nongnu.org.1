Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8674A893
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 03:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHaVM-0001rA-0m; Thu, 06 Jul 2023 21:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHaVJ-0001qo-Tu
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 21:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHaVH-0005R4-MM
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 21:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688694200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZRMmvjz61VZOqRpArLxh55UpoSMtjU8NCIqCKvFz/Y=;
 b=DbhaXtDC4quDGfmhh8hgF3QsA3B/EHbRRQ9TFgkqm6JSO2CG7QVr7AZ4BjKpDx6ZmMTS0+
 51u+HsfEKEcX2sxCxXzBiVQzZNiW0B+DjSitslAhBoznn3CAFe/sdKsInlm7VIs6I8GfHD
 /L8uu3GU0HCd9dE8dan9QTbKCG0KYKI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-qc7xX3icNq-xfGCoMeAW3Q-1; Thu, 06 Jul 2023 21:43:18 -0400
X-MC-Unique: qc7xX3icNq-xfGCoMeAW3Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6fbee0642so8030011fa.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 18:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688694197; x=1691286197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eZRMmvjz61VZOqRpArLxh55UpoSMtjU8NCIqCKvFz/Y=;
 b=NQ0bDga/9IA6r/jXlMBNDrYr1aSH8p8/t1DIbVPMFy6kmYzIi/8Yc5LV3iWWyWDWKQ
 ly+u4bEXemKShYUcw6sv1mwDegAI1MDsroYgtXNpDwT07xQNWvkFiMpFE1YKMbnZ3ZGz
 0K8OBb3m7PVJ76oyYOhd0RMnbilN4Pz7nc2+Edz8aQaWSY9+nK8UXARsw8cBOwev2VOM
 ZnF9YPnejfJO8pDXEIH9c9A7h9rgpU6KBIBZlfW2IlBskeKW7fqs5jniHC7jlnJSrCip
 6ekMKsG1zF8UC6IXSeWCAd2z4lcqpUztgPCaNT+hQMGIT23wGpOHkw/v6gm7Yzjd3Yk/
 edbA==
X-Gm-Message-State: ABy/qLZ0L6/iShcpm1yWsfM+ituW54tRnCNeh7YNL/CjfRKm8AMwkmip
 XXnROzQ+8Ai2l9AbAIWMN7xl/oLSB5fJWVNcHrVkzPmRXZQZkF9uxKC0xjdHOYDJ6gUM5vkxJst
 45rWpGqRYCuf8VzKq3CVCZDVtRfrG0Q8=
X-Received: by 2002:a2e:87d4:0:b0:2b6:d0fa:7023 with SMTP id
 v20-20020a2e87d4000000b002b6d0fa7023mr1461871ljj.24.1688694197326; 
 Thu, 06 Jul 2023 18:43:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHibliiO1w2qBWU0sNnQzVmxb9X792jcUBHQzR71Gv4qvprNKD7NWiQc2uTO8tB8yrARfqdJ6PhArNVDDPWKqY=
X-Received: by 2002:a2e:87d4:0:b0:2b6:d0fa:7023 with SMTP id
 v20-20020a2e87d4000000b002b6d0fa7023mr1461868ljj.24.1688694196951; Thu, 06
 Jul 2023 18:43:16 -0700 (PDT)
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
In-Reply-To: <CAJSP0QXbq2s-VoWyPz7wWXCnhrt3nOMeoxdhUL8cerxm1sMfeg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jul 2023 09:43:03 +0800
Message-ID: <CACGkMEsk65V4OiDB==fKSZ8us=FGz4u3Cj5un+2YYXep+OrQXw@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Fri, Jul 7, 2023 at 3:08=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
>
> On Wed, 5 Jul 2023 at 02:02, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Jul 3, 2023 at 5:03=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.=
com> wrote:
> > >
> > > On Fri, 30 Jun 2023 at 09:41, Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefanha@g=
mail.com> wrote:
> > > > >
> > > > > On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > > >
> > > > > > On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <st=
efanha@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat=
.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi=
 <stefanha@gmail.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maxime=
ts <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Ma=
ximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > >>
> > > > > > > > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason=
 Wang <jasowang@redhat.com> wrote:
> > > > > > > > > > > > > >>>>
> > > > > > > > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya=
 Maximets <i.maximets@ovn.org> wrote:
> > > > > > > > > > > > > >> It is noticeably more performant than a tap wi=
th vhost=3Don in terms of PPS.
> > > > > > > > > > > > > >> So, that might be one case.  Taking into accou=
nt that just rcu lock and
> > > > > > > > > > > > > >> unlock in virtio-net code takes more time than=
 a packet copy, some batching
> > > > > > > > > > > > > >> on QEMU side should improve performance signif=
icantly.  And it shouldn't be
> > > > > > > > > > > > > >> too hard to implement.
> > > > > > > > > > > > > >>
> > > > > > > > > > > > > >> Performance over virtual interfaces may potent=
ially be improved by creating
> > > > > > > > > > > > > >> a kernel thread for async Tx.  Similarly to wh=
at io_uring allows.  Currently
> > > > > > > > > > > > > >> Tx on non-zero-copy interfaces is synchronous,=
 and that doesn't allow to
> > > > > > > > > > > > > >> scale well.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Interestingly, actually, there are a lot of "du=
plication" between
> > > > > > > > > > > > > > io_uring and AF_XDP:
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > 1) both have similar memory model (user registe=
r)
> > > > > > > > > > > > > > 2) both use ring for communication
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I wonder if we can let io_uring talks directly =
to AF_XDP.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Well, if we submit poll() in QEMU main loop via i=
o_uring, then we can
> > > > > > > > > > > > > avoid cost of the synchronous Tx for non-zero-cop=
y modes, i.e. for
> > > > > > > > > > > > > virtual interfaces.  io_uring thread in the kerne=
l will be able to
> > > > > > > > > > > > > perform transmission for us.
> > > > > > > > > > > >
> > > > > > > > > > > > It would be nice if we can use iothread/vhost other=
 than the main loop
> > > > > > > > > > > > even if io_uring can use kthreads. We can avoid the=
 memory translation
> > > > > > > > > > > > cost.
> > > > > > > > > > >
> > > > > > > > > > > The QEMU event loop (AioContext) has io_uring code
> > > > > > > > > > > (utils/fdmon-io_uring.c) but it's disabled at the mom=
ent. I'm working
> > > > > > > > > > > on patches to re-enable it and will probably send the=
m in July. The
> > > > > > > > > > > patches also add an API to submit arbitrary io_uring =
operations so
> > > > > > > > > > > that you can do stuff besides file descriptor monitor=
ing. Both the
> > > > > > > > > > > main loop and IOThreads will be able to use io_uring =
on Linux hosts.
> > > > > > > > > >
> > > > > > > > > > Just to make sure I understand. If we still need a copy=
 from guest to
> > > > > > > > > > io_uring buffer, we still need to go via memory API for=
 GPA which
> > > > > > > > > > seems expensive.
> > > > > > > > > >
> > > > > > > > > > Vhost seems to be a shortcut for this.
> > > > > > > > >
> > > > > > > > > I'm not sure how exactly you're thinking of using io_urin=
g.
> > > > > > > > >
> > > > > > > > > Simply using io_uring for the event loop (file descriptor=
 monitoring)
> > > > > > > > > doesn't involve an extra buffer, but the packet payload s=
till needs to
> > > > > > > > > reside in AF_XDP umem, so there is a copy between guest m=
emory and
> > > > > > > > > umem.
> > > > > > > >
> > > > > > > > So there would be a translation from GPA to HVA (unless io_=
uring
> > > > > > > > support 2 stages) which needs to go via qemu memory core. A=
nd this
> > > > > > > > part seems to be very expensive according to my test in the=
 past.
> > > > > > >
> > > > > > > Yes, but in the current approach where AF_XDP is implemented =
as a QEMU
> > > > > > > netdev, there is already QEMU device emulation (e.g. virtio-n=
et)
> > > > > > > happening. So the GPA to HVA translation will happen anyway i=
n device
> > > > > > > emulation.
> > > > > >
> > > > > > Just to make sure we're on the same page.
> > > > > >
> > > > > > I meant, AF_XDP can do more than e.g 10Mpps. So if we still use=
 the
> > > > > > QEMU netdev, it would be very hard to achieve that if we stick =
to
> > > > > > using the Qemu memory core translations which need to take care=
 about
> > > > > > too much extra stuff. That's why I suggest using vhost in io th=
reads
> > > > > > which only cares about ram so the translation could be very fas=
t.
> > > > >
> > > > > What does using "vhost in io threads" mean?
> > > >
> > > > It means a vhost userspace dataplane that is implemented via io thr=
eads.
> > >
> > > AFAIK this does not exist today. QEMU's built-in devices that use
> > > IOThreads don't use vhost code. QEMU vhost code is for vhost kernel,
> > > vhost-user, or vDPA but not built-in devices that use IOThreads. The
> > > built-in devices implement VirtioDeviceClass callbacks directly and
> > > use AioContext APIs to run in IOThreads.
> >
> > Yes.
> >
> > >
> > > Do you have an idea for using vhost code for built-in devices? Maybe
> > > it's fastest if you explain your idea and its advantages instead of m=
e
> > > guessing.
> >
> > It's something like I'd proposed in [1]:
> >
> > 1) a vhost that is implemented via IOThreads
> > 2) memory translation is done via vhost memory table/IOTLB
> >
> > The advantages are:
> >
> > 1) No 3rd application like DPDK application
> > 2) Attack surface were reduced
> > 3) Better understanding/interactions with device model for things like
> > RSS and IOMMU
> >
> > There could be some dis-advantages but it's not obvious to me :)
>
> Why is QEMU's native device emulation API not the natural choice for
> writing built-in devices? I don't understand why the vhost interface
> is desirable for built-in devices.

Unless the memory helpers (like address translations) were optimized
fully to satisfy this 10M+ PPS.

Not sure if this is too hard, but last time I benchmark, perf told me
most of the time spent in the translation.

Using a vhost is a workaround since its memory model is much more
simpler so it can skip lots of memory sections like I/O and ROM etc.

Thanks

>
> >
> > It's something like linking SPDK/DPDK to Qemu.
>
> Sergio Lopez tried loading vhost-user devices as shared libraries that
> run in the QEMU process. It worked as an experiment but wasn't pursued
> further.
>
> I think that might make sense in specific cases where there is an
> existing vhost-user codebase that needs to run as part of QEMU.
>
> In this case the AF_XDP code is new, so it's not a case of moving
> existing code into QEMU.
>
> >
> > >
> > > > > > > Regarding pinning - I wonder if that's something that can be =
refined
> > > > > > > in the kernel by adding an AF_XDP flag that enables on-demand=
 pinning
> > > > > > > of umem. That way only rx and tx buffers that are currently i=
n use
> > > > > > > will be pinned. The disadvantage is the runtime overhead to p=
in/unpin
> > > > > > > pages. I'm not sure whether it's possible to implement this, =
I haven't
> > > > > > > checked the kernel code.
> > > > > >
> > > > > > It requires the device to do page faults which is not commonly
> > > > > > supported nowadays.
> > > > >
> > > > > I don't understand this comment. AF_XDP processes each rx/tx
> > > > > descriptor. At that point it can getuserpages() or similar in ord=
er to
> > > > > pin the page. When the memory is no longer needed, it can put tho=
se
> > > > > pages. No fault mechanism is needed. What am I missing?
> > > >
> > > > Ok, I think I kind of get you, you mean doing pinning while process=
ing
> > > > rx/tx buffers? It's not easy since GUP itself is not very fast, it =
may
> > > > hit PPS for sure.
> > >
> > > Yes. It's not as fast as permanently pinning rx/tx buffers, but it
> > > supports unpinned guest RAM.
> >
> > Right, it's a balance between pin and PPS. PPS seems to be more
> > important in this case.
> >
> > >
> > > There are variations on this approach, like keeping a certain amount
> > > of pages pinned after they have been used so the cost of
> > > pinning/unpinning can be avoided when the same pages are reused in th=
e
> > > future, but I don't know how effective that is in practice.
> > >
> > > Is there a more efficient approach without relying on hardware page
> > > fault support?
> >
> > I guess so, I see some slides that say device page fault is very slow.
> >
> > >
> > > My understanding is that hardware page fault support is not yet
> > > deployed. We'd be left with pinning guest RAM permanently or using a
> > > runtime pinning/unpinning approach like I've described.
> >
> > Probably.
> >
> > Thanks
> >
> > >
> > > Stefan
> > >
> >
>


