Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4D47FE9D3
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 08:38:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8bch-00066q-AG; Thu, 30 Nov 2023 02:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8bce-00065Q-7e
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:38:08 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8bcZ-0005mB-Pn
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 02:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701329883; x=1732865883;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=nRsvxMK0xXLv2z475vawDPZCSbmouFr1izddt1pJqeY=;
 b=f6vR9AyrZbmfGaBsCfMcNxGn9tUu81wiK4xFhzTJWeqR6JW9/eXlqLxI
 N2f98NCpLsEiJw4o+t1+hduaOmgEVJtAnvaTAp0vew3rna+5dNkK3fiKt
 llYZiRJOkpEGhi7OUyhzkCOILKQBsfu3XhAgnG+TECFgfK0h85Pzi2bWn
 UUun/4P4FeBZKQ4dsOOrpwOkB00M+Pe/q+bx8hXUICh8l+CRPsrqF5qVk
 o/HS1oVVPVNvlVUwbPNd5Ctri45fUQ+h9vouTer3rk7RPXh/hLuvk1nNZ
 FNByvbe/3kQFzmN0FD5TzaG+a2qJGXt1UcQm2aPpqaYbfZOFArwScU8Wv Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="424432596"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="424432596"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 23:38:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="798195854"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="798195854"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 23:37:55 -0800
Message-ID: <8b2800e3-989a-4c9f-b7e5-7b2e0702e3a0@intel.com>
Date: Thu, 30 Nov 2023 15:37:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/70] RAMBlock: Add support of KVM private guest memfd
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
 <20231115071519.2864957-3-xiaoyao.li@intel.com>
 <82ac9bf4-7463-48fc-b138-fcaa6314547f@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <82ac9bf4-7463-48fc-b138-fcaa6314547f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/20/2023 5:24 PM, David Hildenbrand wrote:
>>   uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
>>   {
>>       uint8_t mask = mr->dirty_log_mask;
>> diff --git a/system/physmem.c b/system/physmem.c
>> index fc2b0fee0188..0af2213cbd9c 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1841,6 +1841,20 @@ static void ram_block_add(RAMBlock *new_block, 
>> Error **errp)
>>           }
>>       }
>> +#ifdef CONFIG_KVM
>> +    if (kvm_enabled() && new_block->flags & RAM_GUEST_MEMFD &&
> 
> 
> I recall that we prefer to write this as
> 
>      if (kvm_enabled() && (new_block->flags & RAM_GUEST_MEMFD) &&

get it.

Thanks!

>> +        new_block->guest_memfd < 0) {
>> +        /* TODO: to decide if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is 
>> supported */
>> +        uint64_t flags = 0;
>> +        new_block->guest_memfd = 
>> kvm_create_guest_memfd(new_block->max_length,
>> +                                                        flags, errp);
> 
> Get rid of "flags" and just pass 0". Whatever code wants to pass flags 
> later can decide how to do that.


How to handle it please see the reply to patch 3.


