Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A277478F337
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 21:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbnAq-00005x-DR; Thu, 31 Aug 2023 15:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbnAc-0008WN-Qb
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbnAZ-0001wQ-B0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 15:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693509450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52qLlz5c3JUAJMjtDe1EUv+O4wVeVL3aowZhXNrGHO4=;
 b=eQP+aYwq6tsgieVGnh9r+vgYNq9+dKaUtJY+d6ztI746gkc0dx7YCaKwWItLjb9VTudXNa
 S2XEKk8ms69TtoUpryhHmf4kI8pCeroV3i9xZOK8aR9I+mIEO7oOa6nH6bKuK+lnB/L/uU
 j70iVXStI7k3iIiV1GcBHh5Hxejy/7A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-viIMyMamOSGV-91KvkdQmg-1; Thu, 31 Aug 2023 15:17:27 -0400
X-MC-Unique: viIMyMamOSGV-91KvkdQmg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01777101A5B4;
 Thu, 31 Aug 2023 19:17:27 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F1575CC05;
 Thu, 31 Aug 2023 19:17:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 2/7] tests/tcg/s390x: Test precise self-modifying code handling
Date: Thu, 31 Aug 2023 21:17:14 +0200
Message-Id: <20230831191719.140001-3-thuth@redhat.com>
In-Reply-To: <20230831191719.140001-1-thuth@redhat.com>
References: <20230831191719.140001-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add small softmmu and user tests to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230807114921.438881-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/precise-smc-user.c      | 39 +++++++++++++++
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/Makefile.target         |  1 +
 tests/tcg/s390x/precise-smc-softmmu.S   | 63 +++++++++++++++++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 tests/tcg/s390x/precise-smc-user.c
 create mode 100644 tests/tcg/s390x/precise-smc-softmmu.S

diff --git a/tests/tcg/s390x/precise-smc-user.c b/tests/tcg/s390x/precise-smc-user.c
new file mode 100644
index 0000000000..33a5270865
--- /dev/null
+++ b/tests/tcg/s390x/precise-smc-user.c
@@ -0,0 +1,39 @@
+/*
+ * Test s390x-linux-user precise self-modifying code handling.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <sys/mman.h>
+#include <stdint.h>
+#include <stdlib.h>
+
+extern __uint128_t __attribute__((__aligned__(1))) smc;
+extern __uint128_t __attribute__((__aligned__(1))) patch;
+
+int main(void)
+{
+    char *aligned_smc = (char *)((uintptr_t)&smc & ~0xFFFULL);
+    char *smc_end = (char *)&smc + sizeof(smc);
+    uint64_t value = 21;
+    int err;
+
+    err = mprotect(aligned_smc, smc_end - aligned_smc,
+                   PROT_READ | PROT_WRITE | PROT_EXEC);
+    assert(err == 0);
+
+    asm("jg 0f\n"                           /* start a new TB */
+        "patch: .byte 0,0,0,0,0,0\n"        /* replaces padding */
+        ".byte 0,0,0,0,0,0\n"               /* replaces vstl */
+        "agr %[value],%[value]\n"           /* replaces sgr */
+        "smc: .org . + 6\n"                 /* pad patched code to 16 bytes */
+        "0: vstl %[patch],%[idx],%[smc]\n"  /* start writing before TB */
+        "sgr %[value],%[value]"             /* this becomes `agr %r0,%r0` */
+        : [smc] "=R" (smc)
+        , [value] "+r" (value)
+        : [patch] "v" (patch)
+        , [idx] "r" (sizeof(patch) - 1)
+        : "cc");
+
+    return value == 42 ? EXIT_SUCCESS : EXIT_FAILURE;
+}
diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
index 76345b6e64..1a1f088b28 100644
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ b/tests/tcg/s390x/Makefile.softmmu-target
@@ -25,6 +25,7 @@ ASM_TESTS =                                                                    \
     lpswe-early                                                                \
     lra                                                                        \
     mc                                                                         \
+    precise-smc-softmmu                                                        \
     ssm-early                                                                  \
     stosm-early                                                                \
     stpq                                                                       \
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 9c0e70c6ca..c650aefe5c 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -61,6 +61,7 @@ Z13_TESTS+=locfhr
 Z13_TESTS+=vcksm
 Z13_TESTS+=vstl
 Z13_TESTS+=vrep
+Z13_TESTS+=precise-smc-user
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
diff --git a/tests/tcg/s390x/precise-smc-softmmu.S b/tests/tcg/s390x/precise-smc-softmmu.S
new file mode 100644
index 0000000000..f7fa57d899
--- /dev/null
+++ b/tests/tcg/s390x/precise-smc-softmmu.S
@@ -0,0 +1,63 @@
+/*
+ * Test s390x-softmmu precise self-modifying code handling.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+    .org 0x8e
+program_interruption_code:
+    .org 0x150
+program_old_psw:
+    .org 0x1D0                         /* program new PSW */
+    .quad 0x180000000,pgm              /* 64-bit mode */
+    .org 0x200                         /* lowcore padding */
+    .globl _start
+_start:
+    lctlg %c0,%c0,c0
+    lghi %r0,15
+
+    /* Test 1: replace sgr with agr. */
+    lghi %r1,21
+    vl %v0,patch1
+    jg 1f                              /* start a new TB */
+0:
+    .org . + 6                         /* pad patched code to 16 bytes */
+1:
+    vstl %v0,%r0,0b                    /* start writing before TB */
+    sgr %r1,%r1                        /* this becomes `agr %r1,%r1` */
+    cgijne %r1,42,failure
+
+    /* Test 2: replace agr with division by zero. */
+    vl %v0,patch2
+    jg 1f                              /* start a new TB */
+0:
+    .org . + 6                         /* pad patched code to 16 bytes */
+1:
+    vstl %v0,%r0,0b                    /* start writing before TB */
+    sgr %r1,%r1                        /* this becomes `d %r0,zero` */
+failure:
+    lpswe failure_psw
+
+pgm:
+    chhsi program_interruption_code,0x9          /* divide exception? */
+    jne failure
+    clc program_old_psw(16),expected_old_psw2    /* correct old PSW? */
+    jne failure
+    lpswe success_psw
+
+patch1:
+    .fill 12                           /* replaces padding and stpq */
+    agr %r1,%r1                        /* replaces sgr */
+patch2:
+    .fill 12                           /* replaces padding and stpq */
+    d %r0,zero                         /* replaces sgr */
+zero:
+    .long 0
+expected_old_psw2:
+    .quad 0x200180000000,failure       /* cc is from addition */
+    .align 8
+c0:
+    .quad 0x60000                      /* AFP, VX */
+success_psw:
+    .quad 0x2000000000000,0xfff        /* see is_special_wait_psw() */
+failure_psw:
+    .quad 0x2000000000000,0            /* disabled wait */
-- 
2.39.3


