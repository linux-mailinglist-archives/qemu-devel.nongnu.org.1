Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 128E2781544
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j0-00050W-Nu; Fri, 18 Aug 2023 18:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iw-0004z8-Uo
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iu-0004OV-O1
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc5acc627dso10917475ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396819; x=1693001619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y7y0D0sEaL0VTSukWCoFv1RFuNJvu9hO7InBuIwdRw4=;
 b=o94zIxRzh+E8UzkEVttPuwQ8pbhDgIKJAZPf3IvwL7qLiH9IOQpLmME2kLhsLfcTQc
 kkHFORx24pieNmRTdAFMcNv/zvTWSZ02FwmuHZk1hhhOdEGmYtAyOsQk9k1bOIkmyROb
 vXDnnwbTvqT4N23/3bMDxDLMlmg2Kb1fl6oi7vNjL09nVL2ARGj5cRCrx+Da1Svv3jYE
 v3eW3XqcRMzj2V4PucJDOqRnM+ggqjQQgK9i0751s8f0tzMrxKhFCRhJZspDrVHQfb0V
 l+cxdEbM/WUC9pLS+HB2dRWG3png17UHpr+qOFnJoIjJgGrbNI9Qgi4hYTGaNqXF7AVh
 6BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396819; x=1693001619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y7y0D0sEaL0VTSukWCoFv1RFuNJvu9hO7InBuIwdRw4=;
 b=QZS2h4ke2drrm0M8fz/ZPQWjT5D1pDBXPZ9vOHsVRrjtUU2Zpb1r0FjwjTOPOt2pt4
 RXg/aV4c0udZ078gYUu8PNBCvcIs0edsae4vQPVwEeVG0wUWapbCBbx+l8Yh2yJTDMHC
 ZINbfTX/EC++/UewrKZ/z3rJoKZovGvfHvMQs2KwVx1u/1k4tfksqOD9LxsyM7cXnDOt
 Vl04sNHGQ5S7Ihgipu9yH/k01qtEI+n52AHWkCbAc9vAttQvaQoW964PocGSux33jeMi
 onkw0v6FDr9dyBGou/innzyvywVleb3/FmnGKyIaHx2YybOM9Wcy48E6TvEurE39WsCJ
 xgqQ==
X-Gm-Message-State: AOJu0YypXOl+7STZhFlafBAemwQzUOQB0ZqkadH+U8Y0K+K7jR8rJHWo
 8IsztAEKTqSmM7yBlt/R7ZtDAtNz69VNA3ZEHuM=
X-Google-Smtp-Source: AGHT+IHlYfKFYKwkb7MGVxUQ5zMsX5T1k+UkdEYLoshSeoe0tjya46nhGERVaTqsFUPPFhsPI9Z7rA==
X-Received: by 2002:a17:903:22cd:b0:1bb:2093:efb1 with SMTP id
 y13-20020a17090322cd00b001bb2093efb1mr628274plg.27.1692396819322; 
 Fri, 18 Aug 2023 15:13:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 12/23] tcg/aarch64: Implement negsetcond_*
Date: Fri, 18 Aug 2023 15:13:16 -0700
Message-Id: <20230818221327.150194-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Trivial, as aarch64 has an instruction for this: CSETM.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h     |  4 ++--
 tcg/aarch64/tcg-target.c.inc | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 6080fddf73..e3faa9cff4 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -94,7 +94,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_extrl_i64_i32    0
 #define TCG_TARGET_HAS_extrh_i64_i32    0
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_div_i64          1
@@ -130,7 +130,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 35ca80cd56..7d8d114c9e 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2262,6 +2262,16 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
         break;
 
+    case INDEX_op_negsetcond_i32:
+        a2 = (int32_t)a2;
+        /* FALLTHRU */
+    case INDEX_op_negsetcond_i64:
+        tcg_out_cmp(s, ext, a1, a2, c2);
+        /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
+        tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
+                     TCG_REG_XZR, tcg_invert_cond(args[3]));
+        break;
+
     case INDEX_op_movcond_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -2868,6 +2878,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rA);
 
     case INDEX_op_mul_i32:
-- 
2.34.1


