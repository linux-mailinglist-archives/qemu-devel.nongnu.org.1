Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1097A3328
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMY-0006Ie-4p; Sat, 16 Sep 2023 18:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMV-0006HV-Jk
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:59 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMT-00047V-KY
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:59 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ab2436b57dso2150977b6e.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901716; x=1695506516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqYg31kX0a+sV4HnqFcr75vBUreLp6z9YJ7du9LtFxI=;
 b=xhkSdvkjBYC0W+pc+h/buWRfuy6J7/F20U4invS1qvDhh4BDQPP5izbPmTQhOBXQB4
 Kx25KHFAxKO+6TB2Wktm0Ad7vlYHGcZnYD9Qjkg73bFXPduHYp6BHCsoR+90nVlxFSHD
 HYtvHnzIsCvKGGOANGiCVWsnwmUiHedSfDEitxX5XI65KEACbCTZmBDLYq+LXSceOxnx
 BUItna5WKQ53t/qADtvT83KlYH/4XBOpi21MRSLGXzXr0Nw4YV5uZu+zHIXAk/kARs/I
 JASShDdkayHjPZJKWojBRFUo0F6hjSf2f4a8d+vkh79ey8BD7clQSxyPjOYVVIDy+J6u
 pZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901716; x=1695506516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqYg31kX0a+sV4HnqFcr75vBUreLp6z9YJ7du9LtFxI=;
 b=VxiwZhO7u13AgC0ZgPS6g9pBxaotDXOXHAD1n3d2IJ0NBLyD8zlUZ/IeZwJgQS/Yxj
 LRLEEoqyYDoUldx2gP1IIZSmF23+WkGhdYKSeT/O191r6ivrH2ZPqel6VNXyem+Dx+aB
 K5Fe9t7bAdhMWu1k26+zWYG5GskxlmlcKLQLQrHnR6EiFE43t39JvrfWRbyy/Iv8eRTP
 KNI4fkCVN3DRHaxF2V1WCFfHdSGx2Jqw26h/h0ims9XoO0LLHYQCWgvfbDsrCdiW+cYD
 UJXEz4GpnliosDsLdFk56+x8iEec0+L82hKOYBHGaaDvPUuuRM6kTCICUWZ8lGRdbfJz
 6ffw==
X-Gm-Message-State: AOJu0Yze51sJtcPqpHq07ADVZuSqQd6emow+x4ScRlIj5pVjpDbqdSNn
 5ehhUdCCIJqldQ3YM1SR4dPJaTcj4YBco2UuDjM=
X-Google-Smtp-Source: AGHT+IHUkTc3RV3jVaJnzPSvfORDSat9vVFfeaS9Z2ctcJ2wF5VsuPTYibnvAA/7WuMSoLmUivwrrA==
X-Received: by 2002:aca:1909:0:b0:3a7:7bd3:7ab7 with SMTP id
 l9-20020aca1909000000b003a77bd37ab7mr6194206oii.51.1694901716426; 
 Sat, 16 Sep 2023 15:01:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 4/7] tcg/loongarch64: Use cpuinfo.h
Date: Sat, 16 Sep 2023 15:01:48 -0700
Message-Id: <20230916220151.526140-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
References: <20230916220151.526140-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 8 ++++----
 tcg/loongarch64/tcg-target.c.inc | 8 +-------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 03017672f6..1bea15b02e 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -29,6 +29,8 @@
 #ifndef LOONGARCH_TCG_TARGET_H
 #define LOONGARCH_TCG_TARGET_H
 
+#include "host/cpuinfo.h"
+
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 64
 
@@ -85,8 +87,6 @@ typedef enum {
     TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
-extern bool use_lsx_instructions;
-
 /* used for function call generation */
 #define TCG_REG_CALL_STACK              TCG_REG_SP
 #define TCG_TARGET_STACK_ALIGN          16
@@ -171,10 +171,10 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 
-#define TCG_TARGET_HAS_qemu_ldst_i128   use_lsx_instructions
+#define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
 
 #define TCG_TARGET_HAS_v64              0
-#define TCG_TARGET_HAS_v128             use_lsx_instructions
+#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v256             0
 
 #define TCG_TARGET_HAS_not_vec          1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 40074c46b8..52f2c26ce1 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -32,8 +32,6 @@
 #include "../tcg-ldst.c.inc"
 #include <asm/hwcap.h>
 
-bool use_lsx_instructions;
-
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "zero",
@@ -2316,10 +2314,6 @@ static void tcg_target_init(TCGContext *s)
         exit(EXIT_FAILURE);
     }
 
-    if (hwcap & HWCAP_LOONGARCH_LSX) {
-        use_lsx_instructions = 1;
-    }
-
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
 
@@ -2335,7 +2329,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
 
-    if (use_lsx_instructions) {
+    if (cpuinfo & CPUINFO_LSX) {
         tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
-- 
2.34.1


