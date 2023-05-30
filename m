Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B85716D72
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o5-0006lB-Lr; Tue, 30 May 2023 15:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nv-00063u-32
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:48 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nr-0004cS-U0
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso5568438b3a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474082; x=1688066082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oznYYgRZlnX+t2EBlDXRv+m0lTb2+8Xh7ZDPWTosV5I=;
 b=MlFDRvo3276gw6duv8oO1KLBnmYGMDOXRqb6xJ18gxMqQWdBurGWIV02Tu5HP+BJgz
 66JPevtPzhqrSwD5MM17u5IEW9r45G1ndXuWMH+i2GIsOIcQUJCa7nQshivU1Pkt0Ydh
 tb1TwlD8ezKFxs3+lUoPB7jHDH5FSHmS0rxVYFADeGP/oHbXhctsNj88vNsjw2p27/Fm
 dqa2BWlm6gi/fJJdzWs2AbqFFLxUC9a95kOAsSvpVH1AQ+JUjT/T9oXRtk0L8pJTUOS3
 9WZMHWtRC6ckmueP+sTIWnYwgHdcU5z8cRz4yU9sVqDDqhs+69ix1y6HRGYeQndhJSpX
 aqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474082; x=1688066082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oznYYgRZlnX+t2EBlDXRv+m0lTb2+8Xh7ZDPWTosV5I=;
 b=Y8LKbo79x8fX2wbkAF9qK6+B7MZ4FlOg9MmgKLlEK5KL+F/s2fqla/yKpcXoSstYcz
 4QwuHftXQ/NxqkxpnS2MWDDElyJKOpQQpCkcYXCS5HNa3SIn991J86dwVEn+jjdWRsaF
 DXLUIzKzOeSsI77C2sjT1/f8TLgPK5Op5T5oDCX1ft8YOAa233nxMr6/eOJFgRm0+G2M
 zmTwy9xdAIhVgbFkgFoMmW/AXlHOys3LvB3O04jtYcx0btoaTqX6BESSD0SvaBhM5S4V
 eUiUhS6fma24BFHD7HmGdh/w19pRgrCTt5KtfcwqYvKGleIXcIIYoId5tYd2OkSyEFU0
 P+BQ==
X-Gm-Message-State: AC+VfDxFErd/5fHZm2p6oHM87mxWMiTGJroF6ac8ZRjayB3rzmOlGfqH
 104P4vRiDrsa1rRk1UT807t4gYcMFUHAVNUb36E=
X-Google-Smtp-Source: ACHHUZ7tpfU+aQ7rSH03sc6ApfU8v9tZA8KXWhfxTK4WtuqMVmopeokBlhCUPwC1lynBsin9PcIVIQ==
X-Received: by 2002:a05:6a20:160a:b0:10a:ef03:3346 with SMTP id
 l10-20020a056a20160a00b0010aef033346mr4021874pzj.9.1685474082649; 
 Tue, 30 May 2023 12:14:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 04/20] target/arm: Use tcg_gen_qemu_ld_i128 for LDXP
Date: Tue, 30 May 2023 12:14:22 -0700
Message-Id: <20230530191438.411344-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

While we don't require 16-byte atomicity here, using a single larger
load simplifies the code, and makes it a closer match to STXP.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 967400ed68..0e720f2612 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2398,14 +2398,14 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                                TCGv_i64 addr, int size, bool is_pair)
 {
     int idx = get_mem_index(s);
-    MemOp memop = s->be_data;
+    MemOp memop;
 
     g_assert(size <= 3);
     if (is_pair) {
         g_assert(size >= 2);
         if (size == 2) {
             /* The pair must be single-copy atomic for the doubleword.  */
-            memop |= MO_64 | MO_ALIGN;
+            memop = finalize_memop(s, MO_64 | MO_ALIGN);
             tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
             if (s->be_data == MO_LE) {
                 tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
@@ -2415,21 +2415,30 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
                 tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 0, 32);
             }
         } else {
-            /* The pair must be single-copy atomic for *each* doubleword, not
-               the entire quadword, however it must be quadword aligned.  */
-            memop |= MO_64;
-            tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx,
-                                memop | MO_ALIGN_16);
+            /*
+             * The pair must be single-copy atomic for *each* doubleword, not
+             * the entire quadword, however it must be quadword aligned.
+             * Expose the complete load to tcg, for ease of tlb lookup,
+             * but indicate that only 8-byte atomicity is required.
+             */
+            TCGv_i128 t16 = tcg_temp_new_i128();
 
-            TCGv_i64 addr2 = tcg_temp_new_i64();
-            tcg_gen_addi_i64(addr2, addr, 8);
-            tcg_gen_qemu_ld_i64(cpu_exclusive_high, addr2, idx, memop);
+            memop = finalize_memop_atom(s, MO_128 | MO_ALIGN_16,
+                                        MO_ATOM_IFALIGN_PAIR);
+            tcg_gen_qemu_ld_i128(t16, addr, idx, memop);
 
+            if (s->be_data == MO_LE) {
+                tcg_gen_extr_i128_i64(cpu_exclusive_val,
+                                      cpu_exclusive_high, t16);
+            } else {
+                tcg_gen_extr_i128_i64(cpu_exclusive_high,
+                                      cpu_exclusive_val, t16);
+            }
             tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
             tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
         }
     } else {
-        memop |= size | MO_ALIGN;
+        memop = finalize_memop(s, size | MO_ALIGN);
         tcg_gen_qemu_ld_i64(cpu_exclusive_val, addr, idx, memop);
         tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
     }
-- 
2.34.1


