Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BD5723E71
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIr-0007lk-VQ; Tue, 06 Jun 2023 05:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIp-0007ja-Ja
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIk-0004oN-S5
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f739ec88b2so20106115e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044909; x=1688636909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DSMHqJBYQ/ZZe59fxFXssDmNBSSzK/3Oo7RgKV289TI=;
 b=YI+IRAhDulh1kJrkxp1T1G3dAweTD8IXhSyWi3fATJMFRGafJEkFrS2imCkpT54la1
 hmN+qdI7zaGt1diiH0cHIbjynGDjlqVBWEZxkqmOn2h/aej0hucSkIRjTweo97xq8FwH
 z3YF4oRp3kZcSbDWghYueJ1uTYf170xHzYC/H93HL49OrPUJF3MDmyvRvPhZtvbAhU/R
 5nmjf597q2x3XKz7Pob0WcieGsab06EqnBwjhqCYFEyh5kGM8MG6zIUiue8i6XRgpU/L
 /DjSzXlveAIaBBVSg9IK780Wulcuf2PitKuoOYvQmo+gFyFXt7itzcUHsOsCc02yldSt
 FiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044909; x=1688636909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DSMHqJBYQ/ZZe59fxFXssDmNBSSzK/3Oo7RgKV289TI=;
 b=g0nh22hfXfpN10MjjdyDQoCUUVvJDxP6tcu4xlsfsLgrqkn1xJJsgGUMRRZb9dawIo
 m7EDvjzEA80qXpXNWHSq/JmSM51hr1lIrleYcIc2dLIXybJGWEqqys9+eguQLOYe8t8F
 FsnilFMPQNHgxoQT9PpGyTNceStCFb0wlvpvBquhJ2lU7WjpZnYjhqcNsb+9TkaFlFlS
 DCRIhM//iHkJLjYBZ86Psa5vgPHlRZxZ3WpQH43Ums/qmgH/80yYa2DNU5QDMLkVy7do
 Ebju9vuY/z0M1gj0vmiblB2zI6V0LjyXpgVWcuW+RIt9RnQRU9akhaqY4O7nNKYIfKJF
 CFHw==
X-Gm-Message-State: AC+VfDyoBvj2XV/WmZSxAC6S7ORKQAVGTGBM6u2sGzypHV8CXFBysfbN
 rbgHQ57I6HhcP2azOyEfp78K7d6bS2bvW6O8qRk=
X-Google-Smtp-Source: ACHHUZ7w7ESXFQAJWjQtADUstjFG/254iyRV4PfFG1Mrl/XAplB+DhD7KPu5lKXtfyAGOrl8gsJJgg==
X-Received: by 2002:a05:600c:ace:b0:3f7:e6d8:457b with SMTP id
 c14-20020a05600c0ace00b003f7e6d8457bmr1518190wmr.19.1686044909555; 
 Tue, 06 Jun 2023 02:48:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/42] target/arm: Load/store integer pair with one tcg
 operation
Date: Tue,  6 Jun 2023 10:48:00 +0100
Message-Id: <20230606094814.3581397-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

This is required for LSE2, where the pair must be treated atomically if
it does not cross a 16-byte boundary.  But it simplifies the code to do
this always.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 70 ++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 729947b11a4..88183f9dca1 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2942,26 +2942,66 @@ static void disas_ldst_pair(DisasContext *s, uint32_t insn)
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


