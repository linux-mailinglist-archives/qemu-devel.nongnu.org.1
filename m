Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAF97FEAB4
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 09:33:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8cSs-0000Ah-3H; Thu, 30 Nov 2023 03:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8cSl-000081-KU
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:32:01 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r8cSj-000851-8K
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 03:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701333117; x=1732869117;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ysZ3/9er4by0oGguDKTL7b7QQM3l5NmKPgsTSrYiT1o=;
 b=A0HEWnvp49BxVVxO/w62xHVPGyb+Yckw5lEH5BK6O7XI99doj/zGLcb3
 VmB2LutrEzu1xuwxV7u1Fvo+l1Rg00uyAZBcDqc/r1Jdtj0ULvsFLXvv3
 yRo4Myd8X1uQ+TnPQgZ/hH2qGxmC3mRNsx8QjrE9G4ogd1bKyZaGg5GFu
 2vPAMoAA4tO7oSZlWgc7C0KPs688OeGkefU39b3i1AkzHkhsL9pFBoVBi
 e0NJPokzk1Xf1aHHoCazDNAm1uZck6ja0v90bJtLQCD4kqKFTo8dl4M7d
 a/G0i6qmmQmP2MAgxAx75diFzkvvnavxrV5J8lsRY/m4Bywi5LK7uolWs w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="11995697"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="11995697"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2023 00:31:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="772982457"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; d="scan'208";a="772982457"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2023 00:31:46 -0800
Message-ID: <e6f52c81-0be6-4e37-8da3-0a3411d6f2c6@intel.com>
Date: Thu, 30 Nov 2023 16:31:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/70] RAMBlock: Add support of KVM private guest memfd
Content-Language: en-US
To: Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@intel.com
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-3-xiaoyao.li@intel.com>
 <20231117203528.GA1645850@ls.amr.corp.intel.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20231117203528.GA1645850@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.9; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/18/2023 4:35 AM, Isaku Yamahata wrote:
> On Wed, Nov 15, 2023 at 02:14:11AM -0500,
> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
> 
>> diff --git a/system/physmem.c b/system/physmem.c
>> index fc2b0fee0188..0af2213cbd9c 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1841,6 +1841,20 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>           }
>>       }
>>   
>> +#ifdef CONFIG_KVM
>> +    if (kvm_enabled() && new_block->flags & RAM_GUEST_MEMFD &&
>> +        new_block->guest_memfd < 0) {
>> +        /* TODO: to decide if KVM_GUEST_MEMFD_ALLOW_HUGEPAGE is supported */
>> +        uint64_t flags = 0;
>> +        new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
>> +                                                        flags, errp);
>> +        if (new_block->guest_memfd < 0) {
>> +            qemu_mutex_unlock_ramlist();
>> +            return;
>> +        }
>> +    }
>> +#endif
>> +
> 
> We should define kvm_create_guest_memfd() stub in accel/stub/kvm-stub.c.
> We can remove this #ifdef.

Nice suggestion! Will use stub.

