Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A77DC769938
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTgZ-0005a1-39; Mon, 31 Jul 2023 10:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgS-0005WZ-KE
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgQ-0007eb-CQ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe2048c910so9789015e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812936; x=1691417736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=STtOVksr63dEkZ6wAYpplxRzfdJwT/NJYMmDJPe/tsc=;
 b=RJcIdCamjcgBEAeVlxYWD5La8/Z/AbzTtdhYk+pkGqMUv0uURpf3huWY/cBt0RXN7p
 2EKT0ClB4sWqzqwji4pluVQFEk8qmPbGyWl8oz9QDijka+vowSzIuKPFTGTd8AjEFbjN
 zNsAnjVbFc9fRY7hI+mkQFbNoF/vBZbpU7ogrv0tHaQ8b9M5xN/s8fNvV0VWOizi605L
 Qf0ucEO1WK5Xow24bDOaaX+wooSnQ4rtVtg/7VsgVGMA7ygTjrqCegL02nB7hn0N31XY
 XUjNRpN4p0xt7qgZ1U5ruOGvVduLJtnSTzbmBdLU2RM17L4UN82jpmosJjTKw5v+tWOZ
 SU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812936; x=1691417736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=STtOVksr63dEkZ6wAYpplxRzfdJwT/NJYMmDJPe/tsc=;
 b=SG/inmGSQWxwfaYiyzjcLHh6PiINhSRcly5/hSBZSpuTyAEkRizUWbJ8/m+HsB/X3w
 8CFqxJPmpVvHa8PHe3T6y1bOHlm8ih1ZC43Q3JIAojPjNLYAmW+RTYQ0WGf3gV3JVChS
 Uo5qIPW4EbHxYzLFL2Y584Y01TohcLSs6KTgNJL68hkEYpSUlRgP5GWJ+2xkraW3lFnp
 YlZLLG7ctBcFm1PQYF2f0lHKp3i6NJzfZOPrm54oVicRpOeO8Z4dOiwgk/K/gJI3QQzJ
 BEbH8AliNJKqAyZQf2JD5FgZyn04Ou8AOP28CPrnF6Mhc+pkPCtpmyDnbyJLnM7uXzbz
 rPpw==
X-Gm-Message-State: ABy/qLYcjaqiFdN+018IGBOUnBx6HfVx+QjwE8A1bovKNYZRyeAzQZQ1
 jYq+aV+xaQYmv/k6eGwwW4XqN1hFckrZp0mJsx0=
X-Google-Smtp-Source: APBJJlFevLDU0L3XKmo7F/9Pe9greEQMqor5idJpCT3BxSvaNtUCX/ciENURBaKYG/AphBl+3JpeYQ==
X-Received: by 2002:a05:600c:2a4e:b0:3f9:b30f:a013 with SMTP id
 x14-20020a05600c2a4e00b003f9b30fa013mr76243wme.6.1690812936651; 
 Mon, 31 Jul 2023 07:15:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11450675wmz.29.2023.07.31.07.15.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 07:15:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/6] target/arm: Avoid writing to constant TCGv in trans_CSEL()
Date: Mon, 31 Jul 2023 15:15:30 +0100
Message-Id: <20230731141533.3303894-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731141533.3303894-1-peter.maydell@linaro.org>
References: <20230731141533.3303894-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In commit 0b188ea05acb5 we changed the implementation of
trans_CSEL() to use tcg_constant_i32(). However, this change
was incorrect, because the implementation of the function
sets up the TCGv_i32 rn and rm to be either zero or else
a TCG temp created in load_reg(), and these TCG temps are
then in both cases written to by the emitted TCG ops.
The result is that we hit a TCG assertion:

qemu-system-arm: ../../tcg/tcg.c:4455: tcg_reg_alloc_mov: Assertion `!temp_readonly(ots)' failed.

(or on a non-debug build, just produce a garbage result)

Adjust the code so that rn and rm are always writeable
temporaries whether the instruction is using the special
case "0" or a normal register as input.

Cc: qemu-stable@nongnu.org
Fixes: 0b188ea05acb5 ("target/arm: Use tcg_constant in trans_CSEL")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230727103906.2641264-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 13c88ba1b9f..b71ac2d0d53 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -8799,7 +8799,7 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
 /* v8.1M CSEL/CSINC/CSNEG/CSINV */
 static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
 {
-    TCGv_i32 rn, rm, zero;
+    TCGv_i32 rn, rm;
     DisasCompare c;
 
     if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
@@ -8817,16 +8817,17 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     }
 
     /* In this insn input reg fields of 0b1111 mean "zero", not "PC" */
-    zero = tcg_constant_i32(0);
+    rn = tcg_temp_new_i32();
+    rm = tcg_temp_new_i32();
     if (a->rn == 15) {
-        rn = zero;
+        tcg_gen_movi_i32(rn, 0);
     } else {
-        rn = load_reg(s, a->rn);
+        load_reg_var(s, rn, a->rn);
     }
     if (a->rm == 15) {
-        rm = zero;
+        tcg_gen_movi_i32(rm, 0);
     } else {
-        rm = load_reg(s, a->rm);
+        load_reg_var(s, rm, a->rm);
     }
 
     switch (a->op) {
@@ -8846,7 +8847,7 @@ static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
     }
 
     arm_test_cc(&c, a->fcond);
-    tcg_gen_movcond_i32(c.cond, rn, c.value, zero, rn, rm);
+    tcg_gen_movcond_i32(c.cond, rn, c.value, tcg_constant_i32(0), rn, rm);
 
     store_reg(s, a->rd, rn);
     return true;
-- 
2.34.1


