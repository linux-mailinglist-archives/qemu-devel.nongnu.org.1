Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3027B79FB23
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 07:46:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfBN-0002GE-7L; Thu, 14 Sep 2023 01:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1qgfBL-0002G5-7Y
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1qgfBA-0000mO-EA
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694670372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K31tXeFe8NAW6C6RrWnf9VKjKUgw1J5J0Ik5wfgImX0=;
 b=MYsVVyFrFOh8A8DDUCD0VO1y6fabkLP45sweFMwdQj5ap6ms3+hEPZ7P7RwGYP/0zNv25P
 NVpm95djd3iWjULYFz6QpzelXMJlaTx7MiEO8lOi2uC3/Um4hwoBD1CFzpM8XA1THre/Ne
 3aig+6IWLoFcWotQnuMepdh1nUDRPMc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-AobdXMQyMEiBJiS_sIWsQg-1; Thu, 14 Sep 2023 01:45:01 -0400
X-MC-Unique: AobdXMQyMEiBJiS_sIWsQg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401e1c55ddcso4634725e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 22:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694670300; x=1695275100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K31tXeFe8NAW6C6RrWnf9VKjKUgw1J5J0Ik5wfgImX0=;
 b=Iyv9slonJ6kMcLgijupAy9VpREi8eQAwd1tR+fDGCHgdAeV4/FwJpF26fYhw1f0j9V
 1KrNVZNm/JQVJmPA/wbM1iON1Im3wUoBgo5ParjG2nwq/RHRLjxuF2Q/pJrNvjfm38Rh
 E4uLtrZNqZAgOtvaQQyfm2LuXVFDsG/HQ61WfhW4EgcCo3TI32zU98XPhcq6mpb6FgEB
 37+oIMGYAysZlp0JFHvoAqKKIIdW05Q1m6E83ntJdWxmHOBou1G+NXsO/3nZe+uV5ZTQ
 q9J8qc4PMDBmyXFKwpLmifPHbSN7YTCIX7i2BqHEdWm9nAUCjI1oIvOzzrwem6x8Xd5l
 62OQ==
X-Gm-Message-State: AOJu0YznkXZ5yDZPioaAXekbBRD6RVa/I9UZBR870KzCyuhjWJqZMZU0
 MJkZWqYZk4+/s82ZJod42wm7phCwZ1gc3QoPevo56kQJiezbq9vc9tp13rdtuCwRCWXH14dVTpm
 9gjjLwvjhGNJPhpj77xMLYTA0TwAaHOs=
X-Received: by 2002:adf:ea92:0:b0:317:60f9:caa with SMTP id
 s18-20020adfea92000000b0031760f90caamr3565042wrm.59.1694670300209; 
 Wed, 13 Sep 2023 22:45:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXan0Xr8f1t5nI6yC2nJZo0j3wsFenc7ZM2pudNSQJ5YpbXTc1MHb8tk2RTOIukZDUFM9vt336zJ5vmUk+Nhg=
X-Received: by 2002:adf:ea92:0:b0:317:60f9:caa with SMTP id
 s18-20020adfea92000000b0031760f90caamr3565024wrm.59.1694670299842; Wed, 13
 Sep 2023 22:44:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230503091337.2130631-1-lulu@redhat.com>
 <20230913093042-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230913093042-mutt-send-email-mst@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Thu, 14 Sep 2023 13:44:19 +0800
Message-ID: <CACLfguW6CQK7yOsyri-8f=gN3jz7KUt-82gY=ecJWU99=3EBsQ@mail.gmail.com>
Subject: Re: [RFC 0/7] vhost-vdpa: add support for iommufd
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi Michael=EF=BC=8C
Really sorry for the delay, I was sick-leave for almost 2 months,
which caused the delay in the development of this feature.  I will
continue working on this feature soon.
Thanks
Cindy

On Wed, Sep 13, 2023 at 9:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, May 03, 2023 at 05:13:30PM +0800, Cindy Lu wrote:
> > Hi All
> > There is the RFC to support the IOMMUFD in vdpa device
> > any comments are welcome
> > Thanks
> > Cindy
>
> Any plans to work on this or should I consider this abandoned?
>
>
> > Cindy Lu (7):
> >   vhost: introduce new UAPI to support IOMMUFD
> >   qapi: support iommufd in vdpa
> >   virtio : add a ptr for vdpa_iommufd in VirtIODevice
> >   net/vhost-vdpa: Add the check for iommufd
> >   vhost-vdpa: Add the iommufd support in the map/unmap function
> >   vhost-vdpa: init iommufd function in vhost_vdpa start
> >   vhost-vdpa-iommufd: Add iommufd support for vdpa
> >
> >  hw/virtio/meson.build          |   2 +-
> >  hw/virtio/vhost-vdpa-iommufd.c | 240 +++++++++++++++++++++++++++++++++
> >  hw/virtio/vhost-vdpa.c         |  74 +++++++++-
> >  include/hw/virtio/vhost-vdpa.h |  47 +++++++
> >  include/hw/virtio/virtio.h     |   5 +
> >  linux-headers/linux/vhost.h    |  72 ++++++++++
> >  net/vhost-vdpa.c               |  31 +++--
> >  qapi/net.json                  |   1 +
> >  8 files changed, 451 insertions(+), 21 deletions(-)
> >  create mode 100644 hw/virtio/vhost-vdpa-iommufd.c
> >
> > --
> > 2.34.3
>


