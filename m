Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7571E76FB95
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:03:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRpld-0002HX-Lw; Fri, 04 Aug 2023 04:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRplR-0001yN-Me
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:02:25 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRplP-0000SY-8N
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691136143; x=1722672143;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=e8Dfm98iMIUR7csajBhgBMGNYmUnOuIK0dINVDmvkAE=;
 b=Remd34dz60qjOusf2g5ptZBb1QbGRLtqaowq7XWyWwTrd3l+ikMeoS3V
 NMAW87K5DgIbN26TO4n9zE65I32dXxU1JCr1mE1TOaHg9UnF0rdXERuxb
 EdBig+d094M6FuTNYG1Qs8bHqOX0wCxPPfXjQHBATL1sdjWL3Zs5P7Woy
 XmXgvm8DA9jZR/wmVP+Eyj8ZDtt5GYOc+jt17bNXB7tp1RilFGloY9BfM
 Ue67BlZhsZrNF1b3c3UslJdi0X2z+gWFNW73Cy24jKS52VPM7+PPxQ3Sn
 ioOqZheNjhkv2Lu1+tdr62H7mip74mbZHaLRpwhTmD11uZckNzzoFINpv Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="350400355"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="350400355"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 01:02:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="976453383"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="976453383"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by fmsmga006.fm.intel.com with ESMTP; 04 Aug 2023 01:02:16 -0700
Date: Fri, 4 Aug 2023 16:12:44 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 01/17] i386: Fix comment style in topology.h
Message-ID: <ZMyy/E+nWxeDjYOl@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-2-zhao1.liu@linux.intel.com>
 <40340464-84fe-3512-0cc2-eb1d2622e353@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40340464-84fe-3512-0cc2-eb1d2622e353@amd.com>
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi Babu,

On Tue, Aug 01, 2023 at 06:13:55PM -0500, Moger, Babu wrote:
> Date: Tue, 1 Aug 2023 18:13:55 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 01/17] i386: Fix comment style in topology.h
> 
> Hi Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > For function comments in this file, keep the comment style consistent
> > with other places.
> 
> s/with other places./with other files in the directory./

OK, thanks!

-Zhao

> 
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org
> > Reviewed-by: Yanan Wang <wangyanan55@huawei.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/hw/i386/topology.h | 33 +++++++++++++++++----------------
> >  1 file changed, 17 insertions(+), 16 deletions(-)
> > 
> > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > index 81573f6cfde0..5a19679f618b 100644
> > --- a/include/hw/i386/topology.h
> > +++ b/include/hw/i386/topology.h
> > @@ -24,7 +24,8 @@
> >  #ifndef HW_I386_TOPOLOGY_H
> >  #define HW_I386_TOPOLOGY_H
> >  
> > -/* This file implements the APIC-ID-based CPU topology enumeration logic,
> > +/*
> > + * This file implements the APIC-ID-based CPU topology enumeration logic,
> >   * documented at the following document:
> >   *   Intel® 64 Architecture Processor Topology Enumeration
> >   *   http://software.intel.com/en-us/articles/intel-64-architecture-processor-topology-enumeration/
> > @@ -41,7 +42,8 @@
> >  
> >  #include "qemu/bitops.h"
> >  
> > -/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
> > +/*
> > + * APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
> >   */
> >  typedef uint32_t apic_id_t;
> >  
> > @@ -58,8 +60,7 @@ typedef struct X86CPUTopoInfo {
> >      unsigned threads_per_core;
> >  } X86CPUTopoInfo;
> >  
> > -/* Return the bit width needed for 'count' IDs
> > - */
> > +/* Return the bit width needed for 'count' IDs */
> >  static unsigned apicid_bitwidth_for_count(unsigned count)
> >  {
> >      g_assert(count >= 1);
> > @@ -67,15 +68,13 @@ static unsigned apicid_bitwidth_for_count(unsigned count)
> >      return count ? 32 - clz32(count) : 0;
> >  }
> >  
> > -/* Bit width of the SMT_ID (thread ID) field on the APIC ID
> > - */
> > +/* Bit width of the SMT_ID (thread ID) field on the APIC ID */
> >  static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
> >  {
> >      return apicid_bitwidth_for_count(topo_info->threads_per_core);
> >  }
> >  
> > -/* Bit width of the Core_ID field
> > - */
> > +/* Bit width of the Core_ID field */
> >  static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
> >  {
> >      return apicid_bitwidth_for_count(topo_info->cores_per_die);
> > @@ -87,8 +86,7 @@ static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
> >      return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
> >  }
> >  
> > -/* Bit offset of the Core_ID field
> > - */
> > +/* Bit offset of the Core_ID field */
> >  static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
> >  {
> >      return apicid_smt_width(topo_info);
> > @@ -100,14 +98,14 @@ static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
> >      return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
> >  }
> >  
> > -/* Bit offset of the Pkg_ID (socket ID) field
> > - */
> > +/* Bit offset of the Pkg_ID (socket ID) field */
> >  static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
> >  {
> >      return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
> >  }
> >  
> > -/* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> > +/*
> > + * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> >   *
> >   * The caller must make sure core_id < nr_cores and smt_id < nr_threads.
> >   */
> > @@ -120,7 +118,8 @@ static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
> >             topo_ids->smt_id;
> >  }
> >  
> > -/* Calculate thread/core/package IDs for a specific topology,
> > +/*
> > + * Calculate thread/core/package IDs for a specific topology,
> >   * based on (contiguous) CPU index
> >   */
> >  static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
> > @@ -137,7 +136,8 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
> >      topo_ids->smt_id = cpu_index % nr_threads;
> >  }
> >  
> > -/* Calculate thread/core/package IDs for a specific topology,
> > +/*
> > + * Calculate thread/core/package IDs for a specific topology,
> >   * based on APIC ID
> >   */
> >  static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
> > @@ -155,7 +155,8 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
> >      topo_ids->pkg_id = apicid >> apicid_pkg_offset(topo_info);
> >  }
> >  
> > -/* Make APIC ID for the CPU 'cpu_index'
> > +/*
> > + * Make APIC ID for the CPU 'cpu_index'
> >   *
> >   * 'cpu_index' is a sequential, contiguous ID for the CPU.
> >   */
> 
> -- 
> Thanks
> Babu Moger

