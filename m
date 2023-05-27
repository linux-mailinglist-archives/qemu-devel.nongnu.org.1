Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F07713526
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ulO-0007pC-L9; Sat, 27 May 2023 10:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulK-0007og-EM
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:19 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulI-0002Gg-Ng
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:18 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2564b0921f1so304152a91.3
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685197155; x=1687789155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Ci3Rw1Bwfq/vRMH6eDy4QVIqFnQy7Z61D8fU9qGASA=;
 b=opHnNvlK67U5GEiwnV5AJmHAEhCy0zfcc8EfjaiERh3+sewTukAAu828PJeaJ4fUxw
 zYV09YDgXxUQ8sQ68bJqoU/ytHJiz7XUD+fNQu4245Xm15T9fEO7UuLFlEBgrtCRc4Ml
 mHEpKvSAOR+QMW1DxWV69nI7PkFrknE8+0uIflibGmvKZG/zKoowRBA227W6C6kETtbq
 VU9EbQN6MqMwJV/2XheekZYK/+ktVpay+TANl0mMHsxxskaQwE1etyc6WwjKViAzOUJK
 GWYJopMdXXeajGBQ+pV+vLfx3go3BSk+l/xqyHGEHnUCIGPuMEQbiGZneB1CW3Ldt/kH
 NPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685197155; x=1687789155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Ci3Rw1Bwfq/vRMH6eDy4QVIqFnQy7Z61D8fU9qGASA=;
 b=afVjlmsWSHyoVPKL3gYde4XxUvLonOWnIQvhRxuFFE7E/zQOMEeyDRy6M+9YJGA2r/
 hfCzCw77mcrfH+ekXukJ2pK7O6NxYOOsqFoex8qfJTPq7yRuVHcj+XMHme7MvtAb5Th+
 RyxRnt82y+4hyHMYL2tSliBhrfnAH8MAFR6LEILXjESp/1EdCxkzx7OfPlrSXcq+70AM
 cUNL6XRRStyoVD2okQnMVGfaBNnaW4Q6lvqoMJHSk7FES7ippCjDAHAn6YIIqiBaNRhg
 Srqwd6cNuthEPpOXuO10FNaD3S9i+wK4h4acofbUnodx0y0wuDmWrV9xISktJCB3E2Q/
 sGmg==
X-Gm-Message-State: AC+VfDzi7GS8MxBtPD4TXcdmPHAYbipdJ77TmjZoOeCgqnPqhbUywyY/
 Kl8PkeHWs1LawdnpKE90r+9orEOw5YeHBailRaY=
X-Google-Smtp-Source: ACHHUZ5uVfZGpOYcdjj130ClUPZFaEU0SyYCoV4YKvtTuk2mB+A+19ET2W3v5GyBE3T10j+8BaKfYA==
X-Received: by 2002:a17:902:ea0b:b0:1af:b3b6:4947 with SMTP id
 s11-20020a170902ea0b00b001afb3b64947mr7767551plg.24.1685197155272; 
 Sat, 27 May 2023 07:19:15 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:be31:c162:a57e:7431])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a170902759400b001a988a71617sm1258992pll.192.2023.05.27.07.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 07:19:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu,
	alex.bennee@linaro.org
Subject: [PATCH 4/4] target/arm: Use float64_to_int32_modulo for FJCVTZS
Date: Sat, 27 May 2023 07:19:10 -0700
Message-Id: <20230527141910.1885950-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527141910.1885950-1-richard.henderson@linaro.org>
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

The standard floating point results are provided by the generic routine.
We only need handle the extra Z flag result afterward.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 71 +++++++----------------------------------
 1 file changed, 12 insertions(+), 59 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 36906db8e0..789bba36cc 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1120,68 +1120,21 @@ const FloatRoundMode arm_rmode_to_sf_map[] = {
 uint64_t HELPER(fjcvtzs)(float64 value, void *vstatus)
 {
     float_status *status = vstatus;
-    uint32_t exp, sign;
-    uint64_t frac;
-    uint32_t inexact = 1; /* !Z */
+    uint32_t inexact, frac;
+    uint32_t e_old, e_new;
 
-    sign = extract64(value, 63, 1);
-    exp = extract64(value, 52, 11);
-    frac = extract64(value, 0, 52);
+    e_old = get_float_exception_flags(status);
+    set_float_exception_flags(0, status);
+    frac = float64_to_int32_modulo(value, float_round_to_zero, status);
+    e_new = get_float_exception_flags(status);
+    set_float_exception_flags(e_old | e_new, status);
 
-    if (exp == 0) {
-        /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript.  */
-        inexact = sign;
-        if (frac != 0) {
-            if (status->flush_inputs_to_zero) {
-                float_raise(float_flag_input_denormal, status);
-            } else {
-                float_raise(float_flag_inexact, status);
-                inexact = 1;
-            }
-        }
-        frac = 0;
-    } else if (exp == 0x7ff) {
-        /* This operation raises Invalid for both NaN and overflow (Inf).  */
-        float_raise(float_flag_invalid, status);
-        frac = 0;
+    if (value == float64_chs(float64_zero)) {
+        /* While not inexact for IEEE FP, -0.0 is inexact for JavaScript. */
+        inexact = 1;
     } else {
-        int true_exp = exp - 1023;
-        int shift = true_exp - 52;
-
-        /* Restore implicit bit.  */
-        frac |= 1ull << 52;
-
-        /* Shift the fraction into place.  */
-        if (shift >= 0) {
-            /* The number is so large we must shift the fraction left.  */
-            if (shift >= 64) {
-                /* The fraction is shifted out entirely.  */
-                frac = 0;
-            } else {
-                frac <<= shift;
-            }
-        } else if (shift > -64) {
-            /* Normal case -- shift right and notice if bits shift out.  */
-            inexact = (frac << (64 + shift)) != 0;
-            frac >>= -shift;
-        } else {
-            /* The fraction is shifted out entirely.  */
-            frac = 0;
-        }
-
-        /* Notice overflow or inexact exceptions.  */
-        if (true_exp > 31 || frac > (sign ? 0x80000000ull : 0x7fffffff)) {
-            /* Overflow, for which this operation raises invalid.  */
-            float_raise(float_flag_invalid, status);
-            inexact = 1;
-        } else if (inexact) {
-            float_raise(float_flag_inexact, status);
-        }
-
-        /* Honor the sign.  */
-        if (sign) {
-            frac = -frac;
-        }
+        /* Normal inexact or overflow or NaN */
+        inexact = e_new & (float_flag_inexact | float_flag_invalid);
     }
 
     /* Pack the result and the env->ZF representation of Z together.  */
-- 
2.34.1


