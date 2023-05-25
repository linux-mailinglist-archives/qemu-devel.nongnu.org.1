Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2719A711362
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQU-00008S-Vo; Thu, 25 May 2023 14:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQT-00006v-7M
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:11:01 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQR-00062d-3F
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:11:00 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ae507af2e5so12955ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038257; x=1687630257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhXY6OVrpQp4Lm/To99lZW68y4mFxyvdIBwjvdoCrKQ=;
 b=WGvMhMVeBV1UA9sYkaEKFKjQDD4J4M45OX5YRc4cyHwb2bPXeZMskbOLUidOQoPya8
 2nEx/1QC0yr9CIFbhdO1YBlCPp5x62bS452yGvtDuc70KKqDhDoyY+Sao0NHcKme5+fP
 M9UJ08ebb/OSJobiqCwt6iPQuhiyj4p3QsMWODjXioCX3NU38TFmaXEoWBPZCcAGMJ4P
 aP/+1WmTA3AZ55ip0l1ax/6snVZfDZMmIM8tKfrxPtJIR2GTKG0pBbG9qTpn8V2qVGrD
 4dG2UXoDGIhn0d4ZDNXgr0VTLaDSZGqJsnE9Gqr6Fz/LBAUFjRmyvVip4vuKOT24tfmE
 NzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038257; x=1687630257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhXY6OVrpQp4Lm/To99lZW68y4mFxyvdIBwjvdoCrKQ=;
 b=SldL+JPqLKr9S+BpxyhwIkHBG1QwVDK9W/ZQsGVDSGV1AVPrIjxS6IhQN89Bt8axgw
 M+cDlcbrBlEIq6SfHwRANOmKpNRIXHLy6D7uNN1py7rDLgWZ2xSrQbdtx/JgFeKautJ9
 KouTAh5wBFTIjeygtaY4sRaGJXttC8e2za0XdJWvF0hS636NxKToJo8E2a6a8C6rUtE4
 dCdhpRIElAxbAMEncZcXH2dUog0hx02G1kusOKgzcZUjgQPSxlJpTMY3VTb2qYKokDFT
 CDgKcKM3pe9pEEv08DWj2YX/pJG0+oOwdkeC/BVtsqtVAiWSbZhZODfrtciboWvXTBOk
 /Qlg==
X-Gm-Message-State: AC+VfDzfRnGk7KL/z/JPSXqhz+RHT+XXIoqjiBqvclTA5UCgonnzPTIl
 GAWIWHzzlWIwQVgRfMdO8pROUJ78gcwm+vXd0+8=
X-Google-Smtp-Source: ACHHUZ7JHzYtcRdp35aBXr6EcsSDIHTZy2dvAti7bDz2s01b5vGS3PL7bUygTj146MtYsmdoZD6XDw==
X-Received: by 2002:a17:902:d483:b0:1af:ac49:e048 with SMTP id
 c3-20020a170902d48300b001afac49e048mr2874148plg.25.1685038256785; 
 Thu, 25 May 2023 11:10:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 23/23] tcg/riscv: Support CTZ, CLZ from Zbb
Date: Thu, 25 May 2023 11:10:36 -0700
Message-Id: <20230525181036.1559435-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/riscv/tcg-target.h         |  8 ++++----
 tcg/riscv/tcg-target.c.inc     | 35 ++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index a5cadd303f..aac5ceee2b 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -18,5 +18,6 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, rZ, rN)
 C_O1_I2(r, rZ, rZ)
+C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index e9e84be9a5..62fe61af7b 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -125,8 +125,8 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_eqv_i32          have_zbb
 #define TCG_TARGET_HAS_nand_i32         0
 #define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          0
-#define TCG_TARGET_HAS_ctz_i32          0
+#define TCG_TARGET_HAS_clz_i32          have_zbb
+#define TCG_TARGET_HAS_ctz_i32          have_zbb
 #define TCG_TARGET_HAS_ctpop_i32        have_zbb
 #define TCG_TARGET_HAS_brcond2          1
 #define TCG_TARGET_HAS_setcond2         1
@@ -159,8 +159,8 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_eqv_i64          have_zbb
 #define TCG_TARGET_HAS_nand_i64         0
 #define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_clz_i64          have_zbb
+#define TCG_TARGET_HAS_ctz_i64          have_zbb
 #define TCG_TARGET_HAS_ctpop_i64        have_zbb
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 811b84d152..c0257124fa 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1063,6 +1063,22 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tcg_out_cltz(TCGContext *s, TCGType type, RISCVInsn insn,
+                         TCGReg ret, TCGReg src1, int src2, bool c_src2)
+{
+    tcg_out_opc_imm(s, insn, ret, src1, 0);
+
+    if (!c_src2 || src2 != (type == TCG_TYPE_I32 ? 32 : 64)) {
+        /*
+         * The requested zero result does not match the insn, so adjust.
+         * Note that constraints put 'ret' in a new register, so the
+         * computation above did not clobber either 'src1' or 'src2'.
+         */
+        tcg_out_movcond(s, TCG_COND_EQ, ret, src1, 0, true,
+                        src2, c_src2, ret, false);
+    }
+}
+
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
@@ -1723,6 +1739,19 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_imm(s, OPC_CPOP, a0, a1, 0);
         break;
 
+    case INDEX_op_clz_i32:
+        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CLZW, a0, a1, a2, c2);
+        break;
+    case INDEX_op_clz_i64:
+        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CLZ, a0, a1, a2, c2);
+        break;
+    case INDEX_op_ctz_i32:
+        tcg_out_cltz(s, TCG_TYPE_I32, OPC_CTZW, a0, a1, a2, c2);
+        break;
+    case INDEX_op_ctz_i64:
+        tcg_out_cltz(s, TCG_TYPE_I64, OPC_CTZ, a0, a1, a2, c2);
+        break;
+
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false, true);
@@ -1920,6 +1949,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
+    case INDEX_op_clz_i32:
+    case INDEX_op_clz_i64:
+    case INDEX_op_ctz_i32:
+    case INDEX_op_ctz_i64:
+        return C_N1_I2(r, r, rM);
+
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(rZ, rZ);
-- 
2.34.1


