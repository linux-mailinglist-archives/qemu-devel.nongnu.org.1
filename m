Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC6682A43C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLc-0000vW-Az; Wed, 10 Jan 2024 17:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLW-0000AV-KC
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:50 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLU-0003hh-EI
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:50 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-429b459aa98so6554541cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926807; x=1705531607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjHxyGR5DOw/0X5t4FNhTcg/ySO1/KXOrl0SiEd+H80=;
 b=uN2yJ0HUHf20YQWuDeorXQ3cLD+QoXJIutHjV4OC73piITEyhGUdfmzmLi7daRh7em
 ypjyHfYJMsgU1n159WrprxU/pCDlxpAZ3GCRt/EV/LJYKxoebmQDJWRaWe8hQp3Co+mO
 pTVqGqBRaqa6aEzQyTVbx+oZQenw697Z3D0sgEDsNOOHLZS6fVya/055rlV8eslVA6RV
 1MD9WfUYdUGayc/N6aKuduoBKbxaaMqlg/R5Dz2C38wS0cBRllzB96M+8iqwvNDa1IJk
 9UOspOF+yoNwsMfdXHJd+jLtud+AFjvIL5jTxYGP2+klW5Lhe2UYZBlDUiPFaq0IKWkX
 /ADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926807; x=1705531607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjHxyGR5DOw/0X5t4FNhTcg/ySO1/KXOrl0SiEd+H80=;
 b=MnGANKZidv2hZ1MO3H1qskD65dHENIGQWwIPFjfmgIDx0JMSv2+WG+bsXV/2xtFkdC
 5S6v0r8XqN4zwplGN16kwD9a931T33GECAszDtIsN5fmHqDmH1mQfltF5Ly/yI83uZEP
 crzGVqONAUORr9ps6tCP9+xJJ+Ocf/Exsq/e0+Zj8fdBZoDwYyHNWVCjau5hfQAq6lg2
 yR9b8gi9l8TFrdxicMAH3RYwWOQ8chXeFEkZIqruFK1Egri0cc4Q7jnzEBhSvjOhOXO7
 E5oHOy5mrbyaO7AV1McULnY4lpjSgLFF5msKLzJR2gju9JvADtAmbP3g/qvxRnzzft6c
 o6dw==
X-Gm-Message-State: AOJu0Yz1HWSPoVsGYarThzUWgGkDNOFLAM6xdqrMGQ4lnC5SBcAaeJXB
 2aHI/lrvKF2gBfBzDdBrKJePm72xOq9Z2N7CcjD3nyF5xiLSwT4A
X-Google-Smtp-Source: AGHT+IEmnXJnQF0SrqK3pdkCt1V1JUh2FdmwBD6ZNIlARSIwPsNx5fjB1TBPTI+VAElsii0jfEkwjg==
X-Received: by 2002:a05:622a:294:b0:429:99d9:213a with SMTP id
 z20-20020a05622a029400b0042999d9213amr324133qtw.17.1704926807465; 
 Wed, 10 Jan 2024 14:46:47 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 33/38] tcg/ppc: Add TCG_CT_CONST_CMP
Date: Thu, 11 Jan 2024 09:44:03 +1100
Message-Id: <20240110224408.10444-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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
index cb47b29452..9f99bde505 100644
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
 C_N1O1_I1(o, m, r)
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
index 26e0bc31d7..535ef2cbe7 100644
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
@@ -3991,8 +4022,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_negsetcond_i32:
     case INDEX_op_and_i64:
     case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
@@ -4000,8 +4029,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
-    case INDEX_op_setcond_i64:
-    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_mul_i32:
@@ -4045,11 +4072,16 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
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


