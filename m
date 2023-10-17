Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD4E7CBB8E
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:46:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdlq-0007tx-8x; Tue, 17 Oct 2023 02:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlZ-0007sG-LN
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlW-0001qn-FZ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c77449a6daso42939455ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524876; x=1698129676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0OGT/ljR6h/FKMK8az8Ybfl519ArhwT7zqC2zzRTgE=;
 b=UHEik1I+BlmomG5YP0E2DegfVJOkCf4LTBQPCiLxZygMnAVeb4y/2hu/H/1M4SVQNs
 g5OV8+8URIcioWxAf4WAoV5O1uLWHkuCzx/6PKn+c6CQZ4R5RDUxxWALs1tQjwKMC4PQ
 tMmc1vIctq6GKn+aS4pPO2a2NGuRHDlRkS2ywp3zwgIAQ7mzM0RzhiHs+CJTmQaPe2dO
 vC52w19y1rwl09biV6KopHPhcTnlaevgc2godYLiGAeKBrYUrD2k+FGnu1JocjlzRsFQ
 UKs/rNXtx5wFkd0XvyYJscyLjSPB6Br2TzeWQzvCXmYytFQJ49gW1k4siEacMxS9qVXM
 u/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524876; x=1698129676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h0OGT/ljR6h/FKMK8az8Ybfl519ArhwT7zqC2zzRTgE=;
 b=MtLDcQVifzU4gqPtbgPvoto6Cwg31aQyj8GavwWo6bRK2eiUS9fsIkXPy8T5Q/N3Fl
 5xMkrrkBgrd8H6al4F0/uj1XNPkuYhcPCRakT1VsrFOP3K+c4oD0vCDnURjpDvWMzuse
 eZtDhLULB5yl0zuveSL/23pVLUnEraY+mrsUBX93YOANY9IZZR19b1s6GXodG5220hzP
 ZaxfYWTB1gNxE6cz3ArO/m7A1q7ctuX4ZmsAQKiBbB44lR5KGKfRFAe4IWOql4gsXslG
 yAnE9JiOKDMJCta36t1XleQr8Xk7YSZeAtZ3KGFZLXV0UnUY2fKK/qlkHTEuQ+U6zo1h
 XVag==
X-Gm-Message-State: AOJu0YxbjCm5gq0Bpu7TvoEvIm5VJmrCY7b27lclacLxavCjnLKw8JVh
 LumXjjHlIKJZeIrm2AONCelMaem2ljlbdsvmgZk=
X-Google-Smtp-Source: AGHT+IGSGL5+fU+Y2rbputkaiAqT7ixpb+hcSRNxhES21bGA2S8XuQ7A6ZFSvi7oP9AExiDnmjRdIQ==
X-Received: by 2002:a17:903:11c7:b0:1c3:2532:ac71 with SMTP id
 q7-20020a17090311c700b001c32532ac71mr1727305plh.31.1697524875757; 
 Mon, 16 Oct 2023 23:41:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 07/20] target/sparc: Remove CC_OP_TADDTV, CC_OP_TSUBTV
Date: Mon, 16 Oct 2023 23:40:56 -0700
Message-Id: <20231017064109.681935-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |   2 -
 target/sparc/cc_helper.c | 267 +--------------------------------------
 target/sparc/helper.c    |  40 ++++--
 target/sparc/translate.c |   4 +-
 4 files changed, 32 insertions(+), 281 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 8498bd07db..27f7fed293 100644
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
index d31aa24b5d..cebe03ff51 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -21,275 +21,12 @@
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
-static inline uint32_t get_C_addx_icc(uint32_t dst, uint32_t src1,
-                                      uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 & src2) | (~dst & (src1 | src2))) & (1U << 31)) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-static inline uint32_t get_V_add_icc(uint32_t dst, uint32_t src1,
-                                     uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 ^ src2 ^ -1) & (src1 ^ dst)) & (1U << 31)) {
-        ret = PSR_OVF;
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
-static inline uint32_t get_C_addx_xcc(target_ulong dst, target_ulong src1,
-                                      target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 & src2) | (~dst & (src1 | src2))) & (1ULL << 63)) {
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
-static inline uint32_t get_V_tag_icc(target_ulong src1, target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if ((src1 | src2) & 0x3) {
-        ret = PSR_OVF;
-    }
-    return ret;
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
-static inline uint32_t get_C_subx_icc(uint32_t dst, uint32_t src1,
-                                      uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((~src1 & src2) | (dst & (~src1 | src2))) & (1U << 31)) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-static inline uint32_t get_V_sub_icc(uint32_t dst, uint32_t src1,
-                                     uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 ^ src2) & (src1 ^ dst)) & (1U << 31)) {
-        ret = PSR_OVF;
-    }
-    return ret;
-}
-
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
-static inline uint32_t get_C_subx_xcc(target_ulong dst, target_ulong src1,
-                                      target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (((~src1 & src2) | (dst & (~src1 | src2))) & (1ULL << 63)) {
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
-    env->cc_icc_C = (uint64_t)icc << (32 - PSR_CARRY_SHIFT);
-    env->cc_xcc_C = (xcc >> PSR_CARRY_SHIFT) & 1;
-    env->cc_xcc_Z = ~xcc & PSR_ZERO;
-#else
-    env->cc_N = -(icc & PSR_NEG);
-    env->cc_V = -(icc & PSR_OVF);
-    env->cc_icc_C = (icc >> PSR_CARRY_SHIFT) & 1;
-#endif
-    env->cc_icc_Z = ~icc & PSR_ZERO;
-
-    CC_OP = CC_OP_FLAGS;
+    g_assert_not_reached();
 }
 
 uint32_t helper_compute_C_icc(CPUSPARCState *env)
@@ -301,5 +38,5 @@ uint32_t helper_compute_C_icc(CPUSPARCState *env)
         return env->cc_icc_C;
 #endif
     }
-    return icc_table[CC_OP].compute_c(env) >> PSR_CARRY_SHIFT;
+    g_assert_not_reached();
 }
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 87a4258792..4887f295a5 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -204,7 +204,7 @@ uint64_t helper_udivx(CPUSPARCState *env, uint64_t a, uint64_t b)
 target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
-    target_ulong dst;
+    target_ulong dst, v;
 
     /* Tag overflow occurs if either input has bits 0 or 1 set.  */
     if ((src1 | src2) & 3) {
@@ -214,15 +214,23 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
     dst = src1 + src2;
 
     /* Tag overflow occurs if the addition overflows.  */
-    if (~(src1 ^ src2) & (src1 ^ dst) & (1u << 31)) {
+    v = ~(src1 ^ src2) & (src1 ^ dst);
+    if (v & (1u << 31)) {
         goto tag_overflow;
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TADDTV;
-    env->cc_src = src1;
-    env->cc_src2 = src2;
-    env->cc_dst = dst;
+    env->cc_V = v;
+    env->cc_N = dst;
+    env->cc_icc_Z = dst;
+#ifdef TARGET_SPARC64
+    env->cc_xcc_Z = dst;
+    env->cc_icc_C = dst ^ src1 ^ src2;
+    env->cc_xcc_C = dst < src1;
+#else
+    env->cc_icc_C = dst < src1;
+#endif
+
     return dst;
 
  tag_overflow:
@@ -232,7 +240,7 @@ target_ulong helper_taddcctv(CPUSPARCState *env, target_ulong src1,
 target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
                              target_ulong src2)
 {
-    target_ulong dst;
+    target_ulong dst, v;
 
     /* Tag overflow occurs if either input has bits 0 or 1 set.  */
     if ((src1 | src2) & 3) {
@@ -242,15 +250,23 @@ target_ulong helper_tsubcctv(CPUSPARCState *env, target_ulong src1,
     dst = src1 - src2;
 
     /* Tag overflow occurs if the subtraction overflows.  */
-    if ((src1 ^ src2) & (src1 ^ dst) & (1u << 31)) {
+    v = (src1 ^ src2) & (src1 ^ dst);
+    if (v & (1u << 31)) {
         goto tag_overflow;
     }
 
     /* Only modify the CC after any exceptions have been generated.  */
-    env->cc_op = CC_OP_TSUBTV;
-    env->cc_src = src1;
-    env->cc_src2 = src2;
-    env->cc_dst = dst;
+    env->cc_V = v;
+    env->cc_N = dst;
+    env->cc_icc_Z = dst;
+#ifdef TARGET_SPARC64
+    env->cc_xcc_Z = dst;
+    env->cc_icc_C = dst ^ src1 ^ src2;
+    env->cc_xcc_C = src1 < src2;
+#else
+    env->cc_icc_C = src1 < src2;
+#endif
+
     return dst;
 
  tag_overflow:
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index ff523a4e7d..d8cb669592 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3700,8 +3700,8 @@ TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_udivcc)
 TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_sdivcc)
 TRANS(TADDcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_taddcc)
 TRANS(TSUBcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_tsubcc)
-TRANS(TADDccTV, ALL, do_flags_arith, a, CC_OP_TADDTV, gen_op_taddcctv)
-TRANS(TSUBccTV, ALL, do_flags_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv)
+TRANS(TADDccTV, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_taddcctv)
+TRANS(TSUBccTV, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_tsubcctv)
 
 static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 {
-- 
2.34.1


