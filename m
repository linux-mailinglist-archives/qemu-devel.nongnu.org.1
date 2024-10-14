Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428B599BD1C
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Oct 2024 02:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t094a-0002ve-O3; Sun, 13 Oct 2024 20:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t094V-0002vS-5x; Sun, 13 Oct 2024 20:36:27 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1t094S-0005Ut-8F; Sun, 13 Oct 2024 20:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728866184; x=1760402184;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DJrV15441yItVfFMS+GR8ovq8PdMMPCcONnm9fvbUFI=;
 b=LfgbEDRBnnHM9/lpyACNMiOdJRal7ke+GTLh5jmNjO/Q2ABtv8NoNnnp
 mhmQY0mYrIsDekS2muCIYqOf4QVO7jjwMAYCzQ6ch08cmNmcEyqgSy2YL
 YuVdUVOS4EcZ97yRiWOtjeUR9QMuvOWyALulR3FHwHr9VDpjk6xpKWWNg
 ztfXWzl8EYOBdoPlPKqOFHjea8Vl+yQ8eWICoU6MbEFzHTkKv4VNvP1ZA
 AVvu6v0nMuwwzRxbXURW6x7CAG+u45wbVvQi4VY05i0aesHDfvUrPCiND
 DM5W/wuSh3zGioIDG9IWoTK7KeSlDLiRdvuINpU8UVj30Cpr/qxxJcFIi w==;
X-CSE-ConnectionGUID: uJBCSNGKSy2azSg5cYCakQ==
X-CSE-MsgGUID: /4Xa/Q0rSCif+SgmEHO8MQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="28329017"
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; d="scan'208";a="28329017"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2024 17:36:18 -0700
X-CSE-ConnectionGUID: 1zG0qCFBQh2uqmtp6MbKJA==
X-CSE-MsgGUID: i3OrTwIjSq+p93oIaIYkfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,201,1725346800"; d="scan'208";a="108170004"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.38])
 ([10.124.224.38])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2024 17:36:16 -0700
Message-ID: <a48fcd78-d1c4-4359-bc18-d04147a93f50@intel.com>
Date: Mon, 14 Oct 2024 08:36:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: pbonzini@redhat.com, imammedo@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, zhao1.liu@intel.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, qemu-devel@nongnu.org
References: <20241009035638.59330-1-xuchuangxclwt@bytedance.com>
 <cc83fc31-7a77-4e32-a861-3c1dc8592a04@intel.com>
 <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <2f6b952d-4c21-4db5-9a8a-84a0c10feca8@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 10/12/2024 5:35 PM, Chuang Xu wrote:
> 
> On 10/12/24 下午4:21, Xiaoyao Li wrote:
>> On 10/9/2024 11:56 AM, Chuang Xu wrote:
>>> When QEMU is started with:
>>> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
>>> -smp 180,sockets=2,dies=1,cores=45,threads=2
>>>
>>> On Intel platform:
>>> CPUID.01H.EBX[23:16] is defined as "max number of addressable IDs for
>>> logical processors in the physical package".
>>>
>>> When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 
>>> 90 for
>>> CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
>>> executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
>>> CPUID.04H.EAX[31:26], which matches the expected result.
>>>
>>> As (1+CPUID.04H.EAX[31:26]) rounds up to the nearest power-of-2 integer,
>>> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
>>> integer too. Otherwise we may encounter unexpected results in guest.
>>>
>>> For example, when QEMU is started with CLI above and xtopology is 
>>> disabled,
>>> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/ 
>>> (1+CPUID.04H.EAX[31:26]) to
>>> calculate threads-per-core in detect_ht(). Then guest will get "90/ 
>>> (1+63)=1"
>>> as the result, even though threads-per-core should actually be 2.
>>
>> It's kernel's bug instead.
>>
>> In 1.5.3 "Sub ID Extraction Parameters for initial APIC ID" of "Intel 
>> 64 Architecture Processor Topology Enumeration" [1], it is
>>
>>   - SMT_Mask_Width = Log2(RoundToNearestPof2(CPUID.1:EBX[23:16])/ 
>> (CPUID.(EAX=4,ECX=0):EAX[31:26]) + 1))
>>
>> The value of CPUID.1:EBX[23:16] needs to be *rounded* to the neartest 
>> power-of-two integer instead of itself being the power-of-two.
>>
>> This also is consistency with the SDM, where the comment for bit 23-16 
>> of CPUID.1:EBX is:
>>
>>   The nearest power-of-2 integer that is not smaller than EBX[23:16] is
>>   the number of unique initial APIC IDs reserved for addressing
>>   different logical processors in a physical package.
>>
>> What I read from this is, the nearest power-of-2 integer that is not 
>> smaller than EBX[23:16] is a different thing than EBX[23:16]. i.e.,
> 
> Yes, when I read sdm, I also thought it was a kernel bug. But on my 
> 192ht spr host, the value of CPUID.1:EBX[23:16] was indeed rounded up
> 
> to the nearest power of 2 by the hardware. After communicating with 
> Intel technical support staff, we thought that perhaps the description 
> in sdm
> 
> is not so accurate, and rounding up CPUID.1:EBX[23:16] to the power of 2 
> in qemu may be more in line with the hardware behavior.

I think above justification is important. We need to justify our changes 
with the fact and correct reason.

I somehow agree to set EBX[23:16] to a value of power-of-2, because the 
1.5.3 "Sub ID Extraction Parameters for initial APIC ID" of "Intel 64 
Architecture Processor Topology Enumeration" spec says

     CPUID.1:EBX[23:16] represents the maximum number of addressable IDs
     (initial APIC ID) that can be assigned to logical processors in a
     physical package. The value may not be the same as the number of
     logical processors that are present in the hardware of a physical
     package.

It uses the word "may not".

However, the justification of the change cannot be "it leads to 
unexpected results in guest" because the guest implementation is not 
correct.

>>
>> - EBX[23:16]: Maximum number of addressable IDs for logical processors
>>   in this physical package
>>
>> - pow2ceil(EBX[23:16]): the number of unique initial APIC IDs reserved
>>   for addressing different logical processors in a physical package.
>>
>> [1] https://cdrdv2-public.intel.com/759067/intel-64-architecture- 
>> processor-topology-enumeration.pdf
>>
>>> And on AMD platform:
>>> CPUID.01H.EBX[23:16] is defined as "Logical processor count". Current
>>> result meets our expectation.
>>>
>>> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 
>>> integer
>>> only for Intel platform to solve the unexpected result.
>>>
>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>>> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
>>> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
>>> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
>>> ---
>>>   target/i386/cpu.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index ff227a8c5c..641d4577b0 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -6462,7 +6462,15 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t 
>>> index, uint32_t count,
>>>           }
>>>           *edx = env->features[FEAT_1_EDX];
>>>           if (threads_per_pkg > 1) {
>>> -            *ebx |= threads_per_pkg << 16;
>>> +            /*
>>> +             * AMD requires logical processor count, but Intel needs 
>>> maximum
>>> +             * number of addressable IDs for logical processors per 
>>> package.
>>> +             */
>>> +            if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
>>> +                *ebx |= threads_per_pkg << 16;
>>> +            } else {
>>> +                *ebx |= 1 << apicid_pkg_offset(&topo_info) << 16;
>>> +            }
>>>               *edx |= CPUID_HT;
>>>           }
>>>           if (!cpu->enable_pmu) {
>>


