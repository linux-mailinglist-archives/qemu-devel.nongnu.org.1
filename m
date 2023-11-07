Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD17E4859
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:34:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qsh-0002v7-GG; Tue, 07 Nov 2023 13:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0Qsf-0002uc-OD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0Qsc-0007Q6-FU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0hRYBjcj2W+Zbjl0cv92FXFJYMNyto1lD0c7MJweonU=;
 b=NOyvf9JgzV/tT/PNcs8ZSqvIkvjJj2weinDFOsa6hSavkc1nzebUVQn7jMtlzfwpPDx7w4
 w9sBJD9r/2NL8FOXQvOeHceCXKDEfQV+LbYsZSyguYlBfXGVi6TBej0rO23riQBrEFLLQs
 2/hyK4BO6Ktv1NLMpTjkjUhqm59gy4Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-toyCzIfqObGn2SKJEJ0XYQ-1; Tue, 07 Nov 2023 13:32:48 -0500
X-MC-Unique: toyCzIfqObGn2SKJEJ0XYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62FDF9423C1;
 Tue,  7 Nov 2023 18:32:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1911F2166B26;
 Tue,  7 Nov 2023 18:32:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 10/11] tests/tcg/s390x: Test ADD LOGICAL WITH CARRY
Date: Tue,  7 Nov 2023 19:32:27 +0100
Message-ID: <20231107183228.276424-11-thuth@redhat.com>
In-Reply-To: <20231107183228.276424-1-thuth@redhat.com>
References: <20231107183228.276424-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a test that tries different combinations of ADD LOGICAL WITH
CARRY instructions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20231106093605.1349201-6-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/add-logical-with-carry.c | 156 +++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target          |   1 +
 2 files changed, 157 insertions(+)
 create mode 100644 tests/tcg/s390x/add-logical-with-carry.c

diff --git a/tests/tcg/s390x/add-logical-with-carry.c b/tests/tcg/s390x/add-logical-with-carry.c
new file mode 100644
index 0000000000..d982f8a651
--- /dev/null
+++ b/tests/tcg/s390x/add-logical-with-carry.c
@@ -0,0 +1,156 @@
+/*
+ * Test ADD LOGICAL WITH CARRY instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdio.h>
+#include <stdlib.h>
+
+static const struct test {
+    const char *name;
+    unsigned long values[3];
+    unsigned long exp_sum;
+    int exp_cc;
+} tests[] = {
+    /*
+     * Each test starts with CC 0 and executes two chained ADD LOGICAL WITH
+     * CARRY instructions on three input values. The values must be compatible
+     * with both 32- and 64-bit test functions.
+     */
+
+    /* NAME       VALUES       EXP_SUM EXP_CC */
+    { "cc0->cc0", {0, 0, 0},   0,      0, },
+    { "cc0->cc1", {0, 0, 42},  42,     1, },
+    /* cc0->cc2 is not possible */
+    /* cc0->cc3 is not possible */
+    /* cc1->cc0 is not possible */
+    { "cc1->cc1", {-3, 1, 1},  -1,     1, },
+    { "cc1->cc2", {-3, 1, 2},  0,      2, },
+    { "cc1->cc3", {-3, 1, -1}, -3,     3, },
+    /* cc2->cc0 is not possible */
+    { "cc2->cc1", {-1, 1, 1},  2,      1, },
+    { "cc2->cc2", {-1, 1, -1}, 0,      2, },
+    /* cc2->cc3 is not possible */
+    /* cc3->cc0 is not possible */
+    { "cc3->cc1", {-1, 2, 1},  3,      1, },
+    { "cc3->cc2", {-1, 2, -2}, 0,      2, },
+    { "cc3->cc3", {-1, 2, -1}, 1,      3, },
+};
+
+/* Test ALCR (register variant) followed by ALC (memory variant). */
+static unsigned long test32rm(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    unsigned int a32 = a, b32 = b, c32 = c;
+
+    asm("xr %[cc],%[cc]\n"
+        "alcr %[a],%[b]\n"
+        "alc %[a],%[c]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a32), [cc] "+&r" (*cc)
+        : [b] "r" (b32), [c] "T" (c32)
+        : "cc");
+    *cc >>= 28;
+
+    return (int)a32;
+}
+
+/* Test ALC (memory variant) followed by ALCR (register variant). */
+static unsigned long test32mr(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    unsigned int a32 = a, b32 = b, c32 = c;
+
+    asm("xr %[cc],%[cc]\n"
+        "alc %[a],%[b]\n"
+        "alcr %[c],%[a]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a32), [c] "+&r" (c32), [cc] "+&r" (*cc)
+        : [b] "T" (b32)
+        : "cc");
+    *cc >>= 28;
+
+    return (int)c32;
+}
+
+/* Test ALCGR (register variant) followed by ALCG (memory variant). */
+static unsigned long test64rm(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    asm("xr %[cc],%[cc]\n"
+        "alcgr %[a],%[b]\n"
+        "alcg %[a],%[c]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a), [cc] "+&r" (*cc)
+        : [b] "r" (b), [c] "T" (c)
+        : "cc");
+    *cc >>= 28;
+    return a;
+}
+
+/* Test ALCG (memory variant) followed by ALCGR (register variant). */
+static unsigned long test64mr(unsigned long a, unsigned long b,
+                              unsigned long c, int *cc)
+{
+    asm("xr %[cc],%[cc]\n"
+        "alcg %[a],%[b]\n"
+        "alcgr %[c],%[a]\n"
+        "ipm %[cc]"
+        : [a] "+&r" (a), [c] "+&r" (c), [cc] "+&r" (*cc)
+        : [b] "T" (b)
+        : "cc");
+    *cc >>= 28;
+    return c;
+}
+
+static const struct test_func {
+    const char *name;
+    unsigned long (*ptr)(unsigned long, unsigned long, unsigned long, int *);
+} test_funcs[] = {
+    { "test32rm", test32rm },
+    { "test32mr", test32mr },
+    { "test64rm", test64rm },
+    { "test64mr", test64mr },
+};
+
+static const struct test_perm {
+    const char *name;
+    size_t a_idx, b_idx, c_idx;
+} test_perms[] = {
+    { "a, b, c", 0, 1, 2 },
+    { "b, a, c", 1, 0, 2 },
+};
+
+int main(void)
+{
+    unsigned long a, b, c, sum;
+    int result = EXIT_SUCCESS;
+    const struct test_func *f;
+    const struct test_perm *p;
+    size_t i, j, k;
+    const struct test *t;
+    int cc;
+
+    for (i = 0; i < sizeof(tests) / sizeof(tests[0]); i++) {
+        t = &tests[i];
+        for (j = 0; j < sizeof(test_funcs) / sizeof(test_funcs[0]); j++) {
+            f = &test_funcs[j];
+            for (k = 0; k < sizeof(test_perms) / sizeof(test_perms[0]); k++) {
+                p = &test_perms[k];
+                a = t->values[p->a_idx];
+                b = t->values[p->b_idx];
+                c = t->values[p->c_idx];
+                sum = f->ptr(a, b, c, &cc);
+                if (sum != t->exp_sum || cc != t->exp_cc) {
+                    fprintf(stderr,
+                            "[  FAILED  ] %s %s(0x%lx, 0x%lx, 0x%lx) returned 0x%lx cc %d, expected 0x%lx cc %d\n",
+                            t->name, f->name, a, b, c, sum, cc,
+                            t->exp_sum, t->exp_cc);
+                    result = EXIT_FAILURE;
+                }
+            }
+        }
+    }
+
+    return result;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index a476547b65..0e670f3f8b 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -43,6 +43,7 @@ TESTS+=cgebra
 TESTS+=clgebr
 TESTS+=clc
 TESTS+=laalg
+TESTS+=add-logical-with-carry
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.41.0


