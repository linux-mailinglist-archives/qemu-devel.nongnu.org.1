Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F34749B37
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNai-0003RZ-Bn; Thu, 06 Jul 2023 07:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHNag-0003RB-Bu
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:56:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHNaa-0005Lu-5A
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:56:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3090d3e9c92so609950f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688644553; x=1691236553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JmueAPQsqtSZaYNbQt6iIHMZiHM3tNmpaVav4KpZ5Sk=;
 b=AEJ5rGiHJz+R4Cf87PXIhPADHPGYxLfCfyJ71n1lxvf6bTJwSQtBzrkML8uh8NsROH
 ksiFQZl4iZiUXGWrwS+l1zXA/HT7xB7bXmHDicUd7mqibhchTAh3F75fHW5Ju35iIAc7
 FXY66ZBI3NWhZ3L/5tz0V0P0pSUYRuzxcadLsoOyCbxUGFOIqbSIHq040c0rrcDgmzcC
 HvCrkfILEmT7OPKW2D/XsEgykOfq3IYn6DJ4cZZexcNnd79B+qsxbeGT/Pi7a2KliBar
 lOijVGeFlu9A1LB4ISzIm04J0/Nb3Ug0K9sX0M855mL+edqey2dKdQJmhcPEQaj7/6Vw
 yl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688644553; x=1691236553;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JmueAPQsqtSZaYNbQt6iIHMZiHM3tNmpaVav4KpZ5Sk=;
 b=NnNkhzvr9aoW4i4R2yxE8VN5sF1cqWo+seCu4AyDnbnx+JC1XTblgHUANfzTKNPW5n
 KsZxnHyIJmn3fCUByC/f/Isx6m27yHFGw+VBl0NWCt1qe2qmjmZ7/EdeNPlMIpGSp4vd
 RByvX6gsHlI+kYGStXtBwUCYAgmpjrPNM+ReVClZDd61EEyRQISLHWKLVp6I3MAvIbYM
 E1vJ8gyRNP0rcRAmm6j7LNuBC9691DnUnL/EljX88+O01/z7z8H8XveE+xNTJZox/iaQ
 TIImKDH/nRm0zOH/JnpRMgq193gumwatiB5DgLcliIrSCMUDt66TyUFqiUr//XP3hBw3
 CO9Q==
X-Gm-Message-State: ABy/qLbKNyO19RnX/J9DT1OK/nCL4DfAKiCgugxV2Uv6QmdgUVB+NB9T
 KyanMML/Nr3EMb5nNz5sdPTAsbpQ7/B2E0bfkCA=
X-Google-Smtp-Source: APBJJlEh2zWgpkkSjr3e4rqeFA9t65qeBm0Nd/x19l7dT5F6MbxMyIihnxVohMaDq3PZlxMWLNtNSQ==
X-Received: by 2002:adf:de0a:0:b0:313:eb81:d2f6 with SMTP id
 b10-20020adfde0a000000b00313eb81d2f6mr2041225wrm.4.1688644553064; 
 Thu, 06 Jul 2023 04:55:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a5d5908000000b0031437ec7ec1sm1736974wrd.2.2023.07.06.04.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 04:55:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] tests/tcg/aarch64/sysregs.c: Use S syntax for id_aa64zfr0_el1
 and id_aa64smfr0_el1
Date: Thu,  6 Jul 2023 12:55:51 +0100
Message-Id: <20230706115551.3411008-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Some assemblers will complain about attempts to access
id_aa64zfr0_el1 and id_aa64smfr0_el1 by name if the test
binary isn't built for the right processor type:

 /tmp/ccASXpLo.s:782: Error: selected processor does not support system register name 'id_aa64zfr0_el1'
 /tmp/ccASXpLo.s:829: Error: selected processor does not support system register name 'id_aa64smfr0_el1'

However, these registers are in the ID space and are guaranteed to
read-as-zero on older CPUs, so the access is both safe and sensible.
Switch to using the S syntax, as we already do for ID_AA64ISAR2_EL1
and ID_AA64MMFR2_EL1.  This allows us to drop the HAS_ARMV9_SME check
and the makefile machinery to adjust the CFLAGS for this test, so we
don't rely on having a sufficiently new compiler to be able to check
these registers.

This means we're actually testing the SME ID register: no released
GCC yet recognizes -march=armv9-a+sme, so that was always skipped.
It also avoids a future problem if we try to switch the "do we have
SME support in the toolchain" check from "in the compiler" to "in the
assembler" (at which point we would otherwise run into the above
errors).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a patch I propose to add into the target-arm pullreq,
as a fix for the build problem that we otherwise run into with
RTH's SME fix patch in it:
https://gitlab.com/qemu-project/qemu/-/jobs/4592433432#L3723

 tests/tcg/aarch64/sysregs.c       | 11 +++++++----
 tests/tcg/aarch64/Makefile.target |  7 +------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index 46b931f781d..d8eb06abcf2 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -25,9 +25,14 @@
 /*
  * Older assemblers don't recognize newer system register names,
  * but we can still access them by the Sn_n_Cn_Cn_n syntax.
+ * This also means we don't need to specifically request that the
+ * assembler enables whatever architectural features the ID registers
+ * syntax might be gated behind.
  */
 #define SYS_ID_AA64ISAR2_EL1 S3_0_C0_C6_2
 #define SYS_ID_AA64MMFR2_EL1 S3_0_C0_C7_2
+#define SYS_ID_AA64ZFR0_EL1 S3_0_C0_C4_4
+#define SYS_ID_AA64SMFR0_EL1 S3_0_C0_C4_5
 
 int failed_bit_count;
 
@@ -132,10 +137,8 @@ int main(void)
     /* all hidden, DebugVer fixed to 0x6 (ARMv8 debug architecture) */
     get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
     get_cpu_reg_check_zero(id_aa64dfr1_el1);
-    get_cpu_reg_check_mask(id_aa64zfr0_el1,  _m(0ff0,ff0f,00ff,00ff));
-#ifdef HAS_ARMV9_SME
-    get_cpu_reg_check_mask(id_aa64smfr0_el1, _m(80f1,00fd,0000,0000));
-#endif
+    get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,00ff,00ff));
+    get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(80f1,00fd,0000,0000));
 
     get_cpu_reg_check_zero(id_aa64afr0_el1);
     get_cpu_reg_check_zero(id_aa64afr1_el1);
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index cec1d4b2875..ea9ceb31e61 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -61,15 +61,10 @@ AARCH64_TESTS += mte-1 mte-2 mte-3 mte-4 mte-5 mte-6 mte-7
 mte-%: CFLAGS += -march=armv8.5-a+memtag
 endif
 
-ifneq ($(CROSS_CC_HAS_SVE),)
 # System Registers Tests
 AARCH64_TESTS += sysregs
-ifneq ($(CROSS_CC_HAS_ARMV9_SME),)
-sysregs: CFLAGS+=-march=armv9-a+sme -DHAS_ARMV9_SME
-else
-sysregs: CFLAGS+=-march=armv8.1-a+sve
-endif
 
+ifneq ($(CROSS_CC_HAS_SVE),)
 # SVE ioctl test
 AARCH64_TESTS += sve-ioctls
 sve-ioctls: CFLAGS+=-march=armv8.1-a+sve
-- 
2.34.1


