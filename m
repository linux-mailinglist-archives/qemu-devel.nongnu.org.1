Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3696982D461
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:01:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGxo-0003RF-8Y; Mon, 15 Jan 2024 02:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPGxa-0003Qh-U4
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:00:40 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPGxY-00035d-Kc
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705302037; x=1736838037;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5JSwSQ3J8PA9PzyALRv2cPsEPClHm1KzdzYkYownScM=;
 b=HC4qJ4SbS7gK9+ZSUDHhq0dSSZYRQhLJzlMYekUhofyb89P97kD8b/wr
 YsZtDjt6oyXZ/W9tsYJXqVuWj1cIGlGRO6lwtBFV98JhMUepIViGceaaw
 Fe2nIHzsPkYD1Ud439BanD8tLYOplMZyYYy73EpuhXjiJKeXcc1DGnvzQ
 hui7Bx3TfdlR4ipgH29Qrv/zfRgTQa7bQwMLoSG6Rq7vcxLSQoGnaDH37
 SRoNppNUwSm0qk9Y6sLho8JtSf66pYU1ExJ2xrxd2bgChiTLb9vpZO7xy
 JF567FbJR4m0qoStNG7x4o7SILwwcr28Fw9FAdJ9FypdzaY+1z8L7yhru Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13027345"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13027345"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 23:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="906974219"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="906974219"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 23:00:27 -0800
Message-ID: <4094e712-65b9-4b47-9c3f-67970ff8a86c@intel.com>
Date: Mon, 15 Jan 2024 15:00:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
 CPUID[4]
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
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
 <20240108082727.420817-15-zhao1.liu@linux.intel.com>
 <a0cd67f2-94f2-4c4b-9212-6b7344163660@intel.com> <ZaSpQuQxU5UrbIf4@intel.com>
 <5a004819-b9bf-4a2e-b8b3-ed238a66245a@intel.com> <ZaTPvmU/6gXHNDRo@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZaTPvmU/6gXHNDRo@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.8; envelope-from=xiaoyao.li@intel.com;
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

On 1/15/2024 2:25 PM, Zhao Liu wrote:
> Hi Xiaoyao,
> 
> On Mon, Jan 15, 2024 at 12:25:19PM +0800, Xiaoyao Li wrote:
>> Date: Mon, 15 Jan 2024 12:25:19 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v7 14/16] i386: Use CPUCacheInfo.share_level to encode
>>   CPUID[4]
>>
>> On 1/15/2024 11:40 AM, Zhao Liu wrote:
>>>>> +{
>>>>> +    uint32_t num_ids = 0;
>>>>> +
>>>>> +    switch (share_level) {
>>>>> +    case CPU_TOPO_LEVEL_CORE:
>>>>> +        num_ids = 1 << apicid_core_offset(topo_info);
>>>>> +        break;
>>>>> +    case CPU_TOPO_LEVEL_DIE:
>>>>> +        num_ids = 1 << apicid_die_offset(topo_info);
>>>>> +        break;
>>>>> +    case CPU_TOPO_LEVEL_PACKAGE:
>>>>> +        num_ids = 1 << apicid_pkg_offset(topo_info);
>>>>> +        break;
>>>>> +    default:
>>>>> +        /*
>>>>> +         * Currently there is no use case for SMT and MODULE, so use
>>>>> +         * assert directly to facilitate debugging.
>>>>> +         */
>>>>> +        g_assert_not_reached();
>>>>> +    }
>>>>> +
>>>>> +    return num_ids - 1;
>>>> suggest to just return num_ids, and let the caller to do the -1 work.
>>> Emm, SDM calls the whole "num_ids - 1" (CPUID.0x4.EAX[bits 14-25]) as
>>> "maximum number of addressable IDs for logical processors sharing this
>>> cache"...
>>>
>>> So if this helper just names "num_ids" as max_lp_ids_share_the_cache,
>>> I'm not sure there would be ambiguity here?
>>
>> I don't think it will.
>>
>> if this function is going to used anywhere else, people will need to keep in
>> mind to do +1 stuff to get the actual number.
>>
>> leaving the -1 trick to where CPUID value gets encoded. let's make this
>> function generic.
> 
> This helper is the complete pattern to get addressable IDs, this is to
> say, the "- 1" is also the part of this calculation.
>
> Its own meaning is self-consistent and generic enough to meet the common
> definitions of AMD and Intel.

OK. I stop bikeshedding on it.

> Thanks,
> Zhao
> 


