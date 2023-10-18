Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D48AF7CEB33
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzN-00082L-NV; Wed, 18 Oct 2023 18:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzM-00081E-8S
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:04 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzK-0002Rx-CZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9b95943beso62303205ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667961; x=1698272761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPve6f7zLeYUZnfvyB8rknIVGRQNk3b6m8Mg7HCCt/Y=;
 b=LyqoCBKSXgOhNbFpNyFcfdyaUoJkRNT6j5UddR8E7CzsoyNFfcodk2uFIAPG58mP16
 37Ro+FCgQUdETT0+oAiyUBaYSGmBetBze048O+ExcSS1k/7tLSQeMplqaQSt21dXhD1u
 RQUIJgXpoh1QYm9SoN4wb3sA/gOZs2F+tRBWZw601Sxxks4TCFevot8mBfuycTLfzzCh
 3qvDcYFmTfz0/KLn0g8qGEpUNSxH10fdoP++OOTdpRqSsymw9xexjvw0e9E1RN1k+LaR
 pLJnSzIfwttxWk3vAvPAvkulhkh+tbCkIj+Kb9UXF+KZpIInyIoliKtYL79+B2xp0Khx
 mYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667961; x=1698272761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPve6f7zLeYUZnfvyB8rknIVGRQNk3b6m8Mg7HCCt/Y=;
 b=Oqdi7xAoF+JIqLWzFZXToTgZYZlyviNVZvP1IZdgyAYzXYKHGNtcW+e4k/PxB490KU
 5EA0Ab3J/wp6Uik12R6l5KFlciJozqX3NRqCTcw5dM0jRT7B1Xa0yUDx/29ITkrr13F1
 dojYgx1q95/Dbqsfx0zV0N4PNXUH2YW3+CDZeO29oLbS7o7B6Ahgf+/c43pehP8ddZX+
 mjJm9uALYDLG0IXvtkUSOstyjfkVjwJXqJYnlZOOJnfoQT7gmHgNSQJWlioi2Ewmk2Ax
 0gJKJpywC3zM7rD52QrtpAQru5qY4LrevgjJi4ye0ZPLD1sexADBMF4mnSa/+3Caksze
 4m9Q==
X-Gm-Message-State: AOJu0YxMHkHHSXPYX2qZPVV7ZgKhFrUZRcp8vOc19jwaOMh9M9Rfkb83
 Rmn9EbfWldjTAf4VUopdnbWNzsX8uq21/t7/N2I=
X-Google-Smtp-Source: AGHT+IHUF7TbNMAlf7TBvanqhJidbhc+e5abNlYPu5dK+LN38NeW4kN97JV9VLLIpSQDAb7onTJLIA==
X-Received: by 2002:a17:903:228b:b0:1c9:b196:d294 with SMTP id
 b11-20020a170903228b00b001c9b196d294mr887746plh.20.1697667960944; 
 Wed, 18 Oct 2023 15:26:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jordan Niethe <jniethe5@gmail.com>
Subject: [PULL 02/29] tcg/ppc: Enable direct branching tcg_out_goto_tb with
 TCG_REG_TB
Date: Wed, 18 Oct 2023 15:25:30 -0700
Message-Id: <20231018222557.1562065-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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


