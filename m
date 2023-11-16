Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FFF7ED9C2
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 03:48:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3SQ2-00035K-CQ; Wed, 15 Nov 2023 21:47:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3SQ0-00034x-TA
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:47:48 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3SPz-00008m-92
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700102867; x=1731638867;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=raAjj+ppcl8HOoyTjPoDhf0qhLozPZCCDn35FT/+JrU=;
 b=dGFGEWyQBJStrZSKYryTl34Mjer0rn9AO37HocMabXCp0g5Q0tsEsXdD
 yzsB3R6rIdevrM/je3W+lL2tCgC3UeSRqm+a63NOQNSvImnQckFVUbuk9
 E01L3dOQMrIpnJ9WUSXw5Kl+wnHu8jnTONFww7eBVtk86ZazePLe50qUg
 aOGWcLk5rYe7AZ2Do8hcAO++A7fov4iDvCHFO+PdBzEeVM2p993aJyi0R
 Zo/fwm8CT19eltFPH/FUeXgFnLz4aJ1A0yoFDIMecpC5XhwHIUqEgUQHI
 YG7HgL/+fsZYMepixe1rboF6lwV/sqwhdiJ142ijoWpxwHi8VTtUcEQkC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388165706"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; d="scan'208";a="388165706"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:47:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="715062974"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; d="scan'208";a="715062974"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:47:38 -0800
Message-ID: <05f0e440-36a2-4d3a-8caa-842b34e50dce@intel.com>
Date: Thu, 16 Nov 2023 10:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/70] RAMBlock/guest_memfd: Enable
 KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, Sean Christopherson
 <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-4-xiaoyao.li@intel.com>
 <bc84fa4f-4866-4321-8f30-1388eed7e64f@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <bc84fa4f-4866-4321-8f30-1388eed7e64f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/16/2023 2:10 AM, David Hildenbrand wrote:
> On 15.11.23 08:14, Xiaoyao Li wrote:
>> KVM allows KVM_GUEST_MEMFD_ALLOW_HUGEPAGE for guest memfd. When the
>> flag is set, KVM tries to allocate memory with transparent hugeapge at
>> first and falls back to non-hugepage on failure.
>>
>> However, KVM defines one restriction that size must be hugepage size
>> aligned when KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is set.
>>
>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> ---
>> v3:
>>   - New one in v3.
>> ---
>>   system/physmem.c | 38 ++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index 0af2213cbd9c..c56b17e44df6 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1803,6 +1803,40 @@ static void dirty_memory_extend(ram_addr_t 
>> old_ram_size,
>>       }
>>   }
>> +#ifdef CONFIG_KVM
>> +#define HPAGE_PMD_SIZE_PATH 
>> "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
>> +#define DEFAULT_PMD_SIZE (1ul << 21)
>> +
>> +static uint32_t get_thp_size(void)
>> +{
>> +    gchar *content = NULL;
>> +    const char *endptr;
>> +    static uint64_t thp_size = 0;
>> +    uint64_t tmp;
>> +
>> +    if (thp_size != 0) {
>> +        return thp_size;
>> +    }
>> +
>> +    if (g_file_get_contents(HPAGE_PMD_SIZE_PATH, &content, NULL, 
>> NULL) &&
>> +        !qemu_strtou64(content, &endptr, 0, &tmp) &&
>> +        (!endptr || *endptr == '\n')) {
>> +        /* Sanity-check the value and fallback to something 
>> reasonable. */
>> +        if (!tmp || !is_power_of_2(tmp)) {
>> +            warn_report("Read unsupported THP size: %" PRIx64, tmp);
>> +        } else {
>> +            thp_size = tmp;
>> +        }
>> +    }
>> +
>> +    if (!thp_size) {
>> +        thp_size = DEFAULT_PMD_SIZE;
>> +    }
> 
> ... did you shamelessly copy that from hw/virtio/virtio-mem.c ? ;)

Get caught.

> This should be factored out into a common helper.

Sure, will do it in next version.


