Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F82744780
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVv-0007WD-6n; Sat, 01 Jul 2023 02:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVs-0007VI-UP
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:20 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVr-0007FT-4p
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:20 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f875b267d9so4333266e87.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194517; x=1690786517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zw6bQp1/aPCTHVB9O6SX0clKjc4ibzsmP+nMY0H68OE=;
 b=B46m4tOq3vehnqsffCn+XtiAB44MrpLtdxBEZAvVhNW3xzh0GcojTw7OVb8yFW2c7Q
 IuAgaNfTAU7hl2OQfRnFenu0Adf7UO7EDI8tinVZn8PEXnIOcX+xXNpSaKAKgg+wT6Xt
 fYwbSgnWvPTn8a28RTEhL16Wbcjldu5t4sI5I2LjOT78QK/i3JRr5LbLBC4/nbMo6hso
 wEfB1hgunEvvvWg9OKrDgGXYMxa2gCQi4Q5FqxWlqZ5JKot6Bk8gN5d7N1WK1eP46F7H
 Wjxnw0ofcsVB7ClZVYcwqisg2NT0XN0Y9EqjWv+h+i1gIhn2Vt8S9TXrjQCfAAv+9L2c
 p9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194517; x=1690786517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zw6bQp1/aPCTHVB9O6SX0clKjc4ibzsmP+nMY0H68OE=;
 b=AkPlzvwMdC1Cukdljpb8LXehh3nW9xZ3jUZ3Eo2eR787BWHH7Z9XPKNc+HK5DMYERd
 SR7vTU9LJnOB0B7uJvnD+o3TDIWuB8bVTskIp+5V/N63Mm/laPZDG9kCdLwyLPBQfycR
 kPmhmXERKnHHli9DPDZ6ztdMhRaHtbWFvbS3FUlV3WM09A3YXH77gGpr13pRnz7upLJi
 Pk0cOSI6xQQwOkoBv9wD58YcPbcgXF+oCNUzCpa7zjjDZr19SOcdQLVtYas4ImyVqE+6
 F6lVY0YsPaJPgDat8pmll3+9QBr381yksO8B7v+3nDhIbXTHDdq4PRJC6HzSJB2oJ0se
 ecQQ==
X-Gm-Message-State: ABy/qLa3KvyOGkYWdBYSFlAiQqYxEHqqD2oBRUeelWR0M6H0vhQ2/dpK
 WJSpXA8McRbUxXVHnLyZqbm+y/edH3/BhB4re9fczQ==
X-Google-Smtp-Source: APBJJlGJ7B4eKjV10mbKKPD2M+c1GxyOriCmCCq0rjBzEmaA/WxBpW8n5ewp4lwvny+3qDWaKXpktQ==
X-Received: by 2002:a05:6512:368b:b0:4f7:6453:f3f1 with SMTP id
 d11-20020a056512368b00b004f76453f3f1mr3228476lfs.15.1688194517537; 
 Fri, 30 Jun 2023 23:55:17 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/11] target/alpha: Use float64_to_int64_modulo for CVTTQ
Date: Sat,  1 Jul 2023 08:55:06 +0200
Message-Id: <20230701065510.514743-8-richard.henderson@linaro.org>
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

For the most part we can use the new generic routine,
though exceptions need some post-processing to sort
invalid from integer overflow.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230527141910.1885950-4-richard.henderson@linaro.org>
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


