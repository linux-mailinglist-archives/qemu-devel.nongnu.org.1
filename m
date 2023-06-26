Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F7373EA85
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 20:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrJD-0004fu-4R; Mon, 26 Jun 2023 14:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJA-0004eF-67; Mon, 26 Jun 2023 14:51:28 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrJ4-00050p-Ir; Mon, 26 Jun 2023 14:51:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2727EEF27;
 Mon, 26 Jun 2023 21:50:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9838EF7B6;
 Mon, 26 Jun 2023 21:50:19 +0300 (MSK)
Received: (nullmailer pid 1574006 invoked by uid 1000);
 Mon, 26 Jun 2023 18:50:16 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.3 16/54] tests/tcg/s390x: Test EXECUTE of relative
 branches
Date: Mon, 26 Jun 2023 21:49:23 +0300
Message-Id: <20230626185002.1573836-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
References: <qemu-stable-8.0.3-20230626214235@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230426235813.198183-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit bfa72590df14e4c94c03d2464f3abe18bf2e5dac)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: forgotten testcase for commit b858c53ef632b80f3269773a18b17639b1eec62c)

diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0031868b13..23dc8b6a63 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -34,6 +34,7 @@ TESTS+=cdsg
 TESTS+=chrl
 TESTS+=rxsbg
 TESTS+=ex-relative-long
+TESTS+=ex-branch
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
diff --git a/tests/tcg/s390x/ex-branch.c b/tests/tcg/s390x/ex-branch.c
new file mode 100644
index 0000000000..c606719152
--- /dev/null
+++ b/tests/tcg/s390x/ex-branch.c
@@ -0,0 +1,158 @@
+/* Check EXECUTE with relative branch instructions as targets. */
+#include <assert.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+struct test {
+    const char *name;
+    void (*func)(long *link, long *magic);
+    long exp_link;
+};
+
+/* Branch instructions and their expected effects. */
+#define LINK_64(test) ((long)test ## _exp_link)
+#define LINK_NONE(test) -1L
+#define FOR_EACH_INSN(F)                                                       \
+    F(bras,  "%[link]",     LINK_64)                                           \
+    F(brasl, "%[link]",     LINK_64)                                           \
+    F(brc,   "0x8",         LINK_NONE)                                         \
+    F(brcl,  "0x8",         LINK_NONE)                                         \
+    F(brct,  "%%r0",        LINK_NONE)                                         \
+    F(brctg, "%%r0",        LINK_NONE)                                         \
+    F(brxh,  "%%r2,%%r0",   LINK_NONE)                                         \
+    F(brxhg, "%%r2,%%r0",   LINK_NONE)                                         \
+    F(brxle, "%%r0,%%r1",   LINK_NONE)                                         \
+    F(brxlg, "%%r0,%%r1",   LINK_NONE)                                         \
+    F(crj,   "%%r0,%%r0,8", LINK_NONE)                                         \
+    F(cgrj,  "%%r0,%%r0,8", LINK_NONE)                                         \
+    F(cij,   "%%r0,0,8",    LINK_NONE)                                         \
+    F(cgij,  "%%r0,0,8",    LINK_NONE)                                         \
+    F(clrj,  "%%r0,%%r0,8", LINK_NONE)                                         \
+    F(clgrj, "%%r0,%%r0,8", LINK_NONE)                                         \
+    F(clij,  "%%r0,0,8",    LINK_NONE)                                         \
+    F(clgij, "%%r0,0,8",    LINK_NONE)
+
+#define INIT_TEST                                                              \
+    "xgr %%r0,%%r0\n"  /* %r0 = 0; %cc = 0 */                                  \
+    "lghi %%r1,1\n"    /* %r1 = 1 */                                           \
+    "lghi %%r2,2\n"    /* %r2 = 2 */
+
+#define CLOBBERS_TEST "cc", "0", "1", "2"
+
+#define DEFINE_TEST(insn, args, exp_link)                                      \
+    extern char insn ## _exp_link[];                                           \
+    static void test_ ## insn(long *link, long *magic)                         \
+    {                                                                          \
+        asm(INIT_TEST                                                          \
+            #insn " " args ",0f\n"                                             \
+            ".globl " #insn "_exp_link\n"                                      \
+            #insn "_exp_link:\n"                                               \
+            ".org . + 90\n"                                                    \
+            "0: lgfi %[magic],0x12345678\n"                                    \
+            : [link] "+r" (*link)                                              \
+            , [magic] "+r" (*magic)                                            \
+            : : CLOBBERS_TEST);                                                \
+    }                                                                          \
+    extern char ex_ ## insn ## _exp_link[];                                    \
+    static void test_ex_ ## insn(long *link, long *magic)                      \
+    {                                                                          \
+        unsigned long target;                                                  \
+                                                                               \
+        asm(INIT_TEST                                                          \
+            "larl %[target],0f\n"                                              \
+            "ex %%r0,0(%[target])\n"                                           \
+            ".globl ex_" #insn "_exp_link\n"                                   \
+            "ex_" #insn "_exp_link:\n"                                         \
+            ".org . + 60\n"                                                    \
+            "0: " #insn " " args ",1f\n"                                       \
+            ".org . + 120\n"                                                   \
+            "1: lgfi %[magic],0x12345678\n"                                    \
+            : [target] "=r" (target)                                           \
+            , [link] "+r" (*link)                                              \
+            , [magic] "+r" (*magic)                                            \
+            : : CLOBBERS_TEST);                                                \
+    }                                                                          \
+    extern char exrl_ ## insn ## _exp_link[];                                  \
+    static void test_exrl_ ## insn(long *link, long *magic)                    \
+    {                                                                          \
+        asm(INIT_TEST                                                          \
+            "exrl %%r0,0f\n"                                                   \
+            ".globl exrl_" #insn "_exp_link\n"                                 \
+            "exrl_" #insn "_exp_link:\n"                                       \
+            ".org . + 60\n"                                                    \
+            "0: " #insn " " args ",1f\n"                                       \
+            ".org . + 120\n"                                                   \
+            "1: lgfi %[magic],0x12345678\n"                                    \
+            : [link] "+r" (*link)                                              \
+            , [magic] "+r" (*magic)                                            \
+            : : CLOBBERS_TEST);                                                \
+    }
+
+/* Test functions. */
+FOR_EACH_INSN(DEFINE_TEST)
+
+/* Test definitions. */
+#define REGISTER_TEST(insn, args, _exp_link)                                   \
+    {                                                                          \
+        .name = #insn,                                                         \
+        .func = test_ ## insn,                                                 \
+        .exp_link = (_exp_link(insn)),                                         \
+    },                                                                         \
+    {                                                                          \
+        .name = "ex " #insn,                                                   \
+        .func = test_ex_ ## insn,                                              \
+        .exp_link = (_exp_link(ex_ ## insn)),                                  \
+    },                                                                         \
+    {                                                                          \
+        .name = "exrl " #insn,                                                 \
+        .func = test_exrl_ ## insn,                                            \
+        .exp_link = (_exp_link(exrl_ ## insn)),                                \
+    },
+
+static const struct test tests[] = {
+    FOR_EACH_INSN(REGISTER_TEST)
+};
+
+int main(int argc, char **argv)
+{
+    const struct test *test;
+    int ret = EXIT_SUCCESS;
+    bool verbose = false;
+    long link, magic;
+    size_t i;
+
+    for (i = 1; i < argc; i++) {
+        if (strcmp(argv[i], "-v") == 0) {
+            verbose = true;
+        }
+    }
+
+    for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+        test = &tests[i];
+        if (verbose) {
+            fprintf(stderr, "[ RUN      ] %s\n", test->name);
+        }
+        link = -1;
+        magic = -1;
+        test->func(&link, &magic);
+#define ASSERT_EQ(expected, actual) do {                                       \
+    if (expected != actual) {                                                  \
+        fprintf(stderr, "%s: " #expected " (0x%lx) != " #actual " (0x%lx)\n",  \
+                test->name, expected, actual);                                 \
+        ret = EXIT_FAILURE;                                                    \
+    }                                                                          \
+} while (0)
+        ASSERT_EQ(test->exp_link, link);
+        ASSERT_EQ(0x12345678L, magic);
+#undef ASSERT_EQ
+    }
+
+    if (verbose) {
+        fprintf(stderr, ret == EXIT_SUCCESS ? "[  PASSED  ]\n" :
+                                              "[  FAILED  ]\n");
+    }
+
+    return ret;
+}
-- 
2.39.2


