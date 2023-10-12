Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8897C68BE
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 11:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqrYH-0007jy-Ed; Thu, 12 Oct 2023 05:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qqrY6-0007jE-6k; Thu, 12 Oct 2023 05:00:06 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qqrY0-0007YW-QP; Thu, 12 Oct 2023 05:00:04 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5k743qdfz6K6XZ;
 Thu, 12 Oct 2023 16:57:52 +0800 (CST)
Received: from localhost (10.48.155.47) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 12 Oct
 2023 09:59:55 +0100
Date: Thu, 12 Oct 2023 09:59:54 +0100
To: Vikram Sethi <vsethi@nvidia.com>
CC: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com"
 <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>, 
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Andy
 Currid <ACurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Dave Jiang
 <dave.jiang@intel.com>, "Shanker Donthineni" <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/3] qom: new object to associate device to numa node
Message-ID: <20231012095954.00006ebb@Huawei.com>
In-Reply-To: <BYAPR12MB3336E4ABBB0CBD3C87222DA7BDCCA@BYAPR12MB3336.namprd12.prod.outlook.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-2-ankita@nvidia.com>
 <20231009132642.00002c8d@Huawei.com>
 <BYAPR12MB3336E4ABBB0CBD3C87222DA7BDCCA@BYAPR12MB3336.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.155.47]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
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

On Wed, 11 Oct 2023 17:37:11 +0000
Vikram Sethi <vsethi@nvidia.com> wrote:

> Hi Jonathan,
> 
> > -----Original Message-----
> > From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> > Sent: Monday, October 9, 2023 7:27 AM
> > To: Ankit Agrawal <ankita@nvidia.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>; alex.williamson@redhat.com;
> > clg@redhat.com; shannon.zhaosl@gmail.com; peter.maydell@linaro.org;
> > ani@anisinha.ca; berrange@redhat.com; eduardo@habkost.net;
> > imammedo@redhat.com; mst@redhat.com; eblake@redhat.com;
> > armbru@redhat.com; david@redhat.com; gshan@redhat.com; Aniket
> > Agashe <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti Wankhede
> > <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>;
> > Vikram Sethi <vsethi@nvidia.com>; Andy Currid <acurrid@nvidia.com>;
> > Dheeraj Nigam <dnigam@nvidia.com>; Uday Dhoke <udhoke@nvidia.com>;
> > qemu-arm@nongnu.org; qemu-devel@nongnu.org; Dave Jiang
> > <dave.jiang@intel.com>
> > Subject: Re: [PATCH v2 1/3] qom: new object to associate device to numa
> > node
> > 
> > 
> > On Sun, 8 Oct 2023 01:47:38 +0530
> > <ankita@nvidia.com> wrote:
> >   
> > > From: Ankit Agrawal <ankita@nvidia.com>
> > >
> > > The CPU cache coherent device memory can be added as NUMA nodes
> > > distinct from the system memory nodes. These nodes are associated with
> > > the device and Qemu needs a way to maintain this link.  
> > 
> > Hi Ankit,
> > 
> > I'm not sure I'm convinced of the approach to creating nodes for memory
> > usage (or whether that works in Linux on all NUMA ACPI archs), but I am
> > keen to see Generic Initiator support in QEMU. I'd also like to see it done in a
> > way that naturally extends to Generic Ports which are very similar (but don't
> > hang memory off them! :) Dave Jiang posted a PoC a while back for generic
> > ports.
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
> > kernel.org%2Fqemu-
> > devel%2F168185633821.899932.322047053764766056.stgit%40djiang5-
> > mobl3%2F&data=05%7C01%7Cvsethi%40nvidia.com%7C846b19f87bc5424d
> > c33608dbc8c3015d%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7
> > C638324512146712954%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> > 7C%7C&sdata=v318MXognoITHyv7AFqZAfvUi2hLy2ZUVnLvyQ2IAfY%3D&res
> > erved=0
> > 
> > My concern with this approach is that it is using a side effect of a Linux
> > implementation detail that the infra structure to bring up coherent memory
> > is all present even for a GI only node (if it is which I can't recall) I'm also fairly
> > sure we never tidied up the detail of going from the GI to the device in Linux
> > (because it's harder than a _PXM entry for the device).  It requires stashing a
> > better description than the BDF before potentially doing reenumeration so
> > that we can rebuild the association after that is done.
> >   
> 
> I'm not sure I understood the concern. Are you suggesting that the ACPI specification
> somehow prohibits memory associated with a GI node in the same PXM? i.e whether the GI is memory-less
> or with memory isn't mandated by the spec IIRC. Certainly seems perfectly normal
> for an accelerator with memory to have a GI with memory and that memory be able to be associated with the same PXM. 

Indeed reasonable that a GI would have associated memory, but if it's
"normal memory" (i.e. coherent and not device private memory accessed by PCI bar
etc) then expectation would be that memory is in SRAT as a memory entry.
Which brings us back to the original question of whether 0 sized memory nodes
are fine.

> So what about this patch is using a Linux implementation detail? Even if Linux wasn't currently supporting
> that use case, it is something that would have been reasonable to add IMO. What am I missing?

Linux is careful to only bring up the infrastructure for specific types of 
roximity node. It works its way through SRAT and sets appropriate bitmap bits
to say which combination of PXM node types a given node is. (CPU, Memory, GI etc)

After that walk is done it then brings up various infrastructure.
What I can't remember (you'll need to experiment) is if there is anything not
brought up for a non Memory node that you would need.  Might be fine, but that
doesn't mean it will remain fine.  Maybe we just need to make sure the documentation
/ comments in Linux cover this use case.  You are on your own for what other
OSes decided is valid here as the specifcation does not mention this AFAIK.
If it does then add a reference.

There is a non trivial (potential) cost to enabling facilities on NUMA nodes that
will never make use of them - a bunch of longer searches etc when looking
for memory.  For GIs we enable pretty much everything a CPU node uses.
That was controversial though only well after support was already in - the
controversy being that it added costs to paths that didn't care about GIs.

Basically it boils down to using unexpected corners of specifications may
prove fragile.

For one thing I'm doubtful if the NUMA description the kernel exposes (coming
from a subset of HMAT) won't deal with this case.  Not tried it though
so you may be lucky.

Jonathan



