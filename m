Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DECEC711351
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQT-000074-UC; Thu, 25 May 2023 14:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQS-00005u-7y
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:11:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQP-00061Y-6C
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae4c5e12edso13604345ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038256; x=1687630256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pcX79UtOjLA+j+Do1pHI/f4UsYp0/Pzd6kIdjo/mVKc=;
 b=SPqfw04eo8JnTY59N90VWgr8Xsa2AxBLbPJRMWntGzedq/kOTbXqbpXCJLOExH1m0k
 1fezEEEKR0thd+pk7YWdbj7SpIPYKIF/58wHsu60bqb4qeSNwkcRib70U2tHc/EHDHm2
 fbUMSdf54yGZeO7VenAFk+xWzgHnDBXo6zrjAissZVt2V+YNgG/gtI+i2Ri0VFokzVRY
 bw6GRt8qv7Xwa75X3+PybE/idKj5jNymOBFtKwFlqVAgyBKjU321zwy9h1nju4Wj97zw
 bj4qMRecXZXPHIWHvAVKNIobVaxMk82k7UgCTRiBUAkCEKUxaXQ4SI2eQgIDAQ3YW11A
 BuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038256; x=1687630256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcX79UtOjLA+j+Do1pHI/f4UsYp0/Pzd6kIdjo/mVKc=;
 b=dMqEH+RxNb0ctmqwTtqpsRnlBP5cGIDO4qCzn7lJyE8lWMFqYtjCmBk4HQdGfyyWnO
 rpulbKU3e4lySGZaKKs00cymEb3uQBPOf+6oGJdiRjDHfTRJEpm3N0QXkXzimvtLJZ1x
 9mpzRWo9h8IHmJXhoLFDz1QOFW4GtdgTcjFx4WZpEfqDzSv9dq42an5inDiv0dkYB17j
 02NPM6LAlsUECxq/p2nWPZ/4GiYy6HEXsH1RhdUxQ18Oj0KFxIOHipGPz2QY12JZPEWu
 gEhNA7nur/+HFeKqH5H7EjAgRS73f7SvqYEsfRXz2e+5geLaUYvx833fCaeMAPGOn1Qt
 WKoA==
X-Gm-Message-State: AC+VfDwuTIbzFjU8VChdSWFzKbtwo1m5EQQrntirEwt0cSHvBgCwjMvO
 8jqbugjXfY6bEP2cjIrrk0KT2nPQxngzAhOMePg=
X-Google-Smtp-Source: ACHHUZ7IWX3BgNgc1jmydcAJ4Y9QzxfQtbUwqakMOwjHxDQDC/Q4WqGEgd4KVi7xLful1ZtzbFg16g==
X-Received: by 2002:a17:902:ecc9:b0:1af:db10:333b with SMTP id
 a9-20020a170902ecc900b001afdb10333bmr3159220plh.59.1685038255970; 
 Thu, 25 May 2023 11:10:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 22/23] tcg/riscv: Implement movcond
Date: Thu, 25 May 2023 11:10:35 -0700
Message-Id: <20230525181036.1559435-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Implement with and without Zicond.  Without Zicond, we were letting
the middle-end expand to a 5 insn sequence; better to use a branch
over a single insn.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |   1 +
 tcg/riscv/tcg-target.h         |   4 +-
 tcg/riscv/tcg-target.c.inc     | 139 ++++++++++++++++++++++++++++++++-
 3 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 1a33ece98f..a5cadd303f 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -18,4 +18,5 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
+C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index e0b23006c4..e9e84be9a5 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -97,7 +97,7 @@ extern bool have_zbb;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_movcond_i32      0
+#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
@@ -132,7 +132,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_setcond2         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
-#define TCG_TARGET_HAS_movcond_i64      0
+#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index db328ddc2d..811b84d152 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -169,7 +169,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
     }
     /*
      * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
-     * Used by addsub2, which may need the negative operation,
+     * Used by addsub2 and movcond, which may need the negative value,
      * and requires the modified constant to be representable.
      */
     if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
@@ -936,6 +936,133 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tcg_out_movcond_zicond(TCGContext *s, TCGReg ret, TCGReg test_ne,
+                                   int val1, bool c_val1,
+                                   int val2, bool c_val2)
+{
+    if (val1 == 0) {
+        if (c_val2) {
+            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, val2);
+            val2 = TCG_REG_TMP1;
+        }
+        tcg_out_opc_reg(s, OPC_CZERO_NEZ, ret, val2, test_ne);
+        return;
+    }
+
+    if (val2 == 0) {
+        if (c_val1) {
+            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, val1);
+            val1 = TCG_REG_TMP1;
+        }
+        tcg_out_opc_reg(s, OPC_CZERO_EQZ, ret, val1, test_ne);
+        return;
+    }
+
+    if (c_val2) {
+        if (c_val1) {
+            tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP1, val1 - val2);
+        } else {
+            tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP1, val1, -val2);
+        }
+        tcg_out_opc_reg(s, OPC_CZERO_EQZ, ret, TCG_REG_TMP1, test_ne);
+        tcg_out_opc_imm(s, OPC_ADDI, ret, ret, val2);
+        return;
+    }
+
+    if (c_val1) {
+        tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP1, val2, -val1);
+        tcg_out_opc_reg(s, OPC_CZERO_NEZ, ret, TCG_REG_TMP1, test_ne);
+        tcg_out_opc_imm(s, OPC_ADDI, ret, ret, val1);
+        return;
+    }
+
+    tcg_out_opc_reg(s, OPC_CZERO_NEZ, TCG_REG_TMP1, val2, test_ne);
+    tcg_out_opc_reg(s, OPC_CZERO_EQZ, TCG_REG_TMP0, val1, test_ne);
+    tcg_out_opc_reg(s, OPC_OR, ret, TCG_REG_TMP0, TCG_REG_TMP1);
+}
+
+static void tcg_out_movcond_br1(TCGContext *s, TCGCond cond, TCGReg ret,
+                                TCGReg cmp1, TCGReg cmp2,
+                                int val, bool c_val)
+{
+    RISCVInsn op;
+    int disp = 8;
+
+    tcg_debug_assert((unsigned)cond < ARRAY_SIZE(tcg_brcond_to_riscv));
+    op = tcg_brcond_to_riscv[cond].op;
+    tcg_debug_assert(op != 0);
+
+    if (tcg_brcond_to_riscv[cond].swap) {
+        tcg_out_opc_branch(s, op, cmp2, cmp1, disp);
+    } else {
+        tcg_out_opc_branch(s, op, cmp1, cmp2, disp);
+    }
+    if (c_val) {
+        tcg_out_opc_imm(s, OPC_ADDI, ret, TCG_REG_ZERO, val);
+    } else {
+        tcg_out_opc_imm(s, OPC_ADDI, ret, val, 0);
+    }
+}
+
+static void tcg_out_movcond_br2(TCGContext *s, TCGCond cond, TCGReg ret,
+                                TCGReg cmp1, TCGReg cmp2,
+                                int val1, bool c_val1,
+                                int val2, bool c_val2)
+{
+    TCGReg tmp;
+
+    /* TCG optimizer reorders to prefer ret matching val2. */
+    if (!c_val2 && ret == val2) {
+        cond = tcg_invert_cond(cond);
+        tcg_out_movcond_br1(s, cond, ret, cmp1, cmp2, val1, c_val1);
+        return;
+    }
+
+    if (!c_val1 && ret == val1) {
+        tcg_out_movcond_br1(s, cond, ret, cmp1, cmp2, val2, c_val2);
+        return;
+    }
+
+    tmp = (ret == cmp1 || ret == cmp2 ? TCG_REG_TMP1 : ret);
+    if (c_val1) {
+        tcg_out_movi(s, TCG_TYPE_REG, tmp, val1);
+    } else {
+        tcg_out_mov(s, TCG_TYPE_REG, tmp, val1);
+    }
+    tcg_out_movcond_br1(s, cond, tmp, cmp1, cmp2, val2, c_val2);
+    tcg_out_mov(s, TCG_TYPE_REG, ret, tmp);
+}
+
+static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg cmp1, int cmp2, bool c_cmp2,
+                            TCGReg val1, bool c_val1,
+                            TCGReg val2, bool c_val2)
+{
+    int tmpflags;
+    TCGReg t;
+
+    if (!have_zicond && (!c_cmp2 || cmp2 == 0)) {
+        tcg_out_movcond_br2(s, cond, ret, cmp1, cmp2,
+                            val1, c_val1, val2, c_val2);
+        return;
+    }
+
+    tmpflags = tcg_out_setcond_int(s, cond, TCG_REG_TMP0, cmp1, cmp2, c_cmp2);
+    t = tmpflags & ~SETCOND_FLAGS;
+
+    if (have_zicond) {
+        if (tmpflags & SETCOND_INV) {
+            tcg_out_movcond_zicond(s, ret, t, val2, c_val2, val1, c_val1);
+        } else {
+            tcg_out_movcond_zicond(s, ret, t, val1, c_val1, val2, c_val2);
+        }
+    } else {
+        cond = tmpflags & SETCOND_INV ? TCG_COND_EQ : TCG_COND_NE;
+        tcg_out_movcond_br2(s, cond, ret, t, TCG_REG_ZERO,
+                            val1, c_val1, val2, c_val2);
+    }
+}
+
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
@@ -1623,6 +1750,12 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
         break;
 
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        tcg_out_movcond(s, args[5], a0, a1, a2, c2,
+                        args[3], const_args[3], args[4], const_args[4]);
+        break;
+
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
@@ -1791,6 +1924,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_brcond_i64:
         return C_O0_I2(rZ, rZ);
 
+    case INDEX_op_movcond_i32:
+    case INDEX_op_movcond_i64:
+        return C_O1_I4(r, r, rI, rM, rM);
+
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
-- 
2.34.1


