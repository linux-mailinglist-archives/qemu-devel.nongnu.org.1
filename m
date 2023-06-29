Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D360743036
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 00:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEzsY-0000fM-6F; Thu, 29 Jun 2023 18:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qEzsV-0000fB-NM
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 18:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qEzsT-00028y-6e
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 18:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688076755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIbtxiQLzpMHnG60g3HuqtJ5+DaR+fBSi2/5wKvryW4=;
 b=LX5lxP9WQgK6hy8rPFSgn6iO6Y8has5wT48EpuBqVWbAqSOn08/1SlvVF2rZP1fhg+giye
 yuniUyK5m4TS9C0tRb4l+kou/nJdLYXt+kRQsLCvm6WZBtfZrS31iKXA19nOjaMgz5kwGQ
 EdGGl1F/Qo+eZX90BsrxJGq/GoS2YUY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-D5EwGwHoN9-_d1Ptvnr7-g-1; Thu, 29 Jun 2023 18:12:34 -0400
X-MC-Unique: D5EwGwHoN9-_d1Ptvnr7-g-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-77e23d23eccso22286539f.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 15:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688076753; x=1690668753;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DIbtxiQLzpMHnG60g3HuqtJ5+DaR+fBSi2/5wKvryW4=;
 b=BNHPsz6C/KsSgzBy+4b+DYR0ytnVUEka/RgFeMQCyPJEX3iGpNrRqZl+ysA1l6YEEF
 iySbjZAekA0foRAPZQlzs5W/xoKlkvUSBE8aUxXFspKKfvFAobfBxSPa5EnRX9bEnWSi
 uFujXDbwgYgA50Am+vDWhKSIXQx8hA0QGoVQsDn7WngcxStxQxAgZUXlezbkE8620POa
 TolqFc+xFFVEYQjpkXIcvwC98ICMYj7grpUfH0ei7cII/64gzih5xQUSm0nYA0qLVAl+
 LuUCXNLZPyAAOG1AlQNjxuXpxBemUCLdah+jRD1L/pEr144uqQPP6LRQ0xvGpavGNwFo
 VJSA==
X-Gm-Message-State: AC+VfDzS+uOTieBk57klpGHOCy/lw3iBJMpFhkKdDRC7lmrD0bvz0IFn
 C2yvPLRRaNEuRzKBdnrwAWqmqyxIeuYPpNcOaYc7bSL3jBOrfZV6+X52G1neGuFkkyuGjw6zN+b
 5919t/220NTF7Hvc=
X-Received: by 2002:a05:6602:3885:b0:783:42bc:cc5f with SMTP id
 br5-20020a056602388500b0078342bccc5fmr4050961iob.8.1688076753253; 
 Thu, 29 Jun 2023 15:12:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Cv0HcebB4L76z101OCHRiKL2/Z8zxaF9zfAH3g0gyY6JxirpnTSjGnhm+bEUsAv0YckQ/xA==
X-Received: by 2002:a05:6602:3885:b0:783:42bc:cc5f with SMTP id
 br5-20020a056602388500b0078342bccc5fmr4050944iob.8.1688076752921; 
 Thu, 29 Jun 2023 15:12:32 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 c2-20020a02c9c2000000b0042ad9365cb0sm2319218jap.85.2023.06.29.15.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 15:12:32 -0700 (PDT)
Date: Thu, 29 Jun 2023 16:12:30 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org, clg@redhat.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Message-ID: <20230629161230.21fe40b5.alex.williamson@redhat.com>
In-Reply-To: <8032e407-2aad-b39e-a6d2-bc2828360e73@oracle.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-6-zhenzhong.duan@intel.com>
 <9aa97ee7-ee54-a2d3-2cde-36b1a1d1241d@oracle.com>
 <8c9e8103-d194-5e8f-eaa2-1cc16bfb3c9a@nvidia.com>
 <8032e407-2aad-b39e-a6d2-bc2828360e73@oracle.com>
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

On Thu, 29 Jun 2023 16:42:23 +0100
Joao Martins <joao.m.martins@oracle.com> wrote:

> On 29/06/2023 16:20, Avihai Horon wrote:
> > On 29/06/2023 15:44, Joao Martins wrote: =20
> >> On 29/06/2023 09:40, Zhenzhong Duan wrote: =20
> >>> This patch refactors vfio_migration_realize() and its dependend code
> >>> as follows:
> >>>
> >>> 1. It's redundant in vfio_migration_realize() to registers multiple b=
lockers,
> >>> =C2=A0=C2=A0=C2=A0 e.g: vIOMMU blocker can be refactored as per devic=
e blocker.
> >>> 2. Change vfio_viommu_preset() to be only a per device checker.
> >>> 3. Remove global vIOMMU blocker related stuff, e.g:
> >>> =C2=A0=C2=A0=C2=A0 giommu_migration_blocker, vfio_[block|unblock]_gio=
mmu_migration()
> >>> =C2=A0=C2=A0=C2=A0 and vfio_migration_finalize()
> >>> 4. Change vfio_migration_realize(), vfio_block_multiple_devices_migra=
tion()
> >>> =C2=A0=C2=A0=C2=A0 vfio_block_migration() and vfio_viommu_preset() to=
 return bool type.
> >>> 5. Print "Migration disabled" depending on enable_migration property
> >>> =C2=A0=C2=A0=C2=A0 and print it as warning instead of error which is =
overkill.
> >>> =20
> >> I am not enterily sure we need to keep "Migration disabled". Perhaps w=
e should
> >> just derisk from error to warning and use always the same error messag=
es.
> >> =20
> >>> migrate_add_blocker() returns 0 when successfully adding the migratio=
n blocker.
> >>> However, the caller of vfio_migration_realize() considers that migrat=
ion was
> >>> blocked when the latter returned an error. What matters for migration=
 is that
> >>> the blocker is added in core migration, so this cleans up usability s=
uch that
> >>> user sees "Migrate disabled" when any of the vfio migration blockers =
are active
> >>> and it's not intentionally forced by user with enable-migration=3Doff.
> >>>
> >>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> >>> ---
> >>> =C2=A0 hw/vfio/common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66 +++++++----------------------------
> >>> =C2=A0 hw/vfio/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 30 +++++++++-------
> >>> =C2=A0 hw/vfio/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +--
> >>> =C2=A0 include/hw/vfio/vfio-common.h |=C2=A0 7 ++--
> >>> =C2=A0 4 files changed, 36 insertions(+), 71 deletions(-)
> >>>
> >>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >>> index 77e2ee0e5c6e..c80ecb1da53f 100644
> >>> --- a/hw/vfio/common.c
> >>> +++ b/hw/vfio/common.c
> >>> @@ -362,7 +362,6 @@ bool vfio_mig_active(void)
> >>> =C2=A0 }
> >>>
> >>> =C2=A0 static Error *multiple_devices_migration_blocker;
> >>> -static Error *giommu_migration_blocker;
> >>>
> >>> =C2=A0 static unsigned int vfio_migratable_device_num(void)
> >>> =C2=A0 {
> >>> @@ -381,19 +380,19 @@ static unsigned int vfio_migratable_device_num(=
void)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return device_num;
> >>> =C2=A0 }
> >>>
> >>> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Erro=
r **errp)
> >>> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Err=
or **errp)
> >>> =C2=A0 {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (multiple_devices_migration_blocker=
 ||
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_migratabl=
e_device_num() <=3D 1) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vbasedev->enable_migration =3D=3D =
ON_OFF_AUTO_ON) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(err=
p, "Migration is currently not supported with multiple "
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "VFIO devices");
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&multiple_devices_migration=
_blocker,
> >>> @@ -403,9 +402,15 @@ int vfio_block_multiple_devices_migration(VFIODe=
vice
> >>> *vbasedev, Error **errp)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(mul=
tiple_devices_migration_blocker);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multiple_devic=
es_migration_blocker =3D NULL;
> >>> +=C2=A0=C2=A0=C2=A0 } else {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Only ON_OFF_AUTO_=
AUTO case, ON_OFF_AUTO_OFF is checked
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * in vfio_migration=
_realize().
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("Migration di=
sabled, not support multiple VFIO devices");
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =20
> >> Perhaps you could stash the previous error message and use it in the
> >> warn_report_error to consolidate the error messages e.g.
> >>
> >> bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error=
 **errp)
> >> {
> >> =C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 if (multiple_devices_migration_blocker ||
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_migratable_devic=
e_num() <=3D 1) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&err, "%s: Migration is currently =
not supported with multiple "
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "VFIO devices", v=
basedev->name);
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 if (vbasedev->enable_migration =3D=3D ON_OFF_=
AUTO_ON) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagate(errp,=
 err);
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0 ...
> >> =C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> >> =C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Warns only on ON_O=
FF_AUTO_AUTO case */
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report_err(err);=
 =20
> >=20
> > I'm not sure this warning is needed.
> > If I remember correctly, I think Alex didn't want migration error/warni=
ng
> > messages to be logged in the AUTO case.

Correct.

> Hmm, ok, I missed this from the previous discussions.
>=20
> So today there are migration warnings in the current code. (even in the A=
UTO
> case). So if we want them removed, then this patch would then just remove=
 the
> "Migration disabled" all together (in the two places we commented).
>=20
> The rest of the cases already propagate the error I think. And the AUTO c=
ase
> will always be blocked migration and see the same printed messages elsewh=
ere.

I tested this with Avihai's series and saw the correct logging, at
least for a device that does not support migration.

In AUTO mode, we should only ever see errors or warnings if the device
supports migration and an error or incompatibility occurs while further
probing or configuring it.  Lack of support for migration should only
ever generate an error or warning when using enable_migration=3Don or the
global -only-migratable flag.

As I understood Avihai's patch, we're populating the Error pointer, but
we only ever propagate that error in the above cases.  Thanks,

Alex

> >> =C2=A0=C2=A0=C2=A0=C2=A0 }
> >> }
> >> =20
> >>> -=C2=A0=C2=A0=C2=A0 return ret;
> >>> +=C2=A0=C2=A0=C2=A0 return !ret;
> >>> =C2=A0 }
> >>>
> >>> =C2=A0 void vfio_unblock_multiple_devices_migration(void)
> >>> @@ -420,55 +425,10 @@ void vfio_unblock_multiple_devices_migration(vo=
id)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multiple_devices_migration_blocker =3D=
 NULL;
> >>> =C2=A0 }
> >>>
> >>> -static bool vfio_viommu_preset(void)
> >>> +/* Block migration with a vIOMMU */ =20
> >> I meant in the previous version to put the comment on top of the calle=
r, not on
> >> the definition. But with the new code structure from Avihai the error =
message
> >> further below... it will look a bit redundant.
> >> =20
> >>> +bool vfio_viommu_preset(VFIODevice *vbasedev)
> >>> =C2=A0 {
> >>> -=C2=A0=C2=A0=C2=A0 VFIOAddressSpace *space;
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(space, &vfio_address_spaces, list) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (space->as !=3D &addre=
ss_space_memory) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn true;
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> -=C2=A0=C2=A0=C2=A0 }
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0 return false;
> >>> -}
> >>> -
> >>> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
> >>> -{
> >>> -=C2=A0=C2=A0=C2=A0 int ret;
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0 if (giommu_migration_blocker ||
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !vfio_viommu_preset()) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>> -=C2=A0=C2=A0=C2=A0 }
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0 if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO=
_ON) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp,
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Migration is currently not supp=
orted with vIOMMU enabled");
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>> -=C2=A0=C2=A0=C2=A0 }
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0 error_setg(&giommu_migration_blocker,
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "Migration is currently not supported with vIOMMU enable=
d");
> >>> -=C2=A0=C2=A0=C2=A0 ret =3D migrate_add_blocker(giommu_migration_bloc=
ker, errp);
> >>> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(giommu_migrati=
on_blocker);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 giommu_migration_blocker =
=3D NULL;
> >>> -=C2=A0=C2=A0=C2=A0 }
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0 return ret;
> >>> -}
> >>> -
> >>> -void vfio_migration_finalize(void)
> >>> -{
> >>> -=C2=A0=C2=A0=C2=A0 if (!giommu_migration_blocker ||
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_viommu_preset()) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >>> -=C2=A0=C2=A0=C2=A0 }
> >>> -
> >>> -=C2=A0=C2=A0=C2=A0 migrate_del_blocker(giommu_migration_blocker);
> >>> -=C2=A0=C2=A0=C2=A0 error_free(giommu_migration_blocker);
> >>> -=C2=A0=C2=A0=C2=A0 giommu_migration_blocker =3D NULL;
> >>> +=C2=A0=C2=A0=C2=A0 return vbasedev->group->container->space->as !=3D=
 &address_space_memory;
> >>> =C2=A0 }
> >>> =20
> >> nice consolidation
> >> =20
> >>> =C2=A0 static void vfio_set_migration_error(int err)
> >>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >>> index 1db7d52ab2c1..84036e5cfc01 100644
> >>> --- a/hw/vfio/migration.c
> >>> +++ b/hw/vfio/migration.c
> >>> @@ -802,13 +802,13 @@ static int vfio_migration_init(VFIODevice *vbas=
edev)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>> =C2=A0 }
> >>>
> >>> -static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Er=
ror **errp)
> >>> +static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, E=
rror
> >>> **errp)
> >>> =C2=A0 {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vbasedev->enable_migration =3D=3D =
ON_OFF_AUTO_ON) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagat=
e(errp, err);
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbasedev->migration_blocker =3D error_=
copy(err);
> >>> @@ -818,9 +818,11 @@ static int vfio_block_migration(VFIODevice *vbas=
edev,
> >>> Error *err, Error **errp)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_free(vba=
sedev->migration_blocker);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbasedev->migr=
ation_blocker =3D NULL;
> >>> +=C2=A0=C2=A0=C2=A0 } else if (vbasedev->enable_migration !=3D ON_OFF=
_AUTO_OFF) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report("%s: Migratio=
n disabled", vbasedev->name);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =20
> >> Perhaps you can use the the local error to expand on why migration was
> >> disabled e.g.
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 warn_report_err(err);=
 =20
> >=20
> > Same here.
> >=20
> > Thanks.
> >  =20
> >> =20
> >>> -=C2=A0=C2=A0=C2=A0 return ret;
> >>> +=C2=A0=C2=A0=C2=A0 return !ret;
> >>> =C2=A0 }
> >>>
> >>> =C2=A0 /* -----------------------------------------------------------=
----------- */
> >>> @@ -835,7 +837,12 @@ void vfio_reset_bytes_transferred(void)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes_transferred =3D 0;
> >>> =C2=A0 }
> >>>
> >>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> >>> +/*
> >>> + * Return true when either migration initialized or blocker register=
ed.
> >>> + * Currently only return false when adding blocker fails which will
> >>> + * de-register vfio device.
> >>> + */
> >>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> >>> =C2=A0 {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> >>> @@ -873,18 +880,17 @@ int vfio_migration_realize(VFIODevice *vbasedev=
, Error
> >>> **errp)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vbasedev->name);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> -=C2=A0=C2=A0=C2=A0 ret =3D vfio_block_multiple_devices_migration(vba=
sedev, errp);
> >>> -=C2=A0=C2=A0=C2=A0 if (ret) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>> +=C2=A0=C2=A0=C2=A0 if (!vfio_block_multiple_devices_migration(vbased=
ev, errp)) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> -=C2=A0=C2=A0=C2=A0 ret =3D vfio_block_giommu_migration(vbasedev, err=
p);
> >>> -=C2=A0=C2=A0=C2=A0 if (ret) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>> +=C2=A0=C2=A0=C2=A0 if (vfio_viommu_preset(vbasedev)) { =20
> >> The /* Block migration with a vIOMMU */
> >>
> >> Would go above, but I don't think we need it anymore ...
> >> =20
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(&err, "%s: Mig=
ration is currently not supported "
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "with vIOMMU enabled", vbasedev-=
>name);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return vfio_block_migrati=
on(vbasedev, err, errp); =20
> >> ... as the error message when placed here makes it obvious. So the com=
ment I
> >> suggested won't add much. Unless others disagree.
> >> =20
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> -=C2=A0=C2=A0=C2=A0 trace_vfio_migration_realize(vbasedev->name);
> >>> -=C2=A0=C2=A0=C2=A0 return 0;
> >>> +=C2=A0=C2=A0=C2=A0 return true;
> >>> =C2=A0 }
> >>> =20
> >> I think somewhere in function we should have vfio_migration_exit() bei=
ng called
> >> behind a label or elsewhere from vfio_migration_realize (...)
> >> =20
> >>> =C2=A0 void vfio_migration_exit(VFIODevice *vbasedev)
> >>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>> index dc69d3031b24..184d08568154 100644
> >>> --- a/hw/vfio/pci.c
> >>> +++ b/hw/vfio/pci.c
> >>> @@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error=
 **errp)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pdev->failover_pair_id) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D vfio_m=
igration_realize(vbasedev, errp);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_report("%s: Migration disabled", vbasedev->name);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
race_vfio_migration_realize(vbasedev->name);
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 goto out_vfio_migration;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
> >> (...) Which then void the need for this change. Perhaps your previous =
patch
> >> (4/5) could come after this refactor patch instead ... where you would=
 fix the
> >> unwinding error path inside the vfio_migration_realize() as opposed to
> >> vfio_realize().
> >> =20
> >>> @@ -3257,7 +3258,6 @@ static void vfio_instance_finalize(Object *obj)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_put_device(vdev);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vfio_put_group(group);
> >>> -=C2=A0=C2=A0=C2=A0 vfio_migration_finalize();
> >>> =C2=A0 }
> >>>
> >>> =C2=A0 static void vfio_exitfn(PCIDevice *pdev)
> >>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-com=
mon.h
> >>> index 93429b9abba0..3c18572322fc 100644
> >>> --- a/include/hw/vfio/vfio-common.h
> >>> +++ b/include/hw/vfio/vfio-common.h
> >>> @@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIO=
GroupList;
> >>> =C2=A0 extern VFIOGroupList vfio_group_list;
> >>>
> >>> =C2=A0 bool vfio_mig_active(void);
> >>> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Erro=
r **errp);
> >>> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Err=
or **errp);
> >>> =C2=A0 void vfio_unblock_multiple_devices_migration(void);
> >>> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
> >>> +bool vfio_viommu_preset(VFIODevice *vbasedev);
> >>> =C2=A0 int64_t vfio_mig_bytes_transferred(void);
> >>> =C2=A0 void vfio_reset_bytes_transferred(void);
> >>>
> >>> @@ -252,8 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *conta=
iner,
> >>> =C2=A0 int vfio_spapr_remove_window(VFIOContainer *container,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hwaddr offset_within_address_space);
> >>>
> >>> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> >>> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> >>> =C2=A0 void vfio_migration_exit(VFIODevice *vbasedev);
> >>> -void vfio_migration_finalize(void);
> >>>
> >>> =C2=A0 #endif /* HW_VFIO_VFIO_COMMON_H */ =20


