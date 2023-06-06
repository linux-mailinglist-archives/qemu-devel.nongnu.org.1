Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76099723E57
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIu-0007nQ-AD; Tue, 06 Jun 2023 05:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIq-0007kr-NG
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:37 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIm-0004nL-Qt
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30adc51b65cso5323815f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044912; x=1688636912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y4vWb9Y1xxl2/v0t4z9da7Xxeb1mu3H8daoLBgX6KF8=;
 b=s1dWbefJdxCUMwRcJpSy9HLGQFcpFGDEfGqebTEAFub/C8tey1ar6HObxNwrzVrbSz
 uWv97seDztsc8oeBCyUvBHrSjNXSinHptQMnpHNVTistjEI4FcR45Y2nLi9dKK0xXfbg
 6CAij20dQocEvqgvAD6vY62t0jFGLYHV2EzH7v13/IjU2hO/aT8yrmEFyfxuH1VzuUlE
 cwP1D891gr7LugKmEJ/vWIiWefBPp9Y+xE7zI2MvJuXWYjk4m6u4hRxWPIVzuNYSDfll
 aERcsgVQKO7mTevOy9F0cYJz0SVGsTgq2btYlS1gCl1QBvdX/1Q2DfqHC8kpDSt0mMX7
 /cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044912; x=1688636912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4vWb9Y1xxl2/v0t4z9da7Xxeb1mu3H8daoLBgX6KF8=;
 b=abf3hxhAWIMxXLlPtmpG0BwKmjuibi6cchy5xETmLk/M3xCAr+Nqe2VU1g5kGNWvjf
 cmapSC8BfNosU/GD1SZXWShSjkrwejFKQkjFuSEUw+UUMxx98hP3vFQ8Pn45a/3KwOQT
 81anvVJqpGS+nvv+fAL03m/C1vTKQp1ffFL8MXgVMlDcM6ktMOlXVOETbFFBlhP68wb/
 kZzaunxByd39NS2SYJJ0Eph5ozyYB3GZAvCveQTH9iW2sIdX7dMrW4etUFfyPmTuCQk1
 H+sS8hppe0oJ+83/uClMNGd6zLv8YZHOXEK5+YqG4/yYhodkIhEC20BXNg8MrwvThP9L
 M2Cw==
X-Gm-Message-State: AC+VfDzF4a9BjeEIjSiu0yDTXX1GrCRrbV8ZZ7b2Wfpcts+gcRQSSKiv
 9hUqD7ndhrtCHiEcoKXNA+XT0W+sWazmOeiDi24=
X-Google-Smtp-Source: ACHHUZ691apnomMIZVjFHcICuRRD9L2K9wFNbQP6pXOXzlU8Lqn4pcq/yhjvTANFPciXI02vQu8rMw==
X-Received: by 2002:adf:f649:0:b0:306:2d32:8ec with SMTP id
 x9-20020adff649000000b003062d3208ecmr1542130wrp.6.1686044912084; 
 Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/42] target/arm: Check alignment in helper_mte_check
Date: Tue,  6 Jun 2023 10:48:05 +0100
Message-Id: <20230606094814.3581397-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Fixes a bug in that with SCTLR.A set, we should raise any
alignment fault before raising any MTE check fault.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-15-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h         |  3 ++-
 target/arm/tcg/mte_helper.c    | 18 ++++++++++++++++++
 target/arm/tcg/translate-a64.c |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index ce26299f7f0..e3029bdc37a 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1242,7 +1242,8 @@ FIELD(MTEDESC, MIDX,  0, 4)
 FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
-FIELD(MTEDESC, SIZEM1, 9, SIMD_DATA_BITS - 9)  /* size - 1 */
+FIELD(MTEDESC, ALIGN, 9, 3)
+FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index a4f3f92bc02..9c64def0816 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -785,6 +785,24 @@ uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra)
 
 uint64_t HELPER(mte_check)(CPUARMState *env, uint32_t desc, uint64_t ptr)
 {
+    /*
+     * R_XCHFJ: Alignment check not caused by memory type is priority 1,
+     * higher than any translation fault.  When MTE is disabled, tcg
+     * performs the alignment check during the code generated for the
+     * memory access.  With MTE enabled, we must check this here before
+     * raising any translation fault in allocation_tag_mem.
+     */
+    unsigned align = FIELD_EX32(desc, MTEDESC, ALIGN);
+    if (unlikely(align)) {
+        align = (1u << align) - 1;
+        if (unlikely(ptr & align)) {
+            int idx = FIELD_EX32(desc, MTEDESC, MIDX);
+            bool w = FIELD_EX32(desc, MTEDESC, WRITE);
+            MMUAccessType type = w ? MMU_DATA_STORE : MMU_DATA_LOAD;
+            arm_cpu_do_unaligned_access(env_cpu(env), ptr, type, idx, GETPC());
+        }
+    }
+
     return mte_check(env, desc, ptr, GETPC());
 }
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0b600695965..77073a9c1d8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -264,6 +264,7 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ALIGN, get_alignment_bits(memop));
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
 
         ret = tcg_temp_new_i64();
@@ -295,6 +296,7 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ALIGN, get_alignment_bits(single_mop));
         desc = FIELD_DP32(desc, MTEDESC, SIZEM1, total_size - 1);
 
         ret = tcg_temp_new_i64();
-- 
2.34.1


