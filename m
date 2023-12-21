Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3304F81B558
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 12:54:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGHcz-0000VB-9g; Thu, 21 Dec 2023 06:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rGHcv-0000UX-9S
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:54:09 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rGHcn-00085D-Jr
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:54:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703159641; x=1734695641;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FokxupZMkJ+ad4iSfHL9pdMk49+SE2EcvGK7Aj91dGs=;
 b=JMLzPn+Ywi6+/RHJoE2cl6TY/vm657tqx9auEFxC+gKUlgDiRxf9jMfe
 fyNxCHnaaenNQr/FpKoh1yyf+4zszTha7jVq65PkaN6jmO2Zthux9iYzK
 4jDE93Nwjtoi3GwAFwNYBOBEQhQ85mz/lPAg+1DDiMZTiC13YO5FfMYW/
 6kBBk4wEZdc32x7gSnOm+hM+rlR79bHj7Hu/+0pJYG9RW6/73e83Ib4w1
 coBoVYfGA579DCoYmeHefRKS8w4oWg+M/EfQzVO0acsb/kqfuGIbA4E/l
 y9/brGxysR11vgGYMMOLC15A3qLAP9pd+ykWpi/xPdqaXWz4YIUbub0jy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="398749442"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="398749442"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 03:53:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="842610547"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="842610547"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.12.199])
 ([10.93.12.199])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 03:53:49 -0800
Message-ID: <a0289f6d-2008-48d7-95fb-492066c38461@intel.com>
Date: Thu, 21 Dec 2023 19:53:44 +0800
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
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <DS0PR11MB63737AFCA458FA78423C0BB7DC95A@DS0PR11MB6373.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 12/21/2023 6:36 PM, Wang, Wei W wrote:
> On Thursday, December 21, 2023 2:11 PM, Li, Xiaoyao wrote:
>> On 12/12/2023 9:56 PM, Wang, Wei W wrote:
>>> On Wednesday, November 15, 2023 3:14 PM, Xiaoyao Li wrote:
>>>> Introduce the helper functions to set the attributes of a range of
>>>> memory to private or shared.
>>>>
>>>> This is necessary to notify KVM the private/shared attribute of each gpa
>> range.
>>>> KVM needs the information to decide the GPA needs to be mapped at
>>>> hva- based shared memory or guest_memfd based private memory.
>>>>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> ---
>>>>    accel/kvm/kvm-all.c  | 42
>> ++++++++++++++++++++++++++++++++++++++++++
>>>>    include/sysemu/kvm.h |  3 +++
>>>>    2 files changed, 45 insertions(+)
>>>>
>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c index
>>>> 69afeb47c9c0..76e2404d54d2 100644
>>>> --- a/accel/kvm/kvm-all.c
>>>> +++ b/accel/kvm/kvm-all.c
>>>> @@ -102,6 +102,7 @@ bool kvm_has_guest_debug;  static int
>>>> kvm_sstep_flags; static bool kvm_immediate_exit;  static bool
>>>> kvm_guest_memfd_supported;
>>>> +static uint64_t kvm_supported_memory_attributes;
>>>>    static hwaddr kvm_max_slot_size = ~0;
>>>>
>>>>    static const KVMCapabilityInfo kvm_required_capabilites[] = { @@
>>>> -1305,6
>>>> +1306,44 @@ void kvm_set_max_memslot_size(hwaddr max_slot_size)
>>>>        kvm_max_slot_size = max_slot_size;
>>>>    }
>>>>
>>>> +static int kvm_set_memory_attributes(hwaddr start, hwaddr size,
>>>> +uint64_t attr) {
>>>> +    struct kvm_memory_attributes attrs;
>>>> +    int r;
>>>> +
>>>> +    attrs.attributes = attr;
>>>> +    attrs.address = start;
>>>> +    attrs.size = size;
>>>> +    attrs.flags = 0;
>>>> +
>>>> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_MEMORY_ATTRIBUTES, &attrs);
>>>> +    if (r) {
>>>> +        warn_report("%s: failed to set memory (0x%lx+%#zx) with attr
>>>> + 0x%lx
>>>> error '%s'",
>>>> +                     __func__, start, size, attr, strerror(errno));
>>>> +    }
>>>> +    return r;
>>>> +}
>>>> +
>>>> +int kvm_set_memory_attributes_private(hwaddr start, hwaddr size) {
>>>> +    if (!(kvm_supported_memory_attributes &
>>>> KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
>>>> +        error_report("KVM doesn't support PRIVATE memory attribute\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    return kvm_set_memory_attributes(start, size,
>>>> +KVM_MEMORY_ATTRIBUTE_PRIVATE); }
>>>> +
>>>> +int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size) {
>>>> +    if (!(kvm_supported_memory_attributes &
>>>> KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
>>>> +        error_report("KVM doesn't support PRIVATE memory attribute\n");
>>>> +        return -EINVAL;
>>>> +    }
>>>
>>> Duplicate code in kvm_set_memory_attributes_shared/private.
>>> Why not move the check into kvm_set_memory_attributes?
>>
>> Because it's not easy to put the check into there.
>>
>> Both setting and clearing one bit require the capability check. If moving the
>> check into kvm_set_memory_attributes(), the check of
>> KVM_MEMORY_ATTRIBUTE_PRIVATE will have to become unconditionally,
>> which is not aligned to the function name because the name is not restricted to
>> shared/private attribute only.
> 
> No need to specifically check for KVM_MEMORY_ATTRIBUTE_PRIVATE there.
> I'm suggesting below:
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 2d9a2455de..63ba74b221 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1375,6 +1375,11 @@ static int kvm_set_memory_attributes(hwaddr start, hwaddr size, uint64_t attr)
>       struct kvm_memory_attributes attrs;
>       int r;
> 
> +    if ((attr & kvm_supported_memory_attributes) != attr) {
> +        error_report("KVM doesn't support memory attr %lx\n", attr);
> +        return -EINVAL;
> +    }

In the case of setting a range of memory to shared while KVM doesn't 
support private memory. Above check doesn't work. and following IOCTL fails.

>       attrs.attributes = attr;
>       attrs.address = start;
>       attrs.size = size;
> @@ -1390,21 +1395,11 @@ static int kvm_set_memory_attributes(hwaddr start, hwaddr size, uint64_t attr)
> 
>   int kvm_set_memory_attributes_private(hwaddr start, hwaddr size)
>   {
> -    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> -        error_report("KVM doesn't support PRIVATE memory attribute\n");
> -        return -EINVAL;
> -    }
> -
>       return kvm_set_memory_attributes(start, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
>   }
> 
>   int kvm_set_memory_attributes_shared(hwaddr start, hwaddr size)
>   {
> -    if (!(kvm_supported_memory_attributes & KVM_MEMORY_ATTRIBUTE_PRIVATE)) {
> -        error_report("KVM doesn't support PRIVATE memory attribute\n");
> -        return -EINVAL;
> -    }
> -
>       return kvm_set_memory_attributes(start, size, 0);
>   }
> 
> Maybe you don't even need the kvm_set_memory_attributes_shared/private wrappers.


