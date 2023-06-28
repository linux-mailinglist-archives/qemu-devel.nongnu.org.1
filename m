Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3A740B06
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQOM-0004Bv-3b; Wed, 28 Jun 2023 04:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEQOK-00049k-9X
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEQOI-00053c-GC
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687940343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNkfr1UHDFDHL3+w5814ZQ5u855zwHwr0Fl0WweB62g=;
 b=F+855w5C6QHS5eyco4goPFdpR+KPG956TI49Bw0NgPNxoiC6fxbpplkdk9R8ADPai/m/rA
 E12bROOFVw1TclxEWL5O1AHSTCYbkdJHE0JC8lqtD1GJ1pxO0X7ShsZegWexcB7UNXjvIu
 koKwpYfk8/1QLCqXcDJRuitlnzItzek=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-1VuyOBiCMeaU7tnC5dAY7g-1; Wed, 28 Jun 2023 04:19:01 -0400
X-MC-Unique: 1VuyOBiCMeaU7tnC5dAY7g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b698377ed7so34423241fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687940340; x=1690532340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNkfr1UHDFDHL3+w5814ZQ5u855zwHwr0Fl0WweB62g=;
 b=U2AWH8IMddx2Lb1o4/UCZpygR2aCw/5IlrDVVIkLD3YY8QGH196t5t5xUi77eg7ePr
 SeDblE0eBOTXoLzntwal8bgFau8HoSynjwB6dR+dT7LPrSi/DXu/5517dnUz7stzb7XO
 tmEXrvIw4ZjakdoEjzDE/QDddQFb9pzoBrltV8jcs4nd6fVerpw0vCWhMPB1zHc2RDRy
 8K1boZRo7NQKZk1QKwVAaN/4a7sSJ9n3BGUq7XxBrgDMuoOpLqTkj4oMxVpP7IF7u73j
 xbKQuS8XvaqYHUg4GLn8Q4lUxw5PsDP/R6K1SbyzKoxtmmppAXsMS1dBKCSmW7X3Ozr4
 ELqg==
X-Gm-Message-State: AC+VfDzFKQLwqmDKH0W4A+P7B5ZTqDUZHNKq/TCBvqSaVZssoHSvJ1DU
 l/gKSxpczx+hSSEX541mtTXiHZFP2jZqWCa9feoSCxXjocoUqks4oHAFZoaVKdjmowNbuEE1gYR
 UmwydN1P0674YL9mYHywCOgTBXJwyM14=
X-Received: by 2002:a2e:8894:0:b0:2b6:a0c2:edaa with SMTP id
 k20-20020a2e8894000000b002b6a0c2edaamr5968744lji.32.1687940340042; 
 Wed, 28 Jun 2023 01:19:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6hAYpdbkg4IxBrTcA4pjteLERNVjt/ENlwu3jZij7iLkyRIjG7fO+1kgM+Aw9ZjLiskxukgI5S8KVcw/avEQc=
X-Received: by 2002:a2e:8894:0:b0:2b6:a0c2:edaa with SMTP id
 k20-20020a2e8894000000b002b6a0c2edaamr5968730lji.32.1687940339664; Wed, 28
 Jun 2023 01:18:59 -0700 (PDT)
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
In-Reply-To: <CAJSP0QVg-mmtnMXZpxRKutbdgpdNeawJT45iQSp4cf=MRedZAQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 16:18:48 +0800
Message-ID: <CACGkMEtdk-Qi+5M+pEa9v=S_ehRs=m7Ux4=Sf6aqk0EqNzyQ5g@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > >
> > > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maximets@o=
vn.org> wrote:
> > > > >
> > > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.maxime=
ts@ovn.org> wrote:
> > > > > >>
> > > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > >>>>
> > > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.max=
imets@ovn.org> wrote:
> > > > > >> It is noticeably more performant than a tap with vhost=3Don in=
 terms of PPS.
> > > > > >> So, that might be one case.  Taking into account that just rcu=
 lock and
> > > > > >> unlock in virtio-net code takes more time than a packet copy, =
some batching
> > > > > >> on QEMU side should improve performance significantly.  And it=
 shouldn't be
> > > > > >> too hard to implement.
> > > > > >>
> > > > > >> Performance over virtual interfaces may potentially be improve=
d by creating
> > > > > >> a kernel thread for async Tx.  Similarly to what io_uring allo=
ws.  Currently
> > > > > >> Tx on non-zero-copy interfaces is synchronous, and that doesn'=
t allow to
> > > > > >> scale well.
> > > > > >
> > > > > > Interestingly, actually, there are a lot of "duplication" betwe=
en
> > > > > > io_uring and AF_XDP:
> > > > > >
> > > > > > 1) both have similar memory model (user register)
> > > > > > 2) both use ring for communication
> > > > > >
> > > > > > I wonder if we can let io_uring talks directly to AF_XDP.
> > > > >
> > > > > Well, if we submit poll() in QEMU main loop via io_uring, then we=
 can
> > > > > avoid cost of the synchronous Tx for non-zero-copy modes, i.e. fo=
r
> > > > > virtual interfaces.  io_uring thread in the kernel will be able t=
o
> > > > > perform transmission for us.
> > > >
> > > > It would be nice if we can use iothread/vhost other than the main l=
oop
> > > > even if io_uring can use kthreads. We can avoid the memory translat=
ion
> > > > cost.
> > >
> > > The QEMU event loop (AioContext) has io_uring code
> > > (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm working
> > > on patches to re-enable it and will probably send them in July. The
> > > patches also add an API to submit arbitrary io_uring operations so
> > > that you can do stuff besides file descriptor monitoring. Both the
> > > main loop and IOThreads will be able to use io_uring on Linux hosts.
> >
> > Just to make sure I understand. If we still need a copy from guest to
> > io_uring buffer, we still need to go via memory API for GPA which
> > seems expensive.
> >
> > Vhost seems to be a shortcut for this.
>
> I'm not sure how exactly you're thinking of using io_uring.
>
> Simply using io_uring for the event loop (file descriptor monitoring)
> doesn't involve an extra buffer, but the packet payload still needs to
> reside in AF_XDP umem, so there is a copy between guest memory and
> umem.

So there would be a translation from GPA to HVA (unless io_uring
support 2 stages) which needs to go via qemu memory core. And this
part seems to be very expensive according to my test in the past.

> If umem encompasses guest memory,

It requires you to pin the whole guest memory and a GPA to HVA
translation is still required.

Thanks

>it may be possible to avoid
> copying the packet payload.
>
> Stefan
>


