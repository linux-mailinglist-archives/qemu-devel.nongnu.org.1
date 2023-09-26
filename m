Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 078EE7AF3F8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDWB-0004pJ-Tk; Tue, 26 Sep 2023 15:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qlDW9-0004p2-83
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qlDW3-0007M2-Nd
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:14:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695755672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bIucCWiIgB50GAMn0+d8O36oS83zmtGAhyXicJWDZ8=;
 b=QuiUr6+AG0kDopFZVP+EBytbjMGiBVvIRL/RTEH0A2o7I27XXWGpsa6+Tzpbm8SakSOIE4
 K5LnDcrRqC/ypyKSnkZO/Bk4aus/FJ4XNrhnf3ykBSn74tTGVrUz186TeGCtLiekpKVUhV
 /XWd2DwcZBw1UykQalAxwUezZBq4Zyg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-k5jA1cmXMtq06OHPChd1Pg-1; Tue, 26 Sep 2023 15:14:30 -0400
X-MC-Unique: k5jA1cmXMtq06OHPChd1Pg-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3512ab05a5dso88941055ab.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695755670; x=1696360470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7bIucCWiIgB50GAMn0+d8O36oS83zmtGAhyXicJWDZ8=;
 b=CKR2hnw8+h21Oa1Du714pqmMBUkiKiS6L28bQz0lkeGKC9Nn64OwtYENG8IYkCr1d9
 GR+7GKxnDkzQ8daDjfaDbNOG/wBZP9M3bgO5/adGNAfyJGXEPhYHWoMCyjV4UX/VRcbW
 7a3p7k8OLwvbeUDHNImhKs1kWpG4tFt6dWQzkljPDnwleyGqBeVjRYqf1O+IKl/WHzZ6
 drDKwmmndXhtX7g+bZ4/dTDZprOi5BFWuJicVypIIzoXywqFYWawmC/0ayg0uJcFWzWl
 gwFRsb5o+phyoI7jJMykr+wO2Kh0rBokmZVjV6uiJt8ptlThix6NyxJtsCuKGhSp1ZV9
 XjBg==
X-Gm-Message-State: AOJu0YyeF4N7Nkn70njcWygBpmCojCtQGUVkY3HwO40YIxGmZHO9AmNX
 Kub23/Up+qt8BXhRiFdN96yRdwMmQcdAmzXiD+JBxC3vu+3gjZMQ82iE7m/ClyDDtPnhjeqF0iq
 WDGgOyBz9mRoTFnc=
X-Received: by 2002:a92:1a08:0:b0:351:4f0c:b968 with SMTP id
 a8-20020a921a08000000b003514f0cb968mr3903969ila.19.1695755670191; 
 Tue, 26 Sep 2023 12:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKxxGm6/3H+1j6jdzwOBespb7OgiBfU20Ygm9TsglFiNtlUeJyZy1QxL6J2d4mrIXFk9dYzw==
X-Received: by 2002:a92:1a08:0:b0:351:4f0c:b968 with SMTP id
 a8-20020a921a08000000b003514f0cb968mr3903946ila.19.1695755669870; 
 Tue, 26 Sep 2023 12:14:29 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 f20-20020a02b794000000b0043a0d66a80csm3606237jam.24.2023.09.26.12.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 12:14:29 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:14:27 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Andy
 Currid <ACurrid@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Gavin Shan
 <gshan@redhat.com>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230926131427.1e441670.alex.williamson@redhat.com>
In-Reply-To: <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
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

On Tue, 26 Sep 2023 18:54:53 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 26.09.23 16:52, Ankit Agrawal wrote:
> >>>>> Good idea.=C2=A0 Fundamentally the device should not be creating NU=
MA
> >>>>> nodes, the VM should be configured with NUMA nodes and the device
> >>>>> memory associated with those nodes. =20
> >>>>
> >>>> +1. That would also make it fly with DIMMs and virtio-mem, where you
> >>>> would want NUMA-less nodes ass well (imagine passing CXL memory to a=
 VM
> >>>> using virtio-mem).
> >>>> =20
> >>>
> >>> We actually do not add the device memory on the host, instead
> >>> map it into the Qemu VMA using remap_pfn_range(). Please checkout the
> >>> mmap function in vfio-pci variant driver code managing the device.
> >>> https://lore.kernel.org/all/20230915025415.6762-1-ankita@nvidia.com/
> >>> And I think host memory backend would need memory that is added on the
> >>> host.
> >>>
> >>> Moreover since we want to passthrough the entire device memory, the
> >>> -object memory-backend-ram would have to be passed a size that is equ=
al
> >>> to the device memory. I wonder if that would be too much of a trouble
> >>> for an admin (or libvirt) triggering the Qemu process.
> >>>
> >>> Both these items are avoided by exposing the device memory as BAR as =
in the
> >>> current=C2=A0 implementation (referenced above) since it lets Qemu to=
 naturally
> >>> discover the device memory region and do mmap.
> >>> =20
> >>
> >> Just to clarify: nNUMA nodes for DIMMs/NVDIMMs/virtio-mem are configur=
ed
> >> on the device, not on the memory backend.
> >>
> >> e.g., -device pc-dimm,node=3D3,memdev=3Dmem1,... =20
> >  =20
>=20
> Alco CCing Gavin, I remember he once experimented with virtio-mem +=20
> multiple memory-less nodes and it was quite working (because of=20
> MEM_AFFINITY_HOTPLUGGABLE only on the last node, below).
>=20
> > Agreed, but still we will have the aforementioned issues viz.
> > 1. The backing memory for the memory device would need to be allocated
> > on the host. However, we do not add the device memory on the host in th=
is
> > case. Instead the Qemu VMA is mapped to the device memory physical
> > address using remap_pfn_range(). =20
>=20
> I don't see why that would be necessary ...
>=20
> > 2. The memory device need to be passed an allocation size such that all=
 of
> > the device memory is mapped into the Qemu VMA. This may not be readily
> > available to the admin/libvirt. =20
>=20
> ... or that. But your proposal roughly looks like what I had in mind, so=
=20
> let's focus on that.
>=20
> >=20
> > Based on the suggestions here, can we consider something like the
> > following?
> > 1. Introduce a new -numa subparam 'devnode', which tells Qemu to mark
> > the node with MEM_AFFINITY_HOTPLUGGABLE in the SRAT's memory affinity
> > structure to make it hotpluggable. =20
>=20
> Is that "devnode=3Don" parameter required? Can't we simply expose any nod=
e=20
> that does *not* have any boot memory assigned as MEM_AFFINITY_HOTPLUGGABL=
E?
>=20
> Right now, with "ordinary", fixed-location memory devices=20
> (DIMM/NVDIMM/virtio-mem/virtio-pmem), we create an srat entry that=20
> covers the device memory region for these devices with=20
> MEM_AFFINITY_HOTPLUGGABLE. We use the highest NUMA node in the machine,=20
> which does not quite work IIRC. All applicable nodes that don't have=20
> boot memory would need MEM_AFFINITY_HOTPLUGGABLE for Linux to create them.
>=20
> In your example, which memory ranges would we use for these nodes in SRAT?
>=20
> > 2. Create several NUMA nodes with 'devnode' which are supposed to be
> > associated with the vfio-pci device.
> > 3. Pass the numa node start and count to associate the nodes created.
> >=20
> > So, the command would look something like the following.
> > ...
> >          -numa node,nodeid=3D2,devnode=3Don \
> >          -numa node,nodeid=3D3,devnode=3Don \
> >          -numa node,nodeid=3D4,devnode=3Don \
> >          -numa node,nodeid=3D5,devnode=3Don \
> >          -numa node,nodeid=3D6,devnode=3Don \
> >          -numa node,nodeid=3D7,devnode=3Don \
> >          -numa node,nodeid=3D8,devnode=3Don \
> >          -numa node,nodeid=3D9,devnode=3Don \
> >          -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.0,ad=
dr=3D04.0,rombar=3D0,numa-node-start=3D2,numa-node-count=3D8 \ =20

I don't see how these numa-node args on a vfio-pci device have any
general utility.  They're only used to create a firmware table, so why
don't we be explicit about it and define the firmware table as an
object?  For example:

	-numa node,nodeid=3D2 \
	-numa node,nodeid=3D3 \
	-numa node,nodeid=3D4 \
	-numa node,nodeid=3D5 \
	-numa node,nodeid=3D6 \
	-numa node,nodeid=3D7 \
	-numa node,nodeid=3D8 \
	-numa node,nodeid=3D9 \
	-device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.0,addr=3D04.0,ro=
mbar=3D0,id=3Dnvgrace0 \
	-object nvidia-gpu-mem-acpi,devid=3Dnvgrace0,nodeset=3D2-9 \

There are some suggestions in this thread that CXL could have similar
requirements, but I haven't found any evidence that these
dev-mem-pxm-{start,count} attributes in the _DSD are standardized in
any way.  If they are, maybe this would be a dev-mem-pxm-acpi object
rather than an NVIDIA specific one.

It seems like we could almost meet the requirement for this table via
-acpitable, but I think we'd like to avoid the VM orchestration tool
from creating, compiling, and passing ACPI data blobs into the VM.
Thanks,

Alex


