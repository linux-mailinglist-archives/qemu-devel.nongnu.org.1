Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEF9718176
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Lmu-0001Qj-0V; Wed, 31 May 2023 09:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q4Hir-0002nZ-RD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:02:25 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q4Hio-00016U-TU
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685523742; x=1717059742;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=tEdL9Y2EsTc9AAryEDj6q4lAljjolzZUR1OUsWcDwZc=;
 b=n1xhzEDzLLOY7EsttXmeC2TrD/4zn4TsdPEb7N9rZ6ALQRa/Px5qlhii
 wSgLwAz0p484gQnHLgq3IGz1kOuBO9LNQM6WuK6+xDKxlshz+q15C2NAQ
 BC6FCIBj2cdZoySJ+RLXM+gq74jqXUwbejiSk4NoLHdfkmgQwRff02U2d
 mK6rl/srNfPsdfe34dn33dWGl16rAzvbQ9UwPxPZWg5O++QLmSbqoM4Q3
 ajjlZrMjMXENk+KEcmVrgpMlHg3gSLCVdVEXGXrQnwVFv68igGIUqwlnj
 NPBU0AxMyVD5GhDPjyyfW3V6u3TbLEMnPr/mE16TkPY429AYAT4lWqLUo A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="383442335"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="383442335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 02:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="736585170"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="736585170"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga008.jf.intel.com with ESMTP; 31 May 2023 02:02:13 -0700
Date: Wed, 31 May 2023 17:11:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH 2/3] hw/smbios: Fix thread count in type4
Message-ID: <ZHcPUsbu/SzYA3Te@liuzhao-OptiPlex-7080>
References: <20230529164343.467793-1-zhao1.liu@linux.intel.com>
 <20230529164343.467793-3-zhao1.liu@linux.intel.com>
 <674ecc04-cf72-cbf1-ddbf-611c65b57299@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <674ecc04-cf72-cbf1-ddbf-611c65b57299@redhat.com>
Received-SPF: pass client-ip=192.55.52.88; envelope-from=zhao1.liu@intel.com;
 helo=mga01.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 May 2023 09:22:48 -0400
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

Hi Ani,

Thanks for your review!

On Wed, May 31, 2023 at 01:28:57PM +0530, Ani Sinha wrote:
> Date: Wed, 31 May 2023 13:28:57 +0530 (IST)
> From: Ani Sinha <anisinha@redhat.com>
> Subject: Re: [PATCH 2/3] hw/smbios: Fix thread count in type4
> 
> 
> 
> On Tue, 30 May 2023, Zhao Liu wrote:
> 
> > From: Zhao Liu <zhao1.liu@intel.com>
> >
> > From SMBIOS 3.0 specification, thread count field means:
> >
> > Thread Count is the total number of threads detected by the BIOS for
> > this processor socket. It is a processor-wide count, not a
> > thread-per-core count. [1]
> >
> > So here we should use threads per socket other than threads per core.
> >
> > [1] SMBIOS 3.0.0, section 7.5.8, Processor Information - Thread Count
> 
> I see two patches sent out around this fix. The patch
> [PATCH] hw/smbios: fix thead count field in type 4 table
> 
> looks correct to me. I NACK this patch.

The deffierence between these 2 fixes is the understanding of "smp.cores".

Strictly speaking, smp.cores only represents the number of cores in one
cluster, not in one socket, so we shouldn't use "smp.cores * smp.threads"
to calculation the number of threads in the sockets (which I also fixed the
similar thing in another patch [1]).

[1]: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg07187.html

> 
> >
> > Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >  hw/smbios/smbios.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index d67415d44dd8..f80a701cdfc1 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >  {
> >      char sock_str[128];
> >      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> > +    unsigned cpus_per_socket = ms->smp.max_cpus / ms->smp.sockets;
> >
> 
> This is confusing. Looking at machine_parse_smp_config(), this is
> essentially total number of threads per socket.

It's "the maximum number of logical processors on the machine" (I
referred the comment fo CpuTopology in include/hw/boards.h), which means
the total threads of the whole system (sockets * dies * clusters * cores
* threads).

> Maybe a better naming is threads_per_socket.

Thanks, I can send a v2 if the other two patches are OK.

> 
> Regardless, this patch is confusing.

The intent of my cleanup was to eliminate the confusion of these various
topological variables of the smp.

The third patch also tries to fix the incorrect usage of smp.cores.

Regards,
Zhao

> 
> >      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> >          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> > @@ -750,14 +751,14 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> >      t->core_enabled = t->core_count;
> >
> > -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
> > +    t->thread_count = (cpus_per_socket > 255) ? 0xFF : cpus_per_socket;
> >
> >      t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
> >      t->processor_family2 = cpu_to_le16(0x01); /* Other */
> >
> >      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> >          t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> > -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
> > +        t->thread_count2 = cpu_to_le16(cpus_per_socket);
> >      }
> >
> >      SMBIOS_BUILD_TABLE_POST;
> > --
> > 2.34.1
> >
> >
> 

