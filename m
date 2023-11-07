Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764397E333D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:51:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C97-0008BD-5F; Mon, 06 Nov 2023 21:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C94-0008AY-Vo
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:50 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C93-0005q0-86
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:50 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6c320a821c4so4636758b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325328; x=1699930128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3O8/mcQ+FXQ1L4q0gH6GTHD/Q1jUKjZFDP8Gx7yZ+4=;
 b=oG5Pu8ShiJLPO2OPdMIGdvf6x69sf+2oWmJzF6zDzMxApvDu1ZTYyPQSftGfmFwX4D
 U3VdZGBg98igwo2Ekf0tUf6DgDy9LriFHnHAcNFMX0NdJZREFDfbgnkuxDF5o0U+H/oj
 lf94vSpL019qnVnwlbYIIbWp0JFw6x76eJqWwR1ymlBkKxUDlcVMKIJXGaIpNlaMOV0D
 2D+m9dUCQoiU8pZHpGlXbEGgen4/qaHIr/3rJdiv3kRJm15GINnuEJFUBBgpRexbrklV
 PaXQoEtcVrPOBkAbpiGSn7UnF9jjMXZVbYStZOjwcCIkjJm+GPjnVhttB5lcB7/dZcOZ
 IjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325328; x=1699930128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q3O8/mcQ+FXQ1L4q0gH6GTHD/Q1jUKjZFDP8Gx7yZ+4=;
 b=uRkebovY+a+Dzv//rmmYKk582bJjzDRzKW7gwwJN0v7V8+sUrnvhevNS20f4hcpomn
 Ad8Ba+oa5jcSq4giJw8cFi7sbl5R4ioU3oDVRhIA1/kp6fTdDDZCrMhy4jeE8vxdikJC
 CYIM/PaljHtT26afcxadJp3oF0ZCgjK8Ph3w0D3cjp1CKuE/Ff0PLWpv9/6qPfDP8UkM
 jqHbwGLr8pf/txCei5awBiKxn90vyj5rrK6tUNyOloJkkCwV4Trr1JaWfV6mARvTm73m
 L1jdIGU67duC+2ARsCcyz7uFwGwjTRAiEaRCMPS7Q29FEI+P4S5lFncuixDAVxxklrwh
 7H0g==
X-Gm-Message-State: AOJu0Yz+1h/57bNShdnG/5rSa9h5qHTUGYw293L2sW/SNVB0r5zFvR7c
 RCzmgI+ClsWLRA8xSQYyrPeivl7eboLPSJRm/DM=
X-Google-Smtp-Source: AGHT+IEsfhnce4quM9zKzzhFFgik3T7RGEtJ4pXtOCnPy//tfhHkngcR7Abd/xaHC4tJjwEJhcWrmg==
X-Received: by 2002:a05:6a00:1345:b0:6bd:f760:6ab1 with SMTP id
 k5-20020a056a00134500b006bdf7606ab1mr29533980pfu.14.1699325327870; 
 Mon, 06 Nov 2023 18:48:47 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PATCH 05/35] tcg/loongarch64: Use cpuinfo.h
Date: Mon,  6 Nov 2023 18:48:12 -0800
Message-Id: <20231107024842.7650-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiajie Chen <c@jia.je>
Message-Id: <20230916220151.526140-5-richard.henderson@linaro.org>
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
index a1a387df31..ae13c1f666 100644
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
@@ -2314,10 +2312,6 @@ static void tcg_target_init(TCGContext *s)
         exit(EXIT_FAILURE);
     }
 
-    if (hwcap & HWCAP_LOONGARCH_LSX) {
-        use_lsx_instructions = 1;
-    }
-
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
 
@@ -2333,7 +2327,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
 
-    if (use_lsx_instructions) {
+    if (cpuinfo & CPUINFO_LSX) {
         tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
-- 
2.34.1


