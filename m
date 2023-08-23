Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3878616B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOk-0000Oa-UX; Wed, 23 Aug 2023 16:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOZ-0008PR-36
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0005WB-S6
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso37627695ad.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822235; x=1693427035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoXbN2inAVU70xEpEd9jztZdntpK43wt6w8LQmEU68E=;
 b=c6Iruv7eCcrUPCcg7KEgQ0dqIOoUn5fRNrEJOQgj/Ss8EsKuOqIG9daxHTJWjoFXMJ
 cF3OTSBt22Yv/Azs2eqg0MRXi2o9QqUeDk6BH0kQicnfYJK45Ict/+F54OmVHwPnnIym
 qehvCI6Ko8BWEx+LqiL2i63jRt2Xz7glkVNqjJDYxc1Bw9v+hG9FPSdkOvA+l0bJoExf
 VGEVJo7LtHGW0y1eDFmNHXRsbwy2HFDytkhp33NSTwWZiM2CNXZAolY9ga87ThFTsC/i
 hrwQXxjupLGUlqbXqby1HWnAsly1fqNoWVsUuhFN7Taonxx+0W9g2H/cPeoPIcZothWW
 h/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822235; x=1693427035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoXbN2inAVU70xEpEd9jztZdntpK43wt6w8LQmEU68E=;
 b=g/yyZu8TF8ZneMuWteBOixrsRzDgsxOZf3luOW/29KPzP6RLJSUmDdHj8lby/7j/X0
 7VA9WO01H+mqmbcDukHLlNX8bgd5ZU8kmx1c3YqzCUByLCqbUCkAhlpAANatX0pAst4r
 uMSJzcZzt1aN0Ri6KennwzdASEAHjEO+yTaUkSeRotu5ljPS8ssTTtpg2tI7wG8V7tDG
 EeFLHRy19z+V0LY1s0RNocISBXVPzhcaE1ju816uNU33sgmVxQ/WYmuNqctbrPtgrO11
 qBZUrvYQDuV29NaMtB7GMJeb4L2pZXruV7vQd5PGD05MvrXvHQbaCjs20wo6GP83z1Bu
 WaYA==
X-Gm-Message-State: AOJu0YyrdO1YAVLykPfSRvhuvONEqTcXRULjmsVWUw2vyw2p2r6A4iov
 2x6F6Hh2q0rlXP7SDsqP0VxIhzmaoOgPmAqV1GU=
X-Google-Smtp-Source: AGHT+IEJXFVHChG9zQ35fJQLrnXmqwCWgW+Ug1JFxWlp49bZvNSHUuxAh1NWdOYCu1CYB6ZWVdzbpQ==
X-Received: by 2002:a17:903:2281:b0:1c0:86c6:95ca with SMTP id
 b1-20020a170903228100b001c086c695camr8777478plh.8.1692822235243; 
 Wed, 23 Aug 2023 13:23:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 29/48] tcg/riscv: Implement negsetcond_*
Date: Wed, 23 Aug 2023 13:23:07 -0700
Message-Id: <20230823202326.1353645-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
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

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.h     |  4 ++--
 tcg/riscv/tcg-target.c.inc | 45 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 0efb3fc0b8..c1132d178f 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -88,7 +88,7 @@ extern bool have_zbb;
 
 /* optional instructions */
 #define TCG_TARGET_HAS_movcond_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
@@ -124,7 +124,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_movcond_i64      1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eeaeb6b6e3..232b616af3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -936,6 +936,44 @@ static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tcg_out_negsetcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                               TCGReg arg1, tcg_target_long arg2, bool c2)
+{
+    int tmpflags;
+    TCGReg tmp;
+
+    /* For LT/GE comparison against 0, replicate the sign bit. */
+    if (c2 && arg2 == 0) {
+        switch (cond) {
+        case TCG_COND_GE:
+            tcg_out_opc_imm(s, OPC_XORI, ret, arg1, -1);
+            arg1 = ret;
+            /* fall through */
+        case TCG_COND_LT:
+            tcg_out_opc_imm(s, OPC_SRAI, ret, arg1, TCG_TARGET_REG_BITS - 1);
+            return;
+        default:
+            break;
+        }
+    }
+
+    tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
+    tmp = tmpflags & ~SETCOND_FLAGS;
+
+    /* If intermediate result is zero/non-zero: test != 0. */
+    if (tmpflags & SETCOND_NEZ) {
+        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
+        tmp = ret;
+    }
+
+    /* Produce the 0/-1 result. */
+    if (tmpflags & SETCOND_INV) {
+        tcg_out_opc_imm(s, OPC_ADDI, ret, tmp, -1);
+    } else {
+        tcg_out_opc_reg(s, OPC_SUB, ret, TCG_REG_ZERO, tmp);
+    }
+}
+
 static void tcg_out_movcond_zicond(TCGContext *s, TCGReg ret, TCGReg test_ne,
                                    int val1, bool c_val1,
                                    int val2, bool c_val2)
@@ -1782,6 +1820,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_setcond(s, args[3], a0, a1, a2, c2);
         break;
 
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        tcg_out_negsetcond(s, args[3], a0, a1, a2, c2);
+        break;
+
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         tcg_out_movcond(s, args[5], a0, a1, a2, c2,
@@ -1910,6 +1953,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_andc_i32:
-- 
2.34.1


