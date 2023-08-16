Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FA077E44D
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHwJ-0006T7-27; Wed, 16 Aug 2023 10:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHwA-0006Gz-SJ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:54 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHw7-0002P9-9Q
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:54 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6887480109bso1316210b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692197750; x=1692802550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NHyHJm0GL/uGu27M1d2LW9mRlg3KlAClqxw38Vui2Us=;
 b=AYTZg+NhRsQ7j7+S0YOUpo5k5LTVcdSv3EwcVjO/1ETZH5sI303JSeGMmCffMvN1MJ
 QtLy2EMzjhjQqVeD/6aBVNRP2+csr9PYFuQSHxOEqUqsJhjxbA9H8DccbPXBYzQ7px6K
 NTFytT1h0GfR88mJlTjwBpuMGxVRZWeje+s63WTvDkLZI/UuFRo4ymv6IV3LPeYK+LJE
 bZnQxbtkC6eaCaQH3ZKiUDH1mcvHSWNsIaA1a1kMZ1osSrueHOxXEqZxVsRs0Ucr/u/6
 rvRDLneXa6bQs9cvaVrM3nxGH5AqXDOfhQgraPFHET/kzq2e+5tJYH8WsT7IfCQMmgWc
 zGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692197750; x=1692802550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHyHJm0GL/uGu27M1d2LW9mRlg3KlAClqxw38Vui2Us=;
 b=iOe4S4eHFQl0Gqli4YM/i5/qh1HarSwMzHDEPSnqG5WVrFbY1zPe/xQqtcv5u2yCq8
 HelrIIRzNYgv/s4qPuTzYPSPQR5HAMUv5P9yKxRUBrbZJjdLORS23LPboaVlFYYuCi0Y
 +kxHHqWFK4TYtwaB23ivbYB973Bjnmwsf8pjO3TIoSbpttL05F2SEGF/fphgmm+RxzZ/
 3JN6QVr3qWv/j0dNBQlntixyPIaCh4IV/KqerjgiGLc78xobX4jfinzEk75HHKMqCo74
 jLf1QweRl5/sec2P7oBoNd+Tvs19Ex+JvJ2VOCaq1rhjVA9YsiYX3GEnfE/bqRHrnrtg
 1pOg==
X-Gm-Message-State: AOJu0YxAc2I1l47urZu2QGsmDmVNZXkexTX50h54eEb3OSQ0tCy4r4om
 g1bMqf2aDywgETbbRT/1btdt4zAqgbAScOrmBDU=
X-Google-Smtp-Source: AGHT+IEv76P0uBNuTLvbJSPr89j9x9/6+LcbsvRm3ly+qZkXX31bh+1QzYZ2h6K1RABmHhSuOyks7A==
X-Received: by 2002:a05:6a00:c89:b0:682:5a68:9846 with SMTP id
 a9-20020a056a000c8900b006825a689846mr2706288pfv.16.1692197749964; 
 Wed, 16 Aug 2023 07:55:49 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 fe22-20020a056a002f1600b00682a0184742sm11619069pfb.148.2023.08.16.07.55.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:55:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] tcg/i386: Drop BYTEH deposits for 64-bit
Date: Wed, 16 Aug 2023 07:55:45 -0700
Message-Id: <20230816145547.477974-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145547.477974-1-richard.henderson@linaro.org>
References: <20230816145547.477974-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

It is more useful to allow low-part deposits into all registers
than to restrict allocation for high-byte deposits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h | 2 +-
 tcg/i386/tcg-target-con-str.h | 1 -
 tcg/i386/tcg-target.h         | 4 ++--
 tcg/i386/tcg-target.c.inc     | 7 +++----
 4 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 5ea3a292f0..3949d49538 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -33,7 +33,7 @@ C_O1_I1(r, q)
 C_O1_I1(r, r)
 C_O1_I1(x, r)
 C_O1_I1(x, x)
-C_O1_I2(Q, 0, Q)
+C_O1_I2(q, 0, q)
 C_O1_I2(q, r, re)
 C_O1_I2(r, 0, ci)
 C_O1_I2(r, 0, r)
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index 24e6bcb80d..95a30e58cd 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -19,7 +19,6 @@ REGS('D', 1u << TCG_REG_EDI)
 REGS('r', ALL_GENERAL_REGS)
 REGS('x', ALL_VECTOR_REGS)
 REGS('q', ALL_BYTEL_REGS)     /* regs that can be used as a byte operand */
-REGS('Q', ALL_BYTEH_REGS)     /* regs with a second byte (e.g. %ah) */
 REGS('L', ALL_GENERAL_REGS & ~SOFTMMU_RESERVE_REGS)  /* qemu_ld/st */
 REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
 
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 2a2e3fffa8..30cce01ca4 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -227,8 +227,8 @@ typedef enum {
 #define TCG_TARGET_HAS_cmpsel_vec       -1
 
 #define TCG_TARGET_deposit_i32_valid(ofs, len) \
-    (((ofs) == 0 && (len) == 8) || ((ofs) == 8 && (len) == 8) || \
-     ((ofs) == 0 && (len) == 16))
+    (((ofs) == 0 && ((len) == 8 || (len) == 16)) || \
+     (TCG_TARGET_REG_BITS == 32 && (ofs) == 8 && (len) == 8))
 #define TCG_TARGET_deposit_i64_valid    TCG_TARGET_deposit_i32_valid
 
 /* Check for the possibility of high-byte extraction and, for 64-bit,
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a6b2eae995..ba40dd0f4d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -144,7 +144,6 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 # define TCG_REG_L1 TCG_REG_EDX
 #endif
 
-#define ALL_BYTEH_REGS         0x0000000fu
 #if TCG_TARGET_REG_BITS == 64
 # define ALL_GENERAL_REGS      0x0000ffffu
 # define ALL_VECTOR_REGS       0xffff0000u
@@ -152,7 +151,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #else
 # define ALL_GENERAL_REGS      0x000000ffu
 # define ALL_VECTOR_REGS       0x00ff0000u
-# define ALL_BYTEL_REGS        ALL_BYTEH_REGS
+# define ALL_BYTEL_REGS        0x0000000fu
 #endif
 #ifdef CONFIG_SOFTMMU
 # define SOFTMMU_RESERVE_REGS  ((1 << TCG_REG_L0) | (1 << TCG_REG_L1))
@@ -2752,7 +2751,7 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (args[3] == 0 && args[4] == 8) {
             /* load bits 0..7 */
             tcg_out_modrm(s, OPC_MOVB_EvGv | P_REXB_R | P_REXB_RM, a2, a0);
-        } else if (args[3] == 8 && args[4] == 8) {
+        } else if (TCG_TARGET_REG_BITS == 32 && args[3] == 8 && args[4] == 8) {
             /* load bits 8..15 */
             tcg_out_modrm(s, OPC_MOVB_EvGv, a2, a0 + 4);
         } else if (args[3] == 0 && args[4] == 16) {
@@ -3312,7 +3311,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return C_O1_I2(Q, 0, Q);
+        return C_O1_I2(q, 0, q);
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-- 
2.34.1


