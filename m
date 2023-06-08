Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D19727512
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 04:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q75YN-0001sc-Gb; Wed, 07 Jun 2023 22:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q75YL-0001sR-OX
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:39:09 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q75YI-0007mH-Ti
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686191946; x=1717727946;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9gtUnsbgVWMd+11LYZg1U/mtaP4gR6aPotVSxTrNjSo=;
 b=ixfxFUAunoRvB2rFb5iYA9uYyb0szjbuUFYbqHH9CrFhW5diY4SvRv4K
 U4L2doYDb99W+qcnZvYAkORg1mB/bJiSFFkshy/XK9l739Sgb3F9/aQaO
 TpipQYuDKugstSE4JkVaanQLzbIOl3zVJdXbiXhOxebh4gdkzQ1geXxU2
 N9cs793BAkBxtysUoHh9A0hK02oSC4c05rWkiDrsDadRwB+Brec2EUkqZ
 2lMvX2rxRKYKogMX03mDYXAOAAk+dXnI6pWbSqrRbRqV5YM8vudKad4k2
 nUgmL96cZrZRCkqWmlKuHhTgPwAbuZi1dfG6hs2ZmCwNQ8jCB3fFpvwL0 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="360508941"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="360508941"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 19:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="799641795"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="799641795"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by FMSMGA003.fm.intel.com with ESMTP; 07 Jun 2023 19:38:56 -0700
Date: Thu, 8 Jun 2023 10:48:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH v2 1/3] hw/smbios: Fix smbios_smp_sockets caculation
Message-ID: <ZIFBgOW6LUKlcwQG@liuzhao-OptiPlex-7080>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-2-zhao1.liu@linux.intel.com>
 <20230607163503.75aae205@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607163503.75aae205@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=134.134.136.65; envelope-from=zhao1.liu@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jun 07, 2023 at 04:35:03PM +0200, Igor Mammedov wrote:
> Date: Wed, 7 Jun 2023 16:35:03 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v2 1/3] hw/smbios: Fix smbios_smp_sockets caculation
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)

Hi Igor,

> 
> On Thu,  1 Jun 2023 17:29:50 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Here're 2 mistakes:
> > 1. 003f230e37d7 ("machine: Tweak the order of topology members in struct
> >    CpuTopology") changes the meaning of smp.cores but doesn't fix
> >    original smp.cores uses. And because of the introduction of cluster,
> >    now smp.cores means the number of cores in one cluster. So smp.cores
> >    * smp.threads just means the cpus in a cluster not in a socket.
> 
> > 2. smp.cpus means the number of initial online cpus, not the total
> >    number of cpus. For such topology calculation, smp.max_cpus
> >    should be considered.
> that's probably not relevant to the patch.
> 

For the 2nd point, I mean the original calculation should use max_cpus
other than cpus to calculate sockets:

- smbios_smp_sockets = DIV_ROUND_UP(ms->smp.cpus,
+ smbios_smp_sockets = DIV_ROUND_UP(ms->smp.max_cpus,
                                    ms->smp.cores * ms->smp.threads);


But since we already have smp.sockets, we can use it directly.

> 
> > 
> > Since the number of sockets has already been recorded in smp structure,
> > use smp.sockets directly.
> 
> 
> I'd rephrase commit message to something like this:
> ---
> CPU topology is calculated by ..., and trying to recalculate it here
> with another rules leads to an error, such as 
> 
>  ... example follows ..
> 
> So stop reinventing the another wheel and use topo values that ... has calculated. 

Looks good for me. Thanks!

Regards,
Zhao

> 
> > 
> > Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  hw/smbios/smbios.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index d2007e70fb05..d67415d44dd8 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -1088,8 +1088,7 @@ void smbios_get_tables(MachineState *ms,
> >          smbios_build_type_2_table();
> >          smbios_build_type_3_table();
> >  
> > -        smbios_smp_sockets = DIV_ROUND_UP(ms->smp.cpus,
> > -                                          ms->smp.cores * ms->smp.threads);
> > +        smbios_smp_sockets = ms->smp.sockets;
> >          assert(smbios_smp_sockets >= 1);
> >  
> >          for (i = 0; i < smbios_smp_sockets; i++) {
> 

