Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A054F9EDEB8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 06:19:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLbaj-0007Vi-QN; Thu, 12 Dec 2024 00:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1tLbaf-0007VU-S2
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 00:18:21 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1tLbac-0004Al-64
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 00:18:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733980698; x=1765516698;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=dugcJKA6XIHtmk4l+Lj2z0oS3nv9cLyv9kh2TLQdnzU=;
 b=MY8lZOQ1pb6xX352a0cq1na4Z9jdbWR0qL8oF4VvJXQqo0bEcXHvN1g9
 S3nW6/+AfoJsV4Q4WCl82Crw6Of3+ktNMC6NfE6bmhI09GEIEk/QDbGI4
 69K5pIkhXBi42MFT76BwPgnid/0MVf4qUIuBnsuxqNoQNUFNqZKKbl1Td
 76ctNQGY02xWBATHO8Wg9zmaZ6HWrnc/19ZpvPOcfOv6MbiIYhZhlvSBz
 5175y6p/E/qHY7Y3NKUlu4c5uUSWe7WDR2EAOw8Okn0dbJpyVtLv3Ofe9
 O1arp28mVRq2ecuESuHpix6mU8Xil66zYN5kYCCVDe2W3jx2GtiDmzlgH w==;
X-CSE-ConnectionGUID: HFKPV8lVQKWYtZNM96CWuA==
X-CSE-MsgGUID: slE/Kz+2TqyFIBT7S/KUVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="37224574"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; d="scan'208";a="37224574"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 21:18:14 -0800
X-CSE-ConnectionGUID: TuGYZe1JT2qe/62g3wFttA==
X-CSE-MsgGUID: 9LZCchpGT0ODsaQKS0nTUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="133484581"
Received: from unknown (HELO [10.238.0.149]) ([10.238.0.149])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Dec 2024 21:18:12 -0800
Message-ID: <72e1da62-5fd2-4633-b304-24be3dac1e7f@linux.intel.com>
Date: Thu, 12 Dec 2024 13:18:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Set return value after handling
 KVM_EXIT_HYPERCALL
To: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Cc: seanjc@google.com, michael.roth@amd.com, rick.p.edgecombe@intel.com,
 isaku.yamahata@intel.com, farrah.chen@intel.com, kvm@vger.kernel.org
References: <20241212032628.475976-1-binbin.wu@linux.intel.com>
 <2144c2c0-4a5d-4efd-b5e2-f2b4096c08b5@intel.com>
Content-Language: en-US
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <2144c2c0-4a5d-4efd-b5e2-f2b4096c08b5@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.13;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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




On 12/12/2024 11:44 AM, Xiaoyao Li wrote:
> On 12/12/2024 11:26 AM, Binbin Wu wrote:
>> Userspace should set the ret field of hypercall after handling
>> KVM_EXIT_HYPERCALL.  Otherwise, a stale value could be returned to KVM.
>>
>> Fixes: 47e76d03b15 ("i386/kvm: Add KVM_EXIT_HYPERCALL handling for KVM_HC_MAP_GPA_RANGE")
>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>> ---
>> To test the TDX code in kvm-coco-queue, please apply the patch to the QEMU,
>> otherwise, TDX guest boot could fail.
>> A matching QEMU tree including this patch is here:
>> https://github.com/intel-staging/qemu-tdx/releases/tag/tdx-qemu-upstream-v6.1-fix_kvm_hypercall_return_value
>>
>> Previously, the issue was not triggered because no one would modify the ret
>> value. But with the refactor patch for __kvm_emulate_hypercall() in KVM,
>> https://lore.kernel.org/kvm/20241128004344.4072099-7-seanjc@google.com/, the
>> value could be modified.
>> ---
>>   target/i386/kvm/kvm.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 8e17942c3b..4bcccb48d1 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -6005,10 +6005,14 @@ static int kvm_handle_hc_map_gpa_range(struct kvm_run *run)
>>     static int kvm_handle_hypercall(struct kvm_run *run)
>>   {
>> +    int ret = -EINVAL;
>> +
>>       if (run->hypercall.nr == KVM_HC_MAP_GPA_RANGE)
>> -        return kvm_handle_hc_map_gpa_range(run);
>> +        ret = kvm_handle_hc_map_gpa_range(run);
>> +
>> +    run->hypercall.ret = ret;
>
> Updating run->hypercall.ret is useful only when QEMU needs to re-enter the guest. For the case of ret < 0, QEMU will stop the vcpu.

IMHO, assign run->hypercall.ret anyway should be OK, no need to add a
per-condition on ret, although the value is not used when ret < 0.

Currently, since QEMU will stop the vcpu when ret < 0, this patch doesn't
convert ret to -Exxx that the ABI expects.

>
> I think we might need re-think on the handling of KVM_EXIT_HYPERCALL. E.g., in what error case should QEMU stop the vcpu, and in what case can QEMU return the error back to the guest via run->hypercall.ret.

Actually, I had the similar question before.
https://lore.kernel.org/kvm/d25cc62c-0f56-4be2-968a-63c8b1d63b5a@linux.intel.com/

It might depends on the hypercall number?
Another option is QEMU always sets run->hypercall.ret appropriately and continues the vcpu thread.


>
>> -    return -EINVAL;
>> +    return ret;
>>   }
>>     #define VMX_INVALID_GUEST_STATE 0x80000021
>>
>> base-commit: ae35f033b874c627d81d51070187fbf55f0bf1a7
>


