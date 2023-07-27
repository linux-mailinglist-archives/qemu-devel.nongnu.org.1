Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C176590D
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:44:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3ov-0003z9-6O; Thu, 27 Jul 2023 12:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3op-0003vG-8d
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:26:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3on-0000fV-8f
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:26:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6862842a028so904763b3a.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690475183; x=1691079983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3G2qvF807dtcBmq3t7VF0034ERKCeVyIfRSjPFahYwM=;
 b=sMG0w/xn9GQ2iZUQ2aEEE/C0ljYIaczAdwqPdn9zwWYC7TFXk5oe2IO3KGvM8AvLHV
 Sh0bTB3tZqW9mFiacCBJeMV0fGtwCT8rGbEO3AXgtzJyHWyX6FlUStZWkOghbdPbLeBH
 2P4ZAZYkdfaxnP6UKnTN2Z2KoD7Kc3A2D1Qj6wVsJZtdRQj6VmV3K29yb2YMAsIak6Q4
 9BDK0UUZwJjLUUmVk9l0fN8qnmAW1UVZGKLvA0utfxIeH+g34zQalQ0bE5Uy1LoLNC4E
 ZBqZe6lOUaYNVIp/Vwu5mxlbWbCGPrQ3HkbAO7ZNjORFZMqJFBhObl9YBgglb3jpxSE5
 VMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690475183; x=1691079983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3G2qvF807dtcBmq3t7VF0034ERKCeVyIfRSjPFahYwM=;
 b=JmnyWBo8sqvvZdDlvE4xZQzrEr0B61Diqy/WA2dmIkOz1ChEsFH1Mslz1AsMWZPwEH
 pDYElnti48TXgzD+PP8RffDmR7V7MZpk7xklWnJOzVH4K2ofv/WQVkYpUhQv3VO3wHGZ
 FyC1UscyA3vDBq54kZrebZ+7TVD50kwQJ6GS61p0Ve5IG847MVWG7VKBp3p9IhtTH6b3
 BfBitd55BzzJkdU1JkQBB1+7/x6XoL2/MblPwTzMY47BIuOfOXXRJkvIuxgK6HpfJtP4
 A9gZk22mNOiNUUcB8PzKeKEXb7yyaps8TOPcEGL1YXHHgDfaJBiANCFwlltHH5lQHcLL
 ypeQ==
X-Gm-Message-State: ABy/qLYZPlnE1YQG7GdYQqcrQYt3QCtI/bPt7ndr8vVD0qTDgtj7bQIZ
 sWSmjQpheTG41sP82lZ0kPzbhm2u1CzzSeN9qS8=
X-Google-Smtp-Source: APBJJlE84JoSbhXLKVKkktTKsRDpetXbFE7P3PoosBnRp1vF8w51yiT3C7PLiIU9m7yFMfpuo0zjXw==
X-Received: by 2002:a05:6a00:1a94:b0:682:2e99:9de0 with SMTP id
 e20-20020a056a001a9400b006822e999de0mr5566719pfv.23.1690475182516; 
 Thu, 27 Jul 2023 09:26:22 -0700 (PDT)
Received: from stoup.. ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 p13-20020aa7860d000000b00682c1db7551sm1687786pfn.49.2023.07.27.09.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:26:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH] target/arm: Do not use gen_mte_checkN in trans_STGP
Date: Thu, 27 Jul 2023 09:26:21 -0700
Message-Id: <20230727162621.445400-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

STGP writes to tag memory, it does not check it.
This happened to work because we wrote tag memory first
so that the check always succeeded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 41 +++++++++++++---------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5fa1257d32..dfd18e19ca 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3020,37 +3020,17 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
         tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     }
 
-    if (!s->ata) {
-        /*
-         * TODO: We could rely on the stores below, at least for
-         * system mode, if we arrange to add MO_ALIGN_16.
-         */
-        gen_helper_stg_stub(cpu_env, dirty_addr);
-    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
-        gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
-    } else {
-        gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
-    }
-
-    mop = finalize_memop(s, MO_64);
-    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << MO_64, mop);
-
+    clean_addr = clean_data_tbi(s, dirty_addr);
     tcg_rt = cpu_reg(s, a->rt);
     tcg_rt2 = cpu_reg(s, a->rt2);
 
     /*
-     * STGP is defined as two 8-byte memory operations and one tag operation.
-     * We implement it as one single 16-byte memory operation for convenience.
-     * Rebuild mop as for STP.
-     * TODO: The atomicity with LSE2 is stronger than required.
-     * Need a form of MO_ATOM_WITHIN16_PAIR that never requires
-     * 16-byte atomicity.
+     * STGP is defined as two 8-byte memory operations, aligned to TAG_GRANULE,
+     * and one tag operation.  We implement it as one single aligned 16-byte
+     * memory operation for convenience.  Note that the alignment ensures
+     * MO_ATOM_IFALIGN_PAIR produces 8-byte atomicity for the memory store.
      */
-    mop = MO_128;
-    if (s->align_mem) {
-        mop |= MO_ALIGN_8;
-    }
-    mop = finalize_memop_pair(s, mop);
+    mop = MO_128 | MO_ALIGN | MO_ATOM_IFALIGN_PAIR;
 
     tmp = tcg_temp_new_i128();
     if (s->be_data == MO_LE) {
@@ -3060,6 +3040,15 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
     }
     tcg_gen_qemu_st_i128(tmp, clean_addr, get_mem_index(s), mop);
 
+    /* Perform the tag store, if tag access enabled. */
+    if (s->ata) {
+        if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            gen_helper_stg_parallel(cpu_env, dirty_addr, dirty_addr);
+        } else {
+            gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
+        }
+    }
+
     op_addr_ldstpair_post(s, a, dirty_addr, offset);
     return true;
 }
-- 
2.34.1


