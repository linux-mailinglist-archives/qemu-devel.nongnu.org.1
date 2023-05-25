Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDA5711348
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQO-0008Sy-LR; Thu, 25 May 2023 14:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQM-0008RY-94
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQK-0005xU-LZ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ae452c2777so148465ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038251; x=1687630251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HzbBgDnZuyuhsCwWOOWXMwV0vq7jpkLgIfNcztp/e8=;
 b=l48/yNCUvYyle7p7nqC5egUaP7kcI08KzHXlugz/fqZcK1lNeuPHuqI5kXy/ZfmawJ
 4PfWF/Ka3uF4ng5yah/fs101yIxx3A3UoXaDZkwlIRchtCxeOARE0oRf6O62TK6b6oSo
 EM8iENDCkAZYuUHsguJQ0HFrJYsyOsG5VbbV+f3g2aTMfYY0hRzHp77rlnrSZxJvMz3s
 Mazovd9D4wXVO5NAC1s7A+lA226uoe22lZmjDKh1AKUDmzLhJ4kIA1+jvGwAg1cdfPW9
 HHmttDMs0UvyQ+wcKud0aBFfezI8ZqVKWiG+Kd+JRFSPD1D58W694xKTJwjcEGcxEC+i
 Uj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038251; x=1687630251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HzbBgDnZuyuhsCwWOOWXMwV0vq7jpkLgIfNcztp/e8=;
 b=Mdn1RmEg274xo7CDtaRAH7w2v/2wKHFhipf78XyX7cq+x0YypVHBd2a5RVfi7y8pNe
 NdYKY3flmUdUFym27QckX8rtf/m7F+rHbEn3nUZF+ssqr52MqxOgChduHkqpJAm023Wn
 5i1hUlcSaQgC0XNTwG3JQeJ2RXl2JpGbUSsVOmLmo9h8HYtNq2ltybiE4EE0Aa53mddG
 6ZPNZZEIIpUTO/d8VcaOqLq9gK0aZ1F3oT6xPSZlQ7oe+VZl6iO03UGmnEHOlmtFBm9n
 3jOCYbeyG0FNVNzKhNOCzqgUCzwbrVOGgZ+vkHGhuRsCPlirG0OvKaoCerbxj9oRvYrV
 YuaQ==
X-Gm-Message-State: AC+VfDyihvm9fkpTfFQyDuAq0ZF68C1ux2C84Ig1bTcOZdyTLur/5tNg
 EB4mt29/5/5K1MgiYyOh5+kcglO51KixQouAYgE=
X-Google-Smtp-Source: ACHHUZ4Z9aKO9PhuRzx+HKtgcJTCyCCggaDt7UQqOchrZr5SoVBaPxjktbz7R8l7CCjjtOPJa7Ytnw==
X-Received: by 2002:a17:903:44c:b0:1ae:4dda:c2e with SMTP id
 iw12-20020a170903044c00b001ae4dda0c2emr2591059plb.13.1685038251449; 
 Thu, 25 May 2023 11:10:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 16/23] tcg/riscv: Support ADD.UW, SEXT.B, SEXT.H,
 ZEXT.H from Zba+Zbb
Date: Thu, 25 May 2023 11:10:29 -0700
Message-Id: <20230525181036.1559435-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 tcg/riscv/tcg-target.c.inc | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index edfe4c8f8d..297119817b 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -593,26 +593,42 @@ static void tcg_out_ext8u(TCGContext *s, TCGReg ret, TCGReg arg)
 
 static void tcg_out_ext16u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
-    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
-    tcg_out_opc_imm(s, OPC_SRLIW, ret, ret, 16);
+    if (have_zbb) {
+        tcg_out_opc_reg(s, OPC_ZEXT_H, ret, arg, TCG_REG_ZERO);
+    } else {
+        tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
+        tcg_out_opc_imm(s, OPC_SRLIW, ret, ret, 16);
+    }
 }
 
 static void tcg_out_ext32u(TCGContext *s, TCGReg ret, TCGReg arg)
 {
-    tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
-    tcg_out_opc_imm(s, OPC_SRLI, ret, ret, 32);
+    if (have_zba) {
+        tcg_out_opc_reg(s, OPC_ADD_UW, ret, arg, TCG_REG_ZERO);
+    } else {
+        tcg_out_opc_imm(s, OPC_SLLI, ret, arg, 32);
+        tcg_out_opc_imm(s, OPC_SRLI, ret, ret, 32);
+    }
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
-    tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 24);
+    if (have_zbb) {
+        tcg_out_opc_imm(s, OPC_SEXT_B, ret, arg, 0);
+    } else {
+        tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 24);
+        tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 24);
+    }
 }
 
 static void tcg_out_ext16s(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
 {
-    tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
-    tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 16);
+    if (have_zbb) {
+        tcg_out_opc_imm(s, OPC_SEXT_H, ret, arg, 0);
+    } else {
+        tcg_out_opc_imm(s, OPC_SLLIW, ret, arg, 16);
+        tcg_out_opc_imm(s, OPC_SRAIW, ret, ret, 16);
+    }
 }
 
 static void tcg_out_ext32s(TCGContext *s, TCGReg ret, TCGReg arg)
-- 
2.34.1


