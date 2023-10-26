Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F27D7B69
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:15:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrl6-0002Uu-F6; Thu, 26 Oct 2023 00:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl4-0002Ub-8v
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:10 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl2-0000j3-Kt
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:10 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cab2c24ecdso3328445ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698293647; x=1698898447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NWMNJDe+S0+EZdJBo+3dWkXIm0dV/UW0LgPiVtKrpH8=;
 b=WTCHf+hf8DmS223zBWjIgTDTxiZFN7FG5muwnZGAPo8g3yy4vYXIj5XssoROy2nknO
 5IwgwTon+26AHbpF0bsR1NReewIERr61v2jMS/3dDXZ+HbsVlw4SnLAAub6T4iHOKg4P
 B9AL1i4kRM/Db5zebjHgDOb4H+OKj4JW6Fl/YZvZu1hW6VgCh6Dkhqjg9qRmDVM/yPVQ
 0MDvVd2yeiRRdF7SpaYU200YTP4AKAKilg4gqNjOaZkjKByHmAM37gx82pUY6QK9EDbR
 GDNAfmFldggSoJfkRl5JuK6HQbP1ymGRSEHGNk+E5bf8NqLKMEbpAkmYGb5vlCsC3QGA
 CwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698293647; x=1698898447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NWMNJDe+S0+EZdJBo+3dWkXIm0dV/UW0LgPiVtKrpH8=;
 b=keruJ/RdTfWS7Vmnux5qqcuN1QU2t8+ZC834o6k0o3WdKzRJucwZfD0fcW1Akiq3gV
 V1MrXJHooS+PVyNxr6jWPlyurXjI10mSqZzQzv65HVgwYvenAY/8mlGRzT6D75xGGS5G
 Y8SLS0GU+3sWbcvdjNkUg9449bnJJk3rvlWnWqZLT6LuaR8vCpmBbP2AI5d19MblomIW
 IsOHxwwL3DN5tnUNBMuYuHJklI9z6X+KmP0Ef6sDGRaHD2FSev1k86BQNJ1bY2SqXRFg
 K50wXpB5hcUiUyR6i9m7ywCS7CQrnPHl4+7+luA5ELmef0y0NhiLSOTllAj2GInHRBJo
 O+Ig==
X-Gm-Message-State: AOJu0YwkDLNfoBpVyeejlJl1N3BkrxhhQaVoVfODvyNqbKrcpr8+rpek
 h2rayQcJW/3P6RszMHjk2bPQxRshPY/h4fxnWgE=
X-Google-Smtp-Source: AGHT+IEr3fW42+oH8+86utQGpqX1JDgmTnD1qhigrirnBAlQR3+z4rSzr8XWh2oVK1lkKFgV/nIhvQ==
X-Received: by 2002:a17:902:ecca:b0:1c7:562d:9b16 with SMTP id
 a10-20020a170902ecca00b001c7562d9b16mr17295736plh.24.1698293646957; 
 Wed, 25 Oct 2023 21:14:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001b8b2b95068sm9953929pli.204.2023.10.25.21.14.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 21:14:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/6] tcg/mips: Always implement movcond
Date: Wed, 25 Oct 2023 21:14:00 -0700
Message-Id: <20231026041404.1229328-3-richard.henderson@linaro.org>
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

Expand as branch over move if not supported in the ISA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index a5e6fe727b..f9b790ed8a 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1085,13 +1085,22 @@ static void tcg_out_movcond(TCGContext *s, TCGCond cond, TCGReg ret,
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


