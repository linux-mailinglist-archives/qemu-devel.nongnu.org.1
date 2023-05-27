Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C99713525
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ulJ-0007o1-PC; Sat, 27 May 2023 10:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulI-0007ng-7g
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:16 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2ulG-0002GC-Id
 for qemu-devel@nongnu.org; Sat, 27 May 2023 10:19:16 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-256481ce1b5so430175a91.1
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685197153; x=1687789153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DDbFBgISj2NEyBK0D5B4JQEN40ApYglGb4D217KNjVU=;
 b=DCD0ru6fPCyggh9ahSI/GdOAxD46vY7QCkaJACsvPwC5QppfTrz5GjRmEoVo40edU2
 YfFMChM3UlkwHHwVbe/cxOEGuF7zDpLGBpXNgnyLukz1bziN0QGU9JgOgk8AaAjFhkAN
 Jd8QKLUlOB7jzhi9pomUP3GFyk0taoNzA3fwUOEWSWPE+LKGiLmqd4LKZu6DeVo/qCYk
 +n4B/ukz83UbjzBfR8J67/7h0qE59QuM3yHsrm6+h8TgYdcHbljEXmXkkyYCkq6tFyPK
 3Az0YZjXRlWfXOzJuGDGQa3s6Sp58iyL2cXDKqwZklHw9aW1idZvsuBO09UQ68So09i5
 1WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685197153; x=1687789153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DDbFBgISj2NEyBK0D5B4JQEN40ApYglGb4D217KNjVU=;
 b=gCzNUO+FEqkYBvindUPOIGWj7jSOo2lR6tctgOo2oDixeWMxGr9NRrlbd6DEmywiJz
 kdrpFQBx2q8+zdj5cLrynNFi8omDKyMQ60N/Hi+PEz6MwoT9kIy30g7b1EWHaobWH+W5
 DUpV5lw0+aN8C05428/yvzL9WpA7md5m681xzh50eH25D0YhoEl/smoUBYVrG/PFLUdR
 Nb6rtK0qGX1tjfXbenURz20jagIJjNhS3+pD8FvjH8u7hUvvo1jWutc9scTurIx7jaeN
 Qj9lsJUpQqf8pSxiz88vPUmW/LI0UXEVUIkm0nUwrB7Dy5ywsgzZzl6B4lmUQa6kNjSa
 vUWw==
X-Gm-Message-State: AC+VfDxC7/TYT9Yz2M+ydftBJSlyXm7yUgqMtRbRS5raO0h3rVc8txV7
 UFEtczhUAkJSxcgf5ZK6bj/T/IQ2AN58V3RQ4BM=
X-Google-Smtp-Source: ACHHUZ4Ek5Sd0iNyaOE1tVN9NY9mSUIzq3wIFvBS50nWQExksYN11+tA5vcaTewmS3C4wOm401kyrg==
X-Received: by 2002:a17:902:e884:b0:1ae:1237:874d with SMTP id
 w4-20020a170902e88400b001ae1237874dmr5890752plg.69.1685197152924; 
 Sat, 27 May 2023 07:19:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:be31:c162:a57e:7431])
 by smtp.gmail.com with ESMTPSA id
 j20-20020a170902759400b001a988a71617sm1258992pll.192.2023.05.27.07.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 07:19:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu,
	alex.bennee@linaro.org
Subject: [PATCH 1/4] fpu: Add float64_to_int{32,64}_modulo
Date: Sat, 27 May 2023 07:19:07 -0700
Message-Id: <20230527141910.1885950-2-richard.henderson@linaro.org>
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

Add versions of float64_to_int* which do not saturate the result.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h   |  3 ++
 fpu/softfloat.c           | 31 ++++++++++++++++
 fpu/softfloat-parts.c.inc | 78 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3dcf20e3a2..cd130564d8 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -751,6 +751,9 @@ int16_t float64_to_int16_round_to_zero(float64, float_status *status);
 int32_t float64_to_int32_round_to_zero(float64, float_status *status);
 int64_t float64_to_int64_round_to_zero(float64, float_status *status);
 
+int32_t float64_to_int32_modulo(float64, FloatRoundMode, float_status *status);
+int64_t float64_to_int64_modulo(float64, FloatRoundMode, float_status *status);
+
 uint16_t float64_to_uint16_scalbn(float64, FloatRoundMode, int, float_status *);
 uint32_t float64_to_uint32_scalbn(float64, FloatRoundMode, int, float_status *);
 uint64_t float64_to_uint64_scalbn(float64, FloatRoundMode, int, float_status *);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 108f9cb224..c05819afcd 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -852,11 +852,24 @@ static uint64_t parts128_float_to_uint(FloatParts128 *p, FloatRoundMode rmode,
 #define parts_float_to_uint(P, R, Z, M, S) \
     PARTS_GENERIC_64_128(float_to_uint, P)(P, R, Z, M, S)
 
+static int64_t parts64_float_to_sint_modulo(FloatParts64 *p,
+                                            FloatRoundMode rmode,
+                                            int bitsm1, float_status *s);
+static int64_t parts128_float_to_sint_modulo(FloatParts128 *p,
+                                             FloatRoundMode rmode,
+                                             int bitsm1, float_status *s);
+
+#define parts_float_to_sint_modulo(P, R, M, S) \
+    PARTS_GENERIC_64_128(float_to_sint_modulo, P)(P, R, M, S)
+
 static void parts64_sint_to_float(FloatParts64 *p, int64_t a,
                                   int scale, float_status *s);
 static void parts128_sint_to_float(FloatParts128 *p, int64_t a,
                                    int scale, float_status *s);
 
+#define parts_float_to_sint(P, R, Z, MN, MX, S) \
+    PARTS_GENERIC_64_128(float_to_sint, P)(P, R, Z, MN, MX, S)
+
 #define parts_sint_to_float(P, I, Z, S) \
     PARTS_GENERIC_64_128(sint_to_float, P)(P, I, Z, S)
 
@@ -3409,6 +3422,24 @@ int64_t bfloat16_to_int64_round_to_zero(bfloat16 a, float_status *s)
     return bfloat16_to_int64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+int32_t float64_to_int32_modulo(float64 a, FloatRoundMode rmode,
+                                float_status *s)
+{
+    FloatParts64 p;
+
+    float64_unpack_canonical(&p, a, s);
+    return parts_float_to_sint_modulo(&p, rmode, 31, s);
+}
+
+int64_t float64_to_int64_modulo(float64 a, FloatRoundMode rmode,
+                                float_status *s)
+{
+    FloatParts64 p;
+
+    float64_unpack_canonical(&p, a, s);
+    return parts_float_to_sint_modulo(&p, rmode, 63, s);
+}
+
 /*
  * Floating-point to unsigned integer conversions
  */
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 247400031c..527e15e6ab 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -1181,6 +1181,84 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
     return r;
 }
 
+/*
+ * Like partsN(float_to_sint), except do not saturate the result.
+ * Instead, return the rounded unbounded precision two's compliment result,
+ * modulo 2**(bitsm1 + 1).
+ */
+static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
+                                            FloatRoundMode rmode,
+                                            int bitsm1, float_status *s)
+{
+    int flags = 0;
+    uint64_t r;
+    bool overflow = false;
+
+    switch (p->cls) {
+    case float_class_snan:
+        flags |= float_flag_invalid_snan;
+        /* fall through */
+    case float_class_qnan:
+        flags |= float_flag_invalid;
+        r = 0;
+        break;
+
+    case float_class_inf:
+        overflow = true;
+        r = 0;
+        break;
+
+    case float_class_zero:
+        return 0;
+
+    case float_class_normal:
+        /* TODO: N - 2 is frac_size for rounding; could use input fmt. */
+        if (parts_round_to_int_normal(p, rmode, 0, N - 2)) {
+            flags = float_flag_inexact;
+        }
+
+        if (p->exp <= DECOMPOSED_BINARY_POINT) {
+            /*
+             * Because we rounded to integral, and exp < 64,
+             * we know frac_low is zero.
+             */
+            r = p->frac_hi >> (DECOMPOSED_BINARY_POINT - p->exp);
+            if (p->exp < bitsm1) {
+                /* Result in range. */
+            } else if (p->exp == bitsm1) {
+                /* The only in-range value is INT_MIN. */
+                overflow = !p->sign || p->frac_hi != DECOMPOSED_IMPLICIT_BIT;
+            } else {
+                overflow = true;
+            }
+        } else {
+            /* Overflow, but there might still be bits to return. */
+            int shl = p->exp - DECOMPOSED_BINARY_POINT;
+            if (shl < N) {
+                frac_shl(p, shl);
+                r = p->frac_hi;
+            } else {
+                r = 0;
+            }
+            overflow = true;
+        }
+
+        if (p->sign) {
+            r = -r;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    if (overflow) {
+        flags = float_flag_invalid | float_flag_invalid_cvti;
+    }
+    float_raise(flags, s);
+    return r;
+}
+
 /*
  * Integer to float conversions
  *
-- 
2.34.1


