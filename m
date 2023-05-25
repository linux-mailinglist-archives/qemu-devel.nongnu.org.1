Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9CE711353
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQS-00005R-3a; Thu, 25 May 2023 14:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQO-0008Sc-0I
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:56 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQM-0005yc-CL
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:55 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-53404873a19so1355122a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038253; x=1687630253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l1HPhkHQuFzsHgTzLhVx0No3GK62rrEnumKuXLdYldA=;
 b=n1pyR+Rcc+LzxIY9nwKOexB7/xbEjbU9y0OTsFNUT3s3mJQ5o4Catl4UBWySCzmYq+
 Qj8BEe/p7WZ45FGBsvIXUff8rVfrqT4Cvz1Y4Pak4t9fW/wwlOz+lQa217AcpLFABhI4
 o7nevBWM1WnzXNCZsS1kbUVtaAkMtSR52v3ELAtSNjlcQP/IM0+pQL9T4//8D2xB4EN8
 qNtPtE2RZHBsqb6RtvttB4KH/5VNKbcL4axulvu+BwQFN+AgLj4skYPRzU7dorQuUxsm
 JjsqAD61M/cP4giOJe2h04QQ7IeG56zSGxAQzqAg9Yx5mFwnZ9oPbR2r1dInxLFv+fmd
 cMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038253; x=1687630253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l1HPhkHQuFzsHgTzLhVx0No3GK62rrEnumKuXLdYldA=;
 b=gmYCvdxcfswa7U/hmPrj/n4csLmfVa07JuHSb6ftaVGZDR+RJkZwksMLMGImtYQt/0
 NRIgjzxOwSPQT7rpsjtSukWEdeY/tebYCKPXq2axTkZjpHVLGOm3L1LoLEaPFcq05VHe
 iaJSwcHUEQ7eZDx1JjLRK3TnGXdqMucusicXrH7lyzKLPd7pcMvZGRjnN1Hdoaw+/BVh
 ZQTPeW29Rb6spOh26zb+4GkjujIPYeyQFuleC7uDWbwEYtkhdVvADQv2ZIW9/0GoGegj
 cWZJTW4eNKJ1dos7NqhBqjS80+eDSKhAfRyf4Dogm81NUT/Uchp1okCi5xcQxeixVfQ0
 djzA==
X-Gm-Message-State: AC+VfDz2ZMLvGXCaew6KceW3XY/W5TabbW1xgy02E16jbk11szYHJ1dG
 en0y6Fdwqei/LsXTRIUx85SJYrc0HhsmgxWCUj4=
X-Google-Smtp-Source: ACHHUZ4r/SgFzlMwha6dNKybd9FIaW9dgQIsHB3tr8QnFX6rDVL4i9LxyqmCG8FA5iEui6lsaK3q8g==
X-Received: by 2002:a17:902:b586:b0:1ad:e198:c4fc with SMTP id
 a6-20020a170902b58600b001ade198c4fcmr2351237pls.54.1685038252895; 
 Thu, 25 May 2023 11:10:52 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 18/23] tcg/riscv: Support rotates from Zbb
Date: Thu, 25 May 2023 11:10:31 -0700
Message-Id: <20230525181036.1559435-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
 tcg/riscv/tcg-target.h     |  4 ++--
 tcg/riscv/tcg-target.c.inc | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 9f58d46208..317d385924 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -101,7 +101,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_div_i32          1
 #define TCG_TARGET_HAS_rem_i32          1
 #define TCG_TARGET_HAS_div2_i32         0
-#define TCG_TARGET_HAS_rot_i32          0
+#define TCG_TARGET_HAS_rot_i32          have_zbb
 #define TCG_TARGET_HAS_deposit_i32      0
 #define TCG_TARGET_HAS_extract_i32      0
 #define TCG_TARGET_HAS_sextract_i32     0
@@ -136,7 +136,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_div_i64          1
 #define TCG_TARGET_HAS_rem_i64          1
 #define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          0
+#define TCG_TARGET_HAS_rot_i64          have_zbb
 #define TCG_TARGET_HAS_deposit_i64      0
 #define TCG_TARGET_HAS_extract_i64      0
 #define TCG_TARGET_HAS_sextract_i64     0
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 2fdd450da3..cc96425413 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1457,6 +1457,36 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         }
         break;
 
+    case INDEX_op_rotl_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, -a2 & 0x1f);
+        } else {
+            tcg_out_opc_reg(s, OPC_ROLW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_rotl_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_RORI, a0, a1, -a2 & 0x3f);
+        } else {
+            tcg_out_opc_reg(s, OPC_ROL, a0, a1, a2);
+        }
+        break;
+
+    case INDEX_op_rotr_i32:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_RORIW, a0, a1, a2 & 0x1f);
+        } else {
+            tcg_out_opc_reg(s, OPC_RORW, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_rotr_i64:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_RORI, a0, a1, a2 & 0x3f);
+        } else {
+            tcg_out_opc_reg(s, OPC_ROR, a0, a1, a2);
+        }
+        break;
+
     case INDEX_op_add2_i32:
         tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
                         const_args[4], const_args[5], false, true);
@@ -1632,9 +1662,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotr_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i64:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_brcond_i32:
-- 
2.34.1


