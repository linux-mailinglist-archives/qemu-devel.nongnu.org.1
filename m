Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1257C8C18
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLg4-00010f-Qu; Fri, 13 Oct 2023 13:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg3-0000zu-CA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:19 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg1-0005UZ-Ng
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:19 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-57bb6a2481fso1235278eaf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217016; x=1697821816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPve6f7zLeYUZnfvyB8rknIVGRQNk3b6m8Mg7HCCt/Y=;
 b=Msl+ZWCw9E/diUA61MA/XWkW8wsBPWy/v6ueOOhlZoENWJn1bV0d9/vqJO1lA81ULf
 +JQ6NMh4d15N1H4wphJVSMdW7mL7Jz8fBSad1OWOQjP3HFkHCvNPsuuuHqhsnH5+evRT
 p+1uh0GiX4kHUj4RTxLTGyIu9BfslmQ1E2h9hylC6HZEcEeFqfiyYTo42+YXcl996Xp1
 UN4jvKwE1Ct+Vb1M5lfximThX6Q3i1Bn4hgYCV3eLT4fc3V/NszpKHW+2T77IjnOqtR9
 LRT0CVdGwRvVWdph/XLQXS0JGV4GW+lzObV6r61EtM+3w1K7Zebso6mZiluWpZiO1kIQ
 /M4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217016; x=1697821816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPve6f7zLeYUZnfvyB8rknIVGRQNk3b6m8Mg7HCCt/Y=;
 b=i0u0DgapUwi1xDcpAAxxr3+7X4doxyW5uDoKm6QtDF5GmXpilwXhg0chYLbBNEzurT
 Pd2liG/LQK5GOoL35Ok6Gq/eJiesNBryDO10n1AyBZbR4RZidJGibqo5dr+YJ5cIso7M
 t4dDrfXuchMWto+jy857VrgS/H+2a3NrP57r3Z3a7P1mzWABjI1emQRtzv38cuW3y1wh
 1Zpb9t0TGR4TkMACv7XO7dLv2j7fHjzoIE4z3GqW/u7qve0b9hUNHe30zrtMus+a0j+O
 7jbJNXlSnbHzmRi37z4SAaHcIFfDM7ulpPgT0UsIlqsZAO8GfXxxbreMCI/cVwDjDa3k
 06Qw==
X-Gm-Message-State: AOJu0YxbyG9YnQTmS8WWo/4cJKIvmNWJp2khZ31JN+G2xvqH/8yyeq/O
 wjJDYWFtNV3HrV8a5CP39Mov7czlePB81almhig=
X-Google-Smtp-Source: AGHT+IFHSya7bZFoOCKgsE2LSJXa9hsi88cxnndqaSC6uGSqicZnxxcuefw8R4f7WBwAlUj/otLjDQ==
X-Received: by 2002:a05:6358:5e12:b0:143:9b25:c021 with SMTP id
 q18-20020a0563585e1200b001439b25c021mr16672897rwn.1.1697217015841; 
 Fri, 13 Oct 2023 10:10:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 02/13] tcg/ppc: Enable direct branching tcg_out_goto_tb
 with TCG_REG_TB
Date: Fri, 13 Oct 2023 10:10:01 -0700
Message-Id: <20231013171012.122980-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

From: Jordan Niethe <jniethe5@gmail.com>

Direct branch patching was disabled when using TCG_REG_TB in commit
736a1588c1 ("tcg/ppc: Fix race in goto_tb implementation").

The issue with direct branch patching with TCG_REG_TB is the lack of
synchronization between the new TCG_REG_TB being established and the
direct branch being patched in.

If each translation block is responsible for establishing its own
TCG_REG_TB then there can be no synchronization issue.

Make each translation block begin by setting up its own TCG_REG_TB.
Use the preferred 'bcl 20,31,$+4' sequence.

Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
[rth: Split out tcg_out_tb_start, power9 addpcis]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 48 ++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 5cecc6ed95..9197cfd6c6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2509,9 +2509,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out32(s, MTSPR | RS(tcg_target_call_iarg_regs[1]) | CTR);
-    if (USE_REG_TB) {
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
-    }
     tcg_out32(s, BCCTR | BO_ALWAYS);
 
     /* Epilogue */
@@ -2529,7 +2526,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
 static void tcg_out_tb_start(TCGContext *s)
 {
-    /* nothing to do */
+    /* Load TCG_REG_TB. */
+    if (USE_REG_TB) {
+        /* bcl 20,31,$+4 (preferred form for getting nia) */
+        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
+        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -4));
+    }
 }
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t arg)
@@ -2542,32 +2545,22 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 {
     uintptr_t ptr = get_jmp_target_addr(s, which);
 
+    /* Direct branch will be patched by tb_target_set_jmp_target. */
+    set_jmp_insn_offset(s, which);
+    tcg_out32(s, NOP);
+
+    /* When branch is out of range, fall through to indirect. */
     if (USE_REG_TB) {
         ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
-        tcg_out_mem_long(s, LD, LDX, TCG_REG_TB, TCG_REG_TB, offset);
-    
-        /* TODO: Use direct branches when possible. */
-        set_jmp_insn_offset(s, which);
-        tcg_out32(s, MTSPR | RS(TCG_REG_TB) | CTR);
-
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-
-        /* For the unlinked case, need to reset TCG_REG_TB.  */
-        set_jmp_reset_offset(s, which);
-        tcg_out_mem_long(s, ADDI, ADD, TCG_REG_TB, TCG_REG_TB,
-                         -tcg_current_code_size(s));
+        tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
     } else {
-        /* Direct branch will be patched by tb_target_set_jmp_target. */
-        set_jmp_insn_offset(s, which);
-        tcg_out32(s, NOP);
-
-        /* When branch is out of range, fall through to indirect. */
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1, (int16_t)ptr);
-        tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
-        tcg_out32(s, BCCTR | BO_ALWAYS);
-        set_jmp_reset_offset(s, which);
     }
+
+    tcg_out32(s, MTSPR | RS(TCG_REG_TMP1) | CTR);
+    tcg_out32(s, BCCTR | BO_ALWAYS);
+    set_jmp_reset_offset(s, which);
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -2577,10 +2570,6 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     intptr_t diff = addr - jmp_rx;
     tcg_insn_unit insn;
 
-    if (USE_REG_TB) {
-        return;
-    }
-
     if (in_range_b(diff)) {
         insn = B | (diff & 0x3fffffc);
     } else {
@@ -2600,9 +2589,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out32(s, MTSPR | RS(args[0]) | CTR);
-        if (USE_REG_TB) {
-            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, args[0]);
-        }
         tcg_out32(s, ADDI | TAI(TCG_REG_R3, 0, 0));
         tcg_out32(s, BCCTR | BO_ALWAYS);
         break;
-- 
2.34.1


