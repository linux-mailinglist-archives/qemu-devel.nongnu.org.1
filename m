Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F275FCB3
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyp8-0001KT-Rz; Mon, 24 Jul 2023 12:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyp7-0001K7-9q
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyp5-0006x5-Tl
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPZAqp99usLpVFtgppm/Pe3CTt20xx/6W024G0Ze3fE=;
 b=af0a7amjr6lOiKV0louF6qO1R5dtV0pqYKRTXoZ/+mu9MiJWnKdar7V2r7F5HuWBCD8bgl
 x7UUZM5eEce/6vJHgYMbq46yeuXEJQHOV/LGeYBR+5E+Ih6tVxafIUWGz5K5gVHsiYFn8Q
 FbtBDFlrx9EOUgyer3jQUYfNRoNqUKs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-xbeCtrV1PVeuTOBUlDTciQ-1; Mon, 24 Jul 2023 12:54:12 -0400
X-MC-Unique: xbeCtrV1PVeuTOBUlDTciQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0E463C13507;
 Mon, 24 Jul 2023 16:54:08 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00761492CAC;
 Mon, 24 Jul 2023 16:54:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 13/16] tests/tcg/s390x: Test VCKSM
Date: Mon, 24 Jul 2023 18:53:46 +0200
Message-Id: <20230724165349.55714-14-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-15-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/vx.h            |  2 ++
 tests/tcg/s390x/vcksm.c         | 31 +++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 3 files changed, 34 insertions(+)
 create mode 100644 tests/tcg/s390x/vcksm.c

diff --git a/tests/tcg/s390x/vx.h b/tests/tcg/s390x/vx.h
index 02e7fd518a..00701dbe35 100644
--- a/tests/tcg/s390x/vx.h
+++ b/tests/tcg/s390x/vx.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_TESTS_S390X_VX_H
 #define QEMU_TESTS_S390X_VX_H
 
+#include <stdint.h>
+
 typedef union S390Vector {
     uint64_t d[2];  /* doubleword */
     uint32_t w[4];  /* word */
diff --git a/tests/tcg/s390x/vcksm.c b/tests/tcg/s390x/vcksm.c
new file mode 100644
index 0000000000..452daaae6c
--- /dev/null
+++ b/tests/tcg/s390x/vcksm.c
@@ -0,0 +1,31 @@
+/*
+ * Test the VCKSM instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include "vx.h"
+
+int main(void)
+{
+    S390Vector v1;
+    S390Vector v2 = {
+        .d[0] = 0xb2261c8140edce49ULL,
+        .d[1] = 0x387bf5a433af39d1ULL,
+    };
+    S390Vector v3 = {
+        .d[0] = 0x73b03d2c7f9e654eULL,
+        .d[1] = 0x23d74e51fb479877ULL,
+    };
+    S390Vector exp = {.d[0] = 0xdedd7f8eULL, .d[1] = 0ULL};
+
+    asm volatile("vcksm %[v1],%[v2],%[v3]"
+                 : [v1] "=v" (v1.v)
+                 : [v2] "v" (v2.v)
+                 , [v3] "v" (v3.v));
+    assert(memcmp(&v1, &exp, sizeof(v1)) == 0);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 71bf39b78d..1fc9809907 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -58,6 +58,7 @@ TESTS += $(PGM_SPECIFICATION_TESTS)
 Z13_TESTS=vistr
 Z13_TESTS+=lcbb
 Z13_TESTS+=locfhr
+Z13_TESTS+=vcksm
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
-- 
2.39.3


