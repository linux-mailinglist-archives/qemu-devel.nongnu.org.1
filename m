Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724667D62BA
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIT-0000BO-RM; Wed, 25 Oct 2023 03:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIR-0000AB-Ih
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:19 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIP-0004f5-IS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:19 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b5af4662b7so4538789b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218836; x=1698823636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TM/KRrd2eN3gH2XezGt/xyNTAB3pmf+w8+Xiugmh0j8=;
 b=wKJM9KqdB4lIrhwrgp98fVCv6i8NfzafP1vHJDA0hNwALcs6JWASJJdX6rtXRGPV5I
 oykVT+Nw3qXNIEHbneZgb95wrp6a+NUv70n2zF7No37VQPFqQouIf9/f0mibkaWzeq20
 OJoLJ6tYiwGSbzNcH142nnQ0t4fZQ3y5aC2HU7f/ffKnH2sbSYuSgSvsW3TOoND3nQXf
 mbDswcWrzdR0atpFtFCFjBHSCsd8B54uyHCS0peymXR0/rdRIQFr+0MD3qNbam53oJMH
 lHGPQiG/6tmprgukt7OCj2APmJRYlVG+fIZCxp9Ba4WuaNnvQZbphdIKJjaRkRQr/lSh
 Yb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218836; x=1698823636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TM/KRrd2eN3gH2XezGt/xyNTAB3pmf+w8+Xiugmh0j8=;
 b=QzxEcEaTJNMrFRIemJKPgBHslFyEakw0v7lJlxjMknoo7kGujOQENp1N7yiaWBb02U
 +Awi0WLPNGZK7rxpZZC5jLgTB8PDM/IsPX3ufxIgUgVve4+zHuEgUq9Z1vZX15kDEeTZ
 xZbHvUTITcDgpVl+dVr3AcLw6gxZu4xOgsTQS2ISRU0gl8nrjlYfKarYV1zz1J+wf+T0
 Dq4Y2prMnm7d44w4t7/8Vs0SEEczOq9AQOPju1LgPDeA6F6AKXpNjs81vMSv2/MBAaGt
 Uxj84eIc54VMhauYirjIM/BmNlWqcFwWXuOAdEZW2Xw5c7IyXM2qoPBgKaMgO5LBsCpr
 Ed7w==
X-Gm-Message-State: AOJu0Yyq3BDB2FW+oRzLAHevt0ZcqAO7hiKDpdzyjNofSkLdQU0NE0tq
 sZe/aIJxsXk5PG9E8XZ8kLdUeStQ6uU2Ul7lAMw=
X-Google-Smtp-Source: AGHT+IEGwmXP95QKvubIY45Gp/ieJGJ2hKjBjjVAyUlpTjanOl7XVvMS198bWRbfP/f82XUtOGb+kA==
X-Received: by 2002:a05:6a21:3298:b0:17b:689e:c757 with SMTP id
 yt24-20020a056a21329800b0017b689ec757mr5331756pzb.11.1698218836308; 
 Wed, 25 Oct 2023 00:27:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 08/29] tcg/aarch64: Generate TBZ, TBNZ
Date: Wed, 25 Oct 2023 00:26:46 -0700
Message-Id: <20231025072707.833943-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Test the sign bit for LT/GE vs 0, and TSTNE/EQ vs a power of 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 100 ++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 2a748b3ee3..e65fc415d2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -105,6 +105,18 @@ static bool reloc_pc19(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t offset = target - src_rx;
+
+    if (offset == sextract64(offset, 0, 14)) {
+        *src_rw = deposit32(*src_rw, 5, 14, offset);
+        return true;
+    }
+    return false;
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -115,6 +127,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         return reloc_pc26(code_ptr, (const tcg_insn_unit *)value);
     case R_AARCH64_CONDBR19:
         return reloc_pc19(code_ptr, (const tcg_insn_unit *)value);
+    case R_AARCH64_TSTBR14:
+        return reloc_pc14(code_ptr, (const tcg_insn_unit *)value);
     default:
         g_assert_not_reached();
     }
@@ -369,6 +383,10 @@ typedef enum {
     /* Conditional branch (immediate).  */
     I3202_B_C       = 0x54000000,
 
+    /* Test and branch (immediate).  */
+    I3205_TBZ       = 0x36000000,
+    I3205_TBNZ      = 0x37000000,
+
     /* Unconditional branch (immediate).  */
     I3206_B         = 0x14000000,
     I3206_BL        = 0x94000000,
@@ -649,6 +667,14 @@ static void tcg_out_insn_3202(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | tcg_cond_to_aarch64[c] | (imm19 & 0x7ffff) << 5);
 }
 
+static void tcg_out_insn_3205(TCGContext *s, AArch64Insn insn,
+                              TCGReg rt, int imm6, int imm14)
+{
+    insn |= (imm6 & 0x20) << (31 - 5);
+    insn |= (imm6 & 0x1f) << 19;
+    tcg_out32(s, insn | (imm14 & 0x3fff) << 5 | rt);
+}
+
 static void tcg_out_insn_3206(TCGContext *s, AArch64Insn insn, int imm26)
 {
     tcg_out32(s, insn | (imm26 & 0x03ffffff));
@@ -1412,30 +1438,66 @@ static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
 static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
                            TCGArg b, bool b_const, TCGLabel *l)
 {
-    intptr_t offset;
-    bool need_cmp;
+    int tbit = -1;
+    bool need_cmp = true;
 
-    if (b_const && b == 0 && (c == TCG_COND_EQ || c == TCG_COND_NE)) {
-        need_cmp = false;
-    } else {
-        need_cmp = true;
-        tcg_out_cmp(s, ext, c, a, b, b_const);
-    }
-
-    if (!l->has_value) {
-        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
-        offset = tcg_in32(s) >> 5;
-    } else {
-        offset = tcg_pcrel_diff(s, l->u.value_ptr) >> 2;
-        tcg_debug_assert(offset == sextract64(offset, 0, 19));
+    switch (c) {
+    case TCG_COND_EQ:
+    case TCG_COND_NE:
+        if (b_const && b == 0) {
+            need_cmp = false;
+        }
+        break;
+    case TCG_COND_LT:
+    case TCG_COND_GE:
+        if (b_const && b == 0) {
+            c = (c == TCG_COND_LT ? TCG_COND_TSTNE : TCG_COND_TSTEQ);
+            tbit = ext ? 63 : 31;
+            need_cmp = false;
+        }
+        break;
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        if (b_const && is_power_of_2(b)) {
+            tbit = ctz64(b);
+            need_cmp = false;
+        }
+        break;
+    default:
+        break;
     }
 
     if (need_cmp) {
-        tcg_out_insn(s, 3202, B_C, c, offset);
-    } else if (c == TCG_COND_EQ) {
-        tcg_out_insn(s, 3201, CBZ, ext, a, offset);
+        tcg_out_cmp(s, ext, c, a, b, b_const);
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
+        tcg_out_insn(s, 3202, B_C, c, 0);
+        return;
+    }
+
+    if (tbit >= 0) {
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_TSTBR14, l, 0);
+        switch (c) {
+        case TCG_COND_TSTEQ:
+            tcg_out_insn(s, 3205, TBZ, a, tbit, 0);
+            break;
+        case TCG_COND_TSTNE:
+            tcg_out_insn(s, 3205, TBNZ, a, tbit, 0);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
+        switch (c) {
+        case TCG_COND_EQ:
+            tcg_out_insn(s, 3201, CBZ, ext, a, 0);
+            break;
+        case TCG_COND_NE:
+            tcg_out_insn(s, 3201, CBNZ, ext, a, 0);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
-- 
2.34.1


