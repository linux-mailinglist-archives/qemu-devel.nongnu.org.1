Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73161785719
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJl-0001Zj-0A; Wed, 23 Aug 2023 07:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJM-0001WB-GB
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJK-0001Vc-S4
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZKzgd+PwDSw1IXSdBOzJq70FmczDucXQ+0ZBaWhhhDk=;
 b=GNW8Q9bnLJw6tmbM8cjdZRpAaQkOTLbMyZH5KBV1d43UqmGQCKTBLEQoidQE9tICAtVKci
 ljg7ZKMhY8eEDFKvX4/1na9fk3NY5kO3lYpiY1UiVQeq7je3QPOKTkF+V2QOrpq8+JLtjx
 lX1CtTbfIxgiIOLjSCssUbC5IOE8xkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-5ZiGSViMOQWpIIGrqFLK-w-1; Wed, 23 Aug 2023 07:46:04 -0400
X-MC-Unique: 5ZiGSViMOQWpIIGrqFLK-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2936B857A84;
 Wed, 23 Aug 2023 11:46:04 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4C7C15BAE;
 Wed, 23 Aug 2023 11:46:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 12/12] tests/tcg/s390x: Test VSTRS
Date: Wed, 23 Aug 2023 13:45:44 +0200
Message-Id: <20230823114544.216520-13-thuth@redhat.com>
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230804233748.218935-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/vxeh2_vstrs.c   | 88 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 89 insertions(+)
 create mode 100644 tests/tcg/s390x/vxeh2_vstrs.c

diff --git a/tests/tcg/s390x/vxeh2_vstrs.c b/tests/tcg/s390x/vxeh2_vstrs.c
new file mode 100644
index 0000000000..313ec1d728
--- /dev/null
+++ b/tests/tcg/s390x/vxeh2_vstrs.c
@@ -0,0 +1,88 @@
+/*
+ * Test the VSTRS instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "vx.h"
+
+static inline __attribute__((__always_inline__)) int
+vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
+      const S390Vector *v4, const uint8_t m5, const uint8_t m6)
+{
+    int cc;
+
+    asm("vstrs %[v1],%[v2],%[v3],%[v4],%[m5],%[m6]\n"
+        "ipm %[cc]"
+        : [v1] "=v" (v1->v)
+        , [cc] "=r" (cc)
+        : [v2] "v" (v2->v)
+        , [v3] "v" (v3->v)
+        , [v4] "v" (v4->v)
+        , [m5] "i" (m5)
+        , [m6]  "i" (m6)
+        : "cc");
+
+    return (cc >> 28) & 3;
+}
+
+static void test_ignored_match(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0x222000205e410000ULL, .d[1] = 0};
+    S390Vector v3 = {.d[0] = 0x205e410000000000ULL, .d[1] = 0};
+    S390Vector v4 = {.d[0] = 3, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 2) == 1);
+    assert(v1.d[0] == 16);
+    assert(v1.d[1] == 0);
+}
+
+static void test_empty_needle(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0x5300000000000000ULL, .d[1] = 0};
+    S390Vector v3 = {.d[0] = 0, .d[1] = 0};
+    S390Vector v4 = {.d[0] = 0, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 0) == 2);
+    assert(v1.d[0] == 0);
+    assert(v1.d[1] == 0);
+}
+
+static void test_max_length(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0x1122334455667700ULL, .d[1] = 0};
+    S390Vector v3 = {.d[0] = 0, .d[1] = 0};
+    S390Vector v4 = {.d[0] = 16, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 0) == 3);
+    assert(v1.d[0] == 7);
+    assert(v1.d[1] == 0);
+}
+
+static void test_no_match(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {.d[0] = 0xffffff000fffff00ULL, .d[1] = 0x82b};
+    S390Vector v3 = {.d[0] = 0xfffffffeffffffffULL,
+                     .d[1] = 0xffffffff00000000ULL};
+    S390Vector v4 = {.d[0] = 11, .d[1] = 0};
+
+    assert(vstrs(&v1, &v2, &v3, &v4, 0, 2) == 1);
+    assert(v1.d[0] == 16);
+    assert(v1.d[1] == 0);
+}
+
+int main(void)
+{
+    test_ignored_match();
+    test_empty_needle();
+    test_max_length();
+    test_no_match();
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index a6062b5c07..9c0e70c6ca 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -75,6 +75,7 @@ ifneq ($(CROSS_CC_HAS_Z15),)
 Z15_TESTS=vxeh2_vs
 Z15_TESTS+=vxeh2_vcvt
 Z15_TESTS+=vxeh2_vlstr
+Z15_TESTS+=vxeh2_vstrs
 $(Z15_TESTS): CFLAGS+=-march=z15 -O2
 TESTS+=$(Z15_TESTS)
 endif
-- 
2.39.3


