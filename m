Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845547B54C4
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnJfD-0003c5-LY; Mon, 02 Oct 2023 10:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qnJfA-0003bY-VJ
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qnJf6-0004SH-Cu
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696255958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1b0mpVMPqu/Kc2EsbboDgNf59yteKL5nVaAcy4jwAwY=;
 b=IP0WVtP17iC9r0kKXcHiW27OS09o8NymsZUWbBDMhXaa03WiIeMg5I1ltekfvQmai1Eo2i
 e3+Dm6CHhXgmkwS8dBEgcy128iWKUGgvysuCtirHOYOkV9vGtha9MCjuSgVNRYO2xy5izz
 7YYjBd/xhjG2ijwX+c8kDn1kLERKTAg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-hwm0t-OtPu6SuEmlvocwjQ-1; Mon, 02 Oct 2023 10:12:25 -0400
X-MC-Unique: hwm0t-OtPu6SuEmlvocwjQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-534543af820so8572118a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696255944; x=1696860744;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1b0mpVMPqu/Kc2EsbboDgNf59yteKL5nVaAcy4jwAwY=;
 b=F03+FrBA0RvXDDqQivnDUgUACBRLNGGEfXiirhVObzkjyjWCQLQj9YkDUbbAlaPT4S
 F9BirsbEndRWb0Rhz7yP1+gpdy9uSrZpt1fiTbRn5yU84bTzXKzysmQW3/N2UEeLvyFb
 1bc2PZe36q71ZgYTJq+4v5mkqIg4B1sqOJ2c2XGNaIcAIiLllQ/O3kG8Gnpqf1jSMsci
 7mHuoFxH6Vj0/dwODQFNx8aEyNejZw9tclXgyDQrkYt4LEWFgQeYhUkyRWeNXnvyBHa6
 bAK1UnITh8r93GtQghJaQSovbDwzlNOkIbNr0q6BXeT1Yi1UsVAZ3S4JhVZngqwt5pUN
 ZtGQ==
X-Gm-Message-State: AOJu0YwjcuDAss1qzp/IzLdudmXP+SiTpTNEnQ9qzK0CU6osdZagx/sP
 CoTvbuWubbJj7cD1LLCgA8UeWRFsd7QGVdwMyjvM/NYfgU9LxMzD3TbTdYj7iwbm85zTxVo+RGE
 b2icjYdrJjx6NsZIkwji2h5ja4TqstGA=
X-Received: by 2002:aa7:cf92:0:b0:533:795d:8c48 with SMTP id
 z18-20020aa7cf92000000b00533795d8c48mr10523094edx.10.1696255944283; 
 Mon, 02 Oct 2023 07:12:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrdnlKI3DJ6mE9zx1awSBrbHsr/0g2aUpvoCR9Nl/e2ip5KrMCDAmxbeTsbtUjuqmRAiy/rpx5AOxw+ABePxA=
X-Received: by 2002:aa7:cf92:0:b0:533:795d:8c48 with SMTP id
 z18-20020aa7cf92000000b00533795d8c48mr10523082edx.10.1696255943963; Mon, 02
 Oct 2023 07:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230927192737.528280-1-stefanha@redhat.com>
 <CAJaqyWfO6YUbif3RA+7YSs2hvqC0+8wsr7-WmzBvho4Qw0anNQ@mail.gmail.com>
In-Reply-To: <CAJaqyWfO6YUbif3RA+7YSs2hvqC0+8wsr7-WmzBvho4Qw0anNQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 2 Oct 2023 22:11:47 +0800
Message-ID: <CAPpAL=zGU23r3FN5CdjKf+vTGm5ddZc87bxkV0nw8dDWMGC88w@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost: clean up device reset
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, 
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Fam Zheng <fam@euphon.net>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QE tested a regression testing on this series with vhost-vdpa device,
everything is working fine.

Tested-by: Lei Yang <Leiyang@redhat.com>

On Thu, Sep 28, 2023 at 6:40=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Sep 27, 2023 at 9:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > Stateful vhost devices may need to free resources or clear device state=
 upon
> > device reset. The vhost-user protocol has a VHOST_USER_RESET_DEVICE mes=
sage for
> > this and vDPA has SET_STATUS 0, but only QEMU's vhost-user-scsi device =
actually
> > implements this today.
> >
> > This patch series performs device reset across all device types. When
> > virtio_reset() is called, the associated vhost_dev's ->vhost_reset_devi=
ce() is
> > called. vhost-user-scsi's one-off implementation is obsoleted and remov=
ed.
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
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> > Stefan Hajnoczi (3):
> >   vhost-user: do not send RESET_OWNER on device reset
> >   vhost-backend: remove vhost_kernel_reset_device()
> >   virtio: call ->vhost_reset_device() during reset
> >
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
> >
>
>


