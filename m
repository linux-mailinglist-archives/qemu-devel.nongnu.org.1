Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13830A8A8BD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 22:02:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m7Z-00019v-EO; Tue, 15 Apr 2025 15:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m2e-0004UN-FQ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:34:03 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1T-0002rQ-Hl
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:33:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22548a28d0cso86276075ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745559; x=1745350359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a3SfxIcs1zeNRs5wsCJLlcN5jNoj68T47ybcBmDi4A8=;
 b=s6eMLDfjRKqxFAIRJZT6keePj9jK9aWqOGnXzmQlai4GA/e55NqU6FQCOdUlhyInom
 Ehu3aAx1fiY9dJpYlo/tekqgDZYy0cLDDNDJnaO9JZb8oBm11JFtJRBnqvIqSqLGfKpl
 tQK2gPiGmrMYHIqD8pYOZSL3yJzGnl6rVePOCGdOpa1YlcUBkZT3x79cU/4d1X0EBfTd
 3ZNjHYIK40xIGj5QA1hyfLO1oERCDEICFuu409MDVouRXP/NYZgSNGzVkRSB4gvgmpBm
 K/oWs79//NiI9sZnqL2lGTRrXJFjWzvPhF10FOWbnk0sbMncky1rjjvzmU3EZZgb7NW0
 L8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745559; x=1745350359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a3SfxIcs1zeNRs5wsCJLlcN5jNoj68T47ybcBmDi4A8=;
 b=OSXnS7DBS/k2qdklSVtfXtuWpbo3dtXlTD1/pi61ydZCfJkM227C16NGGimXQlzG48
 QOGOWKwcZuGpizSD3J7ajTM1CA/eioZSKY1u5XAPcvPvfkshYibDYJE8Ucpn55hXE6tg
 G8GUw2andd64fxTKV+0BJfaPzezhzhjfzvAlckCKUnzCNdcGEKl99O+ur6Tq1al8P+Pi
 FlYtRjIgnrYj75ez6kMiiqh7wrZgmN1Kt9+ksSea3aq8vQrfUqPXiyKxwA61ci5aghap
 TdgJJtj2RbewT3bxGkisIMxf3fe1X4oRCJIeJYbt9+kxT8UfkdKgDuRULfCuk47KYWah
 AnGg==
X-Gm-Message-State: AOJu0YynIcqKyFz/7lN+0Hf7kj+LTSFuVL2ogpcOj9WFCXos8j3bnPk5
 BsY36ec3YB2rjR/X6uaxpyO4SOgJfvsDL5S8UU6MawssLqXY+g1wuy0G1AvDqvP0trGcfS8GlTw
 6
X-Gm-Gg: ASbGncvhWlvcnpvJnk4n60BJCPJtA1FfK8LQA8BSSlkV62ro/TNiS0p5aWfSdD6+W8Q
 pMSyZVrcPFiNO/Gg09LIY46paMARDehxH3KxLqS4AehdBkf0+Fy4pZUkYR4bcIRHE+cvlQK4udf
 b1G9ns396EDwbOrjCrjiu+QdHAlyqLtITxQviIEL30rWJHSlJkmFikrTMPuosVTzGOTaBjMXuiB
 aneO+9RvzEvT3BVWE2nGzAV02Q2ocbDLOwfw+8/g5scT1aZjaZuwShMD2LFegv9LzmWzNhdFflv
 KjrdE64KYDZAQmup1GTW+4K1gLUJrbCitPMgxU/wknqSRe/oyblpzQR903D8iQXDV3gPHm9fbgM
 =
X-Google-Smtp-Source: AGHT+IFSyqkn739eKmIWt05B6rX8GCD+VI0egZMUyRuslyU+jXAPCXdqBKut7jvhObUPwNZTJbjBJw==
X-Received: by 2002:a17:903:2a8e:b0:224:1c41:a4bc with SMTP id
 d9443c01a7336-22c318ca4e3mr6367215ad.12.1744745559529; 
 Tue, 15 Apr 2025 12:32:39 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 098/163] tcg: Convert extu_i32_i64 to TCGOutOpUnary
Date: Tue, 15 Apr 2025 12:24:09 -0700
Message-ID: <20250415192515.232910-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 15 ++++++++++++---
 tcg/aarch64/tcg-target.c.inc     |  2 --
 tcg/i386/tcg-target.c.inc        |  2 --
 tcg/loongarch64/tcg-target.c.inc |  2 --
 tcg/mips/tcg-target.c.inc        |  2 --
 tcg/ppc/tcg-target.c.inc         |  2 --
 tcg/riscv/tcg-target.c.inc       |  2 --
 tcg/s390x/tcg-target.c.inc       |  4 ----
 tcg/sparc64/tcg-target.c.inc     |  2 --
 tcg/tci/tcg-target.c.inc         |  2 --
 10 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 35f192e483..b6c1efa828 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1083,6 +1083,16 @@ static const TCGOutOpUnary outop_exts_i32_i64 = {
     .base.static_constraint = C_O1_I1(r, r),
     .out_rr = tgen_exts_i32_i64,
 };
+
+static void tgen_extu_i32_i64(TCGContext *s, TCGType t, TCGReg a0, TCGReg a1)
+{
+    tcg_out_extu_i32_i64(s, a0, a1);
+}
+
+static const TCGOutOpUnary outop_extu_i32_i64 = {
+    .base.static_constraint = C_O1_I1(r, r),
+    .out_rr = tgen_extu_i32_i64,
+};
 #endif
 
 /*
@@ -1140,6 +1150,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
 #else
     OUTOP(INDEX_op_bswap64, TCGOutOpUnary, outop_bswap64),
     OUTOP(INDEX_op_ext_i32_i64, TCGOutOpUnary, outop_exts_i32_i64),
+    OUTOP(INDEX_op_extu_i32_i64, TCGOutOpUnary, outop_extu_i32_i64),
 #endif
 };
 
@@ -5427,9 +5438,6 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     /* emit instruction */
     TCGType type = TCGOP_TYPE(op);
     switch (op->opc) {
-    case INDEX_op_extu_i32_i64:
-        tcg_out_extu_i32_i64(s, new_args[0], new_args[1]);
-        break;
     case INDEX_op_extrl_i64_i32:
         tcg_out_extrl_i64_i32(s, new_args[0], new_args[1]);
         break;
@@ -5490,6 +5498,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
 
     case INDEX_op_bswap64:
     case INDEX_op_ext_i32_i64:
+    case INDEX_op_extu_i32_i64:
         assert(TCG_TARGET_REG_BITS == 64);
         /* fall through */
     case INDEX_op_ctpop:
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 68f7a1cec2..44314f6a0f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2710,7 +2710,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -3176,7 +3175,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 14b912beb7..8371cfaf5a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3413,7 +3413,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -4000,7 +3999,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, 0);
 
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
         return C_O1_I1(r, r);
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e2dbd08e12..3a85b6f4ba 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1931,7 +1931,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2458,7 +2457,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ld8s_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index e992a468eb..b6b7070fbb 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2364,7 +2364,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2390,7 +2389,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index fea767573c..e1767f1d6c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3640,7 +3640,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:      /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:   /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:   /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -4269,7 +4268,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index e5fe15c338..48d4325097 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2630,7 +2630,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -2873,7 +2872,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
         return C_O1_I1(r, r);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 5c5a38c2c8..d81b8fb8f4 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2997,7 +2997,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
@@ -3470,9 +3469,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_extu_i32_i64:
-        return C_O1_I1(r, r);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e93ef8e7f2..d52907f7e3 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1883,7 +1883,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     default:
         g_assert_not_reached();
     }
@@ -1908,7 +1907,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ecff90404f..3cf2913acd 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -55,7 +55,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_extu_i32_i64:
         return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
@@ -1108,7 +1107,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_call:     /* Always emitted via tcg_out_call.  */
     case INDEX_op_exit_tb:  /* Always emitted via tcg_out_exit_tb.  */
     case INDEX_op_goto_tb:  /* Always emitted via tcg_out_goto_tb.  */
-    case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     default:
         g_assert_not_reached();
-- 
2.43.0


