Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A388785E00
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 19:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYrCf-0008ML-Gw; Wed, 23 Aug 2023 12:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qYrCc-0008Lw-07
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 12:59:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qYrCY-0008Ht-Rs
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 12:59:29 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RWC4k1FDMz67XMQ;
 Thu, 24 Aug 2023 00:55:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 17:59:11 +0100
Date: Wed, 23 Aug 2023 17:59:10 +0100
To: Shreyas Shah <shreyas.shah@elastics.cloud>
CC: Maverickk 78 <maverickk1778@gmail.com>, Jonathan Cameron via
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>
Subject: Re: CXL volatile memory is not listed
Message-ID: <20230823175910.00001b81@Huawei.com>
In-Reply-To: <IA1PR12MB6236E18350FFCB8916E32E86E81BA@IA1PR12MB6236.namprd12.prod.outlook.com>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
 <20230810113512.00000516@Huawei.com>
 <CALfBBTud4Y7qxKB8nkZ5Lo5sQs-7-F9Rkso+iQGvLO07VyRcDA@mail.gmail.com>
 <20230811145458.000029c7@Huawei.com>
 <CALfBBTsMLP8_eTfmFt5mB+ywF1D0WTR7m=PBqUVzhhvcwC+zYA@mail.gmail.com>
 <IA1PR12MB6236E18350FFCB8916E32E86E81BA@IA1PR12MB6236.namprd12.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 18 Aug 2023 11:30:55 +0000
Shreyas Shah <shreyas.shah@elastics.cloud> wrote:

> Once the cxl memory is online, how does Operating system know whether to malloc in the cxl memory or socket attached DDR memory?

If you've brought the memory up as 'normal memory' via kmem rather than the other dax options
then it'll be a separate NUMA node.  Hence you can control allocations using same tools
used on multiple numa node systems.

Jonathan

> 
> 
> 
> [https://static1.squarespace.com/static/60dbbd6d597c966b91a3b27b/t/6104415e6177af1589fb05e4/1627668830393/elastics-cloud-logo-120.png]<https://www.elastics.cloud/>
> Shreyas Shah
> Founder, CTO and Chief Scientist, Elastics.cloud, Inc.
> 1730 North First Street, 5th Floor, San Jose, CA 95112
> t: 408 476 3100<tel:408%20476%203100> | e: email: shreyas.shah@elastics.cloud
> 
> ________________________________
> From: Maverickk 78 <maverickk1778@gmail.com>
> Sent: Thursday, August 17, 2023 10:18 PM
> To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jonathan Cameron via <qemu-devel@nongnu.org>; linux-cxl@vger.kernel.org <linux-cxl@vger.kernel.org>
> Subject: Re: CXL volatile memory is not listed
> 
> Hi Jonathan,
> 
> The use case of CXL switch will always need some sort of management
> agent + FM configuring the available CXL memory connected.
> 
> In most cases it would be bmc controller configuring MLD/MHD's to
> host, and in very rare scenarios it may be one of the host interacting
> with FM firmware inside the switch which would do the trick.
> 
> Another use case is static hardcoding between CXL memory & host in
> built in cxl switch
> 
> There is no scenario where one of the host BIOS can push the select
> CXL memory to itself.
> 
> 
> Is my understanding correct?
> 
> 
> 
> On Fri, 11 Aug 2023 at 19:25, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Fri, 11 Aug 2023 08:04:26 +0530
> > Maverickk 78 <maverickk1778@gmail.com> wrote:
> >  
> > > Jonathan,
> > >  
> > > > More generally for the flow that would bring the memory up as system ram
> > > > you would typically need the bios to have done the CXL enumeration or
> > > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > > be fully automated, because there are policy decisions to make on things like
> > > > interleaving.  
> > >
> > > BIOS CXL enumeration? is CEDT not enough? or BIOS further needs to
> > > create an entry
> > > in the e820 table?  
> > On intel platforms 'maybe' :)  I know how it works on those that just
> > use the nice standard EFI tables - less familiar with the e820 stuff :)
> >
> > CEDT says where to find the the various bits of system related CXL stuff.
> > Nothing in there on the configuration that should be used such as interleaving
> > as that depends on what the administrator wants. Or on what the BIOS has
> > decided the users should have.
> >  
> > >  
> > > >
> > > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > > etc in the kernel.
> > > >  
> > > Manual works with "cxl create regiton"  :)  
> > Great.
> >
> > Jonathan
> >  
> > >
> > > On Thu, 10 Aug 2023 at 16:05, Jonathan Cameron
> > > <Jonathan.Cameron@huawei.com> wrote:  
> > > >
> > > > On Wed, 9 Aug 2023 04:21:47 +0530
> > > > Maverickk 78 <maverickk1778@gmail.com> wrote:
> > > >  
> > > > > Hello,
> > > > >
> > > > > I am running qemu-system-x86_64
> > > > >
> > > > > qemu-system-x86_64 --version
> > > > > QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
> > > > >  
> > > > +Cc linux-cxl as the answer is more todo with linux than qemu.
> > > >  
> > > > > qemu-system-x86_64 \
> > > > > -m 2G,slots=4,maxmem=4G \
> > > > > -smp 4 \
> > > > > -machine type=q35,accel=kvm,cxl=on \
> > > > > -enable-kvm \
> > > > > -nographic \
> > > > > -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> > > > > -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> > > > > -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> > > > > -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> > > > > -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G  
> > > >
> > > > There are some problems upstream at the moment (probably not cxl related but
> > > > I'm digging). So today I can't boot an x86 machine. (goody)
> > > >
> > > >
> > > > More generally for the flow that would bring the memory up as system ram
> > > > you would typically need the bios to have done the CXL enumeration or
> > > > a bunch of scripts in the kernel to have done it.  In general it can't
> > > > be fully automated, because there are policy decisions to make on things like
> > > > interleaving.
> > > >
> > > > I'm not aware of any open source BIOSs that do it yet.  So you have
> > > > to rely on the same kernel paths as for persistent memory - manual configuration
> > > > etc in the kernel.
> > > >
> > > > There is support in ndctl for those enabling flows, so I'd look there
> > > > for more information
> > > >
> > > > Jonathan
> > > >
> > > >  
> > > > >
> > > > >
> > > > > I was expecting the CXL memory to be listed in "System Ram", the lsmem
> > > > > shows only 2G memory which is System RAM, it's not listing the CXL
> > > > > memory.
> > > > >
> > > > > Do I need to pass any particular parameter in the kernel command line?
> > > > >
> > > > > Is there any documentation available? I followed the inputs provided in
> > > > >
> > > > > https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> > > > >
> > > > > Is there any documentation/blog listed?  
> > > >  
> >  
> 


