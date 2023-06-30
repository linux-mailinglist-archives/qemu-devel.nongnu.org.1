Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2D7743605
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8lB-0004a3-Tt; Fri, 30 Jun 2023 03:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF8lA-0004Zt-3C
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qF8l7-0006DG-Ui
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688110896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fl2h//qTb6kufArg6CpLc7lkq/Woqx5v0BcU4p3wplM=;
 b=gCwWT0puCBgDr799mK5WW6C1YqLbDbT5jRuNCrzE8hm1AGv2HR1zIVqg3GY0uYfW4mOTr9
 7IgcXKJxgajCHIhKOkyWoffXZnwK5jbLp0oj+mbKze30BmC41tZuEGUGApv1fa9g6BvOpu
 2T6uHKEl3AB+oMy1Jfwe88i4uXqn9fk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-SomnZnKCPeidt0mVhY-OrA-1; Fri, 30 Jun 2023 03:41:18 -0400
X-MC-Unique: SomnZnKCPeidt0mVhY-OrA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b69de8fb27so14348461fa.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 00:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688110877; x=1690702877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fl2h//qTb6kufArg6CpLc7lkq/Woqx5v0BcU4p3wplM=;
 b=DYocDjjLDKUZmN8ShN0ddzjJDYEFFdHUSt62E3Ap4dTfBqXtXD3DQ6x5Qti/BNf27h
 v3RyDy/gvB/UTyhApVh8eFUAalurA115wmtDejHwzZgsYU9ettl14eH2Xk6c3MsjFtpk
 UhBfY9yLl5S1KHou5V0i728o9a4po0YA8PNl7NzIDl7bZyFDmmjl7OYn7H0D3ey7DwPf
 E47jcrDuc62WlOBc8BqJmTGw8M56isJ0nMxlQZZGvr7ou7TxuqoSUbl3KaLmyO5LVlIR
 CkPsEiHQ335DtfzFcXaC+gYjz0BmSQ246ro9NqDplyL8dJJRLNEDEXliWODqE7H5rRnS
 DUmA==
X-Gm-Message-State: ABy/qLYjUYcv/b1xZS09Nza4PELapdfkh2i85Ao1XCSSOd+EN0nxBZ3U
 M89VM1qZWg7T0k8kGA/VPcUfiZrdz/A8epFJa36tO9EbO4daCeQWJLzTfUFeMBbNOYiI4UNASse
 n3a32qt0esbwNi6jgPYcz8V6DuETLlO8=
X-Received: by 2002:a2e:350e:0:b0:2b6:c619:c5c4 with SMTP id
 z14-20020a2e350e000000b002b6c619c5c4mr1347353ljz.35.1688110877219; 
 Fri, 30 Jun 2023 00:41:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF0LL3NEdMlIfcwZY9pPOtJy5lwQKMzBSAbMoS1nyuIyF106b/TtYujNYik1U+Txr2NJ8kNyPk3NCAiPeer9AQ=
X-Received: by 2002:a2e:350e:0:b0:2b6:c619:c5c4 with SMTP id
 z14-20020a2e350e000000b002b6c619c5c4mr1347333ljz.35.1688110876880; Fri, 30
 Jun 2023 00:41:16 -0700 (PDT)
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
In-Reply-To: <CAJSP0QUtCnE49YWA6PmVSExMaFf2VZi3St1Wysk9ruDS37ALHg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 30 Jun 2023 15:41:05 +0800
Message-ID: <CACGkMEu1V4HBdP3JFYV-+Uec1s6f0U3fj5f9tV0FApQ+U8rbrw@mail.gmail.com>
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

On Thu, Jun 29, 2023 at 8:36=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Thu, 29 Jun 2023 at 07:26, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 4:25=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > >
> > > On Wed, 28 Jun 2023 at 10:19, Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > > > >
> > > > > > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stefan=
ha@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com=
> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.ma=
ximets@ovn.org> wrote:
> > > > > > > > >
> > > > > > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <=
i.maximets@ovn.org> wrote:
> > > > > > > > > >>
> > > > > > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <j=
asowang@redhat.com> wrote:
> > > > > > > > > >>>>
> > > > > > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximet=
s <i.maximets@ovn.org> wrote:
> > > > > > > > > >> It is noticeably more performant than a tap with vhost=
=3Don in terms of PPS.
> > > > > > > > > >> So, that might be one case.  Taking into account that =
just rcu lock and
> > > > > > > > > >> unlock in virtio-net code takes more time than a packe=
t copy, some batching
> > > > > > > > > >> on QEMU side should improve performance significantly.=
  And it shouldn't be
> > > > > > > > > >> too hard to implement.
> > > > > > > > > >>
> > > > > > > > > >> Performance over virtual interfaces may potentially be=
 improved by creating
> > > > > > > > > >> a kernel thread for async Tx.  Similarly to what io_ur=
ing allows.  Currently
> > > > > > > > > >> Tx on non-zero-copy interfaces is synchronous, and tha=
t doesn't allow to
> > > > > > > > > >> scale well.
> > > > > > > > > >
> > > > > > > > > > Interestingly, actually, there are a lot of "duplicatio=
n" between
> > > > > > > > > > io_uring and AF_XDP:
> > > > > > > > > >
> > > > > > > > > > 1) both have similar memory model (user register)
> > > > > > > > > > 2) both use ring for communication
> > > > > > > > > >
> > > > > > > > > > I wonder if we can let io_uring talks directly to AF_XD=
P.
> > > > > > > > >
> > > > > > > > > Well, if we submit poll() in QEMU main loop via io_uring,=
 then we can
> > > > > > > > > avoid cost of the synchronous Tx for non-zero-copy modes,=
 i.e. for
> > > > > > > > > virtual interfaces.  io_uring thread in the kernel will b=
e able to
> > > > > > > > > perform transmission for us.
> > > > > > > >
> > > > > > > > It would be nice if we can use iothread/vhost other than th=
e main loop
> > > > > > > > even if io_uring can use kthreads. We can avoid the memory =
translation
> > > > > > > > cost.
> > > > > > >
> > > > > > > The QEMU event loop (AioContext) has io_uring code
> > > > > > > (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm=
 working
> > > > > > > on patches to re-enable it and will probably send them in Jul=
y. The
> > > > > > > patches also add an API to submit arbitrary io_uring operatio=
ns so
> > > > > > > that you can do stuff besides file descriptor monitoring. Bot=
h the
> > > > > > > main loop and IOThreads will be able to use io_uring on Linux=
 hosts.
> > > > > >
> > > > > > Just to make sure I understand. If we still need a copy from gu=
est to
> > > > > > io_uring buffer, we still need to go via memory API for GPA whi=
ch
> > > > > > seems expensive.
> > > > > >
> > > > > > Vhost seems to be a shortcut for this.
> > > > >
> > > > > I'm not sure how exactly you're thinking of using io_uring.
> > > > >
> > > > > Simply using io_uring for the event loop (file descriptor monitor=
ing)
> > > > > doesn't involve an extra buffer, but the packet payload still nee=
ds to
> > > > > reside in AF_XDP umem, so there is a copy between guest memory an=
d
> > > > > umem.
> > > >
> > > > So there would be a translation from GPA to HVA (unless io_uring
> > > > support 2 stages) which needs to go via qemu memory core. And this
> > > > part seems to be very expensive according to my test in the past.
> > >
> > > Yes, but in the current approach where AF_XDP is implemented as a QEM=
U
> > > netdev, there is already QEMU device emulation (e.g. virtio-net)
> > > happening. So the GPA to HVA translation will happen anyway in device
> > > emulation.
> >
> > Just to make sure we're on the same page.
> >
> > I meant, AF_XDP can do more than e.g 10Mpps. So if we still use the
> > QEMU netdev, it would be very hard to achieve that if we stick to
> > using the Qemu memory core translations which need to take care about
> > too much extra stuff. That's why I suggest using vhost in io threads
> > which only cares about ram so the translation could be very fast.
>
> What does using "vhost in io threads" mean?

It means a vhost userspace dataplane that is implemented via io threads.

> Is that a vhost kernel
> approach where userspace dedicates threads (the stuff that Mike
> Christie has been working on)? I haven't looked at how Mike's recent
> patches work, but I wouldn't call that approach QEMU IOThreads,
> because the threads probably don't run the AioContext event loop and
> instead execute vhost kernel code the entire time.
>
> But despite these questions, I think I'm beginning to understand that
> you're proposing a vhost_net.ko AF_XDP implementation instead of a
> userspace QEMU AF_XDP netdev implementation.

Sorry for being unclear, but I'm not proposing that.

> I wonder if any
> optimizations can be made when the AF_XDP user is kernel code instead
> of userspace code.

The only possible way to go is to adapt AF_XDP umem memory model to
vhost which I'm not sure of anything we can gain.

>
> > >
> > > Are you thinking about AF_XDP passthrough where the guest directly
> > > interacts with AF_XDP?
> >
> > This could be another way to solve, since it won't use Qemu's memory
> > core to do the translation.
> >
> > >
> > > > > If umem encompasses guest memory,
> > > >
> > > > It requires you to pin the whole guest memory and a GPA to HVA
> > > > translation is still required.
> > >
> > > Ilya mentioned that umem uses relative offsets instead of absolute
> > > memory addresses. In the AF_XDP passthrough case this means no addres=
s
> > > translation needs to be added to AF_XDP.
> >
> > I don't see how it can avoid the translations as it works at the level
> > of HVA. But what guests submit is PA or even IOVA.
>
> In a passthrough scenario the guest is doing AF_XDP, so it writes
> relative umem offsets, thereby eliminating address translation
> concerns (the addresses are not PAs or IOVAs). However, this approach
> probably won't work well with memory hotplug - or at least it will end
> up becoming a memory translation mechanism in order to support memory
> hotplug.

Ok.

>
> >
> > What's more, guest memory could be backed by different memory
> > backends, this means a single umem may not even work.
>
> Maybe. I don't know the nature of umem. If there can be multiple vmas
> in the umem range, then there should be no issue mixing different
> memory backends.

If I understand correctly, a single umem requires contiguous VA at least.

>
> >
> > >
> > > Regarding pinning - I wonder if that's something that can be refined
> > > in the kernel by adding an AF_XDP flag that enables on-demand pinning
> > > of umem. That way only rx and tx buffers that are currently in use
> > > will be pinned. The disadvantage is the runtime overhead to pin/unpin
> > > pages. I'm not sure whether it's possible to implement this, I haven'=
t
> > > checked the kernel code.
> >
> > It requires the device to do page faults which is not commonly
> > supported nowadays.
>
> I don't understand this comment. AF_XDP processes each rx/tx
> descriptor. At that point it can getuserpages() or similar in order to
> pin the page. When the memory is no longer needed, it can put those
> pages. No fault mechanism is needed. What am I missing?

Ok, I think I kind of get you, you mean doing pinning while processing
rx/tx buffers? It's not easy since GUP itself is not very fast, it may
hit PPS for sure.

Thanks

>
> Stefan
>


