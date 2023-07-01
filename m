Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B93F74477B
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVu-0007VX-1U; Sat, 01 Jul 2023 02:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVr-0007Ug-SN
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:19 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVp-0007F8-Ti
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:19 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fb94b1423eso4203701e87.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194516; x=1690786516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mRZecGlk4y92NOTZCV4Vh1o10DfSN55KRLfHTObE+8=;
 b=Zm3ru0H7iKnM6SFbZwuC+rTBF4XbB7/sZWASnJ2jd2XqVZiitjIkMWnllbInnUM+aB
 tq7dTa8YFBMFG7UwuXWZgyb5pm/I4K4aqFg50Ut6VLIfy6nIFVM7FZ7wDwQBikkv3ICQ
 AZXN8rnSSpotwko6OV0hmd+jyz2nMTIQ7bKDOeb2tkS0v4zfB/ySmll/wO9/BDLrukWQ
 FKKrFDHnMR25XTzrkGW6IIF3OmNfd1O33wixGrEwrWcP/7stmh9p+o5WWINeL2B1IvhU
 WVUHvfDsdMMNUeegIBwC860RD51pZ11oUBu2uhHdS7fqPh62UeLMpE/lGp4eX564MbTp
 2Wmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194516; x=1690786516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+mRZecGlk4y92NOTZCV4Vh1o10DfSN55KRLfHTObE+8=;
 b=UB+yv0FqPXYUF4eygEbREg94lw/CYmHnjsk5vdB14lEr9rst/odMpZLBZS0mC6lJxA
 /WMCWjk3/H4L3lJpDLgzjPSAy35O76Z9M1vRK4Pykg+VDybMQMmnIDyE8ASbgpYtdhXD
 kSxd0bA+vv25Yhb3iKSYaGryqN6WpqPrWUG0T0X0s23eAftwpWHf368AKkHEthu6Tnbj
 KqDLwEV4/kSL4Sgx+DC+zIjPSK9f8D2UoLFe0QmhbgPiqu319hUiAsTGWkUezK7U8fYM
 0a1YjKdGPdmKZN8W1adLHg6uec/SPZiGS2MzlpNCn2zVfrf9tdcgf5Yt2P/x3+ijMJ6e
 i3Lg==
X-Gm-Message-State: ABy/qLbKVnir0z0SzhNUoKoBizpdhTP854wkazXu2xRhG5eqy1hzcQ4j
 8RzDpEScfGJCk17BTpaxWzPQ3e73N0BXKb+DaxBClw==
X-Google-Smtp-Source: APBJJlEVEN2Dd+ckCRfDYhcbP/acQU2bFn6hPevrWky3O5IaRncm4cn9HdPrFL83paZAsMC3oiG4jQ==
X-Received: by 2002:a05:6512:3612:b0:4f8:70f8:d424 with SMTP id
 f18-20020a056512361200b004f870f8d424mr3206454lfs.65.1688194516086; 
 Fri, 30 Jun 2023 23:55:16 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 05/11] fpu: Add float64_to_int{32,64}_modulo
Date: Sat,  1 Jul 2023 08:55:04 +0200
Message-Id: <20230701065510.514743-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
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

Reviewed-by: Christoph Muellner <christoph.muellner@vrull.eu>
Tested-by: Christoph Muellner <christoph.muellner@vrull.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230527141910.1885950-2-richard.henderson@linaro.org>
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
index 42e6c188b4..0cc130ae9b 100644
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


