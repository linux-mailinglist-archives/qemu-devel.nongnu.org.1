Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A12711AA8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:29:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLZ-0005qD-EN; Thu, 25 May 2023 19:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLW-0005oq-0S
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:15 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLQ-0005me-Ey
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:13 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5346d150972so100042a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057167; x=1687649167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/k1qWQ9n1nK/LPGBxkHi7oTQfCtAyyOXQtWzeqV16Y=;
 b=QPcqo3D9BOm9RWkUYTd0/sVdjwWj9QIa2ZcskEusulX3urqxaZ25taJ/8SsWe06hZC
 rP/rZ2ALkgf/fw+aBS1j3ec4sw+bqJ4pP/M38KEksLh11jmqyqzaHvzCmhiNxyIiexL4
 KFNpe+7H6yQAHS56MMM7PpMB5cgWqavevT5psd/SkoymXBnewc8ojYF7ACJPVGUAr4FE
 rdiZ64P/C5zQv7UrNOCRD4fcQU0vn9vlbzutUyEHmWyYptdBMRfg3Wf1dgoEHySyZkFL
 RaKNE+qPPtjTjaV45LVWATsI2ViuYtpe+GQHSeUMtBRpwH7UhfQzG+U1rll2jhAG1X79
 KJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057167; x=1687649167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N/k1qWQ9n1nK/LPGBxkHi7oTQfCtAyyOXQtWzeqV16Y=;
 b=ihNId+lg9YqfPdFCBWBVGHENaCrvuqusbQq4p7PIxwtVfYrve5JLzLTP7deWjeDcgU
 PqRKlJSD36XgOBv6piNL9nGrdwi3WOnznwyd2uQtSwY36WFzj03bmBy1D7oyeWyefQDU
 zoqpdBsdNARGAGZTVmAn88KlK6Lurd5qlnD6dyrH2Ii+k1S0HEwWv8O5PT0gMsYnZBnZ
 mM9d+y8bmSslgTLI+L1YWZuY3VlAu8MzBzQR8hIZlnI63CGwtcYmCISIuseI146KmItg
 6CCaJuiN5j0nzFOJ1D3xGrqGEP5pl6WumW6GwkLjeFA43XietbYwdtrf9GlpD2OrSO+R
 qSBA==
X-Gm-Message-State: AC+VfDylT7RcuF7kpq+lupxWL9WJC+YkK6915bbIQjLRawpGtOarhZrI
 KNdzw90hOYaJCbmtwA4aygwy4zqppMUukzr2u+w=
X-Google-Smtp-Source: ACHHUZ6L22D/2Ji2r0CVLo36fkDyQsu6c3kqzTBsAjLZkCty7V+V9APdj5vEHaP56x+Lk91xaNSTdQ==
X-Received: by 2002:a17:902:f801:b0:1ae:5212:748b with SMTP id
 ix1-20020a170902f80100b001ae5212748bmr288567plb.49.1685057166872; 
 Thu, 25 May 2023 16:26:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 09/20] target/arm: Load/store integer pair with one tcg
 operation
Date: Thu, 25 May 2023 16:25:47 -0700
Message-Id: <20230525232558.1758967-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


