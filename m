Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B727927BA4
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 19:10:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPPy6-000368-FA; Thu, 04 Jul 2024 13:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPPy0-00035S-A6
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:09:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sPPxy-0007Nx-Hx
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 13:09:56 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFNPp2RmKz6K9Kr;
 Fri,  5 Jul 2024 01:07:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C0523140C72;
 Fri,  5 Jul 2024 01:09:52 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 18:09:52 +0100
Date: Thu, 4 Jul 2024 18:09:51 +0100
To: "Huang, Ying" <ying.huang@intel.com>
CC: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>, Gregory Price
 <gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>, 
 <tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
 <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Jiang
 <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
Message-ID: <20240704180951.00005ca6@Huawei.com>
In-Reply-To: <87a5iykgdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240628060925.303309-1-horen.chuang@linux.dev>
 <20240628060925.303309-2-horen.chuang@linux.dev>
 <20240702142535.00003dc0@Huawei.com>
 <87a5iykgdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
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

On Wed, 03 Jul 2024 16:51:40 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> 
> > On Fri, 28 Jun 2024 06:09:23 +0000
> > "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:  
> 
> [snip]
> 
> >> @@ -875,8 +886,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
> >>  
> >>  static int __init memory_tier_init(void)
> >>  {
> >> -	int ret, node;
> >> -	struct memory_tier *memtier;
> >> +	int ret;
> >>  
> >>  	ret = subsys_virtual_register(&memory_tier_subsys, NULL);
> >>  	if (ret)
> >> @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
> >>  				GFP_KERNEL);
> >>  	WARN_ON(!node_demotion);
> >>  #endif
> >> -	mutex_lock(&memory_tier_lock);
> >> +
> >> +	guard(mutex)(&memory_tier_lock);  
> >
> > If this was safe to do without the rest of the change (I think so)
> > then better to pull that out as a trivial precursor so less noise
> > in here.
> >  
> >>  	/*
> >>  	 * For now we can have 4 faster memory tiers with smaller adistance
> >>  	 * than default DRAM tier.
> >> @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
> >>  	if (IS_ERR(default_dram_type))
> >>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
> >>  
> >> -	/*
> >> -	 * Look at all the existing N_MEMORY nodes and add them to
> >> -	 * default memory tier or to a tier if we already have memory
> >> -	 * types assigned.
> >> -	 */
> >> -	for_each_node_state(node, N_MEMORY) {
> >> -		if (!node_state(node, N_CPU))
> >> -			/*
> >> -			 * Defer memory tier initialization on
> >> -			 * CPUless numa nodes. These will be initialized
> >> -			 * after firmware and devices are initialized.
> >> -			 */
> >> -			continue;
> >> -
> >> -		memtier = set_node_memory_tier(node);
> >> -		if (IS_ERR(memtier))
> >> -			/*
> >> -			 * Continue with memtiers we are able to setup
> >> -			 */
> >> -			break;
> >> -	}
> >> -	establish_demotion_targets();
> >> -	mutex_unlock(&memory_tier_lock);
> >> +	/* Record nodes with memory and CPU to set default DRAM performance. */
> >> +	nodes_and(default_dram_nodes, node_states[N_MEMORY],
> >> +		  node_states[N_CPU]);  
> >
> > There are systems where (for various esoteric reasons, such as describing an
> > association with some other memory that isn't DRAM where the granularity
> > doesn't match) the CPU nodes contain no DRAM but rather it's one node away.
> > Handling that can be a job for another day though.
> >
> > Why does this need to be computed here?  Why not do it in
> > hmat_set_default_dram_perf? Doesn't seem to be used anywhere else.  
> 
> IMO, which node is default dram node is a general concept instead of
> HMAT specific.  So, I think that it's better to decide that in the
> general code (memory-tiers.c).

That makes sense given I'd imagine this will spread to other firmware
types in time.

Thanks,

Jonathan

> 
> >>  
> >>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
> >>  	return 0;  
> 
> --
> Best Regards,
> Huang, Ying
> 


