Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083B782AAD
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 15:38:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY56F-0007Ug-K5; Mon, 21 Aug 2023 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qY56C-0007UY-L9
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:37:40 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qY569-00089z-O9
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 09:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692625057; x=1724161057;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=M+ae2WWZJRbnkbrcvS/1ir92dZk28ks8tEhtEglPDk4=;
 b=KVTLUjATdkCG78j6tSSCQUCQ+aD22PpwBuI32uznFVZ0MmME5LdujS5B
 CsInOBkhIj0Ufh9XJXlUmOAGrKwdfR/ADUxz9Q3LRcJQefTYib3bCP4iQ
 DS3rBJbq7semfFvtlRZfDeppdBgFqmDKlPC3Aq1izCFQRcAoW954/MpLr
 6A/1vxZWd81Zh1cDjPQUerfRpFjRbq0Wv5iTixjknjAlh63oag3ylJYGm
 JBcb7r/KISrFjo7Ft5Hki/vVYHKHhq+dMezMQXWC3AJnq/cTrjG9SYaTq
 AEWRLTpqXlY/OCGzNp0Pv8bjZ3rxk4gt6P8l2TxELeP0udSD1rwDE09Gg w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376340154"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; d="scan'208";a="376340154"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2023 06:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="1066606579"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; d="scan'208";a="1066606579"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2023 06:37:17 -0700
Message-ID: <e031e715-8962-831f-a56a-935a006b8aa8@intel.com>
Date: Mon, 21 Aug 2023 21:37:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v2 03/58] target/i386: Parse TDX vm type
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
 <20230818095041.1973309-4-xiaoyao.li@intel.com> <ZOMf6AMe1ShL3rjC@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZOMf6AMe1ShL3rjC@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -77
X-Spam_score: -7.8
X-Spam_bar: -------
X-Spam_report: (-7.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-3.374,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/21/2023 4:27 PM, Daniel P. Berrangé wrote:
> On Fri, Aug 18, 2023 at 05:49:46AM -0400, Xiaoyao Li wrote:
>> TDX VM requires VM type KVM_X86_TDX_VM to be passed to
>> kvm_ioctl(KVM_CREATE_VM).
>>
>> If tdx-guest object is specified to confidential-guest-support, like,
>>
>>    qemu -machine ...,confidential-guest-support=tdx0 \
>>         -object tdx-guest,id=tdx0,...
>>
>> it parses VM type as KVM_X86_TDX_VM.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   target/i386/kvm/kvm.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 62f237068a3a..77f4772afe6c 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -32,6 +32,7 @@
>>   #include "sysemu/runstate.h"
>>   #include "kvm_i386.h"
>>   #include "sev.h"
>> +#include "tdx.h"
>>   #include "xen-emu.h"
>>   #include "hyperv.h"
>>   #include "hyperv-proto.h"
>> @@ -158,6 +159,7 @@ static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
>>   static const char* vm_type_name[] = {
>>       [KVM_X86_DEFAULT_VM] = "default",
>>       [KVM_X86_SW_PROTECTED_VM] = "sw-protected-vm",
>> +    [KVM_X86_TDX_VM] = "tdx",
>>   };
>>   
>>   int kvm_get_vm_type(MachineState *ms, const char *vm_type)
>> @@ -170,12 +172,18 @@ int kvm_get_vm_type(MachineState *ms, const char *vm_type)
>>               kvm_type = KVM_X86_DEFAULT_VM;
>>           } else if (!g_ascii_strcasecmp(vm_type, "sw-protected-vm")) {
>>               kvm_type = KVM_X86_SW_PROTECTED_VM;
>> -        } else {
>> +        } else if (!g_ascii_strcasecmp(vm_type, "tdx")) {
>> +            kvm_type = KVM_X86_TDX_VM;
>> +        }else {
>>               error_report("Unknown kvm-type specified '%s'", vm_type);
>>               exit(1);
>>           }
>>       }
> 
> This whole block of code should go away - as this should not exist
> as a user visible property. It should be sufficient to use the
> tdx-guest object type to identify use of TDX.
> 

yes, agreed.

It's here because this series is based on the gmem series, which 
introduced property. I'm sorry that I forgot to mention it in the commit 
message.

Next gmem series will drop the implementation of kvm-type property [1] 
and above code will be dropped in next version as well.

[1] 
https://lore.kernel.org/qemu-devel/9b3a3e88-21f4-bfd2-a9c3-60a25832e698@intel.com/



