Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 559657DA909
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG5-0004xz-Q6; Sat, 28 Oct 2023 15:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFn-0004lV-8U
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFl-0004AE-FV
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc329ce84cso5536705ad.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522348; x=1699127148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iyWIBc/bae3SRvX15BHebB0rh43djQLxGZtPVa1AI4o=;
 b=aeh1SuNwgKh5r7B244wojGKeav1pj3rMb8TuM+oSpa1LH1SCYIXhefXDlQiS3P9CJp
 Rz2fPeFYH6weA7XgTMzLaCZbF7ghH0BbLQ7H1FWJrXlQ8qg3z13GD4/JgRhlthlS6QE8
 iu9Lan2HB6uxgM/btI1N+hjjOkas4RzToUEeb4xHv/LRlwU/uUKaSG7vqTERfSHqx1lc
 3iqSDBWdqRIvuuiKHFZ+fGJKpjidbQNMXTYjV4VTDL5pYeOo/W0nb3Ra3gc0IlBGWWsR
 5ewzfQ8PpTbQ/IAo1bIgfSMB+0meNMfJe+VY89k3DJJCX3jvEA8ljSLFTu32B/O/ywSd
 zGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522348; x=1699127148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iyWIBc/bae3SRvX15BHebB0rh43djQLxGZtPVa1AI4o=;
 b=fQ7Jt+LTcxy2l7W2ojEcugt116YHGwyCFRuEacMVZySYi+C1mNszOD3EEhUuAa347B
 LTNh7H3sik9yYvFj6b3oysMwsAbF+ZTIDRKmFUKiJ6NlKVnevt7wpfMqPd5LDytpW7Or
 ZhvFCij+PtQ9XbODZQhNJ5EFTcirgxqcT0oFmMPIPujulLQQIuXPK99Aa/EstwXsyosn
 Pt1n/a6vXruGX1TwrOUNiyNoOjPc6ZpvhEWb0lAL/E1rZN/3KJ5RXRASNh1PRQDGQxNI
 LAL0+DPGZiTCPo1EvMeT4VFiXsB203HP6LQOHj9OxbQD/ZZZ7VaTtuvXqYKueFUZrhF2
 ZJ4w==
X-Gm-Message-State: AOJu0YzSxgHu2Fhw6VIDgxIcFRbn8bhaGI5a259khLaOt7xxIshPqYGq
 JT6+2GLz12H03JqLn0nccD+eoLeV7J++thE/aSw=
X-Google-Smtp-Source: AGHT+IFz2Dc+eS6oqrbO16D+fEo1AO3R/gSIjJSsFlcTo8qjchM0co6B7q51gA03yOMxJtdFlhb0WA==
X-Received: by 2002:a17:902:cec7:b0:1c1:f6d1:3118 with SMTP id
 d7-20020a170902cec700b001c1f6d13118mr7463315plg.27.1698522348216; 
 Sat, 28 Oct 2023 12:45:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 27/35] tcg/ppc: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:45:14 -0700
Message-Id: <20231028194522.245170-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 105 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 98 insertions(+), 7 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index b20dbe036d..ef1d959892 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -703,9 +703,11 @@ enum {
     CR_SO
 };
 
-static const uint32_t tcg_to_bc[] = {
+static const uint32_t tcg_to_bc[16] = {
     [TCG_COND_EQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
     [TCG_COND_NE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
+    [TCG_COND_TSTEQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
+    [TCG_COND_TSTNE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
     [TCG_COND_LT]  = BC | BI(0, CR_LT) | BO_COND_TRUE,
     [TCG_COND_GE]  = BC | BI(0, CR_LT) | BO_COND_FALSE,
     [TCG_COND_LE]  = BC | BI(0, CR_GT) | BO_COND_FALSE,
@@ -717,9 +719,11 @@ static const uint32_t tcg_to_bc[] = {
 };
 
 /* The low bit here is set if the RA and RB fields must be inverted.  */
-static const uint32_t tcg_to_isel[] = {
+static const uint32_t tcg_to_isel[16] = {
     [TCG_COND_EQ]  = ISEL | BC_(0, CR_EQ),
     [TCG_COND_NE]  = ISEL | BC_(0, CR_EQ) | 1,
+    [TCG_COND_TSTEQ] = ISEL | BC_(0, CR_EQ),
+    [TCG_COND_TSTNE] = ISEL | BC_(0, CR_EQ) | 1,
     [TCG_COND_LT]  = ISEL | BC_(0, CR_LT),
     [TCG_COND_GE]  = ISEL | BC_(0, CR_LT) | 1,
     [TCG_COND_LE]  = ISEL | BC_(0, CR_GT) | 1,
@@ -872,21 +876,33 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     return true;
 }
 
-static inline void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
-                               int sh, int mb)
+static void tcg_out_rld_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                           int sh, int mb, bool rc)
 {
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
     sh = SH(sh & 0x1f) | (((sh >> 5) & 1) << 1);
     mb = MB64((mb >> 5) | ((mb << 1) & 0x3f));
-    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb);
+    tcg_out32(s, op | RA(ra) | RS(rs) | sh | mb | rc);
 }
 
-static inline void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
-                               int sh, int mb, int me)
+static void tcg_out_rld(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                        int sh, int mb)
+{
+    tcg_out_rld_rc(s, op, ra, rs, sh, mb, false);
+}
+
+static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                           int sh, int mb, int me, bool rc)
 {
     tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me));
 }
 
+static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                        int sh, int mb, int me)
+{
+    tcg_out_rlw_rc(s, op, ra, rs, sh, mb, me, false);
+}
+
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
 {
     tcg_out32(s, EXTSB | RA(dst) | RS(src));
@@ -1702,6 +1718,50 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
+/*
+ * Set dest non-zero if and only if (arg1 & arg2) is non-zero.
+ * If RC, then also set RC0.
+ */
+static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
+                         bool const_arg2, TCGType type, bool rc)
+{
+    int mb, me;
+
+    if (!const_arg2) {
+        tcg_out32(s, AND | SAB(arg1, dest, arg2) | rc);
+        return;
+    }
+
+    if (type == TCG_TYPE_I32) {
+        arg2 = (uint32_t)arg2;
+    } else if (arg2 == (uint32_t)arg2) {
+        type = TCG_TYPE_I32;
+    }
+
+    if ((arg2 & ~0xffff) == 0) {
+        tcg_out32(s, ANDI | SAI(arg1, dest, arg2));
+        return;
+    }
+    if ((arg2 & ~0xffff0000ull) == 0) {
+        tcg_out32(s, ANDI | SAI(arg1, dest, arg2));
+        return;
+    }
+    if (type == TCG_TYPE_I32) {
+        if (mask_operand(arg2, &mb, &me)) {
+            tcg_out_rlw_rc(s, RLWINM, dest, arg1, 0, mb, me, rc);
+            return;
+        }
+    } else {
+        int sh = clz64(arg2);
+        if (mask64_operand(arg2 << sh, &mb, &me)) {
+            tcg_out_rld_rc(s, RLDICR, dest, arg1, sh, me, rc);
+            return;
+        }
+    }
+    /* Constraints should satisfy this. */
+    g_assert_not_reached();
+}
+
 static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
                         int const_arg2, int cr, TCGType type)
 {
@@ -1736,6 +1796,12 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
         imm = 0;
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        tcg_debug_assert(cr == 0);
+        tcg_out_test(s, TCG_REG_R0, arg1, arg2, const_arg2, type, true);
+        return;
+
     case TCG_COND_LT:
     case TCG_COND_GE:
     case TCG_COND_LE:
@@ -1946,6 +2012,16 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
         tcg_out_setcond_ne0(s, type, arg0, arg1, neg);
         break;
 
+    case TCG_COND_TSTEQ:
+        tcg_out_test(s, TCG_REG_R0, arg1, arg2, const_arg2, type, false);
+        tcg_out_setcond_eq0(s, type, arg0, TCG_REG_R0, neg);
+        break;
+
+    case TCG_COND_TSTNE:
+        tcg_out_test(s, TCG_REG_R0, arg1, arg2, const_arg2, type, false);
+        tcg_out_setcond_ne0(s, type, arg0, TCG_REG_R0, neg);
+        break;
+
     case TCG_COND_LE:
     case TCG_COND_LEU:
         inv = true;
@@ -2118,6 +2194,21 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        if (blconst) {
+            tcg_out_andi32(s, TCG_REG_R0, al, bl);
+        } else {
+            tcg_out32(s, AND | SAB(al, TCG_REG_R0, bl));
+        }
+        if (bhconst) {
+            tcg_out_andi32(s, TCG_REG_TMP1, ah, bh);
+        } else {
+            tcg_out32(s, AND | SAB(ah, TCG_REG_TMP1, bh));
+        }
+        tcg_out32(s, OR | SAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_TMP1) | 1);
+        break;
+
     case TCG_COND_LT:
     case TCG_COND_LE:
     case TCG_COND_GT:
-- 
2.34.1


