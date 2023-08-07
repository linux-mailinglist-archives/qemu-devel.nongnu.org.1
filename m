Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74394772379
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 14:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSz47-0004Fp-Cx; Mon, 07 Aug 2023 08:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qSz43-0004E3-Sc
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 08:10:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qSz3x-0003DS-D6
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 08:10:21 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKFRH6PfJz6J6ct;
 Mon,  7 Aug 2023 20:06:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 13:10:10 +0100
Date: Mon, 7 Aug 2023 13:10:09 +0100
To: Gregory Price <gregory.price@memverge.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "hchkuo@avery-design.com.tw"
 <hchkuo@avery-design.com.tw>, "cbrowy@avery-design.com"
 <cbrowy@avery-design.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Adam Manzanares
 <a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>, "nifan@outlook.com"
 <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 5/9] hw/mem/cxl_type3: Add host backend and
 address space handling for DC regions
Message-ID: <20230807131009.00000fcc@Huawei.com>
In-Reply-To: <ZM0+ewZtknlOrGMl@memverge.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b@uscas1p1.samsung.com>
 <20230725183939.2741025-6-fan.ni@samsung.com>
 <20230804173623.00007707@Huawei.com>
 <ZM0+ewZtknlOrGMl@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Fri, 4 Aug 2023 14:07:55 -0400
Gregory Price <gregory.price@memverge.com> wrote:

> On Fri, Aug 04, 2023 at 05:36:23PM +0100, Jonathan Cameron wrote:
> > On Tue, 25 Jul 2023 18:39:56 +0000
> > Fan Ni <fan.ni@samsung.com> wrote:
> >   
> > > From: Fan Ni <nifan@outlook.com>
> > > 
> > > Add (file/memory backed) host backend, all the dynamic capacity regions
> > > will share a single, large enough host backend. Set up address space for
> > > DC regions to support read/write operations to dynamic capacity for DCD.
> > > 
> > > With the change, following supports are added:
> > > 1. add a new property to type3 device "nonvolatile-dc-memdev" to point to host
> > >    memory backend for dynamic capacity;
> > > 2. add namespace for dynamic capacity for read/write support;
> > > 3. create cdat entries for each dynamic capacity region;
> > > 4. fix dvsec range registers to include DC regions.
> > > 
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> > Hi Fan,
> > 
> > I'm not sure if we want to do all regions backed by one memory backend
> > or one backend each.  It will become complex when some are shared
> > (e.g. what Gregory is working on).  
> 
> I thought about this briefly when i implemented the original volatile
> support due to the potential for partitioning. We landed on, iirc, 
> 2 backends (1 for volatile, 1 for non-volatile).
> 
> The reality, though, is the driver (presently) does not have a good way
> to create more than 1 dax per memdev, and in practice with real devices
> we see that this just tends to be the case: 1 dax per device.  So unless
> that's going to change, ever having more than 1 backend will just be
> unused complexity.

I'm not sure how this will turn out.  I guess we play with what Fan has
done here and see if it ever ends up mattering!

> 
> To me, this is a good example of "maybe piling everything into the core
> ct3d is going to get ugly fast".  Maybe it would be better to do
> something similar to the CCI interface and allow for overriding the
> other functions as well.

In general I agree - but DCD is going to be a fairly standard facility
so for this one I think it'll end up either in ct3d or in the MHD / MLD
generalizations of that. For now I'm still thinking a normal type 3 device
is an MHD or MLD with a limited feature set - so easier to just turn things
off in one of those than do it as additions.   Now I'm not sure if
we end up with a MHD MLD with a lot of options in the end - probably still
as the ct3d but with a default where most stuff is turned off.

Ultimately I want that super device to be maintainable. That may mean
breaking the functionality up, but I don't yet think that means going
the simple + extend model.

> 
> just a thought.  I apologize for not engaging with the DCD patch set,
> conferences have been keeping me busier than expected.  I plan on
> putting it through the grinder this month.

No problem. Definitely some testing needed here so great to have
some more of that when you get to it.  I think most of the issues
will occur when the kernel isn't do it's normal flows. So weird
add and remove sequences linux many never use but which we should
emulate the handling for correctly.

> 
> > 
> > A few questions inline.  In particular there are subtle changes to
> > existing handling that are either bug fixes (in which case they need
> > to be sent first) or bugs / have no effect and shouldn't be in here.
> > 
> >   
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c  |  19 +++-
> > >  hw/mem/cxl_type3.c          | 203 +++++++++++++++++++++++++++++-------
> > >  include/hw/cxl/cxl_device.h |   4 +
> > >  3 files changed, 185 insertions(+), 41 deletions(-)
> > >   


