Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B887B6D65
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhbN-0005ZJ-FJ; Tue, 03 Oct 2023 11:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnhbE-0005Wq-UA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:46:23 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnhbB-0004UJ-8E
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:46:15 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c4bad60a1aso697778a34.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696347971; x=1696952771; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AWhVrenavtcbKw4ZhcYUIEra2ebOrcPcbB2ptjf/EQA=;
 b=NlwR2nPvxYm0X85Ixp9OPMaTFubvOFLqw5pOYynTxCYHHAJB0X3JkwPPhWCFZEzZhC
 0xmqlTUplRNTEzRCpt3v0f2VF7qP+nFS9WiJ0bTwjZoQo5cy5uko6aPpM80FaKESHyfW
 SprhPktla8v0gRHC0H2f9p6k3sNB5rXIp9k3MnmOaHhQQG4Iw3OcXq0BpxedBFh8REZK
 uBmCWmtQD38NA3iv3QwB0PWOH7ns6FdHVduIKW+sMOkljk2jl3KirJFu/W/+MaB+RDjw
 9K/Liuk/qFvldDV712yCVI5XYTBvDVbELJoQ4bXvwbbrskuFWExvvqH6nDtap72nxD58
 RNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696347971; x=1696952771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AWhVrenavtcbKw4ZhcYUIEra2ebOrcPcbB2ptjf/EQA=;
 b=vQncjkFFp4ocrNZb+4JadtFAl8TAwf2iv6mEy3IuDvtKpLKJyEl8WJPuCy6INlY9/9
 snjy76pSMnBoz/Vui+iULPiG/inkvmdmH486wqt7djDnmEic3ey02AF1xWNLwg1I7wHB
 2yZZ7c7penL+TQXXhuHQFJdsRiXco4OiLYTcTnY5TuaEGkCjTxqhPzNNUhDgLxxIKySX
 ud1nm+C4QCbRGnsQzEAo2u5m1gTbM6d3e4SxSTeJzFVmrhSCayyWeM3hAd2HcKt19S4M
 dNfpgoAlrWJvaKcwr/ZZJmvWxKAAFoooNkBpT0+3aOpBN8sijifqprv8CqPYaPmFiW0T
 nccg==
X-Gm-Message-State: AOJu0YwNqNMW1ZR9ZgDN0Z3TbkbzzZRYITf+Oo+NYmZ5nzVIyEgvSVf1
 tGWeFTSehwxNjpo7eIT8r4cchqpbIsexdCD0vOM=
X-Google-Smtp-Source: AGHT+IH90PLwseOttK39wu9mtqMKg1+2DOjvVZtshBW/csFFFUYDfpz92tTRYhcLOOTesHrzJFEpEvHu/+TUY8PD5W4=
X-Received: by 2002:a05:6808:308d:b0:3a4:6b13:b721 with SMTP id
 bl13-20020a056808308d00b003a46b13b721mr16941731oib.46.1696347971191; Tue, 03
 Oct 2023 08:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230827182937.146450-1-lersek@redhat.com>
 <20230827182937.146450-8-lersek@redhat.com>
 <CAJSP0QVWSQ8F-A1ryGLtd1jb8Go1Pr_N7AcLb5W5kSFv8T8jTA@mail.gmail.com>
 <6d766ab4-b6b8-b64b-1f9d-60c558b56509@redhat.com>
 <CAJSP0QV9RO7bkkcVFibnTv4tixmO3wKohSY+ia1D-UZiRzh5QA@mail.gmail.com>
 <20231002015259-mutt-send-email-mst@kernel.org>
 <CAJSP0QXgWsULW_61-MScvuWAiE3c4brYRyFc6q_==Sj6aLE8SQ@mail.gmail.com>
 <CAJSP0QU3jzFGnJ35Zbabf70Tbf+rPA_fvrA_eNxZ8TxOXQxZXA@mail.gmail.com>
 <20231002183627-mutt-send-email-mst@kernel.org>
 <CAJSP0QWTRc6Ai+bM9_UwrpgXXmgvN=rMD248nqoGv0PiOd_2Sg@mail.gmail.com>
 <20231003103143-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231003103143-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Oct 2023 11:45:58 -0400
Message-ID: <CAJSP0QWYZE189K4V9yLyaNnZhAA_uPeH4myL+rLfNkZ5JuUOkA@mail.gmail.com>
Subject: Re: [PATCH 7/7] vhost-user: call VHOST_USER_SET_VRING_ENABLE
 synchronously
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>, 
 Liu Jiang <gerry@linux.alibaba.com>, Sergio Lopez Pascual <slp@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Oct 2023 at 10:40, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 03, 2023 at 09:08:15AM -0400, Stefan Hajnoczi wrote:
> > On Tue, 3 Oct 2023 at 08:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Mon, Oct 02, 2023 at 05:13:26PM -0400, Stefan Hajnoczi wrote:
> > > > One more question:
> > > >
> > > > Why is the disabled state not needed by regular (non-vhost) virtio-net devices?
> > >
> > > Tap does the same - it purges queued packets:
> > >
> > > int tap_disable(NetClientState *nc)
> > > {
> > >     TAPState *s = DO_UPCAST(TAPState, nc, nc);
> > >     int ret;
> > >
> > >     if (s->enabled == 0) {
> > >         return 0;
> > >     } else {
> > >         ret = tap_fd_disable(s->fd);
> > >         if (ret == 0) {
> > >             qemu_purge_queued_packets(nc);
> > >             s->enabled = false;
> > >             tap_update_fd_handler(s);
> > >         }
> > >         return ret;
> > >     }
> > > }
> >
> > tap_disable() is not equivalent to the vhost-user "started but
> > disabled" ring state. tap_disable() is a synchronous one-time action,
> > while "started but disabled" is a continuous state.
>
> well, yes. but practically guests do not queue too many buffers
> after disabling a queue. I don't know if they reliably don't
> or it's racy and we didn't notice it yet - I think it
> was mostly dpdk that had this and that's usually
> used with vhost-user.
>
> > The "started but disabled" ring state isn't needed to achieve this.
> > The back-end can just drop tx buffers upon receiving
> > VHOST_USER_SET_VRING_ENABLE .num=0.
>
> yes, maybe that would have been a better way to do this.
>
>
> > The history of the spec is curious. VHOST_USER_SET_VRING_ENABLE was
> > introduced before the the "started but disabled" state was defined,
> > and it explicitly mentions tap attach/detach:
> >
> > commit 7263a0ad7899994b719ebed736a1119cc2e08110
> > Author: Changchun Ouyang <changchun.ouyang@intel.com>
> > Date:   Wed Sep 23 12:20:01 2015 +0800
> >
> >     vhost-user: add a new message to disable/enable a specific virt queue.
> >
> >     Add a new message, VHOST_USER_SET_VRING_ENABLE, to enable or disable
> >     a specific virt queue, which is similar to attach/detach queue for
> >     tap device.
> >
> > and then later:
> >
> > commit c61f09ed855b5009f816242ce281fd01586d4646
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Mon Nov 23 12:48:52 2015 +0200
> >
> >     vhost-user: clarify start and enable
> >
> > >
> > > what about non tap backends? I suspect they just aren't
> > > used widely with multiqueue so no one noticed.
> >
> > I still don't understand why "started but disabled" is needed instead
> > of just two ring states: enabled and disabled.
>
> With dropping packets when ring is disabled? Maybe that would
> have been enough. I also failed to realize it's specific to
> net, seemed generic to me :(
>
> > It seems like the cleanest path going forward is to keep the "ignore
> > rx, discard tx" semantics for virtio-net devices but to clarify in the
> > spec that other device types do not process the ring:
> >
> > "
> > * started but disabled: the back-end must not process the ring. For legacy
> >   reasons there is an exception for the networking device, where the
> >   back-end must process and discard any TX packets and not process
> >   other rings.
> > "
> >
> > What do you think?
> >
> > Stefan
>
> Okay... I hope we are not missing any devices which need virtio net
> semantics. Care checking them all?

Sure, I will check them. I'm very curious myself whether virtio-vsock
is affected (it has rx and tx queues).

I will report back.

Stefan

>
> --
> MST
>

