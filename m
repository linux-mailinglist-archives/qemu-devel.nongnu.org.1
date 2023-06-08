Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3289272751A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 04:43:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q75c8-0003NZ-4c; Wed, 07 Jun 2023 22:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q75c6-0003NC-GO
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:43:02 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q75c4-0000Vl-NW
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686192180; x=1717728180;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=COk/J1SMfnkYhUoAt1DKGAWPRhQJRWzK8m/89XMQNwg=;
 b=NtYFC4pWTUxD0TZzQ82oV9hwNfaYvAs6VrRCsauufm/dDVvzFwJWDl2c
 UZJH8VCQISZHrVZ56gqgAHh03Ceo7FWyGctsaRjWdW874oZhTlskeOxYl
 gI2zCAYi0uSqrcnr/AKJDywkM6DPLF1V16aCf+ZTPvzEJ3MvrEIZxI3I/
 WKaQMsaD2asx1po8riq7eFLamDr0Drlpw/Fd5sN+Re/PAOrPtKXYyiYr/
 E+FQDrEaEUZAisX9C5mcVmmTDz9cC0sL3fMpTHiMUe0VEShHVHfRwu0+c
 FaHqTcv8Z7IsPefcNHcFO0cppHohIq0GvmbY12xGuk/HF4+OyzxZg3bjn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="346791062"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="346791062"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 19:42:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="739524197"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="739524197"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga008.jf.intel.com with ESMTP; 07 Jun 2023 19:42:57 -0700
Date: Thu, 8 Jun 2023 10:52:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH v2 3/3] hw/smbios: Fix core count in type4
Message-ID: <ZIFCcXmRFlk3oBJM@liuzhao-OptiPlex-7080>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-4-zhao1.liu@linux.intel.com>
 <20230607165107.76b18fe0@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607165107.76b18fe0@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=134.134.136.20; envelope-from=zhao1.liu@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jun 07, 2023 at 04:51:07PM +0200, Igor Mammedov wrote:
> Date: Wed, 7 Jun 2023 16:51:07 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v2 3/3] hw/smbios: Fix core count in type4
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Thu,  1 Jun 2023 17:29:52 +0800
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
> 
> see comment on 2/3 patch and do the same for cores.

Ok, thanks.

> 
> > 
> > [1] SMBIOS 3.0.0, section 7.5.6, Processor Information - Core Count
> > 
> > Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v1:
> >  * Calculate cores_per_socket in a different way from
> >    threads_per_socket.
> >  * Add the sanity check to ensure consistency of results between these 2
> >    ways. This can help not miss any future change of cpu topology.
> > ---
> >  hw/smbios/smbios.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index faf82d4ae646..2b46a51dfcad 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -714,6 +714,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      char sock_str[128];
> >      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> >      unsigned threads_per_socket;
> > +    unsigned cores_per_socket;
> >  
> >      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> >          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> > @@ -750,8 +751,16 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >  
> >      /* smp.max_cpus is the total number of threads for the system. */
> >      threads_per_socket = ms->smp.max_cpus / ms->smp.sockets;
> > +    cores_per_socket = ms->smp.cores * ms->smp.clusters * ms->smp.dies;
> >  
> > -    t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> > +    /*
> > +     * Currently, max_cpus = threads * cores * clusters * dies * sockets.
> > +     * threads_per_socket and cores_per_socket are calculated in 2 ways so
> > +     * that this sanity check ensures we won't miss any topology level.
> > +     */
> > +    g_assert(cores_per_socket == (threads_per_socket / ms->smp.threads));
> > +
> > +    t->core_count = (cores_per_socket > 255) ? 0xFF : cores_per_socket;
> >      t->core_enabled = t->core_count;
> >  
> >      t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
> > @@ -760,7 +769,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      t->processor_family2 = cpu_to_le16(0x01); /* Other */
> >  
> >      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> > -        t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> > +        t->core_count2 = t->core_enabled2 = cpu_to_le16(cores_per_socket);
> >          t->thread_count2 = cpu_to_le16(threads_per_socket);
> >      }
> >  
> 

