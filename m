Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882ED97C9FC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Sep 2024 15:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwN-0004l2-5h; Thu, 19 Sep 2024 09:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwF-0004Ty-In
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwA-0000zr-MP
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42e5e1e6d37so7615495e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751469; x=1727356269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ssn9H7VrIbql77q/bvO9LinYCZ18sNmlwvuHxervBLY=;
 b=opY0+KIB26u5hTyyE+UysA6HFJb/lM9s5eCD+pQAhQg67DKERu+c96QLcVcED6wH4P
 VBXprEnxFQQVElNRyeMufacLcolbiUuFE0q0xzmf83U9LITh89sHGz2obbEg8QjaT8z0
 4voUr6krnDMJ2SUQB+Z6dK6XywtbEqRE+Z9JQ3v7MKUdtuP4yTiHWunXk0EgIjR1zc7b
 mRDVu8qyrxqZtAg0BX1Ut5APM2dULxTEgtealAhMJismni5fftzN2FH1YL2NRVOFxIrD
 kxw6Fb6v+mMf0d9FJaMborZ4WHDedsz1cQ0HRvgneF8Ip9sFbVJPXnjoUgWzZTJOz7Bk
 O3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751469; x=1727356269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ssn9H7VrIbql77q/bvO9LinYCZ18sNmlwvuHxervBLY=;
 b=bV142Yrnr+JjeYVtg/vfBpjxJ4Eri3y+M2MsLVSJxszemt20VvNm6bYCT9szxFiQXR
 +ggMj7PwLgTwIVVxsgz0bESaGYY0eftkBuXDcFTYOM2MwLgqYOk14MZCj32xnRJuT3a0
 ol8yDr8mlpoluoJIoT3XY7lIL5wzaMrWXGbnwVEnDYle/Y3D1948/PrZlkgEWTZ+SMbX
 SUsDU27Qlzvh4cTb3mJm8S652jns+9Y80IYacy/XFbdLbw6pIVOrBBOb20EU5zrHvGoe
 a1XZtPgngyaQmlq0rjadAbbYUgM5F/7sH+AF6J7ZmVV/796e3WGnr9J6bcTRfz3FMHdg
 5lFA==
X-Gm-Message-State: AOJu0YyPWR0mWWZUpnGJjyDoph4aTQq38VJlLEGBtO8n1s8ibYAswztz
 nsXHhNcxJQs3ciRoz5Y4+N4p0R14RYTw+C7nyW8QcaAYiu2Mx/AcJ4GVxREiyNfZlwJcqashkPL
 u
X-Google-Smtp-Source: AGHT+IExGLpvYK/TKAgu1jcRILpzv0nNEkrFIgVvpTwziH07SJKTyoLIFqkRAyVmt9CrKMcdrd7tag==
X-Received: by 2002:a05:600c:4f81:b0:42c:b7f9:4bbd with SMTP id
 5b1f17b1804b1-42cdb586ccfmr193756785e9.26.1726751468933; 
 Thu, 19 Sep 2024 06:11:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/38] target/arm: Replace tcg_gen_dupi_vec with constants in
 translate-sve.c
Date: Thu, 19 Sep 2024 14:10:30 +0100
Message-Id: <20240919131106.3362543-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Instead of copying a constant into a temporary with dupi,
use a vector constant directly.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 128 +++++++++++++--------------------
 1 file changed, 49 insertions(+), 79 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 9e2536dfe99..49d32fabc9d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -6081,9 +6081,9 @@ static void gen_sshll_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t imm)
 
     if (top) {
         if (shl == halfbits) {
-            TCGv_vec t = tcg_temp_new_vec_matching(d);
-            tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(halfbits, halfbits));
-            tcg_gen_and_vec(vece, d, n, t);
+            tcg_gen_and_vec(vece, d, n,
+                            tcg_constant_vec_matching(d, vece,
+                                MAKE_64BIT_MASK(halfbits, halfbits)));
         } else {
             tcg_gen_sari_vec(vece, d, n, halfbits);
             tcg_gen_shli_vec(vece, d, d, shl);
@@ -6138,18 +6138,18 @@ static void gen_ushll_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t imm)
 
     if (top) {
         if (shl == halfbits) {
-            TCGv_vec t = tcg_temp_new_vec_matching(d);
-            tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(halfbits, halfbits));
-            tcg_gen_and_vec(vece, d, n, t);
+            tcg_gen_and_vec(vece, d, n,
+                            tcg_constant_vec_matching(d, vece,
+                                MAKE_64BIT_MASK(halfbits, halfbits)));
         } else {
             tcg_gen_shri_vec(vece, d, n, halfbits);
             tcg_gen_shli_vec(vece, d, d, shl);
         }
     } else {
         if (shl == 0) {
-            TCGv_vec t = tcg_temp_new_vec_matching(d);
-            tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-            tcg_gen_and_vec(vece, d, n, t);
+            tcg_gen_and_vec(vece, d, n,
+                            tcg_constant_vec_matching(d, vece,
+                                MAKE_64BIT_MASK(0, halfbits)));
         } else {
             tcg_gen_shli_vec(vece, d, n, halfbits);
             tcg_gen_shri_vec(vece, d, d, halfbits - shl);
@@ -6317,18 +6317,14 @@ static const TCGOpcode sqxtn_list[] = {
 
 static void gen_sqxtnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t mask = (1ull << halfbits) - 1;
     int64_t min = -1ull << (halfbits - 1);
     int64_t max = -min - 1;
 
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, d, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, d, d, t);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_and_vec(vece, d, d, t);
+    tcg_gen_smax_vec(vece, d, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, d, d, tcg_constant_vec_matching(d, vece, max));
+    tcg_gen_and_vec(vece, d, d, tcg_constant_vec_matching(d, vece, mask));
 }
 
 static const GVecGen2 sqxtnb_ops[3] = {
@@ -6349,19 +6345,15 @@ TRANS_FEAT(SQXTNB, aa64_sve2, do_narrow_extract, a, sqxtnb_ops)
 
 static void gen_sqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t mask = (1ull << halfbits) - 1;
     int64_t min = -1ull << (halfbits - 1);
     int64_t max = -min - 1;
 
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, n, n, tcg_constant_vec_matching(d, vece, max));
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, tcg_constant_vec_matching(d, vece, mask), d, n);
 }
 
 static const GVecGen2 sqxtnt_ops[3] = {
@@ -6389,12 +6381,10 @@ static const TCGOpcode uqxtn_list[] = {
 
 static void gen_uqxtnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
 
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_gen_umin_vec(vece, d, n, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const GVecGen2 uqxtnb_ops[3] = {
@@ -6415,14 +6405,13 @@ TRANS_FEAT(UQXTNB, aa64_sve2, do_narrow_extract, a, uqxtnb_ops)
 
 static void gen_uqxtnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const GVecGen2 uqxtnt_ops[3] = {
@@ -6450,14 +6439,11 @@ static const TCGOpcode sqxtun_list[] = {
 
 static void gen_sqxtunb_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
 
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, d, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, d, d, t);
+    tcg_gen_smax_vec(vece, d, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, d, d, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const GVecGen2 sqxtunb_ops[3] = {
@@ -6478,16 +6464,14 @@ TRANS_FEAT(SQXTUNB, aa64_sve2, do_narrow_extract, a, sqxtunb_ops)
 
 static void gen_sqxtunt_vec(unsigned vece, TCGv_vec d, TCGv_vec n)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = (1ull << halfbits) - 1;
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const GVecGen2 sqxtunt_ops[3] = {
@@ -6551,13 +6535,11 @@ static void gen_shrnb64_i64(TCGv_i64 d, TCGv_i64 n, int64_t shr)
 
 static void gen_shrnb_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     uint64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_shri_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_and_vec(vece, d, n, t);
+    tcg_gen_and_vec(vece, d, n, tcg_constant_vec_matching(d, vece, mask));
 }
 
 static const TCGOpcode shrnb_vec_list[] = { INDEX_op_shri_vec, 0 };
@@ -6609,13 +6591,11 @@ static void gen_shrnt64_i64(TCGv_i64 d, TCGv_i64 n, int64_t shr)
 
 static void gen_shrnt_vec(unsigned vece, TCGv_vec d, TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     uint64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_shli_vec(vece, n, n, halfbits - shr);
-    tcg_gen_dupi_vec(vece, t, mask);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, tcg_constant_vec_matching(d, vece, mask), d, n);
 }
 
 static const TCGOpcode shrnt_vec_list[] = { INDEX_op_shli_vec, 0 };
@@ -6658,14 +6638,12 @@ TRANS_FEAT(RSHRNT, aa64_sve2, do_shr_narrow, a, rshrnt_ops)
 static void gen_sqshrunb_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    uint64_t max = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, d, n, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const TCGOpcode sqshrunb_vec_list[] = {
@@ -6690,16 +6668,15 @@ TRANS_FEAT(SQSHRUNB, aa64_sve2, do_shr_narrow, a, sqshrunb_ops)
 static void gen_sqshrunt_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    uint64_t max = MAKE_64BIT_MASK(0, halfbits);
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, 0);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, 0));
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const TCGOpcode sqshrunt_vec_list[] = {
@@ -6742,18 +6719,15 @@ TRANS_FEAT(SQRSHRUNT, aa64_sve2, do_shr_narrow, a, sqrshrunt_ops)
 static void gen_sqshrnb_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = MAKE_64BIT_MASK(0, halfbits - 1);
     int64_t min = -max - 1;
+    int64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_and_vec(vece, d, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, n, n, tcg_constant_vec_matching(d, vece, max));
+    tcg_gen_and_vec(vece, d, n, tcg_constant_vec_matching(d, vece, mask));
 }
 
 static const TCGOpcode sqshrnb_vec_list[] = {
@@ -6778,19 +6752,16 @@ TRANS_FEAT(SQSHRNB, aa64_sve2, do_shr_narrow, a, sqshrnb_ops)
 static void gen_sqshrnt_vec(unsigned vece, TCGv_vec d,
                              TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
     int64_t max = MAKE_64BIT_MASK(0, halfbits - 1);
     int64_t min = -max - 1;
+    int64_t mask = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_sari_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, min);
-    tcg_gen_smax_vec(vece, n, n, t);
-    tcg_gen_dupi_vec(vece, t, max);
-    tcg_gen_smin_vec(vece, n, n, t);
+    tcg_gen_smax_vec(vece, n, n, tcg_constant_vec_matching(d, vece, min));
+    tcg_gen_smin_vec(vece, n, n, tcg_constant_vec_matching(d, vece, max));
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, tcg_constant_vec_matching(d, vece, mask), d, n);
 }
 
 static const TCGOpcode sqshrnt_vec_list[] = {
@@ -6833,12 +6804,11 @@ TRANS_FEAT(SQRSHRNT, aa64_sve2, do_shr_narrow, a, sqrshrnt_ops)
 static void gen_uqshrnb_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    int64_t max = MAKE_64BIT_MASK(0, halfbits);
 
     tcg_gen_shri_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, d, n, t);
+    tcg_gen_umin_vec(vece, d, n, tcg_constant_vec_matching(d, vece, max));
 }
 
 static const TCGOpcode uqshrnb_vec_list[] = {
@@ -6863,14 +6833,14 @@ TRANS_FEAT(UQSHRNB, aa64_sve2, do_shr_narrow, a, uqshrnb_ops)
 static void gen_uqshrnt_vec(unsigned vece, TCGv_vec d,
                             TCGv_vec n, int64_t shr)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
     int halfbits = 4 << vece;
+    int64_t max = MAKE_64BIT_MASK(0, halfbits);
+    TCGv_vec maxv = tcg_constant_vec_matching(d, vece, max);
 
     tcg_gen_shri_vec(vece, n, n, shr);
-    tcg_gen_dupi_vec(vece, t, MAKE_64BIT_MASK(0, halfbits));
-    tcg_gen_umin_vec(vece, n, n, t);
+    tcg_gen_umin_vec(vece, n, n, maxv);
     tcg_gen_shli_vec(vece, n, n, halfbits);
-    tcg_gen_bitsel_vec(vece, d, t, d, n);
+    tcg_gen_bitsel_vec(vece, d, maxv, d, n);
 }
 
 static const TCGOpcode uqshrnt_vec_list[] = {
-- 
2.34.1


