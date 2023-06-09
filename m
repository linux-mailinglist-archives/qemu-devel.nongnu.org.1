Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2A73E1CA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 16:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmzq-0004Nt-94; Mon, 26 Jun 2023 10:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qDmzk-0004NC-C4
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:15:08 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qDmzh-0002po-VQ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 10:15:08 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 3396A11F041;
 Mon, 26 Jun 2023 14:15:04 +0000 (UTC)
From: ~jhogberg <jhogberg@git.sr.ht>
Date: Fri, 09 Jun 2023 14:04:14 +0200
Subject: [PATCH qemu v4 2/2] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
MIME-Version: 1.0
Message-ID: <168778890374.24232.3402138851538068785-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168778890374.24232.3402138851538068785-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~jhogberg <john.hogberg@ericsson.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: John H=C3=B6gberg <john.hogberg@ericsson.com>

https://gitlab.com/qemu-project/qemu/-/issues/1034

Signed-off-by: John H=C3=B6gberg <john.hogberg@ericsson.com>
---
 tests/tcg/aarch64/Makefile.target |   3 +-
 tests/tcg/aarch64/icivau.c        | 189 ++++++++++++++++++++++++++++++
 2 files changed, 191 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/aarch64/icivau.c

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.t=
arget
index 3430fd3cd8..de6566d0d4 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -9,9 +9,10 @@ AARCH64_SRC=3D$(SRC_PATH)/tests/tcg/aarch64
 VPATH 		+=3D $(AARCH64_SRC)
=20
 # Base architecture tests
-AARCH64_TESTS=3Dfcvt pcalign-a64
+AARCH64_TESTS=3Dfcvt pcalign-a64 icivau
=20
 fcvt: LDFLAGS+=3D-lm
+icivau: LDFLAGS+=3D-lrt
=20
 run-fcvt: fcvt
 	$(call run-test,$<,$(QEMU) $<, "$< on $(TARGET_NAME)")
diff --git a/tests/tcg/aarch64/icivau.c b/tests/tcg/aarch64/icivau.c
new file mode 100644
index 0000000000..e3e8569912
--- /dev/null
+++ b/tests/tcg/aarch64/icivau.c
@@ -0,0 +1,189 @@
+/*
+ * Tests the IC IVAU-driven workaround for catching changes made to dual-map=
ped
+ * code that would otherwise go unnoticed in user mode.
+ *
+ * Copyright (c) 2023 Ericsson AB
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#define MAX_CODE_SIZE 128
+
+typedef int (SelfModTest)(uint32_t, uint32_t*);
+typedef int (BasicTest)(int);
+
+static void mark_code_modified(const uint32_t *exec_data, size_t length)
+{
+    int dc_required, ic_required;
+    unsigned long ctr_el0;
+
+    /*
+     * Clear the data/instruction cache, as indicated by the CTR_ELO.{DIC,ID=
C}
+     * flags.
+     *
+     * For completeness we might be tempted to assert that we should fail wh=
en
+     * the whole code update sequence is omitted, but that would make the te=
st
+     * flaky as it can succeed by coincidence on actual hardware.
+     */
+    asm ("mrs %0, ctr_el0\n" : "=3Dr"(ctr_el0));
+
+    /* CTR_EL0.IDC */
+    dc_required =3D !((ctr_el0 >> 28) & 1);
+
+    /* CTR_EL0.DIC */
+    ic_required =3D !((ctr_el0 >> 29) & 1);
+
+    if (dc_required) {
+        size_t dcache_stride, i;
+
+        /*
+         * Step according to the minimum cache size, as the cache maintenance
+         * instructions operate on the cache line of the given address.
+         *
+         * We assume that exec_data is properly aligned.
+         */
+        dcache_stride =3D (4 << ((ctr_el0 >> 16) & 0xF));
+
+        for (i =3D 0; i < length; i +=3D dcache_stride) {
+            const char *dc_addr =3D &((const char *)exec_data)[i];
+            asm volatile ("dc cvau, %x[dc_addr]\n"
+                          : /* no outputs */
+                          : [dc_addr] "r"(dc_addr)
+                          : "memory");
+        }
+
+        asm volatile ("dmb ish\n");
+    }
+
+    if (ic_required) {
+        size_t icache_stride, i;
+
+        icache_stride =3D (4 << (ctr_el0 & 0xF));
+
+        for (i =3D 0; i < length; i +=3D icache_stride) {
+            const char *ic_addr =3D &((const char *)exec_data)[i];
+            asm volatile ("ic ivau, %x[ic_addr]\n"
+                          : /* no outputs */
+                          : [ic_addr] "r"(ic_addr)
+                          : "memory");
+        }
+
+        asm volatile ("dmb ish\n");
+    }
+
+    asm volatile ("isb sy\n");
+}
+
+static int basic_test(uint32_t *rw_data, const uint32_t *exec_data)
+{
+    /*
+     * As user mode only misbehaved for dual-mapped code when previously
+     * translated code had been changed, we'll start off with this basic test
+     * function to ensure that there's already some translated code at
+     * exec_data before the next test. This should cause the next test to fa=
il
+     * if `mark_code_modified` fails to invalidate the code.
+     *
+     * Note that the payload is in binary form instead of inline assembler
+     * because we cannot use __attribute__((naked)) on this platform and the
+     * workarounds are at least as ugly as this is.
+     */
+    static const uint32_t basic_payload[] =3D {
+        0xD65F03C0 /* 0x00: RET */
+    };
+
+    BasicTest *copied_ptr =3D (BasicTest *)exec_data;
+
+    memcpy(rw_data, basic_payload, sizeof(basic_payload));
+    mark_code_modified(exec_data, sizeof(basic_payload));
+
+    return copied_ptr(1234) =3D=3D 1234;
+}
+
+static int self_modification_test(uint32_t *rw_data, const uint32_t *exec_da=
ta)
+{
+    /*
+     * This test is self-modifying in an attempt to cover an edge case where
+     * the IC IVAU instruction invalidates itself.
+     *
+     * Note that the IC IVAU instruction is 16 bytes into the function, in w=
hat
+     * will be the same cache line as the modifed instruction on machines wi=
th
+     * a cache line size >=3D 16 bytes.
+     */
+    static const uint32_t self_mod_payload[] =3D {
+        /* Overwrite the placeholder instruction with the new one. */
+        0xB9001C20, /* 0x00: STR w0, [x1, 0x1C] */
+
+        /* Get the executable address of the modified instruction. */
+        0x100000A8, /* 0x04: ADR x8, <0x1C> */
+
+        /* Mark the modified instruction as updated. */
+        0xD50B7B28, /* 0x08: DC CVAU x8 */
+        0xD5033BBF, /* 0x0C: DMB ISH */
+        0xD50B7528, /* 0x10: IC IVAU x8 */
+        0xD5033BBF, /* 0x14: DMB ISH */
+        0xD5033FDF, /* 0x18: ISB */
+
+        /* Placeholder instruction, overwritten above. */
+        0x52800000, /* 0x1C: MOV w0, 0 */
+
+        0xD65F03C0  /* 0x20: RET */
+    };
+
+    SelfModTest *copied_ptr =3D (SelfModTest *)exec_data;
+    int i;
+
+    memcpy(rw_data, self_mod_payload, sizeof(self_mod_payload));
+    mark_code_modified(exec_data, sizeof(self_mod_payload));
+
+    for (i =3D 1; i < 10; i++) {
+        /* Replace the placeholder instruction with `MOV w0, i` */
+        uint32_t new_instr =3D 0x52800000 | (i << 5);
+
+        if (copied_ptr(new_instr, rw_data) !=3D i) {
+            return 0;
+        }
+    }
+
+    return 1;
+}
+
+int main(int argc, char **argv)
+{
+    const char *shm_name =3D "qemu-test-tcg-aarch64-icivau";
+    int fd;
+
+    fd =3D shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
+
+    if (fd < 0) {
+        return EXIT_FAILURE;
+    }
+
+    /* Unlink early to avoid leaving garbage in case the test crashes. */
+    shm_unlink(shm_name);
+
+    if (ftruncate(fd, MAX_CODE_SIZE) =3D=3D 0) {
+        const uint32_t *exec_data;
+        uint32_t *rw_data;
+
+        rw_data =3D mmap(0, MAX_CODE_SIZE, PROT_READ | PROT_WRITE,
+                       MAP_SHARED, fd, 0);
+        exec_data =3D mmap(0, MAX_CODE_SIZE, PROT_READ | PROT_EXEC,
+                         MAP_SHARED, fd, 0);
+
+        if (rw_data && exec_data) {
+            if (basic_test(rw_data, exec_data) &&
+                self_modification_test(rw_data, exec_data)) {
+                return EXIT_SUCCESS;
+            }
+        }
+    }
+
+    return EXIT_FAILURE;
+}
--=20
2.38.5

