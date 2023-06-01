Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9F671EF58
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kHU-0005Ob-C1; Thu, 01 Jun 2023 11:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco.cagnin@gmail.com>)
 id 1q4kHM-0005G7-Rg; Thu, 01 Jun 2023 11:31:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francesco.cagnin@gmail.com>)
 id 1q4kHI-0005H5-V6; Thu, 01 Jun 2023 11:31:56 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so9971075e9.2; 
 Thu, 01 Jun 2023 08:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685633511; x=1688225511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Zn0c0UKseOi7S7AmGeZn7dlkhsld3M/mRfedn+v9cM=;
 b=rzmOLT3EWQCxJHTGNK5Q6+Naag9EhDfuVh1E0pBTebiOjN0q0LowerSCGLbHPrwyBF
 ReSL/9hXMLUILsLovi0GPQfuUV279sI/YAPtPw84HQ/7RRzZptT8eKDJ/9L9rmLqQp3n
 S8sFX4SrqG2sZtk08fDgxXhn+N0kiwlsiaVOf3ydrLR8bd1q6pUcF9gA9DquzQ0UO6Px
 TnCGgDXvky+XHQYnHCH9hWxpxrxkR/mty6Gs8rWaoJhl8eVz3uRMsXeIv+12AKWMPv/W
 EdDq/xeNIg1gc4PRWa4VfwMkBjJH46voixKNxdi549+dCvUeYOoT6c5mXAi8mfa7glAn
 EvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685633511; x=1688225511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Zn0c0UKseOi7S7AmGeZn7dlkhsld3M/mRfedn+v9cM=;
 b=XEOzeT64A+KHgfFvjIUdNukDObJRKo/i+OpbRyFU94/GBnRlS3MO71Ey0uW8nxv1ED
 CmM/q9ifZCv3F+5gDbE5GJcA27aEneuOFDS67AsbjAsygn4l/hA4TUzU7S69zTyju6l/
 Ag+kqFDphCgInnwN5+rSIGcMm3VCMbhJRuJAHhwtFTklGcKkpgdkkftE26WNFjEGf5UU
 EUOuppVrxRoC8yf9j6AInIzxl0xYCBrb9htH0VDMYN2VlMDJfzKRCJSpulbxWuNeAeN5
 lukQLr98aqH+ieeDsNGAth91iKgHtV9jGIyHIF6ICfgOXYADRTf5QDKFW8ohXn/TLXVw
 Jgww==
X-Gm-Message-State: AC+VfDwvvTv4KvBJ3txoM0mScXbgf3Y/GXVWJuC28gktZjUcqQEkaeVZ
 Qr0dkibPGJqezH3lmrWG94kyWOeX/Jk3KA==
X-Google-Smtp-Source: ACHHUZ5Ej6TmJrh1xUuWnLnlJgkIPcjr0ZCnM+lIvAq0s0+swzy4QxWX2FCNCXKFy8nJBa7YiMSxrw==
X-Received: by 2002:a1c:7206:0:b0:3f6:3486:1396 with SMTP id
 n6-20020a1c7206000000b003f634861396mr2563471wmc.33.1685633510990; 
 Thu, 01 Jun 2023 08:31:50 -0700 (PDT)
Received: from omega.guest.bzh.qb (177.23.22.93.rev.sfr.net. [93.22.23.177])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a1ced0e000000b003f4289b18a7sm2763975wmh.5.2023.06.01.08.31.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 08:31:50 -0700 (PDT)
From: francesco.cagnin@gmail.com
X-Google-Original-From: fcagnin@quarkslab.com
To: qemu-devel@nongnu.org
Cc: mads@ynddal.dk, dirty@apple.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com,
 alex.bennee@linaro.org, philmd@linaro.org,
 Francesco Cagnin <fcagnin@quarkslab.com>
Subject: [PATCH v5 4/4] hvf: add guest debugging handlers for Apple Silicon
 hosts
Date: Thu,  1 Jun 2023 17:31:07 +0200
Message-Id: <20230601153107.81955-5-fcagnin@quarkslab.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601153107.81955-1-fcagnin@quarkslab.com>
References: <20230601153107.81955-1-fcagnin@quarkslab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=francesco.cagnin@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
---
 accel/hvf/hvf-accel-ops.c |  10 +
 accel/hvf/hvf-all.c       |   6 +
 include/sysemu/hvf.h      |  15 ++
 include/sysemu/hvf_int.h  |   1 +
 target/arm/hvf/hvf.c      | 474 +++++++++++++++++++++++++++++++++++++-
 target/arm/hvf_arm.h      |   7 +
 target/i386/hvf/hvf.c     |   9 +
 7 files changed, 520 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 92601b1369..9c3da03c94 100644
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
index e983c23ad7..754707dbfb 100644
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
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index 386020a29c..70549b9158 100644
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
index 3592239fdc..6ab119e49f 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -54,6 +54,7 @@ struct hvf_vcpu_state {
     void *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
+    bool guest_debug_enabled;
 };
 
 void assert_hvf_ok(hv_return_t ret);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bb83627727..2bd0a35cba 100644
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
diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
index 9a9d1a0bf5..e848c1d27d 100644
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
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 08bc96ecbc..f6775c942a 100644
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
2.40.1


