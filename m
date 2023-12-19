Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5508C81906D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:14:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfWr-0001pS-0N; Tue, 19 Dec 2023 14:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWm-0001l2-Kd
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:16 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWk-0001lh-Bl
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:16 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33664b6d6abso2681152f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013193; x=1703617993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kbhem3ByWXGPCcp4ptdyGn3hPusC0kTAklpx1zGjXBg=;
 b=a2zHQWdVEUVfhGl2q7FP7dqEXSQ9suFyA1blgea3uo0yB0XGDuqek7K+cc/jObi/MT
 jlkod3uAqbKSigdpTkL5wEEoXCyV0m4IlUHt9kibQZTYE/zVKgpea9iLT+M7KwKRyYbH
 JDeDtR9VUJznFui+frBuml9U66Al06seS+GevG0Midd5AYpU7vwwTlQ28FuPyIPwWpvL
 YAKFles3cGrJnkslN3cgPuCBFjgIRZ6A08v6yoGA7tr0bsSzSRRZlFo3jTf2g5VM4J9m
 QImGR4RIxepriGSbIwj7mzeKeSAsX8r/8RpEk0PNlK8LfudKV/rWuAkB06AJEPRho+Zy
 Nr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013193; x=1703617993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kbhem3ByWXGPCcp4ptdyGn3hPusC0kTAklpx1zGjXBg=;
 b=qD0sMcdcn0Yi4iFfPPihygXrDBEq6fGWpEXvuG67d+JFMCImZxyOdc3ovfvPPYhzVi
 aKADx4mczLvBf9B8sFowjoldNUm9rD44SGRz3yvvNBimBkN6PBMG1tnIwVUY7v18LK82
 r8JdZPk4mP2K7Y5I4RZLV50Orj0Y4wApE6pqFgPTUtg0XlUPBkwqg8YqquSpLROdJpbF
 yuXyg7hJzauqJYoegw3o/3xwE7iO94NVugkT9Q+MButI8RNYwjkhT4Zn5rSc88YABgG5
 ahMrV08MygFPZ4N/Z2diSgKzVcPFwFB9ZteuECGGJ4BpNjMR9azlQ/8Uf4XAyWqWSErt
 07EQ==
X-Gm-Message-State: AOJu0Yx3ZtaKmkfDe5m/7zNyGmr239C7zMJr+5kbVYSqZedqyaJUe9LG
 ZFpjroIJ6EnLc3lBl0VM5vUwx50AOtBKArGMolI=
X-Google-Smtp-Source: AGHT+IFRDiBIV8xXuIOGD9E1Q9j0YpP7EbkKGPkZnY098FrXkSqYChZ33s/puv7C7k6DBWh899KKbQ==
X-Received: by 2002:adf:ef0a:0:b0:336:77a8:3e40 with SMTP id
 e10-20020adfef0a000000b0033677a83e40mr242400wro.103.1703013192843; 
 Tue, 19 Dec 2023 11:13:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/43] target/arm/kvm: Move kvm_arm_handle_debug and unexport
Date: Tue, 19 Dec 2023 19:12:31 +0000
Message-Id: <20231219191307.2895919-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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
 target/arm/kvm_arm.h |  9 ------
 target/arm/kvm.c     | 77 ++++++++++++++++++++++++++++++++++++++++++++
 target/arm/kvm64.c   | 70 ----------------------------------------
 3 files changed, 77 insertions(+), 79 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index ac4856cb46e..9fa9cb7f767 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -445,13 +445,4 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
 
 #endif
 
-/**
- * kvm_arm_handle_debug:
- * @cs: CPUState
- * @debug_exit: debug part of the KVM exit structure
- *
- * Returns: TRUE if the debug exception was handled.
- */
-bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit);
-
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4608bea7df4..55e1b4f26e9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -988,6 +988,83 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
     return -1;
 }
 
+/**
+ * kvm_arm_handle_debug:
+ * @cs: CPUState
+ * @debug_exit: debug part of the KVM exit structure
+ *
+ * Returns: TRUE if the debug exception was handled.
+ *
+ * See v8 ARM ARM D7.2.27 ESR_ELx, Exception Syndrome Register
+ *
+ * To minimise translating between kernel and user-space the kernel
+ * ABI just provides user-space with the full exception syndrome
+ * register value to be decoded in QEMU.
+ */
+static bool kvm_arm_handle_debug(CPUState *cs,
+                                 struct kvm_debug_exit_arch *debug_exit)
+{
+    int hsr_ec = syn_get_ec(debug_exit->hsr);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /* Ensure PC is synchronised */
+    kvm_cpu_synchronize_state(cs);
+
+    switch (hsr_ec) {
+    case EC_SOFTWARESTEP:
+        if (cs->singlestep_enabled) {
+            return true;
+        } else {
+            /*
+             * The kernel should have suppressed the guest's ability to
+             * single step at this point so something has gone wrong.
+             */
+            error_report("%s: guest single-step while debugging unsupported"
+                         " (%"PRIx64", %"PRIx32")",
+                         __func__, env->pc, debug_exit->hsr);
+            return false;
+        }
+        break;
+    case EC_AA64_BKPT:
+        if (kvm_find_sw_breakpoint(cs, env->pc)) {
+            return true;
+        }
+        break;
+    case EC_BREAKPOINT:
+        if (find_hw_breakpoint(cs, env->pc)) {
+            return true;
+        }
+        break;
+    case EC_WATCHPOINT:
+    {
+        CPUWatchpoint *wp = find_hw_watchpoint(cs, debug_exit->far);
+        if (wp) {
+            cs->watchpoint_hit = wp;
+            return true;
+        }
+        break;
+    }
+    default:
+        error_report("%s: unhandled debug exit (%"PRIx32", %"PRIx64")",
+                     __func__, debug_exit->hsr, env->pc);
+    }
+
+    /* If we are not handling the debug exception it must belong to
+     * the guest. Let's re-use the existing TCG interrupt code to set
+     * everything up properly.
+     */
+    cs->exception_index = EXCP_BKPT;
+    env->exception.syndrome = debug_exit->hsr;
+    env->exception.vaddress = debug_exit->far;
+    env->exception.target_el = 1;
+    qemu_mutex_lock_iothread();
+    arm_cpu_do_interrupt(cs);
+    qemu_mutex_unlock_iothread();
+
+    return false;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 352643e0665..6b6db9374c6 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1121,73 +1121,3 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     }
     return 0;
 }
-
-/* See v8 ARM ARM D7.2.27 ESR_ELx, Exception Syndrome Register
- *
- * To minimise translating between kernel and user-space the kernel
- * ABI just provides user-space with the full exception syndrome
- * register value to be decoded in QEMU.
- */
-
-bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
-{
-    int hsr_ec = syn_get_ec(debug_exit->hsr);
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
-    /* Ensure PC is synchronised */
-    kvm_cpu_synchronize_state(cs);
-
-    switch (hsr_ec) {
-    case EC_SOFTWARESTEP:
-        if (cs->singlestep_enabled) {
-            return true;
-        } else {
-            /*
-             * The kernel should have suppressed the guest's ability to
-             * single step at this point so something has gone wrong.
-             */
-            error_report("%s: guest single-step while debugging unsupported"
-                         " (%"PRIx64", %"PRIx32")",
-                         __func__, env->pc, debug_exit->hsr);
-            return false;
-        }
-        break;
-    case EC_AA64_BKPT:
-        if (kvm_find_sw_breakpoint(cs, env->pc)) {
-            return true;
-        }
-        break;
-    case EC_BREAKPOINT:
-        if (find_hw_breakpoint(cs, env->pc)) {
-            return true;
-        }
-        break;
-    case EC_WATCHPOINT:
-    {
-        CPUWatchpoint *wp = find_hw_watchpoint(cs, debug_exit->far);
-        if (wp) {
-            cs->watchpoint_hit = wp;
-            return true;
-        }
-        break;
-    }
-    default:
-        error_report("%s: unhandled debug exit (%"PRIx32", %"PRIx64")",
-                     __func__, debug_exit->hsr, env->pc);
-    }
-
-    /* If we are not handling the debug exception it must belong to
-     * the guest. Let's re-use the existing TCG interrupt code to set
-     * everything up properly.
-     */
-    cs->exception_index = EXCP_BKPT;
-    env->exception.syndrome = debug_exit->hsr;
-    env->exception.vaddress = debug_exit->far;
-    env->exception.target_el = 1;
-    qemu_mutex_lock_iothread();
-    arm_cpu_do_interrupt(cs);
-    qemu_mutex_unlock_iothread();
-
-    return false;
-}
-- 
2.34.1


