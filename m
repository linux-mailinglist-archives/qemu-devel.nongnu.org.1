Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F31927D62CE
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIT-0000BJ-NX; Wed, 25 Oct 2023 03:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIR-0000A8-HH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIO-0004es-Ne
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9d407bb15so45170955ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218835; x=1698823635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grrY6KBqyVlmw+Y1FqG6v+fB0Wl2pAJYFymCVdGaSh4=;
 b=keYtgttdDxHs5olsMwSEr9Q66+Vk9C5LnGpB8EXFezU3EUmtiKkM2W3sBvZlHGCHQs
 gKIjw08FJhhA7egPKBKWEl/1CsoxHnaHY7fiVKRse62XnZYGEzIBvthow2N6jvfx4SK0
 gtUrIIBsmAcCObZqiJblXHp/PQ5WNRtd/Wm+QWJ3N4/lnklz0ihhQlt/urLneveI5U8v
 2f+b5xstVui70hxWmKO4erAEXfgGg9IgPeN1AjDSYnbGt+6WDfKMfzdqcxSig+1nON5d
 iCb6pfY4KN/yJPyLg5R/WVF2f0kfihNQNb8Dx7wii/XCCHqKPDWRTatlkcC2ahgjIt5U
 nXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218835; x=1698823635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grrY6KBqyVlmw+Y1FqG6v+fB0Wl2pAJYFymCVdGaSh4=;
 b=waMkezzg97OCDGtx2NPNM4kKFoJ9el2yrbdGYv9GkNYcUpQ6B2Wze+0uGt8ol4rHCa
 qXL5j6514bXfZQ0jYW1xEF+MvJCnZNxKXhD53kp3xFiissfCchfSU4bTODMFCVTh6YLD
 Pexu4hxybunhAYPWDJG0ubXoBmWKTZnw2qGuKJFliY5f/eyAue36u2Ydju2FZozgllGk
 3skQp0JU1hUhefmHwVeBrHGDv+wOWPA8yRza9gLD9AVCgKoqtUFgrt/dVsPVgcsMWThS
 67zjULFgyy7/TcKdsQt03tqO6/0s8bXjirqQ64+GJWFHThlldYyjqSyvJYMjua60hvaI
 QkJg==
X-Gm-Message-State: AOJu0YxWZCNnJTatMV0o3gsjEwT3cba9RTrR7264yRNkRsWuD25g1bwL
 hC8tzaxfeA3bKiToXlT111cBa3h+JgoTxjUQr+k=
X-Google-Smtp-Source: AGHT+IHH9/LYnDZiZVFFfRh721IWIOC3vtyn96fAe9lxjgDhP1OTqHTvN0o4hLJxtVZSsz5RhD/cYw==
X-Received: by 2002:a17:903:4113:b0:1ca:72f9:253a with SMTP id
 r19-20020a170903411300b001ca72f9253amr13093175pld.23.1698218835454; 
 Wed, 25 Oct 2023 00:27:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 07/29] tcg/aarch64: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:45 -0700
Message-Id: <20231025072707.833943-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  4 +--
 tcg/aarch64/tcg-target.c.inc     | 58 +++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 3fdee26a3d..a927cd11a2 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -10,7 +10,7 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(r, rA)
+C_O0_I2(r, rAL)
 C_O0_I2(rZ, r)
 C_O0_I2(w, r)
 C_O0_I3(rZ, rZ, r)
@@ -31,6 +31,6 @@ C_O1_I2(w, w, wN)
 C_O1_I2(w, w, wO)
 C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
-C_O1_I4(r, r, rA, rZ, rZ)
+C_O1_I4(r, r, rAL, rZ, rZ)
 C_O2_I1(r, r, r)
 C_O2_I4(r, r, rZ, rZ, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index a3efa1e67a..2a748b3ee3 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -344,6 +344,9 @@ static const enum aarch64_cond_code tcg_cond_to_aarch64[] = {
     [TCG_COND_GTU] = COND_HI,
     [TCG_COND_GEU] = COND_HS,
     [TCG_COND_LEU] = COND_LS,
+    /* bit test */
+    [TCG_COND_TSTEQ] = COND_EQ,
+    [TCG_COND_TSTNE] = COND_NE,
 };
 
 typedef enum {
@@ -1341,20 +1344,35 @@ static inline void tcg_out_dep(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_bfm(s, ext, rd, rn, a, b);
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGReg a,
+static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGCond cond, TCGReg a,
                         tcg_target_long b, bool const_b)
 {
-    if (const_b) {
-        /* Using CMP or CMN aliases.  */
-        if (b >= 0) {
-            tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
-        } else {
-            tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+    if (is_tst_cond(cond)) {
+        if (const_b) {
+            if (is_limm(b)) {
+                tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, a, b);
+                return;
+            }
+            tcg_out_movi(s, ext, TCG_REG_TMP0, b);
+            b = TCG_REG_TMP0;
         }
-    } else {
-        /* Using CMP alias SUBS wzr, Wn, Wm */
-        tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
+        tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
+        return;
     }
+
+    if (const_b) {
+        if (is_aimm(b)) {
+            tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
+            return;
+        }
+        if (is_aimm(-b)) {
+            tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+            return;
+        }
+        tcg_out_movi(s, ext, TCG_REG_TMP0, b);
+        b = TCG_REG_TMP0;
+    }
+    tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
 }
 
 static void tcg_out_goto(TCGContext *s, const tcg_insn_unit *target)
@@ -1401,7 +1419,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         need_cmp = false;
     } else {
         need_cmp = true;
-        tcg_out_cmp(s, ext, a, b, b_const);
+        tcg_out_cmp(s, ext, c, a, b, b_const);
     }
 
     if (!l->has_value) {
@@ -1574,7 +1592,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
     } else {
         AArch64Insn sel = I3506_CSEL;
 
-        tcg_out_cmp(s, ext, a0, 0, 1);
+        tcg_out_cmp(s, ext, TCG_COND_NE, a0, 0, 1);
         tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP0, a1);
 
         if (const_b) {
@@ -1719,7 +1737,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                          addr_adj, compare_mask);
 
         /* Perform the address comparison. */
-        tcg_out_cmp(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2, 0);
+        tcg_out_cmp(s, addr_type, TCG_COND_NE, TCG_REG_TMP0, TCG_REG_TMP2, 0);
 
         /* If not equal, we jump to the slow path. */
         ldst->label_ptr[0] = s->code_ptr;
@@ -2275,7 +2293,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_setcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSET alias of CSINC Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINC, TCG_TYPE_I32, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
@@ -2285,7 +2303,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_negsetcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
@@ -2295,7 +2313,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_movcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[5], a1, a2, c2);
         tcg_out_insn(s, 3506, CSEL, ext, a0, REG0(3), REG0(4), args[5]);
         break;
 
@@ -2895,11 +2913,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
+        return C_O1_I2(r, r, rA);
+
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rA);
+        return C_O1_I2(r, r, rAL);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
@@ -2949,11 +2969,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rA);
+        return C_O0_I2(r, rAL);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rA, rZ, rZ);
+        return C_O1_I4(r, r, rAL, rZ, rZ);
 
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
-- 
2.34.1


