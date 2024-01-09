Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60249828A0E
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 17:33:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNF1s-0002F9-9P; Tue, 09 Jan 2024 11:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNF1q-00029s-5s
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:32:38 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rNF1l-0008OH-GH
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 11:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704817953; x=1736353953;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=lq/alh0+QIDMJk8UzRpq0dUPGFZAHpyHNUvoUPsvRgQ=;
 b=HddSRRDGz4icyy0iAem9LMjzswLVEJxQVAQHL8W3Bd7F3hTTW4bZlsdd
 nY+oxyZIvxozuWH3naHdZQ6PG6K2crbEBz/SixTHtmMl7zfAAUDSDRhWG
 qTAT3+KCJ2ViJQ3xiMyv12oMFT+mLWYpvwg5F2pbXe9jMJpLOw+UPAWQQ
 KDsFlZ5izuV93HQf+u2Ush7IRjqKc+H+V2v8nSaP4RLSKVZ+nfvtcf5Gb
 HyqPUQuGp38pEOyCqN8XDjes7kaRxdHTX5r0B8B1r9Lk/KXi3Lx5lYpP1
 yrOXMrZdR2c1OnIrarET5YHLYFz/cnTT8/13YQTv8H5wiF80oEyc8LB2g Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="4996530"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="4996530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 08:32:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="872290734"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; d="scan'208";a="872290734"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 08:32:24 -0800
Message-ID: <bd2679e7-46af-4875-ba42-b4ea413ec0a1@intel.com>
Date: Wed, 10 Jan 2024 00:32:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/70] kvm: Introduce support for memory_attributes
Content-Language: en-US
To: "Wang, Wei W" <wei.w.wang@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, "Qiang, Chenyi" <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-7-xiaoyao.li@intel.com>
 <DS0PR11MB6373D69ABBF4BDF7120438ACDC8EA@DS0PR11MB6373.namprd11.prod.outlook.com>
 <cc568b63-a129-4b23-8ac8-313193ea8126@intel.com>
 <DS0PR11MB63737AFCA458FA78423C0BB7DC95A@DS0PR11MB6373.namprd11.prod.outlook.com>
 <a0289f6d-2008-48d7-95fb-492066c38461@intel.com>
 <DS0PR11MB63730289975875A5B90D078CDC95A@DS0PR11MB6373.namprd11.prod.outlook.com>
 <1bc76559-20e7-4b20-a566-9491711f7a21@intel.com>
 <DS0PR11MB637348501D03A18EE7C394C4DC6A2@DS0PR11MB6373.namprd11.prod.outlook.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <DS0PR11MB637348501D03A18EE7C394C4DC6A2@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
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

On 1/9/2024 10:53 PM, Wang, Wei W wrote:
> On Tuesday, January 9, 2024 1:47 PM, Li, Xiaoyao wrote:
>> On 12/21/2023 9:47 PM, Wang, Wei W wrote:
>>> On Thursday, December 21, 2023 7:54 PM, Li, Xiaoyao wrote:
>>>> On 12/21/2023 6:36 PM, Wang, Wei W wrote:
>>>>> No need to specifically check for KVM_MEMORY_ATTRIBUTE_PRIVATE
>> there.
>>>>> I'm suggesting below:
>>>>>
>>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>>>> 2d9a2455de..63ba74b221 100644
>>>>> --- a/accel/kvm/kvm-all.c
>>>>> +++ b/accel/kvm/kvm-all.c
>>>>> @@ -1375,6 +1375,11 @@ static int kvm_set_memory_attributes(hwaddr
>>>> start, hwaddr size, uint64_t attr)
>>>>>         struct kvm_memory_attributes attrs;
>>>>>         int r;
>>>>>
>>>>> +    if ((attr & kvm_supported_memory_attributes) != attr) {
>>>>> +        error_report("KVM doesn't support memory attr %lx\n", attr);
>>>>> +        return -EINVAL;
>>>>> +    }
>>>>
>>>> In the case of setting a range of memory to shared while KVM doesn't
>>>> support private memory. Above check doesn't work. and following IOCTL
>> fails.
>>>
>>> SHARED attribute uses the value 0, which indicates it's always supported, no?
>>> For the implementation, can you find in the KVM side where the ioctl
>>> would get failed in that case?
>>
>> I'm worrying about the future case, that KVM supports other memory attribute
>> than shared/private. For example, KVM supports RWX bits (bit 0
>> - 2) but not shared/private bit.
> 
> What's the exact issue?
> +#define KVM_MEMORY_ATTRIBUTE_READ               (1ULL << 2)
> +#define KVM_MEMORY_ATTRIBUTE_WRITE             (1ULL << 1)
> +#define KVM_MEMORY_ATTRIBUTE_EXE                  (1ULL << 0)
> 
> They are checked via
> "if ((attr & kvm_supported_memory_attributes) != attr)" shared above in
> kvm_set_memory_attributes.
> In the case you described, kvm_supported_memory_attributes will be 0x7.
> Anything unexpected?

Sorry that I thought for wrong case.

It doesn't work on the case that KVM doesn't support memory_attribute, 
e.g., an old KVM. In this case, 'kvm_supported_memory_attributes' is 0, 
and 'attr' is 0 as well.

