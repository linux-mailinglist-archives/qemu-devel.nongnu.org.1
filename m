Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F32B7DDBD8
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:15:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2a4-0005wK-VI; Wed, 01 Nov 2023 00:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zz-0005ub-GV
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:43 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zx-0007WM-Fb
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:43 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b2e22a4004so4334537b6e.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811900; x=1699416700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kT8CWMgw4vZpAZbw34J5pEYMvqKkkdXhPN2igbpIoI=;
 b=NRdzKW+y27fouRepXemL9uPJSKNnNQzPTNI2mP+qf8+WJ7vePGuLO5nMjOtG/5Q5jF
 iRgL7ba1NvpfFl8+YPrmcOaZdlsCJqL+vXZfk6SY6USPv/aa13O3Rw+alVcR3UrxU3um
 Kyu5T6/PPF4GiTxIxD5Do8yrBFvGeXUkh2dPTz60gVc5cWNhp8I4WYf9Fqai4xOJf4R5
 afpTGpPBuu0PwU8BWMKx/0psgZ1Y3Sj9LtUWPuzTq5RgsibFWAIZCGrCNPP1/G3QX9Am
 76gXlZoUpEioR0HAzj2jbVy75jKjUV4xu0Lgx3eZunuWjTJa8hYGF0FBfl6QuO64kMGG
 /mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811900; x=1699416700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kT8CWMgw4vZpAZbw34J5pEYMvqKkkdXhPN2igbpIoI=;
 b=fPq2qWF50JFxzixAZs0F7Wp3OSwWrepFY8+bYPM7eVB0kVQ6Vd1frougdvOLPsjC0s
 IlLMXJWHCtTJN1eIkJGSGVm+NkjMq6jTwN6h4RC9aTlaFFcZcYU/GaZE8YwUDaN5dWt1
 tKaWImisLxNm7d+7wqpMTQR8QD3VnC53A0rvQWeWpGVTbFN5YLw0vJo9qISNm2tbpNOd
 VBe/PyP9FXIzkDPjhN2gohqZn7czy22f+JDdAzQP8mNi2W9XF+UhFlLoWTjSugXy5GU8
 2+iKUR8Ie11JXWsiq2VG2rym2xgO+94RNzp5/nbeh4RRhg+GTpGfhXWMUWugavSt+T59
 qfbQ==
X-Gm-Message-State: AOJu0Yz2WZIdxX4KIwK9OsIBWcaY8nYephMmKDhqCe51JPtUrGZ3ZfbU
 lWOK/SsvTM13VYaRDUI9QSt0qSfiyAkm3neEzoQ=
X-Google-Smtp-Source: AGHT+IF+tY8qwleLaMW8G65Q90e/kNkdohPCX8ZyQrftKLQVdH/veCZwxxfSWLGWGXbNOxlraGEy7g==
X-Received: by 2002:a05:6808:8db:b0:3ae:5e0e:1669 with SMTP id
 k27-20020a05680808db00b003ae5e0e1669mr15510899oij.42.1698811900407; 
 Tue, 31 Oct 2023 21:11:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 07/21] target/sparc: Remove CC_OP_TADDTV, CC_OP_TSUBTV
Date: Tue, 31 Oct 2023 21:11:18 -0700
Message-Id: <20231101041132.174501-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |   2 -
 target/sparc/cc_helper.c | 190 +--------------------------------------
 target/sparc/helper.c    |  36 ++++++--
 target/sparc/translate.c |   4 +-
 4 files changed, 32 insertions(+), 200 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9884bd416a..a7999eaab5 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -150,8 +150,6 @@ enum {
 enum {
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_FLAGS,   /* all cc are back in cc_*_[NZCV] registers */
-    CC_OP_TADDTV,  /* modify all flags except V, CC_DST = res, CC_SRC = src1 */
-    CC_OP_TSUBTV,  /* modify all flags except V, CC_DST = res, CC_SRC = src1 */
     CC_OP_NB,
 };
 
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index 20d451aa65..05f1479aea 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -21,198 +21,12 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 
-static inline uint32_t get_NZ_icc(int32_t dst)
-{
-    uint32_t ret = 0;
-
-    if (dst == 0) {
-        ret = PSR_ZERO;
-    } else if (dst < 0) {
-        ret = PSR_NEG;
-    }
-    return ret;
-}
-
-#ifdef TARGET_SPARC64
-static inline uint32_t get_NZ_xcc(target_long dst)
-{
-    uint32_t ret = 0;
-
-    if (!dst) {
-        ret = PSR_ZERO;
-    } else if (dst < 0) {
-        ret = PSR_NEG;
-    }
-    return ret;
-}
-#endif
-
-static inline uint32_t get_C_add_icc(uint32_t dst, uint32_t src1)
-{
-    uint32_t ret = 0;
-
-    if (dst < src1) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-#ifdef TARGET_SPARC64
-static inline uint32_t get_C_add_xcc(target_ulong dst, target_ulong src1)
-{
-    uint32_t ret = 0;
-
-    if (dst < src1) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-static inline uint32_t get_V_add_xcc(target_ulong dst, target_ulong src1,
-                                     target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 ^ src2 ^ -1) & (src1 ^ dst)) & (1ULL << 63)) {
-        ret = PSR_OVF;
-    }
-    return ret;
-}
-
-static uint32_t compute_all_add_xcc(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_xcc(CC_DST);
-    ret |= get_C_add_xcc(CC_DST, CC_SRC);
-    ret |= get_V_add_xcc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
-static uint32_t compute_C_add_xcc(CPUSPARCState *env)
-{
-    return get_C_add_xcc(CC_DST, CC_SRC);
-}
-#endif
-
-static uint32_t compute_C_add(CPUSPARCState *env)
-{
-    return get_C_add_icc(CC_DST, CC_SRC);
-}
-
-static uint32_t compute_all_taddtv(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_add_icc(CC_DST, CC_SRC);
-    return ret;
-}
-
-static inline uint32_t get_C_sub_icc(uint32_t src1, uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (src1 < src2) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-#ifdef TARGET_SPARC64
-static inline uint32_t get_C_sub_xcc(target_ulong src1, target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (src1 < src2) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-static inline uint32_t get_V_sub_xcc(target_ulong dst, target_ulong src1,
-                                     target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 ^ src2) & (src1 ^ dst)) & (1ULL << 63)) {
-        ret = PSR_OVF;
-    }
-    return ret;
-}
-
-static uint32_t compute_all_sub_xcc(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_xcc(CC_DST);
-    ret |= get_C_sub_xcc(CC_SRC, CC_SRC2);
-    ret |= get_V_sub_xcc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
-static uint32_t compute_C_sub_xcc(CPUSPARCState *env)
-{
-    return get_C_sub_xcc(CC_SRC, CC_SRC2);
-}
-#endif
-
-static uint32_t compute_C_sub(CPUSPARCState *env)
-{
-    return get_C_sub_icc(CC_SRC, CC_SRC2);
-}
-
-static uint32_t compute_all_tsubtv(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_sub_icc(CC_SRC, CC_SRC2);
-    return ret;
-}
-
-typedef struct CCTable {
-    uint32_t (*compute_all)(CPUSPARCState *env); /* return all the flags */
-    uint32_t (*compute_c)(CPUSPARCState *env);  /* return the C flag */
-} CCTable;
-
-static const CCTable icc_table[CC_OP_NB] = {
-    /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_TADDTV] = { compute_all_taddtv, compute_C_add },
-    [CC_OP_TSUBTV] = { compute_all_tsubtv, compute_C_sub },
-};
-
-#ifdef TARGET_SPARC64
-static const CCTable xcc_table[CC_OP_NB] = {
-    /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_TADDTV] = { compute_all_add_xcc, compute_C_add_xcc },
-    [CC_OP_TSUBTV] = { compute_all_sub_xcc, compute_C_sub_xcc },
-};
-#endif
-
 void helper_compute_psr(CPUSPARCState *env)
 {
     if (CC_OP == CC_OP_FLAGS) {
         return;
     }
-
-    uint32_t icc = icc_table[CC_OP].compute_all(env);
-#ifdef TARGET_SPARC64
-    uint32_t xcc = xcc_table[CC_OP].compute_all(env);
-
-    env->cc_N = deposit64(-(icc & PSR_NEG), 32, 32, -(xcc & PSR_NEG));
-    env->cc_V = deposit64(-(icc & PSR_OVF), 32, 32, -(xcc & PSR_OVF));
-    env->icc_C = (uint64_t)icc << (32 - PSR_CARRY_SHIFT);
-    env->xcc_C = (xcc >> PSR_CARRY_SHIFT) & 1;
-    env->xcc_Z = ~xcc & PSR_ZERO;
-#else
-    env->cc_N = -(icc & PSR_NEG);
-    env->cc_V = -(icc & PSR_OVF);
-    env->icc_C = (icc >> PSR_CARRY_SHIFT) & 1;
-#endif
-    env->icc_Z = ~icc & PSR_ZERO;
-
-    CC_OP = CC_OP_FLAGS;
+    g_assert_not_reached();
 }
 
 uint32_t helper_compute_C_icc(CPUSPARCState *env)
@@ -224,5 +38,5 @@ uint32_t helper_compute_C_icc(CPUSPARCState *env)
         return env->icc_C;
 #endif
     }
-    return icc_table[CC_OP].compute_c(env) >> PSR_CARRY_SHIFT;
+    g_assert_not_reached();
 }
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 53eec693dd..6117e99b55 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -156,7 +156,7 @@ uint64_t helper_udivx(CPUSPARCState *env, uint64_t a, uint64_t b)
 target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
-    target_ulong dst;
+    target_ulong dst, v;
 
     /* Tag overflow occurs if either input has bits 0 or 1 set.  */
     if ((src1 | src2) & 3) {
@@ -166,13 +166,23 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
     dst = src1 + src2;
 
     /* Tag overflow occurs if the addition overflows.  */
-    if (~(src1 ^ src2) & (src1 ^ dst) & (1u << 31)) {
+    v = ~(src1 ^ src2) & (src1 ^ dst);
+    if (v & (1u << 31)) {
         goto tag_overflow;
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_src = src1;
-    env->cc_src2 = src2;
+    env->cc_V = v;
+    env->cc_N = dst;
+    env->icc_Z = dst;
+#ifdef TARGET_SPARC64
+    env->xcc_Z = dst;
+    env->icc_C = dst ^ src1 ^ src2;
+    env->xcc_C = dst < src1;
+#else
+    env->icc_C = dst < src1;
+#endif
+
     return dst;
 
  tag_overflow:
@@ -182,7 +192,7 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
 target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
-    target_ulong dst;
+    target_ulong dst, v;
 
     /* Tag overflow occurs if either input has bits 0 or 1 set.  */
     if ((src1 | src2) & 3) {
@@ -192,13 +202,23 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
     dst = src1 - src2;
 
     /* Tag overflow occurs if the subtraction overflows.  */
-    if ((src1 ^ src2) & (src1 ^ dst) & (1u << 31)) {
+    v = (src1 ^ src2) & (src1 ^ dst);
+    if (v & (1u << 31)) {
         goto tag_overflow;
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_src = src1;
-    env->cc_src2 = src2;
+    env->cc_V = v;
+    env->cc_N = dst;
+    env->icc_Z = dst;
+#ifdef TARGET_SPARC64
+    env->xcc_Z = dst;
+    env->icc_C = dst ^ src1 ^ src2;
+    env->xcc_C = src1 < src2;
+#else
+    env->icc_C = src1 < src2;
+#endif
+
     return dst;
 
  tag_overflow:
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d119ce4c94..7703166ebd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3598,8 +3598,8 @@ TRANS(SUB, ALL, do_arith, a, CC_OP_FLAGS,
 
 TRANS(TADDcc, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_taddcc)
 TRANS(TSUBcc, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_tsubcc)
-TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, NULL, NULL, gen_op_taddcctv)
-TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, NULL, NULL, gen_op_tsubcctv)
+TRANS(TADDccTV, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_taddcctv)
+TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_tsubcctv)
 
 TRANS(AND, ALL, do_logic, a, tcg_gen_and_tl, tcg_gen_andi_tl)
 TRANS(XOR, ALL, do_logic, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
-- 
2.34.1


