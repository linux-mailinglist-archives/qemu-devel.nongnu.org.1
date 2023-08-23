Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C8786162
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOh-0000Fg-68; Wed, 23 Aug 2023 16:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOZ-0008PT-2i
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:04 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOU-0005WJ-Rd
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:24:02 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bf078d5fb7so41367365ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822236; x=1693427036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bD2O0lrkRHwVXL3IDULQ9hX9URo+FxxM1i6zeSiE9KI=;
 b=xMoO/x4K8Z1GjNfH6c6BgtdcV9JO/bR7AS1n4bAFGkhCm8uEhf3aJsBmptpDbeklS3
 YoopuyuFt5YVmPphx8bnm8KIuHyOQRZe4dZTbl6X6kQ32KKKBbSn+W5soW9TPTO75iL5
 iOzJP6PkvSXFtaYPLN5wnZ7oNWFgIO3O5RAgV4lXcR9uk8D5de8TbVFMmFd69ze9deTS
 Db/IWxnGhWrlYLxkFE5lNQjcuSIurtz9nLGKLnFDN9sR4kJ5wbuVPjlk8rn/+exUrHTX
 3jTGlY+I3fBsNmXWrfaA3JuM0tvg0GZpu95L0iVS3a075HvraXF98N4QQjWFI+K0IsoL
 tJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822236; x=1693427036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bD2O0lrkRHwVXL3IDULQ9hX9URo+FxxM1i6zeSiE9KI=;
 b=Ac02vhPH4KKzvrFoN7FK4A9JoD32yeBRBiEYNrxK0Gvj1eJa23A4l9neG7Bn4nzqe5
 c3l/sKgrgVHSPXujL+/PZlIntPLuj6LA2CqNLPK2eiSld1T58mWBsyOM2el+jj3RsFEa
 XaAFA0Q76PE9t98/mVoLnE0H9HlbLE3sOMj3RkQloO/lxu+kHW7dbYSxvpclaVCP8Aa1
 iy9z5FsHoQNwpx97aR/eEE/jinuUKlHh8cO2MDPEnq1Wf+UfFAwwEeOXqh5zE+x0L6j6
 Y/yt+d3CCa+NUKFcjnDNz7nEfO35XDuDcIbNB6/kQ/r8YUWplmJ3b8H2ypiUw1u4ShOB
 gwiQ==
X-Gm-Message-State: AOJu0YwI4u7EDCr1YQn6ZdbUnOmCf6rerD/D636wd9H9Q1DRjzj0o6rk
 w/qtvklV6bFquEGRlJcm1qWvHR1q2Zi4J7HkDGA=
X-Google-Smtp-Source: AGHT+IGH1s5ThQMKPYftctY9d4qP9jDRobRfXR9JTNtcg5BCYPQTIWg/3EddKeWtPxz8InrrJ/ypEA==
X-Received: by 2002:a17:902:9888:b0:1bb:25bd:d091 with SMTP id
 s8-20020a170902988800b001bb25bdd091mr11399295plp.30.1692822235960; 
 Wed, 23 Aug 2023 13:23:55 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/48] tcg/s390x: Implement negsetcond_*
Date: Wed, 23 Aug 2023 13:23:08 -0700
Message-Id: <20230823202326.1353645-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 tcg/s390x/tcg-target.h     |  4 +-
 tcg/s390x/tcg-target.c.inc | 78 +++++++++++++++++++++++++-------------
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 123a4b1645..50e12ef9d6 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -96,7 +96,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sextract_i32   0
 #define TCG_TARGET_HAS_extract2_i32   0
 #define TCG_TARGET_HAS_movcond_i32    1
-#define TCG_TARGET_HAS_negsetcond_i32 0
+#define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_add2_i32       1
 #define TCG_TARGET_HAS_sub2_i32       1
 #define TCG_TARGET_HAS_mulu2_i32      0
@@ -132,7 +132,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_sextract_i64   0
 #define TCG_TARGET_HAS_extract2_i64   0
 #define TCG_TARGET_HAS_movcond_i64    1
-#define TCG_TARGET_HAS_negsetcond_i64 0
+#define TCG_TARGET_HAS_negsetcond_i64 1
 #define TCG_TARGET_HAS_add2_i64       1
 #define TCG_TARGET_HAS_sub2_i64       1
 #define TCG_TARGET_HAS_mulu2_i64      1
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a94f7908d6..ecd8aaf2a1 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1266,7 +1266,8 @@ static int tgen_cmp(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
 }
 
 static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
-                         TCGReg dest, TCGReg c1, TCGArg c2, int c2const)
+                         TCGReg dest, TCGReg c1, TCGArg c2,
+                         bool c2const, bool neg)
 {
     int cc;
 
@@ -1275,11 +1276,27 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
         /* Emit: d = 0, d = (cc ? 1 : d).  */
         cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
         tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
-        tcg_out_insn(s, RIEg, LOCGHI, dest, 1, cc);
+        tcg_out_insn(s, RIEg, LOCGHI, dest, neg ? -1 : 1, cc);
         return;
     }
 
- restart:
+    switch (cond) {
+    case TCG_COND_GEU:
+    case TCG_COND_LTU:
+    case TCG_COND_LT:
+    case TCG_COND_GE:
+        /* Swap operands so that we can use LEU/GTU/GT/LE.  */
+        if (!c2const) {
+            TCGReg t = c1;
+            c1 = c2;
+            c2 = t;
+            cond = tcg_swap_cond(cond);
+        }
+        break;
+    default:
+        break;
+    }
+
     switch (cond) {
     case TCG_COND_NE:
         /* X != 0 is X > 0.  */
@@ -1292,11 +1309,20 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
 
     case TCG_COND_GTU:
     case TCG_COND_GT:
-        /* The result of a compare has CC=2 for GT and CC=3 unused.
-           ADD LOGICAL WITH CARRY considers (CC & 2) the carry bit.  */
+        /*
+         * The result of a compare has CC=2 for GT and CC=3 unused.
+         * ADD LOGICAL WITH CARRY considers (CC & 2) the carry bit.
+         */
         tgen_cmp(s, type, cond, c1, c2, c2const, true);
         tcg_out_movi(s, type, dest, 0);
         tcg_out_insn(s, RRE, ALCGR, dest, dest);
+        if (neg) {
+            if (type == TCG_TYPE_I32) {
+                tcg_out_insn(s, RR, LCR, dest, dest);
+            } else {
+                tcg_out_insn(s, RRE, LCGR, dest, dest);
+            }
+        }
         return;
 
     case TCG_COND_EQ:
@@ -1310,27 +1336,17 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
 
     case TCG_COND_LEU:
     case TCG_COND_LE:
-        /* As above, but we're looking for borrow, or !carry.
-           The second insn computes d - d - borrow, or -1 for true
-           and 0 for false.  So we must mask to 1 bit afterward.  */
+        /*
+         * As above, but we're looking for borrow, or !carry.
+         * The second insn computes d - d - borrow, or -1 for true
+         * and 0 for false.  So we must mask to 1 bit afterward.
+         */
         tgen_cmp(s, type, cond, c1, c2, c2const, true);
         tcg_out_insn(s, RRE, SLBGR, dest, dest);
-        tgen_andi(s, type, dest, 1);
-        return;
-
-    case TCG_COND_GEU:
-    case TCG_COND_LTU:
-    case TCG_COND_LT:
-    case TCG_COND_GE:
-        /* Swap operands so that we can use LEU/GTU/GT/LE.  */
-        if (!c2const) {
-            TCGReg t = c1;
-            c1 = c2;
-            c2 = t;
-            cond = tcg_swap_cond(cond);
-            goto restart;
+        if (!neg) {
+            tgen_andi(s, type, dest, 1);
         }
-        break;
+        return;
 
     default:
         g_assert_not_reached();
@@ -1339,7 +1355,7 @@ static void tgen_setcond(TCGContext *s, TCGType type, TCGCond cond,
     cc = tgen_cmp(s, type, cond, c1, c2, c2const, false);
     /* Emit: d = 0, t = 1, d = (cc ? t : d).  */
     tcg_out_movi(s, TCG_TYPE_I64, dest, 0);
-    tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, 1);
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, neg ? -1 : 1);
     tcg_out_insn(s, RRFc, LOCGR, dest, TCG_TMP0, cc);
 }
 
@@ -2288,7 +2304,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_setcond_i32:
         tgen_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1],
-                     args[2], const_args[2]);
+                     args[2], const_args[2], false);
+        break;
+    case INDEX_op_negsetcond_i32:
+        tgen_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1],
+                     args[2], const_args[2], true);
         break;
     case INDEX_op_movcond_i32:
         tgen_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1],
@@ -2566,7 +2586,11 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
     case INDEX_op_setcond_i64:
         tgen_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1],
-                     args[2], const_args[2]);
+                     args[2], const_args[2], false);
+        break;
+    case INDEX_op_negsetcond_i64:
+        tgen_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1],
+                     args[2], const_args[2], true);
         break;
     case INDEX_op_movcond_i64:
         tgen_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1],
@@ -3109,8 +3133,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
     case INDEX_op_setcond_i32:
+    case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rA);
 
     case INDEX_op_clz_i64:
-- 
2.34.1


