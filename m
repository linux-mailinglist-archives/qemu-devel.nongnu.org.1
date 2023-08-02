Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E1176C7E6
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 10:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR6qD-0001vk-AK; Wed, 02 Aug 2023 04:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qR6qA-0001up-4g
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:04:18 -0400
Received: from [192.55.52.120] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qR6q8-0007iV-HT
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 04:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690963456; x=1722499456;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CUJG5kgK4w6vRjvQVxtBajR+8zX9BVIsj1QWPqvP7to=;
 b=VastsejFHoqBP2r4Oo2X5QVg9lI1MHxZJYXBJZgfz6HpzgKvAoE6FhKi
 z1sUXLrhmvqe90iIcsLG2TqRVd2M+Zx9G5R1qJwgTiW1+RMtFTx47qKzm
 NWX6hAIFiEaUhpAgT1WWGacbG0JGIEb11LL5wW0KTugciDeV+rwNA2MMQ
 TUFYdLhr8tj/UIH9J/A2PWeILOY0XXh+QnhXYQvXGmMd98OY/nCH5/tM8
 T5mz5PBCfHYuBdknRtvzbnA4uuj7biX6TK6pXsWGhHQzYQlpULbW9A/8V
 n5X27dBmFgqfCvvhXvs4UusgI3hu6uzdCENN219XIKyo+Hz0wYH0MToBZ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="368411603"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; d="scan'208";a="368411603"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 01:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="732288771"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; d="scan'208";a="732288771"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2023 01:04:10 -0700
Message-ID: <f5ddade3-01a8-f315-e380-cd53d448123a@intel.com>
Date: Wed, 2 Aug 2023 16:04:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 08/19] HostMem: Add private property to indicate to
 use kvm gmem
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-9-xiaoyao.li@intel.com> <87o7js808y.fsf@pond.sub.org>
 <ZMkdZkQipZUIUicN@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZMkdZkQipZUIUicN@redhat.com>
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

On 8/1/2023 10:57 PM, Daniel P. Berrangé wrote:
> On Mon, Jul 31, 2023 at 07:22:05PM +0200, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>
>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>
>>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>
>> [...]
>>
>>> diff --git a/qapi/qom.json b/qapi/qom.json
>>> index 7f92ea43e8e1..e0b2044e3d20 100644
>>> --- a/qapi/qom.json
>>> +++ b/qapi/qom.json
>>> @@ -605,6 +605,9 @@
>>>   # @reserve: if true, reserve swap space (or huge pages) if applicable
>>>   #     (default: true) (since 6.1)
>>>   #
>>> +# @private: if true, use KVM gmem private memory
>>> +#           (default: false) (since 8.1)
>>> +#
>>
>> Please format like
>>
>>     # @private: if true, use KVM gmem private memory (default: false)
>>     #     (since 8.1)
> 
> Also QEMU 8.1.0 is in freeze right now, so there's no chance
> of these patches making 8.1.0. IOW, use "since 8.2" as the
> next release you might achieve merge for.

Thanks for pointing it out. Will do it in next version.

> With regards,
> Daniel


