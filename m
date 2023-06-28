Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1FB740AF4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:15:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQKa-0001qr-N4; Wed, 28 Jun 2023 04:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEQKY-0001qV-Uk
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:15:14 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qEQKW-0002p5-Ju
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:15:14 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1b07d97180dso307274fac.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687940111; x=1690532111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amb9PdwzK2dq9guvrH6cRIZhhG/JGq0GF5KwBk9VNfA=;
 b=d1Jno0Pv+A04irrCHa5YQIOsj2EjPLGgIMyvieJuV669SRgiiDoWXB7Slh9AkjtIZw
 0MR6V9EPpKRVZ0ThuF4UBoNmz9qlbX05sMpKdNzLtgJoY4trOyhjbSAD64h2RHBl9QDV
 JJ/NIxv3bHfeBhfaj9rb0f7H5jxVvJ+ElSCcVEAOf3o9mbngC1yMHlngtcK/k8Pqy9YA
 rs6pG/fXFQIEPopSvSz1xwL2njzR5TfnbQH5vfpWZ2uK35/LZommnTDJpx0SSwE6OBz9
 l9yKQmEU/h9xYnljtGF3goKe6/MbOABkaFvS7rqsxFjDiRziwtcKvseD6W3MgrzxlAI3
 O1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687940111; x=1690532111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amb9PdwzK2dq9guvrH6cRIZhhG/JGq0GF5KwBk9VNfA=;
 b=gmiSfI8ZaLJqWRPEN1RFDt1SaJ+TX/r6EJRPqTij7XVO0YGksK1c4QhUgBXZpfpfnQ
 0pDDxLgEpjfAtZCHUVtDfbCVOZiItJyFaJDbC+rXU9qJBRiJAIx1DAx796HqJ+0Y4wlH
 yqle8YFu5nPHXUYphmKZFM88x5mZpuwSB4nXy8ycQUQkE38jM9iA84eazLF7xstyRfcn
 HGIqcaZqQBAP3KiRNs9B+ufJLx9gYmmq3P5OENob4NGt/38iWbbcVW3qyNH1wMzeE6pI
 jeOO922DMaMM0T3sFObQKSM7rckrkdTNNbT9YUi1MDM3xCbRdxp6TNV2R1C4Q5UGo2QC
 Or2w==
X-Gm-Message-State: AC+VfDxJjXBpljRkM0fgwbMdsF4zZ8Xe4H5X55CEgvQd3LA6Rl1ZzkS2
 aosXyoAPZETUo8uYwk/mk/n+E0jUwUJgsvU2XrY=
X-Google-Smtp-Source: ACHHUZ4seFrivwI9oWU4qo/dt4KFr9zDwj5Q12FxGxWyZU9VLjdLLJ0Vy/bKkvAyKMEawtlr+NGPbgAwjhJshFNUhEA=
X-Received: by 2002:a05:6870:e916:b0:1b0:6e5b:21d6 with SMTP id
 l22-20020a056870e91600b001b06e5b21d6mr2655483oan.38.1687940110819; Wed, 28
 Jun 2023 01:15:10 -0700 (PDT)
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
In-Reply-To: <CACGkMEuN_PeXZhqaN4EJP8rKRVK=wftpkH3--y267j9+7smCOw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 28 Jun 2023 10:14:59 +0200
Message-ID: <CAJSP0QVg-mmtnMXZpxRKutbdgpdNeawJT45iQSp4cf=MRedZAQ@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Jason Wang <jasowang@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x36.google.com
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

On Wed, 28 Jun 2023 at 09:59, Jason Wang <jasowang@redhat.com> wrote:
>
> On Wed, Jun 28, 2023 at 3:46=E2=80=AFPM Stefan Hajnoczi <stefanha@gmail.c=
om> wrote:
> >
> > On Wed, 28 Jun 2023 at 05:28, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, Jun 28, 2023 at 6:45=E2=80=AFAM Ilya Maximets <i.maximets@ovn=
.org> wrote:
> > > >
> > > > On 6/27/23 04:54, Jason Wang wrote:
> > > > > On Mon, Jun 26, 2023 at 9:17=E2=80=AFPM Ilya Maximets <i.maximets=
@ovn.org> wrote:
> > > > >>
> > > > >> On 6/26/23 08:32, Jason Wang wrote:
> > > > >>> On Sun, Jun 25, 2023 at 3:06=E2=80=AFPM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > >>>>
> > > > >>>> On Fri, Jun 23, 2023 at 5:58=E2=80=AFAM Ilya Maximets <i.maxim=
ets@ovn.org> wrote:
> > > > >> It is noticeably more performant than a tap with vhost=3Don in t=
erms of PPS.
> > > > >> So, that might be one case.  Taking into account that just rcu l=
ock and
> > > > >> unlock in virtio-net code takes more time than a packet copy, so=
me batching
> > > > >> on QEMU side should improve performance significantly.  And it s=
houldn't be
> > > > >> too hard to implement.
> > > > >>
> > > > >> Performance over virtual interfaces may potentially be improved =
by creating
> > > > >> a kernel thread for async Tx.  Similarly to what io_uring allows=
.  Currently
> > > > >> Tx on non-zero-copy interfaces is synchronous, and that doesn't =
allow to
> > > > >> scale well.
> > > > >
> > > > > Interestingly, actually, there are a lot of "duplication" between
> > > > > io_uring and AF_XDP:
> > > > >
> > > > > 1) both have similar memory model (user register)
> > > > > 2) both use ring for communication
> > > > >
> > > > > I wonder if we can let io_uring talks directly to AF_XDP.
> > > >
> > > > Well, if we submit poll() in QEMU main loop via io_uring, then we c=
an
> > > > avoid cost of the synchronous Tx for non-zero-copy modes, i.e. for
> > > > virtual interfaces.  io_uring thread in the kernel will be able to
> > > > perform transmission for us.
> > >
> > > It would be nice if we can use iothread/vhost other than the main loo=
p
> > > even if io_uring can use kthreads. We can avoid the memory translatio=
n
> > > cost.
> >
> > The QEMU event loop (AioContext) has io_uring code
> > (utils/fdmon-io_uring.c) but it's disabled at the moment. I'm working
> > on patches to re-enable it and will probably send them in July. The
> > patches also add an API to submit arbitrary io_uring operations so
> > that you can do stuff besides file descriptor monitoring. Both the
> > main loop and IOThreads will be able to use io_uring on Linux hosts.
>
> Just to make sure I understand. If we still need a copy from guest to
> io_uring buffer, we still need to go via memory API for GPA which
> seems expensive.
>
> Vhost seems to be a shortcut for this.

I'm not sure how exactly you're thinking of using io_uring.

Simply using io_uring for the event loop (file descriptor monitoring)
doesn't involve an extra buffer, but the packet payload still needs to
reside in AF_XDP umem, so there is a copy between guest memory and
umem. If umem encompasses guest memory, it may be possible to avoid
copying the packet payload.

Stefan

