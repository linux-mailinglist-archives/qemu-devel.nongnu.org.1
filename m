Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1908E7D7940
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2t-00077K-16; Wed, 25 Oct 2023 20:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2k-00070k-W3
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2g-0004r5-K8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:09 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cab2c24ecdso2241205ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279357; x=1698884157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TM/KRrd2eN3gH2XezGt/xyNTAB3pmf+w8+Xiugmh0j8=;
 b=bnZ+K/HU2vyv/jXoCms993r3lAslmTpDa61ludEN3Je88fislNbytASVpeFynI+ZhY
 R71qppsYXL/vwGBfHp1VF2GV7Zryg4k5fniXK2uvFn8Sxyqr6WK68zs0KIVHingxA5nZ
 rP7GZxyg/9wEzxNnGwOblMNB9ivLdOCsb+MxRfy82ggcGYQ76KLD7yGAk3RGCQtyjmy9
 5QaxTAjy7is1HCDD9LviSC8gCD500pggbCxeL/IW5ofUhaBz2zZIGv/MXErijn5Tu6n1
 ektd99NVVrxp4X5mslelI+jYYq05gtCW/rnrhfyQgBnKk2FSkLL+pJhVKBlxSaLI9jpO
 BZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279357; x=1698884157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TM/KRrd2eN3gH2XezGt/xyNTAB3pmf+w8+Xiugmh0j8=;
 b=WgSZcHMmpcICD+fAMIwKqcf21NJSz+UjkjFiKAM4PulmYmQDg+Qtp9QONlw3O8ejzQ
 M8sYOw3ItIelL3gh32D3KqQbr9hW/DavmZDEC0t2TndKsPm17fgtZ7vSdLHq8KFoJh5X
 e7x77A/yaLJZ73RAuIDfrATvQrsTZ8iEYoiPdaklN+V0CbTkvMbqgBxuJDDd8ynRqWpO
 sSEVWwVCHEbV7I+K90dicNZ2alkTCcrFXcA71fzPCowC9gPc/s4Fzc43UoEgJlqoT1Oz
 KlvvsJTLr8Dwj+QB0240opG08XC+FocOxkprVcqchlOQ/3m1YGgefhyprUNkfXcZbO0s
 Qy5w==
X-Gm-Message-State: AOJu0Yx95ENYag07Em5ensunowlOIyH3I7N07qQ4a2yPy7C9Ni483bSM
 9d8IK2n3w3c60lGXO3DZUgBiovS945hdfaaIsCA=
X-Google-Smtp-Source: AGHT+IGhptrmxvre5L7xlygyulNw9b4isrZK76fFkFtDu/BdCrrAs0Q3oSfYGK/F05mgWMLz6vsXMA==
X-Received: by 2002:a17:902:da83:b0:1c7:4973:7b34 with SMTP id
 j3-20020a170902da8300b001c749737b34mr16822669plx.50.1698279357577; 
 Wed, 25 Oct 2023 17:15:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/29] tcg/aarch64: Generate TBZ, TBNZ
Date: Wed, 25 Oct 2023 17:13:55 -0700
Message-Id: <20231026001542.1141412-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


