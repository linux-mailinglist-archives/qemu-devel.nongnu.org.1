Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8F08CEDB8
	for <lists+qemu-devel@lfdr.de>; Sat, 25 May 2024 05:15:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAhr1-0006ik-5v; Fri, 24 May 2024 23:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhqx-0006hk-Gu; Fri, 24 May 2024 23:13:51 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAhqv-0004q9-E3; Fri, 24 May 2024 23:13:51 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-24fd4f615bfso6636fac.3; 
 Fri, 24 May 2024 20:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716606827; x=1717211627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6GoopJJATWYm8J4AQBO2uEawHJimowUcs3mDf1Js1Io=;
 b=OGn5N5EClt6PBUOaypB+T4rhAChg+uaJAuLj75L26DLPODjMxsdzT/O9L740vpI0zJ
 3A8MMh6V/Uw4rstArYBwc7hhnV4atlzPOsRZZjo17wkSWnDLOb7AyXO4X1EdfNHqONHO
 Ub1Kllj7dmrrhKkBaI6g7XBzu9pTdYXigOTfRiHvyyaU9AVN17Zeh8SIEBK9vOwjnmKf
 Lns0rhFcHdrEkWbQCus2TidA7ZfllKe+niu6H+x7W1hAJIgh4IXOacjCfGP3zGc2VS9u
 bAMCWAPqm2paujIJYnfZ/Hp7xiDDIs3ZFtn6p9vN9gqI4X18io1eQmCsJX8JF76H/pzB
 Qw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716606827; x=1717211627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6GoopJJATWYm8J4AQBO2uEawHJimowUcs3mDf1Js1Io=;
 b=IaWj+z66vuaa7qOPIutiLHBnedd2Prrqp1pwo+oZnA1uO4lokJENRUI2gCWP7yyXM6
 r5fcetIkzOOFtwEUDZ8lbP/3nXRuZaRUz8GIev2gedUKAEwfo+pQ4WWRp0BQRFW/T2m0
 GIi67zalIIxP/WEtj/qY1rZbaZ7k21nl67A8rX/FinG9QqsRwVANdqKpu0JE/s7JIN5z
 Ld3vmg4kfT2NKozb4e94scYj5vXqtD8JhM/z03T6u5xynAv2uv0e+5qGdSjBxa8HOdhc
 Ugo4fpAA2VQUuJsFOrHlXC/FgrKgCcL3CkhiGMqTVFBZH+pAfkI5rY5WB5ik4teiWhGw
 y0Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBJ9UedX5YnQH8DmuwzyjsWoQ6TxjliUSfxMnkiG66jzGEnZiAamYn5n08C2pNdDk2zfcDyGLBFT1FkvRB76n1ta/+WGS4u+gqqCvov7PBnhRx405wn/C7+Cg=
X-Gm-Message-State: AOJu0YymSEMSQOrVZ044IA5HLQVuuKjv6GerlMFVFojPa1wv8Oydz5W3
 cZtXaBhbsXRrUPyn7DIA1pU4PNzecT2QmoM+oTDZOdp1UVct6QRD
X-Google-Smtp-Source: AGHT+IG9i9Lkcmw7QgT7b69cZCa1EWMJUpj0EJGzhTYeaA5ndSw2Y+Rf3X3Hv2cFB88eTK5jZlRNXA==
X-Received: by 2002:a05:6870:d112:b0:24f:d3ad:ac96 with SMTP id
 586e51a60fabf-24fd3adeed9mr113464fac.22.1716606827490; 
 Fri, 24 May 2024 20:13:47 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fc05a363sm1744306b3a.64.2024.05.24.20.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 20:13:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 3/3] tests/qtest/migration-test: Use custom asm bios for ppc64
Date: Sat, 25 May 2024 13:13:29 +1000
Message-ID: <20240525031330.196609-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240525031330.196609-1-npiggin@gmail.com>
References: <20240525031330.196609-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Similar to other archs, build a custom bios memory updater. Running the
test with OF code is a cool trick, but SLOF takes a long time to boot.
This reduces test time by around 3x (150s to 50s).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/migration/migration-test.h   |  1 +
 tests/migration/ppc64/a-b-kernel.h | 42 +++++++++++++++++++
 tests/qtest/migration-test.c       | 35 +++-------------
 tests/migration/Makefile           |  2 +-
 tests/migration/ppc64/Makefile     | 15 +++++++
 tests/migration/ppc64/a-b-kernel.S | 66 ++++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+), 31 deletions(-)
 create mode 100644 tests/migration/ppc64/a-b-kernel.h
 create mode 100644 tests/migration/ppc64/Makefile
 create mode 100644 tests/migration/ppc64/a-b-kernel.S

diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
index 68512c0b1b..194df7df6f 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -22,6 +22,7 @@
 /* PPC */
 #define PPC_TEST_MEM_START (1 * 1024 * 1024)
 #define PPC_TEST_MEM_END   (100 * 1024 * 1024)
+#define PPC_H_PUT_TERM_CHAR 0x58
 
 /* ARM */
 #define ARM_TEST_MEM_START (0x40000000 + 1 * 1024 * 1024)
diff --git a/tests/migration/ppc64/a-b-kernel.h b/tests/migration/ppc64/a-b-kernel.h
new file mode 100644
index 0000000000..673317efdb
--- /dev/null
+++ b/tests/migration/ppc64/a-b-kernel.h
@@ -0,0 +1,42 @@
+/* This file is automatically generated from the assembly file in
+ * tests/migration/ppc64. Edit that file and then run "make all"
+ * inside tests/migration to update, and then remember to send both
+ * the header and the assembler differences in your patch submission.
+ */
+unsigned char ppc64_kernel[] = {
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+  0x00, 0x00, 0x00, 0x00, 0x7d, 0x20, 0x00, 0xa6, 0x39, 0x40, 0xff, 0xff,
+  0x79, 0x49, 0xf8, 0x0e, 0x7d, 0x20, 0x01, 0x64, 0x3e, 0x80, 0x00, 0x10,
+  0x62, 0x94, 0x00, 0x00, 0x3d, 0x20, 0x06, 0x40, 0x61, 0x29, 0x00, 0x00,
+  0x7e, 0xb4, 0x48, 0x50, 0x39, 0x40, 0x10, 0x00, 0x7e, 0xb5, 0x53, 0xd2,
+  0x38, 0x60, 0x00, 0x58, 0x38, 0x80, 0x00, 0x00, 0x38, 0xa0, 0x00, 0x01,
+  0x38, 0xc0, 0x00, 0x41, 0x78, 0xc6, 0xc1, 0xc6, 0x44, 0x00, 0x00, 0x22,
+  0x38, 0x60, 0x00, 0x00, 0x7e, 0x89, 0xa3, 0x78, 0x7e, 0xa9, 0x03, 0xa6,
+  0x98, 0x69, 0x00, 0x00, 0x39, 0x29, 0x10, 0x00, 0x42, 0x00, 0xff, 0xf8,
+  0x7e, 0x89, 0xa3, 0x78, 0x7e, 0xa9, 0x03, 0xa6, 0x88, 0x69, 0x00, 0x00,
+  0x38, 0x63, 0x00, 0x01, 0x98, 0x69, 0x00, 0x00, 0x39, 0x29, 0x10, 0x00,
+  0x42, 0x00, 0xff, 0xf0, 0x38, 0x60, 0x00, 0x58, 0x38, 0x80, 0x00, 0x00,
+  0x38, 0xa0, 0x00, 0x01, 0x38, 0xc0, 0x00, 0x42, 0x78, 0xc6, 0xc1, 0xc6,
+  0x44, 0x00, 0x00, 0x22, 0x4b, 0xff, 0xff, 0xcc
+};
+
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b8617cc843..94d5057857 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -128,6 +128,7 @@ static char *bootpath;
  */
 #include "tests/migration/i386/a-b-bootblock.h"
 #include "tests/migration/aarch64/a-b-kernel.h"
+#include "tests/migration/ppc64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
 static void bootfile_create(char *dir, bool suspend_me)
@@ -147,10 +148,8 @@ static void bootfile_create(char *dir, bool suspend_me)
         content = s390x_elf;
         len = sizeof(s390x_elf);
     } else if (strcmp(arch, "ppc64") == 0) {
-        /*
-         * sane architectures can be programmed at the boot prompt
-         */
-        return;
+        content = ppc64_kernel;
+        len = sizeof(ppc64_kernel);
     } else if (strcmp(arch, "aarch64") == 0) {
         content = aarch64_kernel;
         len = sizeof(aarch64_kernel);
@@ -181,29 +180,10 @@ static void wait_for_serial(const char *side)
 {
     g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
     FILE *serialfile = fopen(serialpath, "r");
-    const char *arch = qtest_get_arch();
-    int started = (strcmp(side, "src_serial") == 0 &&
-                   strcmp(arch, "ppc64") == 0) ? 0 : 1;
 
     do {
         int readvalue = fgetc(serialfile);
 
-        if (!started) {
-            /* SLOF prints its banner before starting test,
-             * to ignore it, mark the start of the test with '_',
-             * ignore all characters until this marker
-             */
-            switch (readvalue) {
-            case '_':
-                started = 1;
-                break;
-            case EOF:
-                fseek(serialfile, 0, SEEK_SET);
-                usleep(1000);
-                break;
-            }
-            continue;
-        }
         switch (readvalue) {
         case 'A':
             /* Fine */
@@ -215,8 +195,6 @@ static void wait_for_serial(const char *side)
             return;
 
         case EOF:
-            started = (strcmp(side, "src_serial") == 0 &&
-                       strcmp(arch, "ppc64") == 0) ? 0 : 1;
             fseek(serialfile, 0, SEEK_SET);
             usleep(1000);
             break;
@@ -737,14 +715,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         memory_size = "256M";
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
-        arch_source = g_strdup_printf("-prom-env 'use-nvramrc?=true' -prom-env "
-                                      "'nvramrc=hex .\" _\" begin %x %x "
-                                      "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                      "until'", end_address, start_address);
         machine_alias = "pseries";
         machine_opts = "vsmt=8";
         arch_opts = g_strdup_printf("-nodefaults "
-                        "-machine " PSERIES_DEFAULT_CAPABILITIES);
+                        "-machine " PSERIES_DEFAULT_CAPABILITIES " "
+                        "-bios %s", bootpath);
     } else if (strcmp(arch, "aarch64") == 0) {
         memory_size = "150M";
         machine_alias = "virt";
diff --git a/tests/migration/Makefile b/tests/migration/Makefile
index 13e99b1692..2c5ee287ec 100644
--- a/tests/migration/Makefile
+++ b/tests/migration/Makefile
@@ -5,7 +5,7 @@
 # See the COPYING file in the top-level directory.
 #
 
-TARGET_LIST = i386 aarch64 s390x
+TARGET_LIST = i386 aarch64 s390x ppc64
 
 SRC_PATH = ../..
 
diff --git a/tests/migration/ppc64/Makefile b/tests/migration/ppc64/Makefile
new file mode 100644
index 0000000000..a3a2d98ac8
--- /dev/null
+++ b/tests/migration/ppc64/Makefile
@@ -0,0 +1,15 @@
+.PHONY: all clean
+all: a-b-kernel.h
+
+a-b-kernel.h: ppc64.kernel
+	echo "$$__note" > $@
+	xxd -i $< | sed -e 's/.*int.*//' >> $@
+
+ppc64.kernel: ppc64.elf
+	$(CROSS_PREFIX)objcopy -O binary -S $< $@
+
+ppc64.elf: a-b-kernel.S
+	$(CROSS_PREFIX)gcc -static -o $@ -nostdlib -Wl,--build-id=none $<
+
+clean:
+	$(RM) *.kernel *.elf
diff --git a/tests/migration/ppc64/a-b-kernel.S b/tests/migration/ppc64/a-b-kernel.S
new file mode 100644
index 0000000000..0613a8d18e
--- /dev/null
+++ b/tests/migration/ppc64/a-b-kernel.S
@@ -0,0 +1,66 @@
+#
+# Copyright (c) 2024 IBM, Inc
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+
+#include "../migration-test.h"
+
+.section .text
+
+.macro print ch
+	li	%r3,PPC_H_PUT_TERM_CHAR
+	li	%r4,0
+	li	%r5,1
+	li	%r6,\ch
+	sldi	%r6,%r6,56
+	sc	1
+.endm
+
+        .globl  _start
+_start:
+. = 0x100
+	/*
+	 * Enter 64-bit mode. Not necessary because the test uses 32-bit
+	 * addresses, but those constants could easily be changed and break
+	 * in 32-bit mode.
+	 */
+	mfmsr	%r9
+	li	%r10,-1
+	rldimi	%r9,%r10,63,0
+	mtmsrd	%r9
+
+        /*
+	 * Set up test memory region. Non-volatiles are used because the
+	 * hcall can clobber regs.
+	 * r20 - start address
+	 * r21 - number of pages
+	 */
+	lis	%r20,PPC_TEST_MEM_START@h
+	ori	%r20,%r20,PPC_TEST_MEM_START@l
+	lis	%r9,PPC_TEST_MEM_END@h
+	ori	%r9,%r9,PPC_TEST_MEM_END@l
+	subf	%r21,%r20,%r9
+	li	%r10,TEST_MEM_PAGE_SIZE
+	divd	%r21,%r21,%r10
+
+	print	'A'
+
+	li	%r3,0
+	mr	%r9,%r20
+	mtctr	%r21
+1:	stb	%r3,0(%r9)
+	addi	%r9,%r9,TEST_MEM_PAGE_SIZE
+	bdnz	1b
+
+loop:
+	mr	%r9,%r20
+	mtctr	%r21
+1:	lbz	%r3,0(%r9)
+	addi	%r3,%r3,1
+	stb	%r3,0(%r9)
+	addi	%r9,%r9,TEST_MEM_PAGE_SIZE
+	bdnz	1b
+
+	print	'B'
+	b	loop
-- 
2.43.0


