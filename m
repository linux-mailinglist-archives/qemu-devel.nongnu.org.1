Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C274477D
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVv-0007WX-Tq; Sat, 01 Jul 2023 02:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVt-0007VQ-C6
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:21 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVr-0007Fi-OS
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:21 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so4286838e87.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194518; x=1690786518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vWBYX+czO68YBn+sruZR19OlwAnKUpeq8kLfDlKJ0tE=;
 b=XrH4ZjkZoWwK8x81L0/zS9Zwp4O3YrdCQKevSJtyHlxKpEOOSDdi18JMqm0I80YDoK
 mvphU9oIRoWrGMc/Fh+glo3cAg0DTJqsnTgtNP7HHu68c4QUdnHcDQYOTcqexmnIkRHp
 LumIOqQbJT87faMzZl4/JttzyeE1DOH+YFFlWP4ndS5PVZgADgJW4aeyHtluUvC0ctbZ
 qKqkw6SGIr9nM8gVVw5qEiOFROx2O14JIHs2/7Rp15jQsTUdp1yTPTbqxwJf7JmukdUp
 8nLrZZ63HZw9IIO+1p24dJ0xIsTT1hJETydQy5h38zq/AdpocxDSKtzbfE5b7rEYvnxT
 MfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194518; x=1690786518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWBYX+czO68YBn+sruZR19OlwAnKUpeq8kLfDlKJ0tE=;
 b=ZA4SUmky4d2aI3flVDCwrcJ/eWlkllQWDSEdRymHEDgJcWxNBnoXto0Py6dip7eglg
 VLyiXDd969KmhDiLKHJn2Hb8gdhyVFwkl0kA6jjXVMAdlw3At4ARd+uw4eFQJBo5zu0m
 qw3g9DLf/5hxdF2vpDnc4UlmBvRNJTwBRk34hDH3PXWNyUm/76YMaChuMkuMP6nYLWYI
 rO67LkvR+Cbf5RHAYTwH6EdZh/iqrXB0KOXxGiK4DjCHRCfkrs3Y7mIlCu8iNTktYke8
 AElSUvqmFGRPxQvIIY7U9W3jQj06j9IwkgVDE1gxnzk4L87f8brzr98b3hNYIeM49f0g
 5WVw==
X-Gm-Message-State: ABy/qLaEA55QNOds2K/n+oI+xL2u7EEOADRNM/unoyjeZlgGBDx3oHv7
 8Y8Dsmr8ejvZPQRsj7NrE8RkbwYBFFGbBEIl5uQalg==
X-Google-Smtp-Source: APBJJlF7VAlWOwuqKptLfiCxl/kYNsbbWs5q1az77BClaZHS2vXxwqsgmVPfL2dJduRtpS5iTTJ+2w==
X-Received: by 2002:a05:6512:1112:b0:4f8:7503:2041 with SMTP id
 l18-20020a056512111200b004f875032041mr4320265lfg.37.1688194518190; 
 Fri, 30 Jun 2023 23:55:18 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/11] target/arm: Use float64_to_int32_modulo for FJCVTZS
Date: Sat,  1 Jul 2023 08:55:07 +0200
Message-Id: <20230701065510.514743-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12a.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230527141910.1885950-5-richard.henderson@linaro.org>
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


