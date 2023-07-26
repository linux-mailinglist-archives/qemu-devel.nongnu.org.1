Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E6E763EA3
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:37:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOhot-0006C4-9O; Wed, 26 Jul 2023 12:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhmI-0005zW-Cu
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:54:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOhmG-0004mV-Mz
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 12:54:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686bd857365so47268b3a.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 09:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690390458; x=1690995258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MocAb1kiGqDSxbSBtFU2OD7QXuFJdAZtU0eEfpJ5DqY=;
 b=jmk3lOVFLz4Pu9Z+Tf+EBVBHKRBvXOog+dA/y6vKqHEgfjB4r0BdQr1BKvKn3FaPrB
 mKd6Q+6nDT82al0HL63mkiYwYTEtmbW7hpnshrKQsVeNGqfFUqN05cfREPr0Pi0V94L3
 bvYdaDiPGDFw7Nlnm3tOpbcQKxKbFM3z4Qz4lXxtR0uNjVmIpSzVQuuyLs54pyRoqoDF
 3ke6+yX5HDYrJJk4xPgoQPbOhSE0/WcI44OwpLdPgGzM9gbcrdO3RAbk/M2AmyJN5X/d
 /VIon+Lb+j03g03x8mbYdmQKNQJYeynX8BTX066Bwp6g3M6AfHt+E+LoNG4JEZIYNVgo
 XvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690390458; x=1690995258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MocAb1kiGqDSxbSBtFU2OD7QXuFJdAZtU0eEfpJ5DqY=;
 b=ImkSl/k4bittt9LVCXXnjgWd2droFFfkpeBFDEfoZ6QMI8Uqfn+8+CbKuMSHDwuXVK
 xUuAyoda5fy0NcheUoplXaC2md5nXSbja1oDdla/ubfSBabFwnGQBbPwkK054tiCQvxa
 HzC7aMRg6GDS600n1CtwdfQYiSA+NiSlxbb5w3wNOlXCB+pbPZlCUJQq7/fdjpq+qwrt
 jx++GnSWPMFZLLcTE7UgqNMkfJ9ER4ggWOjkD4HPYADIEECDONNi/EYcdzbig3noo71I
 UyBVTv9iSXyXi+uqcdBR+As8iLZtYsLxOEG1nmz/0lxoanBZZtuOvD2XiY//TZND4zds
 PPTA==
X-Gm-Message-State: ABy/qLZFAv3GNYjAts1VTfVY86x5Zz8uLj86XOikhnCaMPsx5iSG3W4G
 nDGI0HY1QeKhcOT+zcGq5arfwW0jD8CWQyv8/0Y=
X-Google-Smtp-Source: APBJJlEYV5Agvhg8hxFp1+wgvZ2AG3xcpWVzR4kXdnB6LAweMd85OEzVEVe7F/Pb7zLUP/9H2JKNKw==
X-Received: by 2002:a05:6a00:14d4:b0:667:85e6:4d1 with SMTP id
 w20-20020a056a0014d400b0066785e604d1mr3262314pfu.33.1690390458295; 
 Wed, 26 Jul 2023 09:54:18 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 b12-20020aa7810c000000b006833b73c749sm11720579pfi.22.2023.07.26.09.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 09:54:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH for-8.1] target/arm: Fix MemOp for STGP
Date: Wed, 26 Jul 2023 09:54:16 -0700
Message-Id: <20230726165416.309624-1-richard.henderson@linaro.org>
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

When converting to decodetree, the code to rebuild mop for the pair
only made it into trans_STP and not into trans_STGP.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1790
Fixes: 8c212eb6594 ("target/arm: Convert load/store-pair to decodetree")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ef0c47407a..5fa1257d32 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3004,6 +3004,9 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
     MemOp mop;
     TCGv_i128 tmp;
 
+    /* STGP only comes in one size. */
+    tcg_debug_assert(a->sz == MO_64);
+
     if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
         return false;
     }
@@ -3029,13 +3032,25 @@ static bool trans_STGP(DisasContext *s, arg_ldstpair *a)
         gen_helper_stg(cpu_env, dirty_addr, dirty_addr);
     }
 
-    mop = finalize_memop(s, a->sz);
-    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << a->sz, mop);
+    mop = finalize_memop(s, MO_64);
+    clean_addr = gen_mte_checkN(s, dirty_addr, true, false, 2 << MO_64, mop);
 
     tcg_rt = cpu_reg(s, a->rt);
     tcg_rt2 = cpu_reg(s, a->rt2);
 
-    assert(a->sz == 3);
+    /*
+     * STGP is defined as two 8-byte memory operations and one tag operation.
+     * We implement it as one single 16-byte memory operation for convenience.
+     * Rebuild mop as for STP.
+     * TODO: The atomicity with LSE2 is stronger than required.
+     * Need a form of MO_ATOM_WITHIN16_PAIR that never requires
+     * 16-byte atomicity.
+     */
+    mop = MO_128;
+    if (s->align_mem) {
+        mop |= MO_ALIGN_8;
+    }
+    mop = finalize_memop_pair(s, mop);
 
     tmp = tcg_temp_new_i128();
     if (s->be_data == MO_LE) {
-- 
2.34.1


