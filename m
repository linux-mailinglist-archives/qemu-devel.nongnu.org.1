Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 516467236FE
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgK-0004lY-Vc; Tue, 06 Jun 2023 01:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgI-0004k7-3d
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgG-000451-IW
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686030991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tt73rM8NJ5DyayJocaDCA2D//CCHTDJSW/fH1beXtOQ=;
 b=EKvJcODb5RR/UT5nK2zjbVf/R9owMg3qSG4VU4C94h702OEBlqGjko87n3c/32XkdD2OS4
 Ml7rCPtZiS3ccQI8J1OS7wGiOq+SPXvHiCET8cbTHzFZ8/uRJwfXOeGX2HyttMTGBTHIku
 EBl8lzRZ3q0VziHPR6AgUgCuWGrv4vg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-twm9V-ZePrOcKeVCkwxu8w-1; Tue, 06 Jun 2023 01:56:28 -0400
X-MC-Unique: twm9V-ZePrOcKeVCkwxu8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F461101A55C;
 Tue,  6 Jun 2023 05:56:28 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAA672166B25;
 Tue,  6 Jun 2023 05:56:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 02/18] tests/tcg/s390x: Test LCBB
Date: Tue,  6 Jun 2023 07:56:05 +0200
Message-Id: <20230606055621.523175-3-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a test to prevent regressions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230526181240.1425579-3-iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/lcbb.c          | 51 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 tests/tcg/s390x/lcbb.c

diff --git a/tests/tcg/s390x/lcbb.c b/tests/tcg/s390x/lcbb.c
new file mode 100644
index 0000000000..8d368e0998
--- /dev/null
+++ b/tests/tcg/s390x/lcbb.c
@@ -0,0 +1,51 @@
+/*
+ * Test the LCBB instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+static inline __attribute__((__always_inline__)) void
+lcbb(long *r1, void *dxb2, int m3, int *cc)
+{
+    asm("lcbb %[r1],%[dxb2],%[m3]\n"
+        "ipm %[cc]"
+        : [r1] "+r" (*r1), [cc] "=r" (*cc)
+        : [dxb2] "R" (*(char *)dxb2), [m3] "i" (m3)
+        : "cc");
+    *cc = (*cc >> 28) & 3;
+}
+
+static char buf[0x1000] __attribute__((aligned(0x1000)));
+
+static inline __attribute__((__always_inline__)) void
+test_lcbb(void *p, int m3, int exp_r1, int exp_cc)
+{
+    long r1 = 0xfedcba9876543210;
+    int cc;
+
+    lcbb(&r1, p, m3, &cc);
+    assert(r1 == (0xfedcba9800000000 | exp_r1));
+    assert(cc == exp_cc);
+}
+
+int main(void)
+{
+    test_lcbb(&buf[0],    0, 16, 0);
+    test_lcbb(&buf[63],   0,  1, 3);
+    test_lcbb(&buf[0],    1, 16, 0);
+    test_lcbb(&buf[127],  1,  1, 3);
+    test_lcbb(&buf[0],    2, 16, 0);
+    test_lcbb(&buf[255],  2,  1, 3);
+    test_lcbb(&buf[0],    3, 16, 0);
+    test_lcbb(&buf[511],  3,  1, 3);
+    test_lcbb(&buf[0],    4, 16, 0);
+    test_lcbb(&buf[1023], 4,  1, 3);
+    test_lcbb(&buf[0],    5, 16, 0);
+    test_lcbb(&buf[2047], 5,  1, 3);
+    test_lcbb(&buf[0],    6, 16, 0);
+    test_lcbb(&buf[4095], 6,  1, 3);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 23dc8b6a63..4ed07c6ab0 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -47,6 +47,7 @@ $(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
 TESTS += $(PGM_SPECIFICATION_TESTS)
 
 Z13_TESTS=vistr
+Z13_TESTS+=lcbb
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
-- 
2.31.1


