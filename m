Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DBDBA3B7F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 14:57:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v27wc-0007WD-92; Fri, 26 Sep 2025 08:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27w1-0006ET-4I; Fri, 26 Sep 2025 08:52:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v27vo-0007qI-Lm; Fri, 26 Sep 2025 08:52:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6F77B157F6E;
 Fri, 26 Sep 2025 15:45:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4859290F2C;
 Fri, 26 Sep 2025 15:45:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 38/38] tests/tcg/multiarch: Add tb-link test
Date: Fri, 26 Sep 2025 15:45:38 +0300
Message-ID: <20250926124540.2221746-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20250926154509@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit e13e1195db8af18e149065a59351ea85215645bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 45c9cfe18c..cfecf65c2d 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -45,6 +45,8 @@ vma-pthread: LDFLAGS+=-pthread
 sigreturn-sigmask: CFLAGS+=-pthread
 sigreturn-sigmask: LDFLAGS+=-pthread
 
+tb-link: LDFLAGS+=-lpthread
+
 # GCC versions 12/13/14/15 at least incorrectly complain about
 # "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gcc bug
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
diff --git a/tests/tcg/multiarch/tb-link.c b/tests/tcg/multiarch/tb-link.c
new file mode 100644
index 0000000000..4e40306fa1
--- /dev/null
+++ b/tests/tcg/multiarch/tb-link.c
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Verify that a single TB spin-loop is properly invalidated,
+ * releasing the thread from the spin-loop.
+ */
+
+#include <assert.h>
+#include <sys/mman.h>
+#include <pthread.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <sched.h>
+
+
+#ifdef __x86_64__
+#define READY   0x000047c6      /* movb $0,0(%rdi) */
+#define LOOP    0xfceb9090      /* 1: nop*2; jmp 1b */
+#define RETURN  0x909090c3      /* ret; nop*3 */
+#define NOP     0x90909090      /* nop*4 */
+#elif defined(__aarch64__)
+#define READY   0x3900001f      /* strb wzr,[x0] */
+#define LOOP    0x14000000      /* b . */
+#define RETURN  0xd65f03c0      /* ret */
+#define NOP     0xd503201f      /* nop */
+#elif defined(__riscv)
+#define READY   0x00050023      /* sb zero, (a0) */
+#define LOOP    0x0000006f      /* jal zero, #0 */
+#define RETURN  0x00008067      /* jalr zero, ra, 0 */
+#define NOP     0x00000013      /* nop */
+#endif
+
+
+int main()
+{
+#ifdef READY
+    int tmp;
+    pthread_t thread_id;
+    bool hold = true;
+    uint32_t *buf;
+
+    buf = mmap(NULL, 3 * sizeof(uint32_t),
+               PROT_READ | PROT_WRITE | PROT_EXEC,
+               MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+    assert(buf != MAP_FAILED);
+
+    buf[0] = READY;
+    buf[1] = LOOP;
+    buf[2] = RETURN;
+
+    alarm(2);
+
+    tmp = pthread_create(&thread_id, NULL, (void *(*)(void *))buf, &hold);
+    assert(tmp == 0);
+
+    while (hold) {
+        sched_yield();
+    }
+
+    buf[1] = NOP;
+    __builtin___clear_cache(&buf[1], &buf[2]);
+
+    tmp = pthread_join(thread_id, NULL);
+    assert(tmp == 0);
+#endif
+    return 0;
+}
-- 
2.47.3


