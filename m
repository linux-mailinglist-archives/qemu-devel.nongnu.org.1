Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E8977D3BD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Aq-000558-5g; Tue, 15 Aug 2023 15:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ao-00054F-R7
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:50 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Ak-00012w-Vq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so4570515b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129465; x=1692734265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RJZ6ogXJOw0J2MAEkk8rAYiluI26jV6bi5dyyeMPndQ=;
 b=N1rwoCLAkpOk1w3Q52F5mzB5eW4FeBZDJvV2mB7t55UNEodUfKbTMDVuhX/p/Rq84s
 weJhPxuCrLhpZW70b9dg6PlNe9mZQKA4A3VxvQFd3ev661LeIt27TwjomSWDqwP8srDp
 oYd5FBiI8qVk44FNri8iEhApbltB3X4/xnvMoh1e/6/7itBV3Baw1hO4cwM9Y0yxD5+G
 EhbDQfvbxZkfcBvKvQQJSTGYoM/rCUKVTGxSD5f7a0GSk5QWCQ1Q2BAoiBAGUydvtv+n
 5KB66mUNMkxaDNR+6IU7CPGmp84ncpZXqWnREn8nMInd6vPRDR5Hk1Ma2utjbgWR/HFe
 6gYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129465; x=1692734265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJZ6ogXJOw0J2MAEkk8rAYiluI26jV6bi5dyyeMPndQ=;
 b=EgoLyE5b5ZDupZOPPLH0FocdRIF7AOGWEG8CdvYMtJmKQdSt3HfBTcKffistaiSlEg
 q6hU50f5p/DuVkYhhZ/NJaglPXRn7S74ToWsqsLRbxBFLoFFJ5u3E2AMWSm2p6xRTdi0
 P7WNEvTLsILL5Ht3gu1T5zsIehDywgIS/cT4jmAo4GgyB39O/zxKU8au3e4m0jYk6e7y
 9GP5fV8e8YOftNuwYGE/ZWpv3Lfqz9dgyphDpbZ9KG/BPsz4TPt9jKyqFCbswpNuGlGo
 eg1Y5xDCUc3pBGnKazNxAMXLOPDKG5zIs7Uszkh8LEretwiaicTmKaaAIpGyhjiBSZJE
 7j7g==
X-Gm-Message-State: AOJu0YyqekGQIc6/jWMRiEp7xPwJWP3ZnyPifY5bYyz4SszYqaDO3cvj
 1D/G89gMtso1SgwE/WVsrMyBDLKXShexWd5EWb8=
X-Google-Smtp-Source: AGHT+IHZib8IuC9nI61INci0AIgBLbg743/dbiv7LnPGv44cVSstcdLeCxzk6tT38zy3PbFPI0g9NQ==
X-Received: by 2002:a05:6a00:181f:b0:676:8fac:37 with SMTP id
 y31-20020a056a00181f00b006768fac0037mr3757658pfa.4.1692129465544; 
 Tue, 15 Aug 2023 12:57:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 03/14] tcg/ppc: Enable direct branching tcg_out_goto_tb
 with TCG_REG_TB
Date: Tue, 15 Aug 2023 12:57:30 -0700
Message-Id: <20230815195741.8325-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 97b7697921..134a9bbcb6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2464,9 +2464,6 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out32(s, MTSPR | RS(tcg_target_call_iarg_regs[1]) | CTR);
-    if (USE_REG_TB) {
-        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
-    }
     tcg_out32(s, BCCTR | BO_ALWAYS);
 
     /* Epilogue */
@@ -2484,7 +2481,13 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
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
@@ -2497,32 +2500,22 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
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
@@ -2532,10 +2525,6 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     intptr_t diff = addr - jmp_rx;
     tcg_insn_unit insn;
 
-    if (USE_REG_TB) {
-        return;
-    }
-
     if (in_range_b(diff)) {
         insn = B | (diff & 0x3fffffc);
     } else {
@@ -2555,9 +2544,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
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


