Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211C7236FA
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgY-0004r5-Pt; Tue, 06 Jun 2023 01:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgU-0004pT-5n
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgS-00049S-Od
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686031004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oHRTL85XxJgPRvE/Ju5GyJ2XKuGglMdx9+z41yApVOM=;
 b=hryitKvlvoaHUQG8qXEsVGLlc4sGic096pqmURpYZfSy9nk1n61GMyATca1vvGd+snMQ4C
 roLhiBrOlDGDxBQMpsjRDnllVT9AWNJ0AleMwy48UJx/HaAhZkc3L3OZcZWJtx01EYPsKx
 3E5ORW+o2vf96GhsCvBNM2ZLqMDO3IU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-qrDlsnTMN-ycycoVnZJsdg-1; Tue, 06 Jun 2023 01:56:39 -0400
X-MC-Unique: qrDlsnTMN-ycycoVnZJsdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7A3085A5A8;
 Tue,  6 Jun 2023 05:56:38 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98D9A2166B25;
 Tue,  6 Jun 2023 05:56:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 09/18] tests/tcg/s390x: Test MXDB and MXDBR
Date: Tue,  6 Jun 2023 07:56:12 +0200
Message-Id: <20230606055621.523175-10-thuth@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230601223027.795501-3-iii@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/mxdb.c          | 30 ++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 31 insertions(+)
 create mode 100644 tests/tcg/s390x/mxdb.c

diff --git a/tests/tcg/s390x/mxdb.c b/tests/tcg/s390x/mxdb.c
new file mode 100644
index 0000000000..ae922559d3
--- /dev/null
+++ b/tests/tcg/s390x/mxdb.c
@@ -0,0 +1,30 @@
+/*
+ * Test the MXDB and MXDBR instructions.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    union {
+        double d[2];
+        long double ld;
+    } a;
+    double b;
+
+    a.d[0] = 1.2345;
+    a.d[1] = 999;
+    b = 6.789;
+    asm("mxdb %[a],%[b]" : [a] "+f" (a.ld) : [b] "R" (b));
+    assert(a.ld > 8.38 && a.ld < 8.39);
+
+    a.d[0] = 1.2345;
+    a.d[1] = 999;
+    b = 6.789;
+    asm("mxdbr %[a],%[b]" : [a] "+f" (a.ld) : [b] "f" (b));
+    assert(a.ld > 8.38 && a.ld < 8.39);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index a2a15c4a23..85abfbb98c 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -35,6 +35,7 @@ TESTS+=chrl
 TESTS+=rxsbg
 TESTS+=ex-relative-long
 TESTS+=ex-branch
+TESTS+=mxdb
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.31.1


