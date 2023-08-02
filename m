Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598E76C7E5
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6pc-0001kO-53; Wed, 02 Aug 2023 04:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qR6pa-0001kA-1J
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:03:42 -0400
Received: from [192.55.52.120] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qR6pY-0007bi-3q
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690963420; x=1722499420;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=83fW9XZQKMG666lu8RCXFlJ6rej8OW3/lE+RD9JXFks=;
 b=RmhSGquAVZ+aRWlJOGp8r3acJMOR31kIKyPmQafDTol+rKAZsG2IBv1I
 bwfn5Um0E/kf/Hq6wPWPiQwPVBfTl7u0r31Nmpp99ttYYYyEETlvcWnWx
 /ngphmfXxDFSTBD0QlaGgHt44iXEDebsKmvs4PxjyytMkMwmFSLZy+UPH
 2PdPkToFRITBfMNB812m3LP27AhlYuWv6kgZMsLPeC74yqOHdnejj6C9p
 j7DV1wCFHJ740TeOgbxG4+c6BRESFkj7vKRpyoVJevRJZNqK7QdsSRFpW
 wo+YgsEB2g5wZBFPLJ5hp7r84twEPBm5AnRILrEkb7yGIS/oN7Xvxgbvi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368411435"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; d="scan'208";a="368411435"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 01:03:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732288530"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; d="scan'208";a="732288530"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 01:03:30 -0700
Message-ID: <2addfff0-88bf-59aa-f2f3-8129366a006d@intel.com>
Date: Wed, 2 Aug 2023 16:03:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
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
 <20230731162201.271114-9-xiaoyao.li@intel.com>
 <f8e40f1a-729b-f520-299a-4132e371be61@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <f8e40f1a-729b-f520-299a-4132e371be61@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 8/2/2023 1:21 AM, David Hildenbrand wrote:
> On 31.07.23 18:21, Xiaoyao Li wrote:
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>>   backends/hostmem.c       | 18 ++++++++++++++++++
>>   include/sysemu/hostmem.h |  2 +-
>>   qapi/qom.json            |  4 ++++
>>   3 files changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/backends/hostmem.c b/backends/hostmem.c
>> index 747e7838c031..dbdbb0aafd45 100644
>> --- a/backends/hostmem.c
>> +++ b/backends/hostmem.c
>> @@ -461,6 +461,20 @@ static void 
>> host_memory_backend_set_reserve(Object *o, bool value, Error **errp)
>>       }
>>       backend->reserve = value;
>>   }
>> +
>> +static bool host_memory_backend_get_private(Object *o, Error **errp)
>> +{
>> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
>> +
>> +    return backend->private;
>> +}
>> +
>> +static void host_memory_backend_set_private(Object *o, bool value, 
>> Error **errp)
>> +{
>> +    HostMemoryBackend *backend = MEMORY_BACKEND(o);
>> +
>> +    backend->private = value;
>> +}
>>   #endif /* CONFIG_LINUX */
>>   static bool
>> @@ -541,6 +555,10 @@ host_memory_backend_class_init(ObjectClass *oc, 
>> void *data)
>>           host_memory_backend_get_reserve, 
>> host_memory_backend_set_reserve);
>>       object_class_property_set_description(oc, "reserve",
>>           "Reserve swap space (or huge pages) if applicable");
>> +    object_class_property_add_bool(oc, "private",
>> +        host_memory_backend_get_private, 
>> host_memory_backend_set_private);
>> +    object_class_property_set_description(oc, "private",
>> +        "Use KVM gmem private memory");
>>   #endif /* CONFIG_LINUX */
>>       /*
>>        * Do not delete/rename option. This option must be considered 
>> stable
>> diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
>> index 39326f1d4f9c..d88970395618 100644
>> --- a/include/sysemu/hostmem.h
>> +++ b/include/sysemu/hostmem.h
>> @@ -65,7 +65,7 @@ struct HostMemoryBackend {
>>       /* protected */
>>       uint64_t size;
>>       bool merge, dump, use_canonical_path;
>> -    bool prealloc, is_mapped, share, reserve;
>> +    bool prealloc, is_mapped, share, reserve, private;
>>       uint32_t prealloc_threads;
>>       ThreadContext *prealloc_context;
>>       DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 7f92ea43e8e1..e0b2044e3d20 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -605,6 +605,9 @@
>>   # @reserve: if true, reserve swap space (or huge pages) if applicable
>>   #     (default: true) (since 6.1)
>>   #
>> +# @private: if true, use KVM gmem private memory
>> +#           (default: false) (since 8.1)
>> +#
> 
> But that's not what any of this does.
> 
> This patch only adds a property and doesn't even explain what it intends 
> to achieve with that.
> 
> How will it be used from a user? What will it affect internally? What 
> will it modify in regards of the memory backend?

How it will be used is in the next patch, patch 09.

for kvm_x86_sw_protected_vm type VM, it will allocate private gmem with 
KVM ioctl if the memory backend has property "private" on.

> That all should go into the surprisingly empty patch description.

I'm sorry. I admit the empty commit message is really bad.




