Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CE3786169
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOe-0008WT-1t; Wed, 23 Aug 2023 16:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOb-0008R7-7t
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0005WR-SE
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:02 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso47178615ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822236; x=1693427036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8q9Haud9Zky3AnhOVlbezI32RyFzege/QayVrJIGCI=;
 b=aXlyRFwy6yp2lZQ3OHQzvJwqOqUmy4znq3oAr0H46olvNcezfyDU7OMeDhj398dftK
 kwGN7dJXcEbvuSLrQxtvKj7lKiBS6496isD0poEkfpAj51OyPRPMnfrmxEniOIk4U3Ew
 OHQsEw7FPq0xgcdTl7haGjeg+5Rr2B6SJPDqG4Rg1zvlbPYKoLwuqIux1V83jEtnShTG
 tnmE3y6nYCc05y4ZWz56bsmGWg2Ion0nXhglml4NpdlqWU04XpFaB0fBTSwTLhjOiJpt
 /R/23AL/DAFMXoCh3qF1iTmlLbPvdT0lJfA9ixRvIVetxLbts1shMJxRkznzNIwCIXzY
 gCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822236; x=1693427036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8q9Haud9Zky3AnhOVlbezI32RyFzege/QayVrJIGCI=;
 b=hMAINlI/hr47htsx6rHRph6HAOo25Wl1FlAHxdEq3ZWvMQZsH0tiqdX6no0A/SbRGh
 LuXtL7XQBVB+O2+OLZsQo+uGexBQitxwxPlxJWUKYgsGaRpqgBMe87z61N6ZUECCn3IQ
 leHH3Hskv3D6MjE0hFiFvg43T7awTMUCuZQDP58FbiLhXb83DmCZqVF5qD+7J354XVR5
 QVs6zxpu7UO5pfDG//imG3YWMRu6GAVvVvAwSq7TpFue2lF/VkFexPSJBTQbhRJxT2NT
 jF0gwvvsEgo+2wdtUTN6OKpehrY3FoIf91Z4oNWeX//IdZpFyowpIrdfN3RFC3RT7KKe
 Z8FQ==
X-Gm-Message-State: AOJu0Yymer/qSKJ1Cm1X/iTRfQlC6D5mvU8qkgl7y5JO21oTTWotqCtV
 l2RqWStaEEpW9qZeDpHKHTfLLLEfNphZgjlt0/8=
X-Google-Smtp-Source: AGHT+IFEkTaPLswUWo38fViPCiiQ0G54lGH0Hmod9+LW96nMwyl0I/T6Z3uSQhWiW+dzrOBICGaFwA==
X-Received: by 2002:a17:903:4c5:b0:1bd:ec9e:59fe with SMTP id
 jm5-20020a17090304c500b001bdec9e59femr13062074plb.68.1692822236681; 
 Wed, 23 Aug 2023 13:23:56 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 31/48] tcg/sparc64: Implement negsetcond_*
Date: Wed, 23 Aug 2023 13:23:09 -0700
Message-Id: <20230823202326.1353645-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.h     |  4 ++--
 tcg/sparc64/tcg-target.c.inc | 40 +++++++++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 79889db760..3d41c9659b 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -106,7 +106,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sextract_i32     0
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_movcond_i32      1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_mulu2_i32        1
@@ -143,7 +143,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_sextract_i64     0
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_movcond_i64      1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_add2_i64         1
 #define TCG_TARGET_HAS_sub2_i64         1
 #define TCG_TARGET_HAS_mulu2_i64        0
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index ffcb879211..f2a346a1bd 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -720,7 +720,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
 }
 
 static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg c1, int32_t c2, int c2const)
+                                TCGReg c1, int32_t c2, int c2const, bool neg)
 {
     /* For 32-bit comparisons, we can play games with ADDC/SUBC.  */
     switch (cond) {
@@ -760,22 +760,34 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
     default:
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movcc(s, cond, MOVCC_ICC, ret, 1, 1);
+        tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
         return;
     }
 
     tcg_out_cmp(s, c1, c2, c2const);
     if (cond == TCG_COND_LTU) {
-        tcg_out_arithi(s, ret, TCG_REG_G0, 0, ARITH_ADDC);
+        if (neg) {
+            /* 0 - 0 - C = -C = (C ? -1 : 0) */
+            tcg_out_arithi(s, ret, TCG_REG_G0, 0, ARITH_SUBC);
+        } else {
+            /* 0 + 0 + C =  C = (C ? 1 : 0) */
+            tcg_out_arithi(s, ret, TCG_REG_G0, 0, ARITH_ADDC);
+        }
     } else {
-        tcg_out_arithi(s, ret, TCG_REG_G0, -1, ARITH_SUBC);
+        if (neg) {
+            /* 0 + -1 + C = C - 1 = (C ? 0 : -1) */
+            tcg_out_arithi(s, ret, TCG_REG_G0, -1, ARITH_ADDC);
+        } else {
+            /* 0 - -1 - C = 1 - C = (C ? 0 : 1) */
+            tcg_out_arithi(s, ret, TCG_REG_G0, -1, ARITH_SUBC);
+        }
     }
 }
 
 static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
-                                TCGReg c1, int32_t c2, int c2const)
+                                TCGReg c1, int32_t c2, int c2const, bool neg)
 {
-    if (use_vis3_instructions) {
+    if (use_vis3_instructions && !neg) {
         switch (cond) {
         case TCG_COND_NE:
             if (c2 != 0) {
@@ -796,11 +808,11 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
        if the input does not overlap the output.  */
     if (c2 == 0 && !is_unsigned_cond(cond) && c1 != ret) {
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movr(s, cond, ret, c1, 1, 1);
+        tcg_out_movr(s, cond, ret, c1, neg ? -1 : 1, 1);
     } else {
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movcc(s, cond, MOVCC_XCC, ret, 1, 1);
+        tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
     }
 }
 
@@ -1355,7 +1367,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
     case INDEX_op_setcond_i32:
-        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2);
+        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, false);
+        break;
+    case INDEX_op_negsetcond_i32:
+        tcg_out_setcond_i32(s, args[3], a0, a1, a2, c2, true);
         break;
     case INDEX_op_movcond_i32:
         tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
@@ -1437,7 +1452,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
         break;
     case INDEX_op_setcond_i64:
-        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2);
+        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, false);
+        break;
+    case INDEX_op_negsetcond_i64:
+        tcg_out_setcond_i64(s, args[3], a0, a1, a2, c2, true);
         break;
     case INDEX_op_movcond_i64:
         tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
@@ -1564,6 +1582,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, rZ, rJ);
 
     case INDEX_op_brcond_i32:
-- 
2.34.1


