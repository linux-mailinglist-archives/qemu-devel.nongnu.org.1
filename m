Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51E07A147C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 05:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgzeJ-0000TX-V2; Thu, 14 Sep 2023 23:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgzeH-0000TP-7L
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 23:37:41 -0400
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgzeD-0003qr-Rw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 23:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694749057; x=1726285057;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PEq7BbJOpK/YDddrwIkD9257uy7E4R+5/3E5LkWOrPc=;
 b=KW/B6UE6UC/RK7kIYQYWBeZ76ORQ36uaNFF/E1ZLh0BjIVZQYVFqjTGD
 Bosl3s+P9LD5vvk51NLORROL523UPSkcMRZq8+lIldGB3h2Ii8JJaBqRA
 /29B2Y9U1FGXsZ5eK5zl8njFFfxBYft0gPXZem1XdZUBlz9vUSPsFKGQi
 tNZtswVstATQ+NY1VBW6tU7k4lYeMNQ8FSTNx7yAgdV83Aut077yiZFI7
 AL08tMplq9oBrvUK/S9+E2+2BAZe2CoGyWblRBaJGXBJJlFsmXcwIb7US
 h8KcPDSq3wxTEZY1eiicX7aTXIZ2extiYlh46C04bseVQwdQMI/UJ+Z2A w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="379066316"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; d="scan'208";a="379066316"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 20:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="888055878"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; d="scan'208";a="888055878"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.93.29.154])
 ([10.93.29.154])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 20:36:54 -0700
Message-ID: <a8cf6824-4228-8de5-0727-96ea6c5bad36@intel.com>
Date: Fri, 15 Sep 2023 11:37:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 00/21] QEMU gmem implemention
To: David Hildenbrand <david@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <fe9f3d19-df01-01e6-a253-f7fe5bdea41f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
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

On 9/14/2023 9:09 PM, David Hildenbrand wrote:
> On 14.09.23 05:50, Xiaoyao Li wrote:
>> It's the v2 RFC of enabling KVM gmem[1] as the backend for private
>> memory.
>>
>> For confidential-computing, KVM provides gmem/guest_mem interfaces for
>> userspace, like QEMU, to allocate user-unaccesible private memory. This
>> series aims to add gmem support in QEMU's RAMBlock so that each RAM can
>> have both hva-based shared memory and gmem_fd based private memory. QEMU
>> does the shared-private conversion on KVM_MEMORY_EXIT and discards the
>> memory.
>>
>> It chooses the design that adds "private" property to hostmeory backend.
>> If "private" property is set, QEMU will allocate/create KVM gmem when
>> initialize the RAMbloch of the memory backend.
>>
>> This sereis also introduces the first user of kvm gmem,
>> KVM_X86_SW_PROTECTED_VM. A KVM_X86_SW_PROTECTED_VM with private KVM gmem
>> can be created with
>>
>>    $qemu -object sw-protected-vm,id=sp-vm0 \
>>     -object memory-backend-ram,id=mem0,size=1G,private=on \
>>     -machine 
>> q35,kernel_irqchip=split,confidential-guest-support=sp-vm0,memory-backend=mem0 \
>>     ...
>>
>> Unfortunately this patch series fails the boot of OVMF at very early
>> stage due to triple fault, because KVM doesn't support emulating 
>> string IO
>> to private memory.
> 
> Is support being added? Or have we figured out what it would take to 
> make it work?

Hi David,

I only reply the questions that werrn't covered by Sean's reply.

> How does this interact with other features (memory ballooning, virtiofs, 
> vfio/mdev/...)?

I need time to learn them before I can answer it.

>>
>> This version still leave some opens to be discussed:
>> 1. whether we need "private" propery to be user-settable?
>>
>>     It seems unnecessary because vm-type is determined. If the VM is
>>     confidential-guest, then the RAM of the guest must be able to be
>>     mapped as private, i.e., have kvm gmem backend. So QEMU can
>>     determine the value of "private" property automatiacally based on vm
>>     type.
>>
>>     This also aligns with the board internal MemoryRegion that needs to
>>     have kvm gmem backend, e.g., TDX requires OVMF to act as private
>>     memory so bios memory region needs to have kvm gmem fd associated.
>>     QEMU no doubt will do it internally automatically.
> 
> Would it make sense to have some regions without "pivate" semantics? 
> Like NVDIMMs?

Of course it can have regions without "private" semantics.

Whether a region needs "private" backend depends on the definition of VM 
type. E.g., for TDX,
  - all the RAM needs to able to mapped as private. So it needs private 
gmem.
  - TDVF(OVMF) code must be mapped as private. So it needs private gmem.
  - MMIO region needs to be shared for TDX 1.0, and it doesn't need 
private gmem;

>>
>> 2. hugepage support.
>>
>>     KVM gmem can be allocated from hugetlbfs. How does QEMU determine
>>     when to allocate KVM gmem with KVM_GUEST_MEMFD_ALLOW_HUGEPAGE. The
>>     easiest solution is create KVM gmem with 
>> KVM_GUEST_MEMFD_ALLOW_HUGEPAGE
>>     only when memory backend is HostMemoryBackendFile of hugetlbfs.
> 
> Good question.
> 
> Probably "if the memory backend uses huge pages, also use huge pages for 
> the private gmem" makes sense.
> 
> ... but it becomes a mess with preallocation ... which is what people 
> should actually be using with hugetlb. Andeventual double 
> memory-consumption ... but maybe that's all been taken care of already?
> 
> Probably it's best to leave hugetlb support as future work and start 
> with something minimal.
> 

As Sean replied, I had some misunderstanding of 
KVM_GUEST_MEMFD_ALLOW_HUGEPAGE. If it's for THP, I think we can allow it 
for every gmem.

As for hugetlb, we can leave it as future work.


