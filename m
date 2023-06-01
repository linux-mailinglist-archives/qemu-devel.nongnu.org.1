Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349EE719065
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 04:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Xkf-0001UV-Qv; Wed, 31 May 2023 22:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4Xkd-0001UH-4U
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:09:19 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q4Xka-0003wB-Sa
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685585356; x=1717121356;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YYxT8VCOxF/7Z29LM5MRgP+Bp1oBTsj8rn8Bd9aI9XA=;
 b=IGCkStDSifrtj94emVlxgOSQBKJleCtIbDb43fvg8SSFsKcaxSGd2wbi
 B9KknRqvvbDu3uaPuBcW4C7Ypx9VlxcAFGikTWTwHuMjK26qPreFnmlwa
 jJEnS8aiN3sb3ZWJ1uvi7TfZgjWyGfU/wZf1YXISVgOl60NEMHXQeXrVW
 eNJ9W16FUPtP0ZsUAS/954GJV6HqJdF4khP0GVTtw9p5Kfj2A3HaXKRGy
 LWAV93MM1SG2Z7e4b1H/UeLp3ZC9ceeoIDCOOeTPpY9V1gusb8EJ8DBqJ
 XC+ROnBpEmv24VsernTVt7Q9BzWjsU+zI9HXAzmAmCfO/dwaI51UXWyC4 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="357822779"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="357822779"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 19:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="736889739"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="736889739"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga008.jf.intel.com with ESMTP; 31 May 2023 19:09:11 -0700
Date: Thu, 1 Jun 2023 10:18:44 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 3/3] hw/smbios: Fix core count in type4
Message-ID: <ZHgABCnjMx/mwKc4@liuzhao-OptiPlex-7080>
References: <20230529164343.467793-1-zhao1.liu@linux.intel.com>
 <20230529164343.467793-4-zhao1.liu@linux.intel.com>
 <20230531174648.46adda5b@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531174648.46adda5b@imammedo.users.ipa.redhat.com>
Received-SPF: none client-ip=134.134.136.24;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga09.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 31, 2023 at 05:46:48PM +0200, Igor Mammedov wrote:
> Date: Wed, 31 May 2023 17:46:48 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH 3/3] hw/smbios: Fix core count in type4
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Tue, 30 May 2023 00:43:43 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > From SMBIOS 3.0 specification, core count field means:
> > 
> > Core Count is the number of cores detected by the BIOS for this
> > processor socket. [1]
> > 
> > Before 003f230e37d7 ("machine: Tweak the order of topology members in
> > struct CpuTopology"), MachineState.smp.cores means "the number of cores
> > in one package", and it's correct to use smp.cores for core count.
> > 
> > But 003f230e37d7 changes the smp.cores' meaning to "the number of cores
> > in one die" and doesn't change the original smp.cores' use in smbios as
> > well, which makes core count in type4 go wrong.
> > 
> > Fix this issue with the correct "cores per socket" caculation.
> > 
> > [1] SMBIOS 3.0.0, section 7.5.6, Processor Information - Core Count
> > 
> > Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  hw/smbios/smbios.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index f80a701cdfc1..32e26bffa2df 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      char sock_str[128];
> >      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> >      unsigned cpus_per_socket = ms->smp.max_cpus / ms->smp.sockets;
> > +    unsigned cores_per_socket = cpus_per_socket / ms->smp.threads;
> wouldn't be
>    smp.dies * smp.clusters * smp.cores
> cleaner and more self-describing
> 
> and then you can add sanity check 
>       g_assert(cores_per_socket != (cpus_per_socket / ms->smp.threads))
> so we won't miss change to CpuTopology in the future?

Thanks! Will use this way.

Regards,
Zhao

>  
> >  
> >      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> >          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> > @@ -748,7 +749,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
> >      SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
> >  
> > -    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> > +    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
> >      t->core_enabled = t->core_count;
> >  
> >      t->thread_count = (cpus_per_socket > 255) ? 0xFF : cpus_per_socket;
> > @@ -757,7 +758,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      t->processor_family2 = cpu_to_le16(0x01); /* Other */
> >  
> >      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> > -        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> > +        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
> >          t->thread_count2 = cpu_to_le16(cpus_per_socket);
> >      }
> >  
> 

