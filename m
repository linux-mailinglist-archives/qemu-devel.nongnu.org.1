Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3971F3C6
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 22:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4op1-0005Gq-82; Thu, 01 Jun 2023 16:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q4oom-0005DY-Cl
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q4oog-0008Ls-Gs
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 16:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685650956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GV9YEEhieBCeu1LZlkkNBh3qshVuQOzPhw46W6kt5bc=;
 b=BSwTX4slVLNydxHf4vK0uxzWXI0Aq122dGjvg/ItuAyOPk33QEdBeS42E9F3ctRI3aACLw
 hPSketuXNl+pmj4fNKxYksWqpMwOH0BWD32+oqzq0YW9XFISzEqEIOH8GgWM3tO6j24LQ7
 FX/nkoydCZDo3IQb5PjKRnGTi4ycMhk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-gdJcsFvPN9KnqdggjksdCw-1; Thu, 01 Jun 2023 16:22:34 -0400
X-MC-Unique: gdJcsFvPN9KnqdggjksdCw-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7773a91a912so14622439f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 13:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685650954; x=1688242954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GV9YEEhieBCeu1LZlkkNBh3qshVuQOzPhw46W6kt5bc=;
 b=QjT2/a26yOiFpySpmGZyYEHcUbeC1EXVil28In9Fz1puVPlWApKMwbsswGwa1medbe
 Adknkx5jKbSxvg9lBUN22GtD+xS68qPaBtBViqLzpOX+HhCaxaGBhfV7E2h802IqmHYC
 O+y95qD21Hyhy3BGGE9UDKcBjogn0w2hNi3yLoBzzuqOr0kcgHIZkkjIDaKktpyYOaRo
 +JdqDvEKAbObHig1bS0ytBtYHrNao/nS29Kw4Zck7zPGjrTujfP3/QRdHia+o1lkhkZE
 rAVXzWx3s+ylarvox2QALh6ijSefDUEv2DfLWR2RE7CjJ9r84+4331OvmPxeHwbxJTNE
 GGfg==
X-Gm-Message-State: AC+VfDyrrJmaxxaunYMJQWfKg4RcrlRIv2qZC223mOJOhXi5QQEb1SFZ
 0x/bgNzlCSaL+TQ43W5GSBuoY/FYAxOktUeG9Xg39xKfsROC6nBoZRtkAhED63ypCYr/ptDWEbi
 CtPBzko8OEyzp9PY=
X-Received: by 2002:a92:4a12:0:b0:33d:ac5:94bc with SMTP id
 m18-20020a924a12000000b0033d0ac594bcmr2964217ilf.15.1685650953816; 
 Thu, 01 Jun 2023 13:22:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5oSnod5mm77OO9rSJcLG3Wkz4WUwujwvoTmY3E6v2EuS9eJ/uMgAlxFWZATJgBBoJGE8ZsYA==
X-Received: by 2002:a92:4a12:0:b0:33d:ac5:94bc with SMTP id
 m18-20020a924a12000000b0033d0ac594bcmr2964210ilf.15.1685650953582; 
 Thu, 01 Jun 2023 13:22:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 p9-20020a92d489000000b0033549a5fb36sm3955850ilg.27.2023.06.01.13.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 13:22:33 -0700 (PDT)
Date: Thu, 1 Jun 2023 14:22:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: <qemu-devel@nongnu.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yishai Hadas
 <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Maor Gottlieb
 <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, Tarun Gupta
 <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v5 8/9] vfio/migration: Add x-allow-pre-copy VFIO device
 property
Message-ID: <20230601142231.78b15326.alex.williamson@redhat.com>
In-Reply-To: <20230530144821.1557-9-avihaih@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-9-avihaih@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Tue, 30 May 2023 17:48:20 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> Add a new VFIO device property x-allow-pre-copy to keep migration
> compatibility to/from older QEMU versions that don't have VFIO pre-copy
> support.

This doesn't make sense to me, vfio migration is not currently
supported, it can only be enabled via an experimental flag.  AFAIK we
have no obligation to maintain migration compatibility against
experimental features.  Is there any other reason we need a flag to
disable pre-copy?

OTOH, should this series finally remove the experimental migration
flag?  Do we require Joao's vIOMMU support to finally make it
supportable?  Is there something else?  Thanks,

Alex

> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  include/hw/vfio/vfio-common.h | 1 +
>  hw/core/machine.c             | 1 +
>  hw/vfio/migration.c           | 3 ++-
>  hw/vfio/pci.c                 | 2 ++
>  4 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 1db901c194..a53ecbe2e0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -146,6 +146,7 @@ typedef struct VFIODevice {
>      VFIOMigration *migration;
>      Error *migration_blocker;
>      OnOffAuto pre_copy_dirty_page_tracking;
> +    bool allow_pre_copy;
>      bool dirty_pages_supported;
>      bool dirty_tracking;
>  } VFIODevice;
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1000406211..64ac3fe38e 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@
> =20
>  GlobalProperty hw_compat_8_0[] =3D {
>      { "migration", "multifd-flush-after-each-section", "on"},
> +    { "vfio-pci", "x-allow-pre-copy", "false" },
>  };
>  const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);
> =20
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index d8f6a22ae1..cb6923ed3f 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice *vbased=
ev)
>  {
>      VFIOMigration *migration =3D vbasedev->migration;
> =20
> -    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
> +    return vbasedev->allow_pre_copy &&
> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
>  }
> =20
>  /* ---------------------------------------------------------------------=
- */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 73874a94de..c69813af7f 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] =3D {
>      DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPCIDev=
ice,
>                              vbasedev.pre_copy_dirty_page_tracking,
>                              ON_OFF_AUTO_ON),
> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
> +                     vbasedev.allow_pre_copy, true),
>      DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
>                              display, ON_OFF_AUTO_OFF),
>      DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0),


