Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C128B81906C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWp-0001oL-6H; Tue, 19 Dec 2023 14:13:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWl-0001k6-4i
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:15 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWi-0001lQ-RP
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33664b6d6abso2681141f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013191; x=1703617991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YAewmSP9F+VoC5qgl8O0d9adIruOSueyhNLq1gS1SEk=;
 b=a6aV5kx6XXbTgfYG0QrYkTP8fWT/jc5PHaGDV33fiCASmTOAgrC9bE0sMuJ+jHXaJO
 NDQctOBv7SMpNDLhc3zCv02134DOc8UzyDUAgDAYF46Z6rydO8ZoiYj3L3KekzXmXcfh
 LLu03ppUbaQkqL5x0d6F/VkxuDh7VebFPqBSd2BNADUy6G1nPZTTxePKg+HXHJwlKa/p
 DSx+B88BZQSSBCsx1dXGvite6kkwmi7E6tpTmixfJ4tPf0OXKFEeiVhX4ieCEXe5axkU
 VJc8sgePwABpm85b4I+JwMf/trQNpHnolSPskfPxcXzwSo7LTz2zCGasqnz3LKr9cUG9
 j2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013191; x=1703617991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAewmSP9F+VoC5qgl8O0d9adIruOSueyhNLq1gS1SEk=;
 b=Op6Bq+DJ7av5yj9Aaw+wVjnYTsSsQZMeyo3RyqPxaYrvFXNPlIADqUVCUDD62Lfqqu
 fUjnsLeONUw1v0S6TXcHhglkMtMdKPHoIlsHkJ1tvEgC3mYayoVd+fiSaV0DTyNw3JP6
 gZoqLFwJ68awvn//9GzECMzbykMmnTGhasjk9RLdVSMB5zpdHgSh5tOlY+d8yYOthpSQ
 t5IgXGgky6Y/NheIN2/TKRcXr+uRlfh1JtB5/NiiJgrudLU6pSMyrbF8Pzu2QHJKWDF1
 DxHvTonEpdCv3r0efnnx7KqO9unLsvXoL6kRbdKbHYc8QXIrqpKkcvzZslkZjuEFhNY7
 yaBw==
X-Gm-Message-State: AOJu0YwZHrMP468VIfNewFxHUy3qjVzwWaSDGteZHYiWHXaj9I2tZFzD
 KwV1fF9F5DpoyTdveK9wIt3vAttairpUsQo8oEk=
X-Google-Smtp-Source: AGHT+IFXWOp9/sbE+khQdzeVu1iJrO3RuGabRq7NzPtoZoOVOfMp7nNAlqv1HR6KQQli9EwlUrY93g==
X-Received: by 2002:a5d:4592:0:b0:336:6dba:e092 with SMTP id
 p18-20020a5d4592000000b003366dbae092mr1733394wrq.3.1703013191378; 
 Tue, 19 Dec 2023 11:13:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/43] target/arm/kvm: Move kvm_arm_verify_ext_dabt_pending and
 unexport
Date: Tue, 19 Dec 2023 19:12:28 +0000
Message-Id: <20231219191307.2895919-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 10 --------
 target/arm/kvm.c     | 57 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm64.c   | 49 -------------------------------------
 3 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index fe6d824a52c..bb284a47de3 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -472,14 +472,4 @@ bool kvm_arm_hw_debug_active(CPUState *cs);
 struct kvm_guest_debug_arch;
 void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
 
-/**
- * kvm_arm_verify_ext_dabt_pending:
- * @cs: CPUState
- *
- * Verify the fault status code wrt the Ext DABT injection
- *
- * Returns: true if the fault status code is as expected, false otherwise
- */
-bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);
-
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4836da6b25..696bc63e863 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -793,6 +793,63 @@ int kvm_get_vcpu_events(ARMCPU *cpu)
     return 0;
 }
 
+#define ARM64_REG_ESR_EL1 ARM64_SYS_REG(3, 0, 5, 2, 0)
+#define ARM64_REG_TCR_EL1 ARM64_SYS_REG(3, 0, 2, 0, 2)
+
+/*
+ * ESR_EL1
+ * ISS encoding
+ * AARCH64: DFSC,   bits [5:0]
+ * AARCH32:
+ *      TTBCR.EAE == 0
+ *          FS[4]   - DFSR[10]
+ *          FS[3:0] - DFSR[3:0]
+ *      TTBCR.EAE == 1
+ *          FS, bits [5:0]
+ */
+#define ESR_DFSC(aarch64, lpae, v)        \
+    ((aarch64 || (lpae)) ? ((v) & 0x3F)   \
+               : (((v) >> 6) | ((v) & 0x1F)))
+
+#define ESR_DFSC_EXTABT(aarch64, lpae) \
+    ((aarch64) ? 0x10 : (lpae) ? 0x10 : 0x8)
+
+/**
+ * kvm_arm_verify_ext_dabt_pending:
+ * @cs: CPUState
+ *
+ * Verify the fault status code wrt the Ext DABT injection
+ *
+ * Returns: true if the fault status code is as expected, false otherwise
+ */
+static bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
+{
+    uint64_t dfsr_val;
+
+    if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
+        ARMCPU *cpu = ARM_CPU(cs);
+        CPUARMState *env = &cpu->env;
+        int aarch64_mode = arm_feature(env, ARM_FEATURE_AARCH64);
+        int lpae = 0;
+
+        if (!aarch64_mode) {
+            uint64_t ttbcr;
+
+            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
+                lpae = arm_feature(env, ARM_FEATURE_LPAE)
+                        && (ttbcr & TTBCR_EAE);
+            }
+        }
+        /*
+         * The verification here is based on the DFSC bits
+         * of the ESR_EL1 reg only
+         */
+         return (ESR_DFSC(aarch64_mode, lpae, dfsr_val) ==
+                ESR_DFSC_EXTABT(aarch64_mode, lpae));
+    }
+    return false;
+}
+
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
     ARMCPU *cpu = ARM_CPU(cs);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 40f459b7862..7d937e25390 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1213,52 +1213,3 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
 
     return false;
 }
-
-#define ARM64_REG_ESR_EL1 ARM64_SYS_REG(3, 0, 5, 2, 0)
-#define ARM64_REG_TCR_EL1 ARM64_SYS_REG(3, 0, 2, 0, 2)
-
-/*
- * ESR_EL1
- * ISS encoding
- * AARCH64: DFSC,   bits [5:0]
- * AARCH32:
- *      TTBCR.EAE == 0
- *          FS[4]   - DFSR[10]
- *          FS[3:0] - DFSR[3:0]
- *      TTBCR.EAE == 1
- *          FS, bits [5:0]
- */
-#define ESR_DFSC(aarch64, lpae, v)        \
-    ((aarch64 || (lpae)) ? ((v) & 0x3F)   \
-               : (((v) >> 6) | ((v) & 0x1F)))
-
-#define ESR_DFSC_EXTABT(aarch64, lpae) \
-    ((aarch64) ? 0x10 : (lpae) ? 0x10 : 0x8)
-
-bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
-{
-    uint64_t dfsr_val;
-
-    if (!kvm_get_one_reg(cs, ARM64_REG_ESR_EL1, &dfsr_val)) {
-        ARMCPU *cpu = ARM_CPU(cs);
-        CPUARMState *env = &cpu->env;
-        int aarch64_mode = arm_feature(env, ARM_FEATURE_AARCH64);
-        int lpae = 0;
-
-        if (!aarch64_mode) {
-            uint64_t ttbcr;
-
-            if (!kvm_get_one_reg(cs, ARM64_REG_TCR_EL1, &ttbcr)) {
-                lpae = arm_feature(env, ARM_FEATURE_LPAE)
-                        && (ttbcr & TTBCR_EAE);
-            }
-        }
-        /*
-         * The verification here is based on the DFSC bits
-         * of the ESR_EL1 reg only
-         */
-         return (ESR_DFSC(aarch64_mode, lpae, dfsr_val) ==
-                ESR_DFSC_EXTABT(aarch64_mode, lpae));
-    }
-    return false;
-}
-- 
2.34.1


