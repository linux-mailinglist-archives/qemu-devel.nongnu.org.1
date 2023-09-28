Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC347B2204
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 18:17:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qltga-0006rt-Lq; Thu, 28 Sep 2023 12:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qltgR-0006lc-EI; Thu, 28 Sep 2023 12:16:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qltgJ-0002qI-Fk; Thu, 28 Sep 2023 12:16:11 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RxJSB55c8z6HJn1;
 Fri, 29 Sep 2023 00:13:30 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 17:15:56 +0100
Date: Thu, 28 Sep 2023 17:15:55 +0100
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>, "David
 Hildenbrand" <david@redhat.com>, =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230928171555.0000604d@Huawei.com>
In-Reply-To: <20230927154240.GB339126@nvidia.com>
References: <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
 <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230927123318.00005aad@Huawei.com>
 <20230927135336.GA339126@nvidia.com>
 <20230927082434.3583361c.alex.williamson@redhat.com>
 <BYAPR12MB33369DCC79212D6040F00560BDC2A@BYAPR12MB3336.namprd12.prod.outlook.com>
 <20230927154240.GB339126@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Wed, 27 Sep 2023 12:42:40 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 27, 2023 at 03:03:09PM +0000, Vikram Sethi wrote:
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Wednesday, September 27, 2023 9:25 AM
> > > To: Jason Gunthorpe <jgg@nvidia.com>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Ankit Agrawal
> > > <ankita@nvidia.com>; David Hildenbrand <david@redhat.com>; C=E9dric Le
> > > Goater <clg@redhat.com>; shannon.zhaosl@gmail.com;
> > > peter.maydell@linaro.org; ani@anisinha.ca; Aniket Agashe
> > > <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti Wankhede
> > > <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>;
> > > Vikram Sethi <vsethi@nvidia.com>; Andy Currid <ACurrid@nvidia.com>;
> > > qemu-arm@nongnu.org; qemu-devel@nongnu.org; Gavin Shan
> > > <gshan@redhat.com>; ira.weiny@intel.com; navneet.singh@intel.com
> > > Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
> > >=20
> > >=20
> > > On Wed, 27 Sep 2023 10:53:36 -0300
> > > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > >  =20
> > > > On Wed, Sep 27, 2023 at 12:33:18PM +0100, Jonathan Cameron wrote:
> > > > =20
> > > > > CXL accelerators / GPUs etc are a different question but who has =
one
> > > > > of those anyway? :) =20
> > > >
> > > > That's exactly what I mean when I say CXL will need it too. I keep
> > > > describing this current Grace & Hopper as pre-CXL HW. You can easia=
lly
> > > > imagine draping CXL around it. CXL doesn't solve the problem that
> > > > motivates all this hackying - Linux can't dynamically create NUMA
> > > > nodes. =20
> > >=20
> > > Why is that and why aren't we pushing towards a solution of removing =
that
> > > barrier so that we don't require the machine topology to be configure=
d to
> > > support this use case and guest OS limitations?  Thanks, =20
>=20
> I haven't looked myself, but I've been told this is very
> hard. Probably the NUMA concept needs to be split a bit so that the
> memory allocator pool handle is not tied to the ACPI.
>=20
> > Even if Linux could create NUMA nodes dynamically for coherent CXL
> > or CXL type devices, there is additional information FW knows that
> > the kernel doesn't. For example, what the distance/latency between
> > CPU and the device NUMA node is. =20
>=20
> But that should just be the existing normal PCIy stuff to define
> affinity of the PCI function. Since the memory is logically linked to
> the PCI function we have no issue from a topology perspective.

Agreed - if there is a node to associate it with, this is easy to cover.
If aim is just to make the info available, could just Generic Initiator
nodes instead.  Those were added for memory free accelerators when the
bios was describing them to fill the gap for things that aren't processors
or memory but for which bandwidth and latency numbers were useful.
This falls into your comment below on the need not being the topology
as such, but rather the number needed for the memory allocator.

>=20
> > While CXL devices present a CDAT table which gives latency type
> > attributes within the device, there would still be some guesswork
> > needed in the kernel as to what the end to end latency/distance is. =20
>=20
> Is it non-uniform per CXL function?

Could be, but if so it is all discoverable. Though mapping is to
device PA range rather than 'function' as such.  You are certainly
allowed lots of different PA ranges with different characteristics.

>=20
> > knows this information and should provide it.  Similarly, QEMU
> > should pass along this information to VMs for the best outcomes. =20
>=20
> Well yes, ideally qemu would pass vCPU affinity for the vPCI functions
> so existing NUMA aware allocations in PCI drivers are optimized. eg we
> put queues in memory close to the PCI function already.

I though we did that via PXBs?

>=20
> I think it is important to keep seperated the need to know the
> topology/affinity/etc and the need for the driver to have a Linux NUMA
> node handle to operate the memory alocator pool APIs.
>=20
> Regardless, it is what it is for the foreseeable future :(
:(

>=20
> Jason


