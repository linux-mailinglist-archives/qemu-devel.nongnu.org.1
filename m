Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 284387D3EFB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQv-0005VT-J8; Mon, 23 Oct 2023 14:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQq-0005Ti-DI
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:40 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQk-000854-KF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:40 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5a1d89ff4b9so1869125a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084813; x=1698689613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPve6f7zLeYUZnfvyB8rknIVGRQNk3b6m8Mg7HCCt/Y=;
 b=mHaPp5Sc8KUo2G09Y6mouormtju1BZf6HjGq1pX+3BL2AV6k8dtaHDML4wQcfOewfj
 OfDfJ0kfsLKf2Q9+lBUoHmp4VxirE7ejZD89pvsUMcCNjReeGaViaYYa/D6KmaKiFbUQ
 658RNPCqQlMyQfstnJY+JPTXIJBbKdL1kj6PQ2fkcwC8duvIW/JW9G/a8cp32Uq709Ek
 gspVn5GZT+1bv+SFZZfEgHR6dFWqpqSzIKRBJwQh4ilCvYRZ+oywWmRg8r7Jgk7lDlYy
 0Dja1/sCNLvp2oNSQ89ns0LW2PVXlQSZbX6dRSz1oOgLCyLVmthx3qmCCsqnblBgY1Y0
 VWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084813; x=1698689613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPve6f7zLeYUZnfvyB8rknIVGRQNk3b6m8Mg7HCCt/Y=;
 b=wXJB5HFtPefa5zwu5fpbaa8jInVmH3DVGBrjoCt1Y1SXZ5Zgv2vp63UKOWz6oDN4AC
 7hE2StB3SrM05t5f2sVQJCs3IIU+Rv9Fz4VqbN/tSamonNFsC8KE1jiAngya7incOvN5
 vV9l4sqvVtu6EWs08K8NNnxKASar7TxeQZEpMHLRV0rb6o5R92YrI4Ll4nQ2/cuICSWH
 d5VAIhAwsnyKUoPTXVdCfH0QS9k+nlSVmKekkZrki2GMKRXb2+uUSF1LIpP1wMxr/v3b
 wWfQcaDfKB2IFXvFAUqwzxktkmWygNxcXwyEcznGTNCYKtm/rFBebrpr0HwK3hDi9KDQ
 Gxlg==
X-Gm-Message-State: AOJu0YxTNm1f/KmzUGxV5MlNe7jP/azPt6M7FiHSfBocRxQq2rz51NoX
 g/RarimFNyslCPIqhIgHe/ahzxudcpCxodv7W2g=
X-Google-Smtp-Source: AGHT+IH59+EoFVi72cLxRr1vKpplfUnND49lj5a/mv27f+HyDmTe5DawwM+F3/HxAF1IrvvAtFzMZA==
X-Received: by 2002:a05:6a20:54a6:b0:14c:a53c:498e with SMTP id
 i38-20020a056a2054a600b0014ca53c498emr354664pzk.42.1698084813052; 
 Mon, 23 Oct 2023 11:13:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jordan Niethe <jniethe5@gmail.com>
Subject: [PULL v3 02/38] tcg/ppc: Enable direct branching tcg_out_goto_tb with
 TCG_REG_TB
Date: Mon, 23 Oct 2023 11:12:53 -0700
Message-Id: <20231023181329.171490-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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


