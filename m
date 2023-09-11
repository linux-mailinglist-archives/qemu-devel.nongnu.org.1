Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B2C79AAD9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 20:37:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfll5-00010R-Ei; Mon, 11 Sep 2023 14:35:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qfll0-0000ys-6u
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 14:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qflkx-0008Kk-Jo
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 14:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694457328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MymfQjy7qAVfhAuw9WHvOC1W6wTpTiGuJleydUBUGao=;
 b=i1sG/QWowxtqDGmc+RhODU/RNEWLfDc/6kBDuA1n8+HkpoYVfknl1cWV/Rc8D7xopGxlVx
 PPUqK1BSAMFTC16kezXxxzN2ecNf2q2F6Qt9uk4hZNT3Y5cXlf+G1veA7VdR7VrCoqmMf3
 IarRTHwkO6QVW2xv5JJzkaLtxInofHU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-ME5hARoZP1-vjj_wPwEzLA-1; Mon, 11 Sep 2023 14:35:27 -0400
X-MC-Unique: ME5hARoZP1-vjj_wPwEzLA-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-34bbbf67e03so30349695ab.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694457326; x=1695062126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MymfQjy7qAVfhAuw9WHvOC1W6wTpTiGuJleydUBUGao=;
 b=KmbCh+4gMFq5VN2qj8hrishgGwbpl8GqM/vPpCNbwZoC9R8HDhsWCReq9cQ9ltO2kZ
 heKsXE6Jxe2NuA9B08LmuTxd572GhKQNDIg5qwQi8ck93ivWf01259ANqYnleSGOrP8n
 4AQp41EyhuF0w5dLGo0QHIXYIn3f/rYiP2tsJbrDy1GipbFiH9yLyEdzHzQUNgMe/hqO
 te6+8lMfOvLiW75bNupRlkjW1FHehlE7hM99WBOHCgtPufd28TIJiP7pZOmdai7DEIg/
 1/i+bbJrmFrJTtBx/kxbiKhYJM24rFMUR/qwD8NA5MQNCHOV7hLsmR0DfwIL9iAyG6Qr
 7OuA==
X-Gm-Message-State: AOJu0Yw4Q/9JnaEhRcF2AiEDmwUZSZBm+txsXQ4819Fy7AsPplXegDH8
 cEi9z4QyJ7r1l1BDdKP5scInKGYKWm8X4L8MtYyOv64Pq8rC1qkHUOVjB6ikl9IOLFtp63FqahV
 DuoDRAbqSZW097Eo=
X-Received: by 2002:a92:c5a5:0:b0:34f:7a25:eef3 with SMTP id
 r5-20020a92c5a5000000b0034f7a25eef3mr3452225ilt.26.1694457326367; 
 Mon, 11 Sep 2023 11:35:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0WenJg9rDrwRi0YUIMy7yoQbhCu6pnpXeNhbRJCgs8Gez/8K7kzCeuhGvgPn5gm1bWKWM7w==
X-Received: by 2002:a92:c5a5:0:b0:34f:7a25:eef3 with SMTP id
 r5-20020a92c5a5000000b0034f7a25eef3mr3452210ilt.26.1694457326142; 
 Mon, 11 Sep 2023 11:35:26 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 t16-20020a02c490000000b0043021113e09sm2238086jam.75.2023.09.11.11.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 11:35:25 -0700 (PDT)
Date: Mon, 11 Sep 2023 12:35:24 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Cedric Le Goater
 <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
Message-ID: <20230911123524.2cf53cbb.alex.williamson@redhat.com>
In-Reply-To: <c2a52c37-b6e5-1229-3e22-90a5ad8068b6@oracle.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
 <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <c2a52c37-b6e5-1229-3e22-90a5ad8068b6@oracle.com>
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

On Mon, 11 Sep 2023 11:12:55 +0100
Joao Martins <joao.m.martins@oracle.com> wrote:

> On 11/09/2023 10:48, Duan, Zhenzhong wrote:
> >> -----Original Message-----
> >> From: Joao Martins <joao.m.martins@oracle.com>
> >> Sent: Monday, September 11, 2023 5:07 PM
> >> Subject: Re: [PATCH v1] vfio/common: Separate vfio-pci ranges
> >>
> >> On 11/09/2023 09:57, Duan, Zhenzhong wrote: =20
> >>>> -----Original Message-----
> >>>> From: qemu-devel-bounces+zhenzhong.duan=3Dintel.com@nongnu.org <qemu-
> >>>> devel-bounces+zhenzhong.duan=3Dintel.com@nongnu.org> On Behalf Of Jo=
ao
> >>>> Martins
> >>>> Sent: Friday, September 8, 2023 5:30 PM
> >>>> Subject: [PATCH v1] vfio/common: Separate vfio-pci ranges
> >>>>
> >>>> QEMU computes the DMA logging ranges for two predefined ranges: 32-b=
it
> >>>> and 64-bit. In the OVMF case, when the dynamic MMIO window is enable=
d,
> >>>> QEMU includes in the 64-bit range the RAM regions at the lower part
> >>>> and vfio-pci device RAM regions which are at the top of the address
> >>>> space. This range contains a large gap and the size can be bigger th=
an
> >>>> the dirty tracking HW limits of some devices (MLX5 has a 2^42 limit).
> >>>>
> >>>> To avoid such large ranges, introduce a new PCI range covering the
> >>>> vfio-pci device RAM regions, this only if the addresses are above 4GB
> >>>> to avoid breaking potential SeaBIOS guests.
> >>>>
> >>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >>>> [ clg: - wrote commit log
> >>>>       - fixed overlapping 32-bit and PCI ranges when using SeaBIOS ]
> >>>> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> >>>> ---
> >>>> v2:
> >>>> * s/minpci/minpci64/
> >>>> * s/maxpci/maxpci64/
> >>>> * Expand comment to cover the pci-hole64 and why we don't do special
> >>>>  handling of pci-hole32.
> >>>> ---
> >>>> hw/vfio/common.c     | 71 +++++++++++++++++++++++++++++++++++++-----=
--
> >>>> hw/vfio/trace-events |  2 +-
> >>>> 2 files changed, 61 insertions(+), 12 deletions(-)
> >>>>
> >>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >>>> index 237101d03844..134649226d43 100644
> >>>> --- a/hw/vfio/common.c
> >>>> +++ b/hw/vfio/common.c
> >>>> @@ -27,6 +27,7 @@
> >>>>
> >>>> #include "hw/vfio/vfio-common.h"
> >>>> #include "hw/vfio/vfio.h"
> >>>> +#include "hw/vfio/pci.h"
> >>>> #include "exec/address-spaces.h"
> >>>> #include "exec/memory.h"
> >>>> #include "exec/ram_addr.h"
> >>>> @@ -1400,6 +1401,8 @@ typedef struct VFIODirtyRanges {
> >>>>     hwaddr max32;
> >>>>     hwaddr min64;
> >>>>     hwaddr max64;
> >>>> +    hwaddr minpci64;
> >>>> +    hwaddr maxpci64;
> >>>> } VFIODirtyRanges;
> >>>>
> >>>> typedef struct VFIODirtyRangesListener {
> >>>> @@ -1408,6 +1411,31 @@ typedef struct VFIODirtyRangesListener {
> >>>>     MemoryListener listener;
> >>>> } VFIODirtyRangesListener;
> >>>>
> >>>> +static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
> >>>> +                                     VFIOContainer *container)
> >>>> +{
> >>>> +    VFIOPCIDevice *pcidev;
> >>>> +    VFIODevice *vbasedev;
> >>>> +    VFIOGroup *group;
> >>>> +    Object *owner;
> >>>> +
> >>>> +    owner =3D memory_region_owner(section->mr);
> >>>> +
> >>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
> >>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
> >>>> +            if (vbasedev->type !=3D VFIO_DEVICE_TYPE_PCI) {
> >>>> +                continue;
> >>>> +            }
> >>>> +            pcidev =3D container_of(vbasedev, VFIOPCIDevice, vbased=
ev);
> >>>> +            if (OBJECT(pcidev) =3D=3D owner) {
> >>>> +                return true;
> >>>> +            }
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    return false;
> >>>> +} =20
> >>>
> >>> What about simplify it with memory_region_is_ram_device()?
> >>> This way vdpa device could also be included.
> >>> =20
> >>
> >> Note that the check is not interested in RAM (or any other kinda of me=
mory like
> >> VGA). That's covered in the 32-64 ranges. But rather in any PCI device=
 RAM that
> >> would fall in the 64-bit PCI hole. Would memory_region_is_ram_device()=
 really
> >> cover it? If so, I am all for the simplification. =20
> >=20
> > Ram device is used not only by vfio pci bars but also host notifier of =
vdpa and vhost-user.
> >=20
> > I have another question, previously I think vfio pci bars are device st=
ates and
> > save/restored through VFIO migration protocol, so we don't need to dirty
> > tracking them. Do I understand wrong? =20
>=20
> The general thinking of device dirty tracking is to track all addressable=
 IOVAs.
> But you do raise a good question. My understanding is that migrating the =
bars
> *as is* might be device migration specific (not a guarantee?); the save f=
ile and
> precopy interface are the only places we transfer from/to the data and it=
's just
> opaque data, not bars or anything formatted specifically -- so if we migr=
ate
> bars it is hidden in what device f/w wants to move. Might be that BARs ar=
en't
> even needed as they are sort of scratch space from h/w side. Ultimately, =
the
> dirty tracker is the one reporting the values, and the device h/w chooses=
 to not
> report those IOVAs as dirty then nothing changes.

I think ram_device is somewhat controversial, only a few select device
types make use of it, so for example an emulated NIC not making use of
ram_device might still exist within the IOVA aperture of the device.

It does however seem strange to me to include the MMIO space of other
devices in the dirty tracking of the vfio device.  I'm not sure it's
really the vfio device's place to report MMIO within another device as
dirty.  Saving grace being that this likely doesn't really occur
currently, but should the vfio device even exert any resources for
tracking such ranges?

A concern with simply trying to define RAM vs PCI ranges is that QEMU
is pretty fluid about the VM layout.  For example, what prevents us
from having a NUMA configuration where one memory node might be
similarly disjoint as between RAM and PCI memory here?  TBH, I thought
this was why we had the combine_iova_ranges() function in the kernel so
that QEMU simply wrote through the dirty tracking ranges and the driver
combined them as necessary based on their own constraints.  Thanks,

Alex


