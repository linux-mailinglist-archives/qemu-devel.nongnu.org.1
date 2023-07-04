Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 351147476E6
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 18:38:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGj1H-0001MF-2G; Tue, 04 Jul 2023 12:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj1B-0001HT-L8
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGj15-0001oI-Sw
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 12:36:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso3393156f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688488598; x=1691080598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6iQY7+PhbnjlrKHmBY15bJBqwm1HUFH2IaULsHG+tok=;
 b=gFpqnzVlkmZIVpxif7WEj1Z+J7mtBAzYl8f2Rf35AWa5knQtly1pUcL02hbsWV6tut
 ZDJzL0wCamaLfA9ryxJPbhWothY8cCWIGeSWR/AUHYr9FKC4XM3xsslzCWckAc+T6bOo
 iq0MQK2qbHBmCgUX93tZoW3xT04OO+Ym9XHUl8D7/4H9agtIeixcmGcpLEqVq4nhERV8
 cTYWzz2aZ6oQ0/TVq0sV/U0us1DtrDWYSgH4wu/4o9BxiAnrzdkidiWu0B4RWmlmE9sT
 mCh4i5nMfTvgYeZaacW0PMbdVJ/tOfIdUC+O3PMtqQI+xCb/1Pftm7YD2TzHqpFRAf8S
 VQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688488598; x=1691080598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6iQY7+PhbnjlrKHmBY15bJBqwm1HUFH2IaULsHG+tok=;
 b=JSkU/WP+xbBT60tO/2kpOfn042RUS66U7R64trVcryZTZM3TT8JbRY70hVKv0FDZRT
 uZ3QkABtWzl4/EgnBQr0XEF6G1Lh52JtoXd3I3NJd7B6iJQouJqkPKfsKLAwZ284OYRz
 NHsQwtlpRhXcAHfW6I0/CpaGNGoFoKsQMZEc207SiUm5CRHSiS+lF7crTyVYwuqm8cCs
 CeJiAOW8QB7BJjipysrlmO0pZePmbqlJG4sR6+VYPga25HkM77nqdsC3TLsD6kJy6IFy
 drOPhkoEAs5nG6PrlVkm+nVfE4Ty9RZWas/Yx4sn0KeIvki1DRO9eByxm8pb46FcMhc9
 YULA==
X-Gm-Message-State: ABy/qLYXXDsB1VLTdS037jRnCK/LOEMK4GxR3nS58X3mMQdJwADlAsmE
 T0o4NRLGfTMUmCt//JLVUAeFAPaqTLFS1z1CZJE=
X-Google-Smtp-Source: APBJJlF/+0LUlQcwJMY+WuwZYOe1DsGq14W5AyNBkDtsGKoOyOYGlCqOIasearAk6ciyYSU3YmnTCQ==
X-Received: by 2002:a5d:4534:0:b0:314:2c7a:d100 with SMTP id
 j20-20020a5d4534000000b003142c7ad100mr8835329wra.42.1688488597936; 
 Tue, 04 Jul 2023 09:36:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b003143b032b7asm4354258wrx.116.2023.07.04.09.36.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 09:36:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] target/arm: Fix SME full tile indexing
Date: Tue,  4 Jul 2023 17:36:28 +0100
Message-Id: <20230704163634.3188465-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

For the outer product set of insns, which take an entire matrix
tile as output, the argument is not a combined tile+column.
Therefore using get_tile_rowcol was incorrect, as we extracted
the tile number from itself.

The test case relies only on assembler support for SME, since
no release of GCC recognizes -march=armv9-a+sme yet.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1620
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230622151201.1578522-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sme.c    | 24 ++++++---
 tests/tcg/aarch64/sme-outprod1.c  | 83 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/Makefile.target | 10 ++--
 3 files changed, 108 insertions(+), 9 deletions(-)
 create mode 100644 tests/tcg/aarch64/sme-outprod1.c

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index d0054e3f775..6038b0a06f1 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -95,6 +95,21 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     return addr;
 }
 
+/*
+ * Resolve tile.size[0] to a host pointer.
+ * Used by e.g. outer product insns where we require the entire tile.
+ */
+static TCGv_ptr get_tile(DisasContext *s, int esz, int tile)
+{
+    TCGv_ptr addr = tcg_temp_new_ptr();
+    int offset;
+
+    offset = tile * sizeof(ARMVectorReg) + offsetof(CPUARMState, zarray);
+
+    tcg_gen_addi_ptr(addr, cpu_env, offset);
+    return addr;
+}
+
 static bool trans_ZERO(DisasContext *s, arg_ZERO *a)
 {
     if (!dc_isar_feature(aa64_sme, s)) {
@@ -260,8 +275,7 @@ static bool do_adda(DisasContext *s, arg_adda *a, MemOp esz,
         return true;
     }
 
-    /* Sum XZR+zad to find ZAd. */
-    za = get_tile_rowcol(s, esz, 31, a->zad, false);
+    za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     pn = pred_full_reg_ptr(s, a->pn);
     pm = pred_full_reg_ptr(s, a->pm);
@@ -286,8 +300,7 @@ static bool do_outprod(DisasContext *s, arg_op *a, MemOp esz,
         return true;
     }
 
-    /* Sum XZR+zad to find ZAd. */
-    za = get_tile_rowcol(s, esz, 31, a->zad, false);
+    za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     zm = vec_full_reg_ptr(s, a->zm);
     pn = pred_full_reg_ptr(s, a->pn);
@@ -308,8 +321,7 @@ static bool do_outprod_fpst(DisasContext *s, arg_op *a, MemOp esz,
         return true;
     }
 
-    /* Sum XZR+zad to find ZAd. */
-    za = get_tile_rowcol(s, esz, 31, a->zad, false);
+    za = get_tile(s, esz, a->zad);
     zn = vec_full_reg_ptr(s, a->zn);
     zm = vec_full_reg_ptr(s, a->zm);
     pn = pred_full_reg_ptr(s, a->pn);
diff --git a/tests/tcg/aarch64/sme-outprod1.c b/tests/tcg/aarch64/sme-outprod1.c
new file mode 100644
index 00000000000..6e5972d75e3
--- /dev/null
+++ b/tests/tcg/aarch64/sme-outprod1.c
@@ -0,0 +1,83 @@
+/*
+ * SME outer product, 1 x 1.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+
+extern void foo(float *dst);
+
+asm(
+"	.arch_extension sme\n"
+"	.type foo, @function\n"
+"foo:\n"
+"	stp x29, x30, [sp, -80]!\n"
+"	mov x29, sp\n"
+"	stp d8, d9, [sp, 16]\n"
+"	stp d10, d11, [sp, 32]\n"
+"	stp d12, d13, [sp, 48]\n"
+"	stp d14, d15, [sp, 64]\n"
+"	smstart\n"
+"	ptrue p0.s, vl4\n"
+"	fmov z0.s, #1.0\n"
+/*
+ * An outer product of a vector of 1.0 by itself should be a matrix of 1.0.
+ * Note that we are using tile 1 here (za1.s) rather than tile 0.
+ */
+"	zero {za}\n"
+"	fmopa za1.s, p0/m, p0/m, z0.s, z0.s\n"
+/*
+ * Read the first 4x4 sub-matrix of elements from tile 1:
+ * Note that za1h should be interchangable here.
+ */
+"	mov w12, #0\n"
+"	mova z0.s, p0/m, za1v.s[w12, #0]\n"
+"	mova z1.s, p0/m, za1v.s[w12, #1]\n"
+"	mova z2.s, p0/m, za1v.s[w12, #2]\n"
+"	mova z3.s, p0/m, za1v.s[w12, #3]\n"
+/*
+ * And store them to the input pointer (dst in the C code):
+ */
+"	st1w {z0.s}, p0, [x0]\n"
+"	add x0, x0, #16\n"
+"	st1w {z1.s}, p0, [x0]\n"
+"	add x0, x0, #16\n"
+"	st1w {z2.s}, p0, [x0]\n"
+"	add x0, x0, #16\n"
+"	st1w {z3.s}, p0, [x0]\n"
+"	smstop\n"
+"	ldp d8, d9, [sp, 16]\n"
+"	ldp d10, d11, [sp, 32]\n"
+"	ldp d12, d13, [sp, 48]\n"
+"	ldp d14, d15, [sp, 64]\n"
+"	ldp x29, x30, [sp], 80\n"
+"	ret\n"
+"	.size foo, . - foo"
+);
+
+int main()
+{
+    float dst[16];
+    int i, j;
+
+    foo(dst);
+
+    for (i = 0; i < 16; i++) {
+        if (dst[i] != 1.0f) {
+            break;
+        }
+    }
+
+    if (i == 16) {
+        return 0; /* success */
+    }
+
+    /* failure */
+    for (i = 0; i < 4; ++i) {
+        for (j = 0; j < 4; ++j) {
+            printf("%f ", (double)dst[i * 4 + j]);
+        }
+        printf("\n");
+    }
+    return 1;
+}
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index cec1d4b2875..97cfc43600a 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -26,7 +26,7 @@ config-cc.mak: Makefile
 	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
 	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
 	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
-	    $(call cc-option,-march=armv9-a+sme,            CROSS_CC_HAS_ARMV9_SME)) 3> config-cc.mak
+	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
 -include config-cc.mak
 
 ifneq ($(CROSS_CC_HAS_ARMV8_2),)
@@ -61,11 +61,15 @@ AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
 mte-%: CFLAGS += -march=armv8.5-a+memtag
 endif
 
+ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
+AARCH64_TESTS += sme-outprod1
+endif
+
 ifneq ($(CROSS_CC_HAS_SVE),)
 # System Registers Tests
 AARCH64_TESTS += sysregs
-ifneq ($(CROSS_CC_HAS_ARMV9_SME),)
-sysregs: CFLAGS+=-march=armv9-a+sme -DHAS_ARMV9_SME
+ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
+sysregs: CFLAGS+=-Wa,-march=armv9-a+sme -DHAS_ARMV9_SME
 else
 sysregs: CFLAGS+=-march=armv8.1-a+sve
 endif
-- 
2.34.1


