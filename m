Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0AE713524
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ulO-0007p5-1b; Sat, 27 May 2023 10:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulJ-0007oN-ID
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:17 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulH-0002GT-Ls
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-52cb8e5e9f5so1224644a12.0
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 07:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685197154; x=1687789154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+CMDJ9rmMCJWN+tP1xmh2RBmH8yQeZ+BBhiYDZHw0M=;
 b=XVTQgssaL6/74jC50WNAmA023RVUrK/7NYajgEtuuVpcUiPtcI4wLpAJi9z1CGn9Fr
 MZXOMN8yCGv4uNeVTpVAjS2JovywqO6UGPVskH6iH8noEsxUuNFzAWj0AME9iTjsSwNQ
 JABKtnl/P/odVrQUwRcN+2dN5NGWlDAHYqSvktmiFrBibxK+AmW8yUdbw3ppLMYeAi5F
 CLIWLIGXDuYJlT1qKmGNELI61T5dI0JBFiTHJPzUOWIrjsQDqrfI1fX/eyaDee6e+7Xh
 NVx/1VKml/fgNK9RzROi7EGHoFVs6SGaGfY6RK8ZRMsb2l5ZLGaKWrdyeBvnfe1EZBDb
 ingw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685197154; x=1687789154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+CMDJ9rmMCJWN+tP1xmh2RBmH8yQeZ+BBhiYDZHw0M=;
 b=Bigr2ZdraL0ESl+McLpwmpQHQzDkRZZqxiO2pR0ijszfSt5TFoIaMGkt4LupylQNV9
 DGH0O6N7NjbEygQ3coyqIvUMEbSUd8GbukD4fy0hfK7oCngarJ9bDklV8piLgwuw82Ml
 Rep5mNdFqxZhUaaMDZdMxku+pFREGRXqITFwntfcN/C1TrOPa4KMQt+WE/zJxA/nWqX7
 BU3QwGI3sbGF37W6PjIBflOnlpvf9HqLUQUmnfdlaMDl0D0Lftk/dJcwY3Z5W3P0aIjh
 QQ/SoL+XBH5eho7NDjrhrzGx11OH9/g6g9iUFy/hUf/MmKZ4mEDdGbof8HwegAwzn4sQ
 d2yg==
X-Gm-Message-State: AC+VfDwBWxE4/nkzhdNnfc/5t8pxgi3Rnl88zFhZ2P29XDBn5oFrtvUN
 zMTZXzdRHAsptNyxL+AXnzjMd5TjrpyYq+hOjBA=
X-Google-Smtp-Source: ACHHUZ5N09oDA2RVtWir1JRxC+ljpnnN/NeLl0avt0ln6jxCSTWvdh0zET6YpcZjzZkDVDbW5QmeSw==
X-Received: by 2002:a17:902:d4ce:b0:1b0:34d5:1bc7 with SMTP id
 o14-20020a170902d4ce00b001b034d51bc7mr204687plg.20.1685197154469; 
 Sat, 27 May 2023 07:19:14 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:be31:c162:a57e:7431])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a170902759400b001a988a71617sm1258992pll.192.2023.05.27.07.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 07:19:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu,
	alex.bennee@linaro.org
Subject: [PATCH 3/4] target/alpha: Use float64_to_int64_modulo for CVTTQ
Date: Sat, 27 May 2023 07:19:09 -0700
Message-Id: <20230527141910.1885950-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527141910.1885950-1-richard.henderson@linaro.org>
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

For the most part we can use the new generic routine,
though exceptions need some post-processing to sort
invalid from integer overflow.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/fpu_helper.c | 85 +++++++++------------------------------
 1 file changed, 18 insertions(+), 67 deletions(-)

diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
index 3ff8bb456d..63d9e9ce39 100644
--- a/target/alpha/fpu_helper.c
+++ b/target/alpha/fpu_helper.c
@@ -453,78 +453,29 @@ uint64_t helper_cvtqs(CPUAlphaState *env, uint64_t a)
 
 static uint64_t do_cvttq(CPUAlphaState *env, uint64_t a, int roundmode)
 {
-    uint64_t frac, ret = 0;
-    uint32_t exp, sign, exc = 0;
-    int shift;
+    float64 fa;
+    int64_t ret;
+    uint32_t exc;
 
-    sign = (a >> 63);
-    exp = (uint32_t)(a >> 52) & 0x7ff;
-    frac = a & 0xfffffffffffffull;
+    fa = t_to_float64(a);
+    ret = float64_to_int64_modulo(fa, roundmode, &FP_STATUS);
 
-    if (exp == 0) {
-        if (unlikely(frac != 0) && !env->fp_status.flush_inputs_to_zero) {
-            goto do_underflow;
-        }
-    } else if (exp == 0x7ff) {
-        exc = FPCR_INV;
-    } else {
-        /* Restore implicit bit.  */
-        frac |= 0x10000000000000ull;
+    exc = get_float_exception_flags(&FP_STATUS);
+    if (unlikely(exc)) {
+        set_float_exception_flags(0, &FP_STATUS);
 
-        shift = exp - 1023 - 52;
-        if (shift >= 0) {
-            /* In this case the number is so large that we must shift
-               the fraction left.  There is no rounding to do.  */
-            if (shift < 64) {
-                ret = frac << shift;
-            }
-            /* Check for overflow.  Note the special case of -0x1p63.  */
-            if (shift >= 11 && a != 0xC3E0000000000000ull) {
+        /* We need to massage the resulting exceptions. */
+        if (exc & float_flag_invalid_cvti) {
+            /* Overflow, either normal or infinity. */
+            if (float64_is_infinity(fa)) {
+                exc = FPCR_INV;
+            } else {
                 exc = FPCR_IOV | FPCR_INE;
             }
-        } else {
-            uint64_t round;
-
-            /* In this case the number is smaller than the fraction as
-               represented by the 52 bit number.  Here we must think
-               about rounding the result.  Handle this by shifting the
-               fractional part of the number into the high bits of ROUND.
-               This will let us efficiently handle round-to-nearest.  */
-            shift = -shift;
-            if (shift < 63) {
-                ret = frac >> shift;
-                round = frac << (64 - shift);
-            } else {
-                /* The exponent is so small we shift out everything.
-                   Leave a sticky bit for proper rounding below.  */
-            do_underflow:
-                round = 1;
-            }
-
-            if (round) {
-                exc = FPCR_INE;
-                switch (roundmode) {
-                case float_round_nearest_even:
-                    if (round == (1ull << 63)) {
-                        /* Fraction is exactly 0.5; round to even.  */
-                        ret += (ret & 1);
-                    } else if (round > (1ull << 63)) {
-                        ret += 1;
-                    }
-                    break;
-                case float_round_to_zero:
-                    break;
-                case float_round_up:
-                    ret += 1 - sign;
-                    break;
-                case float_round_down:
-                    ret += sign;
-                    break;
-                }
-            }
-        }
-        if (sign) {
-            ret = -ret;
+        } else if (exc & float_flag_invalid) {
+            exc = FPCR_INV;
+        } else if (exc & float_flag_inexact) {
+            exc = FPCR_INE;
         }
     }
     env->error_code = exc;
-- 
2.34.1


