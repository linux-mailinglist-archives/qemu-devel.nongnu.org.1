Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F69A8A902
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 22:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mI4-0004OH-EF; Tue, 15 Apr 2025 15:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mBq-0001cb-AW
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:30 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mAv-0007cG-8t
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:43:24 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7376e311086so7846223b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746129; x=1745350929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D1EyruBkD+NBUce366c/Rl8XGoQXLo57MbsM21RJNHc=;
 b=Zg+xwm/v7hX8BgDhORPVnHtLAvIk+TFNd9W37vQvQ/Oe/UFwNAyNfiJ3hIdzkdqe5p
 JA1D+7yYpBzp2Crt0DTChLHo6s2jQ11TIsiDdfHxzNAxvIVwsk2CDNt0bZwZ1IfzHhg+
 JuXFbLXpDmAjOF1ZQYDyAE9/pRT9iU8eMNaXlF8zSfmrgOFZsb4DheXE5DulPC5Zm0f7
 W2ayZky77eQysCP1P9752/s8+y1ePSwsbLgwvn94jkOYYFSWOK1JSq240+UOqPsd/TZh
 G35SggPq6R19irj2I0cwnfEUIu27CCT2+NhSkkoPo3orWMKZsapz2xUX+V4JSe5hKGFw
 U2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746129; x=1745350929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1EyruBkD+NBUce366c/Rl8XGoQXLo57MbsM21RJNHc=;
 b=jfZoFVnfAIskkB3xT52x/ZdTT5wxuCAjT7JBVmJrc8nfZsl7W1RAtZli80g0vnpZuB
 h9iUhNxz3z5p++UHbhIZa1MXQbeaWtiPZ+hgS+TJK7Z+6goihJAirN/XujIqfy38a1VU
 nwfNfM3srcZJPl+Q77aK49e7jaJWXjYst8go62dUU0nRCpFhdD6eZnVhE+DfALCKYZDd
 iwFeR6Uq27y5BoAK0C3avC5EHM3tf8oL+T9X7TprE6lZp3Vroynlm8lAKRcqq7cH/3xe
 xgdHVi83w1iMapwu/AX1jfTsiSXt9p3Z/KdsQqUBEP+fT9jpw4ApGXj8/MtlXYQ5Nck2
 ta4Q==
X-Gm-Message-State: AOJu0YxPumAZo93oe1L4HTkvzOx7q4eWWm07e9+S3lQxwrb36FgaiC2T
 KojlIqlBHx0ZghW0cg4Vo9UF90pdXiGBhL8Q0kbi3kzIeeAXj/yxF42HM7QGZWgp5pBX7YDq+HD
 j
X-Gm-Gg: ASbGncvENeFaxhVoIoCc5DdC14mXFlHPHmhj92gTSLxYebvpf21rXoHQNULH/h3cTRX
 8Lkz5D/T3LnX1qrTis2Q0oz6haWfkKlRmyfbaT6IoZa9zlrEvGgPOezYiq811asFfu9OUz1n2cF
 e/pOxGZLw6PZ+UBNfjL6FTrgKFx3rgHCzm3/R7lJnbqH32jjLNsFxNtigrFtl93jbdIDzshlx1t
 /dE5U0o1GU/K2Yy/rNklrB4mbiEk4KqrvrS5yA02+JJzRn2VBjtZaFKiX0rOeKtlH276e/zmMCB
 nzkIOWDsBKoLhhlvmmwx1CFWsFLhilE8c4N5NFAt4jgLT32hAcASWbiOsDPVWlL9uegj9G4pxh4
 =
X-Google-Smtp-Source: AGHT+IEYW7ACUrph/EywHmu/uAE5EDwPFSC+ttKGUD4khe5LMctP4DE/7mQ6yBY3jTZ+Z+wzXdsJPg==
X-Received: by 2002:a05:6a00:398d:b0:732:a24:7354 with SMTP id
 d2e1a72fcca58-73c1f8c3d99mr971666b3a.4.1744745770554; 
 Tue, 15 Apr 2025 12:36:10 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 137/163] tcg/ppc: Implement add/sub carry opcodes
Date: Tue, 15 Apr 2025 12:24:48 -0700
Message-ID: <20250415192515.232910-138-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |   3 +
 tcg/ppc/tcg-target-con-str.h |   1 +
 tcg/ppc/tcg-target.c.inc     | 167 ++++++++++++++++++++++++++++++-----
 3 files changed, 150 insertions(+), 21 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 14cd217287..9ea26c40ae 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -29,7 +29,10 @@ C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rT)
 C_O1_I2(r, r, rU)
+C_O1_I2(r, r, rZM)
 C_O1_I2(r, r, rZW)
+C_O1_I2(r, rI, rN)
+C_O1_I2(r, rZM, rZM)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(v, v, v, vZM, v)
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc/tcg-target-con-str.h
index 16b687216e..faf92da47f 100644
--- a/tcg/ppc/tcg-target-con-str.h
+++ b/tcg/ppc/tcg-target-con-str.h
@@ -19,6 +19,7 @@ REGS('v', ALL_VECTOR_REGS)
 CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('M', TCG_CT_CONST_MONE)
+CONST('N', TCG_CT_CONST_N16)
 CONST('T', TCG_CT_CONST_S32)
 CONST('U', TCG_CT_CONST_U32)
 CONST('W', TCG_CT_CONST_WSZ)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 5b04655f3b..0b151db0e4 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -89,14 +89,15 @@
 /* Shorthand for size of a register.  */
 #define SZR  (TCG_TARGET_REG_BITS / 8)
 
-#define TCG_CT_CONST_S16  0x100
-#define TCG_CT_CONST_U16  0x200
-#define TCG_CT_CONST_S32  0x400
-#define TCG_CT_CONST_U32  0x800
-#define TCG_CT_CONST_ZERO 0x1000
-#define TCG_CT_CONST_MONE 0x2000
-#define TCG_CT_CONST_WSZ  0x4000
-#define TCG_CT_CONST_CMP  0x8000
+#define TCG_CT_CONST_S16     0x00100
+#define TCG_CT_CONST_U16     0x00200
+#define TCG_CT_CONST_N16     0x00400
+#define TCG_CT_CONST_S32     0x00800
+#define TCG_CT_CONST_U32     0x01000
+#define TCG_CT_CONST_ZERO    0x02000
+#define TCG_CT_CONST_MONE    0x04000
+#define TCG_CT_CONST_WSZ     0x08000
+#define TCG_CT_CONST_CMP     0x10000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -342,6 +343,9 @@ static bool tcg_target_const_match(int64_t sval, int ct,
     if ((ct & TCG_CT_CONST_U16) && uval == (uint16_t)uval) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_N16) && -sval == (int16_t)-sval) {
+        return 1;
+    }
     if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
     }
@@ -2863,21 +2867,69 @@ static const TCGOutOpBinary outop_add = {
     .out_rri = tgen_addi,
 };
 
+static void tgen_addco_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADDC | TAB(a0, a1, a2));
+}
+
+static void tgen_addco_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out32(s, ADDIC | TAI(a0, a1, a2));
+}
+
+static TCGConstraintSetIndex cset_addco(TCGType type, unsigned flags)
+{
+    /*
+     * Note that the CA bit is defined based on the word size of the
+     * environment.  So in 64-bit mode it's always carry-out of bit 63.
+     * The fallback code using deposit works just as well for TCG_TYPE_I32.
+     */
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rI) : C_NotImplemented;
+}
+
 static const TCGOutOpBinary outop_addco = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addco,
+    .out_rrr = tgen_addco_rrr,
+    .out_rri = tgen_addco_rri,
+};
+
+static void tgen_addcio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, ADDE | TAB(a0, a1, a2));
+}
+
+static void tgen_addcio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out32(s, (a2 ? ADDME : ADDZE) | RT(a0) | RA(a1));
+}
+
+static TCGConstraintSetIndex cset_addcio(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, r, rZM) : C_NotImplemented;
+}
+
+static const TCGOutOpBinary outop_addcio = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_NotImplemented,
-};
-
-static const TCGOutOpBinary outop_addcio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_addcio,
+    .out_rrr = tgen_addcio_rrr,
+    .out_rri = tgen_addcio_rri,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
 {
-    g_assert_not_reached();
+    tcg_out32(s, SUBFC | TAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_R0));
 }
 
 static void tgen_and(TCGContext *s, TCGType type,
@@ -3284,21 +3336,94 @@ static const TCGOutOpSubtract outop_sub = {
     .out_rir = tgen_subfi,
 };
 
+static void tgen_subbo_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFC | TAB(a0, a2, a1));
+}
+
+static void tgen_subbo_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (a2 == 0) {
+        tcg_out_movi(s, type, TCG_REG_R0, 0);
+        tgen_subbo_rrr(s, type, a0, a1, TCG_REG_R0);
+    } else {
+        tgen_addco_rri(s, type, a0, a1, -a2);
+    }
+}
+
+/* The underlying insn for subfi is subfic. */
+#define tgen_subbo_rir  tgen_subfi
+
+static void tgen_subbo_rii(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, type, TCG_REG_R0, a2);
+    tgen_subbo_rir(s, type, a0, a1, TCG_REG_R0);
+}
+
+static TCGConstraintSetIndex cset_subbo(TCGType type, unsigned flags)
+{
+    /* Recall that the CA bit is defined based on the host word size. */
+    return type == TCG_TYPE_REG ? C_O1_I2(r, rI, rN) : C_NotImplemented;
+}
+
 static const TCGOutOpAddSubCarry outop_subbo = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_subbo,
+    .out_rrr = tgen_subbo_rrr,
+    .out_rri = tgen_subbo_rri,
+    .out_rir = tgen_subbo_rir,
+    .out_rii = tgen_subbo_rii,
 };
 
-static const TCGOutOpAddSubCarry outop_subbi = {
-    .base.static_constraint = C_NotImplemented,
-};
+static void tgen_subbio_rrr(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFE | TAB(a0, a2, a1));
+}
+
+static void tgen_subbio_rri(TCGContext *s, TCGType type,
+                            TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_addcio_rri(s, type, a0, a1, ~a2);
+}
+
+static void tgen_subbio_rir(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_debug_assert(a1 == 0 || a1 == -1);
+    tcg_out32(s, (a1 ? SUBFME : SUBFZE) | RT(a0) | RA(a2));
+}
+
+static void tgen_subbio_rii(TCGContext *s, TCGType type,
+                            TCGReg a0, tcg_target_long a1, tcg_target_long a2)
+{
+    tcg_out_movi(s, type, TCG_REG_R0, a2);
+    tgen_subbio_rir(s, type, a0, a1, TCG_REG_R0);
+}
+
+static TCGConstraintSetIndex cset_subbio(TCGType type, unsigned flags)
+{
+    return type == TCG_TYPE_REG ? C_O1_I2(r, rZM, rZM) : C_NotImplemented;
+}
 
 static const TCGOutOpAddSubCarry outop_subbio = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_subbio,
+    .out_rrr = tgen_subbio_rrr,
+    .out_rri = tgen_subbio_rri,
+    .out_rir = tgen_subbio_rir,
+    .out_rii = tgen_subbio_rii,
 };
 
+#define outop_subbi  outop_subbio
+
 static void tcg_out_set_borrow(TCGContext *s)
 {
-    g_assert_not_reached();
+    /* borrow = !carry */
+    tcg_out32(s, ADDIC | TAI(TCG_REG_R0, TCG_REG_R0, 0));
 }
 
 static void tgen_xor(TCGContext *s, TCGType type,
-- 
2.43.0


