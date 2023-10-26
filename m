Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC2A7D7B6D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:15:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrl8-0002Vl-9R; Thu, 26 Oct 2023 00:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl6-0002V5-3c
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl2-0000it-Kk
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso11999975ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698293646; x=1698898446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d8cKsWxi6jZjQFiHXDa1qsNnGyql4JqYL/7owK3wgPQ=;
 b=iSmAw9Pzd6PQet8+1y1UAwpkHHREY31d5ham6j9c6F0TooNVM44UjkpmgmmttnCayM
 d8dGieAxcC5vxZjhH6vJEXZbOdS0gCv2yX0kmhK3Tho1NpQfpva5w7Oh7Sco2Vwbk5WV
 Ro5Z2dIhFxxUqUlZFapS4YqEuOQ3+DtjGfqQNAq3Cx+wrVh3ulynDYr2B5QvCkiSg4gs
 xxpbBIq24iZM/1DbNAoyel8wYIZ7LOAvIZPdNG9Ix6j1vvKrGTu4ilPCKdOFurlPcSwA
 PLaU41Gr9/DN1tvfuVpHCNWeaWYKmCpx0Dm1VRMhUWOnzYtnV4XrxBJWAA5zG0acfCxx
 4nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698293646; x=1698898446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8cKsWxi6jZjQFiHXDa1qsNnGyql4JqYL/7owK3wgPQ=;
 b=GBLRlh7NaY87IAKgIcZ6/ututGbI2vEE9j2q4uEYLSJcBysdysmZRtlEWpxjMTlRYy
 o+n/IKo5QCnr0gOKIogPdZKWlgnjp5wEzHuZ7Pc3LjJk7S7CKXsvTtCAdK90UGkhq6yW
 Jp4/VDpQrySslQtclcmUBsHpR86tz0rK/TyOia8wMhMK1V+ieCLs9+6cYvCmCJtRjePl
 gdxFyTyPRFdolV3iPn1FApmMQXOI3uyq+iui3hvYZ+tj9Nop0R6IlVu2n5dJLd5khEUj
 cyW/XtnpPViXRthAP+DoKf11M/nsc3LqcpvOqHgOyqAtVTfqEVRPV96YeqKAR/3hU8bK
 hLWw==
X-Gm-Message-State: AOJu0YwHqtBCSqy1Z9wrDke5ly7gBU+qK0Jd/M8DSj52Ol7Ll7cJSEIf
 9ftMZL9ysBqgnwr6oVAna5rPevIRNaV1ocv1SpU=
X-Google-Smtp-Source: AGHT+IHaJ5mITzWR66UMV1EGm8JoWJyZXIx6YHp7IHXikptVZzDPh5W1nFY0bbNObgFCvk2TFBkLkQ==
X-Received: by 2002:a17:902:f550:b0:1c4:65d5:34ce with SMTP id
 h16-20020a170902f55000b001c465d534cemr1973773plf.31.1698293646156; 
 Wed, 25 Oct 2023 21:14:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001b8b2b95068sm9953929pli.204.2023.10.25.21.14.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 21:14:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] tcg/mips: Split out tcg_out_setcond_int
Date: Wed, 25 Oct 2023 21:13:59 -0700
Message-Id: <20231026041404.1229328-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026041404.1229328-1-richard.henderson@linaro.org>
References: <20231026041404.1229328-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Return the temp and a set of flags, to be used as a
primitive for setcond, brcond, movcond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 356 ++++++++++++++------------------------
 1 file changed, 132 insertions(+), 224 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 739a0f60b7..a5e6fe727b 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -871,81 +871,88 @@ static void tcg_out_addsub2(TCGContext *s, TCGReg rl, TCGReg rh, TCGReg al,
     }
 }
 
-/* Bit 0 set if inversion required; bit 1 set if swapping required.  */
-#define MIPS_CMP_INV  1
-#define MIPS_CMP_SWAP 2
+#define SETCOND_INV    TCG_TARGET_NB_REGS
+#define SETCOND_NEZ    (SETCOND_INV << 1)
+#define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
 
-static const uint8_t mips_cmp_map[16] = {
-    [TCG_COND_LT]  = 0,
-    [TCG_COND_LTU] = 0,
-    [TCG_COND_GE]  = MIPS_CMP_INV,
-    [TCG_COND_GEU] = MIPS_CMP_INV,
-    [TCG_COND_LE]  = MIPS_CMP_INV | MIPS_CMP_SWAP,
-    [TCG_COND_LEU] = MIPS_CMP_INV | MIPS_CMP_SWAP,
-    [TCG_COND_GT]  = MIPS_CMP_SWAP,
-    [TCG_COND_GTU] = MIPS_CMP_SWAP,
-};
+static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
+                               TCGReg arg1, TCGReg arg2)
+{
+    int flags = 0;
+
+    switch (cond) {
+    case TCG_COND_EQ:    /* -> NE  */
+    case TCG_COND_GE:    /* -> LT  */
+    case TCG_COND_GEU:   /* -> LTU */
+    case TCG_COND_LE:    /* -> GT  */
+    case TCG_COND_LEU:   /* -> GTU */
+    case TCG_COND_TSTEQ: /* -> TSTNE */
+        cond = tcg_invert_cond(cond);
+        flags ^= SETCOND_INV;
+        break;
+    default:
+        break;
+    }
+
+    switch (cond) {
+    case TCG_COND_NE:
+        flags |= SETCOND_NEZ;
+        if (arg2 == 0) {
+            return arg1 | flags;
+        }
+        tcg_out_opc_reg(s, OPC_XOR, ret, arg1, arg2);
+        break;
+    case TCG_COND_TSTNE:
+        flags |= SETCOND_NEZ;
+        tcg_out_opc_reg(s, OPC_AND, ret, arg1, arg2);
+        break;
+    case TCG_COND_LT:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
+        break;
+    case TCG_COND_LTU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
+        break;
+    case TCG_COND_GT:
+        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
+        break;
+    case TCG_COND_GTU:
+        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return ret | flags;
+}
+
+static void tcg_out_setcond_end(TCGContext *s, TCGReg ret, int tmpflags)
+{
+    if (tmpflags != ret) {
+        TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
+
+        switch (tmpflags & SETCOND_FLAGS) {
+        case SETCOND_INV:
+            /* Intermediate result is boolean: simply invert. */
+            tcg_out_opc_imm(s, OPC_XORI, ret, tmp, 1);
+            break;
+        case SETCOND_NEZ:
+            /* Intermediate result is zero/non-zero: test != 0. */
+            tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
+            break;
+        case SETCOND_NEZ | SETCOND_INV:
+            /* Intermediate result is zero/non-zero: test == 0. */
+            tcg_out_opc_imm(s, OPC_SLTIU, ret, tmp, 1);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+}
 
 static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
                             TCGReg arg1, TCGReg arg2)
 {
-    MIPSInsn s_opc = OPC_SLTU;
-    int cmp_map;
-
-    switch (cond) {
-    case TCG_COND_EQ:
-        if (arg2 != 0) {
-            tcg_out_opc_reg(s, OPC_XOR, ret, arg1, arg2);
-            arg1 = ret;
-        }
-        tcg_out_opc_imm(s, OPC_SLTIU, ret, arg1, 1);
-        break;
-
-    case TCG_COND_NE:
-        if (arg2 != 0) {
-            tcg_out_opc_reg(s, OPC_XOR, ret, arg1, arg2);
-            arg1 = ret;
-        }
-        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, arg1);
-        break;
-
-    case TCG_COND_TSTEQ:
-        tcg_out_opc_reg(s, OPC_AND, ret, arg1, arg2);
-        tcg_out_opc_imm(s, OPC_SLTIU, ret, ret, 1);
-        break;
-
-    case TCG_COND_TSTNE:
-        tcg_out_opc_reg(s, OPC_AND, ret, arg1, arg2);
-        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, ret);
-        break;
-
-    case TCG_COND_LT:
-    case TCG_COND_GE:
-    case TCG_COND_LE:
-    case TCG_COND_GT:
-        s_opc = OPC_SLT;
-        /* FALLTHRU */
-
-    case TCG_COND_LTU:
-    case TCG_COND_GEU:
-    case TCG_COND_LEU:
-    case TCG_COND_GTU:
-        cmp_map = mips_cmp_map[cond];
-        if (cmp_map & MIPS_CMP_SWAP) {
-            TCGReg t = arg1;
-            arg1 = arg2;
-            arg2 = t;
-        }
-        tcg_out_opc_reg(s, s_opc, ret, arg1, arg2);
-        if (cmp_map & MIPS_CMP_INV) {
-            tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
-        }
-        break;
-
-     default:
-         g_assert_not_reached();
-         break;
-     }
+    int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2);
+    tcg_out_setcond_end(s, ret, tmpflags);
 }
 
 static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
@@ -958,9 +965,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
         [TCG_COND_GE] = OPC_BGEZ,
     };
 
-    MIPSInsn s_opc = OPC_SLTU;
-    MIPSInsn b_opc;
-    int cmp_map;
+    MIPSInsn b_opc = 0;
 
     switch (cond) {
     case TCG_COND_EQ:
@@ -969,7 +974,6 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     case TCG_COND_NE:
         b_opc = OPC_BNE;
         break;
-
     case TCG_COND_LT:
     case TCG_COND_GT:
     case TCG_COND_LE:
@@ -978,156 +982,86 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
             b_opc = b_zero[cond];
             arg2 = arg1;
             arg1 = 0;
-            break;
         }
-        s_opc = OPC_SLT;
-        /* FALLTHRU */
-
-    case TCG_COND_LTU:
-    case TCG_COND_GTU:
-    case TCG_COND_LEU:
-    case TCG_COND_GEU:
-        cmp_map = mips_cmp_map[cond];
-        if (cmp_map & MIPS_CMP_SWAP) {
-            TCGReg t = arg1;
-            arg1 = arg2;
-            arg2 = t;
-        }
-        tcg_out_opc_reg(s, s_opc, TCG_TMP0, arg1, arg2);
-        b_opc = (cmp_map & MIPS_CMP_INV ? OPC_BEQ : OPC_BNE);
-        arg1 = TCG_TMP0;
-        arg2 = TCG_REG_ZERO;
         break;
-
-    case TCG_COND_TSTEQ:
-    case TCG_COND_TSTNE:
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, arg1, arg2);
-        arg1 = TCG_TMP0;
-        arg2 = TCG_REG_ZERO;
-        b_opc = cond == TCG_COND_TSTEQ ? OPC_BEQ : OPC_BNE;
-        break;
-
     default:
-        g_assert_not_reached();
         break;
     }
 
+    if (b_opc == 0) {
+        int tmpflags = tcg_out_setcond_int(s, cond, TCG_TMP0, arg1, arg2);
+
+        arg2 = 0;
+        arg1 = tmpflags & ~SETCOND_FLAGS;
+        b_opc = tmpflags & SETCOND_INV ? OPC_BEQ : OPC_BNE;
+    }
+
     tcg_out_opc_br(s, b_opc, arg1, arg2);
     tcg_out_reloc(s, s->code_ptr - 1, R_MIPS_PC16, l, 0);
     tcg_out_nop(s);
 }
 
-static TCGReg tcg_out_reduce_eq2(TCGContext *s, TCGReg tmp0, TCGReg tmp1,
-                                 TCGReg al, TCGReg ah,
-                                 TCGReg bl, TCGReg bh)
+static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
+                                TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
 {
-    /* Merge highpart comparison into AH.  */
-    if (bh != 0) {
-        if (ah != 0) {
-            tcg_out_opc_reg(s, OPC_XOR, tmp0, ah, bh);
-            ah = tmp0;
-        } else {
-            ah = bh;
-        }
+    int flags = 0;
+
+    switch (cond) {
+    case TCG_COND_EQ:
+        flags |= SETCOND_INV;
+        /* fall through */
+    case TCG_COND_NE:
+        flags |= SETCOND_NEZ;
+        tcg_out_opc_reg(s, OPC_XOR, TCG_TMP0, al, bl);
+        tcg_out_opc_reg(s, OPC_XOR, TCG_TMP1, ah, bh);
+        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
+        break;
+
+    case TCG_COND_TSTEQ:
+        flags |= SETCOND_INV;
+        /* fall through */
+    case TCG_COND_TSTNE:
+        flags |= SETCOND_NEZ;
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
+        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
+        break;
+
+    default:
+        tcg_out_setcond(s, TCG_COND_EQ, TCG_TMP0, ah, bh);
+        tcg_out_setcond(s, tcg_unsigned_cond(cond), TCG_TMP1, al, bl);
+        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, TCG_TMP1, TCG_TMP0);
+        tcg_out_setcond(s, tcg_high_cond(cond), TCG_TMP0, ah, bh);
+        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
+        break;
     }
-    /* Merge lowpart comparison into AL.  */
-    if (bl != 0) {
-        if (al != 0) {
-            tcg_out_opc_reg(s, OPC_XOR, tmp1, al, bl);
-            al = tmp1;
-        } else {
-            al = bl;
-        }
-    }
-    /* Merge high and low part comparisons into AL.  */
-    if (ah != 0) {
-        if (al != 0) {
-            tcg_out_opc_reg(s, OPC_OR, tmp0, ah, al);
-            al = tmp0;
-        } else {
-            al = ah;
-        }
-    }
-    return al;
+    return ret | flags;
 }
 
 static void tcg_out_setcond2(TCGContext *s, TCGCond cond, TCGReg ret,
                              TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
 {
-    TCGReg tmp0 = TCG_TMP0;
-    TCGReg tmp1 = ret;
-
-    tcg_debug_assert(ret != TCG_TMP0);
-    if (ret == ah || ret == bh) {
-        tcg_debug_assert(ret != TCG_TMP1);
-        tmp1 = TCG_TMP1;
-    }
-
-    switch (cond) {
-    case TCG_COND_EQ:
-    case TCG_COND_NE:
-        tmp1 = tcg_out_reduce_eq2(s, tmp0, tmp1, al, ah, bl, bh);
-        tcg_out_setcond(s, cond, ret, tmp1, TCG_REG_ZERO);
-        break;
-
-    case TCG_COND_TSTEQ:
-    case TCG_COND_TSTNE:
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
-        tcg_out_opc_reg(s, OPC_OR, ret, TCG_TMP0, TCG_TMP1);
-        tcg_out_setcond(s, tcg_eqne_cond(cond), ret, tmp1, TCG_REG_ZERO);
-        break;
-
-    default:
-        tcg_out_setcond(s, TCG_COND_EQ, tmp0, ah, bh);
-        tcg_out_setcond(s, tcg_unsigned_cond(cond), tmp1, al, bl);
-        tcg_out_opc_reg(s, OPC_AND, tmp1, tmp1, tmp0);
-        tcg_out_setcond(s, tcg_high_cond(cond), tmp0, ah, bh);
-        tcg_out_opc_reg(s, OPC_OR, ret, tmp1, tmp0);
-        break;
-    }
+    int tmpflags = tcg_out_setcond2_int(s, cond, ret, al, ah, bl, bh);
+    tcg_out_setcond_end(s, ret, tmpflags);
 }
 
 static void tcg_out_brcond2(TCGContext *s, TCGCond cond, TCGReg al, TCGReg ah,
                             TCGReg bl, TCGReg bh, TCGLabel *l)
 {
-    TCGCond b_cond = TCG_COND_NE;
-    TCGReg tmp = TCG_TMP1;
+    int tmpflags = tcg_out_setcond2_int(s, cond, TCG_TMP0, al, ah, bl, bh);
+    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
+    MIPSInsn b_opc = tmpflags & SETCOND_INV ? OPC_BEQ : OPC_BNE;
 
-    /* With branches, we emit between 4 and 9 insns with 2 or 3 branches.
-       With setcond, we emit between 3 and 10 insns and only 1 branch,
-       which ought to get better branch prediction.  */
-     switch (cond) {
-     case TCG_COND_EQ:
-     case TCG_COND_NE:
-        b_cond = cond;
-        tmp = tcg_out_reduce_eq2(s, TCG_TMP0, TCG_TMP1, al, ah, bl, bh);
-        break;
-
-    case TCG_COND_TSTEQ:
-    case TCG_COND_TSTNE:
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, al, bl);
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP1, ah, bh);
-        tcg_out_opc_reg(s, OPC_OR, TCG_TMP1, TCG_TMP1, TCG_TMP0);
-        break;
-
-    default:
-        /* Minimize code size by preferring a compare not requiring INV.  */
-        if (mips_cmp_map[cond] & MIPS_CMP_INV) {
-            cond = tcg_invert_cond(cond);
-            b_cond = TCG_COND_EQ;
-        }
-        tcg_out_setcond2(s, cond, tmp, al, ah, bl, bh);
-        break;
-    }
-
-    tcg_out_brcond(s, b_cond, tmp, TCG_REG_ZERO, l);
+    tcg_out_opc_br(s, b_opc, tmp, TCG_REG_ZERO);
+    tcg_out_reloc(s, s->code_ptr - 1, R_MIPS_PC16, l, 0);
+    tcg_out_nop(s);
 }
 
 static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
                             TCGReg c1, TCGReg c2, TCGReg v1, TCGReg v2)
 {
-    bool eqz = false;
+    int tmpflags;
+    bool eqz;
 
     /* If one of the values is zero, put it last to match SEL*Z instructions */
     if (use_mips32r6_instructions && v1 == 0) {
@@ -1136,35 +1070,9 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
         cond = tcg_invert_cond(cond);
     }
 
-    switch (cond) {
-    case TCG_COND_EQ:
-        eqz = true;
-        /* FALLTHRU */
-    case TCG_COND_NE:
-        if (c2 != 0) {
-            tcg_out_opc_reg(s, OPC_XOR, TCG_TMP0, c1, c2);
-            c1 = TCG_TMP0;
-        }
-        break;
-
-    case TCG_COND_TSTEQ:
-        eqz = true;
-        /* FALLTHRU */
-    case TCG_COND_TSTNE:
-        tcg_out_opc_reg(s, OPC_AND, TCG_TMP0, c1, c2);
-        c1 = TCG_TMP0;
-        break;
-
-    default:
-        /* Minimize code size by preferring a compare not requiring INV.  */
-        if (mips_cmp_map[cond] & MIPS_CMP_INV) {
-            cond = tcg_invert_cond(cond);
-            eqz = true;
-        }
-        tcg_out_setcond(s, cond, TCG_TMP0, c1, c2);
-        c1 = TCG_TMP0;
-        break;
-    }
+    tmpflags = tcg_out_setcond_int(s, cond, TCG_TMP0, c1, c2);
+    c1 = tmpflags & ~SETCOND_FLAGS;
+    eqz = tmpflags & SETCOND_INV;
 
     if (use_mips32r6_instructions) {
         MIPSInsn m_opc_t = eqz ? OPC_SELEQZ : OPC_SELNEZ;
-- 
2.34.1


