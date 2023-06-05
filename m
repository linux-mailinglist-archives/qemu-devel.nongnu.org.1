Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F4722A06
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 16:57:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BdF-0001Pc-DI; Mon, 05 Jun 2023 10:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6Bd8-0001Ne-FT
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q6Bd6-0006td-05
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 10:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685976977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t55hdvqVeMOTLUzB1IPLs4D0gQXMoVKWrm/SzmA+u84=;
 b=Dh+fKpS3BlVX+T+h3Ls2/IFqAI6cFECvBwfVygnAqmzz2faFRr+p8BIG1zBmmzwkKBETHB
 wOwBQ/1sBpcYvDGFXF8O6O6C0ARMDU9zo5R/HJAgmXNPX0lfF5OHHMdRyGmtg8besqcTew
 IUaa12F4BfOY3L9Ct4q9SdqWthsoHd0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-1COSsLYYPTOBMrGLxRm6-A-1; Mon, 05 Jun 2023 10:56:16 -0400
X-MC-Unique: 1COSsLYYPTOBMrGLxRm6-A-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-76ce93a10f3so303743039f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 07:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685976976; x=1688568976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t55hdvqVeMOTLUzB1IPLs4D0gQXMoVKWrm/SzmA+u84=;
 b=Ozi6EmmxMgeP7YnfanGXGpuSa/JoYuKJLrjvm4O5yyP8qI3nksFNlH+EfAK0sp//Bb
 YOt1e1ayJsm/8I7AZ4K09YL9PkwdxqgwfVwOKhzLOXPUT6t5k8ij+962LCmp+F+CAMUf
 uxRd/CmhIsz0H+iGdEgv4cjQfIP/fCIWn4hrG61tFj3Zhin4dkptYc0mZVT6BDb0JrH7
 iPxSI3YsC4ThlJK2mP+pKZzgdjlHiClu1Oyxakqc1okq+gsgRWHXnQDrhTU2YiN24Q/q
 MEfJocrNeMrn65nwImVbLzXwm1uyRZVXm8tRx8uQAV7yNx+Q9akkhHKvhsnA9JuoHCda
 iezg==
X-Gm-Message-State: AC+VfDxyVLycZriNV7MmxSGidg+qB+95qHCFANmY16An+ZPU5h106R1c
 sh/srrOPUcjVD9tQff9a5m5ECJTT8yacUb8h2ZSUZzXZm3QUMTtgAMiLrkMkHYEm1HAKZclXjcX
 t5uwNMpiBdjeEhqc=
X-Received: by 2002:a05:6602:209a:b0:777:b765:661a with SMTP id
 a26-20020a056602209a00b00777b765661amr45246ioa.14.1685976975817; 
 Mon, 05 Jun 2023 07:56:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4UeY5aEHTUShxzty871MuullFutfzrbKSbtj1qqfRwDZNLP03qlMLRWsujT/FjeL5HElebAQ==
X-Received: by 2002:a05:6602:209a:b0:777:b765:661a with SMTP id
 a26-20020a056602209a00b00777b765661amr45216ioa.14.1685976975491; 
 Mon, 05 Jun 2023 07:56:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 t9-20020a02c489000000b0041cd0951a93sm2246176jam.8.2023.06.05.07.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 07:56:14 -0700 (PDT)
Date: Mon, 5 Jun 2023 08:56:12 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
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
Message-ID: <20230605085612.32f4ef95.alex.williamson@redhat.com>
In-Reply-To: <c3edcf5c-75c7-df60-8782-8cc9a8a31ccf@nvidia.com>
References: <20230530144821.1557-1-avihaih@nvidia.com>
 <20230530144821.1557-9-avihaih@nvidia.com>
 <20230601142231.78b15326.alex.williamson@redhat.com>
 <c3edcf5c-75c7-df60-8782-8cc9a8a31ccf@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Sun, 4 Jun 2023 12:33:43 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> On 01/06/2023 23:22, Alex Williamson wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, 30 May 2023 17:48:20 +0300
> > Avihai Horon <avihaih@nvidia.com> wrote:
> > =20
> >> Add a new VFIO device property x-allow-pre-copy to keep migration
> >> compatibility to/from older QEMU versions that don't have VFIO pre-copy
> >> support. =20
> > This doesn't make sense to me, vfio migration is not currently
> > supported, it can only be enabled via an experimental flag.  AFAIK we
> > have no obligation to maintain migration compatibility against
> > experimental features.  Is there any other reason we need a flag to
> > disable pre-copy? =20
>=20
> This could give flexibility to do migration between hosts without=20
> matching VFIO device kernel drivers. E.g., source driver doesn't have=20
> precopy support and dest driver has or vice versa.

If these are valid scenarios, the protocol should support negotiation
without requiring an experimental flag to do so.

> > OTOH, should this series finally remove the experimental migration
> > flag?  Do we require Joao's vIOMMU support to finally make it
> > supportable?  Is there something else? =20
>=20
> I think that after precopy is accepted we can remove the experimental=20
> flag, as we'll have the major parts of VFIO migration upstream.
> After that we will still need to add Joao's vIOMMU support and P2P suppor=
t.
> Do you want me to add a patch to this series that makes VFIO migration=20
> non-experimental?

I'd keep it as a separate patch with a clearly described dependency on
this series so that we can discuss it separately.  Thanks,

Alex

> >> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >> ---
> >>   include/hw/vfio/vfio-common.h | 1 +
> >>   hw/core/machine.c             | 1 +
> >>   hw/vfio/migration.c           | 3 ++-
> >>   hw/vfio/pci.c                 | 2 ++
> >>   4 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-comm=
on.h
> >> index 1db901c194..a53ecbe2e0 100644
> >> --- a/include/hw/vfio/vfio-common.h
> >> +++ b/include/hw/vfio/vfio-common.h
> >> @@ -146,6 +146,7 @@ typedef struct VFIODevice {
> >>       VFIOMigration *migration;
> >>       Error *migration_blocker;
> >>       OnOffAuto pre_copy_dirty_page_tracking;
> >> +    bool allow_pre_copy;
> >>       bool dirty_pages_supported;
> >>       bool dirty_tracking;
> >>   } VFIODevice;
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index 1000406211..64ac3fe38e 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -41,6 +41,7 @@
> >>
> >>   GlobalProperty hw_compat_8_0[] =3D {
> >>       { "migration", "multifd-flush-after-each-section", "on"},
> >> +    { "vfio-pci", "x-allow-pre-copy", "false" },
> >>   };
> >>   const size_t hw_compat_8_0_len =3D G_N_ELEMENTS(hw_compat_8_0);
> >>
> >> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >> index d8f6a22ae1..cb6923ed3f 100644
> >> --- a/hw/vfio/migration.c
> >> +++ b/hw/vfio/migration.c
> >> @@ -323,7 +323,8 @@ static bool vfio_precopy_supported(VFIODevice *vba=
sedev)
> >>   {
> >>       VFIOMigration *migration =3D vbasedev->migration;
> >>
> >> -    return migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
> >> +    return vbasedev->allow_pre_copy &&
> >> +           migration->mig_flags & VFIO_MIGRATION_PRE_COPY;
> >>   }
> >>
> >>   /* -----------------------------------------------------------------=
----- */
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> index 73874a94de..c69813af7f 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -3335,6 +3335,8 @@ static Property vfio_pci_dev_properties[] =3D {
> >>       DEFINE_PROP_ON_OFF_AUTO("x-pre-copy-dirty-page-tracking", VFIOPC=
IDevice,
> >>                               vbasedev.pre_copy_dirty_page_tracking,
> >>                               ON_OFF_AUTO_ON),
> >> +    DEFINE_PROP_BOOL("x-allow-pre-copy", VFIOPCIDevice,
> >> +                     vbasedev.allow_pre_copy, true),
> >>       DEFINE_PROP_ON_OFF_AUTO("display", VFIOPCIDevice,
> >>                               display, ON_OFF_AUTO_OFF),
> >>       DEFINE_PROP_UINT32("xres", VFIOPCIDevice, display_xres, 0), =20
>=20


