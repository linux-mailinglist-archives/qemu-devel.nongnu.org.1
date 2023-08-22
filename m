Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D327838C3
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 06:26:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIxZ-0006Hr-3G; Tue, 22 Aug 2023 00:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxX-0006F0-3G
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:39 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYIxS-0007Vw-Gb
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 00:25:38 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a412653335so3054190b6e.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692678333; x=1693283133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GKKXT9DfTD7fk9RFPmaJK1tvcnI2h1es3y0tUToo9LE=;
 b=yswBk9T+36TM/RGeloDgkFjIfcVZ9EJU9e3UA5VdwJH4eIDKcXwQSqGbIhvRW33xq2
 KFre4jNGhJTq/gqosDJEf/7xwXa0mwDj7JnvKUUNdnkzU63XOtwLiXFLXa2r8VsC1KKU
 fRzpOJio5mUg0DdpQ57EhxAazZx4o9ba2UWPixL4eJkhS64JY+d9Qe/+friYMSOD4HzS
 fkB9WZrtCi/yVFIUx61XfIWCBScj/dU2cHSaMwwMHrxPlpH7VLCCFKX+kcFpuYBM+bAB
 +s2QIZ/JcHQsu1Vfw/IqhzxldYX/anm0ffBhysZz7oOFvDNImuJpmyjywle9P2m9pleh
 f9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692678333; x=1693283133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GKKXT9DfTD7fk9RFPmaJK1tvcnI2h1es3y0tUToo9LE=;
 b=Rn5Oq9Fiv96XG5MBF47dcjcV+w5ImvNfZunWmrO1LBEunez6hsQ4UQ4CVu9eXUetWc
 yq/vB/t9HL42sULypInnHxr50wV6vFTcUUFqCrsFPKy/6/F2LjqvDcgezhsNHeJLnget
 0TIvan8oMJ19s40iiRyAATy7IwJ6QgBfQCmUqqWGEtzbG2wb3i/VCc4Nw8IJS5bBSnQh
 mnGZ19OqJ0TF+s3b5vIf/jog981rvJCb3wd6OOIo3p2nSA/IY8pcw9s5XnSFBlSloD7R
 gx8TU4J8BPPjYabKGkTqdMLieVL1lPCaLI6Q1oOl/gwpbwmK36Zk+FPfp2V478D8op0M
 /m7A==
X-Gm-Message-State: AOJu0YwoWrsPw0WTxCH+RtPrOgRP4lF6Suc9FKWfb2+ouzxW5kNXJq1+
 VQflfgxYeLp4VQqGeTBxpUbY2hJG4yxtpuS4/F4=
X-Google-Smtp-Source: AGHT+IHFpobPjRIe19xRU3dFglNf5x0oB60w7D9n5R5mzrDYp2ikoEgwp2TymKoZAcTR2SvfQDrHgQ==
X-Received: by 2002:a54:4d9b:0:b0:3a7:4f89:5b6d with SMTP id
 y27-20020a544d9b000000b003a74f895b6dmr8686434oix.58.1692678332956; 
 Mon, 21 Aug 2023 21:25:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7900e000000b0068a3f861b24sm3364908pfo.195.2023.08.21.21.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 21:25:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 1/9] tests/tcg/aarch64: Adjust pauth tests for FEAT_FPAC
Date: Mon, 21 Aug 2023 21:25:22 -0700
Message-Id: <20230822042530.1026751-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822042530.1026751-1-richard.henderson@linaro.org>
References: <20230822042530.1026751-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

With FEAT_FPAC, AUT* instructions that fail authentication
do not produce an error value but instead fault.

For pauth-2, install a signal handler and verify it gets called.

For pauth-4 and pauth-5, we are explicitly testing the error value,
so there's nothing to test with FEAT_FPAC, so exit early.
Adjust the makefile to use -cpu neoverse-v1, which has FEAT_EPAC
but not FEAT_FPAC.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/pauth-2.c       | 61 +++++++++++++++++++++++++++----
 tests/tcg/aarch64/pauth-4.c       | 28 ++++++++++++--
 tests/tcg/aarch64/pauth-5.c       | 20 ++++++++++
 tests/tcg/aarch64/Makefile.target |  5 ++-
 4 files changed, 101 insertions(+), 13 deletions(-)

diff --git a/tests/tcg/aarch64/pauth-2.c b/tests/tcg/aarch64/pauth-2.c
index 978652ede3..d498d7dd8b 100644
--- a/tests/tcg/aarch64/pauth-2.c
+++ b/tests/tcg/aarch64/pauth-2.c
@@ -1,5 +1,21 @@
 #include <stdint.h>
+#include <signal.h>
+#include <stdlib.h>
 #include <assert.h>
+#include <sys/auxv.h>
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
@@ -27,31 +43,60 @@ void do_test(uint64_t value)
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
+     * Otherwise * bit 55 of the original is sign-extended into the rest
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
+    unsigned long isar1, isar2;
+
+    assert(getauxval(AT_HWCAP) & HWCAP_CPUID);
+
+    asm("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
+    asm("mrs %0, id_aa64isar2_el1" : "=r"(isar2));
+
+    pac_feature = ((isar1 >> 4) & 0xf)   /* APA */
+                | ((isar1 >> 8) & 0xf)   /* API */
+                | ((isar2 >> 12) & 0xf); /* APA3 */
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
index 24a639e36c..0d79ef21ea 100644
--- a/tests/tcg/aarch64/pauth-4.c
+++ b/tests/tcg/aarch64/pauth-4.c
@@ -2,14 +2,34 @@
 #include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <sys/auxv.h>
 
 #define TESTS 1000
 
 int main()
 {
+    char base[TESTS];
     int i, count = 0;
     float perc;
-    void *base = malloc(TESTS);
+    unsigned long isar1, isar2;
+    int pac_feature;
+
+    assert(getauxval(AT_HWCAP) & HWCAP_CPUID);
+
+    asm("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
+    asm("mrs %0, id_aa64isar2_el1" : "=r"(isar2));
+
+    pac_feature = ((isar1 >> 4) & 0xf)   /* APA */
+                | ((isar1 >> 8) & 0xf)   /* API */
+                | ((isar2 >> 12) & 0xf); /* APA3 */
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
@@ -17,7 +37,7 @@ int main()
         in = i + (uintptr_t) base;
 
         asm("mov %0, %[in]\n\t"
-            "pacia %0, sp\n\t"        /* sigill if pauth not supported */
+            "pacia %0, sp\n\t"
             "eor %0, %0, #4\n\t"      /* corrupt single bit */
             "mov %1, %0\n\t"
             "autia %1, sp\n\t"        /* validate corrupted pointer */
@@ -36,10 +56,10 @@ int main()
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
index 67c257918b..5dbfb14768 100644
--- a/tests/tcg/aarch64/pauth-5.c
+++ b/tests/tcg/aarch64/pauth-5.c
@@ -1,4 +1,5 @@
 #include <assert.h>
+#include <sys/auxv.h>
 
 static int x;
 
@@ -6,6 +7,25 @@ int main()
 {
     int *p0 = &x, *p1, *p2, *p3;
     unsigned long salt = 0;
+    unsigned long isar1, isar2;
+    int pac_feature;
+
+    assert(getauxval(AT_HWCAP) & HWCAP_CPUID);
+
+    asm("mrs %0, id_aa64isar1_el1" : "=r"(isar1));
+    asm("mrs %0, id_aa64isar2_el1" : "=r"(isar2));
+
+    pac_feature = ((isar1 >> 4) & 0xf)   /* APA */
+                | ((isar1 >> 8) & 0xf)   /* API */
+                | ((isar2 >> 12) & 0xf); /* APA3 */
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
index 681dfa077c..780ab3f183 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -42,7 +42,10 @@ endif
 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 AARCH64_TESTS += pauth-1 pauth-2 pauth-4 pauth-5
 pauth-%: CFLAGS += -march=armv8.3-a
-run-pauth-%: QEMU_OPTS += -cpu max
+run-pauth-1: QEMU_OPTS += -cpu max
+run-pauth-2: QEMU_OPTS += -cpu max
+run-pauth-4: QEMU_OPTS += -cpu neoverse-v1
+run-pauth-5: QEMU_OPTS += -cpu neoverse-v1
 endif
 
 # BTI Tests
-- 
2.34.1


