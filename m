Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D6282D3DD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 06:22:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPFOo-00023Y-Oy; Mon, 15 Jan 2024 00:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan.yao@linux.intel.com>)
 id 1rPFOl-00021D-DA
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 00:20:35 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan.yao@linux.intel.com>)
 id 1rPFOi-0008T6-Jy
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 00:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705296032; x=1736832032;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Qbjdb6h6fIbGw1gsZSjaB1Wuih1qWNvn8mYbw+QrrZs=;
 b=LKzQDw3VKbfs9Y706XU9z1qlVIgbSQgWpZD3xvn6eHj97U2DighJTp4X
 rJHehnnf4Al4qve3drLGiX0IERVswU04EFMhVMcSfkxRp8sh0ftrpulmg
 SmTgfB9cI80KjwQuQeyHxsD0TiRsXgen9cCQ/c/W8zVOEnb+aETuG3/ZQ
 ucKHWUxeiBcetuQocVWFqlC8joQpyCVWlIZW6VtD0kHExOQhhvIQygD0z
 cT0gdpuf5IWvBaoKvDAuDtaoKpecWLq9DLqMtfgNYILzafCo8UZDmQ3rU
 eMrfJgyKiEBibMkPe1obj1nvlJbWox/Fjx6eR8p0DFfDMvfXm4+z75mtA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="398401301"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="398401301"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 21:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="25368932"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
 by orviesa002.jf.intel.com with ESMTP; 14 Jan 2024 21:20:24 -0800
Date: Mon, 15 Jan 2024 13:20:22 +0800
From: Yuan Yao <yuan.yao@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
Message-ID: <20240115052022.xbv6exhm4af7kai7@yy-desk-7060>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060>
 <ZaSv51/5Eokkv5Rr@intel.com>
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
User-Agent: NeoMutt/20171215
Received-SPF: none client-ip=192.55.52.120;
 envelope-from=yuan.yao@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Jan 15, 2024 at 12:34:12PM +0800, Xiaoyao Li wrote:
> On 1/15/2024 12:09 PM, Zhao Liu wrote:
> > Hi Yuan,
> >
> > On Mon, Jan 15, 2024 at 11:25:24AM +0800, Yuan Yao wrote:
> > > Date: Mon, 15 Jan 2024 11:25:24 +0800
> > > From: Yuan Yao <yuan.yao@linux.intel.com>
> > > Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
> > >
> > > On Mon, Jan 08, 2024 at 04:27:19PM +0800, Zhao Liu wrote:
> > > > From: Zhao Liu <zhao1.liu@intel.com>
> > > >
> > > > Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
> > > > erroneous smp_num_siblings on Intel Hybrid platforms") is able to
> > > > handle platforms with Module level enumerated via CPUID.1F.
> > > >
> > > > Expose the module level in CPUID[0x1F] if the machine has more than 1
> > > > modules.
> > > >
> > > > (Tested CPU topology in CPUID[0x1F] leaf with various die/cluster
> > > > configurations in "-smp".)
> > > >
> > > > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > > > Tested-by: Babu Moger <babu.moger@amd.com>
> > > > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > > > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > > > ---
> > > > Changes since v3:
> > > >   * New patch to expose module level in 0x1F.
> > > >   * Add Tested-by tag from Yongwei.
> > > > ---
> > > >   target/i386/cpu.c     | 12 +++++++++++-
> > > >   target/i386/cpu.h     |  2 ++
> > > >   target/i386/kvm/kvm.c |  2 +-
> > > >   3 files changed, 14 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > > index 294ca6b8947a..a2d39d2198b6 100644
> > > > --- a/target/i386/cpu.c
> > > > +++ b/target/i386/cpu.c
> > > > @@ -277,6 +277,8 @@ static uint32_t num_cpus_by_topo_level(X86CPUTopoInfo *topo_info,
> > > >           return 1;
> > > >       case CPU_TOPO_LEVEL_CORE:
> > > >           return topo_info->threads_per_core;
> > > > +    case CPU_TOPO_LEVEL_MODULE:
> > > > +        return topo_info->threads_per_core * topo_info->cores_per_module;
> > > >       case CPU_TOPO_LEVEL_DIE:
> > > >           return topo_info->threads_per_core * topo_info->cores_per_module *
> > > >                  topo_info->modules_per_die;
> > > > @@ -297,6 +299,8 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
> > > >           return 0;
> > > >       case CPU_TOPO_LEVEL_CORE:
> > > >           return apicid_core_offset(topo_info);
> > > > +    case CPU_TOPO_LEVEL_MODULE:
> > > > +        return apicid_module_offset(topo_info);
> > > >       case CPU_TOPO_LEVEL_DIE:
> > > >           return apicid_die_offset(topo_info);
> > > >       case CPU_TOPO_LEVEL_PACKAGE:
> > > > @@ -316,6 +320,8 @@ static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
> > > >           return CPUID_1F_ECX_TOPO_LEVEL_SMT;
> > > >       case CPU_TOPO_LEVEL_CORE:
> > > >           return CPUID_1F_ECX_TOPO_LEVEL_CORE;
> > > > +    case CPU_TOPO_LEVEL_MODULE:
> > > > +        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
> > > >       case CPU_TOPO_LEVEL_DIE:
> > > >           return CPUID_1F_ECX_TOPO_LEVEL_DIE;
> > > >       default:
> > > > @@ -347,6 +353,10 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
> > > >           if (env->nr_dies > 1) {
> > > >               set_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
> > > >           }
> > > > +
> > > > +        if (env->nr_modules > 1) {
> > > > +            set_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap);
> > > > +        }
> > > >       }
> > > >
> > > >       *ecx = count & 0xff;
> > > > @@ -6394,7 +6404,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> > > >           break;
> > > >       case 0x1F:
> > > >           /* V2 Extended Topology Enumeration Leaf */
> > > > -        if (topo_info.dies_per_pkg < 2) {
> > > > +        if (topo_info.modules_per_die < 2 && topo_info.dies_per_pkg < 2) {
> > >
> > > A question:
> > > Is the original checking necessary ?
> > > The 0x1f exists even on cpu w/o modules/dies topology on bare metal, I tried
> > > on EMR:
> > >
> > > // leaf 0
> > > 0x00000000 0x00: eax=0x00000020 ebx=0x756e6547 ecx=0x6c65746e edx=0x49656e69
> > >
> > > // leaf 0x1f
> > > 0x0000001f 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000004
> > > 0x0000001f 0x01: eax=0x00000007 ebx=0x00000080 ecx=0x00000201 edx=0x00000004
> > > 0x0000001f 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 edx=0x00000004
> > >
> > > // leaf 0xb
> > > 0x0000000b 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000004
> > > 0x0000000b 0x01: eax=0x00000007 ebx=0x00000080 ecx=0x00000201 edx=0x00000004
> > > 0x0000000b 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 edx=0x00000004
> >
> > The 0x1f is introduced for CascadeLake-AP with die level. And yes the
> > newer mahcines all have this leaf.
> >
> > >
> > > So here leads to different cpu behavior from bare metal, even in case
> > > of "-cpu host".
> > >
> > > In SDM Vol2, cpudid instruction section:
> > >
> > > " CPUID leaf 1FH is a preferred superset to leaf 0BH. Intel
> > > recommends using leaf 1FH when available rather than leaf
> > > 0BH and ensuring that any leaf 0BH algorithms are updated to
> > > support leaf 1FH. "
> > >
> > > My understanding: if 0x1f is existed (leaf 0.eax >= 0x1f)
> > > then it should have same values in lp/core level as 0xb.
>
> No. leaf 0x1f reports the same values in lp/core leve as leaf 0xb only when
> the machine supports these two levels. If the machine supports more levels,
> they will be different.
>
> e.g., the data on one Alder lake:
>
> 0x0000000b 0x00: eax=0x00000001 ebx=0x00000001 ecx=0x00000100 edx=0x00000006
> 0x0000000b 0x01: eax=0x00000007 ebx=0x00000004 ecx=0x00000201 edx=0x00000006
> 0x0000000b 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 edx=0x00000006
>
> 0x0000001f 0x00: eax=0x00000001 ebx=0x00000001 ecx=0x00000100 edx=0x00000006
> 0x0000001f 0x01: eax=0x00000003 ebx=0x00000004 ecx=0x00000201 edx=0x00000006
> 0x0000001f 0x02: eax=0x00000007 ebx=0x00000004 ecx=0x00000302 edx=0x00000006
> 0x0000001f 0x03: eax=0x00000000 ebx=0x00000000 ecx=0x00000003 edx=0x00000006

Ah, so my understanding is incorrect on this.

I tried on one raptor lake i5-i335U, which also hybrid soc but doesn't have
module level, in this case 0x1f and 0xb have same values in core/lp level.

>
>
> > Yes, I think it's time to move to default 0x1f.
>
> we don't need to do so until it's necessary.
>
> > The compatibility issue can be solved by a cpuid-0x1f option similar to
> > cpuid-0xb. I'll cook a patch after this patch series.
> >
> > Thanks,
> > Zhao
> >
> > >
> > > >               *eax = *ebx = *ecx = *edx = 0;
> > > >               break;
> > > >           }
> > > > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> > > > index eecd30bde92b..97b290e10576 100644
> > > > --- a/target/i386/cpu.h
> > > > +++ b/target/i386/cpu.h
> > > > @@ -1018,6 +1018,7 @@ enum CPUTopoLevel {
> > > >       CPU_TOPO_LEVEL_INVALID,
> > > >       CPU_TOPO_LEVEL_SMT,
> > > >       CPU_TOPO_LEVEL_CORE,
> > > > +    CPU_TOPO_LEVEL_MODULE,
> > > >       CPU_TOPO_LEVEL_DIE,
> > > >       CPU_TOPO_LEVEL_PACKAGE,
> > > >       CPU_TOPO_LEVEL_MAX,
> > > > @@ -1032,6 +1033,7 @@ enum CPUTopoLevel {
> > > >   #define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
> > > >   #define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
> > > >   #define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
> > > > +#define CPUID_1F_ECX_TOPO_LEVEL_MODULE   3
> > > >   #define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
> > > >
> > > >   /* MSR Feature Bits */
> > > > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > > > index 4ce80555b45c..e5ddb214cb36 100644
> > > > --- a/target/i386/kvm/kvm.c
> > > > +++ b/target/i386/kvm/kvm.c
> > > > @@ -1913,7 +1913,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > > >               break;
> > > >           }
> > > >           case 0x1f:
> > > > -            if (env->nr_dies < 2) {
> > > > +            if (env->nr_modules < 2 && env->nr_dies < 2) {
> > > >                   break;
> > > >               }
> > > >               /* fallthrough */
> > > > --
> > > > 2.34.1
> > > >
> > > >
> >
>

