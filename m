Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAA076FCAD
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 10:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRqbC-0000zB-DE; Fri, 04 Aug 2023 04:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRqbA-0000us-Et
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:55:52 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qRqb8-0001zl-Lw
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 04:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691139350; x=1722675350;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=y1FZNwCp5jMGomilvzxf19jxUCGIVmJh1hj+a8s+d9w=;
 b=LsGQbMdX6PyVmaf3YoB4aKkyd2brf8acjqLUTyx5LE/6L3aJr21JmCyD
 X03Ul3pHmijAtQe/wRHh2jEzQ3ZUl3eXpvpMLh5g2Q4uX++s+M3sD3+XQ
 S5vHtokRGR4s8TlIrDiaH80VoIsHem8oXPykqa9/sWlJvAXHHKk//BCqg
 InwbcSkDPPfq6hF9SKEyQLw1A0T/qrKNA+crz/xPUdobrXPiKYrT1dgLD
 IfFxVDJDSYkf6PJPoytQSKxuTm9CtBg1D2Q75W57NxFJR9eJTCCPJIQ5C
 y+6R/7fFmG70UkwOFKDtnYdH95AOZoAlTeDUjblGkFAR/V4Ih+gyo76dB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="456479963"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="456479963"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 01:55:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="765023653"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="765023653"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.28])
 by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 01:55:38 -0700
Date: Fri, 4 Aug 2023 17:06:05 +0800
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
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: Re: [PATCH v3 10/17] i386/cpu: Introduce cluster-id to X86CPU
Message-ID: <ZMy/fTiJf0fDocXv@liuzhao-OptiPlex-7080>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
 <20230801103527.397756-11-zhao1.liu@linux.intel.com>
 <b7adedcb-e3c8-98b5-6650-91a70790d183@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7adedcb-e3c8-98b5-6650-91a70790d183@amd.com>
Received-SPF: none client-ip=192.55.52.43;
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

On Wed, Aug 02, 2023 at 05:44:38PM -0500, Moger, Babu wrote:
> Date: Wed, 2 Aug 2023 17:44:38 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v3 10/17] i386/cpu: Introduce cluster-id to X86CPU
> 
> Hi Zhao,
> 
> On 8/1/23 05:35, Zhao Liu wrote:
> > From: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > 
> > We introduce cluster-id other than module-id to be consistent with
> 
> s/We introduce/Introduce/

Thanks! Will fix.

-Zhao

> 
> Thanks
> Babu
> 
> > CpuInstanceProperties.cluster-id, and this avoids the confusion
> > of parameter names when hotplugging.
> > 
> > Following the legacy smp check rules, also add the cluster_id validity
> > into x86_cpu_pre_plug().
> > 
> > Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/i386/x86.c     | 33 +++++++++++++++++++++++++--------
> >  target/i386/cpu.c |  2 ++
> >  target/i386/cpu.h |  1 +
> >  3 files changed, 28 insertions(+), 8 deletions(-)
> > 
> > diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> > index 0b460fd6074d..8154b86f95c7 100644
> > --- a/hw/i386/x86.c
> > +++ b/hw/i386/x86.c
> > @@ -328,6 +328,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >              cpu->die_id = 0;
> >          }
> >  
> > +        /*
> > +         * cluster-id was optional in QEMU 8.0 and older, so keep it optional
> > +         * if there's only one cluster per die.
> > +         */
> > +        if (cpu->cluster_id < 0 && ms->smp.clusters == 1) {
> > +            cpu->cluster_id = 0;
> > +        }
> > +
> >          if (cpu->socket_id < 0) {
> >              error_setg(errp, "CPU socket-id is not set");
> >              return;
> > @@ -344,6 +352,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >                         cpu->die_id, ms->smp.dies - 1);
> >              return;
> >          }
> > +        if (cpu->cluster_id < 0) {
> > +            error_setg(errp, "CPU cluster-id is not set");
> > +            return;
> > +        } else if (cpu->cluster_id > ms->smp.clusters - 1) {
> > +            error_setg(errp, "Invalid CPU cluster-id: %u must be in range 0:%u",
> > +                       cpu->cluster_id, ms->smp.clusters - 1);
> > +            return;
> > +        }
> >          if (cpu->core_id < 0) {
> >              error_setg(errp, "CPU core-id is not set");
> >              return;
> > @@ -363,16 +379,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >  
> >          topo_ids.pkg_id = cpu->socket_id;
> >          topo_ids.die_id = cpu->die_id;
> > +        topo_ids.module_id = cpu->cluster_id;
> >          topo_ids.core_id = cpu->core_id;
> >          topo_ids.smt_id = cpu->thread_id;
> > -
> > -        /*
> > -         * TODO: This is the temporary initialization for topo_ids.module_id to
> > -         * avoid "maybe-uninitialized" compilation errors. Will remove when
> > -         * X86CPU supports cluster_id.
> > -         */
> > -        topo_ids.module_id = 0;
> > -
> >          cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
> >      }
> >  
> > @@ -419,6 +428,14 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >      }
> >      cpu->die_id = topo_ids.die_id;
> >  
> > +    if (cpu->cluster_id != -1 && cpu->cluster_id != topo_ids.module_id) {
> > +        error_setg(errp, "property cluster-id: %u doesn't match set apic-id:"
> > +            " 0x%x (cluster-id: %u)", cpu->cluster_id, cpu->apic_id,
> > +            topo_ids.module_id);
> > +        return;
> > +    }
> > +    cpu->cluster_id = topo_ids.module_id;
> > +
> >      if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
> >          error_setg(errp, "property core-id: %u doesn't match set apic-id:"
> >              " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index d6969813ee02..ffa282219078 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7806,12 +7806,14 @@ static Property x86_cpu_properties[] = {
> >      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, 0),
> >      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, 0),
> >      DEFINE_PROP_INT32("core-id", X86CPU, core_id, 0),
> > +    DEFINE_PROP_INT32("cluster-id", X86CPU, cluster_id, 0),
> >      DEFINE_PROP_INT32("die-id", X86CPU, die_id, 0),
> >      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, 0),
> >  #else
> >      DEFINE_PROP_UINT32("apic-id", X86CPU, apic_id, UNASSIGNED_APIC_ID),
> >      DEFINE_PROP_INT32("thread-id", X86CPU, thread_id, -1),
> >      DEFINE_PROP_INT32("core-id", X86CPU, core_id, -1),
> > +    DEFINE_PROP_INT32("cluster-id", X86CPU, cluster_id, -1),
> >      DEFINE_PROP_INT32("die-id", X86CPU, die_id, -1),
> >      DEFINE_PROP_INT32("socket-id", X86CPU, socket_id, -1),
> >  #endif
> > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > index 5e97d0b76574..d9577938ae04 100644
> > --- a/target/i386/cpu.h
> > +++ b/target/i386/cpu.h
> > @@ -2034,6 +2034,7 @@ struct ArchCPU {
> >      int32_t node_id; /* NUMA node this CPU belongs to */
> >      int32_t socket_id;
> >      int32_t die_id;
> > +    int32_t cluster_id;
> >      int32_t core_id;
> >      int32_t thread_id;
> >  
> 
> -- 
> Thanks
> Babu Moger

