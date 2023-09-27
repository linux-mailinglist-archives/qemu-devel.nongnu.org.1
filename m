Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 288387B0255
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 13:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSJc-000050-JU; Wed, 27 Sep 2023 07:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlSIy-0008V6-Gt; Wed, 27 Sep 2023 07:02:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qlSIv-0001k1-1P; Wed, 27 Sep 2023 07:02:07 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RwYYY068Sz6K7yw;
 Wed, 27 Sep 2023 19:00:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 12:01:48 +0100
Date: Wed, 27 Sep 2023 12:01:48 +0100
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
Message-ID: <20230927120148.000037a0@Huawei.com>
In-Reply-To: <BY5PR12MB37637E2A77DC8A9AB064ABCEB0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
 <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230925145440.00005072@Huawei.com>
 <20230925140328.GF13733@nvidia.com>
 <20230925155351.00000638@Huawei.com>
 <20230925160043.GH13733@nvidia.com>
 <20230925180038.00003879@Huawei.com>
 <BY5PR12MB37637E2A77DC8A9AB064ABCEB0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Tue, 26 Sep 2023 14:54:36 +0000
Ankit Agrawal <ankita@nvidia.com> wrote:

> > With an ACPI spec clarification agreed then I'm fine with
> > using this for all the cases that have come up in this thread.
> > Or a good argument that this is valid in under existing ACPI spec.  
> 
> Hi Jonathan
> 
> I looked at the Section 5.2.16 in ACPI spec doc, but could not see
> any mention of whether size == 0 is invalid or be avoided. 
> https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
> 
> If that is not convincing, do you have suggestions as to how I may
> confirm this?
>

It's not so much whether 0 size is valid that concerns me (as you
say it isn't ruled out, though given the explanatory text is
is non sensical) but rather whether you are allowed to use
such an entry to add memory that is not within the range later.

To my reading the statement under "Memory Affinity Structure" suggests
not.

"The Memory Affinity structure provides the following topology information
statically to the operating system:

* The association between a _memory range_ and the proximity to which it belongs.
* Information about whether the memory range can be hot-plugged.
"

That doesn't leave space for using it to define a proximity node without
providing the range.  With my 'occasional' contributor to ACPI spec hat on,
(obviously there are people way more versed in this than me!)
I'd suggest that ASWG will ask the obvious question of why does the ACPI
table needs to describe a software entity that is entirely discoverable by
other means?  After all your driver is clearly going to pick up these
nodes and assign them later - so it can just create them.  ACPI spec
doesn't care if Linux can do this or not :(

There are some hacks in place in the kernel (or at least under review)
to deal with a CXL case where there are BIOSes that assign part of the
CXL Fixed Memory Window (a bit of host PA space) to an SRAT entry, but
not the whole of it.  However, I think those are a workaround for a bug
(maybe not everyone agrees with that though).

Perhaps I'm being overly hopeful for clarity and it is fine to
do what you have here.

Jonathan

