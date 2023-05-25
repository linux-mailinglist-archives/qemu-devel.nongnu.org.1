Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB75711363
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:14:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQK-0008QU-Tm; Thu, 25 May 2023 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQJ-0008Pn-Aq
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQH-0005uY-Fa
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:51 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64d3491609fso25807b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038248; x=1687630248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAz6IQhwfHAIXCDgKk50JRYG1wGTuelZa2J+mZizWjY=;
 b=QIcTSAUgbVq8fq/+X13tQczgg82DEln/Axf15QUdb+agdlqDgyG8X61uniiTJ/TXtN
 k8Ro0f4RUCpHo2wJS4Y2fNrYDrv0Id66Np/JFdQZ+O7WBzquwqo6xw+H5KdGSwSyBDX+
 rEqBsyNoIc2Ym36OVq1YZSizAEJykD4qRuX8bmLX7hW56cVEbm6FNPIpKHeS8s3dW9eK
 dwtrm2H2ouvV0wpybKV9MbggnzTJ9qWHsEwvoEoJmfhgO0c69fbgOruGUDrgUFzoDeGu
 cOSnixTa3vh5inuvt/0CF3Vvmk+y+RFvdFxk15/tMkw0FCdDWnCIeBRM1Y2dx+j3egZf
 IH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038248; x=1687630248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LAz6IQhwfHAIXCDgKk50JRYG1wGTuelZa2J+mZizWjY=;
 b=S//xHShRBVMlHjIkr1l3H+AWbhtjxC2HhD5u/kJ1EUi+Md/k43UQ91NWydCGVtUwP8
 8HyXDAIdgS3/YYG9IV3UYWZ8moLtFWz1iMwJOGbxhWC0hHkmfRtftzbg1mYRmM2nBi9D
 2C36VYAF28YrrPjSz6JA2fwUL5FMFpNKYlCHAFN5DRPqP0ExMWAlkA5ODEnuHfuUKrtQ
 yQp2hKtVnQPnNhgNe3cQUGoJep+kk7WVVxCVscraQ9BdOwD3Gzw3QwWkft4X8jCvywBR
 fSAwoe33vEiztr6uVhDvldHrrLvmlzmrRhH9r5RlH/iwKXMxLVYRJduIJ6I94e+umhoJ
 CiUA==
X-Gm-Message-State: AC+VfDxPl1n8AhnNBLlkmfXvnaZBs2CBAaxtV5fmcEVDkH2V7nYcVtZw
 /mTOW/AYgWGqKOBHRFxndUt+zuu+FFRXN/De7VE=
X-Google-Smtp-Source: ACHHUZ4jEezLxKURL5vpsJ+rjm/cUOmmBOtMO7d2p5/2QtGVDCbKJmEef4xFUDjXUMIpU5u7epFu+w==
X-Received: by 2002:a05:6a21:339f:b0:10b:3b4d:8c16 with SMTP id
 yy31-20020a056a21339f00b0010b3b4d8c16mr18854025pzb.38.1685038248080; 
 Thu, 25 May 2023 11:10:48 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/23] tcg/mips: Replace MIPS_BE with HOST_BIG_ENDIAN
Date: Thu, 25 May 2023 11:10:25 -0700
Message-Id: <20230525181036.1559435-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Since e03b56863d2b, which replaced HOST_WORDS_BIGENDIAN
with HOST_BIG_ENDIAN, there is no need to define a second
symbol which is [0,1].

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 46 +++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index fd92cc30ca..3274d9aace 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -27,14 +27,8 @@
 #include "../tcg-ldst.c.inc"
 #include "../tcg-pool.c.inc"
 
-#if HOST_BIG_ENDIAN
-# define MIPS_BE  1
-#else
-# define MIPS_BE  0
-#endif
-
 #if TCG_TARGET_REG_BITS == 32
-# define LO_OFF  (MIPS_BE * 4)
+# define LO_OFF  (HOST_BIG_ENDIAN * 4)
 # define HI_OFF  (4 - LO_OFF)
 #else
 /* Assert at compile-time that these values are never used for 64-bit. */
@@ -1439,7 +1433,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         /* Prefer to load from offset 0 first, but allow for overlap.  */
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_opc_imm(s, OPC_LD, lo, base, 0);
-        } else if (MIPS_BE ? hi != base : lo == base) {
+        } else if (HOST_BIG_ENDIAN ? hi != base : lo == base) {
             tcg_out_opc_imm(s, OPC_LW, hi, base, HI_OFF);
             tcg_out_opc_imm(s, OPC_LW, lo, base, LO_OFF);
         } else {
@@ -1455,10 +1449,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg lo, TCGReg hi,
 static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
                                     TCGReg base, MemOp opc, TCGType type)
 {
-    const MIPSInsn lw1 = MIPS_BE ? OPC_LWL : OPC_LWR;
-    const MIPSInsn lw2 = MIPS_BE ? OPC_LWR : OPC_LWL;
-    const MIPSInsn ld1 = MIPS_BE ? OPC_LDL : OPC_LDR;
-    const MIPSInsn ld2 = MIPS_BE ? OPC_LDR : OPC_LDL;
+    const MIPSInsn lw1 = HOST_BIG_ENDIAN ? OPC_LWL : OPC_LWR;
+    const MIPSInsn lw2 = HOST_BIG_ENDIAN ? OPC_LWR : OPC_LWL;
+    const MIPSInsn ld1 = HOST_BIG_ENDIAN ? OPC_LDL : OPC_LDR;
+    const MIPSInsn ld2 = HOST_BIG_ENDIAN ? OPC_LDR : OPC_LDL;
     bool sgn = opc & MO_SIGN;
 
     switch (opc & MO_SIZE) {
@@ -1497,10 +1491,10 @@ static void tcg_out_qemu_ld_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
             tcg_out_opc_imm(s, ld1, lo, base, 0);
             tcg_out_opc_imm(s, ld2, lo, base, 7);
         } else {
-            tcg_out_opc_imm(s, lw1, MIPS_BE ? hi : lo, base, 0 + 0);
-            tcg_out_opc_imm(s, lw2, MIPS_BE ? hi : lo, base, 0 + 3);
-            tcg_out_opc_imm(s, lw1, MIPS_BE ? lo : hi, base, 4 + 0);
-            tcg_out_opc_imm(s, lw2, MIPS_BE ? lo : hi, base, 4 + 3);
+            tcg_out_opc_imm(s, lw1, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 0);
+            tcg_out_opc_imm(s, lw2, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 3);
+            tcg_out_opc_imm(s, lw1, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 0);
+            tcg_out_opc_imm(s, lw2, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 3);
         }
         break;
 
@@ -1550,8 +1544,8 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_opc_imm(s, OPC_SD, lo, base, 0);
         } else {
-            tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? hi : lo, base, 0);
-            tcg_out_opc_imm(s, OPC_SW, MIPS_BE ? lo : hi, base, 4);
+            tcg_out_opc_imm(s, OPC_SW, HOST_BIG_ENDIAN ? hi : lo, base, 0);
+            tcg_out_opc_imm(s, OPC_SW, HOST_BIG_ENDIAN ? lo : hi, base, 4);
         }
         break;
     default:
@@ -1562,10 +1556,10 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg lo, TCGReg hi,
 static void tcg_out_qemu_st_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
                                     TCGReg base, MemOp opc)
 {
-    const MIPSInsn sw1 = MIPS_BE ? OPC_SWL : OPC_SWR;
-    const MIPSInsn sw2 = MIPS_BE ? OPC_SWR : OPC_SWL;
-    const MIPSInsn sd1 = MIPS_BE ? OPC_SDL : OPC_SDR;
-    const MIPSInsn sd2 = MIPS_BE ? OPC_SDR : OPC_SDL;
+    const MIPSInsn sw1 = HOST_BIG_ENDIAN ? OPC_SWL : OPC_SWR;
+    const MIPSInsn sw2 = HOST_BIG_ENDIAN ? OPC_SWR : OPC_SWL;
+    const MIPSInsn sd1 = HOST_BIG_ENDIAN ? OPC_SDL : OPC_SDR;
+    const MIPSInsn sd2 = HOST_BIG_ENDIAN ? OPC_SDR : OPC_SDL;
 
     switch (opc & MO_SIZE) {
     case MO_16:
@@ -1584,10 +1578,10 @@ static void tcg_out_qemu_st_unalign(TCGContext *s, TCGReg lo, TCGReg hi,
             tcg_out_opc_imm(s, sd1, lo, base, 0);
             tcg_out_opc_imm(s, sd2, lo, base, 7);
         } else {
-            tcg_out_opc_imm(s, sw1, MIPS_BE ? hi : lo, base, 0 + 0);
-            tcg_out_opc_imm(s, sw2, MIPS_BE ? hi : lo, base, 0 + 3);
-            tcg_out_opc_imm(s, sw1, MIPS_BE ? lo : hi, base, 4 + 0);
-            tcg_out_opc_imm(s, sw2, MIPS_BE ? lo : hi, base, 4 + 3);
+            tcg_out_opc_imm(s, sw1, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 0);
+            tcg_out_opc_imm(s, sw2, HOST_BIG_ENDIAN ? hi : lo, base, 0 + 3);
+            tcg_out_opc_imm(s, sw1, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 0);
+            tcg_out_opc_imm(s, sw2, HOST_BIG_ENDIAN ? lo : hi, base, 4 + 3);
         }
         break;
 
-- 
2.34.1


