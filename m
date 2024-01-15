Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C4E82D3A8
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 05:35:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPEg6-0001w2-Ng; Sun, 14 Jan 2024 23:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPEg4-0001vo-Lv
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:34:24 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPEg1-0002n7-P7
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 23:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705293262; x=1736829262;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0NImclDo8Qt6SacTmtN8Nm8/6vfT6w9ISUVCKwYzDBc=;
 b=ImDWCD4Wwuolbq97J9bBzbHPbIjhXZly8HD+O1Ex3vwfQXobh3m4Y1XX
 /b543T2JUPG20BJZ8CrVpSuWbXZCPR1TTRrPJCtnVoUQfn33qXU51yfZc
 Bv3TKG86x/egyKod4vRUhP3E771Vvl9a9Ylgy0SlNIhFJor45XUcKezd/
 TMPrAupyvOSgmHTQdElA6L2rGaDo28i4yygW1WeoBbffvvlf3IWB17Jxt
 C4HMVmQm9BoDbyXURVep8dDCQhbKai/wvLkpdLRWIBfVHhKzJNz2rlYZD
 UihMeNJ4xv3qCdqwT1iyK0m9zdvr0T/cBr+LRo0r0Nkc38uzBEzZOwJCi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="12892317"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="12892317"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 20:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1114824344"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="1114824344"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 20:34:14 -0800
Message-ID: <336a4816-966d-42b0-b34b-47be3e41446d@intel.com>
Date: Mon, 15 Jan 2024 12:34:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>, Yuan Yao <yuan.yao@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-9-zhao1.liu@linux.intel.com>
 <20240115032524.44q5ygb25ieut44c@yy-desk-7060> <ZaSv51/5Eokkv5Rr@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZaSv51/5Eokkv5Rr@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/15/2024 12:09 PM, Zhao Liu wrote:
> Hi Yuan,
> 
> On Mon, Jan 15, 2024 at 11:25:24AM +0800, Yuan Yao wrote:
>> Date: Mon, 15 Jan 2024 11:25:24 +0800
>> From: Yuan Yao <yuan.yao@linux.intel.com>
>> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
>>
>> On Mon, Jan 08, 2024 at 04:27:19PM +0800, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
>>> erroneous smp_num_siblings on Intel Hybrid platforms") is able to
>>> handle platforms with Module level enumerated via CPUID.1F.
>>>
>>> Expose the module level in CPUID[0x1F] if the machine has more than 1
>>> modules.
>>>
>>> (Tested CPU topology in CPUID[0x1F] leaf with various die/cluster
>>> configurations in "-smp".)
>>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> Tested-by: Babu Moger <babu.moger@amd.com>
>>> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>> Changes since v3:
>>>   * New patch to expose module level in 0x1F.
>>>   * Add Tested-by tag from Yongwei.
>>> ---
>>>   target/i386/cpu.c     | 12 +++++++++++-
>>>   target/i386/cpu.h     |  2 ++
>>>   target/i386/kvm/kvm.c |  2 +-
>>>   3 files changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 294ca6b8947a..a2d39d2198b6 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -277,6 +277,8 @@ static uint32_t num_cpus_by_topo_level(X86CPUTopoInfo *topo_info,
>>>           return 1;
>>>       case CPU_TOPO_LEVEL_CORE:
>>>           return topo_info->threads_per_core;
>>> +    case CPU_TOPO_LEVEL_MODULE:
>>> +        return topo_info->threads_per_core * topo_info->cores_per_module;
>>>       case CPU_TOPO_LEVEL_DIE:
>>>           return topo_info->threads_per_core * topo_info->cores_per_module *
>>>                  topo_info->modules_per_die;
>>> @@ -297,6 +299,8 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
>>>           return 0;
>>>       case CPU_TOPO_LEVEL_CORE:
>>>           return apicid_core_offset(topo_info);
>>> +    case CPU_TOPO_LEVEL_MODULE:
>>> +        return apicid_module_offset(topo_info);
>>>       case CPU_TOPO_LEVEL_DIE:
>>>           return apicid_die_offset(topo_info);
>>>       case CPU_TOPO_LEVEL_PACKAGE:
>>> @@ -316,6 +320,8 @@ static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
>>>           return CPUID_1F_ECX_TOPO_LEVEL_SMT;
>>>       case CPU_TOPO_LEVEL_CORE:
>>>           return CPUID_1F_ECX_TOPO_LEVEL_CORE;
>>> +    case CPU_TOPO_LEVEL_MODULE:
>>> +        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
>>>       case CPU_TOPO_LEVEL_DIE:
>>>           return CPUID_1F_ECX_TOPO_LEVEL_DIE;
>>>       default:
>>> @@ -347,6 +353,10 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>>>           if (env->nr_dies > 1) {
>>>               set_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
>>>           }
>>> +
>>> +        if (env->nr_modules > 1) {
>>> +            set_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap);
>>> +        }
>>>       }
>>>
>>>       *ecx = count & 0xff;
>>> @@ -6394,7 +6404,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>>>           break;
>>>       case 0x1F:
>>>           /* V2 Extended Topology Enumeration Leaf */
>>> -        if (topo_info.dies_per_pkg < 2) {
>>> +        if (topo_info.modules_per_die < 2 && topo_info.dies_per_pkg < 2) {
>>
>> A question:
>> Is the original checking necessary ?
>> The 0x1f exists even on cpu w/o modules/dies topology on bare metal, I tried
>> on EMR:
>>
>> // leaf 0
>> 0x00000000 0x00: eax=0x00000020 ebx=0x756e6547 ecx=0x6c65746e edx=0x49656e69
>>
>> // leaf 0x1f
>> 0x0000001f 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000004
>> 0x0000001f 0x01: eax=0x00000007 ebx=0x00000080 ecx=0x00000201 edx=0x00000004
>> 0x0000001f 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 edx=0x00000004
>>
>> // leaf 0xb
>> 0x0000000b 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000004
>> 0x0000000b 0x01: eax=0x00000007 ebx=0x00000080 ecx=0x00000201 edx=0x00000004
>> 0x0000000b 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 edx=0x00000004
> 
> The 0x1f is introduced for CascadeLake-AP with die level. And yes the
> newer mahcines all have this leaf.
> 
>>
>> So here leads to different cpu behavior from bare metal, even in case
>> of "-cpu host".
>>
>> In SDM Vol2, cpudid instruction section:
>>
>> " CPUID leaf 1FH is a preferred superset to leaf 0BH. Intel
>> recommends using leaf 1FH when available rather than leaf
>> 0BH and ensuring that any leaf 0BH algorithms are updated to
>> support leaf 1FH. "
>>
>> My understanding: if 0x1f is existed (leaf 0.eax >= 0x1f)
>> then it should have same values in lp/core level as 0xb.

No. leaf 0x1f reports the same values in lp/core leve as leaf 0xb only 
when the machine supports these two levels. If the machine supports more 
levels, they will be different.

e.g., the data on one Alder lake:

0x0000000b 0x00: eax=0x00000001 ebx=0x00000001 ecx=0x00000100 edx=0x00000006
    0x0000000b 0x01: eax=0x00000007 ebx=0x00000004 ecx=0x00000201 
edx=0x00000006
    0x0000000b 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 
edx=0x00000006

0x0000001f 0x00: eax=0x00000001 ebx=0x00000001 ecx=0x00000100 edx=0x00000006
    0x0000001f 0x01: eax=0x00000003 ebx=0x00000004 ecx=0x00000201 
edx=0x00000006
    0x0000001f 0x02: eax=0x00000007 ebx=0x00000004 ecx=0x00000302 
edx=0x00000006
    0x0000001f 0x03: eax=0x00000000 ebx=0x00000000 ecx=0x00000003 
edx=0x00000006


> Yes, I think it's time to move to default 0x1f.

we don't need to do so until it's necessary.

> The compatibility issue can be solved by a cpuid-0x1f option similar to
> cpuid-0xb. I'll cook a patch after this patch series.
> 
> Thanks,
> Zhao
> 
>>
>>>               *eax = *ebx = *ecx = *edx = 0;
>>>               break;
>>>           }
>>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>>> index eecd30bde92b..97b290e10576 100644
>>> --- a/target/i386/cpu.h
>>> +++ b/target/i386/cpu.h
>>> @@ -1018,6 +1018,7 @@ enum CPUTopoLevel {
>>>       CPU_TOPO_LEVEL_INVALID,
>>>       CPU_TOPO_LEVEL_SMT,
>>>       CPU_TOPO_LEVEL_CORE,
>>> +    CPU_TOPO_LEVEL_MODULE,
>>>       CPU_TOPO_LEVEL_DIE,
>>>       CPU_TOPO_LEVEL_PACKAGE,
>>>       CPU_TOPO_LEVEL_MAX,
>>> @@ -1032,6 +1033,7 @@ enum CPUTopoLevel {
>>>   #define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
>>>   #define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
>>>   #define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
>>> +#define CPUID_1F_ECX_TOPO_LEVEL_MODULE   3
>>>   #define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
>>>
>>>   /* MSR Feature Bits */
>>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>>> index 4ce80555b45c..e5ddb214cb36 100644
>>> --- a/target/i386/kvm/kvm.c
>>> +++ b/target/i386/kvm/kvm.c
>>> @@ -1913,7 +1913,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>               break;
>>>           }
>>>           case 0x1f:
>>> -            if (env->nr_dies < 2) {
>>> +            if (env->nr_modules < 2 && env->nr_dies < 2) {
>>>                   break;
>>>               }
>>>               /* fallthrough */
>>> --
>>> 2.34.1
>>>
>>>
> 


