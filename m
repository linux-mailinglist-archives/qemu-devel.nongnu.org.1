Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B9D76B817
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 16:56:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqm3-000327-QZ; Tue, 01 Aug 2023 10:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQqm1-00031h-UY
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:54:57 -0400
Received: from [192.55.52.136] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQqlz-0000WG-Sk
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 10:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690901695; x=1722437695;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=hFAFf3KVZlwutGJFb9g4o8PQ8QKXQi2tI4AFdT2Qoco=;
 b=bX995mjP9wKrpYDSqymwQb3ye+sJ47YUtjOHqysxYP2zIPkbBBlewcQ4
 rrvgjlIQaBx5kkGxzB7ZvVKmgCP/eaDhQhlsORfwVc6J9RjDiKDax2/zz
 6eNHW0+7THVJHk0f2bNA3ZhkhoGahLPo+hqpQR3RqwFfMPwn+BiJm3Xoc
 VmWKjZpT0Vo/VeEtlaEPjPZ4o6phOwwlPt5oTPrGqbuNhi86mFaZ+L4C9
 htizgyHJHed8NokvNtDkMa8O1asrsoOxTzxyNectaTwtHPrPLgumJj0+E
 nFd0wnxGduCNv+Ir0ABsbgwcpCg9CqwICXaNecSEc0R/wLw7ntHELEtVa Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="348919093"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; d="scan'208";a="348919093"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 07:54:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975335372"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; d="scan'208";a="975335372"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 07:54:48 -0700
Message-ID: <54ca98fb-2c26-9787-9da6-6d56c0b68213@intel.com>
Date: Tue, 1 Aug 2023 22:54:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-9-xiaoyao.li@intel.com> <87o7js808y.fsf@pond.sub.org>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <87o7js808y.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.136 (failed)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=xiaoyao.li@intel.com;
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

On 8/1/2023 1:22 AM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> [...]
> 
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 7f92ea43e8e1..e0b2044e3d20 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -605,6 +605,9 @@
>>   # @reserve: if true, reserve swap space (or huge pages) if applicable
>>   #     (default: true) (since 6.1)
>>   #
>> +# @private: if true, use KVM gmem private memory
>> +#           (default: false) (since 8.1)
>> +#
> 
> Please format like
> 
>     # @private: if true, use KVM gmem private memory (default: false)
>     #     (since 8.1)
> 
> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
> to conform to current conventions).

will do it in next version.

Thanks!
-Xiaoyao

>>   # @size: size of the memory region in bytes
>>   #
>>   # @x-use-canonical-path-for-ramblock-id: if true, the canonical path
>> @@ -631,6 +634,7 @@
>>               '*prealloc-context': 'str',
>>               '*share': 'bool',
>>               '*reserve': 'bool',
>> +            '*private': 'bool',
>>               'size': 'size',
>>               '*x-use-canonical-path-for-ramblock-id': 'bool' } }
> 


