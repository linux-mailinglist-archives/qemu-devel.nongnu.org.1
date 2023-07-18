Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32708757953
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLi0t-0007Wj-8N; Tue, 18 Jul 2023 06:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qLi0p-0007UE-F8
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qLi0n-0007iB-Jw
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689676375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJ9VjFOAX7KEpsqx+3rsCh7QB66sbTgBmRj0i8t7LUg=;
 b=cnLTzrudeYeQsBCnLZxLqMWpdR4XGyVqPXgFSIrI+OKtH6uzA0RyML63xU+67F0Tn+5q2T
 tB87+wFn03cL45XhP6jStcRkoQRGyVnLz1uqTMWiEqjKOto/JMRZNQq6zB+Ufgrr07VNbH
 SsqYqnIgOG3y9rSPJr6d/+FqIZI3ZFg=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-ReOdZIOFMhy6XpWnrRX_fg-1; Tue, 18 Jul 2023 06:32:54 -0400
X-MC-Unique: ReOdZIOFMhy6XpWnrRX_fg-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-579dd7e77f5so53222057b3.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689676373; x=1690281173;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJ9VjFOAX7KEpsqx+3rsCh7QB66sbTgBmRj0i8t7LUg=;
 b=ScSx7hkFcxhGvOLuPb+k9jJhBg3BgpIq38Igo/9Jtln7JFnaYpRo1hY+lfOplyFHvE
 z+I4peaQ22Y98mVGYBrIu1DlnkjhOTttEITGipx/uZdwbNTBemo+ZYu5wkJYmqpuN6QL
 5FZIDFLXMtnjRPX/bZQ3fJKvATPJBUN7tQMdd5+24EZl0JhSN+MgrxT0Wj7nPvKgLWsd
 NBS1A2LU5h8US9KADaigxGS+aLnwcH+p4H/b2KqG53/YXBytordhfpTdZstSDuvOWr+2
 l2mO2Ev82nk4Aw2EMx1NOpXMg6QWB/1MuM1DfWxfJMZfcBi351d26bWNCOalfSoxuCNO
 i6pA==
X-Gm-Message-State: ABy/qLaClIdtCXH2ezGFIhf1g5NeDWAB0HwWtWbg5xmHHYZvFfFa9PFf
 nyXNkqiNpZundfw7eUpw8rRvWG2cHXHkF70iPg/bYM/HInLV5I+88wt9KLuakMAoQQg6WZaQbSm
 TqdqSw9HZIIYWrXTRwmDyU3a02i7Mlsc=
X-Received: by 2002:a0d:d8c9:0:b0:56d:2490:7cde with SMTP id
 a192-20020a0dd8c9000000b0056d24907cdemr14789756ywe.50.1689676373083; 
 Tue, 18 Jul 2023 03:32:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHh8k3t3IqzzvYl1s7LPsoKr9b2R0bmumUYFEbPNxabAWjebYIVQ+sEo+6VeMyB0kSsryVx8PoR+hEwPIikfak=
X-Received: by 2002:a0d:d8c9:0:b0:56d:2490:7cde with SMTP id
 a192-20020a0dd8c9000000b0056d24907cdemr14789740ywe.50.1689676372798; Tue, 18
 Jul 2023 03:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225638.1467969-1-peili.dev@gmail.com>
 <CAJaqyWebSowMMWh+HCjj7tmbA3Ey6C69T=SPA4k+6fd_-GjfoA@mail.gmail.com>
 <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
In-Reply-To: <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 18 Jul 2023 12:32:41 +0200
Message-ID: <CAGxU2F4N+xAM0gRh2dHDLSujkJ4Ek--Hk+PoTHOsxe4k+GTrrA@mail.gmail.com>
Subject: vdpa: use io_uring passthrough command for IOCTLs [was Re: [PATCH
 1/2] Reduce vdpa initialization / startup overhead]
To: Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>, 
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: peili.dev@gmail.com, qemu devel list <qemu-devel@nongnu.org>, 
 Linux Virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Thu, Apr 20, 2023 at 6:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Apr 19, 2023 at 11:33=E2=80=AFPM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Wed, Apr 19, 2023 at 12:56=E2=80=AFAM <peili.dev@gmail.com> wrote:
> > >
> > > From: Pei Li <peili.dev@gmail.com>
> > >
> > > Currently, part of the vdpa initialization / startup process
> > > needs to trigger many ioctls per vq, which is very inefficient
> > > and causing unnecessary context switch between user mode and
> > > kernel mode.
> > >
> > > This patch creates an additional ioctl() command, namely
> > > VHOST_VDPA_GET_VRING_GROUP_BATCH, that will batching
> > > commands of VHOST_VDPA_GET_VRING_GROUP into a single
> > > ioctl() call.
>
> I'd expect there's a kernel patch but I didn't see that?
>
> If we want to go this way. Why simply have a more generic way, that is
> introducing something like:
>
> VHOST_CMD_BATCH which did something like
>
> struct vhost_cmd_batch {
>     int ncmds;
>     struct vhost_ioctls[];
> };
>
> Then you can batch other ioctls other than GET_VRING_GROUP?
>

Just restarting this discussion, since I recently worked more with
io_uring passthrough commands and I think it can help here.

The NVMe guys had a similar problem (ioctl too slow for their use
case)[1][2], so they developed a new feature in io_uring that
basically allows you to do IOCTLs asynchronously and in batches using
io_uring.

The same feature is also used by ublk [3] and I recently talked about
this at DevConf with German [4].

Basically, there's a new callback in fops (struct file_operations.uring_cmd=
).
IIUC for NVMe (drivers/nvme/host/ioctl.c) they used exactly the same
values used for IOCTLs also for the new uring_cmd callback.

We could do the same. The changes in the vhost-vdpa kernel module
should be simple, and we could share the code for handling ioctl and
uring_cmd.
That way any new command can be supported with both for compatibility.

In QEMU then we can start using it to optimize the control path.

What do you think?

If it's interesting, I could throw down an RFC with the changes or if
anyone is interested in working on it, I can help with the details.

Thanks,
Stefano

[1] https://lpc.events/event/11/contributions/989/
[2] https://lpc.events/event/16/contributions/1382/
[3] https://lwn.net/Articles/903855/
[4] https://www.youtube.com/watch?v=3D6JqNPirreoY


