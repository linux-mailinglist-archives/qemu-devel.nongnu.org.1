Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83710AC4BD4
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 11:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJr3m-0002xn-IE; Tue, 27 May 2025 05:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uJr3g-0002wk-KI
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:57:21 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1uJr3c-0004gA-W5
 for qemu-devel@nongnu.org; Tue, 27 May 2025 05:57:20 -0400
X-ASG-Debug-ID: 1748339816-086e236c19172890001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx1.zhaoxin.com with ESMTP id dYBHzg7csCMdjEMV (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 27 May 2025 17:56:56 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 27 May
 2025 17:56:56 +0800
Received: from ZXSHMBX1.zhaoxin.com ([::1]) by ZXSHMBX1.zhaoxin.com
 ([fe80::2c07:394e:4919:4dc1%7]) with mapi id 15.01.2507.044; Tue, 27 May 2025
 17:56:56 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from [192.168.31.91] (10.28.66.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 27 May
 2025 17:56:09 +0800
Message-ID: <3318af5c-8a46-4901-91f2-0b2707e0a573@zhaoxin.com>
Date: Tue, 27 May 2025 17:56:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved for Intel
To: Zhao Liu <zhao1.liu@intel.com>
X-ASG-Orig-Subj: Re: [RFC 01/10] i386/cpu: Mark CPUID[0x80000005] as reserved
 for Intel
CC: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Babu Moger
 <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, Tejus GK
 <tejus.gk@nutanix.com>, Jason Zeng <jason.zeng@intel.com>, Manish Mishra
 <manish.mishra@nutanix.com>, Tao Su <tao1.su@intel.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>
References: <20250423114702.1529340-1-zhao1.liu@intel.com>
 <20250423114702.1529340-2-zhao1.liu@intel.com>
 <fa16f7a8-4917-4731-9d9f-7d4c10977168@zhaoxin.com>
 <aDWCxhsCMavTTzkE@intel.com>
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
In-Reply-To: <aDWCxhsCMavTTzkE@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.66.62]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 5/27/2025 5:56:52 PM
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1748339816
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 8529
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.62
X-Barracuda-Spam-Status: No,
 SCORE=-1.62 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA085b
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.141989
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.40 BSF_SC0_SA085b         Custom Rule SA085b
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 5/27/25 5:15 PM, Zhao Liu wrote:
> 
>> On 4/23/25 7:46 PM, Zhao Liu wrote:
>>>
>>> Per SDM, 0x80000005 leaf is reserved for Intel CPU, and its current
>>> "assert" check blocks adding new cache model for non-AMD CPUs.
>>>
>>> Therefore, check the vendor and encode this leaf as all-0 for Intel
>>> CPU. And since Zhaoxin mostly follows Intel behavior, apply the vendor
>>> check for Zhaoxin as well.
>>>
>>> Note, for !vendor_cpuid_only case, non-AMD CPU would get the wrong
>>> information, i.e., get AMD's cache model for Intel or Zhaoxin CPUs.
>>> For this case, there is no need to tweak for non-AMD CPUs, because
>>> vendor_cpuid_only has been turned on by default since PC machine v6.1.
>>>
>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>> ---
>>>    target/i386/cpu.c | 16 ++++++++++++++--
>>>    1 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 1b64ceaaba46..8fdafa8aedaf 100644
[snip]>>> +
>>>            *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
>>>                   (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>>>            *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
>>
>> I've reviewed the cache-related CPUID path and noticed an oddity: every AMD
>> vCPU model still reports identical hard-coded values for the L1 ITLB and L1
>> DTLB fields in leaf 0x8000_0005. Your patch fixes this for Intel(and
>> Zhaoxin), but all AMD models continue to receive the same constants in
>> EAX/EBX.
> 
> Yes, TLB info is hardcoded here. Previously, Babu and Eduardo cleaned up
> the cache info but didn't cover TLB [*]. I guess one reason would there
> are very few use cases related to TLB's info, and people are more
> concerned about the cache itself.
> 
> [*]: https://lore.kernel.org/qemu-devel/20180510204148.11687-2-babu.moger@amd.com/

Understood. Keeping the L1 I/D-TLB fields hard-coded for every vCPU model is 
acceptable.

>> Do you know the reason for this choice? Is the guest expected to ignore
>> those L1 TLB numbers? If so, I'll prepare a patch that adjusts only the
>> Zhaoxin defaults in leaf 0x8000_0005 like below, matching real YongFeng
>> behaviour in ecx and edx, but keep eax and ebx following AMD's behaviour.
> 
> This way is fine for me.
> 

Thanks for confirming. I'll post the YongFeng cache-info series once your 
refactor lands.

>> ## Notes
>> 1. Changes tied to "-machine smp-cache xxx" (mainly
>> x86_cpu_update_smp_cache_topo()) are not included here.
>> 2. Do you think I need Zhaoxin-specific legacy_l1d/l1i/l2/l3_cache helpers?
>> If yes, I'll add them with YongFeng sillicon topology data.
> 
> Legacy cache info stands for information on very old machines. So I
> think your yongfeng_cache_info is enough for Yongfeng CPU.
> 
>> --- patch prototype start ---
> 
> Thank you for your patch!
> 
You're welcome!

>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 7b223642ba..8a17e5ffe9 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -2726,6 +2726,66 @@ static const CPUCaches xeon_srf_cache_info = {
>>       },
>>   };
>>
>> +static const CPUCaches yongfeng_cache_info = {
[snip]>> +    .l3_cache = &(CPUCacheInfo) {
>> +        .type = UNIFIED_CACHE,
>> +        .level = 3,
>> +        .size = 8 * MiB,
>> +        .line_size = 64,
>> +        .associativity = 16,
>> +        .partitions = 1,
>> +        .sets = 8192,
>> +        .lines_per_tag = 1,
>> +        .self_init = true,
>> +        .inclusive = true,
>> +        .no_invd_sharing = true,
>> +        .complex_indexing = false,
>> +        .share_level = CPU_TOPOLOGY_LEVEL_DIE,
> 
> Just to confirm:
> 
> Is the topology of cache on your physical machines per-die instead of
> per-socket?
> 
Apologies for the confusion, the code I shared was only a prototype.
Before submitting the real patch I'll verify every value in yongfeng_cache_info 
against silicon.

For YongFeng the hierarchy is: L1/L2 shared per core, L3 shared per die (four 
cores per L3).

>> +    },
>> +};
>> +
>>   /* The following VMX features are not supported by KVM and are left out in the
>>    * CPU definitions:
>>    *
>> @@ -5928,6 +5988,15 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>                       { /* end of list */ }
>>                   }
>>               },
>> +            {
>> +                .version = 3,
>> +                .note = "wiith the correct model number and cache info",
>> +                .props = (PropValue[]) {
>> +                    { "model", "0x5b" },
>> +                    { /* end of list */ }
>> +                },
>> +                .cache_info = &yongfeng_cache_info
>> +            },
>>               { /* end of list */ }
>>           }
>>       },
> 
> Adding a cache model can be done as a separate patch. :-)
Ok, the current blob was for review only; the formal submission will be split 
into logical patches.>
>> @@ -7565,8 +7634,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,
>> uint32_t count,
>>            * vendor_cpuid_only has been turned on by default since
>>            * PC machine v6.1.
>>            */
>> -        if (cpu->vendor_cpuid_only &&
>> -            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
>> +        if (cpu->vendor_cpuid_only && IS_INTEL_CPU(env)) {
>>               *eax = *ebx = *ecx = *edx = 0;
>>               break;
>>           } else if (cpu->cache_info_passthrough) {
>> @@ -7578,8 +7646,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index,
>> uint32_t count,
>>                  (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
>>           *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
>>                  (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
>> -        *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
>> -        *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
>> +
>> +        if (IS_AMD_CPU(env)) {
>> +            *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
>> +            *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
>> +            break;
>> +        }
> 
> AMD uses 0x80000005 and doesn't use 0x4 leaf. Does Zhaoxin use 0x4?
> If not, you can fix 0x4 for Zhaoxin, too.
Zhaoxin uses 0x4 like Intel. We don't need to fix cpuid 0x4 leaf behaviour.>
>> +        /* Zhaoxin follows AMD behaviour on leaf 0x8000_0005 */
>> +        if (IS_ZHAOXIN_CPU(env)) {
>> +            *ecx = encode_cache_cpuid80000005(env->cache_info_zhaoxin.l1d_cache);
>> +            *edx = encode_cache_cpuid80000005(env->cache_info_zhaoxin.l1i_cache);
> 
> Maybe it's not necessary to add cache_info_zhaoxin? Zhaoxin could use
> legacy cache_info_cpuid4 with Intel, because it seems cache_info_zhaoxin
> is same as cache_info_cpuid4.
> 
> For this case, you can add a comment like "This is a special case where
> Zhaoxin follows AMD. Elsewhere, Zhaoxin follows Intel's behavior."
I agree! I'll drop the cache_info_zhaoxin stub and reuse cache_info_cpuid4 in 
the final patch set.>
>> +            break;
>> +        }
>> +
>> +        /* Other vendors */
>> +        *eax = *ebx = *ecx = *edx = 0;
>>           break;
>>       case 0x80000006:
>>           /* cache info (L2 cache) */
>> @@ -8638,7 +8719,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>               return;
>>           }
>>           env->cache_info_cpuid2 = env->cache_info_cpuid4 = env->cache_info_amd =
>> -            *cache_info;
>> +            env->cache_info_zhaoxin = *cache_info;
>>       } else {
>>           /* Build legacy cache information */
>>           env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
>> @@ -8655,6 +8736,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>           env->cache_info_amd.l1i_cache = &legacy_l1i_cache_amd;
>>           env->cache_info_amd.l2_cache = &legacy_l2_cache_amd;
>>           env->cache_info_amd.l3_cache = &legacy_l3_cache;
>> +
>> +        env->cache_info_zhaoxin.l1d_cache = &legacy_l1d_cache;
>> +        env->cache_info_zhaoxin.l1i_cache = &legacy_l1i_cache;
>> +        env->cache_info_zhaoxin.l2_cache = &legacy_l2_cache;
>> +        env->cache_info_zhaoxin.l3_cache = &legacy_l3_cache;
> 
> As I said above, we can apply cache_info_cpuid4 for Zhaoxin too.
Yep!> >>       }
[snip]

