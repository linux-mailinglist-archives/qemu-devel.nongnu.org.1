Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F82A727518
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 04:42:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q75ak-0002in-Fi; Wed, 07 Jun 2023 22:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q75ag-0002ib-QJ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:41:36 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1q75af-0000ER-0n
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686192093; x=1717728093;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=knX900cZSCH6q5DsX2XwH+r1iiL7HfrYbLUD2OGDtsw=;
 b=L8RqCzqrloAYJwCkWnh6764+PoU1U45Qcq4UtMevLJoePp6epjxRbSpM
 1KsXPbfMwdFLZsPB9fXVGLLujQIRu+4wM4Z8eb7w/d2v84taPBtWDHTt9
 MDdBAF2Ktlp85+SOp9kNaBrRe3Ot7wn78lyj8hfuorSmL70REB9oyCVma
 ZBqN+rpNvRpv6QKsCfYzKWC+rzqPvV3c0Hp9reqNsdHAUiyiW/U+NIH2M
 t1XR/fZNGk6ej3iFke7rdMvBmIHLCwRjy4YZSeuG33Htp9BAMF1awIhDf
 xFKR4FlvvBIuPhszsGz0GN9K3JKtcLYsbf8J1s1PBRv98uPPTF2y8ArnK A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="420739981"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="420739981"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2023 19:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687218178"
X-IronPort-AV: E=Sophos;i="6.00,225,1681196400"; d="scan'208";a="687218178"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga006.jf.intel.com with ESMTP; 07 Jun 2023 19:41:28 -0700
Date: Thu, 8 Jun 2023 10:51:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Message-ID: <ZIFCGWdkTcfwiG37@liuzhao-OptiPlex-7080>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
 <20230607164934.51805cb0@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230607164934.51805cb0@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=134.134.136.31; envelope-from=zhao1.liu@intel.com;
 helo=mga06.intel.com
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

On Wed, Jun 07, 2023 at 04:49:34PM +0200, Igor Mammedov wrote:
> Date: Wed, 7 Jun 2023 16:49:34 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
> X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
> 
> On Thu,  1 Jun 2023 17:29:51 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
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
> > 
> > Fixes: c97294ec1b9e ("SMBIOS: Build aggregate smbios tables and entry point")
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes since v1:
> >  * Rename cpus_per_socket to threads_per_socket.
> >  * Add the comment about smp.max_cpus. Thread count and core count will
> >    be calculated in 2 ways and will add a sanity check to ensure we
> >    don't miss any topology level.
> > ---
> >  hw/smbios/smbios.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index d67415d44dd8..faf82d4ae646 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -713,6 +713,7 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >  {
> >      char sock_str[128];
> >      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
> > +    unsigned threads_per_socket;
> >  
> >      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> >          tbl_len = SMBIOS_TYPE_4_LEN_V30;
> > @@ -747,17 +748,20 @@ static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> >      SMBIOS_TABLE_SET_STR(4, asset_tag_number_str, type4.asset);
> >      SMBIOS_TABLE_SET_STR(4, part_number_str, type4.part);
> >  
> > +    /* smp.max_cpus is the total number of threads for the system. */
> > +    threads_per_socket = ms->smp.max_cpus / ms->smp.sockets;
> 
> what I dislike here is introducing topo calculations with its own assumptions
> in random places.
> 
> I'd suggest to add threads_per_socket (even if it's just a helper field) into
> topo structure and calculate it with the rest on topology.
> And then use result here.

Thanks, I will try this way.

Zhao

> 
> > +
> >      t->core_count = (ms->smp.cores > 255) ? 0xFF : ms->smp.cores;
> >      t->core_enabled = t->core_count;
> >  
> > -    t->thread_count = (ms->smp.threads > 255) ? 0xFF : ms->smp.threads;
> > +    t->thread_count = (threads_per_socket > 255) ? 0xFF : threads_per_socket;
> >  
> >      t->processor_characteristics = cpu_to_le16(0x02); /* Unknown */
> >      t->processor_family2 = cpu_to_le16(0x01); /* Other */
> >  
> >      if (tbl_len == SMBIOS_TYPE_4_LEN_V30) {
> >          t->core_count2 = t->core_enabled2 = cpu_to_le16(ms->smp.cores);
> > -        t->thread_count2 = cpu_to_le16(ms->smp.threads);
> > +        t->thread_count2 = cpu_to_le16(threads_per_socket);
> >      }
> >  
> >      SMBIOS_BUILD_TABLE_POST;
> 

