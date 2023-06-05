Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7D722087
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:06:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65Dj-0007yb-Ix; Mon, 05 Jun 2023 04:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1q65DW-0007ws-IW
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:05:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1q65DU-0002YO-Jm
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685952326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=voOnAIPLC+/+8OB9CvUAfqHSuxlN6SrzX8R4ldio3Hc=;
 b=YJDiqp0FXzQ9rJMm9Kmneih87u9q8H7yHiPx5qgKJOilMIQ5d3hE8m/303pL4ZLus/izGg
 B/A0Iim+/nPWdYwxTb2lbcY7gF3bU86F4lNAna5xrKzzzw3wIj1vW6i2FD+UkZBfmZTd0h
 knh9fMu3rMa+OF4om+vG1GC/vuVItS0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-s0wSB6rWMtataXXP0124FQ-1; Mon, 05 Jun 2023 04:05:24 -0400
X-MC-Unique: s0wSB6rWMtataXXP0124FQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30ae4ed92eeso1954706f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 01:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685952323; x=1688544323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voOnAIPLC+/+8OB9CvUAfqHSuxlN6SrzX8R4ldio3Hc=;
 b=Q32UG8+7RkaxrgfsKMVUUAJcVtBFCQvTPjRyh8TMTBQJ214+Shx0MV+aDU+PNtnNTJ
 v9Al9arNpD+hp46o0kPnD4Tf6zUirrMYsznnuDHGnvvd+zOmbrDXI8mQOD+T9u0xks4u
 XMQuJldNPIPRQqFgenT0kFib1COGOYGmEkYCcJpH4QEYpOROoXfSeYQiRQHoggnXPfRC
 3uARmnGbihsRihozQOPhU8g308Rg+tODLnznXraeljBYnYNIulwR0T4lPJHGhXXTCErc
 kdPalyMxkYNd4TqcpthqDpWAQTaJvyEJnkgCFA8aHozGZm1rdPUniaPAozfRu2BiCZOx
 motA==
X-Gm-Message-State: AC+VfDx3eG1TC95BILXwGHcib2DkY8rTVdHkzBunuvNib0TJyj7ojiaj
 UX72dF4k/PopeGciGy1COaxCE5LCi9ArIRLLAo2UU1tZ+bN19eITuq2KiRQReO69F9VR4GOx0vD
 C07LzKF8ia+JrzujLOSMOBfn+d4xAg+Q=
X-Received: by 2002:a5d:52c8:0:b0:309:419b:925d with SMTP id
 r8-20020a5d52c8000000b00309419b925dmr3730476wrv.70.1685952323604; 
 Mon, 05 Jun 2023 01:05:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52+sERCviuhdUEh3/WLTf/VYWfl2eb5jbayhee0X7w2K7iKGV2EkdjLvcs3E/VpDM6wwuwZ0uKn4eT/CabB8Y=
X-Received: by 2002:a5d:52c8:0:b0:309:419b:925d with SMTP id
 r8-20020a5d52c8000000b00309419b925dmr3730460wrv.70.1685952323294; Mon, 05 Jun
 2023 01:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230503091337.2130631-1-lulu@redhat.com>
 <CACGkMEvssDLX0OAuVE2ZwK_SAdhjUr7fnbH6kbMAOzzJKbsJig@mail.gmail.com>
 <CACLfguXZiErCtA6UN4z8V3x6MSaGga7W86jjg6EYhKb3j8QqiA@mail.gmail.com>
 <20230605014034-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230605014034-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Mon, 5 Jun 2023 16:04:46 +0800
Message-ID: <CACLfguWySBD8TU1L4rgCD1EvfdAaxwTawy4hOp3EEQZLCO_wEw@mail.gmail.com>
Subject: Re: [RFC 0/7] vhost-vdpa: add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Jun 5, 2023 at 1:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Fri, May 05, 2023 at 02:29:23PM +0800, Cindy Lu wrote:
> > On Fri, May 5, 2023 at 11:29=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > Hi Cindy
> > >
> > > On Wed, May 3, 2023 at 5:13=E2=80=AFPM Cindy Lu <lulu@redhat.com> wro=
te:
> > > >
> > > > Hi All
> > > > There is the RFC to support the IOMMUFD in vdpa device
> > > > any comments are welcome
> > > > Thanks
> > > > Cindy
> > >
> > > Please post the kernel patch as well as a reference.
> > >
> > > Thanks
> > >
> > sure=EF=BC=8Cwill do
> > Thanks
> > cindy
>
> Is this effort going anywhere? It will soon be too late for
> the next merge window.
>
Hi Michael
I'm now working on some vduse issue, I will go back to work in IOMMUFD soon

Thanks
Cindy
> > > >
> > > > Cindy Lu (7):
> > > >   vhost: introduce new UAPI to support IOMMUFD
> > > >   qapi: support iommufd in vdpa
> > > >   virtio : add a ptr for vdpa_iommufd in VirtIODevice
> > > >   net/vhost-vdpa: Add the check for iommufd
> > > >   vhost-vdpa: Add the iommufd support in the map/unmap function
> > > >   vhost-vdpa: init iommufd function in vhost_vdpa start
> > > >   vhost-vdpa-iommufd: Add iommufd support for vdpa
> > > >
> > > >  hw/virtio/meson.build          |   2 +-
> > > >  hw/virtio/vhost-vdpa-iommufd.c | 240 +++++++++++++++++++++++++++++=
++++
> > > >  hw/virtio/vhost-vdpa.c         |  74 +++++++++-
> > > >  include/hw/virtio/vhost-vdpa.h |  47 +++++++
> > > >  include/hw/virtio/virtio.h     |   5 +
> > > >  linux-headers/linux/vhost.h    |  72 ++++++++++
> > > >  net/vhost-vdpa.c               |  31 +++--
> > > >  qapi/net.json                  |   1 +
> > > >  8 files changed, 451 insertions(+), 21 deletions(-)
> > > >  create mode 100644 hw/virtio/vhost-vdpa-iommufd.c
> > > >
> > > > --
> > > > 2.34.3
> > > >
> > >
>


