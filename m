Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E637471914C
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:27:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Yx4-0002Y9-KO; Wed, 31 May 2023 23:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1q4Yx1-0002Xv-IH
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:26:11 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <binbin.wu@linux.intel.com>)
 id 1q4Ywy-0004nz-MO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685589968; x=1717125968;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Ih1cVWK+K1uz26FQzwnmxM9d6xM/JFh2ir/BF0NEtrs=;
 b=iCU70vU1Z5Zypc5VMN7MtOhkNZbwr/vcGInVUYauqdmM3M6DOR9t69hu
 KpERvWU/FQKzbP5lFcWgHYXSlvswyKYm8M1imzm45/vpY5T+D2QHETJMf
 xEKkr9IGSMgCD+ItOmzML9tEHjaOsmbg6II9bxndKZXXTUeTYIFxCwb27
 0BerxXdcA4yKQePiB80pcQVs47+0lvgNZ7Z8MzPP/oGfFAwC8tc6Ubv3e
 kNQqhvilcvje5qCDKT2cQcsRU5eR/vusHePBLGBPs+hqcmVOkeERFVf3P
 zHWdHYutA38QfHRv9jVLuIv8ASBjDQiCN2hG/G+kk3IxfHW+a6qmvkZKj Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="418939157"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="418939157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 20:26:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="819577557"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="819577557"
Received: from binbinwu-mobl.ccr.corp.intel.com (HELO [10.254.214.104])
 ([10.254.214.104])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 20:26:03 -0700
Message-ID: <abb80625-3c0f-d2a8-b4c9-547ca4c41a7e@linux.intel.com>
Date: Thu, 1 Jun 2023 11:26:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 1/1] target/i386: add support for LAM in CPUID
 enumeration
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, chao.gao@intel.com,
 robert.hu@linux.intel.com
References: <20230531013250.18311-1-binbin.wu@linux.intel.com>
 <20230531013250.18311-2-binbin.wu@linux.intel.com>
 <48b25232-b487-e056-92c0-a6c2d02e61fe@intel.com>
From: Binbin Wu <binbin.wu@linux.intel.com>
In-Reply-To: <48b25232-b487-e056-92c0-a6c2d02e61fe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.31;
 envelope-from=binbin.wu@linux.intel.com; helo=mga06.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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


On 5/31/2023 11:45 AM, Xiaoyao Li wrote:
> On 5/31/2023 9:32 AM, Binbin Wu wrote:
>> From: Robert Hoo <robert.hu@linux.intel.com>
>>
>> Linear Address Masking (LAM) is a new Intel CPU feature, which allows 
>> software
>> to use of the untranslated address bits for metadata.
>>
>> The bit definition:
>> CPUID.(EAX=7,ECX=1):EAX[26]
>>
>> Add CPUID definition for LAM.
>>
>> More info can be found in Intel ISE Chapter "LINEAR ADDRESS MASKING 
>> (LAM)"
>> https://cdrdv2.intel.com/v1/dl/getContent/671368
>
> LAM defines new bits in CR3 and CR4. I think it needs corresponding 
> support in QEMU as well.

In QEMU, there are several callers call cpu_x86_update_{cr3,cr4}().

* target/i386/tcg
   If there is no objection, LAM feature will not be supported for TCG 
of target-i386.
   LAM CPUID bit will not be added to TCG_7_1_EAX_FEATURES.
   helper_write_crN() and helper_vmrun() check CR4 reserved bit before 
calling cpu_x86_update_cr4(),
   i.e. CR4 LAM bit is not allowed to be set in TCG.
   helper_write_crN() and helper_vmrun() check max physcial address bits 
before calling cpu_x86_update_cr3(),
   no change needed, i.e. CR3 LAM bits are not allowed to be set in TCG.
   About CR4 reserved bits, although QEMU code only uses 
cr4_reserved_bits() in target/i386/tcg,
   still want to do the following changes:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index eb800ba2e2..3946fe5393 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -261,6 +261,7 @@ typedef enum X86Seg {
  #define CR4_SMAP_MASK   (1U << 21)
  #define CR4_PKE_MASK   (1U << 22)
  #define CR4_PKS_MASK   (1U << 24)
+#define CR4_LAM_SUP_MASK (1U << 28)

  #define CR4_RESERVED_MASK \
  (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
@@ -269,7 +270,8 @@ typedef enum X86Seg {
                  | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                  | CR4_LA57_MASK \
                  | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | 
CR4_PKS_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | 
CR4_PKS_MASK \
+                | CR4_LAM_SUP_MASK))

  #define DR6_BD          (1 << 13)
  #define DR6_BS          (1 << 14)
@@ -2469,6 +2471,9 @@ static inline uint64_t 
cr4_reserved_bits(CPUX86State *env)
      if (!(env->features[FEAT_7_0_ECX] & CPUID_7_0_ECX_PKS)) {
          reserved_bits |= CR4_PKS_MASK;
      }
+    if (!(env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM)) {
+        reserved_bits |= CR4_LAM_SUP_MASK;
+    }
      return reserved_bits;
  }


* target/i386/gdbstub
   x86_cpu_gdb_write_register() will call cpu_x86_update_cr3() to update 
cr3/cr4.
   Allow gdb to set the LAM bit(s) to CR3/CR4, if vcpu doesn't support 
LAM, set sregs will fail in KVM.


* target/i386/cpu
   x86_cpu_reset_hold() will call cpu_x86_update_cr4() to reset cr4, it 
should be OK.


>
>> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
>> Co-developed-by: Binbin Wu <binbin.wu@linux.intel.com>
>> Signed-off-by: Binbin Wu <binbin.wu@linux.intel.com>
>> ---
>>   target/i386/cpu.c | 2 +-
>>   target/i386/cpu.h | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 1242bd541a..f4436b3657 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -881,7 +881,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>               "fsrc", NULL, NULL, NULL,
>>               NULL, NULL, NULL, NULL,
>>               NULL, "amx-fp16", NULL, "avx-ifma",
>> -            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, "lam", NULL,
>>               NULL, NULL, NULL, NULL,
>>           },
>>           .cpuid = {
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 7201a71de8..eb800ba2e2 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -924,6 +924,8 @@ uint64_t 
>> x86_cpu_get_supported_feature_word(FeatureWord w,
>>   #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
>>   /* Support for VPMADD52[H,L]UQ */
>>   #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
>> +/* Linear Address Masking */
>> +#define CPUID_7_1_EAX_LAM               (1U << 26)
>>     /* Support for VPDPB[SU,UU,SS]D[,S] */
>>   #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
>


