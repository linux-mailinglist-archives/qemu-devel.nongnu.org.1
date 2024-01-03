Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C3822A43
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 10:26:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKxVL-0002n1-07; Wed, 03 Jan 2024 04:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rKxVD-0002l8-9n
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:25:31 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1rKxVB-0003S1-2T
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704273929; x=1735809929;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qg5DqPfqY1spw2/swDgcPg10+0r62nU0nm9TnH6NbMA=;
 b=aZ1DWRVgSUVAwEqNME+1pw0UUMPKJGEZKOfr2F8MpIwEeiMG+p6BQF7C
 r1Z8x2FMeLKDH49LPIuKVr40FNzsfB2Y/K9xKdSIoWpJ3dH9Yy3CuFNCc
 fUrS23yxeMDLi1ydi8hMVYecLJko0WZ7ctiXShSuKWwHjnhOZwehUvC95
 6dTsKWoDv3XdvxZVjYTASVA4achy1nC7Dq/KophprxyEZewWn8Bau1AqT
 LgruVcWRo7fz5D0Oae/rtjs2NeEZipOhH1Tkyuidik+z991ujoCyDGhuz
 7xczroY4miu3VF0asrTYtSbah9uH8cNHNB2Y1AD2HBHz4F+aC6fcXrZ92 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="461295246"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="461295246"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 01:25:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111313896"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="1111313896"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.238.9.51])
 ([10.238.9.51])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 01:25:22 -0800
Message-ID: <a6505d3b-5850-45ac-9439-14b6fd9b8138@linux.intel.com>
Date: Wed, 3 Jan 2024 17:25:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/i386: add control bits support for LAM
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, chao.gao@intel.com,
 robert.hu@linux.intel.com
References: <20230721080800.2329-1-binbin.wu@linux.intel.com>
 <20230721080800.2329-3-binbin.wu@linux.intel.com>
 <634d2f1e-f7b0-491d-979e-99609b79a955@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <634d2f1e-f7b0-491d-979e-99609b79a955@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=binbin.wu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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



On 12/28/2023 4:51 PM, Xiaoyao Li wrote:
> On 7/21/2023 4:08 PM, Binbin Wu wrote:
>> LAM uses CR3[61] and CR3[62] to configure/enable LAM on user pointers.
>> LAM uses CR4[28] to configure/enable LAM on supervisor pointers.
>>
>> For CR3 LAM bits, no additional handling needed:
>> - TCG
>>    LAM is not supported for TCG of target-i386. helper_write_crN() 
>> and helper_vmrun()
>>    check max physical address bits before calling 
>> cpu_x86_update_cr3(), no change needed,
>>    i.e. CR3 LAM bits are not allowed to be set in TCG.
>> - gdbstub
>>    x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to 
>> update cr3. Allow gdb
>>    to set the LAM bit(s) to CR3, if vcpu doesn't support LAM, 
>> KVM_SET_SREGS will fail as
>>    other CR3 reserved bits.
>>
>> For CR4 LAM bit, its reservation depends on vcpu supporting LAM 
>> feature or not.
>> - TCG
>>    LAM is not supported for TCG of target-i386. helper_write_crN() 
>> and helper_vmrun()
>>    check CR4 reserved bit before calling cpu_x86_update_cr4(), i.e. 
>> CR4 LAM bit is not
>>    allowed to be set in TCG.
>> - gdbstub
>>    x86_cpu_gdb_write_register() will call cpu_x86_update_cr4() to 
>> update cr4. Allow gdb
>>    to set the LAM bit to CR4, if vcpu doesn't support LAM, 
>> KVM_SET_SREGS will fail.
>
> I would go follow the current code, to mask out LAM bit if no CPUID.

I can do it in the next version.

But I am curious what's the rule of masking out a CR4 bit if no CPUID
in cpu_x86_update_cr4()?
e.g. current code checks SMAP but not SMEP.


>
>> - x86_cpu_reset_hold() doesn't need special handling.
>>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> ---
>>   target/i386/cpu.h | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 4db97899fe..710fadf550 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -261,6 +261,7 @@ typedef enum X86Seg {
>>   #define CR4_SMAP_MASK   (1U << 21)
>>   #define CR4_PKE_MASK   (1U << 22)
>>   #define CR4_PKS_MASK   (1U << 24)
>> +#define CR4_LAM_SUP_MASK (1U << 28)
>>     #define CR4_RESERVED_MASK \
>>   (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
>> @@ -269,7 +270,8 @@ typedef enum X86Seg {
>>                   | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | 
>> CR4_UMIP_MASK \
>>                   | CR4_LA57_MASK \
>>                   | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | 
>> CR4_OSXSAVE_MASK \
>> -                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | 
>> CR4_PKS_MASK))
>> +                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | 
>> CR4_PKS_MASK \
>> +                | CR4_LAM_SUP_MASK))
>>     #define DR6_BD          (1 << 13)
>>   #define DR6_BS          (1 << 14)
>> @@ -2478,6 +2480,9 @@ static inline uint64_t 
>> cr4_reserved_bits(CPUX86State *env)
>>       if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
>>           reserved_bits |= CR4_PKS_MASK;
>>       }
>> +    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
>> +        reserved_bits |= CR4_LAM_SUP_MASK;
>> +    }
>>       return reserved_bits;
>>   }
>


