Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1459A7820F1
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 02:34:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXsqa-0001iA-SD; Sun, 20 Aug 2023 20:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXsqZ-0001hn-F2
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 20:32:43 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXsqX-00009d-3A
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 20:32:43 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a78a29bca3so2052901b6e.0
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692577959; x=1693182759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6jTK5S+/19Rgt22kVhE3usOa9jqvvDn75V8SaSLGO4w=;
 b=Go+4bgDQLUGC8Youb61vIUApRDsXbDdO97pMbAYWA4ETXgZNbRoTG67Py8se6cnD0i
 RRIB/FEIg03ZOwwNfRwM+yqB0D65OwDBQlLUbhZrJsnrR0GX0dlrDQaWGXMkjjmK4IBX
 Srt8yS2OEsHPP5sk5oejsOhzE2hvD8r/uSmc8scH1KH/p0/VRYN7Yjk8PjV/FGWZR7Ry
 G6VGHm3FhK2VfXFCd/epHJaWOsRaNGxjBekQTC+Is+609pNL+20PI3IdTSueFIisehfJ
 Z/BZpdI4XDEi36f+p/3D4q5uAyU1mnPUcz+5ESlj+5uNmPwo0k0OowKbb/pZfVi0Z3Wf
 fCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692577959; x=1693182759;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6jTK5S+/19Rgt22kVhE3usOa9jqvvDn75V8SaSLGO4w=;
 b=QpraScm4upEU5XAv7jFa76AzAWhYL/rEauPGs/piLcaWW8HBNV5tNOtcsZqMeiYc3z
 la8IuoTR7rv1qvkfeRdcqdYR1MG8eJDe1nzeKcxp772rxgQ21wl7ilGeRK6O/Up4ogZv
 EeYwvdQtDTbQrSGTYOzId+1y69aXJcGgRIFSaxKNokKwG8SRydVN4XUm/Rg0MiGnZKNH
 RCbYa+XdCXI6AVdiYsB00Q5dAXqPFPrfm+Nb/saA3Cf+r54qy9pG6qamAPwVNudhJG9G
 IKTwkFNwdxJ1m78zFpAfEoq7uQG92XKKN11mUeNjumsIldPoihUZTJFAeN9fEwPgAPWG
 B1bQ==
X-Gm-Message-State: AOJu0YzmJlVhy96zvftG3hG/ExP/oalSibaJnp/akn65FNr4zwbmngrT
 pC0VrnNPuLlJ1k3I4R5hZPCkZJd3W/vSoc6INSk=
X-Google-Smtp-Source: AGHT+IHOx2y1HVTAzVcPb3PPRUxzX+MZmrwjIVjF0vvurFuiFu4jqwyGHGh3JZaArOggfhO7kisCPg==
X-Received: by 2002:a05:6808:159f:b0:3a7:5453:a626 with SMTP id
 t31-20020a056808159f00b003a75453a626mr8046022oiw.4.1692577959303; 
 Sun, 20 Aug 2023 17:32:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:7da6:8db:fd7a:4d62])
 by smtp.gmail.com with ESMTPSA id
 n16-20020aa79050000000b0068664ace38asm5112484pfo.19.2023.08.20.17.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Aug 2023 17:32:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH] softfloat: Handle m68k extended precision denormals properly
Date: Sun, 20 Aug 2023 17:32:37 -0700
Message-Id: <20230821003237.376935-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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
having unbiased exponent 1 (like all other IEEE formats).

Add a flag on FloatFmt to differentiate the behaviour.

Reported-by: Keith Packard <keithp@keithp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                |  9 +++++-
 tests/tcg/m68k/denormal.c      | 53 ++++++++++++++++++++++++++++++++++
 fpu/softfloat-parts.c.inc      |  5 ++--
 tests/tcg/m68k/Makefile.target |  2 +-
 4 files changed, 65 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/m68k/denormal.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 0cc130ae9b..3adfa8cee0 100644
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
index 0000000000..599dafa663
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
+#define X0      0x1p+16383l
+#define Y0      0x1p-16446l
+#define X1      0x1.1p-8223l
+#define Y1      0x1.1p-8224l
+
+static volatile long double test[2][3] = {
+    { X0, Y0, X0 * Y0 },
+    { X1, Y1, X1 * Y1 },
+};
+
+static void dump_ld(const char *label, long double ld)
+{
+    union {
+        long double     d;
+        struct {
+            uint32_t    exp:16;
+            uint32_t    space:16;
+            uint32_t    h;
+            uint32_t    l;
+        };
+    } u;
+
+    u.d = ld;
+    printf("%12s: % -27La 0x%04x 0x%08x 0x%08x\n", label, u.d, u.exp, u.h, u.l);
+}
+
+int main(void)
+{
+    int i, err = 0;
+
+    for (i = 0; i < 2; ++i) {
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
index 527e15e6ab..d0c43c28fb 100644
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


