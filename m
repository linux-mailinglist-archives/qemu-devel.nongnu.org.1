Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 255C07A332E
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 00:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhdMW-0006Hp-9E; Sat, 16 Sep 2023 18:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMU-0006GW-6e
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhdMS-00047F-FU
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 18:01:57 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c09673b006so25321065ad.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694901715; x=1695506515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkIKScugFstB2eLhoDZslzvtYewYtRAcc2oZTQwrpeE=;
 b=IDMTpl0nrpwoYnEIkhmrOFGIeNzkKLJu6Vpj078AE9rqp5Y45VUSZqYVrNLcyhi2Pn
 0qSRV27gEMiEDxs6R5WJ7PdOmCOVt/QrIbzYWDTRatGbKRi9ROpEk5svbiFzckEldaWd
 z5fwdZVwrPM8vBnAgHur6vVDcD2vR8Wf07IlTkviKRuOLgz8uC/w3EEcyuhUVdPRMWKG
 o1nt4AWIZkSFEGUe2ufGAmu0RNEpVsFy1+qngYHtEYuQzj+0kOoflj5wBFQIXPiWxJLc
 FMm59zDG3fS3fPX3x4CPA6tK5uG8SwhfpDngNJJLrY8NzQ96iHUhqXtjV4EUPoBH/989
 Xxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694901715; x=1695506515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NkIKScugFstB2eLhoDZslzvtYewYtRAcc2oZTQwrpeE=;
 b=xLjTb47GAYFWmLZ40ffmBiA74f0YyhTuoXO6uxIFxF/T6KiT5hUUDFU7lI8PWP0P8H
 Nwz/T41agzCke7wniA3/RACqUoRC1RsCvA2z56CcdhkvlOHh8Fd0GVdiHot9oz0uEex0
 BAO8bIjwNqkmwKpgxTkBBi1PlXaifZEHRMbhk6IGeGiXPYjuId68PxtIWOCdnMqtWvW4
 qAEZjXfNrR/RgSrKPjwvP2nNvhDbhOoNe/JY6VM4FvaqSL9tE4U70pzWfljFxcPhAPLa
 drYIAxK866vdBlsZgO9jK7NnY9JyGn82rEq8qZm20xYVH7Trs6SM+qS1YhGVAB09VFeq
 FqWw==
X-Gm-Message-State: AOJu0YxyUmORzqbvo5R+Xm5baFAFZmRHdiHQw9tKP5I2OPRYZATB3w3R
 ndYFRRuAMjJI6BoF/PE/gpvNgdZP6VeOGFlxts0=
X-Google-Smtp-Source: AGHT+IFZD5/AdgSffsjV68HLax35Ios4mR0ENGE6zFBr8QFaWtAqj0gqBcrk8RhYJIrxJR6R5J91rA==
X-Received: by 2002:a17:902:ce84:b0:1be:e873:38b0 with SMTP id
 f4-20020a170902ce8400b001bee87338b0mr5908894plg.59.1694901714857; 
 Sat, 16 Sep 2023 15:01:54 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 q3-20020a170902788300b001b531e8a000sm5707763pll.157.2023.09.16.15.01.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 15:01:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: git@xen0n.name, c@jia.je, gaosong@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH 2/7] tcg/loongarch64: Use C_N2_I1 for INDEX_op_qemu_ld_a*_i128
Date: Sat, 16 Sep 2023 15:01:46 -0700
Message-Id: <20230916220151.526140-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916220151.526140-1-richard.henderson@linaro.org>
References: <20230916220151.526140-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Use new registers for the output, so that we never overlap
the input address, which could happen for user-only.
This avoids a "tmp = addr + 0" in that case.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 +-
 tcg/loongarch64/tcg-target.c.inc     | 17 +++++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 77d62e38e7..cae6c2aad6 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -38,4 +38,4 @@ C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
-C_O2_I1(r, r, r)
+C_N2_I1(r, r, r)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b701df50db..40074c46b8 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1105,13 +1105,18 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi
         }
     } else {
         /* Otherwise use a pair of LD/ST. */
-        tcg_out_opc_add_d(s, TCG_REG_TMP0, h.base, h.index);
+        TCGReg base = h.base;
+        if (h.index != TCG_REG_ZERO) {
+            base = TCG_REG_TMP0;
+            tcg_out_opc_add_d(s, base, h.base, h.index);
+        }
         if (is_ld) {
-            tcg_out_opc_ld_d(s, data_lo, TCG_REG_TMP0, 0);
-            tcg_out_opc_ld_d(s, data_hi, TCG_REG_TMP0, 8);
+            tcg_debug_assert(base != data_lo);
+            tcg_out_opc_ld_d(s, data_lo, base, 0);
+            tcg_out_opc_ld_d(s, data_hi, base, 8);
         } else {
-            tcg_out_opc_st_d(s, data_lo, TCG_REG_TMP0, 0);
-            tcg_out_opc_st_d(s, data_hi, TCG_REG_TMP0, 8);
+            tcg_out_opc_st_d(s, data_lo, base, 0);
+            tcg_out_opc_st_d(s, data_hi, base, 8);
         }
     }
 
@@ -2049,7 +2054,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_qemu_ld_a32_i128:
     case INDEX_op_qemu_ld_a64_i128:
-        return C_O2_I1(r, r, r);
+        return C_N2_I1(r, r, r);
 
     case INDEX_op_qemu_st_a32_i128:
     case INDEX_op_qemu_st_a64_i128:
-- 
2.34.1


