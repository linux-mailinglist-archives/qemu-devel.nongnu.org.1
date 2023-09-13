Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FE979E054
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:01:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgJqw-0003p9-6i; Wed, 13 Sep 2023 02:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgJqu-0003oy-5e
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:59:56 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgJqq-00047J-80
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 02:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694588392; x=1726124392;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=C6mQa9xWJ5rj5rAaxGCawIPJlfT6aTwLFeDPxzx9A+k=;
 b=h6Mg6MtFVND8NFo+kZV2rf+oP+N8PKxArCPZokqZS7AqH4J8gzHIwBQK
 0ehNo3RpcRQLQ72HJPl/7O2TNsseZuzoywuh0f+PCe3BxID3OqZoG8xOr
 IsXTfml++/d5o4W3AmdFn6S8hs4pYgRfrWAADcnsn1h8jYS4U5c8Y6zBr
 LiE15ybsoWaET3pALFmahE7IAMIB18N2NDYW90bEzbkj+UHVsSCwAztqX
 5LOHM+wEb8TaGATCf9f8c8RWoajBqBS3j36Du+DOP6hxvx5QkuVrPVgmn
 Vje95qdil2nV0LRqvKiXmICXWFKUJ0X0UfaNu3f74BX2Ip546Ja8dpmEN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377491112"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; d="scan'208";a="377491112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2023 23:59:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="747192882"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; d="scan'208";a="747192882"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.16.87])
 ([10.93.16.87])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2023 23:59:26 -0700
Message-ID: <fc235a15-53be-033a-1281-ff94ecb8c269@intel.com>
Date: Wed, 13 Sep 2023 14:59:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 15/19] kvm: handle KVM_EXIT_MEMORY_FAULT
To: Isaku Yamahata <isaku.yamahata@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-16-xiaoyao.li@intel.com>
 <20230802222545.GC1807130@ls.amr.corp.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20230802222545.GC1807130@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.55.52.120; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-1.473,
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

On 8/3/2023 6:25 AM, Isaku Yamahata wrote:
> On Mon, Jul 31, 2023 at 12:21:57PM -0400,
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> From: Chao Peng <chao.p.peng@linux.intel.com>
>>
>> Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
>> KVM_EXIT_MEMORY_FAULT happens. It indicates userspace needs to do
>> the memory conversion on the RAMBlock to turn the memory into desired
>> attribute, i.e., private/shared.
>>
>> Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
>> gmem memory backend.
>>
>> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   accel/kvm/kvm-all.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index f9b5050b8885..72d50b923bf2 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -3040,6 +3040,48 @@ static void kvm_eat_signals(CPUState *cpu)
>>       } while (sigismember(&chkset, SIG_IPI));
>>   }
>>   
>> +static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
>> +{
>> +    MemoryRegionSection section;
>> +    void *addr;
>> +    RAMBlock *rb;
>> +    ram_addr_t offset;
>> +    int ret = -1;
>> +
>> +    section = memory_region_find(get_system_memory(), start, size);
>> +    if (!section.mr) {
>> +        return ret;
>> +    }
>> +
>> +    if (memory_region_can_be_private(section.mr)) {
>> +        if (to_private) {
>> +            ret = kvm_set_memory_attributes_private(start, size);
>> +        } else {
>> +            ret = kvm_set_memory_attributes_shared(start, size);
>> +        }
>> +
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +
>> +        addr = memory_region_get_ram_ptr(section.mr) +
>> +               section.offset_within_region;
>> +        rb = qemu_ram_block_from_host(addr, false, &offset);
> 
> Here we have already section. section.mr->ram_block.  We don't have to
> scan the existing RAMBlocks.

But we don't have the @offset, do we?

> Except that, looks good to me.
> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>


