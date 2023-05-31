Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD05717A6B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HQz-0002ES-4G; Wed, 31 May 2023 04:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQc-0002AX-7J
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:34 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1q4HQa-0005fO-Cp
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685522612; x=1717058612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KkICQLUL0N6wno1F6DhwOg202/VMAVLCyaivtde70OQ=;
 b=cItuCOca4j8pXAWixaItTHvtyE5I9ids7IGyTlvhdKTDTDyLFv7MhTX1
 TGGzXAgWszFhPUu6XFwCROBJx7Q47FStKNHu7BskYYq7ThkkGxMKLvZ8m
 0JqjQVol9V/N/ww4SPmltA4Vo96vdoswQtSv7Oa7/mJI1g6fVK0x9w/cD
 A7hlww6f2+Edgx7HeR5Ja52z0N8BLA/EjjQCPaMnbdEvK2herR/GdHaTu
 v+Oji16PoywlzNSpptCwyhawQ60Hy1ZEo9Op7UOCuWblml1+LjgR5UNyh
 bFjfl/Klmog7VyODYD0o2koHw/WO2uIc3comk0dj2CvwzGtJGuxz9g1ln g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="418669318"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="418669318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 01:43:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="1036956500"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="1036956500"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by fmsmga005.fm.intel.com with ESMTP; 31 May 2023 01:43:30 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chenyi Qiang <chenyi.qiang@intel.com>, lei4.wang@intel.com
Subject: [PATCH v4 8/8] target/i386/intel-pt: Access MSR_IA32_RTIT_ADDRn based
 on guest CPUID configuration
Date: Wed, 31 May 2023 04:43:11 -0400
Message-Id: <20230531084311.3807277-9-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531084311.3807277-1-xiaoyao.li@intel.com>
References: <20230531084311.3807277-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=xiaoyao.li@intel.com;
 helo=mga06.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
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

KVM only allows userspace to access legal number of MSR_IA32_RTIT_ADDRn,
which is enumrated by guest's CPUID(0x14,0x1):EAX[2:0], i.e.,
env->features[FEAT_14_1_EAX] & INTEL_PT_ADDR_RANGES_NUM_MASK

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/cpu.h     | 2 ++
 target/i386/kvm/kvm.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 71b83102b75e..d745ba2ad77a 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -973,6 +973,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* Packets which contain IP payload have LIP values */
 #define CPUID_14_0_ECX_LIP                      (1U << 31)
 
+#define INTEL_PT_ADDR_RANGES_NUM_MASK       0x7
+
 /* CLZERO instruction */
 #define CPUID_8000_0008_EBX_CLZERO      (1U << 0)
 /* Always save/restore FP error pointers */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6b1..e68846100ddb 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3561,8 +3561,8 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             }
         }
         if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
-            int addr_num = kvm_arch_get_supported_cpuid(kvm_state,
-                                                    0x14, 1, R_EAX) & 0x7;
+            int addr_num = env->features[FEAT_14_1_EAX] &
+                           INTEL_PT_ADDR_RANGES_NUM_MASK;
 
             kvm_msr_entry_add(cpu, MSR_IA32_RTIT_CTL,
                             env->msr_rtit_ctrl);
@@ -4004,8 +4004,8 @@ static int kvm_get_msrs(X86CPU *cpu)
     }
 
     if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
-        int addr_num =
-            kvm_arch_get_supported_cpuid(kvm_state, 0x14, 1, R_EAX) & 0x7;
+        int addr_num = env->features[FEAT_14_1_EAX] &
+                       INTEL_PT_ADDR_RANGES_NUM_MASK;
 
         kvm_msr_entry_add(cpu, MSR_IA32_RTIT_CTL, 0);
         kvm_msr_entry_add(cpu, MSR_IA32_RTIT_STATUS, 0);
-- 
2.34.1


