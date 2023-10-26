Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65767D7929
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2r-00074F-CW; Wed, 25 Oct 2023 20:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2i-00070O-SZ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:08 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2g-0004qy-1q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:08 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so2302255ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279356; x=1698884156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=grrY6KBqyVlmw+Y1FqG6v+fB0Wl2pAJYFymCVdGaSh4=;
 b=FGePbXHia/47HrRLGrtndW2+2aY4x623ldIxweBIbNCBhRXrUFa97njwFUwawP8VwU
 4R9GNu9Dy5PbjdI6lBtlGZHiNfQHnbfviDcorLMBxhMt2UFEWN3Lmn2l1PXnNGoDXCkM
 /WS1En6VaFr50Msa3c6LyGib3ldI6m1qt+09ZWNZ3HfCT9sUXYDsuOqsHLO4sUY12fTX
 caMxGUKAaFSUE/ZfIyCr8p+e84cXdE7HF+QfLT/NDBVtdj83kZplrkvdmu9JGX4y1aHp
 OBsKIzJZw6uN3peclBjf72OXIQ7x9x3yTRz6R3YIVsdU+g9YR30+psk3vbtjikqHBU23
 cfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279356; x=1698884156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grrY6KBqyVlmw+Y1FqG6v+fB0Wl2pAJYFymCVdGaSh4=;
 b=Wi05zQBZBbTa+ql3BZHkUhhZjodSi5bCNwFqApGgS4udGFKtDQZ9hIx5P38EAXEUpn
 gZpslRMXeYJ7UAvt1s2MD3m0io4G1mPImegAx8wH9PxZ7zserpGMXv11uCW3nRDm8ZL4
 qtg6MvyXBL6doaofoiXbikgTIXiJrIlFaojkpGM0lbe7TJJXeo7UqMOJRL299GbueAT7
 pHm43oknUWLhSM0ehNv/n2EKAvWJ5HdGaCf7zZJExWJsN5uW934PNaH6sFTNmNsjwLKx
 BZXqaS01eMbeUnDb5PnU5z/wGDJiClUXZXQmb8PDgGc+CQoOaHMEXUz/sPRTT+WXISYw
 0KLw==
X-Gm-Message-State: AOJu0YypVUQWvBLAZbRk/8c7OHY886+BJX76ORPLE5dg4u6IRiOK8Q4X
 p/5bGHt4W8YvXEpTYLFo/mO4jC4dpU7f72UmUGg=
X-Google-Smtp-Source: AGHT+IEKl8db+aC1Ok7b1+tcv83jMebpaJ5jl2963m8dXixiSp0bzn/7OUrvdTLzekFjW56mAKo4aw==
X-Received: by 2002:a17:902:ecce:b0:1ca:3241:c679 with SMTP id
 a14-20020a170902ecce00b001ca3241c679mr17639665plh.16.1698279356040; 
 Wed, 25 Oct 2023 17:15:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/29] tcg/aarch64: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:13:53 -0700
Message-Id: <20231026001542.1141412-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


