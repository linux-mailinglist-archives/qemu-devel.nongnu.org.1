Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BE0874D5B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Mar 2024 12:25:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riBrT-0003uh-Ja; Thu, 07 Mar 2024 06:24:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riBrQ-0003uP-VQ
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:24:29 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1riBrN-00084k-47
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709810665; x=1741346665;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=eKQJMp2KjcRGiZeV5u89MH7FjELomniIJ5L02BqxnT8=;
 b=OcUWZuT2D98e8sCPB26uF6/tp7J+HQ10O2xeb/O4nBpWu2UvMIrmHxvP
 Y0HWEIkvq74NyAgSwRrhCciNFQaIri4DOYNAqoCeMCujRCThKOaGtRoPC
 tQi0B7u0jIwGzliZKTqoAUEfkmZNIAWnms9DvR2cEC1zrGCAUc3PrEoFo
 klPfX9FrBgoL3VunJoADUe6V842zRxot8OdFGMATIBfZC51E5tXGYhT1k
 v5TPeDXYtMFqrp11kg+FeplYvaryk3LwAJwRADtGYecwWmI3N8SLbM8r6
 fUPe3yXhuBHIfjq3P2kD2pPZtmk/LztlL3+CniQMtcV19XKCWdcBX+xon Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4327510"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="4327510"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 03:24:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; d="scan'208";a="10527562"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.242.48])
 ([10.124.242.48])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 03:24:08 -0800
Message-ID: <0f3df4b7-ffb9-4fc5-90eb-8a1d6fea5786@intel.com>
Date: Thu, 7 Mar 2024 19:24:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 30/65] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-31-xiaoyao.li@intel.com> <87edcv1x9j.fsf@pond.sub.org>
 <f9774e89-399c-42ad-8fa8-dd4050ee46da@intel.com>
 <871q8vxuzx.fsf@pond.sub.org>
 <4602df24-029e-4a40-bdec-1b0a6aa30a3c@intel.com>
 <87v85yv3j9.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87v85yv3j9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.276, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 3/7/2024 4:39 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> On 2/29/2024 9:25 PM, Markus Armbruster wrote:
>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>
>>>> On 2/29/2024 4:37 PM, Markus Armbruster wrote:
>>>>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>>>>
>>>>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>>
>>>>>> Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
>>>>>> can be provided for TDX attestation. Detailed meaning of them can be
>>>>>> found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/
>>>>>>
>>>>>> Allow user to specify those values via property mrconfigid, mrowner and
>>>>>> mrownerconfig. They are all in base64 format.
>>>>>>
>>>>>> example
>>>>>> -object tdx-guest, \
>>>>>>      mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>>>>>      mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
>>>>>>      mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v
>>>>>>
>>>>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>>>>> Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> [...]
>>>
>>>>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>>>>> index 89ed89b9b46e..cac875349a3a 100644
>>>>>> --- a/qapi/qom.json
>>>>>> +++ b/qapi/qom.json
>>>>>> @@ -905,10 +905,25 @@
>>>>>>    #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>>>>>>    #     be set, otherwise they refuse to boot.
>>>>>>    #
>>>>>> +# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
>>>>>> +#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
>>>>>> +#     (A default value 0 of SHA384 is used when absent).
>>>>>
>>>>> Suggest to drop the parenthesis in the last sentence.
>>>>>
>>>>> @mrconfigid is a string, so the default value can't be 0.  Actually,
>>>>> it's not just any string, but a base64 encoded SHA384 digest, which
>>>>> means it must be exactly 96 hex digits.  So it can't be "0", either.  It
>>>>> could be
>>>>> "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000".
>>>>
>>>> I thought value 0 of SHA384 just means it.
>>>>
>>>> That's my fault and my poor english.
>>>
>>> "Fault" is too harsh :)  It's not as precise as I want our interface
>>> documentation to be.  We work together to get there.
>>>
>>>>> More on this below.
>>>>>
>>>>>> +#
>>>>>> +# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
>>>>>> +#     (A default value 0 of SHA384 is used when absent).
>>>>>> +#
>>>>>> +# @mrownerconfig: ID for owner-defined configuration of the guest TD,
>>>>>> +#     e.g., specific to the workload rather than the run-time or OS
>>>>>> +#     (base64 encoded SHA384 digest). (A default value 0 of SHA384 is
>>>>>> +#     used when absent).
>>>>>> +#
>>>>>>    # Since: 9.0
>>>>>>    ##
>>>>>>    { 'struct': 'TdxGuestProperties',
>>>>>> -  'data': { '*sept-ve-disable': 'bool' } }
>>>>>> +  'data': { '*sept-ve-disable': 'bool',
>>>>>> +            '*mrconfigid': 'str',
>>>>>> +            '*mrowner': 'str',
>>>>>> +            '*mrownerconfig': 'str' } }
>>>>>>    ##
>>>>>>    # @ThreadContextProperties:
>>>>>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>>>>>> index d0ad4f57b5d0..4ce2f1d082ce 100644
>>>>>> --- a/target/i386/kvm/tdx.c
>>>>>> +++ b/target/i386/kvm/tdx.c
>>>>>> @@ -13,6 +13,7 @@
>>>>>>    #include "qemu/osdep.h"
>>>>>>    #include "qemu/error-report.h"
>>>>>> +#include "qemu/base64.h"
>>>>>>    #include "qapi/error.h"
>>>>>>    #include "qom/object_interfaces.h"
>>>>>>    #include "standard-headers/asm-x86/kvm_para.h"
>>>>>> @@ -516,6 +517,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>>>>>        X86CPU *x86cpu = X86_CPU(cpu);
>>>>>>        CPUX86State *env = &x86cpu->env;
>>>>>>        g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
>>>>>> +    size_t data_len;
>>>>>>        int r = 0;
>>>>>>        object_property_set_bool(OBJECT(cpu), "pmu", false, &error_abort);
>>>>>> @@ -528,6 +530,38 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>>>>>>        init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
>>>>>>                            sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
>>>>>> +#define SHA384_DIGEST_SIZE  48
>>>>>> +
>>>>>> +    if (tdx_guest->mrconfigid) {
>>>>>> +        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
>>>>>> +                              strlen(tdx_guest->mrconfigid), &data_len, errp);
>>>>>> +        if (!data || data_len != SHA384_DIGEST_SIZE) {
>>>>>> +            error_setg(errp, "TDX: failed to decode mrconfigid");
>>>>>> +            return -1;
>>>>>> +        }
>>>>>> +        memcpy(init_vm->mrconfigid, data, data_len);
>>>>>> +    }
>>>>>
>>>>> When @mrconfigid is absent, the property remains null, and this
>>>>> conditional is not executed.  init_vm->mrconfigid[], an array of 6
>>>>> __u64, remains all zero.  How does the kernel treat that?
>>>>
>>>> A all-zero SHA384 value is still a valid value, isn't it?
>>>>
>>>> KVM treats it with no difference.
>>>
>>> Can you point me to the spot in the kernel where mrconfigid is used?
>>
>> https://github.com/intel/tdx/blob/66a10e258636fa8ec9f5ce687607bf2196a92341/arch/x86/kvm/vmx/tdx.c#L2322
>>
>> KVM just copy what QEMU provides into its own data structure @td_params. The format @of td_params is defined by TDX spec, and @td_params needs to be passed to TDX module when initialize the context of TD via SEAMCALL(TDH.MNG.INIT): https://github.com/intel/tdx/blob/66a10e258636fa8ec9f5ce687607bf2196a92341/arch/x86/kvm/vmx/tdx.c#L2450
>>
>>
>> In fact, all the three SHA384 fields, will be hashed together with some other fields (in td_params and other content of TD) to compromise the initial measurement of TD.
>>
>> TDX module doesn't care the value of td_params->mrconfigid.
> 
> My problem is that I don't understand when and why users would omit the
> optional @mrFOO.

When users don't care it and don't have an explicit value for them, they 
can omit it. Then a default all-zero value is used.

If making it mandatory field, then users have to explicit pass a 
all-zero value when they don't care it.

> I naively expected absent @mrFOO to mean something like "no attestation
> of FOO".
> 
> But I see that they default to
> "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000".
> 
> If this zero value is special and means "no attestation", then we
> accidentally get no attestation when whatever is being hashed happens to
> hash to this zero value.  Unlikely, but possible.
> 
> If it's not special, then when and why is the ability to omit it useful?
> 
At some point, the zero value is special, because it is the default 
value if no explicit one provided by user. But for TDX point of view, it 
is not special. The field is a must for any TD, and whatever value it 
is, it will be hashed into MRTD (Build-time Measurement Register) for 
later attestation.

TDX architecture defines what fields are always hashed into measurement 
and also provide other mechanism to hash optional field into 
measurement. All this is known to users of TDX, and users can calculate 
the final measurement by itself and compare to what gets reported by TDX 
to see they are identical.

For these three fields, they are must-to-have fields to be hashed into 
measurement. For user's convenience, we don't want to make it mandatory 
input because not everyone cares it and have a specific value to input.
What people needs to know is that, when no explicit value is provided 
for these three field, a all-zero value is used.



