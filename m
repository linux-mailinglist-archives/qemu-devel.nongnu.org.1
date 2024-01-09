Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED2C827E81
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 06:48:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN4xg-0002M8-HX; Tue, 09 Jan 2024 00:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rN4xe-0002Ll-BL
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 00:47:38 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rN4xc-0007TR-7o
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 00:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704779256; x=1736315256;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Lr1c0pBgECUb034TWIjWoUsV0KEx7gxHpqnO/Hb2U1k=;
 b=PzsAEVXQjV9RlWvsmQdxmu83ojLOftfN2wL3sd9NSKYS91UfU6BQxKia
 klbpXd8CpKlgmPipOiw1sRvyJDgAsz1Dt5RbSHiajHEc5tpB7x6FGiicn
 rC/BKV8tk120rTir8WIew8Ekgz8bLOC/5UvRanGK5IGpyznBRaQQ9hPz6
 4f3wBcwwE487pOs2IIOydNUUfLF6wAJ8YW4W8FSvypHowXZORIlMUSA0e
 LPgjCqO5xjMbkH8PeQ6MjB2vDo7yyhYwaoLSGplbmHHqTDGSOYyXpd92+
 GFuU32vXGkWgAVP4KnS4KN1+Qq+SnekMA88/RkAFi37xhzKmL7gDmshdj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="401880782"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; d="scan'208";a="401880782"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 21:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; d="scan'208";a="23773185"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.22.149])
 ([10.93.22.149])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 21:47:28 -0800
Message-ID: <1bc76559-20e7-4b20-a566-9491711f7a21@intel.com>
Date: Tue, 9 Jan 2024 13:47:25 +0800
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
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <DS0PR11MB63730289975875A5B90D078CDC95A@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/21/2023 9:47 PM, Wang, Wei W wrote:
> On Thursday, December 21, 2023 7:54 PM, Li, Xiaoyao wrote:
>> On 12/21/2023 6:36 PM, Wang, Wei W wrote:
>>> No need to specifically check for KVM_MEMORY_ATTRIBUTE_PRIVATE there.
>>> I'm suggesting below:
>>>
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>> 2d9a2455de..63ba74b221 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -1375,6 +1375,11 @@ static int kvm_set_memory_attributes(hwaddr
>> start, hwaddr size, uint64_t attr)
>>>        struct kvm_memory_attributes attrs;
>>>        int r;
>>>
>>> +    if ((attr & kvm_supported_memory_attributes) != attr) {
>>> +        error_report("KVM doesn't support memory attr %lx\n", attr);
>>> +        return -EINVAL;
>>> +    }
>>
>> In the case of setting a range of memory to shared while KVM doesn't support
>> private memory. Above check doesn't work. and following IOCTL fails.
> 
> SHARED attribute uses the value 0, which indicates it's always supported, no?
> For the implementation, can you find in the KVM side where the ioctl
> would get failed in that case?

I'm worrying about the future case, that KVM supports other memory 
attribute than shared/private. For example, KVM supports RWX bits (bit 0 
- 2) but not shared/private bit.

This patch designs kvm_set_memory_attributes() to be common for all the 
bits (and for future bits), thus it leaves the support check to each 
caller function separately.

If you think it's unnecessary, I can change the name of 
kvm_set_memory_attributes() to kvm_set_memory_shared_private() to make 
it only for shared/private bit, then the check can be moved to it.

> static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>                                             struct kvm_memory_attributes *attrs)
> {
>          gfn_t start, end;
> 
>          /* flags is currently not used. */
>          if (attrs->flags)
>                  return -EINVAL;
>          if (attrs->attributes & ~kvm_supported_mem_attributes(kvm)) ==> 0 here
>                  return -EINVAL;
>          if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
>                  return -EINVAL;
>          if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
>                  return -EINVAL;


