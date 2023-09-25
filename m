Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7237AD9A0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 15:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkm3D-0005KD-Md; Mon, 25 Sep 2023 09:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkm3A-0005Hr-GH; Mon, 25 Sep 2023 09:55:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkm37-0006OC-Tt; Mon, 25 Sep 2023 09:55:00 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvPPj5XGvz6K9h1;
 Mon, 25 Sep 2023 21:49:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 14:54:42 +0100
Date: Mon, 25 Sep 2023 14:54:40 +0100
To: Ankit Agrawal <ankita@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "ani@anisinha.ca"
 <ani@anisinha.ca>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, "Andy
 Currid" <ACurrid@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for
 NUMA nodes
Message-ID: <20230925145440.00005072@Huawei.com>
In-Reply-To: <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
 <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
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

On Fri, 22 Sep 2023 05:49:46 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> Hi Jonathan

Hi Ankit,

> 
> > > +        if (pcidev->pdev.has_coherent_memory) {
> > > +            uint64_t start_node = object_property_get_uint(obj,
> > > +                                  "dev_mem_pxm_start", &error_abort);
> > > +            uint64_t node_count = object_property_get_uint(obj,
> > > +                                  "dev_mem_pxm_count", &error_abort);
> > > +            uint64_t node_index;
> > > +
> > > +            /*
> > > +             * Add the node_count PXM domains starting from start_node as
> > > +             * hot pluggable. The VM kernel parse the PXM domains and
> > > +             * creates NUMA nodes.
> > > +             */
> > > +            for (node_index = 0; node_index < node_count; node_index++)
> > > +                build_srat_memory(table_data, 0, 0, start_node + node_index,
> > > +                    MEM_AFFINITY_ENABLED |
> > > + MEM_AFFINITY_HOTPLUGGABLE);  
> > 
> > 0 size SRAT entries for memory? That's not valid.  
> 
> Can you explain in what sense are these invalid? The Linux kernel accepts
> such setting and I had tested it.

ACPI specification doesn't define any means of 'updating' the memory range,
so whilst I guess they are not specifically disallowed without a spec definition
of what it means this is walking into a mine field. In particular the 
description of the hot pluggable bit worries me:
"The system hardware supports hot-add and hot-remove of this memory region."
So I think your definition is calling out that you can hot plug memory into
a region of zero size. To me that's nonsensical so a paranoid OS writer
might just spit out firmware error message and refuse to boot.

There is no guarantee other operating systems won't blow up if they see one
of these. To be able to do this safely I think you probably need an ACPI
spec update to say what such a zero length, zero base region means.

Possible the ASWG folk would say this is fine and I'm reading too much into
the spec, but I'd definitely suggest asking them via the appropriate path,
or throwing in a code first proposal for a comment on this special case and
see what response you get - my guess is it will be 'fix Linux' :(

> 
> > Seems like you've run into the same issue CXL has with dynamic addition of
> > nodes to the kernel and all you want to do here is make sure it thinks there are
> > enough nodes so initializes various structures large enough.
> >  
> Yes, exactly.
> 


