Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C882A434
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLh-0001TP-Jq; Wed, 10 Jan 2024 17:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLc-00010n-L9
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:56 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLY-0003jw-95
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:55 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7831389c7daso381109385a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926811; x=1705531611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+m2bQ+EJZL+KCOl+ulw6p2ASMsIl7BSAfdsffaeaSYk=;
 b=l5Sk8J1Zv1/2Q89KLy9fdpBnOjnBxIJfF0sE5E7XGzNBl309MGn6ZwgrNiE01eNGqW
 A7czBwprAJ22NTXyJNj+EsJSafoe6+9iKNPQ1DP1Z+zyA7a4dii0U6uQWmbwTTqmAKhW
 RbUWiMJm7rmoyJykZbxvbQtlds2gGRqvCqy/jPj3KdN9SplND7uNPrIXYRS9Nz4d+DkO
 mkrfu+QKO0rP3StToZQzhb9yCr76yHBHfH1psfChWfcPwNXIFGZr4nvLFivXXUZ6Zho3
 MwNqsDx7nDSAks0w5wganNjn9/HbDb91ocik5jOBFzmLUAdU0f0d85CeSj6dmmRiwG4W
 sxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926811; x=1705531611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+m2bQ+EJZL+KCOl+ulw6p2ASMsIl7BSAfdsffaeaSYk=;
 b=jrCbpdaUH/HYDu+K17uVJj9duU2cn1iMjGzmxlwO7jBdEVdR4alEO872TWlWnkqBHx
 QTqhUDKofv8uZC0PWuzxXYM/WJipRtsHWq7GTq0V+/U5yY+l6C7AxQ51n8ePCeF6GOyB
 kXHF3biyayWll9GmVX2zIIm7R7w2mThrLrcXM7zjIxzicL8dmAMmlH/1NAozGTchYF27
 VVnpn3glGcC5Dv2oL7F6zJm3KVxivND9dfecrcd2D72RwEl3TTW0TV3ZBLVGi3SwtLO0
 NGoXzCb59c5KEymeMARCx008Q8hiqgg0mqXF0gOpvmJtCVMVsuL/XxS2HJGRbOSIqdwG
 doIg==
X-Gm-Message-State: AOJu0YwfTHWnlc+uy0Q44VBLNIMPpW2pMjVX3F09reJjtnBMu3AHxh/T
 2jFxttcndMQlzgYuGi0pnneMITsuW0vUYyOGDExugyJxETaddFeb
X-Google-Smtp-Source: AGHT+IF544GMuMIDXjBzC9wvGcf23N7VO7wGKASKUlhduPNlb5Uq24dPqlqlkmN+McbcSuT3fOfW4w==
X-Received: by 2002:a05:622a:1049:b0:429:b6c8:5e37 with SMTP id
 f9-20020a05622a104900b00429b6c85e37mr253399qte.86.1704926810845; 
 Wed, 10 Jan 2024 14:46:50 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 34/38] tcg/ppc: Support TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:44:04 +1100
Message-Id: <20240110224408.10444-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 tcg/ppc/tcg-target.h     |   2 +-
 tcg/ppc/tcg-target.c.inc | 122 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 60ce49e672..04a7aba4d3 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -143,7 +143,7 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
     (TCG_TARGET_REG_BITS == 64 && have_isa_2_07)
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 /*
  * While technically Altivec could support V64, it has no 64-bit store
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 535ef2cbe7..7f3829beeb 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -283,11 +283,15 @@ static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool mask_operand(uint32_t c, int *mb, int *me);
+static bool mask64_operand(uint64_t c, int *mb, int *me);
+
 /* test if a constant matches the constraint */
 static bool tcg_target_const_match(int64_t sval, int ct,
                                    TCGType type, TCGCond cond, int vece)
 {
     uint64_t uval = sval;
+    int mb, me;
 
     if (ct & TCG_CT_CONST) {
         return 1;
@@ -316,6 +320,17 @@ static bool tcg_target_const_match(int64_t sval, int ct,
         case TCG_COND_GTU:
             ct |= TCG_CT_CONST_U16;
             break;
+        case TCG_COND_TSTEQ:
+        case TCG_COND_TSTNE:
+            if ((uval & ~0xffff) == 0 || (uval & ~0xffff0000ull) == 0) {
+                return 1;
+            }
+            if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32
+                ? mask_operand(uval, &mb, &me)
+                : mask64_operand(uval << clz64(uval), &mb, &me)) {
+                return 1;
+            }
+            return 0;
         default:
             g_assert_not_reached();
         }
@@ -703,9 +718,11 @@ enum {
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
@@ -717,9 +734,11 @@ static const uint32_t tcg_to_bc[] = {
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
@@ -872,19 +891,31 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
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
 {
-    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me));
+    tcg_out_rld_rc(s, op, ra, rs, sh, mb, false);
+}
+
+static void tcg_out_rlw_rc(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                           int sh, int mb, int me, bool rc)
+{
+    tcg_out32(s, op | RA(ra) | RS(rs) | SH(sh) | MB(mb) | ME(me) | rc);
+}
+
+static void tcg_out_rlw(TCGContext *s, int op, TCGReg ra, TCGReg rs,
+                        int sh, int mb, int me)
+{
+    tcg_out_rlw_rc(s, op, ra, rs, sh, mb, me, false);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg dst, TCGReg src)
@@ -1702,6 +1733,50 @@ static inline bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
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
+        tcg_out32(s, ANDIS | SAI(arg1, dest, arg2 >> 16));
+        return;
+    }
+    if (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I32) {
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
@@ -1736,6 +1811,12 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
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
@@ -1946,6 +2027,16 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
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
@@ -2118,6 +2209,21 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
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


