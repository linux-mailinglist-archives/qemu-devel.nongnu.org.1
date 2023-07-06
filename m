Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B40749DA3
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzd-0005KV-89; Thu, 06 Jul 2023 09:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzP-0004sI-JO
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzM-0000r1-0o
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82dc7so7151345e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649915; x=1691241915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=11dmJzi1SZBc11U8ovpYkYYocCgASa/aNmWlfY/CVCM=;
 b=uu73ZLE6GUX6b6J/Bq6G3ASEwaStlVpaAOV/ACGHEXLNiW9TWW2L3fs2AFP+EDO4S4
 c3e6D24GHxHBX2sejMKSJZji4fbvuc27clR0Y9FdLSwVArS2GQ4qRFOuSEiLdlKJAvq0
 jErHYhQ5uN6pUJJiH39o0ZRwZesCoh1Ke3OtRusM1sy9xu0nTxSzIBuX+KiZ1arVlWZf
 Hyh/TVwlIGUIggDI/p6RHqdVAlLFG6i+rNXhmrUfy06VJ63qNv33SiL4wVhXugyswgNj
 jPl5Klg9Sa/aY7qanK9mlmhe0d1VyWSfizZUn3bf/iQCzpeNMIJcRWGTgr4RpBO4XBRy
 pFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649915; x=1691241915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11dmJzi1SZBc11U8ovpYkYYocCgASa/aNmWlfY/CVCM=;
 b=XiPexeQom/bhlXrxiNOURyvST1oe52e+Y3/1eK8Q4VdG38WkIQzHMoDHq4PFMVavw0
 m4Pc8rQlabYOgmX+K8P15DQPaYYkKXJFOiRuGkh8Qmcy2Z6i3i3q4QkJMHt7AlkHeXjh
 QFj93CWDJZ/CkQNwab6ZnKGbIsQZUawmhBeSeqcTS1hN5idJpb0HEJ6ywhwbXuV+NvDp
 M93k+WE1tTaszedkbDxCnCBCoylieDeycaiWK2QUJIJeRlA/iiPtjJJYdJkDMTX25mGp
 NeTacssvB7v8aKBmCLDeD83QyGnIjKHH6i63smmeutmMVZJ64DNetxEXZ896qa+TSwpl
 6+mw==
X-Gm-Message-State: ABy/qLY9yZUszDJ2hknDCLhaV1VCNqzoPDRFeNXbE7oHabVwL/IN7P05
 L21+87WJee5xmHg9KpQp7cXBC3bhMa7nvRw80iw=
X-Google-Smtp-Source: APBJJlGQ4f/0zP2iYgO4kqsKmiavVNAx5iOFbTLkPaiXW7Lt25oIPDxVprblJNbo3pgRLfJGEBLtzw==
X-Received: by 2002:adf:ecc8:0:b0:30f:af06:7320 with SMTP id
 s8-20020adfecc8000000b0030faf067320mr1506244wro.23.1688649915584; 
 Thu, 06 Jul 2023 06:25:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/14] tests/tcg/aarch64/sysregs.c: Use S syntax for
 id_aa64zfr0_el1 and id_aa64smfr0_el1
Date: Thu,  6 Jul 2023 14:25:01 +0100
Message-Id: <20230706132512.3534397-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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


