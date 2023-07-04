Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C6A7476E0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1E-0001Ju-AY; Tue, 04 Jul 2023 12:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001HS-JE
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:45 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj16-0001oK-8R
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc244d386so63594335e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488598; x=1691080598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J5PRaqRDbG1q7cJ7k1FBCGAtKCCwmrJ591DUA034EE4=;
 b=Twz5jQTd7UrJ4r6NbtKEKyiDfhDd/7qO8sFkT07NbSspsJRVYraVLs7+8OiH1Nll6D
 ZpR7EVE/X9I7hRFeJf7NIdPwO+rb6h+v2o3yGWgnPts5hjs39iJUsV1CEGHAMIEoAfvX
 T2QaYpZMKr2Itz/Qe+0xvEXFrzVvrJ3YofQL6EpOOXiTFECzyMrBR9wgPMppvOpSfBM/
 iqs2sxFLtx+av2CSOZMx0hC38UFJaC7YGR96beJ17TMCiWLVyxyvcTDAc+beLAB7oGp8
 iumx+OvqS0zVj6MI/fkasvN/59W4X8WI/GfGqhJPUvOzdzShoNHzPpf3LeFALgbqFGDz
 UPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488598; x=1691080598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J5PRaqRDbG1q7cJ7k1FBCGAtKCCwmrJ591DUA034EE4=;
 b=ZbYgc6YgJl3yWjeVc7cInusQgILcaOOc4ZdiA29T4GhLmu8W+o9iiv8kC0+ubC3GpJ
 /VPwh1e+qNlQylIa+PjyesSLuO1cgLcxR3zT8mspHbu3OnArFMMUXniI+iYw0N8VE3cA
 zxUKao/aUx6+HGzCHWEv4Zc7hcZIfODwmFnhROx/gnj4JtEFnQquWYsA1HGJsEJlS/Z5
 f9LU5JoDFAVF9Id0FvfOdF3TQY6D27ZfadYICX+5kxkuuymmSy2jdB/YcX7wI7L5jJZ4
 GY0RrBtY3aPcVgCzSXC4c6Vvp5dkO48+Wd+HGybCBfQYEEHXjEyzKHehs2sZPkfwEHme
 gNmQ==
X-Gm-Message-State: AC+VfDxFzsO65pIBGvlPG/EnI9H3IWKzP3/iQu8OO/NvtMZutF6CrkJo
 YtmoitTCavq1QpjpU1Wi20h69gPjnZIdTuDlGqM=
X-Google-Smtp-Source: ACHHUZ6saCjGWpvFIsFAGERC+J93P/EHbEj2fMK3BrlSXu6skv5rVnke8HK8DespuMnJhiL1nrS4mw==
X-Received: by 2002:a05:600c:b53:b0:3fb:416d:6358 with SMTP id
 k19-20020a05600c0b5300b003fb416d6358mr11402817wmr.16.1688488598346; 
 Tue, 04 Jul 2023 09:36:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] target/arm: Handle IC IVAU to improve compatibility with
 JITs
Date: Tue,  4 Jul 2023 17:36:29 +0100
Message-Id: <20230704163634.3188465-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: John Högberg <john.hogberg@ericsson.com>

Unlike architectures with precise self-modifying code semantics
(e.g. x86) ARM processors do not maintain coherency for instruction
execution and memory, requiring an instruction synchronization
barrier on every core that will execute the new code, and on many
models also the explicit use of cache management instructions.

While this is required to make JITs work on actual hardware, QEMU
has gotten away with not handling this since it does not emulate
caches, and unconditionally invalidates code whenever the softmmu
or the user-mode page protection logic detects that code has been
modified.

Unfortunately the latter does not work in the face of dual-mapped
code (a common W^X workaround), where one page is executable and
the other is writable: user-mode has no way to connect one with the
other as that is only known to the kernel and the emulated
application.

This commit works around the issue by telling software that
instruction cache invalidation is required by clearing the
CPR_EL0.DIC flag (regardless of whether the emulated processor
needs it), and then invalidating code in IC IVAU instructions.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1034

Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: John Högberg <john.hogberg@ericsson.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 168778890374.24232.3402138851538068785-1@git.sr.ht
[PMM: removed unnecessary AArch64 feature check; moved
 "clear CTR_EL1.DIC" code up a bit so it's not in the middle
 of the vfp/neon related tests]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c    | 11 +++++++++++
 target/arm/helper.c | 47 ++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index adf84f96860..822efa5b2c1 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1694,6 +1694,17 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+#ifdef CONFIG_USER_ONLY
+    /*
+     * User mode relies on IC IVAU instructions to catch modification of
+     * dual-mapped code.
+     *
+     * Clear CTR_EL0.DIC to ensure that software that honors these flags uses
+     * IC IVAU even if the emulated processor does not normally require it.
+     */
+    cpu->ctr = FIELD_DP64(cpu->ctr, CTR_EL0, DIC, 0);
+#endif
+
     if (arm_feature(env, ARM_FEATURE_AARCH64) &&
         cpu->has_vfp != cpu->has_neon) {
         /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a0b84efab52..8e836aaee13 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5234,6 +5234,36 @@ static void mdcr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+#ifdef CONFIG_USER_ONLY
+/*
+ * `IC IVAU` is handled to improve compatibility with JITs that dual-map their
+ * code to get around W^X restrictions, where one region is writable and the
+ * other is executable.
+ *
+ * Since the executable region is never written to we cannot detect code
+ * changes when running in user mode, and rely on the emulated JIT telling us
+ * that the code has changed by executing this instruction.
+ */
+static void ic_ivau_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                          uint64_t value)
+{
+    uint64_t icache_line_mask, start_address, end_address;
+    const ARMCPU *cpu;
+
+    cpu = env_archcpu(env);
+
+    icache_line_mask = (4 << extract32(cpu->ctr, 0, 4)) - 1;
+    start_address = value & ~icache_line_mask;
+    end_address = value | icache_line_mask;
+
+    mmap_lock();
+
+    tb_invalidate_phys_range(start_address, end_address);
+
+    mmap_unlock();
+}
+#endif
+
 static const ARMCPRegInfo v8_cp_reginfo[] = {
     /*
      * Minimal set of EL0-visible registers. This will need to be expanded
@@ -5273,7 +5303,10 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "CURRENTEL", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .opc2 = 2, .crn = 4, .crm = 2,
       .access = PL1_R, .type = ARM_CP_CURRENTEL },
-    /* Cache ops: all NOPs since we don't emulate caches */
+    /*
+     * Instruction cache ops. All of these except `IC IVAU` NOP because we
+     * don't emulate caches.
+     */
     { .name = "IC_IALLUIS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
       .access = PL1_W, .type = ARM_CP_NOP,
@@ -5286,9 +5319,17 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .accessfn = access_tocu },
     { .name = "IC_IVAU", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 5, .opc2 = 1,
-      .access = PL0_W, .type = ARM_CP_NOP,
+      .access = PL0_W,
       .fgt = FGT_ICIVAU,
-      .accessfn = access_tocu },
+      .accessfn = access_tocu,
+#ifdef CONFIG_USER_ONLY
+      .type = ARM_CP_NO_RAW,
+      .writefn = ic_ivau_write
+#else
+      .type = ARM_CP_NOP
+#endif
+    },
+    /* Cache ops: all NOPs since we don't emulate caches */
     { .name = "DC_IVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 7, .crm = 6, .opc2 = 1,
       .access = PL1_W, .accessfn = aa64_cacheop_poc_access,
-- 
2.34.1


