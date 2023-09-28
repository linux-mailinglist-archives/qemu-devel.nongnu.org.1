Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3F97B2262
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 18:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlttV-0003ur-Di; Thu, 28 Sep 2023 12:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlttT-0003u4-EP; Thu, 28 Sep 2023 12:29:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlttP-0006VV-OY; Thu, 28 Sep 2023 12:29:39 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RxJpZ4K53z6K9Hv;
 Fri, 29 Sep 2023 00:29:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 28 Sep
 2023 17:29:28 +0100
Date: Thu, 28 Sep 2023 17:29:27 +0100
To: Alex Williamson <alex.williamson@redhat.com>
CC: Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Ankit
 Agrawal <ankita@nvidia.com>, David Hildenbrand <david@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Gavin Shan <gshan@redhat.com>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "navneet.singh@intel.com" <navneet.singh@intel.com>
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230928172927.00005f5d@Huawei.com>
In-Reply-To: <20230927103737.35068bae.alex.williamson@redhat.com>
References: <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
 <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230927123318.00005aad@Huawei.com>
 <20230927135336.GA339126@nvidia.com>
 <20230927082434.3583361c.alex.williamson@redhat.com>
 <BYAPR12MB33369DCC79212D6040F00560BDC2A@BYAPR12MB3336.namprd12.prod.outlook.com>
 <20230927103737.35068bae.alex.williamson@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Wed, 27 Sep 2023 10:37:37 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 27 Sep 2023 15:03:09 +0000
> Vikram Sethi <vsethi@nvidia.com> wrote:
>=20
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
> > >    =20
> > > > On Wed, Sep 27, 2023 at 12:33:18PM +0100, Jonathan Cameron wrote:
> > > >   =20
> > > > > CXL accelerators / GPUs etc are a different question but who has =
one
> > > > > of those anyway? :)   =20
> > > >
> > > > That's exactly what I mean when I say CXL will need it too. I keep
> > > > describing this current Grace & Hopper as pre-CXL HW. You can easia=
lly
> > > > imagine draping CXL around it. CXL doesn't solve the problem that
> > > > motivates all this hackying - Linux can't dynamically create NUMA
> > > > nodes.   =20
> > >=20
> > > Why is that and why aren't we pushing towards a solution of removing =
that
> > > barrier so that we don't require the machine topology to be configure=
d to
> > > support this use case and guest OS limitations?  Thanks,
> > >   =20
> >=20
> > Even if Linux could create NUMA nodes dynamically for coherent CXL or C=
XL type devices,=20
> > there is additional information FW knows that the kernel doesn't. For e=
xample,
> > what the distance/latency between CPU and the device NUMA node is. Whil=
e CXL devices
> > present a CDAT table which gives latency type attributes within the dev=
ice, there would still be some
> > guesswork needed in the kernel as to what the end to end latency/distan=
ce is.=20
> > It's probably not the best outcome to just consider this generically fa=
r memory" because=20
> > is it further than Intersocket memory access or not matters.=20
> > Pre CXL devices such as for this patchset don't even have CDAT so the k=
ernel by itself has
> > no idea if this latency/distance is less than or more than inter socket=
 memory access latency
> > even.
> > So specially for devices present at boot, FW knows this information and=
 should provide it.=20
> > Similarly, QEMU should pass along this information to VMs for the best =
outcomes.   =20
>=20
> Yeah, AFAICT we're not doing any of that in this series.  We're only
> creating some number of nodes for the guest driver to make use of and
> describing in the generated _DSD the set of nodes associated for use by
> the device.  How many nodes are required, how the guest driver
> partitions coherent memory among the nodes, and how the guest assigns a
> distance to the nodes is unspecified.
>=20
> A glance at the CDAT spec seems brilliant in this regard, is there such
> a table for this device or could/should the vfio-pci variant driver
> provide one?  I imagine this is how the VM admin or orchestration tool
> would learn to configure nodes and the VMM would further virtualize
> this table for the guest OS and drivers.  Thanks,

I like this proposal. Host bit seems doable.  However I'm not sure
virtualizing it would help for device drivers that have no awareness unless
we slap some generic layer in the driver core in Linux that can use this if
available?  It would certainly be easy enough to add emulation into the gue=
st
to the PCI function config space (as long as we aren't out of room!)

For CXL I think we will have to do this anyway. For a complex topology we
could either:
1) Present a matching topology in the guest with all the components involved
   including switches with right numbers of ports etc so the CDAT tables
   can be read directly from underlying hardware, or...
2) Present a somewhat matching topology in the guest having just messed with
   switches so that we can present their existence but not all the ports et=
c.
   So emulate a cut down CDAT for the switch.
3) Allow flattening everything and present a single CDAT with aggregate num=
bers
   at the EP. That will get a bit messy as we may need the kernel to ignore=
 some
   parts it would normally account for (link widths on CXL buses etc.)

So I'm thinking 1 is to restrictive, hence need to emulate the table anyway
(not mention it might not be on the function being assigned anyway as they
are normally only on Function 0 IIRC).

Gah. Too much of CXL emulation still to do in QEMU already....

Jonathan




>=20
> Alex
>=20


