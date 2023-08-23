Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95686785198
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 09:33:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYiLW-0004zM-Vh; Wed, 23 Aug 2023 03:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYiLS-0004xI-U8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:32:02 -0400
Received: from mgamail.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qYiLR-0008QK-29
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 03:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692775921; x=1724311921;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pjsOKmsIu4a8shj22q34i7BJ1XVcMUenrIsRzIg00Do=;
 b=iLdBvwKAQSPoc7//sWN/AJfdFx8JirOv4ECyDvAcdJnu+0BhYrQGtSFs
 6nvrWbgbBP6RcnPD+zCiHvoYct9VZHqjvUlGfDuSU2sp0eHzRjSge2pYS
 9fEXyb1pnySaAOFVI7LgNSdjxWbE+wkJTA/iFwevT9J1wnBlBQoDFSkrT
 dulvKCwhXmw5fYLX9DZvTqTlqIaxi6pI0HOvnPqaKZoFKV7MIE3KN2vGz
 deASOcxxir3ziXgw4NPZqjAL5k9vfWyPpYRilLDJvlP5dOUaZMrZLXURJ
 USuhixO3bXnNvk9GfLeDKDFtloS7PF4sn7XdLiMIQcLlwl7JF6/onYE89 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="460458608"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="460458608"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2023 00:31:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="713475915"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="713475915"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2023 00:31:51 -0700
Message-ID: <5211f873-88f2-ac11-3c57-676f55df190b@intel.com>
Date: Wed, 23 Aug 2023 15:31:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 18/58] i386/tdx: Validate TD attributes
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Eduardo Habkost <eduardo@habkost.net>, Laszlo Ersek <lersek@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>, erdemaktas@google.com,
 Chenyi Qiang <chenyi.qiang@intel.com>
References: <20230818095041.1973309-1-xiaoyao.li@intel.com>
 <20230818095041.1973309-19-xiaoyao.li@intel.com>
 <ZOMrd6f0URDYp/0r@redhat.com>
 <c1ad3974-876a-9d29-9a59-f54ae4f8b09e@intel.com>
 <ZOTJPUPtYnBMI0W9@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZOTJPUPtYnBMI0W9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.43; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.767,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/22/2023 10:42 PM, Daniel P. Berrangé wrote:
> On Tue, Aug 22, 2023 at 10:30:47PM +0800, Xiaoyao Li wrote:
>> On 8/21/2023 5:16 PM, Daniel P. Berrangé wrote:
>>> On Fri, Aug 18, 2023 at 05:50:01AM -0400, Xiaoyao Li wrote:
>>>> Validate TD attributes with tdx_caps that fixed-0 bits must be zero and
>>>> fixed-1 bits must be set.
>>>>
>>>> Besides, sanity check the attribute bits that have not been supported by
>>>> QEMU yet. e.g., debug bit, it will be allowed in the future when debug
>>>> TD support lands in QEMU.
>>>>
>>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> ---
>>>>    target/i386/kvm/tdx.c | 27 +++++++++++++++++++++++++--
>>>>    1 file changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
>>>> index 629abd267da8..73da15377ec3 100644
>>>> --- a/target/i386/kvm/tdx.c
>>>> +++ b/target/i386/kvm/tdx.c
>>>> @@ -32,6 +32,7 @@
>>>>                                         (1U << KVM_FEATURE_PV_SCHED_YIELD) | \
>>>>                                         (1U << KVM_FEATURE_MSI_EXT_DEST_ID))
>>>> +#define TDX_TD_ATTRIBUTES_DEBUG             BIT_ULL(0)
>>>>    #define TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE   BIT_ULL(28)
>>>>    #define TDX_TD_ATTRIBUTES_PKS               BIT_ULL(30)
>>>>    #define TDX_TD_ATTRIBUTES_PERFMON           BIT_ULL(63)
>>>> @@ -462,13 +463,32 @@ int tdx_kvm_init(MachineState *ms, Error **errp)
>>>>        return 0;
>>>>    }
>>>> -static void setup_td_guest_attributes(X86CPU *x86cpu)
>>>> +static int tdx_validate_attributes(TdxGuest *tdx)
>>>> +{
>>>> +    if (((tdx->attributes & tdx_caps->attrs_fixed0) | tdx_caps->attrs_fixed1) !=
>>>> +        tdx->attributes) {
>>>> +            error_report("Invalid attributes 0x%lx for TDX VM (fixed0 0x%llx, fixed1 0x%llx)",
>>>> +                          tdx->attributes, tdx_caps->attrs_fixed0, tdx_caps->attrs_fixed1);
>>>> +            return -EINVAL;
>>>> +    }
>>>> +
>>>> +    if (tdx->attributes & TDX_TD_ATTRIBUTES_DEBUG) {
>>>> +        error_report("Current QEMU doesn't support attributes.debug[bit 0] for TDX VM");
>>>> +        return -EINVAL;
>>>> +    }
>>>
>>> Use error_setg() in both cases, passing in a 'Error **errp' object,
>>> and 'return -1' instead of returning an errno value.
>>>
>>
>> why return -1 instead of -EINVAL?
> 
> Returning errno values is useful if the method isn't providing an
> "Error **errp" parameter, because it lets the caller report a
> more detailed error message via strerror(). Once you add a Error **
> parameter though, there is almost never any reason for the caller
> to care about the original errno value, and so we use 0 / -1 as
> success/fail indicators.

I see.

Thanks,
-Xiaoyao

> With regards,
> Daniel


