Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D8B79DAE1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAwz-0000hI-8o; Tue, 12 Sep 2023 17:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwt-0000Yh-Im; Tue, 12 Sep 2023 17:29:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwr-0007Xk-2o; Tue, 12 Sep 2023 17:29:31 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68faf930054so2866059b3a.0; 
 Tue, 12 Sep 2023 14:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554166; x=1695158966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0c/U127kRZlzHBmfgSsC57fttRjeM+Iuaw+v/+H9H8A=;
 b=cVCmIdORPyHDZEJAYKvYRORYkDjqAPZ1uNlu3wbsNPtLb7EkFgpMdezPP0/YZRaC4+
 SaST9B3RAy94kIiuWeX+ipNN9NUO0XnEpA+zd5D+Fi1vhOUUYBqAST0bBLoNjV+Fs8VR
 kheYtjn3adt0BXcMJMK5W8XJ9avvsBqI53b4a27riVCMIunC3zslkmhNxWBQiSIvHLFq
 OPh5X/MovX0hvTsqwfNEQFdn1qkELRXacartSQB0ADhk0zwPCmHYI5h1kuyTOQ4IvXTm
 yJcKBMVG4QaaFFQqNDUjKmWbU/LbwwT6K8sxALo54PBNb2lX1xikbJ4BP3BM6NGAUKeQ
 jwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554166; x=1695158966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0c/U127kRZlzHBmfgSsC57fttRjeM+Iuaw+v/+H9H8A=;
 b=DkGig0Lirrpc1jq5q730FraUJsNnG5tyZIaF6lKZlVJgKyhZCxC9dV5iPDg3Slk3uU
 lgE4vq40vPoALp0J//KHthW8HKrUrN408KuA96/zC+MaJVO7cfgtfE7P5BbiYIs4r/5G
 yRzQ5HH1XyYvdDr4Vy+MqyTZyL3/riLfs8VDlk2S3Td3eCUn7dkLM/+UztvOSn96KcjY
 vKVPaui3JifrXI1i1L08981qPERGjRQtlhwW6RXKleoh8Todh0UDsOtcr5t2NG1vqBDi
 kyHeb1aVCf2xwpXYIcI5VZ6tvZKCPsaU5gATXFFfnLkyZOfpzORT2sY70/dDUE0Jz1U1
 4dhA==
X-Gm-Message-State: AOJu0YyQuyfZkW1RiqxdQ0Nk6a/5SWq88d1x20fWzNHcG1yJsCoGQvEa
 LwWjo/F1Y3nu+n+OFJXTukUkxAt6UmJm1Qio
X-Google-Smtp-Source: AGHT+IFDaZyoDJURSCapMwfTHRGZRvB1maqalNeG4nnq9hxM6QRvAvG/KIwVeBJ7sthGfs+XteHogg==
X-Received: by 2002:a05:6a21:3d85:b0:131:a21:9f96 with SMTP id
 bj5-20020a056a213d8500b001310a219f96mr587036pzc.6.1694554166229; 
 Tue, 12 Sep 2023 14:29:26 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:25 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC v6 7/9] target/arm: Add support for native library calls
Date: Wed, 13 Sep 2023 05:28:40 +0800
Message-Id: <20230912212842.658374-8-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit introduces support for native library calls on the
arm target. When encountering special instructions reserved
for native calls, this commit extracts the function name and
generates the corresponding native call.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 configs/targets/aarch64-linux-user.mak |  1 +
 configs/targets/arm-linux-user.mak     |  1 +
 target/arm/tcg/translate-a64.c         | 32 ++++++++++++++++++++++++++
 target/arm/tcg/translate.c             | 29 +++++++++++++++++++++++
 target/arm/tcg/translate.h             |  5 ++++
 5 files changed, 68 insertions(+)

diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index ba8bc5fe3f..5a8fd98cd9 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+CONFIG_NATIVE_CALL=y
diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-linux-user.mak
index 7f5d65794c..f934fb82da 100644
--- a/configs/targets/arm-linux-user.mak
+++ b/configs/targets/arm-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+CONFIG_NATIVE_CALL=y
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3baab6aa60..00b69e9c24 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -25,6 +25,7 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
+#include "native/native.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -2400,6 +2401,10 @@ static bool trans_HLT(DisasContext *s, arg_i *a)
      * it is required for halting debug disabled: it will UNDEF.
      * Secondly, "HLT 0xf000" is the A64 semihosting syscall instruction.
      */
+    if (native_bypass_enabled() && (a->imm == 0xffff)) {
+        s->native_call_status = true;
+        return true;
+    }
     if (semihosting_enabled(s->current_el == 0) && a->imm == 0xf000) {
         gen_exception_internal_insn(s, EXCP_SEMIHOST);
     } else {
@@ -13392,6 +13397,26 @@ void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &op);
 }
 
+static void gen_native_call(CPUState *cpu, DisasContext *s, CPUARMState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    TCGv_i64 arg1 = tcg_temp_new_i64();
+    TCGv_i64 arg2 = tcg_temp_new_i64();
+    TCGv_i64 arg3 = tcg_temp_new_i64();
+    TCGv_i64 ret = tcg_temp_new_i64();
+    uint32_t func_tmp = translator_ldl_swap(env, &s->base, s->base.pc_next,
+                                            bswap_code(s->sctlr_b));
+    char *func_name = g2h(cpu, s->base.pc_next + func_tmp);
+    tcg_gen_mov_i64(arg1, cpu_reg(s, 0));
+    tcg_gen_mov_i64(arg2, cpu_reg(s, 1));
+    tcg_gen_mov_i64(arg3, cpu_reg(s, 2));
+    if (!gen_native_call_i64(func_name, ret, arg1, arg2, arg3)) {
+        unallocated_encoding(s);
+    }
+    tcg_gen_mov_i64(cpu_reg(s, 0), ret);
+#endif
+}
+
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
@@ -13950,6 +13975,13 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     uint64_t pc = s->base.pc_next;
     uint32_t insn;
 
+    if (native_bypass_enabled() && s->native_call_status) {
+        gen_native_call(cpu, s, env);
+        s->base.pc_next = pc + 4;
+        s->native_call_status = false;
+        return;
+    }
+
     /* Singlestep exceptions have the highest priority. */
     if (s->ss_active && !s->pstate_ss) {
         /* Singlestep state is Active-pending.
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 13c88ba1b9..7a5a0f9444 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -28,6 +28,7 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 #include "exec/helper-proto.h"
+#include "native/native.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -1125,6 +1126,23 @@ void gen_lookup_tb(DisasContext *s)
     s->base.is_jmp = DISAS_EXIT;
 }
 
+static void gen_native_call(CPUState *cpu, DisasContext *dc, CPUARMState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    TCGv_i32 arg1 = load_reg(dc, 0);
+    TCGv_i32 arg2 = load_reg(dc, 1);
+    TCGv_i32 arg3 = load_reg(dc, 2);
+    TCGv_i32 ret = tcg_temp_new_i32();
+    uint32_t func_tmp =
+        arm_ldl_code(env, &dc->base, dc->base.pc_next, dc->sctlr_b);
+    char *func_name = g2h(cpu, dc->base.pc_next + func_tmp);
+    if (!gen_native_call_i32(func_name, ret, arg1, arg2, arg3)) {
+        unallocated_encoding(dc);
+    }
+    store_reg(dc, 0, ret);
+#endif
+}
+
 static inline void gen_hlt(DisasContext *s, int imm)
 {
     /* HLT. This has two purposes.
@@ -1139,6 +1157,10 @@ static inline void gen_hlt(DisasContext *s, int imm)
      * semihosting, to provide some semblance of security
      * (and for consistency with our 32-bit semihosting).
      */
+    if (native_bypass_enabled() && (imm == 0xffff)) {
+        s->native_call_status = true;
+        return;
+    }
     if (semihosting_enabled(s->current_el == 0) &&
         (imm == (s->thumb ? 0x3c : 0xf000))) {
         gen_exception_internal_insn(s, EXCP_SEMIHOST);
@@ -9329,6 +9351,13 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     uint32_t pc = dc->base.pc_next;
     unsigned int insn;
 
+    if (native_bypass_enabled() && dc->native_call_status) {
+        gen_native_call(cpu, dc, env);
+        dc->base.pc_next = pc + 4;
+        dc->native_call_status = false;
+        return;
+    }
+
     /* Singlestep exceptions have the highest priority. */
     if (arm_check_ss_active(dc)) {
         dc->base.pc_next = pc + 4;
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index d1cacff0b2..3854a801e6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -157,6 +157,11 @@ typedef struct DisasContext {
     int c15_cpar;
     /* TCG op of the current insn_start.  */
     TCGOp *insn_start;
+    /*
+     * Indicate whether the next instruction is a native function call (true)
+     * or not (false).
+     */
+    bool native_call_status;
 } DisasContext;
 
 typedef struct DisasCompare {
-- 
2.34.1


