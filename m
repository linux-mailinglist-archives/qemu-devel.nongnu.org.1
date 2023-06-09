Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 735AA72BCE4
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8e2p-0008Bk-VR; Mon, 12 Jun 2023 05:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q8e2V-00084X-N4
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:40:52 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q8e2S-0002tn-Cz
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:40:43 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id C21AC11EEDE;
 Mon, 12 Jun 2023 09:40:36 +0000 (UTC)
From: ~jhogberg <jhogberg@git.sr.ht>
Date: Fri, 09 Jun 2023 14:04:14 +0200
Subject: [PATCH qemu v2 2/2] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
MIME-Version: 1.0
Message-ID: <168656283612.26761.9869630057811681568-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168656283612.26761.9869630057811681568-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 tests/tcg/aarch64/icivau.c        | 204 ++++++++++++++++++++++++++++++
 2 files changed, 206 insertions(+), 1 deletion(-)
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
index 0000000000..ff80d3d868
--- /dev/null
+++ b/tests/tcg/aarch64/icivau.c
@@ -0,0 +1,204 @@
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#define PAYLOAD_SIZE (256)
+
+typedef int (*SelfModTestPtr)(char *, const char*, int);
+typedef int (*CompareTestPtr)(int, int);
+
+void flush_icache(const char *exec_data, size_t length)
+{
+    size_t dcache_stride, icache_stride, i;
+    unsigned long ctr_el0;
+
+    /*
+     * Step according to minimum cache sizes, as the cache maintenance
+     * instructions operate on the cache line of the given address.
+     *
+     * We assume that exec_data is properly aligned.
+     */
+    __asm__("mrs %0, ctr_el0\n" : "=3Dr"(ctr_el0));
+    dcache_stride =3D (4 << ((ctr_el0 >> 16) & 0xF));
+    icache_stride =3D (4 << (ctr_el0 & 0xF));
+
+    for (i =3D 0; i < length; i +=3D dcache_stride) {
+        const char *dc_addr =3D &exec_data[i];
+        __asm__ ("dc cvau, %x[dc_addr]\n"
+                 : /* no outputs */
+                 : [dc_addr] "r"(dc_addr)
+                 : "memory");
+    }
+
+    __asm__ ("dmb ish\n");
+
+    for (i =3D 0; i < length; i +=3D icache_stride) {
+        const char *ic_addr =3D &exec_data[i];
+        __asm__ ("ic ivau, %x[ic_addr]\n"
+                 : /* no outputs */
+                 : [ic_addr] "r"(ic_addr)
+                 : "memory");
+    }
+
+    __asm__ ("dmb ish\n"
+             "isb sy\n");
+}
+
+/*
+ * The unmodified assembly of this function returns 0, it self-modifies to
+ * return the value indicated by new_move.
+ */
+int self_modification_payload(char *rw_data, const char *exec_data,
+                              int new_move)
+{
+    register int result __asm__ ("w0") =3D new_move;
+
+    __asm__ (/* Get the writable address of __modify_me. */
+             "sub %x[rw_data], %x[rw_data], %x[exec_data]\n"
+             "adr %x[exec_data], __modify_me\n"
+             "add %x[rw_data], %x[rw_data], %x[exec_data]\n"
+             /* Overwrite the `MOV W0, #0` with the new move. */
+             "str %w[result], [%x[rw_data]]\n"
+             /*
+              * Mark the code as modified.
+              *
+              * Note that we align to the nearest 64 bytes in an attempt to =
put
+              * the flush sequence in the same cache line as the modified mo=
ve.
+              */
+             ".align 6\n"
+             "dc cvau, %x[exec_data]\n"
+             ".align 2\n"
+             "dmb ish\n"
+             "ic ivau, %x[exec_data]\n"
+             "dmb ish\n"
+             "isb sy\n"
+             "__modify_me: mov w0, #0x0\n"
+             : [result] "+r"(result),
+               [rw_data] "+r"(rw_data),
+               [exec_data] "+r"(exec_data)
+             : /* No untouched inputs */
+             : "memory");
+
+    return result;
+}
+
+int self_modification_test(char *rw_data, const char *exec_data)
+{
+    SelfModTestPtr copied_ptr =3D (SelfModTestPtr)exec_data;
+    int i;
+
+    /*
+     * Bluntly assumes that the payload is position-independent and not larg=
er
+     * than PAYLOAD_SIZE.
+     */
+    memcpy(rw_data, self_modification_payload, PAYLOAD_SIZE);
+
+    /*
+     * Notify all PEs that the code at exec_data has been altered.
+     *
+     * For completeness we could assert that we should fail when this is
+     * omitted, which works in user mode and on actual hardware as the
+     * modification won't "take," but doesn't work in system mode as the
+     * softmmu handles everything for us.
+     */
+    flush_icache(exec_data, PAYLOAD_SIZE);
+
+    for (i =3D 1; i < 10; i++) {
+        const int mov_w0_template =3D 0x52800000;
+
+        /* MOV W0, i */
+        if (copied_ptr(rw_data, exec_data, mov_w0_template | (i << 5)) !=3D =
i) {
+            return 0;
+        }
+    }
+
+    return 1;
+}
+
+int compare_copied(char *rw_data, const char *exec_data,
+                   int (*reference_ptr)(int, int))
+{
+    CompareTestPtr copied_ptr =3D (CompareTestPtr)exec_data;
+    int a, b;
+
+    memcpy(rw_data, reference_ptr, PAYLOAD_SIZE);
+    flush_icache(exec_data, PAYLOAD_SIZE);
+
+    for (a =3D 1; a < 10; a++) {
+        for (b =3D 1; b < 10; b++) {
+            if (copied_ptr(a, b) !=3D reference_ptr(a, b)) {
+                return 0;
+            }
+        }
+    }
+
+    return 1;
+}
+
+int compare_alpha(int a, int b)
+{
+    return a + b;
+}
+
+int compare_beta(int a, int b)
+{
+    return a - b;
+}
+
+int compare_gamma(int a, int b)
+{
+    return a * b;
+}
+
+int compare_delta(int a, int b)
+{
+    return a / b;
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
+    if (ftruncate(fd, PAYLOAD_SIZE) =3D=3D 0) {
+        const char *exec_data;
+        char *rw_data;
+
+        rw_data =3D mmap(0, PAYLOAD_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED,
+                       fd, 0);
+        exec_data =3D mmap(0, PAYLOAD_SIZE, PROT_READ | PROT_EXEC, MAP_SHARE=
D,
+                         fd, 0);
+
+        if (rw_data && exec_data) {
+            CompareTestPtr compare_tests[4] =3D {compare_alpha,
+                                               compare_beta,
+                                               compare_gamma,
+                                               compare_delta};
+            int success, i;
+
+            success =3D self_modification_test(rw_data, exec_data);
+
+            for (i =3D 0; i < 4; i++) {
+                success &=3D compare_copied(rw_data, exec_data, compare_test=
s[i]);
+            }
+
+            if (success) {
+                return EXIT_SUCCESS;
+            }
+        }
+    }
+
+    return EXIT_FAILURE;
+}
--=20
2.38.5

