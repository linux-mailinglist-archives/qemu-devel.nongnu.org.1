Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0482D47A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 08:17:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPHDZ-0003wd-SS; Mon, 15 Jan 2024 02:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPHDX-0003vD-EQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:17:07 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rPHDK-0006IL-QK
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 02:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705303015; x=1736839015;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=frylx2i+xOJ2HS9ZVf2GocaKMEjHY2pnDO+LcA2z5qA=;
 b=Hxm4N13KXSWMz9ySOjJJJNBF7zgH/9LLNYJzXe9emo98kypIEsCa9bAr
 GTJLjsALXANoc/nogxQ41zJatkiroFy04UdUS9Fk6pahYduXtPRRsTUfr
 QZjFR/sG4CsDrrf1gndzV0dg8yZlZ8TnGgSJBoT4OCpA9buSz4+frMs16
 nPEaBJOhXMGbcfXBofwpqoR/vs2MeUPxM2W5bdtgwWiQ7/XekFlHPXrRQ
 aCaAW64ABhYyCvJTzuI7wuxzwa+xXqThgk5/IXazGCUUDblpVTrbU4iOR
 1+5atrEkJzzVquiIu0as7b1Ufx3Y1HJfmcr+awr60G0biiG+nyoqfvxZ/ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="21028329"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="21028329"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 23:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="783721538"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="783721538"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2024 23:16:47 -0800
Message-ID: <00873298-06b5-4286-9c92-54376ed2d09d@intel.com>
Date: Mon, 15 Jan 2024 15:16:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Yuan Yao <yuan.yao@linux.intel.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
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
 <336a4816-966d-42b0-b34b-47be3e41446d@intel.com> <ZaTM5njcfIgfsjqt@intel.com>
 <78168ef8-2354-483a-aa3b-9e184de65a72@intel.com> <ZaTSM8IAzQ1onX05@intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZaTSM8IAzQ1onX05@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
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

On 1/15/2024 2:35 PM, Zhao Liu wrote:
> On Mon, Jan 15, 2024 at 02:11:17PM +0800, Xiaoyao Li wrote:
>> Date: Mon, 15 Jan 2024 14:11:17 +0800
>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
>>
>> On 1/15/2024 2:12 PM, Zhao Liu wrote:
>>> Hi Xiaoyao,
>>>
>>> On Mon, Jan 15, 2024 at 12:34:12PM +0800, Xiaoyao Li wrote:
>>>> Date: Mon, 15 Jan 2024 12:34:12 +0800
>>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Subject: Re: [PATCH v7 08/16] i386: Expose module level in CPUID[0x1F]
>>>>
>>>>> Yes, I think it's time to move to default 0x1f.
>>>>
>>>> we don't need to do so until it's necessary.
>>>
>>> Recent and future machines all support 0x1f, and at least SDM has
>>> emphasized the preferred use of 0x1f.
>>
>> The preference is the guideline for software e.g., OS. QEMU doesn't need to
>> emulate cpuid leaf 0x1f to guest if there is only smt and core level.
> 
> Please, QEMU is emulating hardware not writing software.

what I want to conveyed was that, SDM is teaching software how to probe 
the cpu topology, not suggesting VMM how to advertise cpu topology to 
guest.


> Is there any
> reason why we shouldn't emulate new and generic hardware behaviors and
> stick with the old ones?

I didn't say we shouldn't, but we don't need to do it if it's unnecessary.

if cpuid 0x1f is advertised to guest by default, it will also introduce 
the inconsistence. Old product doesn't have cpuid 0x1f, but using QEMU 
to emualte an old product, it has.

sure we can have code to fix it, that only expose 0x1f to new enough cpu 
model. But it just make thing complicated.

>> because in this case, they are exactly the same in leaf 0xb and 0x1f. we don't
>> need to bother advertising the duplicate data.
> 
> You can't "define" the same 0x0b and 0x1f as duplicates. SDM doesn't
> have such the definition.

for QEMU, they are duplicate data that need to be maintained and need to 
be passed to KVM by KVM_SET_CPUID. For guest, it's also unnecessary, 
because it doesn't provide any additional information with cpuid leaf 1f.

SDM keeps cpuid 0xb is for backwards compatibility.

> Regards,
> Zhao
> 


