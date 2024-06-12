Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DAA904E26
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jun 2024 10:29:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHJM0-0000D4-1T; Wed, 12 Jun 2024 04:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHJLy-0000Ce-C5
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:29:10 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHJLv-0000zS-Ib
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 04:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718180948; x=1749716948;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=tnsFj3xarSZjBfOEha/shi7k/q3DMKKZs+BnOozwJmE=;
 b=W796jSjCe+geMZJpWaLuminvdbYvYGr00X7bm1RyQtwBcgY4zlrmVYQh
 vgygKrLB4vIEw6GVgA7OeujnTzg2zfIXgbbGPHJlrkCUF0/DXbLVl02bx
 L4196y+pU4HfXxpk+LnL00kZZN8yKn+PdKq6JwBBjNNKQe6rqCsIkWNuD
 BTqcVX2BjRae9AIQfs1YvLFsYuJ0FeiypzLzWfQ3ssUrkGPToKpDWmQm5
 e/zZBh6zftWMbWTmU5id5+U67kxu+Jo3wYkpjqwZ5058qyShGLzJI6j6K
 69qcz55omfuIVww7nbIAGYCLuW/F48+8nMTRmDeb8w7Ct/JOyEmvDvQOQ A==;
X-CSE-ConnectionGUID: Zc89xqrOQYygtBrJHM4y8w==
X-CSE-MsgGUID: EoSUEcaNQeekZhhGXH9Nzg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18710853"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; d="scan'208";a="18710853"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 01:29:04 -0700
X-CSE-ConnectionGUID: jlcWsIirR0mR+ipt3FugoA==
X-CSE-MsgGUID: EcTQyWlRTViFDHpV1SIrNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; d="scan'208";a="40183566"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.51])
 ([10.124.227.51])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2024 01:28:57 -0700
Message-ID: <90739246-f008-4cf2-bcf5-8a243e2b13d4@intel.com>
Date: Wed, 12 Jun 2024 16:28:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/65] i386/tdx: Add property sept-ve-disable for
 tdx-guest object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-26-xiaoyao.li@intel.com> <ZmGTXP36B76IRalJ@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZmGTXP36B76IRalJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/6/2024 6:45 PM, Daniel P. Berrangé wrote:
> Copying  Zhenzhong Duan as my point relates to the proposed libvirt
> TDX patches.
> 
> On Thu, Feb 29, 2024 at 01:36:46AM -0500, Xiaoyao Li wrote:
>> Bit 28 of TD attribute, named SEPT_VE_DISABLE. When set to 1, it disables
>> EPT violation conversion to #VE on guest TD access of PENDING pages.
>>
>> Some guest OS (e.g., Linux TD guest) may require this bit as 1.
>> Otherwise refuse to boot.
>>
>> Add sept-ve-disable property for tdx-guest object, for user to configure
>> this bit.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>> ---
>> Changes in v4:
>> - collect Acked-by from Markus
>>
>> Changes in v3:
>> - update the comment of property @sept-ve-disable to make it more
>>    descriptive and use new format. (Daniel and Markus)
>> ---
>>   qapi/qom.json         |  7 ++++++-
>>   target/i386/kvm/tdx.c | 24 ++++++++++++++++++++++++
>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 220cc6c98d4b..89ed89b9b46e 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -900,10 +900,15 @@
>>   #
>>   # Properties for tdx-guest objects.
>>   #
>> +# @sept-ve-disable: toggle bit 28 of TD attributes to control disabling
>> +#     of EPT violation conversion to #VE on guest TD access of PENDING
>> +#     pages.  Some guest OS (e.g., Linux TD guest) may require this to
>> +#     be set, otherwise they refuse to boot.
>> +#
>>   # Since: 9.0
>>   ##
>>   { 'struct': 'TdxGuestProperties',
>> -  'data': { }}
>> +  'data': { '*sept-ve-disable': 'bool' } }
> 
> So this exposes a single boolean property that gets mapped into one
> specific bit in the TD attributes:
> 
>> +
>> +static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
>> +{
>> +    TdxGuest *tdx = TDX_GUEST(obj);
>> +
>> +    if (value) {
>> +        tdx->attributes |= TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
>> +    } else {
>> +        tdx->attributes &= ~TDX_TD_ATTRIBUTES_SEPT_VE_DISABLE;
>> +    }
>> +}
> 
> If I look at the documentation for TD attributes
> 
>    https://download.01.org/intel-sgx/latest/dcap-latest/linux/docs/Intel_TDX_DCAP_Quoting_Library_API.pdf
> 
> Section "A.3.4. TD Attributes"
> 
> I see "TD attributes" is a 64-bit int, with 5 bits currently
> defined "DEBUG", "SEPT_VE_DISABLE", "PKS", "PL", "PERFMON",
> and the rest currently reserved for future use. This makes me
> wonder about our modelling approach into the future ?
> 
> For the AMD SEV equivalent we've just directly exposed the whole
> field as an int:
> 
>       'policy' : 'uint32',
> 
> For the proposed SEV-SNP patches, the same has been done again
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2024-06/msg00536.html
> 
>       '*policy': 'uint64',
> 
> 
> The advantage of exposing individual booleans is that it is
> self-documenting at the QAPI level, but the disadvantage is
> that every time we want to expose ability to control a new
> bit in the policy we have to modify QEMU, libvirt, the mgmt
> app above libvirt, and whatever tools the end user has to
> talk to the mgmt app.
> 
> If we expose a policy int, then newly defined bits only require
> a change in QEMU, and everything above QEMU will already be
> capable of setting it.
> 
> In fact if I look at the proposed libvirt patches, they have
> proposed just exposing a policy "int" field in the XML, which
> then has to be unpacked to set the individual QAPI booleans
> 
>    https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/message/WXWXEESYUA77DP7YIBP55T2OPSVKV5QW/
> 
> On balance, I think it would be better if QEMU just exposed
> the raw TD attributes policy as an uint64 at QAPI, instead
> of trying to unpack it to discrete bool fields. This gives
> consistency with SEV and SEV-SNP, and with what's proposed
> at the libvirt level, and minimizes future changes when
> more policy bits are defined.

The reasons why introducing individual bit of sept-ve-disable instead of 
a raw TD attribute as a whole are that

1. other bits like perfmon, PKS, KL are associated with cpu properties, 
e.g.,

	perfmon -> pmu,
	pks -> pks,
	kl -> keylokcer feature that QEMU currently doesn't support

If allowing configuring attribute directly, we need to deal with the 
inconsistence between attribute vs cpu property.

2. people need to know the exact bit position of each attribute. I don't 
think it is a user-friendly interface to require user to be aware of 
such details.

For example, if user wants to create a Debug TD, user just needs to set 
'debug=on' for tdx-guest object. It's much more friendly than that user 
needs to set the bit 0 of the attribute.


>> +
>>   /* tdx guest */
>>   OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
>>                                      tdx_guest,
>> @@ -529,6 +549,10 @@ static void tdx_guest_init(Object *obj)
>>       qemu_mutex_init(&tdx->lock);
>>   
>>       tdx->attributes = 0;
>> +
>> +    object_property_add_bool(obj, "sept-ve-disable",
>> +                             tdx_guest_get_sept_ve_disable,
>> +                             tdx_guest_set_sept_ve_disable);
>>   }
>>   
>>   static void tdx_guest_finalize(Object *obj)
>> -- 
>> 2.34.1
>>
> 
> With regards,
> Daniel


