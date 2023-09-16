Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C627A2DA9
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:31:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM1B-00069s-WF; Fri, 15 Sep 2023 23:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM1A-000699-8p
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM18-00086I-G5
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fbbea0dfeso2356465b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835045; x=1695439845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yXBn3psA6RGuVIWmV+RXep3irMbo8iT6cJNTGZjdHU=;
 b=LO1xghAKSt1iT3xzUkyH23dNxKxMeKlrGxziMur81I1RIRmg0n/GMv5zRolr1rCyni
 eHY3qr9WWVyjuUQVMXpnaJwqxPakqHHpb+k9uuP1S3PgRMx8czM+gyhrjTeLrlJiZklX
 qgqPinBBytSHtYGpY5Cuq1Sky4127cXLKarZyXTQABpyXJUZ6Gnn+ZP1VfQMrraKEFzJ
 KEKOiYdJ1riMqlDgxFdcdx+9LxZdZwRLWMJyQUVHPIi1DQtWxpsiVjzvVQdDU6MIHohm
 XO9RtY/jyr8dqjq6pNjTly5NrQXt8qBwv22gPUY4Aldh9kap+DDYqmQl0609y3R6fkx+
 UcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835045; x=1695439845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yXBn3psA6RGuVIWmV+RXep3irMbo8iT6cJNTGZjdHU=;
 b=jIy0YbhsYgHSj6E5A/k1Yv/znSoH6W1F/tUndHfUN4hJ/LOULyQarGFdlqhwYW+xUj
 hC3MgTan7Nvjm7vgmuj+qH9XkCyfefudLFLuJYtyFUNyYKyUwHiJzm/s9UYH4Bmo2jk6
 ZV2R6hHz+Nkqplh9V9OU0zQ3/9Zviuh9qYomTUiI64arAu/cSd4JdLmsws8SftcyuHcW
 bPjWuXFA4grujvg1kKEYGpvpzE5G3hhqY9ZRYxrqARV6Xtx8FN17fDq5pcf/4hzuxIj/
 T5E7JRV+GnMFLFrIZf7OSRUjvkc3EVmc9Mitkamv1dgyi6Io7AzaqeE7AEc+XDthFmFr
 jEAA==
X-Gm-Message-State: AOJu0YwBnhzyZUmRRYdQzYX4sqw+z4lU6f++n0Df9gLxZd6G2dVmOV6X
 3XIdHp30kAFTyDE3fJert//4UajVy2sdQhB2PlM=
X-Google-Smtp-Source: AGHT+IGp2bhs4x81T1BVRELnkvDJ3PurvmiCmUXu3BH4yddHBSbMDoKsfWRx2cWK1PKRBNk7N15OmQ==
X-Received: by 2002:a05:6a00:cd1:b0:68a:4261:ab7f with SMTP id
 b17-20020a056a000cd100b0068a4261ab7fmr3839811pfv.31.1694835045218; 
 Fri, 15 Sep 2023 20:30:45 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/39] fpu: Handle m68k extended precision denormals properly
Date: Fri, 15 Sep 2023 20:30:07 -0700
Message-Id: <20230916033011.479144-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Motorola treats denormals with explicit integer bit set as
having unbiased exponent 0, unlike Intel which treats it as
having unbiased exponent 1 (more like all other IEEE formats
that have no explicit integer bit).

Add a flag on FloatFmt to differentiate the behaviour.

Reported-by: Keith Packard <keithp@keithp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                |  9 +++++-
 tests/tcg/m68k/denormal.c      | 53 ++++++++++++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc      |  7 +++--
 tests/tcg/m68k/Makefile.target |  2 +-
 4 files changed, 66 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/m68k/denormal.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2a33967094..027a8e576d 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -517,6 +517,7 @@ typedef struct {
  *   round_mask: bits below lsb which must be rounded
  * The following optional modifiers are available:
  *   arm_althp: handle ARM Alternative Half Precision
+ *   m68k_denormal: explicit integer bit for extended precision may be 1
  */
 typedef struct {
     int exp_size;
@@ -526,6 +527,7 @@ typedef struct {
     int frac_size;
     int frac_shift;
     bool arm_althp;
+    bool m68k_denormal;
     uint64_t round_mask;
 } FloatFmt;
 
@@ -576,7 +578,12 @@ static const FloatFmt float128_params = {
 static const FloatFmt floatx80_params[3] = {
     [floatx80_precision_s] = { FLOATX80_PARAMS(23) },
     [floatx80_precision_d] = { FLOATX80_PARAMS(52) },
-    [floatx80_precision_x] = { FLOATX80_PARAMS(64) },
+    [floatx80_precision_x] = {
+        FLOATX80_PARAMS(64),
+#ifdef TARGET_M68K
+        .m68k_denormal = true,
+#endif
+    },
 };
 
 /* Unpack a float to parts, but do not canonicalize.  */
diff --git a/tests/tcg/m68k/denormal.c b/tests/tcg/m68k/denormal.c
new file mode 100644
index 0000000000..20bd8c7332
--- /dev/null
+++ b/tests/tcg/m68k/denormal.c
@@ -0,0 +1,53 @@
+/*
+ * Test m68k extended double denormals.
+ */
+
+#include <stdio.h>
+#include <stdint.h>
+
+#define TEST(X, Y)  { X, Y, X * Y }
+
+static volatile long double test[][3] = {
+    TEST(0x1p+16383l, 0x1p-16446l),
+    TEST(0x1.1p-8223l, 0x1.1p-8224l),
+    TEST(1.0l, 0x1p-16383l),
+};
+
+#undef TEST
+
+static void dump_ld(const char *label, long double ld)
+{
+    union {
+        long double  d;
+        struct {
+            uint32_t exp:16;
+            uint32_t space:16;
+            uint32_t h;
+            uint32_t l;
+        };
+    } u;
+
+    u.d = ld;
+    printf("%12s: % -27La 0x%04x 0x%08x 0x%08x\n", label, u.d, u.exp, u.h, u.l);
+}
+
+int main(void)
+{
+    int i, n = sizeof(test) / sizeof(test[0]), err = 0;
+
+    for (i = 0; i < n; ++i) {
+        long double x = test[i][0];
+        long double y = test[i][1];
+        long double build_mul = test[i][2];
+        long double runtime_mul = x * y;
+
+        if (runtime_mul != build_mul) {
+            dump_ld("x", x);
+            dump_ld("y", y);
+            dump_ld("build_mul", build_mul);
+            dump_ld("runtime_mul", runtime_mul);
+            err = 1;
+        }
+    }
+    return err;
+}
diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index 527e15e6ab..a44649f4f4 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -118,7 +118,8 @@ static void partsN(canonicalize)(FloatPartsN *p, float_status *status,
         } else {
             int shift = frac_normalize(p);
             p->cls = float_class_normal;
-            p->exp = fmt->frac_shift - fmt->exp_bias - shift + 1;
+            p->exp = fmt->frac_shift - fmt->exp_bias
+                   - shift + !fmt->m68k_denormal;
         }
     } else if (likely(p->exp < fmt->exp_max) || fmt->arm_althp) {
         p->cls = float_class_normal;
@@ -256,7 +257,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             is_tiny = !frac_addi(&discard, p, inc);
         }
 
-        frac_shrjam(p, 1 - exp);
+        frac_shrjam(p, !fmt->m68k_denormal - exp);
 
         if (p->frac_lo & round_mask) {
             /* Need to recompute round-to-even/round-to-odd. */
@@ -287,7 +288,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
             p->frac_lo &= ~round_mask;
         }
 
-        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) != 0;
+        exp = (p->frac_hi & DECOMPOSED_IMPLICIT_BIT) && !fmt->m68k_denormal;
         frac_shr(p, frac_shift);
 
         if (is_tiny && (flags & float_flag_inexact)) {
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
index 1163c7ef03..6ff214e60a 100644
--- a/tests/tcg/m68k/Makefile.target
+++ b/tests/tcg/m68k/Makefile.target
@@ -4,7 +4,7 @@
 #
 
 VPATH += $(SRC_PATH)/tests/tcg/m68k
-TESTS += trap
+TESTS += trap denormal
 
 # On m68k Linux supports 4k and 8k pages (but 8k is currently broken)
 EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192
-- 
2.34.1


