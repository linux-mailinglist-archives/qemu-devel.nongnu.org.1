Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3EDACCA3F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 17:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMTcb-00038P-0a; Tue, 03 Jun 2025 11:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMTcU-000386-Bj
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:32:07 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uMTcQ-0000O1-Tk
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748964723; x=1780500723;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FaKpJR92FYKwrFzDdNvsIRCSUqaTqILalsYWRqoVEog=;
 b=LrTiO3irV9XzXbu50f7FcI1ILjkR1l/fmfdi4JxXlrLOp0XvN3Yw/Taz
 yqITGEbmi5IVRcIvdbcFzpEZt1BDS06bNFRielJMQGJVRpja2Qv4sBj6B
 7Y8Y7ddV5ImPRhvWXeZxS4355F32e3YB5jX/vPES0GvymvO5b2M7pRcki
 41FETeD3t/GZKRgm6Ou8hXUqHHx5QJ8Hpuesu2bROMjQxRwXWRTItlpSo
 fYxM+Bfnm2elK59xnewOBUFx2v0riBAHE69Wrv25rFT30CMfH9daHRQbN
 D8KsmgZhGVxUTQPrcyiXw+4CshpT0OM/qFjaKekqgp5gziRCbzD0B1zZc Q==;
X-CSE-ConnectionGUID: lRnXTSVCRfWAtLMsMvG+lA==
X-CSE-MsgGUID: C/+yOaA3Sq+juNnrkkNrDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61632046"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="61632046"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:31:57 -0700
X-CSE-ConnectionGUID: kAyvpBaKQbOil1kptopFJA==
X-CSE-MsgGUID: 0LPSJby8Tfau3DHAS0PZqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="149669955"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 08:31:55 -0700
Message-ID: <9962b691-056e-4ee0-8345-5b5657c5376b@intel.com>
Date: Tue, 3 Jun 2025 23:31:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Prefault memory on page state change
To: Paolo Bonzini <pbonzini@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Michael Roth <michael.roth@amd.com>
References: <f5411c42340bd2f5c14972551edb4e959995e42b.1743193824.git.thomas.lendacky@amd.com>
 <4a757796-11c2-47f1-ae0d-335626e818fd@intel.com>
 <cc2dc418-8e33-4c01-9b8a-beca0a376400@intel.com>
 <d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <d0983ba3-383b-4c81-9cfd-b5b0d26a5d17@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.11; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 6/3/2025 11:00 PM, Paolo Bonzini wrote:
> On 6/3/25 13:47, Xiaoyao Li wrote:
>> On 6/3/2025 3:41 PM, Xiaoyao Li wrote:
>>> On 3/29/2025 4:30 AM, Tom Lendacky wrote:
>>>> A page state change is typically followed by an access of the 
>>>> page(s) and
>>>> results in another VMEXIT in order to map the page into the nested page
>>>> table. Depending on the size of page state change request, this can
>>>> generate a number of additional VMEXITs. For example, under SNP, when
>>>> Linux is utilizing lazy memory acceptance, memory is typically 
>>>> accepted in
>>>> 4M chunks. A page state change request is submitted to mark the 
>>>> pages as
>>>> private, followed by validation of the memory. Since the guest_memfd
>>>> currently only supports 4K pages, each page validation will result in
>>>> VMEXIT to map the page, resulting in 1024 additional exits.
>>>>
>>>> When performing a page state change, invoke KVM_PRE_FAULT_MEMORY for 
>>>> the
>>>> size of the page state change in order to pre-map the pages and 
>>>> avoid the
>>>> additional VMEXITs. This helps speed up boot times.
>>>
>>> Unfortunately, it breaks TDX guest.
>>>
>>>    kvm_hc_map_gpa_range gpa 0x80000000 size 0x200000 attributes 0x0 
>>> flags 0x1
>>>
>>> For TDX guest, it uses MAPGPA to maps the range [0x8000 0000, 
>>> +0x0x200000] to shared. The call of KVM_PRE_FAULT_MEMORY on such 
>>> range leads to the TD being marked as bugged
>>>
>>> [353467.266761] WARNING: CPU: 109 PID: 295970 at arch/x86/kvm/mmu/ 
>>> tdp_mmu.c:674 tdp_mmu_map_handle_target_level+0x301/0x460 [kvm]
>>
>> It turns out to be a KVM bug.
>>
>> The gpa passed in in KVM_PRE_FAULT_MEMORY, i.e., range->gpa has no 
>> indication for share vs. private. KVM directly passes range->gpa to 
>> kvm_tdp_map_page() in kvm_arch_vcpu_pre_fault_memory(), which is then 
>> assigned to fault.addr
>>
>> However, fault.addr is supposed to be a gpa of real access in TDX 
>> guest, which means it needs to have shared bit set if the map is for 
>> shared access, for TDX case. tdp_mmu_get_root_for_fault() will use it 
>> to determine which root to be used.
>>
>> For this case, the pre fault is on the shared memory, while the 
>> fault.addr leads to mirror_root which is for private memory. Thus it 
>> triggers KVM_BUG_ON().
> So this would fix it?
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7b3f1783ab3c..66f96476fade 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4895,6 +4895,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct 
> kvm_vcpu *vcpu,
>   {
>       u64 error_code = PFERR_GUEST_FINAL_MASK;
>       u8 level = PG_LEVEL_4K;
> +    u64 direct_bits;
>       u64 end;
>       int r;
> 
> @@ -4909,15 +4910,18 @@ long kvm_arch_vcpu_pre_fault_memory(struct 
> kvm_vcpu *vcpu,
>       if (r)
>           return r;
> 
> +    direct_bits = 0;
>       if (kvm_arch_has_private_mem(vcpu->kvm) &&
>           kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(range->gpa)))
>           error_code |= PFERR_PRIVATE_ACCESS;
> +    else
> +        direct_bits = kvm_gfn_direct_bits(vcpu->kvm);

should be

	direct_bits = gfn_to_gpa(kvm_gfn_direct_bits(vcpu->kvm));

> 
>       /*
>        * Shadow paging uses GVA for kvm page fault, so restrict to
>        * two-dimensional paging.
>        */
> -    r = kvm_tdp_map_page(vcpu, range->gpa, error_code, &level);
> +    r = kvm_tdp_map_page(vcpu, range->gpa | direct_bits, error_code, 
> &level);
>       if (r < 0)
>           return r;
> 
> 
> 
> I'm applying Tom's patch to get it out of his queue, but will delay sending
> a pull request until the Linux-side fix is accepted.

With above mentioned change, it can fix the issue.

Me synced with Yan offline, and our fix is:

diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
index 52acf99d40a0..209103bf0f30 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.h
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -48,7 +48,7 @@ static inline enum kvm_tdp_mmu_root_types 
kvm_gfn_range_filter_to_root_types(str
  static inline struct kvm_mmu_page *tdp_mmu_get_root_for_fault(struct 
kvm_vcpu *vcpu,
                                                               struct 
kvm_page_fault *fault)
  {
-       if (unlikely(!kvm_is_addr_direct(vcpu->kvm, fault->addr)))
+       if (unlikely(fault->is_private))
                 return root_to_sp(vcpu->arch.mmu->mirror_root_hpa);

         return root_to_sp(vcpu->arch.mmu->root.hpa);

> Paolo
> 
> 


