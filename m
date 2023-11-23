Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 004187F5774
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:43:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61Xw-0006M8-Pt; Wed, 22 Nov 2023 23:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xp-0006L7-3V
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:29 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Xm-00065W-Q3
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:28 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1efa01323b4so329680fac.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714545; x=1701319345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8mP+9YutwFg92uOZpuK6ilsBK+MI6NW7KpuKQNRnLM=;
 b=J6p4ItR16KMk208PuJc/GY2SStSR8yglR+8Up0DCepIQKyH8mVt4CVhBCbTKBugqvL
 yVwttq+lAFYAh/qAI0dBbmBc+cNQiiGpySlgy9TSj0uCpIkx90t+BxCLZS4RxxPOs5fz
 URHS99/2pYTuPfK6yDDY65d6opgdaTXgEmmuGF619tODKeryjZInky7zd7O13t8TQICF
 5MD2/i8dic+yAnwKjiXeSIGjHY5aK2+W3yBxJJs4+wUv/84BRAF4Y/zNbahPLg7WqThr
 hTt3fCVNyhN0Osl44+Af6yh0FMdxmltveWxcJSB5t2Cd5dOoRpQPldKYHCzOAkJDVXJ9
 4G5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714545; x=1701319345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8mP+9YutwFg92uOZpuK6ilsBK+MI6NW7KpuKQNRnLM=;
 b=FroXgCOKXBqBOCYC4BaawgXa7r1neW/JQJ6aLhgjw0J0LPYHByE1QBlxuGTNWW67HG
 GUt9Cpm31zQT6UAPusfAkcwPTPpaTctppDNGOA9CGtbFki54X3YrlFZv26GNuJ9LyIfo
 eqWQKWi6rkhJF9Dwkrpq9dZn9zWap6H9xv5exNBj0VNYRTtDvq4Zegmw5meXZkgmfZDk
 HnxYois5atRHKVFrEUwcxhUKhWAbr6KeA9HfxU2/rXHEedj8LeCZuLRQHhIIYqyea5kz
 cMzi+88Ui8x3ufhNbU0Fuya3jpjPiS3Euqrp2owGEfMbF7Q4y1WvL0EXqtK4L9eDSHAB
 EcXA==
X-Gm-Message-State: AOJu0Yy0WnB6GfbjqFy91vY3un0Y3S1ln9heaTu4LHiKncNyQFvuJ9TE
 AEXIca+ob7bNx9K1apXnGdC23VHDno5wCbx/hH/LhD51
X-Google-Smtp-Source: AGHT+IF4VFIi8REFTL+SXdunOItVsqPL4wGF7Hy5GnylETDydkGpWoAwLDgjfJzqgqDPANLsjB6L0A==
X-Received: by 2002:a05:6870:169a:b0:1e9:e76c:2706 with SMTP id
 j26-20020a056870169a00b001e9e76c2706mr5120659oae.52.1700714545276; 
 Wed, 22 Nov 2023 20:42:25 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/21] target/arm/kvm: Move kvm_arm_verify_ext_dabt_pending
 and unexport
Date: Wed, 22 Nov 2023 22:42:02 -0600
Message-Id: <20231123044219.896776-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h | 10 --------
 target/arm/kvm.c     | 57 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm64.c   | 49 -------------------------------------
 3 files changed, 57 insertions(+), 59 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index fe6d824a52..bb284a47de 100644
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
index b4836da6b2..696bc63e86 100644
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
index 40f459b786..7d937e2539 100644
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


