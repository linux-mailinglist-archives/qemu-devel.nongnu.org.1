Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399E37A2DC0
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1E-0006BH-SJ; Fri, 15 Sep 2023 23:30:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1C-0006AZ-Ny
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1B-00088K-1I
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:50 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68fc1bbc94eso2445516b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835048; x=1695439848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3/jJfVkW0tf04yhU55THuDqyGEOp0nDqt7BMAkf1kM=;
 b=xhMXqfiR9aMFXFH7lm+P6iZE/KL3w7mcH8HNsPwE5MtHva3JG8XAI6Mut3nHtHcJnx
 qhfuITplkbiuHW3DaE8PJqAn3chI2ej8VsBrQBL6c0iN5RO8U6ip/fu6qedDpSiVaTNj
 C0VC4aaDMTFOfN5jK5RKkqs5sncQXllCKBCmEpJxactlVXyTXzt0MSDbkXT04yD7v51X
 9gq+/yOXbOil99qSAQ/6uCtCa5D3Dzi6+fFOtG4Nm9TJ6+C+EJQ0E14qdxifTZnTox60
 +dnMbbvCSFya5WnaUXQP/bbzGC0nUpUeIZDvKDbYLm2zr2kwaB0NLC+UIXcvIrHNUhWa
 0sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835048; x=1695439848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3/jJfVkW0tf04yhU55THuDqyGEOp0nDqt7BMAkf1kM=;
 b=Qj9t5FYY5R/E5JMlQd8iyHvYf4K7Pi/mgStje0lbzC6goqTMUgUpJqhxNjBq4UmTap
 ynpt2PAOHZMR0ijGjPB23HXMXjnQjI0VQF4kdCr9Ap79rwVk5SKmyCyfHOAynyrj08k4
 iC0MHe5gbji3e7AkaKT5w1vPLaloN+rR8pDyNmQ5gV2Udu62vxUV/6ui62NY7z9rME94
 UYX7L5r1FEfeYP3hO3kwiksdnpLwnFSv2kPDzPIQZhASyz0mo8EP01LA5BMYFRkdrhwC
 w4/57ywmLywUQFqw+N+3Lt5P6P1tTxsAF8tZnY+d7FutAEs1WxB2AluyiOVINOl4oGXv
 1F4g==
X-Gm-Message-State: AOJu0YzNMhP9RwN/h+h3y2J3c6IpY7rCwqDF5OkrUIEHLFbjSSOZ1YbF
 Ikluzb3LRIg+LLeTCB7PySw4vP96y1t4xticixY=
X-Google-Smtp-Source: AGHT+IGdgYnvXogkEac3ZuPEte/k6xHWvbhy6W7tu4A1li1KhZRAgD68ICgAieAcwhqTzEAj5EPXOA==
X-Received: by 2002:a05:6a20:6a20:b0:12b:fe14:907e with SMTP id
 p32-20020a056a206a2000b0012bfe14907emr4420195pzk.20.1694835047860; 
 Fri, 15 Sep 2023 20:30:47 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 38/39] tcg/aarch64: Emit BTI insns at jump landing pads
Date: Fri, 15 Sep 2023 20:30:10 -0700
Message-Id: <20230916033011.479144-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The prologue is entered via "call"; the epilogue, each tb,
and each goto_tb continuation point are all reached via "jump".

As tcg_out_goto_long is only used by tcg_out_exit_tb, merge
the two functions.  Change the indirect register used to
TCG_REG_TMP1, aka X17, so that the BTI condition created
is "jump" instead of "jump or call".

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 54 ++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a0b65029d4..06ea3c7652 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -602,6 +602,10 @@ typedef enum {
     DMB_ISH         = 0xd50338bf,
     DMB_LD          = 0x00000100,
     DMB_ST          = 0x00000200,
+
+    BTI_C           = 0xd503245f,
+    BTI_J           = 0xd503249f,
+    BTI_JC          = 0xd50324df,
 } AArch64Insn;
 
 static inline uint32_t tcg_in32(TCGContext *s)
@@ -843,6 +847,17 @@ static void tcg_out_insn_3313(TCGContext *s, AArch64Insn insn,
               | rn << 5 | (rd & 0x1f));
 }
 
+static void tcg_out_bti(TCGContext *s, AArch64Insn insn)
+{
+    /*
+     * While BTI insns are nops on hosts without FEAT_BTI,
+     * there is no point in emitting them in that case either.
+     */
+    if (cpuinfo & CPUINFO_BTI) {
+        tcg_out32(s, insn);
+    }
+}
+
 /* Register to register move using ORR (shifted register with no shift). */
 static void tcg_out_movr(TCGContext *s, TCGType ext, TCGReg rd, TCGReg rm)
 {
@@ -1351,18 +1366,6 @@ static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
     tcg_out_insn(s, 3206, B, offset);
 }
 
-static void tcg_out_goto_long(TCGContext *s, const tcg_insn_unit *target)
-{
-    ptrdiff_t offset = tcg_pcrel_diff(s, target) >> 2;
-    if (offset == sextract64(offset, 0, 26)) {
-        tcg_out_insn(s, 3206, B, offset);
-    } else {
-        /* Choose X9 as a call-clobbered non-LR temporary. */
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X9, (intptr_t)target);
-        tcg_out_insn(s, 3207, BR, TCG_REG_X9);
-    }
-}
-
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *target)
 {
     ptrdiff_t offset = tcg_pcrel_diff(s, target) >> 2;
@@ -1947,12 +1950,28 @@ static const tcg_insn_unit *tb_ret_addr;
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 {
+    const tcg_insn_unit *target;
+    ptrdiff_t offset;
+
     /* Reuse the zeroing that exists for goto_ptr.  */
     if (a0 == 0) {
-        tcg_out_goto_long(s, tcg_code_gen_epilogue);
+        target = tcg_code_gen_epilogue;
     } else {
         tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_X0, a0);
-        tcg_out_goto_long(s, tb_ret_addr);
+        target = tb_ret_addr;
+    }
+
+    offset = tcg_pcrel_diff(s, target) >> 2;
+    if (offset == sextract64(offset, 0, 26)) {
+        tcg_out_insn(s, 3206, B, offset);
+    } else {
+        /*
+         * Only x16/x17 generate BTI type Jump (2),
+         * other registers generate BTI type Jump|Call (3).
+         */
+        QEMU_BUILD_BUG_ON(TCG_REG_TMP0 != TCG_REG_X16);
+        tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, (intptr_t)target);
+        tcg_out_insn(s, 3207, BR, TCG_REG_TMP0);
     }
 }
 
@@ -1970,6 +1989,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     tcg_out32(s, I3206_B);
     tcg_out_insn(s, 3207, BR, TCG_REG_TMP0);
     set_jmp_reset_offset(s, which);
+    tcg_out_bti(s, BTI_J);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -3074,6 +3094,8 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 {
     TCGReg r;
 
+    tcg_out_bti(s, BTI_C);
+
     /* Push (FP, LR) and allocate space for all saved registers.  */
     tcg_out_insn(s, 3314, STP, TCG_REG_FP, TCG_REG_LR,
                  TCG_REG_SP, -PUSH_SIZE, 1, 1);
@@ -3114,10 +3136,12 @@ static void tcg_target_qemu_prologue(TCGContext *s)
      * and fall through to the rest of the epilogue.
      */
     tcg_code_gen_epilogue = tcg_splitwx_to_rx(s->code_ptr);
+    tcg_out_bti(s, BTI_J);
     tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_X0, 0);
 
     /* TB epilogue */
     tb_ret_addr = tcg_splitwx_to_rx(s->code_ptr);
+    tcg_out_bti(s, BTI_J);
 
     /* Remove TCG locals stack space.  */
     tcg_out_insn(s, 3401, ADDI, TCG_TYPE_I64, TCG_REG_SP, TCG_REG_SP,
@@ -3137,7 +3161,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
-    /* nothing to do */
+    tcg_out_bti(s, BTI_J);
 }
 
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count)
-- 
2.34.1


