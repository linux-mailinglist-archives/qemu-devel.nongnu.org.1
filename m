Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9EF7A2DBC
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1C-0006A5-7k; Fri, 15 Sep 2023 23:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM19-00067y-Ly
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:47 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM17-000863-OZ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:47 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6903a452dfaso1851559b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835044; x=1695439844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ycQcefZNeHey9zxJ1yK/vT8id1YHpxVEoaMGMx6Ei9k=;
 b=cc/P920YE9487IpPi0SXAcRAMU6bWJz9qe9ywkoNUHikkhSFhWpSzoz0ovAhnCUSzr
 1gsJU6fQLJyHjlWYwnocttkDKOiXh9WabN6pOgq/mMP6WsPB/RsGDEsQBFmqmAU4k18N
 1AgH3a9m77qVsKeFcgLKcOd2wKbSlFiYNVp0H+2A0zeAicwrbQulb/ZeF+lkWjknDiXn
 CxA/14fVxQzgEhb0Z8VyAfu2cWgjreRJzhSCBV59yVv5n+ADxNk1JTKFE6js+LxdkLB3
 ZBQ9rdLv9UsUTjAeuJyBybT19WFrDPt/bqAmPj9ref3jyYEuZLF9NM7O5C7ZLJBmr6qf
 mDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835044; x=1695439844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycQcefZNeHey9zxJ1yK/vT8id1YHpxVEoaMGMx6Ei9k=;
 b=YD5PuQ2oDSufGFDFUhwV8qvX+SjSc/2hTJPWRV3zlaPgjL+YZ41wXMD+KSmUrz5tbu
 guC2Uca3avpPUCIH8jObQxMOyzc1tzZ43ORAME28cq43ZUv4vgzie+UHOLiR5RGfgdqa
 +13NeRnnVPayY1R+wl5bIeP6BQyhDLY9vUm30klFffrs2a0vrvgLvZ4xiHJ7nLJYbHl6
 KKEfuqIGlfxOb+P7UmqxGYhUqByqxrgnLNB1RskzOWBEGZBSTmzAbIcpjP/JyiNP1nx7
 z6B2B5SiZ2OAtbyYP4cw2sPoVJcHHVH1Jz6d46B/x8xNALjYkkRyhN1poh6v9sMKeNz1
 idPA==
X-Gm-Message-State: AOJu0YzSm0B+w+wrazi4XtVNrwpDu7ICGpqDws4mXHI2/wVMNnVXGind
 V4kw0z9b3pQVQjEzDm6pGWkjE+GxwzLCiTQdW4M=
X-Google-Smtp-Source: AGHT+IHXgoAZld5F6rCnyAdjq6z9ENlSELzKbBZ+QziCsVt7EkTncEnmHJKDjCrCfy8SeryK7DbHfw==
X-Received: by 2002:a05:6a00:1827:b0:68b:c2c7:a8ce with SMTP id
 y39-20020a056a00182700b0068bc2c7a8cemr3721063pfa.17.1694835044396; 
 Fri, 15 Sep 2023 20:30:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 34/39] fpu: Add conversions between bfloat16 and [u]int8
Date: Fri, 15 Sep 2023 20:30:06 -0700
Message-Id: <20230916033011.479144-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

We missed these functions when upstreaming the bfloat16 support.

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230531065458.2082-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h | 12 +++++++++
 fpu/softfloat.c         | 58 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index cd130564d8..eb64075b9c 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -366,6 +366,8 @@ float32 bfloat16_to_float32(bfloat16, float_status *status);
 bfloat16 float64_to_bfloat16(float64 a, float_status *status);
 float64 bfloat16_to_float64(bfloat16 a, float_status *status);
 
+int8_t bfloat16_to_int8_scalbn(bfloat16, FloatRoundMode,
+                               int, float_status *status);
 int16_t bfloat16_to_int16_scalbn(bfloat16, FloatRoundMode,
                                  int, float_status *status);
 int32_t bfloat16_to_int32_scalbn(bfloat16, FloatRoundMode,
@@ -373,14 +375,18 @@ int32_t bfloat16_to_int32_scalbn(bfloat16, FloatRoundMode,
 int64_t bfloat16_to_int64_scalbn(bfloat16, FloatRoundMode,
                                  int, float_status *status);
 
+int8_t bfloat16_to_int8(bfloat16, float_status *status);
 int16_t bfloat16_to_int16(bfloat16, float_status *status);
 int32_t bfloat16_to_int32(bfloat16, float_status *status);
 int64_t bfloat16_to_int64(bfloat16, float_status *status);
 
+int8_t bfloat16_to_int8_round_to_zero(bfloat16, float_status *status);
 int16_t bfloat16_to_int16_round_to_zero(bfloat16, float_status *status);
 int32_t bfloat16_to_int32_round_to_zero(bfloat16, float_status *status);
 int64_t bfloat16_to_int64_round_to_zero(bfloat16, float_status *status);
 
+uint8_t bfloat16_to_uint8_scalbn(bfloat16 a, FloatRoundMode,
+                                 int, float_status *status);
 uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode,
                                    int, float_status *status);
 uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode,
@@ -388,24 +394,30 @@ uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode,
 uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode,
                                    int, float_status *status);
 
+uint8_t bfloat16_to_uint8(bfloat16 a, float_status *status);
 uint16_t bfloat16_to_uint16(bfloat16 a, float_status *status);
 uint32_t bfloat16_to_uint32(bfloat16 a, float_status *status);
 uint64_t bfloat16_to_uint64(bfloat16 a, float_status *status);
 
+uint8_t bfloat16_to_uint8_round_to_zero(bfloat16 a, float_status *status);
 uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *status);
 uint32_t bfloat16_to_uint32_round_to_zero(bfloat16 a, float_status *status);
 uint64_t bfloat16_to_uint64_round_to_zero(bfloat16 a, float_status *status);
 
+bfloat16 int8_to_bfloat16_scalbn(int8_t a, int, float_status *status);
 bfloat16 int16_to_bfloat16_scalbn(int16_t a, int, float_status *status);
 bfloat16 int32_to_bfloat16_scalbn(int32_t a, int, float_status *status);
 bfloat16 int64_to_bfloat16_scalbn(int64_t a, int, float_status *status);
+bfloat16 uint8_to_bfloat16_scalbn(uint8_t a, int, float_status *status);
 bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int, float_status *status);
 bfloat16 uint32_to_bfloat16_scalbn(uint32_t a, int, float_status *status);
 bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int, float_status *status);
 
+bfloat16 int8_to_bfloat16(int8_t a, float_status *status);
 bfloat16 int16_to_bfloat16(int16_t a, float_status *status);
 bfloat16 int32_to_bfloat16(int32_t a, float_status *status);
 bfloat16 int64_to_bfloat16(int64_t a, float_status *status);
+bfloat16 uint8_to_bfloat16(uint8_t a, float_status *status);
 bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status);
 bfloat16 uint32_to_bfloat16(uint32_t a, float_status *status);
 bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0cc130ae9b..2a33967094 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3126,6 +3126,15 @@ int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
     return parts_float_to_sint(&p, rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
+int8_t bfloat16_to_int8_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
+                               float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    return parts_float_to_sint(&p, rmode, scale, INT8_MIN, INT8_MAX, s);
+}
+
 int16_t bfloat16_to_int16_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
                                  float_status *s)
 {
@@ -3392,6 +3401,11 @@ int64_t floatx80_to_int64_round_to_zero(floatx80 a, float_status *s)
     return floatx80_to_int64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+int8_t bfloat16_to_int8(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int8_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
 int16_t bfloat16_to_int16(bfloat16 a, float_status *s)
 {
     return bfloat16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
@@ -3407,6 +3421,11 @@ int64_t bfloat16_to_int64(bfloat16 a, float_status *s)
     return bfloat16_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
 }
 
+int8_t bfloat16_to_int8_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int8_scalbn(a, float_round_to_zero, 0, s);
+}
+
 int16_t bfloat16_to_int16_round_to_zero(bfloat16 a, float_status *s)
 {
     return bfloat16_to_int16_scalbn(a, float_round_to_zero, 0, s);
@@ -3534,6 +3553,15 @@ uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
     return parts_float_to_uint(&p, rmode, scale, UINT64_MAX, s);
 }
 
+uint8_t bfloat16_to_uint8_scalbn(bfloat16 a, FloatRoundMode rmode,
+                                 int scale, float_status *s)
+{
+    FloatParts64 p;
+
+    bfloat16_unpack_canonical(&p, a, s);
+    return parts_float_to_uint(&p, rmode, scale, UINT8_MAX, s);
+}
+
 uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode rmode,
                                    int scale, float_status *s)
 {
@@ -3759,6 +3787,11 @@ Int128 float128_to_uint128_round_to_zero(float128 a, float_status *s)
     return float128_to_uint128_scalbn(a, float_round_to_zero, 0, s);
 }
 
+uint8_t bfloat16_to_uint8(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint8_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
 uint16_t bfloat16_to_uint16(bfloat16 a, float_status *s)
 {
     return bfloat16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
@@ -3774,6 +3807,11 @@ uint64_t bfloat16_to_uint64(bfloat16 a, float_status *s)
     return bfloat16_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
 }
 
+uint8_t bfloat16_to_uint8_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint8_scalbn(a, float_round_to_zero, 0, s);
+}
+
 uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *s)
 {
     return bfloat16_to_uint16_scalbn(a, float_round_to_zero, 0, s);
@@ -3929,6 +3967,11 @@ bfloat16 int16_to_bfloat16_scalbn(int16_t a, int scale, float_status *status)
     return int64_to_bfloat16_scalbn(a, scale, status);
 }
 
+bfloat16 int8_to_bfloat16_scalbn(int8_t a, int scale, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, scale, status);
+}
+
 bfloat16 int64_to_bfloat16(int64_t a, float_status *status)
 {
     return int64_to_bfloat16_scalbn(a, 0, status);
@@ -3944,6 +3987,11 @@ bfloat16 int16_to_bfloat16(int16_t a, float_status *status)
     return int64_to_bfloat16_scalbn(a, 0, status);
 }
 
+bfloat16 int8_to_bfloat16(int8_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
+
 float128 int128_to_float128(Int128 a, float_status *status)
 {
     FloatParts128 p = { };
@@ -4139,6 +4187,11 @@ bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int scale, float_status *status)
     return uint64_to_bfloat16_scalbn(a, scale, status);
 }
 
+bfloat16 uint8_to_bfloat16_scalbn(uint8_t a, int scale, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, scale, status);
+}
+
 bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status)
 {
     return uint64_to_bfloat16_scalbn(a, 0, status);
@@ -4154,6 +4207,11 @@ bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status)
     return uint64_to_bfloat16_scalbn(a, 0, status);
 }
 
+bfloat16 uint8_to_bfloat16(uint8_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
 float128 uint64_to_float128(uint64_t a, float_status *status)
 {
     FloatParts128 p;
-- 
2.34.1


