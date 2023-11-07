Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 837B37E3355
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:55:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9K-0008Mv-1J; Mon, 06 Nov 2023 21:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9G-0008K2-Lo
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:02 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9E-0005so-Fg
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:02 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b565e35fedso3105295b6e.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325339; x=1699930139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zz7hg2/atmOJ2zc1IN2ls7Jl6BOw07GScu60nlbqXVU=;
 b=Pmj72iNHsUMqQu7zxgNh60hoXOwKK5oCFtuj88ifW/tfTlmmNzPpbMlxL1ipbW3Ook
 MJbhTCJ4tVvA3qYc/m+1+7DvZQdZq1cxfkdv2BFFZRS+gqnI89BPVCmdciTZ/h/mDJFI
 RjVNho149kWiCmEOfEfnLrk1bmP+5BiMiLEyFriunILOZZO3TJvyAYITdDlwlPqXPxFw
 MS2frY+KMQQZsOB/csgvvHPMKzu0mx5ptkkwhRz1FzwePd9hsB1FP1gTJoM44VNZSm+L
 5qAJQ2geLm0sU0xiZTVFr5D4ExPAToAHlH621wetL+8a+6WPFPFe/f7/BHEmb53SjWTZ
 Wu6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325339; x=1699930139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zz7hg2/atmOJ2zc1IN2ls7Jl6BOw07GScu60nlbqXVU=;
 b=OFGAs4NNVa0o3Z4uPq3oPKyix9RrPzMXupmImvm50KPXmjwr0MlIc06YdlZ6U52DlH
 YFzvS/lnjVR4oOpzZ9gNmyLr9gXFjWal0XXBmtCenjq0zoHKAGJiJTbR61ZJmCFvdCl9
 8qzF4u6pPwkq430kdwYsxCx99PgeunSPCOCeOsxakKpmkW6JKhPRgprgoowdIFsRp6Zn
 fTg++yH6ifBZWFnfFUEK8rJe25XQCmFCgslRcXIMTLSu7tmfvjnx0As5wcclkjWxNEwd
 /rbBGHxvh+ZeADBp6nLRlziiBAH3woeE5Vzf8Vh5HOiQaGusmS6fCG+tSv/AheJYrXY2
 yZGg==
X-Gm-Message-State: AOJu0YzmQ3dvfrutmQTf5NQOjiG5G3k3kuZjWlg5er17yGB6PuVu+MyQ
 m3BD6E44x0I3EFIAxmLbnvCafq6e451rkrKrpnc=
X-Google-Smtp-Source: AGHT+IFmyMVvFkRPF6JKMMEyiHvB2r6cMy+c1Wx0FFtgydF4GoEvUVQEKAoOjc6bdWna8wtAJYJmvg==
X-Received: by 2002:a05:6808:1810:b0:3b2:eab1:918 with SMTP id
 bh16-20020a056808181000b003b2eab10918mr37694519oib.29.1699325339337; 
 Mon, 06 Nov 2023 18:48:59 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/35] tcg/mips: Split out tcg_out_setcond_int
Date: Mon,  6 Nov 2023 18:48:27 -0800
Message-Id: <20231107024842.7650-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Return the temp and a set of flags, to be used as a
primitive for setcond, brcond, movcond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231026041404.1229328-2-richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 302 +++++++++++++++-----------------------
 1 file changed, 118 insertions(+), 184 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 328984ccff..89681f00fe 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -871,71 +871,83 @@ static void tcg_out_addsub2(TCGContext *s, TCGReg rl, TCGReg rh, TCGReg al,
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
@@ -948,9 +960,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
         [TCG_COND_GE] = OPC_BGEZ,
     };
 
-    MIPSInsn s_opc = OPC_SLTU;
-    MIPSInsn b_opc;
-    int cmp_map;
+    MIPSInsn b_opc = 0;
 
     switch (cond) {
     case TCG_COND_EQ:
@@ -959,7 +969,6 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     case TCG_COND_NE:
         b_opc = OPC_BNE;
         break;
-
     case TCG_COND_LT:
     case TCG_COND_GT:
     case TCG_COND_LE:
@@ -968,133 +977,76 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
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
     default:
-        g_assert_not_reached();
         break;
     }
 
+    if (b_opc == 0) {
+        int tmpflags = tcg_out_setcond_int(s, cond, TCG_TMP0, arg1, arg2);
+
+        arg2 = TCG_REG_ZERO;
+        arg1 = tmpflags & ~SETCOND_FLAGS;
+        b_opc = tmpflags & SETCOND_INV ? OPC_BEQ : OPC_BNE;
+    }
+
+    tcg_out_reloc(s, s->code_ptr, R_MIPS_PC16, l, 0);
     tcg_out_opc_br(s, b_opc, arg1, arg2);
-    tcg_out_reloc(s, s->code_ptr - 1, R_MIPS_PC16, l, 0);
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
+    tcg_out_reloc(s, s->code_ptr, R_MIPS_PC16, l, 0);
+    tcg_out_opc_br(s, b_opc, tmp, TCG_REG_ZERO);
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
@@ -1103,27 +1055,9 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
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


