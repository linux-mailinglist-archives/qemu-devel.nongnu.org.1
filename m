Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82879819069
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX5-00020f-3v; Tue, 19 Dec 2023 14:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWs-0001tK-Bv
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:22 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWq-0001oT-8v
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:22 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-336672406f0so2327770f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013199; x=1703617999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UUOmNDqY3LeEXA9yEVWqeU26I9B7AoztRHl6/x/doeU=;
 b=nEpdFvTd0HFI0VPBorSuT3HwbC5G8QbuOm2HJg2clGQAacuxzdoPKuqJZCowTAVauW
 A645dD0HEHNG6SoaeR/f+mwQD/ZU75Z0KTqAiEoWSPiEa4MLqph+tU+X3iahQZLrGdaA
 CJv7+4V19bp2MhlGnoe6XobYK/k2AVrEsSYaB/nI6bwUvEgiRFIgHJLBj7K02icn7aNQ
 dOY7BNj0A+Gf90lgrtN+2SN8/ZT8YBSQxSMGCHt5KWDMj4tXB7eccIeJd4/4sl7iukbL
 1xDxL+WISRHAX+Yz4v3YoyzXd1Vj8kxiJ8NbeRsn0JQTg2Fre9RcP7cDOhkg1syrWMfA
 yzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013199; x=1703617999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UUOmNDqY3LeEXA9yEVWqeU26I9B7AoztRHl6/x/doeU=;
 b=TXJ39MD2kpcm5L8BRiiJVNsX0dv3JZCOqgqAFCNcB/zaNw+elz39wGmgPIWt8Y9jrP
 6i4kOPogAUxb+tBNsANg3oPqdSjWOLeSAMJiAmr6vnrctElptI5dNVSFAuA8zOEFDfLb
 eVMCTpfATKyfPtZfdSa7L1eu/tamRuElKGeNGKdiygRDnslDa4DFxjNx8mTWgEq0/yDk
 kN4CGT6uCo9/RQPmeMwAgY5lZojrMbOeNdbumh3HTl0iEn4auP0EPumUkBH5mIlnH/Vq
 d0dvEnvQJRpRu3c+TEWUO+2nfvmpFC7uDjeSEC4eyXhUqZL2RqxK5vO89T1dO3BRep3G
 FzTw==
X-Gm-Message-State: AOJu0YwmkKvSnTFrcrYy1QfjCVkydaIqW+yOfiQYUy5yhhyv2jdHcN8W
 y7x4xYprDErNtWXXHgTHMBtvdmKvZsQw0r5Zz0Y=
X-Google-Smtp-Source: AGHT+IE0FVQLV1HxgvzE+vEqOZf0wkl3wc18rI3tUsotGVgw2jUzqHpnDONm9kzR0EOVSZy5Ak+lAQ==
X-Received: by 2002:adf:b301:0:b0:336:782b:ab8b with SMTP id
 j1-20020adfb301000000b00336782bab8bmr114238wrd.61.1703013198825; 
 Tue, 19 Dec 2023 11:13:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/43] target/arm/kvm: Unexport and tidy
 kvm_arm_sync_mpstate_to_{kvm, qemu}
Date: Tue, 19 Dec 2023 19:12:44 +0000
Message-Id: <20231219191307.2895919-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Drop fprintfs and actually use the return values in the callers.
This is OK to do since commit 7191f24c7fcf which added the
error-check to the generic accel/kvm functions that eventually
call into these ones.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: tweak commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 20 --------------------
 target/arm/kvm.c     | 23 ++++++-----------------
 2 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b4339d49d11..8a44a6b762f 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -200,26 +200,6 @@ bool kvm_arm_sve_supported(void);
  */
 int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa);
 
-/**
- * kvm_arm_sync_mpstate_to_kvm:
- * @cpu: ARMCPU
- *
- * If supported set the KVM MP_STATE based on QEMU's model.
- *
- * Returns 0 on success and -1 on failure.
- */
-int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu);
-
-/**
- * kvm_arm_sync_mpstate_to_qemu:
- * @cpu: ARMCPU
- *
- * If supported get the MP_STATE from KVM and store in QEMU's model.
- *
- * Returns 0 on success and aborts on failure.
- */
-int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu);
-
 void kvm_arm_vm_state_change(void *opaque, bool running, RunState state);
 
 int kvm_arm_vgic_probe(void);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b8923fe1776..db6d208cf03 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1004,41 +1004,32 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
 /*
  * Update KVM's MP_STATE based on what QEMU thinks it is
  */
-int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu)
+static int kvm_arm_sync_mpstate_to_kvm(ARMCPU *cpu)
 {
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state = {
             .mp_state = (cpu->power_state == PSCI_OFF) ?
             KVM_MP_STATE_STOPPED : KVM_MP_STATE_RUNNABLE
         };
-        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
-        if (ret) {
-            fprintf(stderr, "%s: failed to set MP_STATE %d/%s\n",
-                    __func__, ret, strerror(-ret));
-            return -1;
-        }
+        return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
     }
-
     return 0;
 }
 
 /*
  * Sync the KVM MP_STATE into QEMU
  */
-int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
+static int kvm_arm_sync_mpstate_to_qemu(ARMCPU *cpu)
 {
     if (cap_has_mp_state) {
         struct kvm_mp_state mp_state;
         int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MP_STATE, &mp_state);
         if (ret) {
-            fprintf(stderr, "%s: failed to get MP_STATE %d/%s\n",
-                    __func__, ret, strerror(-ret));
-            abort();
+            return ret;
         }
         cpu->power_state = (mp_state.mp_state == KVM_MP_STATE_STOPPED) ?
             PSCI_OFF : PSCI_ON;
     }
-
     return 0;
 }
 
@@ -2182,9 +2173,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    kvm_arm_sync_mpstate_to_kvm(cpu);
-
-    return ret;
+    return kvm_arm_sync_mpstate_to_kvm(cpu);
 }
 
 static int kvm_arch_get_fpsimd(CPUState *cs)
@@ -2365,7 +2354,7 @@ int kvm_arch_get_registers(CPUState *cs)
      */
     write_list_to_cpustate(cpu);
 
-    kvm_arm_sync_mpstate_to_qemu(cpu);
+    ret = kvm_arm_sync_mpstate_to_qemu(cpu);
 
     /* TODO: other registers */
     return ret;
-- 
2.34.1


