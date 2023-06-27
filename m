Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D0C73FDB5
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:22:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9Yp-0004BS-1s; Tue, 27 Jun 2023 10:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qE9Yn-0004Ag-7X
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qE9Yh-0001MO-So
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 10:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687875640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X4B9HhYckq2f62suCcF97qJgQQ7/rsojYJ9RLs1kHsc=;
 b=WcIl0CKfAlKDttGyInLYdcQ7AqJsHMO6rvrK/u4RDTYJZXnsPabe07/Vta4kdHl8lbUaHC
 kMDWTCiypry7OsNm60cRl0VPQCBx4CVGRlLquwS8VuNv87aJZ6Bj5MPq1TWbTUEJxtDMhk
 BAyw3ear85qUEflFliqYz1RqoSLhXhA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-cYm0bBZyM7iVLw4ZCX7wow-1; Tue, 27 Jun 2023 10:20:27 -0400
X-MC-Unique: cYm0bBZyM7iVLw4ZCX7wow-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-780c2585057so357674639f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 07:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687875616; x=1690467616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X4B9HhYckq2f62suCcF97qJgQQ7/rsojYJ9RLs1kHsc=;
 b=cblJ1HP/8rcwDytght2hQwzT8kECN8wYxDsikSfBAQTKkxj+drlH4ASd54hRvBxuu5
 83XkdIIAOGuMRTQ6LZ1EFxJ9+WocaSznC7wwsXHfQqLTy6HvkUyxOLdBQeoPyNJR9LIi
 MZ1ZDVfMxVrQf97jz6Lxt2/1hd/tBEyw9MCZnbL08T1E/Rs0+BT1mkspCA6bfv+NR6g8
 NQ7k4AJ8VOXuToMgzq4gtEWCeZVZJHrrkHu7HRvI7l3EZJS2wICwC0MIKjtbi8jpb6kM
 GFRNBWdR0ZnvOXyYdAnuee80WOqMCt8Zh653gIt/Kyv+ysACmPnEjfzS8uipWltdxOwI
 pHZQ==
X-Gm-Message-State: AC+VfDzArv3SirioLsFI8w71p8ihHQVFw8Ngao61eBLsJBH3pZdDqnGp
 IJisFA5J1KVJIQXuTLFe4nr9mX1y/03kX6LwvC5JuAXHijunEBLoE/bWlr2mG+XTQfr4FGyFp7+
 tUdTJnjPldGLUO6c=
X-Received: by 2002:a5d:96c1:0:b0:76f:1664:672 with SMTP id
 r1-20020a5d96c1000000b0076f16640672mr31281002iol.13.1687875615914; 
 Tue, 27 Jun 2023 07:20:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6XgHLwm5pMYdIFkPhqSKyXpeqttzk8WSOP3lFwcyFA/Yo3F9keKE/Sz/B8e3upZxnTjOsMtA==
X-Received: by 2002:a5d:96c1:0:b0:76f:1664:672 with SMTP id
 r1-20020a5d96c1000000b0076f16640672mr31280969iol.13.1687875615578; 
 Tue, 27 Jun 2023 07:20:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 l14-20020a02a88e000000b00423076f5442sm941122jam.2.2023.06.27.07.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 07:20:14 -0700 (PDT)
Date: Tue, 27 Jun 2023 08:20:13 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, Juan Quintela <quintela@redhat.com>, Peter Xu
 <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Yishai Hadas <yishaih@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Kirti
 Wankhede <kwankhede@nvidia.com>, Tarun Gupta <targupta@nvidia.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Message-ID: <20230627082013.384810ca.alex.williamson@redhat.com>
In-Reply-To: <976b7037-ee62-f86d-5772-6a2deca0816d@nvidia.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
 <20230626112729.06dc48d8.alex.williamson@redhat.com>
 <976b7037-ee62-f86d-5772-6a2deca0816d@nvidia.com>
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

On Tue, 27 Jun 2023 11:00:46 +0300
Avihai Horon <avihaih@nvidia.com> wrote:

> On 26/06/2023 20:27, Alex Williamson wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, 26 Jun 2023 17:26:42 +0200
> > C=C3=A9dric Le Goater <clg@redhat.com> wrote:
> > =20
> >> On 6/26/23 15:40, Joao Martins wrote: =20
> >>> On 26/06/2023 14:20, C=C3=A9dric Le Goater wrote: =20
> >>>> Hello Avihai,
> >>>>
> >>>> On 6/26/23 10:23, Avihai Horon wrote: =20
> >>>>> The major parts of VFIO migration are supported today in QEMU. This
> >>>>> includes basic VFIO migration, device dirty page tracking and preco=
py
> >>>>> support.
> >>>>>
> >>>>> Thus, at this point in time, it seems appropriate to make VFIO migr=
ation
> >>>>> non-experimental: remove the x prefix from enable_migration propert=
y,
> >>>>> change it to ON_OFF_AUTO and let the default value be AUTO.
> >>>>>
> >>>>> In addition, make the following adjustments:
> >>>>> 1. Require device dirty tracking support when enable_migration is A=
UTO
> >>>>>       (i.e., not explicitly enabled). This is because device dirty =
tracking
> >>>>>       is currently the only method to do dirty page tracking, which=
 is
> >>>>>       essential for migrating in a reasonable downtime. =20
> >>>> hmm, I don't think QEMU should decide to disable a feature for all
> >>>> devices supposedly because it could be slow for some. That's too
> >>>> restrictive. What about devices with have small states ? for which
> >>>> the downtime would be reasonable even without device dirty tracking
> >>>> support.
> >>>> =20
> >>> device dirty tracking refers to the ability to tracking dirty IOVA us=
ed by the
> >>> device which will DMA into RAM. It is required because the
> >>> consequence/alternative is to transfer all RAM in stop copy phase. De=
vice state
> >>> size at that point is the least of our problems downtime wise. =20
> >> Arg. thanks for reminding me. I tend to take this for granted ... =20
> > My initial reaction was the same, for instance we could have a non-DMA
> > device (ex. PCI serial card) that supports migration w/o dirty
> > tracking, but QEMU cannot assume the device doesn't do DMA, nor is it
> > worth our time to monitor whether bus-master is ever enabled for the
> > device, so QEMU needs to assume all memory that's DMA accessible for
> > the device is perpetually dirty.  Also, if such a corner case existed
> > for a non-DMA migratable device, the easier path is simply to require
> > dirty tracking stubs in the variant driver to report no memory dirtied.
> > =20
> >>> I can imagine that allowing without dirty tracking is useful for deve=
loper
> >>> testing of the suspend/device-state flows, but as real default (auto)=
 is very
> >>> questionable to let it go through without dirty tracking. When we hav=
e IOMMUFD
> >>> dirty tracking that's when we can relieve this restriction as a defau=
lt.
> >>>
> >>> But then note that (...)
> >>> =20
> >>>>> Setting
> >>>>>       enable_migration to ON will not require device dirty tracking=
. =20
> >>> (...) this lets it ignore dirty tracking as you would like.
> >>>
> >>> =20
> >>>>> 2. Make migration blocker messages more elaborate.
> >>>>> 3. Remove error prints in vfio_migration_query_flags().
> >>>>> 4. Remove a redundant assignment in vfio_migration_realize().
> >>>>>
> >>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> >>>>> ---
> >>>>>     include/hw/vfio/vfio-common.h |=C2=A0 2 +-
> >>>>>     hw/vfio/migration.c           | 29 ++++++++++++++++-------------
> >>>>>     hw/vfio/pci.c                 |=C2=A0 4 ++--
> >>>>>     3 files changed, 19 insertions(+), 16 deletions(-)
> >>>>>
> >>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-c=
ommon.h
> >>>>> index b4c28f318f..387eabde60 100644
> >>>>> --- a/include/hw/vfio/vfio-common.h
> >>>>> +++ b/include/hw/vfio/vfio-common.h
> >>>>> @@ -139,7 +139,7 @@ typedef struct VFIODevice {
> >>>>>         bool needs_reset;
> >>>>>         bool no_mmap;
> >>>>>         bool ram_block_discard_allowed;
> >>>>> -    bool enable_migration;
> >>>>> +    OnOffAuto enable_migration;
> >>>>>         VFIODeviceOps *ops;
> >>>>>         unsigned int num_irqs;
> >>>>>         unsigned int num_regions;
> >>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >>>>> index 79eb81dfd7..d8e0848635 100644
> >>>>> --- a/hw/vfio/migration.c
> >>>>> +++ b/hw/vfio/migration.c
> >>>>> @@ -731,14 +731,6 @@ static int vfio_migration_query_flags(VFIODevi=
ce
> >>>>> *vbasedev, uint64_t *mig_flags)
> >>>>>         feature->argsz =3D sizeof(buf);
> >>>>>         feature->flags =3D VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FE=
ATURE_MIGRATION;
> >>>>>         if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
> >>>>> -        if (errno =3D=3D ENOTTY) {
> >>>>> -            error_report("%s: VFIO migration is not supported in k=
ernel",
> >>>>> -                         vbasedev->name);
> >>>>> -        } else {
> >>>>> -            error_report("%s: Failed to query VFIO migration suppo=
rt, err: %s",
> >>>>> -                         vbasedev->name, strerror(errno));
> >>>>> -        }
> >>>>> -
> >>>>>             return -errno;
> >>>>>         }
> >>>>>     @@ -831,14 +823,28 @@ void vfio_reset_bytes_transferred(void)
> >>>>>       int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> >>>>>     {
> >>>>> -    int ret =3D -ENOTSUP;
> >>>>> +    int ret;
> >>>>>     -    if (!vbasedev->enable_migration) {
> >>>>> +    if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_OFF) {
> >>>>> +        error_setg(&vbasedev->migration_blocker,
> >>>>> +                   "%s: Migration is disabled for VFIO device", vb=
asedev->name);
> >>>>>             goto add_blocker;
> >>>>>         }
> >>>>>           ret =3D vfio_migration_init(vbasedev);
> >>>>>         if (ret) { =20
> >>>> It would be good to keep the message for 'errno =3D=3D ENOTTY' as it=
 was in
> >>>> vfio_migration_query_flags(). When migration fails, it is an importa=
nt
> >>>> information to know that it is because the VFIO PCI host device driv=
er
> >>>> doesn't support the feature. The root cause could be deep below in F=
W or
> >>>> how the VF was set up.
> >>>> =20
> >>> +1 As I have been in this rabbit hole =20
>=20
> Sure, I will add it.
>=20
> >>> =20
> >>>>> +        error_setg(&vbasedev->migration_blocker,
> >>>>> +                   "%s: Migration couldn't be initialized for VFIO=
 device, "
> >>>>> +                   "err: %d (%s)",
> >>>>> +                   vbasedev->name, ret, strerror(-ret));
> >>>>> +        goto add_blocker;
> >>>>> +    }
> >>>>> +
> >>>>> +    if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_AUTO &&
> >>>>> +        !vbasedev->dirty_pages_supported) { =20
> >>>> I don't agree with this test.
> >>>> =20
> >>> The alternative right now is perceptual dirty tracking. How is that O=
K as a
> >>> default? It's not like we have even an option :(
> >>>
> >>> Maybe perhaps you refer to avoid strongly enforcing *always* it to al=
low testing
> >>> of the non dirty tracking parts? Maybe when you 'force' enabling with
> >>> enable-migration=3Don is when you ignore the dirty tracking which is =
what this is
> >>> doing. =20
> >>
> >> I see ON_OFF_AUTO_ON as a way to abort the machine startup while
> >> ON_OFF_AUTO_AUTO would let it run but block migration. =20
> > Agreed.  There's a little bit of redundancy between the device-level
> > "enable-migration=3Don" option and the global "-only-migratable" option
> > relative to preventing machine startup, but it also doesn't make sense
> > to me if the device-level option let realize complete successfully if
> > the device doesn't support or fails migration setup.  So I think we'd
> > generally rely on using the -only-migratable option with the default
> > ON_OFF_AUTO_AUTO value, allow the ON_OFF_AUTO_ON value to enable
> > dis-recommended support, and live with the redundancy that it should
> > also cause the device realize to fail if migration is not supported.
> > Thanks,
> >
> > Alex =20
>=20
> OK.
>=20
> When enable_migration=3DAUTO we allow blockers.
> When enable_migration=3DON we don't allow blockers and instead prevent=20
> realization of VFIO device.
>=20
> Regarding device dirty tracking, we keep current behavior, right?
> That is:
> When enable_migration=3DAUTO we block migration if device dirty tracking=
=20
> is not supported.
> When enable_migration=3DON we allow migration even if device dirty=20
> tracking is not supported (in which case DMA-able memory will be=20
> perpetually dirtied).

Yes, and I think we'd be justified in logging a warning when migration
is enabled without any dirty page tracking support.  Thanks,

Alex


