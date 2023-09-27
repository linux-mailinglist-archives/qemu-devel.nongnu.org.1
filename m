Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7C37B0329
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSnM-0002dz-HZ; Wed, 27 Sep 2023 07:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlSnI-0002dJ-8y; Wed, 27 Sep 2023 07:33:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlSnF-00059M-KU; Wed, 27 Sep 2023 07:33:28 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RwZDd5yFWz6DBT0;
 Wed, 27 Sep 2023 19:30:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 12:33:19 +0100
Date: Wed, 27 Sep 2023 12:33:18 +0100
To: Ankit Agrawal <ankita@nvidia.com>
CC: Alex Williamson <alex.williamson@redhat.com>, David Hildenbrand
 <david@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>, "Aniket
 Agashe" <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>,
 <ira.weiny@intel.com>, <navneet.singh@intel.com>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230927123318.00005aad@Huawei.com>
In-Reply-To: <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
 <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 27 Sep 2023 07:14:28 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> > >
> > > Based on the suggestions here, can we consider something like the
> > > following?
> > > 1. Introduce a new -numa subparam 'devnode', which tells Qemu to mark
> > > the node with MEM_AFFINITY_HOTPLUGGABLE in the SRAT's memory affinity
> > > structure to make it hotpluggable. =20
> >
> > Is that "devnode=3Don" parameter required? Can't we simply expose any n=
ode
> > that does *not* have any boot memory assigned as MEM_AFFINITY_HOTPLUGGA=
BLE?

That needs some checking for what extra stuff we'll instantiate on CPU only
(or once we implement them) Generic Initiator / Generic Port nodes -
I'm definitely not keen on doing so for generic ports (which QEMU doesn't y=
et
do though there have been some RFCs I think).

> > Right now, with "ordinary", fixed-location memory devices
> > (DIMM/NVDIMM/virtio-mem/virtio-pmem), we create an srat entry that
> > covers the device memory region for these devices with
> > MEM_AFFINITY_HOTPLUGGABLE. We use the highest NUMA node in the machine,
> > which does not quite work IIRC. All applicable nodes that don't have
> > boot memory would need MEM_AFFINITY_HOTPLUGGABLE for Linux to create th=
em. =20
>=20
> Yeah, you're right that it isn't required. Exposing the node without any =
memory as
> MEM_AFFINITY_HOTPLUGGABLE seems like a better approach than using
> "devnode=3Don".
>=20
> > In your example, which memory ranges would we use for these nodes in SR=
AT? =20
>=20
> We are setting the Base Address and the Size as 0 in the SRAT memory affi=
nity
> structures. This is done through the following:
> build_srat_memory(table_data, 0, 0, i,
>                   MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
>=20
> This results in the following logs in the VM from the Linux ACPI SRAT par=
sing code:
> [    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
> [    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
> [    0.000000] ACPI: SRAT: Node 4 PXM 4 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
> [    0.000000] ACPI: SRAT: Node 5 PXM 5 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
> [    0.000000] ACPI: SRAT: Node 6 PXM 6 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
> [    0.000000] ACPI: SRAT: Node 7 PXM 7 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
> [    0.000000] ACPI: SRAT: Node 8 PXM 8 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
> [    0.000000] ACPI: SRAT: Node 9 PXM 9 [mem 0x00000000-0xfffffffffffffff=
f] hotplug
>=20
> I would re-iterate that we are just emulating the baremetal behavior here.
>=20
>=20
> > I don't see how these numa-node args on a vfio-pci device have any
> > general utility.=A0 They're only used to create a firmware table, so why
> > don't we be explicit about it and define the firmware table as an
> > object?=A0 For example:
> >
> >=A0=A0=A0 =A0=A0=A0 -numa node,nodeid=3D2 \
> >=A0 =A0=A0=A0=A0=A0 -numa node,nodeid=3D3 \
> > =A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D4 \
> >=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D5 \
> >=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D6 \
> >=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D7 \
> >=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D8 \
> >=A0=A0=A0=A0=A0=A0=A0 -numa node,nodeid=3D9 \
> >=A0=A0=A0=A0=A0=A0=A0 -device vfio-pci-nohotplug,host=3D0009:01:00.0,bus=
=3Dpcie.0,addr=3D04.0,rombar=3D0,id=3Dnvgrace0 \
> >=A0=A0=A0=A0=A0=A0=A0 -object nvidia-gpu-mem-acpi,devid=3Dnvgrace0,nodes=
et=3D2-9 \ =20
>=20
> Yeah, that is fine with me. If we agree with this approach, I can go
> implement it.
>=20
>=20
> > There are some suggestions in this thread that CXL could have similar
> > requirements,

For CXL side of things, if talking memory devices (type 3), I'm not
sure what the usecase will be of this feature.
Either we treat them as normal memory in which case it will all be static
at boot of the VM (for SRAT anyway - we might plug things in and
out of ranges), or it will be whole device hotplug and look like pc-dimm
hotplug (which should be into a statically defined range in SRAT).
 Longer term if we look at virtualizing dynamic capacity
devices (not sure we need to other that possibly to leverage
sparse DAX etc on top of them) then we might want to provide
emulated CXL Fixed memory windows in the guest (which get their own=20
NUMA nodes anyway) + plug the memory into that. We'd probably hide
away interleaving etc in the host as all the guest should care about
is performance information and I doubt we'd want to emulate the complexity
of address routing complexities.

Similar to host PA ranges used in CXL fixed memory windows, I'm not sure
we wouldn't just allow for the guest to have 'all' possible setups that
might get plugged later by just burning a lot of HPA space and hence
just be able to use static SRAT nodes covering each region.
This would be less painful than for real PAs because as we are
emulating the CXL devices, probably as one emulated type 3 device per
potential set of real devices in an interleave set we can avoid
all the ordering constraints of CXL address decoders that end up eating
up Host PA space.

Virtualizing DCD is going to be a fun topic (that's next year's
plumbers CXL uconf session sorted ;), but I can see it might be done comple=
tely
differently and look nothing like a CXL device, in which case maybe
what you have here will make sense.

Come to think of it, you 'could' potentially do that for your use case
if the regions are reasonably bound in maximum size at the cost of
large GPA usage?

CXL accelerators / GPUs etc are a different question but who has one
of those anyway? :)


> > but I haven't found any evidence that these
> > dev-mem-pxm-{start,count} attributes in the _DSD are standardized in
> > any way.=A0 If they are, maybe this would be a dev-mem-pxm-acpi object
> > rather than an NVIDIA specific one. =20
>=20
> Maybe Jason, Jonathan can chime in on this?

I'm not aware of anything general around this.  A PCI device
can have a _PXM and I think you could define subdevices each with a
_PXM of their own?  Those subdevices would need drivers to interpret
the structure anyway so not real benefit over a _DSD that I can
immediately think of...

If we think this will be common long term, anyone want to take
multiple _PXM per device support as a proposal to ACPI?

So agreed, it's not general, so if it's acceptable to have 0 length
NUMA nodes (and I think we have to emulate them given that's what real
hardware is doing even if some of us think the real hardware shouldn't
have done that!) then just spinning them up explicitly as nodes
+ device specific stuff for the NVIDIA device seems fine to me.

>=20
>=20
> > It seems like we could almost meet the requirement for this table via
> > -acpitable, but I think we'd like to avoid the VM orchestration tool
> > from creating, compiling, and passing ACPI data blobs into the VM. =20
>=20


