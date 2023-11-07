Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F497E3352
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:55:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9K-0008Mw-2E; Mon, 06 Nov 2023 21:49:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9H-0008KC-5g
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:03 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9F-0005t8-HR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:02 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6c396ef9a3dso2410393b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325340; x=1699930140; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UKokEn2/f5uDToV4b3MTyHM++CDKvKNGzEYJ6Ux0XXw=;
 b=jLFFeBOJ07FEmCGUbbMR0VoreCV3vw+w+2X+G2pvAuz7ix9/T9Oi5XijfGwdyMIW4h
 5vsiSbfx83b7GzjkqpPIgFT0bCPiFLHkykwqwb34b4mUz07o1XvXnG52t4khPHUc6+PI
 //rnXDcnydJBRetEutxrz5Kv0ysAX4jJ5ivFZSdVm36aWoP4nowoTKhsRwsOzl7tZaEt
 yEOxijkFVi4TpPIoYV2mNuUrgXbXYp235ZTXXM4CN6fXtsID3ZU9X04HQiAedja1nUtR
 BsHmEw5ufCzLXbf/Z0lxdggz4S23i8PzgM6NINTeRLtEgeJIyAJm8EJFxEOVOWAalos3
 gxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325340; x=1699930140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKokEn2/f5uDToV4b3MTyHM++CDKvKNGzEYJ6Ux0XXw=;
 b=fywXfP9RvD86HxR8NYvD5mExRDf7k6UfsPlZXr9salpXM/JgS65357+gwes/3E6dz1
 4HBj5EFbjQMHAhFcPcFQ+rVPS75f3FfmSkoPfDG+cokZHvQt1RCrirhJIEqboiyMMCDV
 OiseQB2nbuh+zA3dyHAFFGPz2SYI9+a7LrrfV6K6A7y/a16chaA79/buIRL7xcmpr3Ey
 a69N6ec1gRSjqTtI+4PqditwJxcQtZ0vVcA1Y06EZsDDnko7TaI1j9my1XR26k1lKM7r
 8C799Ux7AJnXW6gLPHrEFKTSopKDm790gZnt4nfkKgesN+4Yn6dxOfF7SN5k2xi1Sqyn
 eZtg==
X-Gm-Message-State: AOJu0YwnAvmneAYyDNKo6i1HaDzaFnWgqWg9abEI1BVlrK8A+Ixpc+WR
 bJDKtdszU5QC84EzJndyHdmyL+rFtqNgQJd77x8=
X-Google-Smtp-Source: AGHT+IFFteoXLI0twyRxoo8m36QjKhP9CNYFBK1UYmwcxW53BkPxGu26N2jsMq8kt7p9WaMz5xLHUg==
X-Received: by 2002:a05:6a00:1593:b0:6be:2901:2cd with SMTP id
 u19-20020a056a00159300b006be290102cdmr29779496pfk.10.1699325340078; 
 Mon, 06 Nov 2023 18:49:00 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/35] tcg/mips: Always implement movcond
Date: Mon,  6 Nov 2023 18:48:28 -0800
Message-Id: <20231107024842.7650-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Expand as branch over move if not supported in the ISA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231026041404.1229328-3-richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.h     |  4 ++--
 tcg/mips/tcg-target.c.inc | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index c0576f66d7..0a4083f0d9 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -154,7 +154,7 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions detected at runtime */
-#define TCG_TARGET_HAS_movcond_i32      use_movnz_instructions
+#define TCG_TARGET_HAS_movcond_i32      1
 #define TCG_TARGET_HAS_bswap16_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_deposit_i32      use_mips32r2_instructions
 #define TCG_TARGET_HAS_extract_i32      use_mips32r2_instructions
@@ -169,7 +169,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_movcond_i64      use_movnz_instructions
+#define TCG_TARGET_HAS_movcond_i64      1
 #define TCG_TARGET_HAS_bswap16_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_bswap32_i64      use_mips32r2_instructions
 #define TCG_TARGET_HAS_bswap64_i64      use_mips32r2_instructions
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 89681f00fe..82b078b9c5 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1070,13 +1070,22 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
         if (v2 != 0) {
             tcg_out_opc_reg(s, OPC_OR, ret, ret, TCG_TMP1);
         }
-    } else {
+        return;
+    }
+
+    /* This should be guaranteed via constraints */
+    tcg_debug_assert(v2 == ret);
+
+    if (use_movnz_instructions) {
         MIPSInsn m_opc = eqz ? OPC_MOVZ : OPC_MOVN;
-
         tcg_out_opc_reg(s, m_opc, ret, v1, c1);
-
-        /* This should be guaranteed via constraints */
-        tcg_debug_assert(v2 == ret);
+    } else {
+        /* Invert the condition in order to branch over the move. */
+        MIPSInsn b_opc = eqz ? OPC_BNE : OPC_BEQ;
+        tcg_out_opc_imm(s, b_opc, c1, TCG_REG_ZERO, 2);
+        tcg_out_nop(s);
+        /* Open-code tcg_out_mov, without the nop-move check. */
+        tcg_out_opc_reg(s, OPC_OR, ret, v1, TCG_REG_ZERO);
     }
 }
 
-- 
2.34.1


