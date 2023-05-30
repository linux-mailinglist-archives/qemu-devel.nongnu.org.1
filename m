Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39828716D4A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:16:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o2-0006Nr-TP; Tue, 30 May 2023 15:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ny-00068j-9t
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:51 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nw-0004g2-4E
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:49 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-256797b5664so1748710a91.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474087; x=1688066087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/k1qWQ9n1nK/LPGBxkHi7oTQfCtAyyOXQtWzeqV16Y=;
 b=UfR9ostwPmDrSyArGDQajpNfSij1C0FWClArMnp8NbsTKFFyd1YwqofMAKHzmQPwWh
 dPPgeCzVAd2lOGzRlRiInHfbiETsG3i6csCdWUksL45b6177+srCiK6WJT69Ozrn3Sv5
 bk0Q0QIz6kPhLw7C32M+oSEYZuFSZOVCbrkop/R5hOqM9Jj6YViR4M0yPs+MLOBnRt9P
 fY78SVwEQLKSsYW+55tZJdjQcc8z30a3yJQVABv1zLSo7ksEta3xl995iLV+tTJR4oPL
 efHYfC9GEeSuAXWLjeqJFwad4AltJiqhWq2tFuMTBXCjR8SFrzFBdcndgxNiq33KGmAb
 z38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474087; x=1688066087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/k1qWQ9n1nK/LPGBxkHi7oTQfCtAyyOXQtWzeqV16Y=;
 b=kwOn/Pi62GbyDkSuJjw7LbblZ3sOJ8oDqi9mURquqIICnG+j5z35jrZAKI/CHHvbCP
 naZFewqUqAvu58SMg6EBQDS86higt984Ypfy/EUp99dTes/EUshKMmgoBnIIzB8NPv+M
 JBIUHeVYeLVxlXhQWdJp2fFJvst/4m28cCWBWGpTPcFcn1I/W9l8ZF42re/BCaYdp4hX
 4s9KQ+8KMSNFEJGw5awT1XLFvQspXmbZdTp8lKwi8UP9sjEdn552D26YS9HipS4MJ0kK
 3iWiMhmvJ83+sRkQumQsbYNZCiavof2W6m+enT0miLoR5oQOZFQy5alh0kYlZgTVaZbc
 sABQ==
X-Gm-Message-State: AC+VfDwUITXgfMxBg98mUjOa7ybPir93IGP2nhpGbJ9lhhYQWVRZlLyC
 JyR/ned7k/RggtP+zEbPaMV0vb+KUoodbSLVdkE=
X-Google-Smtp-Source: ACHHUZ7kWeeXsnpJK18PBHLb7d30G3BqYvZ6Ji/9UadIh3p+RSbfU+T7KBvH6itReLUficP81dyggw==
X-Received: by 2002:a17:90a:8a0b:b0:256:2590:818 with SMTP id
 w11-20020a17090a8a0b00b0025625900818mr3528367pjn.33.1685474086883; 
 Tue, 30 May 2023 12:14:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 09/20] target/arm: Load/store integer pair with one tcg
 operation
Date: Tue, 30 May 2023 12:14:27 -0700
Message-Id: <20230530191438.411344-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

This is required for LSE2, where the pair must be treated atomically if
it does not cross a 16-byte boundary.  But it simplifies the code to do
this always.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 70 ++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 19f0f20896..40c6adc9cc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2954,26 +2954,66 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
         TCGv_i64 tcg_rt2 = cpu_reg(s, rt2);
+        MemOp mop = size + 1;
+
+        /*
+         * With LSE2, non-sign-extending pairs are treated atomically if
+         * aligned, and if unaligned one of the pair will be completely
+         * within a 16-byte block and that element will be atomic.
+         * Otherwise each element is separately atomic.
+         * In all cases, issue one operation with the correct atomicity.
+         *
+         * This treats sign-extending loads like zero-extending loads,
+         * since that reuses the most code below.
+         */
+        if (s->align_mem) {
+            mop |= (size == 2 ? MO_ALIGN_4 : MO_ALIGN_8);
+        }
+        mop = finalize_memop_pair(s, mop);
 
         if (is_load) {
-            TCGv_i64 tmp = tcg_temp_new_i64();
+            if (size == 2) {
+                int o2 = s->be_data == MO_LE ? 32 : 0;
+                int o1 = o2 ^ 32;
 
-            /* Do not modify tcg_rt before recognizing any exception
-             * from the second load.
-             */
-            do_gpr_ld(s, tmp, clean_addr, size + is_signed * MO_SIGN,
-                      false, false, 0, false, false);
-            tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
-            do_gpr_ld(s, tcg_rt2, clean_addr, size + is_signed * MO_SIGN,
-                      false, false, 0, false, false);
+                tcg_gen_qemu_ld_i64(tcg_rt, clean_addr, get_mem_index(s), mop);
+                if (is_signed) {
+                    tcg_gen_sextract_i64(tcg_rt2, tcg_rt, o2, 32);
+                    tcg_gen_sextract_i64(tcg_rt, tcg_rt, o1, 32);
+                } else {
+                    tcg_gen_extract_i64(tcg_rt2, tcg_rt, o2, 32);
+                    tcg_gen_extract_i64(tcg_rt, tcg_rt, o1, 32);
+                }
+            } else {
+                TCGv_i128 tmp = tcg_temp_new_i128();
 
-            tcg_gen_mov_i64(tcg_rt, tmp);
+                tcg_gen_qemu_ld_i128(tmp, clean_addr, get_mem_index(s), mop);
+                if (s->be_data == MO_LE) {
+                    tcg_gen_extr_i128_i64(tcg_rt, tcg_rt2, tmp);
+                } else {
+                    tcg_gen_extr_i128_i64(tcg_rt2, tcg_rt, tmp);
+                }
+            }
         } else {
-            do_gpr_st(s, tcg_rt, clean_addr, size,
-                      false, 0, false, false);
-            tcg_gen_addi_i64(clean_addr, clean_addr, 1 << size);
-            do_gpr_st(s, tcg_rt2, clean_addr, size,
-                      false, 0, false, false);
+            if (size == 2) {
+                TCGv_i64 tmp = tcg_temp_new_i64();
+
+                if (s->be_data == MO_LE) {
+                    tcg_gen_concat32_i64(tmp, tcg_rt, tcg_rt2);
+                } else {
+                    tcg_gen_concat32_i64(tmp, tcg_rt2, tcg_rt);
+                }
+                tcg_gen_qemu_st_i64(tmp, clean_addr, get_mem_index(s), mop);
+            } else {
+                TCGv_i128 tmp = tcg_temp_new_i128();
+
+                if (s->be_data == MO_LE) {
+                    tcg_gen_concat_i64_i128(tmp, tcg_rt, tcg_rt2);
+                } else {
+                    tcg_gen_concat_i64_i128(tmp, tcg_rt2, tcg_rt);
+                }
+                tcg_gen_qemu_st_i128(tmp, clean_addr, get_mem_index(s), mop);
+            }
         }
     }
 
-- 
2.34.1


