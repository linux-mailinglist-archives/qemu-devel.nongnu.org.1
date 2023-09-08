Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B23798B2A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:07:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeew9-0005Xy-6O; Fri, 08 Sep 2023 13:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeew3-0005Ty-Lf
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevq-00019J-ND
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so26096035e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192769; x=1694797569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iPP1VGFIkKk/pnu84AWbQJuPsM24zttg/DQyTydt5A8=;
 b=iTDGw6A4r+xELqij11mScaEqJ3p6zUUYbMQs4UmCFF8GE/QfHU9165JVuQ8dwa1MnR
 96yTlinEu74eu1w5f95ybZE7NAM2YNH/g0+LqaD0KAt5JYu9SmEq9EwMuHnXpyMCt0i8
 5DG9efdP3t6U2lcefVyqb2x31S3VDJDEu1vtE/j51qOkzi53dM0uUjuXV1Hwn5hfVHMZ
 yOjZSsIJCQ48G38mU4hjYvhXwmTFwdx+lNoIKgCUaIFFPnrjadL4vCvN66C1edVTBrOi
 kopaCvHIbGVLixSyxGkzOFjDXE2T55L8McYh0qkUeRrLm+2tCI0gJ3k/qQz2f/32G+I0
 OUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192769; x=1694797569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPP1VGFIkKk/pnu84AWbQJuPsM24zttg/DQyTydt5A8=;
 b=I45fN1r0a976mkNIiCnzucW9hPITm2Oar9C4CVor078MHxuih8zxG0YOYqd1JzqAu6
 J+lp0hrKZeHwVUL7YzMf9tGtnuW01P9sH3Plu2awrAgQpPuFT01kwFoWieOuy+q/6HzM
 otXJdvimPMEDUALWrEQaA9YfxetOdDapjvZExmgsFLbfuBV2dCl3+0bQp7x9F1Kjmb8X
 BfAokCqIBb3NLrrvOB6DIJg4PpROU9UHhl/IuAOSMZweKQERq4jPE0c8U5LRgswEyGWe
 Y9Cm1HIL+RroYb0vM7w8bC/FWoSwxL2XR9jikE9fu60+QjTpuC0tpY22Je0lMVCX6kxK
 QzbQ==
X-Gm-Message-State: AOJu0YzZ/+Zq6gTaQdXau9u+vYW2XD8BTSLoPM5y/ej0kQDTxVA7dEA/
 hF0/oSP474Iu6ycmsRLrnnQ5LLyuTmrePEUL8yY=
X-Google-Smtp-Source: AGHT+IHOt04n24LUVLQlVg1DPeoxBcwHLb3WP732xLRh/GS0WrH8GEKSCzliv0Exs3jtNH1cTvN4tQ==
X-Received: by 2002:a7b:c84b:0:b0:401:d2cb:e6f2 with SMTP id
 c11-20020a7bc84b000000b00401d2cbe6f2mr2543492wml.32.1694192769046; 
 Fri, 08 Sep 2023 10:06:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] target/arm: Do not use gen_mte_checkN in trans_STGP
Date: Fri,  8 Sep 2023 18:05:50 +0100
Message-Id: <20230908170557.773048-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

STGP writes to tag memory, it does not check it.
This happened to work because we wrote tag memory first
so that the check always succeeded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230901203103.136408-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 41 +++++++++++++---------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c2bd96f5d43..7d2f8026e65 100644
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
+    mop = finalize_memop_atom(s, MO_128 | MO_ALIGN, MO_ATOM_IFALIGN_PAIR);
 
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


