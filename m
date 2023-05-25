Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7974A711368
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQR-0008Vj-Cj; Thu, 25 May 2023 14:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQN-0008SH-7q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:55 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQL-0005y6-IC
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:55 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae452c2777so148545ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038252; x=1687630252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1cuVcFNfYtthmtIf50Jsd3dfSKJk8+H2W+YHx6/HyPI=;
 b=SxI2lNtAAhjrfGAF5nGJP7WLiG2XOKloesvx9sNYPQQhvoECYofn2Hs1RgLAif0a3Q
 hxm7yuIjNsIO6DQPOVUg3NbPmSdEJBHU+uAnj4Vw4M2fh1sUfKL7DtJUHWim5SvfPubW
 xDT/8I86IgtE+G5ga7MnFpGBWwbCGkR9d2MZShuYQZvjmwSuLF8APah0e1KEtBOZQI8C
 Ua+fq2EDPSp0nyhE8ARzRXH73Qok254yaG7UJH2B0YJJDzuee7n7oSwsPNUPRSr4s3Ll
 YYu25eyEOzsqZ7nw5MH4NHgDf5Nsyu1lZUoY35BCEu3JFihl8fns1N7A2ts+ywcru9rf
 5tGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038252; x=1687630252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1cuVcFNfYtthmtIf50Jsd3dfSKJk8+H2W+YHx6/HyPI=;
 b=Rukke6rHWx2T9VpYJGDMkPhmOVPH8JP8S/B+q7T5ISnh//4frhaRWSkPJ1V5veFLLk
 E0KQLDXmOhNedg52zIsiZsonJ1zBr81EZAYGLxrtEcTVieuEobSzVPTo8wTjfKMZHww5
 0Nc1nxapJZBFDKZZu0OvtdHduCYpaZKgBi5wQkG74MCuwmL3UEVRstwh4OaqHBcj/yh3
 V2RYwqglNKgIa8HRLoJKU77zQU0CMP8c4Sdx4wVJxvpPfnD6kQR/LelAzKutDjEUaCAH
 uk6bkdIT/q7+7CMfBetIKLTphNzkNnPsTRDu+NAWc5fDp0KdCcpq6JimpJSqW6txD2NM
 Evwg==
X-Gm-Message-State: AC+VfDzF0IS9sXIgOpxSTiVY4hhu1LaQ0VRLPT4CmbFiWmmv7Usa2CEO
 NaGo+5npUwnsZXdfRc+RM261kYwZ1c9X1Kleuzc=
X-Google-Smtp-Source: ACHHUZ732+QNnD52cGUpFEdDcsXb/uq1zDhqcGHOJZuQv/YrYpmNEBD/rJXkKTDgwgnZno4aAPBvxA==
X-Received: by 2002:a17:903:44c:b0:1ae:4dda:c2e with SMTP id
 iw12-20020a170903044c00b001ae4dda0c2emr2591094plb.13.1685038252174; 
 Thu, 25 May 2023 11:10:52 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 17/23] tcg/riscv: Use ADD.UW for guest address generation
Date: Thu, 25 May 2023 11:10:30 -0700
Message-Id: <20230525181036.1559435-18-richard.henderson@linaro.org>
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

The instruction is a combined zero-extend and add.
Use it for exactly that.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 297119817b..2fdd450da3 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1038,14 +1038,18 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
 
     /* TLB Hit - translate address using addend.  */
-    addr_adj = addr_reg;
-    if (TARGET_LONG_BITS == 32) {
-        addr_adj = TCG_REG_TMP0;
-        tcg_out_ext32u(s, addr_adj, addr_reg);
+    if (TARGET_LONG_BITS == 64) {
+        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
+    } else if (have_zba) {
+        tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
+    } else {
+        tcg_out_ext32u(s, TCG_REG_TMP0, addr_reg);
+        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, TCG_REG_TMP2);
     }
-    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP2, addr_adj);
     *pbase = TCG_REG_TMP0;
 #else
+    TCGReg base;
+
     if (a_mask) {
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
@@ -1060,14 +1064,21 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP1, TCG_REG_ZERO, 0);
     }
 
-    TCGReg base = addr_reg;
-    if (TARGET_LONG_BITS == 32) {
-        tcg_out_ext32u(s, TCG_REG_TMP0, base);
-        base = TCG_REG_TMP0;
-    }
     if (guest_base != 0) {
-        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_GUEST_BASE_REG, base);
         base = TCG_REG_TMP0;
+        if (TARGET_LONG_BITS == 64) {
+            tcg_out_opc_reg(s, OPC_ADD, base, addr_reg, TCG_GUEST_BASE_REG);
+        } else if (have_zba) {
+            tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg, TCG_GUEST_BASE_REG);
+        } else {
+            tcg_out_ext32u(s, base, addr_reg);
+            tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_GUEST_BASE_REG);
+        }
+    } else if (TARGET_LONG_BITS == 64) {
+        base = addr_reg;
+    } else {
+        base = TCG_REG_TMP0;
+        tcg_out_ext32u(s, base, addr_reg);
     }
     *pbase = base;
 #endif
-- 
2.34.1


