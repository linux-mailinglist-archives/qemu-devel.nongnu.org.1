Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212ED76A68D
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQeSW-0000JW-Ez; Mon, 31 Jul 2023 21:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQeSR-0000IL-JH
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:45:55 -0400
Received: from [134.134.136.65] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQeSP-000892-EM
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690854353; x=1722390353;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=q3HqSAdiGDjuRHnjIkqW8UXAdbng499ewzU4TwytHbE=;
 b=fLxi81hS8lurF0rU90tNQFqyJXmxNilUIi8NrAQ+INVTDPwS0j1th1XX
 qorA+ELlD29UgOk9p8yB31KJxH2I/jXhsyl+1bZAN6hUfj4Dq6dAMKGTN
 apA3a3wKU87xB/Q9nwuEUAwITiFnXSlzb2XV7JzpH6j+kkAEQyGF/bvtc
 U4cZz4tUgWJO0LpAFNa9HD440XCZqmk7ABR3StvblPCI7o1PgyTUbvR/x
 ducJIHMDP7lpph59wUvStgGgdT87Wac90MVqHEeCtOLGAaT6uSk5CgwzO
 qr/VAQD7XWsXUS8BbGdjAlu+EJG0BDprfRfWtlyW0qJfo+lrY3CtRhXlr g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372798284"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="372798284"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 18:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798465973"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="798465973"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.6.77])
 ([10.93.6.77])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 18:45:44 -0700
Message-ID: <9b3a3e88-21f4-bfd2-a9c3-60a25832e698@intel.com>
Date: Tue, 1 Aug 2023 09:45:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 00/19] QEMU gmem implemention
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <ZMfmkCQImgsinE6T@redhat.com>
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ZMfmkCQImgsinE6T@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.65 (failed)
Received-SPF: pass client-ip=134.134.136.65; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, NICE_REPLY_A=-0.101,
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

On 8/1/2023 12:51 AM, Daniel P. Berrangé wrote:
> On Mon, Jul 31, 2023 at 12:21:42PM -0400, Xiaoyao Li wrote:
>> This is the first RFC version of enabling KVM gmem[1] as the backend for
>> private memory of KVM_X86_PROTECTED_VM.
>>
>> It adds the support to create a specific KVM_X86_PROTECTED_VM type VM,
>> and introduces 'private' property for memory backend. When the vm type
>> is KVM_X86_PROTECTED_VM and memory backend has private enabled as below,
>> it will call KVM gmem ioctl to allocate private memory for the backend.
>>
>>      $qemu -object memory-backend-ram,id=mem0,size=1G,private=on \
>>            -machine q35,kvm-type=sw-protected-vm,memory-backend=mem0 \
>> 	  ...
>>
>> Unfortunately this patch series fails the boot of OVMF at very early
>> stage due to triple fault because KVM doesn't support emulate string IO
>> to private memory. We leave it as an open to be discussed.
>>
>> There are following design opens that need to be discussed:
>>
>> 1. how to determine the vm type?
>>
>>     a. like this series, specify the vm type via machine property
>>        'kvm-type'
>>     b. check the memory backend, if any backend has 'private' property
>>        set, the vm-type is set to KVM_X86_PROTECTED_VM.
>>
>> 2. whether 'private' property is needed if we choose 1.b as design
>>
>>     with 1.b, QEMU can decide whether the memory region needs to be
>>     private (allocates gmem fd for it) or not, on its own.
>>
>> 3. What is KVM_X86_SW_PROTECTED_VM going to look like? What's the
>>     purose of it and what's the requirement on it. I think it's the
>>     questions for KVM folks than QEMU folks.
>>
>> Any other idea/open/question is welcomed.
>>
>>
>> Beside, TDX QEMU implemetation is based on this series to provide
>> private gmem for TD private memory, which can be found at [2].
>> And it can work corresponding KVM [3] to boot TDX guest.
> 
> We already have a general purpose configuration mechanism for
> confidential guests.  The -machine argument has a property
> confidential-guest-support=$OBJECT-ID, for pointing to an
> object that implements the TYPE_CONFIDENTIAL_GUEST_SUPPORT
> interface in QEMU. This is implemented with SEV, PPC PEF
> mode, and s390 protvirt.
> 
> I would expect TDX to follow this same design ie
> 
>      qemu-system-x86_64 \
>        -object tdx-guest,id=tdx0,..... \
>        -machine q35,confidential-guest-support=tdx0 \
>        ...
> 
> and not require inventing the new 'kvm-type' attribute at least.

yes.

TDX is initialized exactly as the above.

This RFC series introduces the 'kvm-type' for KVM_X86_SW_PROTECTED_VM. 
It's my fault that forgot to list the option of introducing 
sw_protected_vm object with CONFIDENTIAL_GUEST_SUPPORT interface.
Thanks for Isaku to raise it 
https://lore.kernel.org/qemu-devel/20230731171041.GB1807130@ls.amr.corp.intel.com/

we can specify KVM_X86_SW_PROTECTED_VM this way:

qemu  \
   -object sw-protected,id=swp0,... \
   -machine confidential-guest-support=swp0 \
   ...

> For the memory backend though, I'm not so sure - possibly that
> might be something that still wants an extra property to identify
> the type of memory to allocate, since we use memory-backend-ram
> for a variety of use cases.  Or it could be an entirely new object
> type such as "memory-backend-gmem"

What I want to discuss is whether providing the interface to users to 
allow them configuring which memory is/can be private. For example, QEMU 
can do it internally. If users wants a confidential guest, QEMU 
allocates private gmem for normal RAM automatically.



