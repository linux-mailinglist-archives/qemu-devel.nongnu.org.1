Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2847DA91F
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFx-0004r9-Jm; Sat, 28 Oct 2023 15:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFm-0004lO-8T
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFk-0004A3-K7
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc20df5187so11929755ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522347; x=1699127147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BOiaD60Pop9BL/fjcx346e3KqYhFz6lBjdoxHSd51pk=;
 b=t+oVARTRUKyOzmwYYoMobKrEO2nEYvLYuj2FW7KDDv+1j1AW03rNnVBym5Nqp7CFcT
 R7mMOkikcpHDtenGXnIKYkGiraTGtVKMZMDyRcFWuo9yqcFFBAWnxLPGLvMiFMl3vku6
 Z+OYn9RatKLptI8fZY3of/z+t+GHrnDz7SGTkG2Ke8YO7lHzrQUS5xCZ6HqpY+r/faRy
 uGo70HwThEmrSMzNaS+rprUElPh6Et7/DZrNkh/OVpJL9ZGisUV1qAZSymjdMfscLaFT
 QecV1cDakn+3M/3ACao/7ry5MtbH9LaaY1muRgDR1s67lKNqi3euXN9qSDPaWFcMIm2O
 nQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522347; x=1699127147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BOiaD60Pop9BL/fjcx346e3KqYhFz6lBjdoxHSd51pk=;
 b=iNoOYJIxtcc3c5jn14gHaA7SVJ43lOlqSerkJD6Sen9DsuDLOdl29BkRpYYn/iRa0J
 es/meUg0L2UdpRknOgfXjouGiEO6liHx+qsU50vNeg0zoQ/f1k1vT0S9hbRbUeedy3Jo
 /9RvNEmNMW+XK/Z/SjNHoK4UHp9n8mtCGmID7BbjrHuMVMy8Unn3evuv3Ak9RMqjqgI/
 6GkecAy+NtqRSfJUQ10MNLVDIzkawuUvNpzXg/eLYRr8mXdZhDNrJ3fBoGYW/GeMJINq
 QmEjwl9YY/PwtJYwH4UxVk563AeKYwWwQGOZXnIuDl21ebh65CogV1rl96nDlGx2mFBq
 czxg==
X-Gm-Message-State: AOJu0Yw1RPQYB8/UP1YdQ1kArgfGINblfab7aoMvqnf6H1v1y8d8DYCS
 FL20Oq2Ue7wUZ7z5sCojgz+TKYEKBm3gv5Tsujg=
X-Google-Smtp-Source: AGHT+IHhVGlk7Q5HNc48ESxg0LAZ9VLmi1SGTuZo9qZlWxPJJyarXiOf/PydMQjiCudikLFWmAz+gw==
X-Received: by 2002:a17:902:c949:b0:1bd:e258:a256 with SMTP id
 i9-20020a170902c94900b001bde258a256mr7554840pla.32.1698522347444; 
 Sat, 28 Oct 2023 12:45:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 26/35] tcg/ppc: Add TCG_CT_CONST_CMP
Date: Sat, 28 Oct 2023 12:45:13 -0700
Message-Id: <20231028194522.245170-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Better constraint for tcg_out_cmp, based on the comparison.
We can't yet remove the fallback to load constants into a
scratch because of tcg_out_cmp2, but that path should not
be as frequent.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  5 ++--
 tcg/ppc/tcg-target-con-str.h |  1 +
 tcg/ppc/tcg-target.c.inc     | 48 ++++++++++++++++++++++++++++++------
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index bbd7b21247..aa1dac8740 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -11,7 +11,7 @@
  */
 C_O0_I1(r)
 C_O0_I2(r, r)
-C_O0_I2(r, ri)
+C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(r, r, r)
 C_O0_I3(o, m, r)
@@ -26,13 +26,14 @@ C_O1_I2(r, rI, ri)
 C_O1_I2(r, rI, rT)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
+C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rT)
 C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rZW)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
-C_O1_I4(r, r, ri, rZ, rZ)
+C_O1_I4(r, r, rC, rZ, rZ)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, r)
 C_O2_I1(o, m, r)
diff --git a/tcg/ppc/tcg-target-con-str.h b/tcg/ppc/tcg-target-con-str.h
index 20846901de..16b687216e 100644
--- a/tcg/ppc/tcg-target-con-str.h
+++ b/tcg/ppc/tcg-target-con-str.h
@@ -16,6 +16,7 @@ REGS('v', ALL_VECTOR_REGS)
  * Define constraint letters for constants:
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
+CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('M', TCG_CT_CONST_MONE)
 CONST('T', TCG_CT_CONST_S32)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 13d43ef9ba..b20dbe036d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -92,11 +92,13 @@
 #define SZR  (TCG_TARGET_REG_BITS / 8)
 
 #define TCG_CT_CONST_S16  0x100
+#define TCG_CT_CONST_U16  0x200
 #define TCG_CT_CONST_S32  0x400
 #define TCG_CT_CONST_U32  0x800
 #define TCG_CT_CONST_ZERO 0x1000
 #define TCG_CT_CONST_MONE 0x2000
 #define TCG_CT_CONST_WSZ  0x4000
+#define TCG_CT_CONST_CMP  0x8000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -296,9 +298,35 @@ static bool tcg_target_const_match(int64_t sval, int ct,
         sval = (int32_t)sval;
     }
 
+    if (ct & TCG_CT_CONST_CMP) {
+        switch (cond) {
+        case TCG_COND_EQ:
+        case TCG_COND_NE:
+            ct |= TCG_CT_CONST_S16 | TCG_CT_CONST_U16;
+            break;
+        case TCG_COND_LT:
+        case TCG_COND_GE:
+        case TCG_COND_LE:
+        case TCG_COND_GT:
+            ct |= TCG_CT_CONST_S16;
+            break;
+        case TCG_COND_LTU:
+        case TCG_COND_GEU:
+        case TCG_COND_LEU:
+        case TCG_COND_GTU:
+            ct |= TCG_CT_CONST_U16;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
     if ((ct & TCG_CT_CONST_S16) && sval == (int16_t)sval) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_U16) && uval == (uint16_t)uval) {
+        return 1;
+    }
     if ((ct & TCG_CT_CONST_S32) && sval == (int32_t)sval) {
         return 1;
     }
@@ -1682,7 +1710,10 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
 
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
 
-    /* Simplify the comparisons below wrt CMPI.  */
+    /*
+     * Simplify the comparisons below wrt CMPI.
+     * All of the tests are 16-bit, so a 32-bit sign extend always works.
+     */
     if (type == TCG_TYPE_I32) {
         arg2 = (int32_t)arg2;
     }
@@ -3990,8 +4021,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
     case INDEX_op_and_i64:
     case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
@@ -3999,8 +4028,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_mul_i32:
@@ -4044,11 +4071,16 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, ri);
-
+        return C_O0_I2(r, rC);
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        return C_O1_I2(r, r, rC);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, ri, rZ, rZ);
+        return C_O1_I4(r, r, rC, rZ, rZ);
+
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rZ);
-- 
2.34.1


