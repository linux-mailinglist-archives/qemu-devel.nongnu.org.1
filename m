Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CB0740A2F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:00:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQ5C-0005Iw-Va; Wed, 28 Jun 2023 03:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEQ5B-0005HX-79
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qEQ59-00030p-D9
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687939158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ss2vhDeCJgXzZJSo6W1cECFqmw6tMqVtzFGMYfLquI=;
 b=Dh87hrYC0mRsou7UnXEsbJoCHQyDQ7fUSqEUPhKHuyMYmOAe1jLavcXjawHuHogAwssbAP
 O1jsLJopdwF5cVeiHWQx8eV/W4LkzP5/D12VFl+oFQVb6IUDbBCiDHwAN8pWUsM20BrxOc
 B8FyY8hYOk/WK8IlK56oPyMX4JwcOgg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-jgQwi-XFOyOmYq6weZOIYw-1; Wed, 28 Jun 2023 03:59:17 -0400
X-MC-Unique: jgQwi-XFOyOmYq6weZOIYw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6b5a7d882so11127941fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687939155; x=1690531155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ss2vhDeCJgXzZJSo6W1cECFqmw6tMqVtzFGMYfLquI=;
 b=ZCbjPNnlKeq43K5OH7bT1HIQSHE5VFV/O2Ar2gnSHRLkrtRytuVK+iKMnShtJ6nXq7
 vCMNExEq1f7zvi9GNzd7+i4nicAsbg3GoyHhwye7bxS1mUNyQOd/nSfMRp50IRytF8lW
 eg0pdg/eHiagwMd6+46qczp70AN6KE1hx3mZUWn+yoMZVZSr7LDmbXgDsC6sxURZV6wA
 8E7I7Tnq3QyXmBBFj3vVqs44rMTmCDGt0LXVXx4fl3MPuLkMUAgQBnrkFEuhbOF7vWFM
 /K1mwZJJvjfsvPGopXGOFHQswWj1FcOVfvMfAeSVTiqY2MWrKnTRB0xy0/aLn6qWaM/N
 HiXw==
X-Gm-Message-State: AC+VfDxy839Jmh0++swGpp36eD1xNIarFZFuSAIKT3Fw7PW256ka73nb
 Mi1rR3TVIqsHxJIB8LFXNWoRLPFw/+7AM6T2SeQ4jvqn3NmVUx9o5NY9Tq3iWoruVqLCrrfEGZm
 w7c2WKp2zRwGlPKMNJlhSpnqm8uHvjvE=
X-Received: by 2002:a2e:b042:0:b0:2b5:8102:1843 with SMTP id
 d2-20020a2eb042000000b002b581021843mr19388838ljl.18.1687939155542; 
 Wed, 28 Jun 2023 00:59:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZIWi6S+7fHITrqgbmB+eNGuBEtRIZMHPaT6aVjigx5zD5GSU25wwff/0G6ErlJsHQrmv0Yo6upNfNGUUuPfM=
X-Received: by 2002:a2e:b042:0:b0:2b5:8102:1843 with SMTP id
 d2-20020a2eb042000000b002b581021843mr19388823ljl.18.1687939155244; Wed, 28
 Jun 2023 00:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
 <CACGkMEsXOb8wiYo9ktgqh8MqD971=ARJ_etL7MBF-uyo6qt1eA@mail.gmail.com>
 <CACGkMEuyq+5_cqx4T03fcaLOGUCrKLZn51sZxNSXyZq8CqLXTg@mail.gmail.com>
 <93a056c4-b6d3-5491-0c1f-7f58e9f9d1ad@ovn.org>
 <CACGkMEuaUTGeCYfH-MbtX_79scN-CkBmFMcY0fwKo4vO_9cn4w@mail.gmail.com>
 <26c03cd4-5582-489c-9f4c-aeaf8e157b42@ovn.org>
 <CACGkMEsE6_91mOhCP5ezT96zz-Tb-bLXQr9ktrLg6zG0TZC3Lg@mail.gmail.com>
 <CAJSP0QXPiNK2rH6_8bB7sjMpdQjT--oX0u4FkdaTj7Ew3qs8CA@mail.gmail.com>
In-Reply-To: <CAJSP0QXPiNK2rH6_8bB7sjMpdQjT--oX0u4FkdaTj7Ew3qs8CA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 15:59:03 +0800
Message-ID: <CACGkMEuN_PeXZhqaN4EJP8rKRVK=wftpkH3--y267j9+7smCOw@mail.gmail.com>
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

On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.com=
> wrote:
>
> On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maximets@ovn.o=
rg> wrote:
> > >
> > > On 6/27/23 04:54, Jason Wang wrote:
> > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.maximets@o=
vn.org> wrote:
> > > >>
> > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowang@redh=
at.com> wrote:
> > > >>>>
> > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.maximet=
s@ovn.org> wrote:
> > > >> It is noticeably more performant than a tap with vhost=3Don in ter=
ms of PPS.
> > > >> So, that might be one case.  Taking into account that just rcu loc=
k and
> > > >> unlock in virtio-net code takes more time than a packet copy, some=
 batching
> > > >> on QEMU side should improve performance significantly.  And it sho=
uldn't be
> > > >> too hard to implement.
> > > >>
> > > >> Performance over virtual interfaces may potentially be improved by=
 creating
> > > >> a kernel thread for async Tx.  Similarly to what io_uring allows. =
 Currently
> > > >> Tx on non-zero-copy interfaces is synchronous, and that doesn't al=
low to
> > > >> scale well.
> > > >
> > > > Interestingly, actually, there are a lot of "duplication" between
> > > > io_uring and AF_XDP:
> > > >
> > > > 1) both have similar memory model (user register)
> > > > 2) both use ring for communication
> > > >
> > > > I wonder if we can let io_uring talks directly to AF_XDP.
> > >
> > > Well, if we submit poll() in QEMU main loop via io_uring, then we can
> > > avoid cost of the synchronous Tx for non-zero-copy modes, i.e. for
> > > virtual interfaces.  io_uring thread in the kernel will be able to
> > > perform transmission for us.
> >
> > It would be nice if we can use iothread/vhost other than the main loop
> > even if io_uring can use kthreads. We can avoid the memory translation
> > cost.
>
> The QEMU event loop (AioContext) has io_uring code
> (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm working
> on patches to re-enable it and will probably send them in July. The
> patches also add an API to submit arbitrary io_uring operations so
> that you can do stuff besides file descriptor monitoring. Both the
> main loop and IOThreads will be able to use io_uring on Linux hosts.

Just to make sure I understand. If we still need a copy from guest to
io_uring buffer, we still need to go via memory API for GPA which
seems expensive.

Vhost seems to be a shortcut for this.

Thanks

>
> Stefan
>


