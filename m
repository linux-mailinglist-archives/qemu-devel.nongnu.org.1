Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63876781553
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:17:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7j2-00052G-BN; Fri, 18 Aug 2023 18:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iz-000507-Hc
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7ix-0004P6-0s
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so9953495ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396822; x=1693001622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+7UWgzsWF6oIigmZN6oYCFNc/72L+NSRTM3l7tzwp5s=;
 b=G+W/b9eC0TcsD5dN4jbTG6/N6IpCjZpcJR0SBRiaXevdRkNEJaLylkCdHKB96nAi3t
 U7DBGQec26VwTvdUN5mWZOazsNRLMg0PtSeQtmBECKTWxNHDQ4GZ3wj8EGXU7uFTQNEN
 UFpsJAmbJQqWYt8SzXzPoKG4joJ/HFl2MO/UOlatD1om+5RJwA0QPee9Vogk51auMFWY
 2mXGof6GSZQgCj258wLi35ikb+UhAcO1zgvWisodqaPag9t4tgWdT4NLV3B3t44ImtDq
 1iGEfP0FeUW4uLbh/Y2mE8IwtVFX0zKKh3UK/ASHa6XMJJRxp/Lqjcu8Nzry9gNiRtJI
 sXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396822; x=1693001622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+7UWgzsWF6oIigmZN6oYCFNc/72L+NSRTM3l7tzwp5s=;
 b=ML+YuFCy2gkWrDr92VK6A6gS9IZtPWMZQ+9kJCFeinYm3d1LB7EQv2JTv8u9QNtEIF
 vOzpnAiauDxN/7c/PJNrEkWX8MANb4AYNBHgrat23K0KoYdwj9b8R0ZotaYMQdTnVihD
 GqEL5oRDf5TVITBGA7yETR0M80JRkD4xGeEtIIcA0ADjCd6ANW/assjUHdfJ5ffr4VIS
 XtrmRn2JmKh/KGbB2EcVO5suFjhK0nfbRX6q6wof3pqVICEN4EVBrMQ22g4TWAFpitqk
 DH6G4d2GA9WS9+1jX3E+a5WlxOXfHBkp1pY6FLVPlAI0GcZ52TW6wCyMT5oO2xcoEYcf
 1qlQ==
X-Gm-Message-State: AOJu0YylSMhhgrVwl74oA0BJ6aaOsn+CA/Kxw4zcDCCc75PpX2pZS9+O
 W0DIYMGZjvgs0rz+dg18zMTiq2gSL7M9/Qz8pas=
X-Google-Smtp-Source: AGHT+IHxu62M8nDAd13eXyiH9qvRVWImEi5YkwII3YHX+oOas70WadAKZ3mdelpv9QcrC5TUx/8XJw==
X-Received: by 2002:a17:902:ecc2:b0:1bb:b2f7:e075 with SMTP id
 a2-20020a170902ecc200b001bbb2f7e075mr738676plh.7.1692396821788; 
 Fri, 18 Aug 2023 15:13:41 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
	qemu-s390x@nongnu.org
Subject: [PATCH v2 15/23] tcg/s390x: Implement negsetcond_*
Date: Fri, 18 Aug 2023 15:13:19 -0700
Message-Id: <20230818221327.150194-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
Cc: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org
---
 tcg/s390x/tcg-target.h     |  4 +-
 tcg/s390x/tcg-target.c.inc | 78 +++++++++++++++++++++++++-------------
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 24e207c2d4..cd3d245be0 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -104,7 +104,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_mulsh_i32      0
 #define TCG_TARGET_HAS_extrl_i64_i32  0
 #define TCG_TARGET_HAS_extrh_i64_i32  0
-#define TCG_TARGET_HAS_negsetcond_i32 0
+#define TCG_TARGET_HAS_negsetcond_i32 1
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
 #define TCG_TARGET_HAS_div2_i64       1
@@ -139,7 +139,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
 #define TCG_TARGET_HAS_muluh_i64      0
 #define TCG_TARGET_HAS_mulsh_i64      0
-#define TCG_TARGET_HAS_negsetcond_i64 0
+#define TCG_TARGET_HAS_negsetcond_i64 1
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
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


