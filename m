Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF48A8A8B6
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 22:00:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m8Y-0002vx-PU; Tue, 15 Apr 2025 15:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1O-0003Dm-T1
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:32:39 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1F-0002g6-Bx
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:32:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-227b650504fso59380875ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745546; x=1745350346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gRBrJuNxGT72R3GDEOrTvwBOdkJ33f0r4LUontC4w0I=;
 b=gxebTuyUCQbniVXK8eZBxWlxIjeRq7xR2CoK3/hUvxHv40QN8bnUnNRBa7V5F6NfdB
 81dcLkxEBzPz3v2J1JEPbXX1LrvPpRFkAO7asrqTF8uKZBuK/hgvOLSZeLlkj0tenZSZ
 4nPvCG8qUEQuzc3GDIZ1auoYr4pBeURs4I3W6jgGiebRXeMzu2RGrLiOZ44JAbaZdS+H
 5sIR68mNh1M5OZPwonatJW9rOUUhd5y59fOrd29YLoQu3mYqCKoRmdjffTNuooyU7Phm
 jmk3+9WFWv9xq4TTB9Oc02vArR4lMw1M/EIkPxhad5gLvIw5Kfc5OUe/LXLBpB8JqSk1
 uy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745546; x=1745350346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRBrJuNxGT72R3GDEOrTvwBOdkJ33f0r4LUontC4w0I=;
 b=CqITwSTWf5aAer2b80XaMCJuE35ZtOIHxshwfWyjdmWXuGr0e2/PfGBT2DQJ1z0QgH
 LZE9kk8CI8YckuWTNxmvGA82DJj2NTp8KItCqXFA1sZg+ez8jhJ7HLkHqVZp777IZcFq
 iOUryD5oA3i856QKLeLRA6WwjAGPNuYI4Ns+J/NQVl0RLQHKbZqzN0KbaJXrQmv0yNbd
 BTVtVgCeDpm/YG7ae2KddR+esHCNCj3NiNkqrYB3RcOqmqjWE4uN7PB6jcAuP7GHVNor
 2hx4+RkHBNJlfWGTUHLetd/WCxdaLeloGga6Nwnl9I/EMnipP2X0zQg2sznooUhtyxlV
 EDrw==
X-Gm-Message-State: AOJu0YyJ89+4IEhAkYNd7upUZ5icRuI/I5rqOeHRq0PSawDMAT01Tr30
 hBBUgh+Qil5uOas982oC8myoqz5r1HpiI04NclA3b+qDigg/IXa744RBS2d30ODU3RD00Tnu+/m
 K
X-Gm-Gg: ASbGnctUj2CVMZdtaHig4Lnxv6r2dvFdFnhJGtZ8IjdVQq7sRyGhz+Ze3ZfL2kiIVM8
 mPgfXEqeSntkN4ggFchLqBPk79jkA5c2dAIl7RCZqeLcNeifaxo1/vA6W94ZapVI+PDu0lCSLQh
 ZJFMAL78GuNrkwCXaaUTRoevZEqBJZXKwgar6EF3hQMdzr6XMWkOv14+fPxqW6SVlqmf2J/U2Mb
 xCzEOCLPkwrn13RFizt7BXdcSU1smjokrBB9ujG3khiWaMyidYRbVgRZnOoesIocppiX9DuDs8o
 S01G+TwKS6h0rcL4E7EpC0kRc2zIugud4Y+wkqVWwM0zSST6Ru5bCv0Q3PkoHXx5jPz09ueao34
 =
X-Google-Smtp-Source: AGHT+IFBaJabhEdgL5NB/7lNnJPASGQikJmxiDxXGLQfwjHhgyTK2tICGFHaHq+JHkhnY1W8KiQ9vw==
X-Received: by 2002:a17:902:d492:b0:223:54e5:bf4b with SMTP id
 d9443c01a7336-22c31a4a223mr4893865ad.25.1744745546346; 
 Tue, 15 Apr 2025 12:32:26 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 082/163] tcg/ppc: Drop fallback constant loading in
 tcg_out_cmp
Date: Tue, 15 Apr 2025 12:23:53 -0700
Message-ID: <20250415192515.232910-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Use U and C constraints for brcond2 and setcond2, so that
tcg_out_cmp2 automatically passes in-range constants
to tcg_out_cmp.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  4 +--
 tcg/ppc/tcg-target.c.inc     | 49 ++++++++++++------------------------
 2 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 77a1038d51..14cd217287 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -15,7 +15,7 @@ C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(r, r, r)
 C_O0_I3(o, m, r)
-C_O0_I4(r, r, ri, ri)
+C_O0_I4(r, r, rU, rC)
 C_O0_I4(r, r, r, r)
 C_O1_I1(r, r)
 C_O1_I1(v, r)
@@ -34,7 +34,7 @@ C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(v, v, v, vZM, v)
 C_O1_I4(r, r, rC, rZ, rZ)
-C_O1_I4(r, r, r, ri, ri)
+C_O1_I4(r, r, r, rU, rC)
 C_O2_I1(r, r, r)
 C_N1O1_I1(o, m, r)
 C_O2_I2(r, r, r, r)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 339b3a0904..1782d05290 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1777,9 +1777,8 @@ static void tcg_out_test(TCGContext *s, TCGReg dest, TCGReg arg1, TCGArg arg2,
 }
 
 static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
-                        int const_arg2, int cr, TCGType type)
+                        bool const_arg2, int cr, TCGType type)
 {
-    int imm;
     uint32_t op;
 
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
@@ -1796,18 +1795,15 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
     case TCG_COND_EQ:
     case TCG_COND_NE:
         if (const_arg2) {
-            if ((int16_t) arg2 == arg2) {
+            if ((int16_t)arg2 == arg2) {
                 op = CMPI;
-                imm = 1;
-                break;
-            } else if ((uint16_t) arg2 == arg2) {
-                op = CMPLI;
-                imm = 1;
                 break;
             }
+            tcg_debug_assert((uint16_t)arg2 == arg2);
+            op = CMPLI;
+            break;
         }
         op = CMPL;
-        imm = 0;
         break;
 
     case TCG_COND_TSTEQ:
@@ -1821,14 +1817,11 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
     case TCG_COND_LE:
     case TCG_COND_GT:
         if (const_arg2) {
-            if ((int16_t) arg2 == arg2) {
-                op = CMPI;
-                imm = 1;
-                break;
-            }
+            tcg_debug_assert((int16_t)arg2 == arg2);
+            op = CMPI;
+            break;
         }
         op = CMP;
-        imm = 0;
         break;
 
     case TCG_COND_LTU:
@@ -1836,30 +1829,20 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
     case TCG_COND_LEU:
     case TCG_COND_GTU:
         if (const_arg2) {
-            if ((uint16_t) arg2 == arg2) {
-                op = CMPLI;
-                imm = 1;
-                break;
-            }
+            tcg_debug_assert((uint16_t)arg2 == arg2);
+            op = CMPLI;
+            break;
         }
         op = CMPL;
-        imm = 0;
         break;
 
     default:
         g_assert_not_reached();
     }
     op |= BF(cr) | ((type == TCG_TYPE_I64) << 21);
-
-    if (imm) {
-        tcg_out32(s, op | RA(arg1) | (arg2 & 0xffff));
-    } else {
-        if (const_arg2) {
-            tcg_out_movi(s, type, TCG_REG_R0, arg2);
-            arg2 = TCG_REG_R0;
-        }
-        tcg_out32(s, op | RA(arg1) | RB(arg2));
-    }
+    op |= RA(arg1);
+    op |= const_arg2 ? arg2 & 0xffff : RB(arg2);
+    tcg_out32(s, op);
 }
 
 static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
@@ -4297,9 +4280,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_brcond2_i32:
-        return C_O0_I4(r, r, ri, ri);
+        return C_O0_I4(r, r, rU, rC);
     case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, r, r, ri, ri);
+        return C_O1_I4(r, r, r, rU, rC);
     case INDEX_op_add2_i64:
     case INDEX_op_add2_i32:
         return C_O2_I4(r, r, r, r, rI, rZM);
-- 
2.43.0


