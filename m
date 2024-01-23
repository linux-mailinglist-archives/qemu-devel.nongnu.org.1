Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7FF8392E2
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 16:35:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSInC-0004Nd-06; Tue, 23 Jan 2024 10:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSIn7-0004JI-J5
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:34:21 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rSIn5-0006ds-Qw
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 10:34:21 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso53073705e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 07:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706024058; x=1706628858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WserJn90ElmaLFKu56K8+uISef20eii9M5Mz4+TMvho=;
 b=qY2FlyLkZk80wBcCUV+dwD8aPMknPtp+1ktRyPQ/fer+R4qx34saGu2JFWFukPDpNe
 Nj8IEKM9DuwUvuZWCJ2FAhnuSl1CW9eUDVhUns4WMcmMqIokatmTcFgr0lAf3I2aqejb
 vW7Pc2HStswp1D6Gcz88jgGb6CdPBxDPySWPMY3f0iRHngjGakrjp+Wd3mRB3RRAQ4Y9
 CuUZ2VjZDABe5ugc6kpKjRe3V6wyDnEKR6ZogVB02p8Mu495wHVjIUjG9IqszIlVnbtV
 zJlzwyaH0McR0Yvurklgjxw/f/I65b5g0ASOhuYNb2XRvsHFMkEH3c9BdA0oxx+4LX1f
 46zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706024058; x=1706628858;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WserJn90ElmaLFKu56K8+uISef20eii9M5Mz4+TMvho=;
 b=NAB0U9mIrOmbURil0kbOWCbC35uscMCua6iiAhtfhxu99jFmr3PIS98jVRccRUp8kg
 ch5DgSJ5pw1/D7FjQr5HPhv+ZDWK8c6Igg90P6YEZHMvj3qCq/cJ+wUQCgGzvM/GltEh
 p1GEHi9V6vwN2762mskchfzk3UTydipBnOmXTA4YqOPlxPgsP1JwvpVF5RGCAcCsVUkm
 0c9rQeJnEt4rYsujuiy0QaF7/hXvnuKE1rzWePm7K1MAUglGRuUyTbt4J+5LhsC0kQmi
 1gB8U3K+d87SqwddbJBr5dB2lsgm6fGAy+aU2e6ERP2NoAyxTCtZycGvCUTL4V4C1IEq
 g2VA==
X-Gm-Message-State: AOJu0Yz4b5bYS1HxM1ZOp7r+t3FtfubKDSRwsdZfubF2at4V5+LWdDG6
 uVCw6hzX2KFcyk7xwEwXwWZjfKX3udoeGkMQJJNJPDbboWGbbTFZRmk1OKK4iws=
X-Google-Smtp-Source: AGHT+IEBFyF6iVT8DKr7VQkAATYkR7LQHzvCMNsXvztaHwPwQIz+EI8S8oKKtgyG/MA/Uj0zZ1q8JA==
X-Received: by 2002:a05:600c:4393:b0:40e:526b:d5f5 with SMTP id
 e19-20020a05600c439300b0040e526bd5f5mr167632wmn.247.1706024058481; 
 Tue, 23 Jan 2024 07:34:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a05600c4e8d00b0040eb6ce137asm2577783wmq.39.2024.01.23.07.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 07:34:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/arm: Fix A64 scalar SQSHRN and SQRSHRN
Date: Tue, 23 Jan 2024 15:34:16 +0000
Message-Id: <20240123153416.877308-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

In commit 1b7bc9b5c8bf374dd we changed handle_vec_simd_sqshrn() so
that instead of starting with a 0 value and depositing in each new
element from the narrowing operation, it instead started with the raw
result of the narrowing operation of the first element.

This is fine in the vector case, because the deposit operations for
the second and subsequent elements will always overwrite any higher
bits that might have been in the first element's result value in
tcg_rd.  However in the scalar case we only go through this loop
once.  The effect is that for a signed narrowing operation, if the
result is negative then we will now return a value where the bits
above the first element are incorrectly 1 (because the narrowfn
returns a sign-extended result, not one that is truncated to the
element size).

Fix this by using an extract operation to get exactly the correct
bits of the output of the narrowfn for element 1, instead of a
plain move.

Cc: qemu-stable@nongnu.org
Fixes: 1b7bc9b5c8bf374dd3 ("target/arm: Avoid tcg_const_ptr in handle_vec_simd_sqshrn")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2089
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 27335e85407..340265beb05 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8343,7 +8343,7 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
         narrowfn(tcg_rd_narrowed, tcg_env, tcg_rd);
         tcg_gen_extu_i32_i64(tcg_rd, tcg_rd_narrowed);
         if (i == 0) {
-            tcg_gen_mov_i64(tcg_final, tcg_rd);
+            tcg_gen_extract_i64(tcg_final, tcg_rd, 0, esize);
         } else {
             tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esize);
         }
-- 
2.34.1


