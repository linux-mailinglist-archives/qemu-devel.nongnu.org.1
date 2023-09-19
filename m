Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA877A6F61
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 01:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qik4t-00028u-VQ; Tue, 19 Sep 2023 19:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qik4r-00028e-Qw
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 19:24:21 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qik4p-0007xk-1K
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 19:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695165859; x=1726701859;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SLa3CFPM9YFPKuRCsC8h0wcrJYMqW+0P11yOKPVS3Zk=;
 b=m/e097dq8gCfixsD59ZYRuSh3o5MHO7JRxdPRMd94F41GPNC/tLcClNC
 E22o8qaMw8wGA6c/BHk5ecXhTAK5IOFl37dmc1Ndlv9vUrVnJvRJowbw/
 gJsK7GzAbgGHm7yEsNihhwkeFXLR8+BCMKpy23iy/TkNjfEJysb3B6Tuj
 1GwKX4QXIV6IcF0u2Q0O4WbjZn+n88WHDrolTiBKauoW30ng8b69j/hT3
 8QwTObQLiYTU3xonXkZSzNl67qMrf2LJgNYVHiuFJP8AJhG0++fijazwj
 88mqphdkaGQJPjCMtpLl8bckE50mZ0HbE+U3czKdwgSwW27vrVdYKUMnN w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="383919136"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; d="scan'208";a="383919136"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 16:24:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="696092486"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; d="scan'208";a="696092486"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.19.128])
 ([10.93.19.128])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 16:24:08 -0700
Message-ID: <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com>
Date: Wed, 20 Sep 2023 07:24:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and associate
 it with RAM_KVM_GMEM
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com> <8734zazeag.fsf@pond.sub.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <8734zazeag.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
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

On 9/19/2023 5:46 PM, Markus Armbruster wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>
>> Add a new property "private" to memory backends. When it's set to true,
>> it indicates the RAMblock of the backend also requires kvm gmem.
> 
> Can you add a brief explanation why you need the property?

It provides a mechanism for user to specify whether the memory can serve 
as private memory (need request kvm gmem).

>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> [...]
> 
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index fa3e88c8e6ab..d28c5403bc0f 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -605,6 +605,9 @@
>>   # @reserve: if true, reserve swap space (or huge pages) if applicable
>>   #     (default: true) (since 6.1)
>>   #
>> +# @private: if true, use KVM gmem private memory (default: false)
>> +#     (since 8.2)
>> +#
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


