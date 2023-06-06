Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FAD723E58
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIl-0007fW-S3; Tue, 06 Jun 2023 05:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIe-0007a3-4w
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIZ-0004iV-Nr
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30e407daab5so2288616f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044898; x=1688636898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OLSFmZC5snF/XdPwTG399QLbog/h6pQA35TnsVfK/Vk=;
 b=en30TBPQ0D4pvGhZqX9ZhZKFFtnBIn9ZbI1Lb8NC5O4Hr8XJt7vDYnSxZXe4IH51Ln
 xSNN23PHktRjhVtj4Le3bu//ZYcCQDHEcCVDgyzPUHwcw873E4mXC/V5ZUGU/hQVjedd
 x+stGlldVwunE5j9pw5t2ryG5U5eUK+E1qUF3qp/sXMl3JqBMdATaJi4pXdgy3GnzqcD
 9d70bj85EGoTDeLQAPIcmlwI8wRyzefHvJs0ssp2LI99iIPePEFOwy74k9yevKsMy3eB
 zbnX5BBR+69npFmEjhOklgU2UddKYe/moZ2tngd5A29TL60hEeW0GHvDq0+47FkK+rLs
 M9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044898; x=1688636898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OLSFmZC5snF/XdPwTG399QLbog/h6pQA35TnsVfK/Vk=;
 b=dkpUxQWZ/+KQgqN6g5VwZPk+pXOUhzHOYEelPQRpnFryYWqI0iRfn+kY8xGKfo0bJE
 YFyGJE2uCPr+De2vsAcvRoZZzcEcopSLERn6skdneVjgAAzr0LnEumHkToElWxPnci00
 Ai6GVc0b8K1tb07LAJYbqxQ/75CMXqY0TRwfgIwuYTy+1ODjNSHFAE/RTWj+T4sVm+iV
 yF4NGS0B67EdU4c/CzSq8VebpOT7tp+pAK17YQuiYWKOIpKYN2CCNoryqf4zVTCZHD98
 g2W56taZEr6aqY6g0NLF8ZAWKNOWO8YJh9mjwWs8iIhj+zok+N7B2MUVM4aG8KLdijET
 wnmA==
X-Gm-Message-State: AC+VfDwEsOrToPtOuC3TWh+ztvOmd3N2iBLIn7+5P8CW+x0uT0XR4Pij
 dGL0IdV1oSBLWj/EFNE578eAK4luNx9/ezhy+MM=
X-Google-Smtp-Source: ACHHUZ7aOyZq2dmiS3r0cuC7IwKDVt1n7CXsDnGloVsHG+U0kk4V3KxgUu0WzkbVQaK1T7fiEH+2Bw==
X-Received: by 2002:adf:e58a:0:b0:30e:4266:14a4 with SMTP id
 l10-20020adfe58a000000b0030e426614a4mr1644958wrm.37.1686044898231; 
 Tue, 06 Jun 2023 02:48:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/42] hvf: add guest debugging handlers for Apple Silicon hosts
Date: Tue,  6 Jun 2023 10:47:36 +0100
Message-Id: <20230606094814.3581397-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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

From: Francesco Cagnin <fcagnin@quarkslab.com>

Guests can now be debugged through the gdbstub. Support is added for
single-stepping, software breakpoints, hardware breakpoints and
watchpoints. The code has been structured like the KVM counterpart.

While guest debugging is enabled, the guest can still read and write the
DBG*_EL1 registers but they don't have any effect.

Signed-off-by: Francesco Cagnin <fcagnin@quarkslab.com>
Message-id: 20230601153107.81955-5-fcagnin@quarkslab.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/hvf.h      |  15 ++
 include/sysemu/hvf_int.h  |   1 +
 target/arm/hvf_arm.h      |   7 +
 accel/hvf/hvf-accel-ops.c |  10 +
 accel/hvf/hvf-all.c       |   6 +
 target/arm/hvf/hvf.c      | 474 +++++++++++++++++++++++++++++++++++++-
 target/i386/hvf/hvf.c     |   9 +
 7 files changed, 520 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 386020a29cc..70549b91588 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -56,6 +56,21 @@ int hvf_arch_insert_hw_breakpoint(target_ulong addr, target_ulong len,
 int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len,
                                   int type);
 void hvf_arch_remove_all_hw_breakpoints(void);
+
+/*
+ * hvf_update_guest_debug:
+ * @cs: CPUState for the CPU to update
+ *
+ * Update guest to enable or disable debugging. Per-arch specifics will be
+ * handled by calling down to hvf_arch_update_guest_debug.
+ */
+int hvf_update_guest_debug(CPUState *cpu);
+void hvf_arch_update_guest_debug(CPUState *cpu);
+
+/*
+ * Return whether the guest supports debugging.
+ */
+bool hvf_arch_supports_guest_debug(void);
 #endif /* NEED_CPU_H */
 
 #endif
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 3592239fdcb..6ab119e49f7 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -54,6 +54,7 @@ struct hvf_vcpu_state {
     void *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
+    bool guest_debug_enabled;
 };
 
 void assert_hvf_ok(hv_return_t ret);
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 9a9d1a0bf59..e848c1d27d4 100644
--- a/target/arm/hvf_arm.h
+++ b/target/arm/hvf_arm.h
@@ -13,6 +13,13 @@
 
 #include "cpu.h"
 
+/**
+ * hvf_arm_init_debug() - initialize guest debug capabilities
+ *
+ * Should be called only once before using guest debug capabilities.
+ */
+void hvf_arm_init_debug(void);
+
 void hvf_arm_set_cpu_features_from_host(ARMCPU *cpu);
 
 #endif
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 92601b1369d..9c3da03c948 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -343,12 +343,18 @@ static int hvf_accel_init(MachineState *ms)
     return hvf_arch_init();
 }
 
+static inline int hvf_gdbstub_sstep_flags(void)
+{
+    return SSTEP_ENABLE | SSTEP_NOIRQ;
+}
+
 static void hvf_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "HVF";
     ac->init_machine = hvf_accel_init;
     ac->allowed = &hvf_allowed;
+    ac->gdbstub_supported_sstep_flags = hvf_gdbstub_sstep_flags;
 }
 
 static const TypeInfo hvf_accel_type = {
@@ -398,6 +404,8 @@ static int hvf_init_vcpu(CPUState *cpu)
     cpu->vcpu_dirty = 1;
     assert_hvf_ok(r);
 
+    cpu->hvf->guest_debug_enabled = false;
+
     return hvf_arch_init_vcpu(cpu);
 }
 
@@ -582,6 +590,8 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, void *data)
     ops->insert_breakpoint = hvf_insert_breakpoint;
     ops->remove_breakpoint = hvf_remove_breakpoint;
     ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
+    ops->update_guest_debug = hvf_update_guest_debug;
+    ops->supports_guest_debug = hvf_arch_supports_guest_debug;
 };
 static const TypeInfo hvf_accel_ops_type = {
     .name = ACCEL_OPS_NAME("hvf"),
diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index e983c23ad7f..754707dbfb3 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -61,3 +61,9 @@ int hvf_sw_breakpoints_active(CPUState *cpu)
 {
     return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
 }
+
+int hvf_update_guest_debug(CPUState *cpu)
+{
+    hvf_arch_update_guest_debug(cpu);
+    return 0;
+}
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bb83627727c..2bd0a35cbab 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -33,6 +33,116 @@
 
 #include "exec/gdbstub.h"
 
+#define MDSCR_EL1_SS_SHIFT  0
+#define MDSCR_EL1_MDE_SHIFT 15
+
+static uint16_t dbgbcr_regs[] = {
+    HV_SYS_REG_DBGBCR0_EL1,
+    HV_SYS_REG_DBGBCR1_EL1,
+    HV_SYS_REG_DBGBCR2_EL1,
+    HV_SYS_REG_DBGBCR3_EL1,
+    HV_SYS_REG_DBGBCR4_EL1,
+    HV_SYS_REG_DBGBCR5_EL1,
+    HV_SYS_REG_DBGBCR6_EL1,
+    HV_SYS_REG_DBGBCR7_EL1,
+    HV_SYS_REG_DBGBCR8_EL1,
+    HV_SYS_REG_DBGBCR9_EL1,
+    HV_SYS_REG_DBGBCR10_EL1,
+    HV_SYS_REG_DBGBCR11_EL1,
+    HV_SYS_REG_DBGBCR12_EL1,
+    HV_SYS_REG_DBGBCR13_EL1,
+    HV_SYS_REG_DBGBCR14_EL1,
+    HV_SYS_REG_DBGBCR15_EL1,
+};
+static uint16_t dbgbvr_regs[] = {
+    HV_SYS_REG_DBGBVR0_EL1,
+    HV_SYS_REG_DBGBVR1_EL1,
+    HV_SYS_REG_DBGBVR2_EL1,
+    HV_SYS_REG_DBGBVR3_EL1,
+    HV_SYS_REG_DBGBVR4_EL1,
+    HV_SYS_REG_DBGBVR5_EL1,
+    HV_SYS_REG_DBGBVR6_EL1,
+    HV_SYS_REG_DBGBVR7_EL1,
+    HV_SYS_REG_DBGBVR8_EL1,
+    HV_SYS_REG_DBGBVR9_EL1,
+    HV_SYS_REG_DBGBVR10_EL1,
+    HV_SYS_REG_DBGBVR11_EL1,
+    HV_SYS_REG_DBGBVR12_EL1,
+    HV_SYS_REG_DBGBVR13_EL1,
+    HV_SYS_REG_DBGBVR14_EL1,
+    HV_SYS_REG_DBGBVR15_EL1,
+};
+static uint16_t dbgwcr_regs[] = {
+    HV_SYS_REG_DBGWCR0_EL1,
+    HV_SYS_REG_DBGWCR1_EL1,
+    HV_SYS_REG_DBGWCR2_EL1,
+    HV_SYS_REG_DBGWCR3_EL1,
+    HV_SYS_REG_DBGWCR4_EL1,
+    HV_SYS_REG_DBGWCR5_EL1,
+    HV_SYS_REG_DBGWCR6_EL1,
+    HV_SYS_REG_DBGWCR7_EL1,
+    HV_SYS_REG_DBGWCR8_EL1,
+    HV_SYS_REG_DBGWCR9_EL1,
+    HV_SYS_REG_DBGWCR10_EL1,
+    HV_SYS_REG_DBGWCR11_EL1,
+    HV_SYS_REG_DBGWCR12_EL1,
+    HV_SYS_REG_DBGWCR13_EL1,
+    HV_SYS_REG_DBGWCR14_EL1,
+    HV_SYS_REG_DBGWCR15_EL1,
+};
+static uint16_t dbgwvr_regs[] = {
+    HV_SYS_REG_DBGWVR0_EL1,
+    HV_SYS_REG_DBGWVR1_EL1,
+    HV_SYS_REG_DBGWVR2_EL1,
+    HV_SYS_REG_DBGWVR3_EL1,
+    HV_SYS_REG_DBGWVR4_EL1,
+    HV_SYS_REG_DBGWVR5_EL1,
+    HV_SYS_REG_DBGWVR6_EL1,
+    HV_SYS_REG_DBGWVR7_EL1,
+    HV_SYS_REG_DBGWVR8_EL1,
+    HV_SYS_REG_DBGWVR9_EL1,
+    HV_SYS_REG_DBGWVR10_EL1,
+    HV_SYS_REG_DBGWVR11_EL1,
+    HV_SYS_REG_DBGWVR12_EL1,
+    HV_SYS_REG_DBGWVR13_EL1,
+    HV_SYS_REG_DBGWVR14_EL1,
+    HV_SYS_REG_DBGWVR15_EL1,
+};
+
+static inline int hvf_arm_num_brps(hv_vcpu_config_t config)
+{
+    uint64_t val;
+    hv_return_t ret;
+    ret = hv_vcpu_config_get_feature_reg(config, HV_FEATURE_REG_ID_AA64DFR0_EL1,
+                                         &val);
+    assert_hvf_ok(ret);
+    return FIELD_EX64(val, ID_AA64DFR0, BRPS) + 1;
+}
+
+static inline int hvf_arm_num_wrps(hv_vcpu_config_t config)
+{
+    uint64_t val;
+    hv_return_t ret;
+    ret = hv_vcpu_config_get_feature_reg(config, HV_FEATURE_REG_ID_AA64DFR0_EL1,
+                                         &val);
+    assert_hvf_ok(ret);
+    return FIELD_EX64(val, ID_AA64DFR0, WRPS) + 1;
+}
+
+void hvf_arm_init_debug(void)
+{
+    hv_vcpu_config_t config;
+    config = hv_vcpu_config_create();
+
+    max_hw_bps = hvf_arm_num_brps(config);
+    hw_breakpoints =
+        g_array_sized_new(true, true, sizeof(HWBreakpoint), max_hw_bps);
+
+    max_hw_wps = hvf_arm_num_wrps(config);
+    hw_watchpoints =
+        g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
+}
+
 #define HVF_SYSREG(crn, crm, op0, op1, op2) \
         ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
 #define PL1_WRITE_MASK 0x4
@@ -465,6 +575,92 @@ int hvf_get_registers(CPUState *cpu)
             continue;
         }
 
+        if (cpu->hvf->guest_debug_enabled) {
+            /* Handle debug registers */
+            switch (hvf_sreg_match[i].reg) {
+            case HV_SYS_REG_DBGBVR0_EL1:
+            case HV_SYS_REG_DBGBCR0_EL1:
+            case HV_SYS_REG_DBGWVR0_EL1:
+            case HV_SYS_REG_DBGWCR0_EL1:
+            case HV_SYS_REG_DBGBVR1_EL1:
+            case HV_SYS_REG_DBGBCR1_EL1:
+            case HV_SYS_REG_DBGWVR1_EL1:
+            case HV_SYS_REG_DBGWCR1_EL1:
+            case HV_SYS_REG_DBGBVR2_EL1:
+            case HV_SYS_REG_DBGBCR2_EL1:
+            case HV_SYS_REG_DBGWVR2_EL1:
+            case HV_SYS_REG_DBGWCR2_EL1:
+            case HV_SYS_REG_DBGBVR3_EL1:
+            case HV_SYS_REG_DBGBCR3_EL1:
+            case HV_SYS_REG_DBGWVR3_EL1:
+            case HV_SYS_REG_DBGWCR3_EL1:
+            case HV_SYS_REG_DBGBVR4_EL1:
+            case HV_SYS_REG_DBGBCR4_EL1:
+            case HV_SYS_REG_DBGWVR4_EL1:
+            case HV_SYS_REG_DBGWCR4_EL1:
+            case HV_SYS_REG_DBGBVR5_EL1:
+            case HV_SYS_REG_DBGBCR5_EL1:
+            case HV_SYS_REG_DBGWVR5_EL1:
+            case HV_SYS_REG_DBGWCR5_EL1:
+            case HV_SYS_REG_DBGBVR6_EL1:
+            case HV_SYS_REG_DBGBCR6_EL1:
+            case HV_SYS_REG_DBGWVR6_EL1:
+            case HV_SYS_REG_DBGWCR6_EL1:
+            case HV_SYS_REG_DBGBVR7_EL1:
+            case HV_SYS_REG_DBGBCR7_EL1:
+            case HV_SYS_REG_DBGWVR7_EL1:
+            case HV_SYS_REG_DBGWCR7_EL1:
+            case HV_SYS_REG_DBGBVR8_EL1:
+            case HV_SYS_REG_DBGBCR8_EL1:
+            case HV_SYS_REG_DBGWVR8_EL1:
+            case HV_SYS_REG_DBGWCR8_EL1:
+            case HV_SYS_REG_DBGBVR9_EL1:
+            case HV_SYS_REG_DBGBCR9_EL1:
+            case HV_SYS_REG_DBGWVR9_EL1:
+            case HV_SYS_REG_DBGWCR9_EL1:
+            case HV_SYS_REG_DBGBVR10_EL1:
+            case HV_SYS_REG_DBGBCR10_EL1:
+            case HV_SYS_REG_DBGWVR10_EL1:
+            case HV_SYS_REG_DBGWCR10_EL1:
+            case HV_SYS_REG_DBGBVR11_EL1:
+            case HV_SYS_REG_DBGBCR11_EL1:
+            case HV_SYS_REG_DBGWVR11_EL1:
+            case HV_SYS_REG_DBGWCR11_EL1:
+            case HV_SYS_REG_DBGBVR12_EL1:
+            case HV_SYS_REG_DBGBCR12_EL1:
+            case HV_SYS_REG_DBGWVR12_EL1:
+            case HV_SYS_REG_DBGWCR12_EL1:
+            case HV_SYS_REG_DBGBVR13_EL1:
+            case HV_SYS_REG_DBGBCR13_EL1:
+            case HV_SYS_REG_DBGWVR13_EL1:
+            case HV_SYS_REG_DBGWCR13_EL1:
+            case HV_SYS_REG_DBGBVR14_EL1:
+            case HV_SYS_REG_DBGBCR14_EL1:
+            case HV_SYS_REG_DBGWVR14_EL1:
+            case HV_SYS_REG_DBGWCR14_EL1:
+            case HV_SYS_REG_DBGBVR15_EL1:
+            case HV_SYS_REG_DBGBCR15_EL1:
+            case HV_SYS_REG_DBGWVR15_EL1:
+            case HV_SYS_REG_DBGWCR15_EL1: {
+                /*
+                 * If the guest is being debugged, the vCPU's debug registers
+                 * are holding the gdbstub's view of the registers (set in
+                 * hvf_arch_update_guest_debug()).
+                 * Since the environment is used to store only the guest's view
+                 * of the registers, don't update it with the values from the
+                 * vCPU but simply keep the values from the previous
+                 * environment.
+                 */
+                const ARMCPRegInfo *ri;
+                ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_sreg_match[i].key);
+                val = read_raw_cp_reg(env, ri);
+
+                arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
+                continue;
+            }
+            }
+        }
+
         ret = hv_vcpu_get_sys_reg(cpu->hvf->fd, hvf_sreg_match[i].reg, &val);
         assert_hvf_ok(ret);
 
@@ -516,6 +712,82 @@ int hvf_put_registers(CPUState *cpu)
             continue;
         }
 
+        if (cpu->hvf->guest_debug_enabled) {
+            /* Handle debug registers */
+            switch (hvf_sreg_match[i].reg) {
+            case HV_SYS_REG_DBGBVR0_EL1:
+            case HV_SYS_REG_DBGBCR0_EL1:
+            case HV_SYS_REG_DBGWVR0_EL1:
+            case HV_SYS_REG_DBGWCR0_EL1:
+            case HV_SYS_REG_DBGBVR1_EL1:
+            case HV_SYS_REG_DBGBCR1_EL1:
+            case HV_SYS_REG_DBGWVR1_EL1:
+            case HV_SYS_REG_DBGWCR1_EL1:
+            case HV_SYS_REG_DBGBVR2_EL1:
+            case HV_SYS_REG_DBGBCR2_EL1:
+            case HV_SYS_REG_DBGWVR2_EL1:
+            case HV_SYS_REG_DBGWCR2_EL1:
+            case HV_SYS_REG_DBGBVR3_EL1:
+            case HV_SYS_REG_DBGBCR3_EL1:
+            case HV_SYS_REG_DBGWVR3_EL1:
+            case HV_SYS_REG_DBGWCR3_EL1:
+            case HV_SYS_REG_DBGBVR4_EL1:
+            case HV_SYS_REG_DBGBCR4_EL1:
+            case HV_SYS_REG_DBGWVR4_EL1:
+            case HV_SYS_REG_DBGWCR4_EL1:
+            case HV_SYS_REG_DBGBVR5_EL1:
+            case HV_SYS_REG_DBGBCR5_EL1:
+            case HV_SYS_REG_DBGWVR5_EL1:
+            case HV_SYS_REG_DBGWCR5_EL1:
+            case HV_SYS_REG_DBGBVR6_EL1:
+            case HV_SYS_REG_DBGBCR6_EL1:
+            case HV_SYS_REG_DBGWVR6_EL1:
+            case HV_SYS_REG_DBGWCR6_EL1:
+            case HV_SYS_REG_DBGBVR7_EL1:
+            case HV_SYS_REG_DBGBCR7_EL1:
+            case HV_SYS_REG_DBGWVR7_EL1:
+            case HV_SYS_REG_DBGWCR7_EL1:
+            case HV_SYS_REG_DBGBVR8_EL1:
+            case HV_SYS_REG_DBGBCR8_EL1:
+            case HV_SYS_REG_DBGWVR8_EL1:
+            case HV_SYS_REG_DBGWCR8_EL1:
+            case HV_SYS_REG_DBGBVR9_EL1:
+            case HV_SYS_REG_DBGBCR9_EL1:
+            case HV_SYS_REG_DBGWVR9_EL1:
+            case HV_SYS_REG_DBGWCR9_EL1:
+            case HV_SYS_REG_DBGBVR10_EL1:
+            case HV_SYS_REG_DBGBCR10_EL1:
+            case HV_SYS_REG_DBGWVR10_EL1:
+            case HV_SYS_REG_DBGWCR10_EL1:
+            case HV_SYS_REG_DBGBVR11_EL1:
+            case HV_SYS_REG_DBGBCR11_EL1:
+            case HV_SYS_REG_DBGWVR11_EL1:
+            case HV_SYS_REG_DBGWCR11_EL1:
+            case HV_SYS_REG_DBGBVR12_EL1:
+            case HV_SYS_REG_DBGBCR12_EL1:
+            case HV_SYS_REG_DBGWVR12_EL1:
+            case HV_SYS_REG_DBGWCR12_EL1:
+            case HV_SYS_REG_DBGBVR13_EL1:
+            case HV_SYS_REG_DBGBCR13_EL1:
+            case HV_SYS_REG_DBGWVR13_EL1:
+            case HV_SYS_REG_DBGWCR13_EL1:
+            case HV_SYS_REG_DBGBVR14_EL1:
+            case HV_SYS_REG_DBGBCR14_EL1:
+            case HV_SYS_REG_DBGWVR14_EL1:
+            case HV_SYS_REG_DBGWCR14_EL1:
+            case HV_SYS_REG_DBGBVR15_EL1:
+            case HV_SYS_REG_DBGBCR15_EL1:
+            case HV_SYS_REG_DBGWVR15_EL1:
+            case HV_SYS_REG_DBGWCR15_EL1:
+                /*
+                 * If the guest is being debugged, the vCPU's debug registers
+                 * are already holding the gdbstub's view of the registers (set
+                 * in hvf_arch_update_guest_debug()).
+                 */
+                continue;
+            }
+        }
+
         val = arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx];
         ret = hv_vcpu_set_sys_reg(cpu->hvf->fd, hvf_sreg_match[i].reg, val);
         assert_hvf_ok(ret);
@@ -1532,11 +1804,13 @@ int hvf_vcpu_exec(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
+    int ret;
     hv_vcpu_exit_t *hvf_exit = cpu->hvf->exit;
     hv_return_t r;
     bool advance_pc = false;
 
-    if (hvf_inject_interrupts(cpu)) {
+    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
+        hvf_inject_interrupts(cpu)) {
         return EXCP_INTERRUPT;
     }
 
@@ -1554,6 +1828,7 @@ int hvf_vcpu_exec(CPUState *cpu)
     uint64_t syndrome = hvf_exit->exception.syndrome;
     uint32_t ec = syn_get_ec(syndrome);
 
+    ret = 0;
     qemu_mutex_lock_iothread();
     switch (exit_reason) {
     case HV_EXIT_REASON_EXCEPTION:
@@ -1573,6 +1848,49 @@ int hvf_vcpu_exec(CPUState *cpu)
     hvf_sync_vtimer(cpu);
 
     switch (ec) {
+    case EC_SOFTWARESTEP: {
+        ret = EXCP_DEBUG;
+
+        if (!cpu->singlestep_enabled) {
+            error_report("EC_SOFTWARESTEP but single-stepping not enabled");
+        }
+        break;
+    }
+    case EC_AA64_BKPT: {
+        ret = EXCP_DEBUG;
+
+        cpu_synchronize_state(cpu);
+
+        if (!hvf_find_sw_breakpoint(cpu, env->pc)) {
+            /* Re-inject into the guest */
+            ret = 0;
+            hvf_raise_exception(cpu, EXCP_BKPT, syn_aa64_bkpt(0));
+        }
+        break;
+    }
+    case EC_BREAKPOINT: {
+        ret = EXCP_DEBUG;
+
+        cpu_synchronize_state(cpu);
+
+        if (!find_hw_breakpoint(cpu, env->pc)) {
+            error_report("EC_BREAKPOINT but unknown hw breakpoint");
+        }
+        break;
+    }
+    case EC_WATCHPOINT: {
+        ret = EXCP_DEBUG;
+
+        cpu_synchronize_state(cpu);
+
+        CPUWatchpoint *wp =
+            find_hw_watchpoint(cpu, hvf_exit->exception.virtual_address);
+        if (!wp) {
+            error_report("EXCP_DEBUG but unknown hw watchpoint");
+        }
+        cpu->watchpoint_hit = wp;
+        break;
+    }
     case EC_DATAABORT: {
         bool isv = syndrome & ARM_EL_ISV;
         bool iswrite = (syndrome >> 6) & 1;
@@ -1677,9 +1995,14 @@ int hvf_vcpu_exec(CPUState *cpu)
         pc += 4;
         r = hv_vcpu_set_reg(cpu->hvf->fd, HV_REG_PC, pc);
         assert_hvf_ok(r);
+
+        /* Handle single-stepping over instructions which trigger a VM exit */
+        if (cpu->singlestep_enabled) {
+            ret = EXCP_DEBUG;
+        }
     }
 
-    return 0;
+    return ret;
 }
 
 static const VMStateDescription vmstate_hvf_vtimer = {
@@ -1711,6 +2034,9 @@ int hvf_arch_init(void)
     hvf_state->vtimer_offset = mach_absolute_time();
     vmstate_register(NULL, 0, &vmstate_hvf_vtimer, &vtimer);
     qemu_add_vm_change_state_handler(hvf_vm_state_change, &vtimer);
+
+    hvf_arm_init_debug();
+
     return 0;
 }
 
@@ -1774,3 +2100,147 @@ void hvf_arch_remove_all_hw_breakpoints(void)
         g_array_remove_range(hw_breakpoints, 0, cur_hw_bps);
     }
 }
+
+/*
+ * Update the vCPU with the gdbstub's view of debug registers. This view
+ * consists of all hardware breakpoints and watchpoints inserted so far while
+ * debugging the guest.
+ */
+static void hvf_put_gdbstub_debug_registers(CPUState *cpu)
+{
+    hv_return_t r = HV_SUCCESS;
+    int i;
+
+    for (i = 0; i < cur_hw_bps; i++) {
+        HWBreakpoint *bp = get_hw_bp(i);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgbcr_regs[i], bp->bcr);
+        assert_hvf_ok(r);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgbvr_regs[i], bp->bvr);
+        assert_hvf_ok(r);
+    }
+    for (i = cur_hw_bps; i < max_hw_bps; i++) {
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgbcr_regs[i], 0);
+        assert_hvf_ok(r);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgbvr_regs[i], 0);
+        assert_hvf_ok(r);
+    }
+
+    for (i = 0; i < cur_hw_wps; i++) {
+        HWWatchpoint *wp = get_hw_wp(i);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgwcr_regs[i], wp->wcr);
+        assert_hvf_ok(r);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgwvr_regs[i], wp->wvr);
+        assert_hvf_ok(r);
+    }
+    for (i = cur_hw_wps; i < max_hw_wps; i++) {
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgwcr_regs[i], 0);
+        assert_hvf_ok(r);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgwvr_regs[i], 0);
+        assert_hvf_ok(r);
+    }
+}
+
+/*
+ * Update the vCPU with the guest's view of debug registers. This view is kept
+ * in the environment at all times.
+ */
+static void hvf_put_guest_debug_registers(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    hv_return_t r = HV_SUCCESS;
+    int i;
+
+    for (i = 0; i < max_hw_bps; i++) {
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgbcr_regs[i],
+                                env->cp15.dbgbcr[i]);
+        assert_hvf_ok(r);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgbvr_regs[i],
+                                env->cp15.dbgbvr[i]);
+        assert_hvf_ok(r);
+    }
+
+    for (i = 0; i < max_hw_wps; i++) {
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgwcr_regs[i],
+                                env->cp15.dbgwcr[i]);
+        assert_hvf_ok(r);
+        r = hv_vcpu_set_sys_reg(cpu->hvf->fd, dbgwvr_regs[i],
+                                env->cp15.dbgwvr[i]);
+        assert_hvf_ok(r);
+    }
+}
+
+static inline bool hvf_arm_hw_debug_active(CPUState *cpu)
+{
+    return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
+}
+
+static void hvf_arch_set_traps(void)
+{
+    CPUState *cpu;
+    bool should_enable_traps = false;
+    hv_return_t r = HV_SUCCESS;
+
+    /* Check whether guest debugging is enabled for at least one vCPU; if it
+     * is, enable exiting the guest on all vCPUs */
+    CPU_FOREACH(cpu) {
+        should_enable_traps |= cpu->hvf->guest_debug_enabled;
+    }
+    CPU_FOREACH(cpu) {
+        /* Set whether debug exceptions exit the guest */
+        r = hv_vcpu_set_trap_debug_exceptions(cpu->hvf->fd,
+                                              should_enable_traps);
+        assert_hvf_ok(r);
+
+        /* Set whether accesses to debug registers exit the guest */
+        r = hv_vcpu_set_trap_debug_reg_accesses(cpu->hvf->fd,
+                                                should_enable_traps);
+        assert_hvf_ok(r);
+    }
+}
+
+void hvf_arch_update_guest_debug(CPUState *cpu)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+
+    /* Check whether guest debugging is enabled */
+    cpu->hvf->guest_debug_enabled = cpu->singlestep_enabled ||
+                                    hvf_sw_breakpoints_active(cpu) ||
+                                    hvf_arm_hw_debug_active(cpu);
+
+    /* Update debug registers */
+    if (cpu->hvf->guest_debug_enabled) {
+        hvf_put_gdbstub_debug_registers(cpu);
+    } else {
+        hvf_put_guest_debug_registers(cpu);
+    }
+
+    cpu_synchronize_state(cpu);
+
+    /* Enable/disable single-stepping */
+    if (cpu->singlestep_enabled) {
+        env->cp15.mdscr_el1 =
+            deposit64(env->cp15.mdscr_el1, MDSCR_EL1_SS_SHIFT, 1, 1);
+        pstate_write(env, pstate_read(env) | PSTATE_SS);
+    } else {
+        env->cp15.mdscr_el1 =
+            deposit64(env->cp15.mdscr_el1, MDSCR_EL1_SS_SHIFT, 1, 0);
+    }
+
+    /* Enable/disable Breakpoint exceptions */
+    if (hvf_arm_hw_debug_active(cpu)) {
+        env->cp15.mdscr_el1 =
+            deposit64(env->cp15.mdscr_el1, MDSCR_EL1_MDE_SHIFT, 1, 1);
+    } else {
+        env->cp15.mdscr_el1 =
+            deposit64(env->cp15.mdscr_el1, MDSCR_EL1_MDE_SHIFT, 1, 0);
+    }
+
+    hvf_arch_set_traps();
+}
+
+inline bool hvf_arch_supports_guest_debug(void)
+{
+    return true;
+}
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 08bc96ecbc1..f6775c942aa 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -703,3 +703,12 @@ int hvf_arch_remove_hw_breakpoint(target_ulong addr, target_ulong len, int type)
 void hvf_arch_remove_all_hw_breakpoints(void)
 {
 }
+
+void hvf_arch_update_guest_debug(CPUState *cpu)
+{
+}
+
+inline bool hvf_arch_supports_guest_debug(void)
+{
+    return false;
+}
-- 
2.34.1


