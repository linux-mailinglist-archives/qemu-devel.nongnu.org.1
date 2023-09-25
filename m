Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 353837ADD86
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:01:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkowz-0005Rb-HL; Mon, 25 Sep 2023 13:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkowv-0005RJ-6F; Mon, 25 Sep 2023 13:00:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkowt-00005p-Cz; Mon, 25 Sep 2023 13:00:44 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvTXG6H3lz6K9G1;
 Tue, 26 Sep 2023 00:55:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 18:00:39 +0100
Date: Mon, 25 Sep 2023 18:00:38 +0100
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Ankit Agrawal <ankita@nvidia.com>, "alex.williamson@redhat.com"
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
Message-ID: <20230925180038.00003879@Huawei.com>
In-Reply-To: <20230925160043.GH13733@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
 <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230925145440.00005072@Huawei.com>
 <20230925140328.GF13733@nvidia.com>
 <20230925155351.00000638@Huawei.com>
 <20230925160043.GH13733@nvidia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 25 Sep 2023 13:00:43 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Sep 25, 2023 at 03:53:51PM +0100, Jonathan Cameron wrote:
> > On Mon, 25 Sep 2023 11:03:28 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Sep 25, 2023 at 02:54:40PM +0100, Jonathan Cameron wrote:
> > >   
> > > > Possible the ASWG folk would say this is fine and I'm reading too much into
> > > > the spec, but I'd definitely suggest asking them via the appropriate path,
> > > > or throwing in a code first proposal for a comment on this special case and
> > > > see what response you get - my guess is it will be 'fix Linux' :(    
> > > 
> > > The goal here is for qemu to emulate what the bare metal environment
> > > is doing.
> > > 
> > > There may be a legitimate question if what the bare metal FW has done
> > > is legitimate (though let's face it, there are lots of creative ACPI
> > > things around), but I don't quite see how this is a qemu question?
> > > 
> > > Unless you are taking the position that qemu should not emulate this
> > > HW?  
> > 
> > Ok. I'd failed to register that the bare metal code was doing this though
> > with hindsight I guess that is obvious. Though without more info or
> > a bare metal example being given its also possible the BIOS was doing
> > enumeration etc (like CXL does for all < 2.0 devices) and hence was
> > building SRAT with the necessary memory ranges in place - even if the
> > driver then does the hot add dance later.  
> 
> Ankit, maybe you can share some relavent ACPI dumps from the physical
> hardware and explain how this compares?
> 
> > That's dubious and likely to break at some point unless the spec
> > comprehends this use case, but meh, so are lots of other things and
> > the hardware vendor gets to pick up the pieces and deal with grumpy
> > customers.  
> 
> Yes.

With my grumpy hat on, good to actually go try and get this
clarification in the spec anyway.  We moan about people doing evil
things or spec gaps, but don't always circle back to fix them.
Obviously I'm not claiming to be good on this front either...

> 
> > I don't currently see this as a safe solution for the proposed other
> > use cases however that are virtualization only.  
> 
> So, how should that translate into a command line experiance? Sounds
> like the broad concept is general but this actual specific HW is not?

I'm not following.  I think, to enable this platform, this will need
to be vfio tied (or some new similar device). The other usecases
were things like virtio-mem where I'd just suggest leaving restricted
to only referring to existing nodes until a well defined solution is
in place to provide the memory only nodes + hotplug mix.

Without a specification clarification, we'd have to fix this in Linux
and enable dynamic NUMA node creation (or just enable a pool of extra
ones to grab from which is sort of a hacky way to do the same).

With an ACPI spec clarification agreed then I'm fine with
using this for all the cases that have come up in this thread.
Or a good argument that this is valid in under existing ACPI spec.

Jonathan


> 
> Thanks,
> Jason


