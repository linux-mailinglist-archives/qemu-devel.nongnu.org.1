Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CF776C7F4
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6ry-0003ZR-5p; Wed, 02 Aug 2023 04:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qR6rp-0003Z9-JW
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:06:01 -0400
Received: from [192.55.52.120] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qR6rn-0008Cv-T8
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690963559; x=1722499559;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=s7uxDsvdyNjvEpJX+EuA7U1P4mwvUNZMv60CP4+Om6s=;
 b=EP7T3IQMRtMRG6T6qe9NmVco7TgmnK3IgA/bO7FiEAT/1O46VpdmKxvM
 FomHzVJDOAYm026hC/JCiX8t3rSSOPzhZT5zp7m2dbPsO3+Pr+TUm531x
 D7YV9m0Oitm8BNTPFsnAhwU2fMrm2OvUoMLcaQoZY8F8yQ+xrkEcL82wf
 F+OBqjpCfIBDRdZMpmKMdcAVFvgt6afzdZup6QounHnipETE2RWhJmeJK
 tKPgBsdnS58+R/I2rSrZJSCK5YyUFNEQxBWj+ky54W6Wo+215AauoFzkY
 yM4zaKJqXeirTMkJ4zkmEAbPlb9yRxI/qC4zQ8D9qMDPM9tfPnHG6Ynwu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368411914"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; d="scan'208";a="368411914"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 01:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732289713"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; d="scan'208";a="732289713"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 01:05:53 -0700
Message-ID: <02e6d578-63c0-1453-42a1-5c315ce51529@intel.com>
Date: Wed, 2 Aug 2023 16:05:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 04/19] memory: Introduce memory_region_can_be_private()
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-5-xiaoyao.li@intel.com>
 <3a14456d-244c-ce8f-9d1c-8bcdb75de81c@suse.de>
 <835a9d0c-4e3a-d2b6-6392-a17f583f0842@suse.de>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <835a9d0c-4e3a-d2b6-6392-a17f583f0842@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.120 (failed)
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/2/2023 12:52 AM, Claudio Fontana wrote:
> On 8/1/23 18:48, Claudio Fontana wrote:
>> On 7/31/23 18:21, Xiaoyao Li wrote:
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>   include/exec/memory.h | 9 +++++++++
>>>   softmmu/memory.c      | 5 +++++
>>>   2 files changed, 14 insertions(+)
>>>
>>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>>> index 61e31c7b9874..e119d3ce1a1d 100644
>>> --- a/include/exec/memory.h
>>> +++ b/include/exec/memory.h
>>> @@ -1679,6 +1679,15 @@ static inline bool memory_region_is_romd(MemoryRegion *mr)
>>>    */
>>>   bool memory_region_is_protected(MemoryRegion *mr);
>>>   
>>> +/**
>>> + * memory_region_can_be_private: check whether a memory region can be private
>>
>> The name of the function is not particularly informative,
>>
>>> + *
>>> + * Returns %true if a memory region's ram_block has valid gmem fd assigned.
>>
>> but in your comment you describe more accurately what it does, why not make it the function name?
>>
>> bool memory_region_has_valid_gmem_fd()
> 
> 
> btw can a memory region have an invalid gmem_fd ?
> 
> If an invalid gmem_fd is just used to mark whether gmem_fd is present or not,
> 
> we could make it just:
> 
> bool memory_region_has_gmem_fd()

yes. It's a good suggestion!

I will use it in next version if no objection from others.

Thanks,
-Xiaoyao





