Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 433BA762F5E
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 10:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZbl-00080p-Id; Wed, 26 Jul 2023 04:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOZbf-0007xl-VP
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOZbd-0007u7-UU
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 04:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690359042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIQmnRJx6fA+ZHBN0PHWuZVp9Sdb0+7CsK7MphwWnok=;
 b=FlgmCr1SYJtNqflhcc1WlvYHjbLjJ79OqZtOuDZ7O1ulA7FRiFaPyLNio9P8AXw7x7crQq
 2Br5i6Cc8JrwW7a+OIeLF53RHy3baTBCHSbHvcUBDrxzYSPzGa0EiLrpTxQirmjzTuoKtE
 i1QtRN+8WW/zGnJlAh0Q0IUMNNAIbds=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-ApZxMHR5OayBPWoLfpXSJQ-1; Wed, 26 Jul 2023 04:10:40 -0400
X-MC-Unique: ApZxMHR5OayBPWoLfpXSJQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b708d79112so58415351fa.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 01:10:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690359039; x=1690963839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIQmnRJx6fA+ZHBN0PHWuZVp9Sdb0+7CsK7MphwWnok=;
 b=QDD3KZjbrnAkQP3f/LE3dInLFK132VagbEPYPYbTFFG+aBaaxY1eJwp+kyw11qnMCY
 GjtOyYRm0kG+H9EOmxV8N7HUuoMVtdOPbX7F4fN7ICvGgHqiUSeOuuvZ2/UQsnzJ0wpu
 JBQ2IZuYv0pfgvgeT695+uX+SqDIpB7trJeH7Fxgdg4wWC1x1bMerxlVS0lci8RYTyvk
 e7Q7s5WDX2Y1+PKNgBjCiqRugBUShD3HsUsxSL71fjAxANM8R9gw6EJnL90MK5GEG2/F
 4gPYyOks9JPgUZvlXYqCKOaoDlWPnrdiaKlAPl/Nj65Wzy2yCMJONw3wWl8WZv7UmeQG
 peZw==
X-Gm-Message-State: ABy/qLaftQHcg6nGanipxn5wvQeYfb23hHQe04mAoyWUO1FhaLftDrV9
 0ZHY2XLW1A5zG63wgV9uaokZZTn082KiG9ZzLyI90rhFsSiw9Iuz/hU1CScmKzdM1fLMrcWtR84
 5qXIG8P+SriDoO9H6TOTJGzf87JvCDR4=
X-Received: by 2002:a2e:9e59:0:b0:2b6:dc55:c3c7 with SMTP id
 g25-20020a2e9e59000000b002b6dc55c3c7mr911749ljk.20.1690359038778; 
 Wed, 26 Jul 2023 01:10:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH2J6eDkvyL5wgPWBoRpCoDpbqnqbV8kra7gLITsk9AtdJfaRahtJihuW40lHshWnwyA4HLSmzXW1m3JkcLFqE=
X-Received: by 2002:a2e:9e59:0:b0:2b6:dc55:c3c7 with SMTP id
 g25-20020a2e9e59000000b002b6dc55c3c7mr911730ljk.20.1690359038417; Wed, 26 Jul
 2023 01:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230418225638.1467969-1-peili.dev@gmail.com>
 <CAJaqyWebSowMMWh+HCjj7tmbA3Ey6C69T=SPA4k+6fd_-GjfoA@mail.gmail.com>
 <CACGkMEu0d0y82wo1p2g-ovbUTYJcVon0-t8fvgFQLokZmd7hDQ@mail.gmail.com>
 <CAGxU2F4N+xAM0gRh2dHDLSujkJ4Ek--Hk+PoTHOsxe4k+GTrrA@mail.gmail.com>
In-Reply-To: <CAGxU2F4N+xAM0gRh2dHDLSujkJ4Ek--Hk+PoTHOsxe4k+GTrrA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 16:10:27 +0800
Message-ID: <CACGkMEtGXOC9TCp+YrBPaV14tVt_hxUcOzRe+EFW-1YV--6w3A@mail.gmail.com>
Subject: Re: vdpa: use io_uring passthrough command for IOCTLs [was Re: [PATCH
 1/2] Reduce vdpa initialization / startup overhead]
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Michael Tsirkin <mst@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>, peili.dev@gmail.com, 
 qemu devel list <qemu-devel@nongnu.org>, 
 Linux Virtualization <virtualization@lists.linux-foundation.org>
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

On Tue, Jul 18, 2023 at 6:32=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Thu, Apr 20, 2023 at 6:20=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Wed, Apr 19, 2023 at 11:33=E2=80=AFPM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, Apr 19, 2023 at 12:56=E2=80=AFAM <peili.dev@gmail.com> wrote:
> > > >
> > > > From: Pei Li <peili.dev@gmail.com>
> > > >
> > > > Currently, part of the vdpa initialization / startup process
> > > > needs to trigger many ioctls per vq, which is very inefficient
> > > > and causing unnecessary context switch between user mode and
> > > > kernel mode.
> > > >
> > > > This patch creates an additional ioctl() command, namely
> > > > VHOST_VDPA_GET_VRING_GROUP_BATCH, that will batching
> > > > commands of VHOST_VDPA_GET_VRING_GROUP into a single
> > > > ioctl() call.
> >
> > I'd expect there's a kernel patch but I didn't see that?
> >
> > If we want to go this way. Why simply have a more generic way, that is
> > introducing something like:
> >
> > VHOST_CMD_BATCH which did something like
> >
> > struct vhost_cmd_batch {
> >     int ncmds;
> >     struct vhost_ioctls[];
> > };
> >
> > Then you can batch other ioctls other than GET_VRING_GROUP?
> >
>
> Just restarting this discussion, since I recently worked more with
> io_uring passthrough commands and I think it can help here.
>
> The NVMe guys had a similar problem (ioctl too slow for their use
> case)[1][2], so they developed a new feature in io_uring that
> basically allows you to do IOCTLs asynchronously and in batches using
> io_uring.
>
> The same feature is also used by ublk [3] and I recently talked about
> this at DevConf with German [4].
>
> Basically, there's a new callback in fops (struct file_operations.uring_c=
md).
> IIUC for NVMe (drivers/nvme/host/ioctl.c) they used exactly the same
> values used for IOCTLs also for the new uring_cmd callback.
>
> We could do the same. The changes in the vhost-vdpa kernel module
> should be simple, and we could share the code for handling ioctl and
> uring_cmd.
> That way any new command can be supported with both for compatibility.
>
> In QEMU then we can start using it to optimize the control path.
>
> What do you think?

This looks interesting.

>
> If it's interesting, I could throw down an RFC with the changes or if
> anyone is interested in working on it, I can help with the details.

Please do that.

Thanks


>
> Thanks,
> Stefano
>
> [1] https://lpc.events/event/11/contributions/989/
> [2] https://lpc.events/event/16/contributions/1382/
> [3] https://lwn.net/Articles/903855/
> [4] https://www.youtube.com/watch?v=3D6JqNPirreoY
>


