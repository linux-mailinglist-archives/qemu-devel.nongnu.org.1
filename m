Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF1F82D382
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:51:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPE0O-0007FF-ES; Sun, 14 Jan 2024 22:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPE0L-0007En-My
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:51:17 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPE0J-0001DG-ER
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705290675; x=1736826675;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hqkWkscx7XpxVuFcGpTfTCVLvZmhCxQ8KR63EtrKzD0=;
 b=HzbZf906aUgo6d6meO3l0w9aQTmNZHbODiifWZPnaxk6vTAOgFuMo0C0
 QXzpBrdnWIKWm4xehCzIR75o1DYusL5HCOpvd1H13DjwD98c9YvyUf9DC
 sIYd1fLbxWCzd9OPgb2QBQ8Tb/WX4YMvbulmF+F8REtLa13H+Z6/sicM4
 bz9lAUg72FaPfKIi3cf0Sydl4+3KY2qiw1QKvfaYeu4iJF9VB54Pzk1Eb
 jfY7MISjjLYjMEoQ+sJxQ2lkk2VduHdkNOrlfaefPCYGnuYWpcALfegv7
 rl7YHVV+ABPqsJ7vhUv7RsXgt+YzsagXfLZNe0XZq4ZgG7/IgEylXP6Xy w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6622713"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6622713"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 19:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="786964036"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; d="scan'208";a="786964036"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 19:51:07 -0800
Message-ID: <93492d11-ca58-43b1-afeb-56fe7da4c45d@intel.com>
Date: Mon, 15 Jan 2024 11:51:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/16] i386/cpu: Use APIC ID offset to encode cache
 topo in CPUID[4]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Robert Hoo <robert.hu@linux.intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-3-zhao1.liu@linux.intel.com>
 <f5202ebd-6bc8-44b1-b22b-f3a033e0f283@intel.com> <ZZ+qGfykupOEFPA2@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZZ+qGfykupOEFPA2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
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

On 1/11/2024 4:43 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Wed, Jan 10, 2024 at 05:31:28PM +0800, Xiaoyao Li wrote:
>> Date: Wed, 10 Jan 2024 17:31:28 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v7 02/16] i386/cpu: Use APIC ID offset to encode cache
>>   topo in CPUID[4]
>>
>> On 1/8/2024 4:27 PM, Zhao Liu wrote:
>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>
>>> Refer to the fixes of cache_info_passthrough ([1], [2]) and SDM, the
>>> CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26] should use the
>>> nearest power-of-2 integer.
>>>
>>> The nearest power-of-2 integer can be calculated by pow2ceil() or by
>>> using APIC ID offset (like L3 topology using 1 << die_offset [3]).
>>>
>>> But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
>>> are associated with APIC ID. For example, in linux kernel, the field
>>> "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID.
>>
>> And for
>>> another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
>>> matched with actual core numbers and it's calculated by:
>>> "(1 << (pkg_offset - core_offset)) - 1".
>>
>> could you elaborate it more? what is the value of actual core numbers on
>> Alder lake P? and what is the pkg_offset and core_offset?
> 
> For example, the following's the CPUID dump of an ADL-S machine:
> 
> CPUID.04H:
> 
> 0x00000004 0x00: eax=0xfc004121 ebx=0x01c0003f ecx=0x0000003f edx=0x00000000
> 0x00000004 0x01: eax=0xfc004122 ebx=0x01c0003f ecx=0x0000007f edx=0x00000000
> 0x00000004 0x02: eax=0xfc01c143 ebx=0x03c0003f ecx=0x000007ff edx=0x00000000
> 0x00000004 0x03: eax=0xfc1fc163 ebx=0x0240003f ecx=0x00009fff edx=0x00000004
> 0x00000004 0x04: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
> 
> 
> CPUID.1FH:
> 
> 0x0000001f 0x00: eax=0x00000001 ebx=0x00000001 ecx=0x00000100 edx=0x0000004c
> 0x0000001f 0x01: eax=0x00000007 ebx=0x00000014 ecx=0x00000201 edx=0x0000004c
> 0x0000001f 0x02: eax=0x00000000 ebx=0x00000000 ecx=0x00000002 edx=0x0000004c
> 
> The CPUID.04H:EAX[bits 31:26] is 63.
>  From CPUID.1FH.00H:EAX[bits 04:00], the core_offset is 1, and from
> CPUID.1FH.01H:EAX[bits 04:00], the pkg_offset is 7.
> 
> Thus we can verify that the above equation as:
> 
> 1 << (0x7 - 0x1) - 1 = 63.
> 
> "Maximum number of addressable IDs" refers to the maximum number of IDs
> that can be enumerated in the APIC ID's topology layout, which does not
> necessarily correspond to the actual number of topology domains.
> 

you still don't tell how many core numbers on Alder lake P.

I guess the number is far smaller than 64, which is not matched with (63 
+ 1)


