Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9790798B41
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:09:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeevy-0005DW-Kw; Fri, 08 Sep 2023 13:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevw-00055i-83
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeevn-00016A-KU
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:06:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so26094925e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694192761; x=1694797561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bNrQGxFMTVZVRRXvMgnejCvUWTcq/58zPnQMO3cKLkk=;
 b=pOzW26OjghNvNTP7LyDVaAeZbLyyePx47ozvXrJq8QXSwh36bht9KOaixP913WqAJW
 vNl3dt0PseIw3yAcP300diddxlceLGf42VynBJymLFK1uKrv5qSq/7drAY7xMT+TzFgq
 YFcBP9JcCk6M83ROw/jQb8rufDUXfzDVhvlqUwSF0nohbLOJel0x64YOMZ0tP6EVPu3e
 J3gjl/+gwJSZW4kf8kS1GZMYp871A7MvGl4QwXWy1TIqEZ6Jhh55mlKEPTYIHHHQbkFn
 MKLx4sSBJiie7dbhiPGEXi9OuNJmOL6Ppxa649TyGciZ4HiZeFNpgNgLcJDhRW613tFH
 ycdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694192761; x=1694797561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNrQGxFMTVZVRRXvMgnejCvUWTcq/58zPnQMO3cKLkk=;
 b=DZNtjQFSWx+06AuFwcnS93D+1GdiDEsEJqw24wy9eTP7mREO7wlV3k3p78yJGjOxoh
 nSTS1IqS6IOopk/V2j1aCsH+gD/KvaWuaXGJbCCIUJchqSOZVXb9V7DhvxdubKkIwO8h
 Ux/HpO60eSGjZCDWEeSNTlk4U/ZgOoeVSQZGSDJBUhh3uW+or6uLmsPXwllX0bR19cgP
 aqBUejxPhcgwAn+Hk4dFKNtds9RIDpY5mjcaBXs2Qt5LnoPs6JHLLyl7BcoMoQQh2zX0
 rnF9uOT/8Fkq7tNcGVeQo+t6TK59927CK7NYr+i7m+bBfZDQdaOIrIOFOAY2j4FC2XOG
 +WXg==
X-Gm-Message-State: AOJu0Yw+CfZCna+pbO8rSVf99JfU3nR7A6KmRPevk9zfsXwHiXJbsrBf
 DaMi/JwigAhEk/sgSjlEjiDawnwmj8vfCdC47bI=
X-Google-Smtp-Source: AGHT+IFmsX39Nbks4S9iMCMZxYXYz1xl18DBvi1bOCB8f8v1cDoI2ttq/m7vSukW1eC64nxeHIHy0g==
X-Received: by 2002:a1c:7917:0:b0:402:e68f:8898 with SMTP id
 l23-20020a1c7917000000b00402e68f8898mr2629245wme.0.1694192761202; 
 Fri, 08 Sep 2023 10:06:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d21-20020a1c7315000000b00400268671c6sm2427152wmb.13.2023.09.08.10.06.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 10:06:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/26] tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
Date: Fri,  8 Sep 2023 18:05:32 +0100
Message-Id: <20230908170557.773048-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908170557.773048-1-peter.maydell@linaro.org>
References: <20230908170557.773048-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

With FEAT_FPAC, AUT* instructions that fail authentication
do not produce an error value but instead fault.

For pauth-2, install a signal handler and verify it gets called.

For pauth-4 and pauth-5, we are explicitly testing the error value,
so there's nothing to test with FEAT_FPAC, so exit early.
Adjust the makefile to use -cpu neoverse-v1, which has FEAT_EPAC
but not FEAT_FPAC.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230829232335.965414-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/pauth.h         | 23 +++++++++++++
 tests/tcg/aarch64/pauth-2.c       | 54 ++++++++++++++++++++++++++-----
 tests/tcg/aarch64/pauth-4.c       | 18 ++++++++---
 tests/tcg/aarch64/pauth-5.c       | 10 ++++++
 tests/tcg/aarch64/Makefile.target |  6 +++-
 5 files changed, 98 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth.h

diff --git a/tests/tcg/aarch64/pauth.h b/tests/tcg/aarch64/pauth.h
new file mode 100644
index 00000000000..543b234437f
--- /dev/null
+++ b/tests/tcg/aarch64/pauth.h
@@ -0,0 +1,23 @@
+/*
+ * Helper for pauth test case
+ *
+ * Copyright (c) 2023 Linaro Ltd
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <assert.h>
+#include <sys/auxv.h>
+
+static int get_pac_feature(void)
+{
+    unsigned long isar1, isar2;
+
+    assert(getauxval(AT_HWCAP) & HWCAP_CPUID);
+
+    asm("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
+    asm("mrs %0, S3_0_C0_C6_2" : "=r"(isar2));     /* id_aa64isar2_el1 */
+
+    return ((isar1 >> 4) & 0xf)   /* APA */
+         | ((isar1 >> 8) & 0xf)   /* API */
+         | ((isar2 >> 12) & 0xf); /* APA3 */
+}
diff --git a/tests/tcg/aarch64/pauth-2.c b/tests/tcg/aarch64/pauth-2.c
index 978652ede3a..89ffdbf1df7 100644
--- a/tests/tcg/aarch64/pauth-2.c
+++ b/tests/tcg/aarch64/pauth-2.c
@@ -1,5 +1,22 @@
 #include <stdint.h>
+#include <signal.h>
+#include <stdlib.h>
 #include <assert.h>
+#include "pauth.h"
+
+
+static void sigill(int sig, siginfo_t *info, void *vuc)
+{
+    ucontext_t *uc = vuc;
+    uint64_t test;
+
+    /* There is only one insn below that is allowed to fault. */
+    asm volatile("adr %0, auth2_insn" : "=r"(test));
+    assert(test == uc->uc_mcontext.pc);
+    exit(0);
+}
+
+static int pac_feature;
 
 void do_test(uint64_t value)
 {
@@ -27,31 +44,52 @@ void do_test(uint64_t value)
      * An invalid salt usually fails authorization, but again there
      * is a chance of choosing another salt that works.
      * Iterate until we find another salt which does fail.
+     *
+     * With FEAT_FPAC, this will SIGILL instead of producing a result.
      */
     for (salt2 = salt1 + 1; ; salt2++) {
-        asm volatile("autda %0, %2" : "=r"(decode) : "0"(encode), "r"(salt2));
+        asm volatile("auth2_insn: autda %0, %2"
+                     : "=r"(decode) : "0"(encode), "r"(salt2));
         if (decode != value) {
             break;
         }
     }
 
+    assert(pac_feature < 4);  /* No FEAT_FPAC */
+
     /* The VA bits, bit 55, and the TBI bits, should be unchanged.  */
     assert(((decode ^ value) & 0xff80ffffffffffffull) == 0);
 
     /*
-     * Bits [54:53] are an error indicator based on the key used;
-     * the DA key above is keynumber 0, so error == 0b01.  Otherwise
-     * bit 55 of the original is sign-extended into the rest of the auth.
+     * Without FEAT_Pauth2, bits [54:53] are an error indicator based on
+     * the key used; the DA key above is keynumber 0, so error == 0b01.
+     * Otherwise, bit 55 of the original is sign-extended into the rest
+     * of the auth.
      */
-    if ((value >> 55) & 1) {
-        assert(((decode >> 48) & 0xff) == 0b10111111);
-    } else {
-        assert(((decode >> 48) & 0xff) == 0b00100000);
+    if (pac_feature < 3) {
+        if ((value >> 55) & 1) {
+            assert(((decode >> 48) & 0xff) == 0b10111111);
+        } else {
+            assert(((decode >> 48) & 0xff) == 0b00100000);
+        }
     }
 }
 
 int main()
 {
+    static const struct sigaction sa = {
+        .sa_sigaction = sigill,
+        .sa_flags = SA_SIGINFO
+    };
+
+    pac_feature = get_pac_feature();
+    assert(pac_feature != 0);
+
+    if (pac_feature >= 4) {
+        /* FEAT_FPAC */
+        sigaction(SIGILL, &sa, NULL);
+    }
+
     do_test(0);
     do_test(0xda004acedeadbeefull);
     return 0;
diff --git a/tests/tcg/aarch64/pauth-4.c b/tests/tcg/aarch64/pauth-4.c
index 24a639e36ca..b254f413afd 100644
--- a/tests/tcg/aarch64/pauth-4.c
+++ b/tests/tcg/aarch64/pauth-4.c
@@ -2,14 +2,24 @@
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "pauth.h"
 
 #define TESTS 1000
 
 int main()
 {
+    char base[TESTS];
     int i, count = 0;
     float perc;
-    void *base = malloc(TESTS);
+    int pac_feature = get_pac_feature();
+
+    /*
+     * Exit if no PAuth or FEAT_FPAC, which will SIGILL on AUTIA failure
+     * rather than return an error for us to check below.
+     */
+    if (pac_feature == 0 || pac_feature >= 4) {
+        return 0;
+    }
 
     for (i = 0; i < TESTS; i++) {
         uintptr_t in, x, y;
@@ -17,7 +27,7 @@ int main()
         in = i + (uintptr_t) base;
 
         asm("mov %0, %[in]\n\t"
-            "pacia %0, sp\n\t"        /* sigill if pauth not supported */
+            "pacia %0, sp\n\t"
             "eor %0, %0, #4\n\t"      /* corrupt single bit */
             "mov %1, %0\n\t"
             "autia %1, sp\n\t"        /* validate corrupted pointer */
@@ -36,10 +46,10 @@ int main()
         if (x != y) {
             count++;
         }
-
     }
+
     perc = (float) count / (float) TESTS;
-    printf("Checks Passed: %0.2f%%", perc * 100.0);
+    printf("Checks Passed: %0.2f%%\n", perc * 100.0);
     assert(perc > 0.95);
     return 0;
 }
diff --git a/tests/tcg/aarch64/pauth-5.c b/tests/tcg/aarch64/pauth-5.c
index 67c257918b9..ed8d5a926b8 100644
--- a/tests/tcg/aarch64/pauth-5.c
+++ b/tests/tcg/aarch64/pauth-5.c
@@ -1,4 +1,5 @@
 #include <assert.h>
+#include "pauth.h"
 
 static int x;
 
@@ -6,6 +7,15 @@ int main()
 {
     int *p0 = &x, *p1, *p2, *p3;
     unsigned long salt = 0;
+    int pac_feature = get_pac_feature();
+
+    /*
+     * Exit if no PAuth or FEAT_FPAC, which will SIGILL on AUTDA failure
+     * rather than return an error for us to check below.
+     */
+    if (pac_feature == 0 || pac_feature >= 4) {
+        return 0;
+    }
 
     /*
      * With TBI enabled and a 48-bit VA, there are 7 bits of auth, and so
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index b77bbd9b3cf..2efacf9a5a3 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -42,7 +42,11 @@ endif
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
 pauth-%: CFLAGS += -march=armv8.3-a
-run-pauth-%: QEMU_OPTS += -cpu max
+run-pauth-1: QEMU_OPTS += -cpu max
+run-pauth-2: QEMU_OPTS += -cpu max
+# Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
+run-pauth-4: QEMU_OPTS += -cpu neoverse-v1
+run-pauth-5: QEMU_OPTS += -cpu neoverse-v1
 endif
 
 # BTI Tests
-- 
2.34.1


