Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A72F7DA916
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:49:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG2-0004v3-1I; Sat, 28 Oct 2023 15:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFq-0004nD-8N
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:55 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFo-0004Af-EX
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:53 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5844bc378feso1940477eaf.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522350; x=1699127150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJQydxS3NvJxT4eWGTovhRM0Zt2nynj/3g50i7a6gMo=;
 b=mFNBNOXMAh+Wn6VvpM+Rv0PcW1DTxiqEV1eWTj4EtonXaHF6lcliusQ4TXWoTvxKow
 FH8AcBLOz9JG1US9XANAwRJayD7iq336J2MlP5OIhweOL7f3pH170KLzCclQDT0sd5Ym
 Lxi00seayruYKsCuf3dZwcrsJVEjpvFfmU/GrN9IJr5nNZ/9E2AXAisPkGNSG6L01Md0
 /cF4Or5VBUvvnwPr3n0X7FLzX0wZVsovR8wVKwBFHTiOUm3pr2sakWEdC2cG9gvnfgUV
 YChMaOEafTN5VQ17M8ULe6aYSKcxTkdXgRzceEAEFXn0cKtYBHQek7tITUfcKkoz7HEk
 W6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522350; x=1699127150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJQydxS3NvJxT4eWGTovhRM0Zt2nynj/3g50i7a6gMo=;
 b=vHK3N1D4e6+IVPJdbkrJcb3HkhIuWok/ILB0yNK6B/DcaLsGQuroz6F+z6LBSLtxg8
 NCyzp1IzFPKLuSzOyRxs7UKl7lPhTnblkg/K73nX23/ZSoTUhuPwFaEPT+UyZNqCZ5bU
 Tg6ATJSpmr92UxbPp2VBJGwX4RWJ6TsN+GKuluGd1G7UiDTUgUNoQngFGIL9BiaKc2pN
 nAGpmT2+BpV9HmblXD0fqP2KQc5XdpgCj0QqM0DKxnRucSLNWOVKXCT/UMU2Jbs+rbDH
 yefxQWDCtJ9QZpPZd4TfrqVkQSc8bg0DRD6OgLeF5n4VqdkwiKGGETeJ5o+a0oD+pZQr
 r9LA==
X-Gm-Message-State: AOJu0Ywdu/lrW6zyTwtVLZCNE6bPuVjCchuV9zGj2ufiJdHtFeR7wAXA
 no3nuQJyeiDuIbjEMpf+HhZyFohf46XuD0VbaiQ=
X-Google-Smtp-Source: AGHT+IGhAotzGMY+VRC6abxq3Ld6MMvpLTyZrs4CGsGxrOU1clvIid8Nk47324BpajK4ozeZ46T70Q==
X-Received: by 2002:a05:6358:7e08:b0:169:5ad5:8c42 with SMTP id
 o8-20020a0563587e0800b001695ad58c42mr3490909rwm.19.1698522350278; 
 Sat, 28 Oct 2023 12:45:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 29/35] tcg/s390x: Add TCG_CT_CONST_CMP
Date: Sat, 28 Oct 2023 12:45:16 -0700
Message-Id: <20231028194522.245170-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target-con-set.h |  6 +--
 tcg/s390x/tcg-target-con-str.h |  1 +
 tcg/s390x/tcg-target.c.inc     | 72 +++++++++++++++++++++++++---------
 3 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/tcg/s390x/tcg-target-con-set.h b/tcg/s390x/tcg-target-con-set.h
index 665851d84a..f75955eaa8 100644
--- a/tcg/s390x/tcg-target-con-set.h
+++ b/tcg/s390x/tcg-target-con-set.h
@@ -15,7 +15,7 @@
 C_O0_I1(r)
 C_O0_I2(r, r)
 C_O0_I2(r, ri)
-C_O0_I2(r, rJU)
+C_O0_I2(r, rC)
 C_O0_I2(v, r)
 C_O0_I3(o, m, r)
 C_O1_I1(r, r)
@@ -27,7 +27,7 @@ C_O1_I2(r, 0, rI)
 C_O1_I2(r, 0, rJ)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
-C_O1_I2(r, r, rJU)
+C_O1_I2(r, r, rC)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rK)
@@ -39,7 +39,7 @@ C_O1_I2(v, v, r)
 C_O1_I2(v, v, v)
 C_O1_I3(v, v, v, v)
 C_O1_I4(r, r, ri, rI, r)
-C_O1_I4(r, r, rJU, rI, r)
+C_O1_I4(r, r, rC, rI, r)
 C_O2_I1(o, m, r)
 C_O2_I2(o, m, 0, r)
 C_O2_I2(o, m, r, r)
diff --git a/tcg/s390x/tcg-target-con-str.h b/tcg/s390x/tcg-target-con-str.h
index 9d2cb775dc..745f6c0df5 100644
--- a/tcg/s390x/tcg-target-con-str.h
+++ b/tcg/s390x/tcg-target-con-str.h
@@ -16,6 +16,7 @@ REGS('o', 0xaaaa) /* odd numbered general regs */
  * Define constraint letters for constants:
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
+CONST('C', TCG_CT_CONST_CMP)
 CONST('I', TCG_CT_CONST_S16)
 CONST('J', TCG_CT_CONST_S32)
 CONST('K', TCG_CT_CONST_P32)
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a317ccd3a5..86ec737768 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -35,6 +35,7 @@
 #define TCG_CT_CONST_P32        (1 << 12)
 #define TCG_CT_CONST_INV        (1 << 13)
 #define TCG_CT_CONST_INVRISBG   (1 << 14)
+#define TCG_CT_CONST_CMP        (1 << 15)
 
 #define ALL_GENERAL_REGS     MAKE_64BIT_MASK(0, 16)
 #define ALL_VECTOR_REGS      MAKE_64BIT_MASK(32, 32)
@@ -548,6 +549,29 @@ static bool tcg_target_const_match(int64_t val, int ct,
         val = (int32_t)val;
     }
 
+    if (ct & TCG_CT_CONST_CMP) {
+        switch (cond) {
+        case TCG_COND_EQ:
+        case TCG_COND_NE:
+            ct |= TCG_CT_CONST_S32 | TCG_CT_CONST_U32;  /* CGFI or CLGFI */
+            break;
+        case TCG_COND_LT:
+        case TCG_COND_GE:
+        case TCG_COND_LE:
+        case TCG_COND_GT:
+            ct |= TCG_CT_CONST_S32;  /* CGFI */
+            break;
+        case TCG_COND_LTU:
+        case TCG_COND_GEU:
+        case TCG_COND_LEU:
+        case TCG_COND_GTU:
+            ct |= TCG_CT_CONST_U32;  /* CLGFI */
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
     if ((ct & TCG_CT_CONST_S32) && val == (int32_t)val) {
         return true;
     }
@@ -1229,22 +1253,34 @@ static int tgen_cmp2(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
             goto exit;
         }
 
-        /*
-         * Constraints are for a signed 33-bit operand, which is a
-         * convenient superset of this signed/unsigned test.
-         */
-        if (c2 == (is_unsigned ? (TCGArg)(uint32_t)c2 : (TCGArg)(int32_t)c2)) {
-            op = (is_unsigned ? RIL_CLGFI : RIL_CGFI);
-            tcg_out_insn_RIL(s, op, r1, c2);
-            goto exit;
+        /* Should match TCG_CT_CONST_CMP. */
+        switch (c) {
+        case TCG_COND_LT:
+        case TCG_COND_GE:
+        case TCG_COND_LE:
+        case TCG_COND_GT:
+            tcg_debug_assert(c2 == (int32_t)c2);
+            op = RIL_CGFI;
+            break;
+        case TCG_COND_EQ:
+        case TCG_COND_NE:
+            if (c2 == (int32_t)c2) {
+                op = RIL_CGFI;
+                break;
+            }
+            /* fall through */
+        case TCG_COND_LTU:
+        case TCG_COND_GEU:
+        case TCG_COND_LEU:
+        case TCG_COND_GTU:
+            tcg_debug_assert(c2 == (uint32_t)c2);
+            op = RIL_CLGFI;
+            break;
+        default:
+            g_assert_not_reached();
         }
-
-        /* Load everything else into a register. */
-        tcg_out_movi(s, TCG_TYPE_I64, TCG_TMP0, c2);
-        c2 = TCG_TMP0;
-    }
-
-    if (type == TCG_TYPE_I32) {
+        tcg_out_insn_RIL(s, op, r1, c2);
+    } else if (type == TCG_TYPE_I32) {
         op = (is_unsigned ? RR_CLR : RR_CR);
         tcg_out_insn_RR(s, op, r1, c2);
     } else {
@@ -3137,7 +3173,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(r, r, ri);
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rJU);
+        return C_O1_I2(r, r, rC);
 
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
@@ -3187,7 +3223,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_brcond_i32:
         return C_O0_I2(r, ri);
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rJU);
+        return C_O0_I2(r, rC);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3240,7 +3276,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_movcond_i32:
         return C_O1_I4(r, r, ri, rI, r);
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rJU, rI, r);
+        return C_O1_I4(r, r, rC, rI, r);
 
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
-- 
2.34.1


