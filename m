Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92950788538
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZUM5-0006BF-JF; Fri, 25 Aug 2023 06:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZUM3-0006Ao-Iz; Fri, 25 Aug 2023 06:47:51 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZUM0-0001gu-Ky; Fri, 25 Aug 2023 06:47:51 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bc83a96067so6520965ad.0; 
 Fri, 25 Aug 2023 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692960466; x=1693565266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TxVNCt55j2RDXKCtEFmWtR8i3BWYROEgmzJcjpsl2I=;
 b=f7J+4JAJzRwpnwsC71h3WVUJcMgRHtfGIcNmehYWs0HtDRYiHnmLlnUoUkuDQELYPm
 YqZAlR+gw38tzM0uYxzX8JyXGMRNGNPrH2WK8irVRFfySoBjeBQ+Nd/4lDJ5HqP0aAf/
 DNTL5d/2OcPpVho0byQ+ZLpShFnY8sA7ZiOEoburpgCFWjiWotA84T5bGZDIhUUy80BA
 ZZUIfW3bJ35yhr5fGLXh287bDxmt+jRANiubmrVEJC48yf+8plAM6/HDo0RIU14fv7Ld
 tVyxg6uADyK4zZv5MK9aAzagY04AFFByaWDPP9Qiin+EViGQf3PORdUgZ4gi06KiCTJN
 8SuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960466; x=1693565266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TxVNCt55j2RDXKCtEFmWtR8i3BWYROEgmzJcjpsl2I=;
 b=jzVta6W+COSEsIXBvJ/xxkcqMP7Q8rMYaPvlxcg2vQBFjhetsMgr1jS3sZfrmLTux1
 bav3Z2R7wYgj9jeYkUinXjYxAQvGwAjqvzyNzIes6oBw1CE/7JMEN26OsoHd6yDJaP3m
 1frkKyIw6e1ZKfReezf8ZS8nFd6TGhzZUgDk1hl7A09FqbbRcPAA5otWtcS+WyEZnOgm
 j/3dN1lc/GPpL6TjrJQ+FJZbfJrRe8f1gFKMhgC0LzZNUEkS5zpTOepx31V2OBjo49UA
 RGEkkcoRIViaBL06njIQIc8T5M0HakGHw0high76UrtEVCOU23L/pvR9eYJSajyP8A5u
 TR3Q==
X-Gm-Message-State: AOJu0YyzRbHw4Xm7PKE7wpnI02m6VELPrXUfXwUZsHnDp87zdjlOMcaW
 6c34VjSRXoUrQGP6sTuXVoYRZW9pBW9rXA==
X-Google-Smtp-Source: AGHT+IGwNQXBLkt/tZUfLHQDHKGVorrQMZwJmOPJDoJizzGzA2lRKzWccVtkUx9jmBzjATNGcohu4g==
X-Received: by 2002:a17:902:c18b:b0:1be:f2a1:22d8 with SMTP id
 d11-20020a170902c18b00b001bef2a122d8mr15134951pld.14.1692960466320; 
 Fri, 25 Aug 2023 03:47:46 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001b89891bfc4sm1346985plg.199.2023.08.25.03.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:47:45 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC v5 08/10] target/arm: Add support for native library calls
Date: Fri, 25 Aug 2023 18:45:24 +0800
Message-Id: <20230825104526.1754950-9-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
References: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x633.google.com
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
 target/arm/tcg/translate-a64.c         | 31 ++++++++++++++++++++++++++
 target/arm/tcg/translate.c             | 28 +++++++++++++++++++++++
 target/arm/tcg/translate.h             |  5 +++++
 5 files changed, 66 insertions(+)

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
index 3baab6aa60..0cb9228a35 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -25,6 +25,8 @@
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
 #include "cpregs.h"
+#include "exec/cpu_ldst.h"
+#include "native/native.h"
 
 static TCGv_i64 cpu_X[32];
 static TCGv_i64 cpu_pc;
@@ -2400,6 +2402,10 @@ static bool trans_HLT(DisasContext *s, arg_i *a)
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
@@ -13392,6 +13398,24 @@ void gen_gvec_rax1(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &op);
 }
 
+static void gen_native_call(CPUState *cpu, DisasContext *s, CPUARMState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    TCGv_i64 arg1 = tcg_temp_new_i64();
+    TCGv_i64 arg2 = tcg_temp_new_i64();
+    TCGv_i64 arg3 = tcg_temp_new_i64();
+    TCGv_i64 ret = tcg_temp_new_i64();
+    uint64_t func_tmp = translator_ldq_swap(env, &s->base, s->base.pc_next,
+                                            bswap_code(s->sctlr_b));
+    char *func_name = g2h(cpu, func_tmp);
+    tcg_gen_mov_i64(arg1, cpu_reg(s, 0));
+    tcg_gen_mov_i64(arg2, cpu_reg(s, 1));
+    tcg_gen_mov_i64(arg3, cpu_reg(s, 2));
+    gen_native_call_i64(func_name, ret, arg1, arg2, arg3);
+    tcg_gen_mov_i64(cpu_reg(s, 0), ret);
+#endif
+}
+
 /* Crypto three-reg SHA512
  *  31                   21 20  16 15  14  13 12  11  10  9    5 4    0
  * +-----------------------+------+---+---+-----+--------+------+------+
@@ -13950,6 +13974,13 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
     uint64_t pc = s->base.pc_next;
     uint32_t insn;
 
+    if (native_bypass_enabled() && s->native_call_status) {
+        gen_native_call(cpu, s, env);
+        s->base.pc_next = pc + 8;
+        s->native_call_status = false;
+        return;
+    }
+
     /* Singlestep exceptions have the highest priority. */
     if (s->ss_active && !s->pstate_ss) {
         /* Singlestep state is Active-pending.
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 13c88ba1b9..d5eaed65f5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -28,6 +28,8 @@
 #include "semihosting/semihost.h"
 #include "cpregs.h"
 #include "exec/helper-proto.h"
+#include "exec/cpu_ldst.h"
+#include "native/native.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
@@ -1125,6 +1127,21 @@ void gen_lookup_tb(DisasContext *s)
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
+    char *func_name = g2h(cpu, func_tmp);
+    gen_native_call_i32(func_name, ret, arg1, arg2, arg3);
+    store_reg(dc, 0, ret);
+#endif
+}
+
 static inline void gen_hlt(DisasContext *s, int imm)
 {
     /* HLT. This has two purposes.
@@ -1139,6 +1156,10 @@ static inline void gen_hlt(DisasContext *s, int imm)
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
@@ -9329,6 +9350,13 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
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


