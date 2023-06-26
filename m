Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3473E669
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 19:29:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDq06-0000mL-S9; Mon, 26 Jun 2023 13:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qDq02-0000mD-Qo
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 13:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qDq00-0001wC-LU
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 13:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687800453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mwbijYhKMFotztA/esobf9FSY1KmTJzml9IXM9KyjvI=;
 b=SD9wuyk/yPK+w2KlpOicVHnh+aq939jYd3j9f9sD2nsyDeI61YGOUF8nQGU4KgU2FSfDIk
 WF++KazphqbkVCvwT70uiV+9qpEH4ePodGTkXQUhjrdLCJay328zMfy11wp81cjdpqbicr
 HtG5sGXalTbq6k8KDYSutCvwgP61TMw=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-XUxfts-3Mn6qyDGwLGv9lQ-1; Mon, 26 Jun 2023 13:27:32 -0400
X-MC-Unique: XUxfts-3Mn6qyDGwLGv9lQ-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3455fbf1a15so17733115ab.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 10:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687800451; x=1690392451;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mwbijYhKMFotztA/esobf9FSY1KmTJzml9IXM9KyjvI=;
 b=WFkFsHLqe0w13P8FWcHefWWxZo2Te7vrNRGfq1keY2XW9kVAKoqigw7jsliyFI5L8j
 YBBMYdGqq/wvHEl4JPydjAUlBoQ/2V2bgCwctoeku/7JsHJ87ZJnC/qtpua8mnn9Cueg
 71nHqbnrqFOj+1Ssj8y50cJ71Q+pVt9s2jlwsqrwc72tMjWpZ8DAiln2x1DhRzeWDWBi
 XCIJ6IqCsT9hCfrqgMVHx1iwHxVf2xOMJuI6ZVgKtAPWbvRZeyXTNyGXxx4J3E5tjFMQ
 YLyd4aF+VMXoimaQpV5Y6F4WWYjb3pyD2xBz8em2NoIvEGHwlA9TAhr7882vZv5/hgZ/
 rn9g==
X-Gm-Message-State: AC+VfDxx/ij5RZ075jzGmSTZM5uPMQOAA34ng+aTp1IHfCjEHp9VKuBi
 ABHHJAbn9pV3mRojFqdazYRYFQpmDni6+37dn1bNVVSBUvTL/+tC56kycv7jrEwa/q1z0EhPT1j
 3oqlbjkjAG96KWGU=
X-Received: by 2002:a92:da02:0:b0:345:3378:4258 with SMTP id
 z2-20020a92da02000000b0034533784258mr8368682ilm.30.1687800451469; 
 Mon, 26 Jun 2023 10:27:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GRF+82wJKRqfWd236pCe+kZwWnb+oj6cLzvOcHBqa+goZxCLwekEmUAPL4qZnTEHVAAutjg==
X-Received: by 2002:a92:da02:0:b0:345:3378:4258 with SMTP id
 z2-20020a92da02000000b0034533784258mr8368669ilm.30.1687800451147; 
 Mon, 26 Jun 2023 10:27:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 r1-20020a028801000000b0041d859c5721sm1919197jai.64.2023.06.26.10.27.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 10:27:30 -0700 (PDT)
Date: Mon, 26 Jun 2023 11:27:29 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Message-ID: <20230626112729.06dc48d8.alex.williamson@redhat.com>
In-Reply-To: <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 26 Jun 2023 17:26:42 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 6/26/23 15:40, Joao Martins wrote:
> > On 26/06/2023 14:20, C=C3=A9dric Le Goater wrote: =20
> >> Hello Avihai,
> >>
> >> On 6/26/23 10:23, Avihai Horon wrote: =20
> >>> The major parts of VFIO migration are supported today in QEMU. This
> >>> includes basic VFIO migration, device dirty page tracking and precopy
> >>> support.
> >>>
> >>> Thus, at this point in time, it seems appropriate to make VFIO migrat=
ion
> >>> non-experimental: remove the x prefix from enable_migration property,
> >>> change it to ON_OFF_AUTO and let the default value be AUTO.
> >>>
> >>> In addition, make the following adjustments:
> >>> 1. Require device dirty tracking support when enable_migration is AUTO
> >>>  =C2=A0=C2=A0=C2=A0 (i.e., not explicitly enabled). This is because d=
evice dirty tracking
> >>>  =C2=A0=C2=A0=C2=A0 is currently the only method to do dirty page tra=
cking, which is
> >>>  =C2=A0=C2=A0=C2=A0 essential for migrating in a reasonable downtime.=
 =20
> >>
> >> hmm, I don't think QEMU should decide to disable a feature for all
> >> devices supposedly because it could be slow for some. That's too
> >> restrictive. What about devices with have small states ? for which
> >> the downtime would be reasonable even without device dirty tracking
> >> support.
> >> =20
> >=20
> > device dirty tracking refers to the ability to tracking dirty IOVA used=
 by the
> > device which will DMA into RAM. It is required because the
> > consequence/alternative is to transfer all RAM in stop copy phase. Devi=
ce state
> > size at that point is the least of our problems downtime wise. =20
>=20
> Arg. thanks for reminding me. I tend to take this for granted ...

My initial reaction was the same, for instance we could have a non-DMA
device (ex. PCI serial card) that supports migration w/o dirty
tracking, but QEMU cannot assume the device doesn't do DMA, nor is it
worth our time to monitor whether bus-master is ever enabled for the
device, so QEMU needs to assume all memory that's DMA accessible for
the device is perpetually dirty.  Also, if such a corner case existed
for a non-DMA migratable device, the easier path is simply to require
dirty tracking stubs in the variant driver to report no memory dirtied.
=20
> > I can imagine that allowing without dirty tracking is useful for develo=
per
> > testing of the suspend/device-state flows, but as real default (auto) i=
s very
> > questionable to let it go through without dirty tracking. When we have =
IOMMUFD
> > dirty tracking that's when we can relieve this restriction as a default.
> >
> > But then note that (...)
> >  =20
> >> =20
> >>> Setting
> >>>  =C2=A0=C2=A0=C2=A0 enable_migration to ON will not require device di=
rty tracking. =20
> >=20
> > (...) this lets it ignore dirty tracking as you would like.
> >
> >  =20
> >>> 2. Make migration blocker messages more elaborate.
> >>> 3. Remove error prints in vfio_migration_query_flags().
> >>> 4. Remove a redundant assignment in vfio_migration_realize().
> >>>
> >>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> >>> ---
> >>>  =C2=A0 include/hw/vfio/vfio-common.h |=C2=A0 2 +-
> >>>  =C2=A0 hw/vfio/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 29 ++++++++++++++++-------------
> >>>  =C2=A0 hw/vfio/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++--
> >>>  =C2=A0 3 files changed, 19 insertions(+), 16 deletions(-)
> >>>
> >>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-com=
mon.h
> >>> index b4c28f318f..387eabde60 100644
> >>> --- a/include/hw/vfio/vfio-common.h
> >>> +++ b/include/hw/vfio/vfio-common.h
> >>> @@ -139,7 +139,7 @@ typedef struct VFIODevice {
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool needs_reset;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool no_mmap;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ram_block_discard_allowed;
> >>> -=C2=A0=C2=A0=C2=A0 bool enable_migration;
> >>> +=C2=A0=C2=A0=C2=A0 OnOffAuto enable_migration;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIODeviceOps *ops;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_irqs;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int num_regions;
> >>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >>> index 79eb81dfd7..d8e0848635 100644
> >>> --- a/hw/vfio/migration.c
> >>> +++ b/hw/vfio/migration.c
> >>> @@ -731,14 +731,6 @@ static int vfio_migration_query_flags(VFIODevice
> >>> *vbasedev, uint64_t *mig_flags)
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature->argsz =3D sizeof(buf);
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 feature->flags =3D VFIO_DEVICE_FEATUR=
E_GET | VFIO_DEVICE_FEATURE_MIGRATION;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ioctl(vbasedev->fd, VFIO_DEVICE_F=
EATURE, feature)) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (errno =3D=3D ENOTTY) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("%s: VFIO migration is not supported in kernel",
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vbasedev->name);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("%s: Failed to query VFIO migration support, err: %s",
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vbasedev->name, strerror(errno));
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> -
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -errno;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>  =C2=A0 @@ -831,14 +823,28 @@ void vfio_reset_bytes_transferred(void)
> >>>  =C2=A0 =C2=A0 int vfio_migration_realize(VFIODevice *vbasedev, Error=
 **errp)
> >>>  =C2=A0 {
> >>> -=C2=A0=C2=A0=C2=A0 int ret =3D -ENOTSUP;
> >>> +=C2=A0=C2=A0=C2=A0 int ret;
> >>>  =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!vbasedev->enable_migration) {
> >>> +=C2=A0=C2=A0=C2=A0 if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO=
_OFF) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&vbasedev->mig=
ration_blocker,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Migration is disabled for V=
FIO device", vbasedev->name);
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto add_bloc=
ker;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D vfio_migration_init(vb=
asedev);
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) { =20
> >>
> >> It would be good to keep the message for 'errno =3D=3D ENOTTY' as it w=
as in
> >> vfio_migration_query_flags(). When migration fails, it is an important
> >> information to know that it is because the VFIO PCI host device driver
> >> doesn't support the feature. The root cause could be deep below in FW =
or
> >> how the VF was set up.
> >> =20
> > +1 As I have been in this rabbit hole
> >  =20
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&vbasedev->mig=
ration_blocker,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: Migration couldn't be initi=
alized for VFIO device, "
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "err: %d (%s)",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbasedev->name, ret, strerror(-r=
et));
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto add_blocker;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO=
_AUTO &&
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vbasedev->dirty_pages_su=
pported) { =20
> >>
> >> I don't agree with this test.
> >> =20
> >=20
> > The alternative right now is perceptual dirty tracking. How is that OK =
as a
> > default? It's not like we have even an option :(
> >=20
> > Maybe perhaps you refer to avoid strongly enforcing *always* it to allo=
w testing
> > of the non dirty tracking parts? Maybe when you 'force' enabling with
> > enable-migration=3Don is when you ignore the dirty tracking which is wh=
at this is
> > doing. =20
>=20
>=20
> I see ON_OFF_AUTO_ON as a way to abort the machine startup while
> ON_OFF_AUTO_AUTO would let it run but block migration.

Agreed.  There's a little bit of redundancy between the device-level
"enable-migration=3Don" option and the global "-only-migratable" option
relative to preventing machine startup, but it also doesn't make sense
to me if the device-level option let realize complete successfully if
the device doesn't support or fails migration setup.  So I think we'd
generally rely on using the -only-migratable option with the default
ON_OFF_AUTO_AUTO value, allow the ON_OFF_AUTO_ON value to enable
dis-recommended support, and live with the redundancy that it should
also cause the device realize to fail if migration is not supported.
Thanks,

Alex

> We would
> need an extra property to relax the checks, else we are hijacking
> some pre-existing option to fit our need.
>=20
> Since dirty tracking is a must-have to implement migration support
> for any existing and future VFIO PCI variant driver, anything else
> would be experimental code and we are trying to remove the flag !
> Please correct me if I am wrong.
>=20
> So, the case !vbasedev->dirty_pages_supported is just an extra
> information to report for why migration is not supported. Does
> that sound reasonable ?
>=20
> Thanks,
>=20
> C.
>=20
>=20
>=20
> >  =20
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&vbasedev->mig=
ration_blocker,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%s: VFIO device doesn't support=
 device dirty tracking",
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbasedev->name);
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto add_bloc=
ker;
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> >> I agree that with ON_OFF_AUTO_AUTO, errors at realize time should be r=
ecorded
> >> in a migration blocker. What about the ON_OFF_AUTO_ON case ? If migrat=
ion was
> >> explicitly requested for the device and the conditions on the host are=
 not met,
> >> I think realize should fail and the machine abort.
> >> =20
> > +1 Good point
> >  =20
> >> Thanks,
> >>
> >> C.
> >>
> >>
> >> =20
> >>> @@ -856,9 +862,6 @@ int vfio_migration_realize(VFIODevice *vbasedev, =
Error
> >>> **errp)
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>>  =C2=A0 =C2=A0 add_blocker:
> >>> -=C2=A0=C2=A0=C2=A0 error_setg(&vbasedev->migration_blocker,
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "VFIO device doesn't support migration");
> >>> -
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D migrate_add_blocker(vbasedev-=
>migration_blocker, errp);
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(vb=
asedev->migration_blocker);
> >>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>> index 73874a94de..48584e3b01 100644
> >>> --- a/hw/vfio/pci.c
> >>> +++ b/hw/vfio/pci.c
> >>> @@ -3347,8 +3347,8 @@ static Property vfio_pci_dev_properties[] =3D {
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_FEATURE_E=
NABLE_REQ_BIT, true),
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BIT("x-igd-opregion", VFI=
OPCIDevice, features,
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIO_FEATURE_E=
NABLE_IGD_OPREGION_BIT, false),
> >>> -=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-enable-migration", VFIOPCIDev=
ice,
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbasedev.enable_migr=
ation, false),
> >>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOP=
CIDevice,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-no-mmap", VFIOPCI=
Device, vbasedev.no_mmap, false),
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("x-balloon-allowed",=
 VFIOPCIDevice,
> >>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbasedev=
.ram_block_discard_allowed, false), =20
> >> =20
>=20


