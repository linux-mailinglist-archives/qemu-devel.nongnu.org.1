Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74008785731
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:52:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJN-0001Wh-II; Wed, 23 Aug 2023 07:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJJ-0001UM-VM
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJF-0001RL-IR
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JztBJHrVZPoEyd5VVRxoKMhYvt0vf53/BnHzwP12uxE=;
 b=PVOJ4XA73Jzo5Gcpo7V5KZ5fUoQxLFHm5B0TyuUvKaOZGC/A1MPdhqAxNEtKkUl7y5YUcn
 zqsCzoHEKIHcBN/0Aob5lXVT68dlXqZaaTP3KRxHhsZqzQreHvTIT/SlUey8IQi7GFgXoX
 BPn9AcekfDdT91mqL2GnppGa2OuZcRA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-DsGcyLNFP1mruuuEMkQ7Ww-1; Wed, 23 Aug 2023 07:45:54 -0400
X-MC-Unique: DsGcyLNFP1mruuuEMkQ7Ww-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E4E6185A7A5;
 Wed, 23 Aug 2023 11:45:54 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F75EC15BAE;
 Wed, 23 Aug 2023 11:45:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 05/12] tests/tcg/s390x: Test VSTL
Date: Wed, 23 Aug 2023 13:45:37 +0200
Message-Id: <20230823114544.216520-6-thuth@redhat.com>
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
Message-Id: <20230804235624.263260-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/vstl.c          | 37 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 tests/tcg/s390x/vstl.c

diff --git a/tests/tcg/s390x/vstl.c b/tests/tcg/s390x/vstl.c
new file mode 100644
index 0000000000..bece952c7e
--- /dev/null
+++ b/tests/tcg/s390x/vstl.c
@@ -0,0 +1,37 @@
+/*
+ * Test the VSTL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include "vx.h"
+
+static inline void vstl(S390Vector *v1, void *db2, size_t r3)
+{
+    asm("vstl %[v1],%[r3],%[db2]"
+        : [db2] "=Q" (*(char *)db2)
+        : [v1] "v" (v1->v), [r3] "r" (r3)
+        : "memory");
+}
+
+int main(void)
+{
+    uint64_t buf[3] = {0x1122334455667788ULL, 0x99aabbccddeeffULL,
+                       0x5a5a5a5a5a5a5a5aULL};
+    S390Vector v = {.d[0] = 0x1234567887654321ULL,
+                    .d[1] = 0x9abcdef00fedcba9ULL};
+
+    vstl(&v, buf, 0);
+    assert(buf[0] == 0x1222334455667788ULL);
+
+    vstl(&v, buf, 1);
+    assert(buf[0] == 0x1234334455667788ULL);
+
+    vstl(&v, buf, -1);
+    assert(buf[0] == 0x1234567887654321ULL);
+    assert(buf[1] == 0x9abcdef00fedcba9ULL);
+    assert(buf[2] == 0x5a5a5a5a5a5a5a5aULL);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 1fc9809907..e280c8c280 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -59,6 +59,7 @@ Z13_TESTS=vistr
 Z13_TESTS+=lcbb
 Z13_TESTS+=locfhr
 Z13_TESTS+=vcksm
+Z13_TESTS+=vstl
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
-- 
2.39.3


