Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9117B7313
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:10:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmeY-00055u-3H; Tue, 03 Oct 2023 17:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnmeI-00054y-SZ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:09:47 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qnme3-0000yz-2b
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:09:46 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3af8b498d31so986958b6e.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696367370; x=1696972170; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sxROvCP8JAbvF0JtDheDyej1OiWAC/UdyT03o7DriFY=;
 b=DAjJ3/6+yDXmxV3VjxwKMv4Gz+OnOJgu01Q49D0aGa2woeZxomvnwRKTK+UOKsZMBj
 nNl5eLKKPzV9HnuXX1sO3tioWyOhuKUj4RtGFNehRNSCvaJes/wxj2wFGiRDbsLc0CtC
 qTMJjU3WwbtsuZqifVOruJyVjavo+wfKUaWCx4pa7HodHglMW+lzDJJgUFhPwv143UZD
 S4Ykqc2BDB5nDGmtSmWsFoB4mR1N7o2LLRiAPoiium70HUfqCWnEwji9Uw+OMSqC2/2C
 qEj0xay2iNTRt+j4S9Sq+Wy+jpYnGEOhkAxQl1ndnuNNEpwt15fk/4BUlbnAZv6sBaCK
 3ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696367370; x=1696972170;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sxROvCP8JAbvF0JtDheDyej1OiWAC/UdyT03o7DriFY=;
 b=hvXwL22HvjkOsO8B6c7VkdSe0YRJjHgb8638HjQuXv4xQ+H3VXLPTt99EKDvdHj+77
 Lf5xI8RvJk/8fHgtcf7s9JtgwEoZlc8r8f0q3GBTnxwioB3qbhoc06sjFxXjK/4HVA/l
 eC3JVGKVn2nj3qdZhlijwCXn49I/5U3p4V2l4/i4owVVcHIK1THM34JGtCHfvIe9NjXi
 XOjRSYv1aquqPnPHw8FPrFOw2EIrI+odYtRIn5B1s3rD4rRplap88x8oumb+bC9RZ5WT
 2cM100Gf7TZy+oMTT+nkg4qol08wk/5iG396QBHgc6vhyxS++d5/ECznbQ/2fIcWH/p0
 boeg==
X-Gm-Message-State: AOJu0Yz/VNOXAE7jV3jI/2KEO90o1uhLhqkjVyfS89Y7dKZx/cjeAEYV
 ceFQZXYKLKj+eHPU5NQ60roXv51HAthB79UdmnY=
X-Google-Smtp-Source: AGHT+IHEUr6gUfyJsUV9tr8KoMvSO1XOQhN+hH4ccbOH0OrwUQEZBcKxs3a5dQlaexQoPLWMEmtOKb/kzWwGgzuX1PY=
X-Received: by 2002:a05:6808:2382:b0:3ac:a11a:4879 with SMTP id
 bp2-20020a056808238200b003aca11a4879mr690864oib.39.1696367369613; Tue, 03 Oct
 2023 14:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230927192737.528280-1-stefanha@redhat.com>
 <20231003170003-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231003170003-mutt-send-email-mst@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Oct 2023 17:09:14 -0400
Message-ID: <CAJSP0QWZiOF9waT+8-x9qtttmmwE0AOmFC-D4TVVNjGsNpzD7g@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost: clean up device reset
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 hreitz@redhat.com, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Fam Zheng <fam@euphon.net>,
 eperezma@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 3 Oct 2023 at 17:01, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Sep 27, 2023 at 03:27:34PM -0400, Stefan Hajnoczi wrote:
> > Stateful vhost devices may need to free resources or clear device state upon
> > device reset. The vhost-user protocol has a VHOST_USER_RESET_DEVICE message for
> > this and vDPA has SET_STATUS 0, but only QEMU's vhost-user-scsi device actually
> > implements this today.
> >
> > This patch series performs device reset across all device types. When
> > virtio_reset() is called, the associated vhost_dev's ->vhost_reset_device() is
> > called. vhost-user-scsi's one-off implementation is obsoleted and removed.
> >
> > This patch affects behavior as follows:
> > - vhost-kernel: no change in behavior. No ioctl calls are made.
> > - vhost-user: back-ends that negotiate
> >   VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
> >   VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
> >   no change in behavior. DPDK, SPDK, libvhost-user, and the
> >   vhost-user-backend crate do not negotiate
> >   VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
> > - vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.
> >
> > I have tested this series with vhost-net (kernel), vhost-user-blk, and
> > vhost-user-fs (both Rust and legacy C).
> >
> > Stefan Hajnoczi (3):
> >   vhost-user: do not send RESET_OWNER on device reset
> >   vhost-backend: remove vhost_kernel_reset_device()
> >   virtio: call ->vhost_reset_device() during reset
>
> Build failure:
> https://gitlab.com/mstredhat/qemu/-/jobs/5215049540

Sorry about that, will fix.

Stefan

> >  include/hw/virtio/vhost.h |  3 +++
> >  hw/scsi/vhost-user-scsi.c | 20 --------------------
> >  hw/virtio/vhost-backend.c |  6 ------
> >  hw/virtio/vhost-user.c    | 13 +++++++++----
> >  hw/virtio/vhost.c         |  9 +++++++++
> >  hw/virtio/virtio.c        |  4 ++++
> >  6 files changed, 25 insertions(+), 30 deletions(-)
> >
> > --
> > 2.41.0
>
>

