Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C50711369
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQN-0008Re-1i; Thu, 25 May 2023 14:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQL-0008RG-KH
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQJ-0005we-Q5
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae615d5018so13632805ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038250; x=1687630250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kiv3PTsHfvHgxd1CsgFYSohQOglr+ZxIFeD2jueV4Ok=;
 b=I0Dk1GXsSbT7SESanBSS4NaIm6OzKO33BC3Lr2h0iEEZrJPiNPX9iSzNF8Hl+1XTQT
 TXRZQRkWxhOrS2aJd+Tlq9QAgl3nIrA5n0DxuerSEoZVaR4KOlg6eKIeSe2bSpubq7l8
 2hfresCNQNajpC7LsIhs0nPCaIrqx6QiHJ6bBIx8uGZWPRi0pAoE+kNfJjC3eSXer291
 7FJZpqnyiUanQxrmPGjnYZtQHddIaidOYlDxwavhDY5haowzEofqBdo0Y1IKZxd5aL30
 cGQosHbSRo60sPSC0+1jtdg7IZ4vP7bbQNP/A/o+nAApQgRq1pWXVV6+4X7CA9ReGryT
 FZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038250; x=1687630250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kiv3PTsHfvHgxd1CsgFYSohQOglr+ZxIFeD2jueV4Ok=;
 b=FngYtDzCd19jo0qXOAvHHKwObBcA3m5/sNhWfWYBBh5uz8Hd2iHzehnciLrXFLcInR
 JtB5uYifFOr3Zyk+9m35JPr2ddoOFHLRtPN2GWQrl+/YOJm1PlwdCXtBJE0sPExM5YYR
 rwfr62iCQVg6nUV9ey2CWf+m3nom7il8Jz56T/8RUnrk4unTfidvxaOKwm89xXfkBa/m
 x0CWUvLYMCnJeMhkT1OSp9o8NACEMVEi9PwrOzIHNbyQWXdBhsYlRrlMBtaQYIJhMBq8
 wjYu30uAwds0VIOtWDqc5Ba87kuJRMXHbj4WUb0BkHbp7NLvrsy+0O0RgKB/GFUhYTVB
 vZvA==
X-Gm-Message-State: AC+VfDwzFzeZA0X+xZGqpgpcLyQbQWREtLiSLiobZbFR1s7jt56+hKU0
 5znl7ssJ65A42iwGrtBmfYr15X1sCkIQg+xJexA=
X-Google-Smtp-Source: ACHHUZ6g63OzlZzWddC+kbe4qmk36QEnH7Rz2Up92xCLDzjyhEP1GTpB9QiETCcir+IkMpS1VOJ4oQ==
X-Received: by 2002:a17:902:e54d:b0:1af:babd:7b6d with SMTP id
 n13-20020a170902e54d00b001afbabd7b6dmr2858918plf.52.1685038250511; 
 Thu, 25 May 2023 11:10:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 15/23] tcg/riscv: Support ANDN, ORN, XNOR from Zbb
Date: Thu, 25 May 2023 11:10:28 -0700
Message-Id: <20230525181036.1559435-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |  1 +
 tcg/riscv/tcg-target-con-str.h |  1 +
 tcg/riscv/tcg-target.h         | 12 +++++-----
 tcg/riscv/tcg-target.c.inc     | 41 ++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d88888d3ac..1a33ece98f 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -15,6 +15,7 @@ C_O0_I2(rZ, rZ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
+C_O1_I2(r, r, rJ)
 C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 6f1cfb976c..d5c419dff1 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -15,6 +15,7 @@ REGS('r', ALL_GENERAL_REGS)
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('I', TCG_CT_CONST_S12)
+CONST('J', TCG_CT_CONST_J12)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 863ac8ba2f..9f58d46208 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -120,9 +120,9 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_bswap32_i32      0
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_neg_i32          1
-#define TCG_TARGET_HAS_andc_i32         0
-#define TCG_TARGET_HAS_orc_i32          0
-#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_andc_i32         have_zbb
+#define TCG_TARGET_HAS_orc_i32          have_zbb
+#define TCG_TARGET_HAS_eqv_i32          have_zbb
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
 #define TCG_TARGET_HAS_clz_i32          0
@@ -154,9 +154,9 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_bswap64_i64      0
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_neg_i64          1
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_andc_i64         have_zbb
+#define TCG_TARGET_HAS_orc_i64          have_zbb
+#define TCG_TARGET_HAS_eqv_i64          have_zbb
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
 #define TCG_TARGET_HAS_clz_i64          0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eb3e2e9eb0..edfe4c8f8d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -138,6 +138,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_S12   0x200
 #define TCG_CT_CONST_N12   0x400
 #define TCG_CT_CONST_M12   0x800
+#define TCG_CT_CONST_J12  0x1000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 
@@ -174,6 +175,13 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
     if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
         return 1;
     }
+    /*
+     * Inverse of sign extended from 12 bits: ~[-0x800, 0x7ff].
+     * Used to map ANDN back to ANDI, etc.
+     */
+    if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
+        return 1;
+    }
     return 0;
 }
 
@@ -1305,6 +1313,31 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ANDI, a0, a1, ~a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_ANDN, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_ORI, a0, a1, ~a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_ORN, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_XORI, a0, a1, ~a2);
+        } else {
+            tcg_out_opc_reg(s, OPC_XNOR, a0, a1, a2);
+        }
+        break;
+
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
@@ -1539,6 +1572,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_i64:
         return C_O1_I2(r, r, rI);
 
+    case INDEX_op_andc_i32:
+    case INDEX_op_andc_i64:
+    case INDEX_op_orc_i32:
+    case INDEX_op_orc_i64:
+    case INDEX_op_eqv_i32:
+    case INDEX_op_eqv_i64:
+        return C_O1_I2(r, r, rJ);
+
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
         return C_O1_I2(r, rZ, rN);
-- 
2.34.1


