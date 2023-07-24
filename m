Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8691975FCB8
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyp7-0001Js-Hl; Mon, 24 Jul 2023 12:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyoz-0001G3-S8
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyox-0006ve-NN
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gKAXEgra0HgR6HbcyPx5/kEbB9cmaWV7cNn3wXt68Q=;
 b=gSXj+3Wdgp/zkWKqWM3z1IEQd5HVWJWPPnQv+ZoKYrdKI1nfIq8DwPlCTR8J50hdTYycVE
 qlMn5uDXJN0i9vRnFYd9AP7IWoEha21GYBwLYojo9Sl9caHzJ4Xwy4APW0d42Gk78E+Ifi
 d9AVzgx6w7wdNVhy23AOq1T5OaUB2H4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-qgduR8boOLuuFpNW7hEr8Q-1; Mon, 24 Jul 2023 12:54:03 -0400
X-MC-Unique: qgduR8boOLuuFpNW7hEr8Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33956881B27;
 Mon, 24 Jul 2023 16:54:03 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65CEB492CAC;
 Mon, 24 Jul 2023 16:54:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 08/16] tests/tcg/s390x: Test CLGEBR and CGEBRA
Date: Mon, 24 Jul 2023 18:53:41 +0200
Message-Id: <20230724165349.55714-9-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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
Message-Id: <20230724082032.66864-10-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/cgebra.c        | 32 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/clgebr.c        | 32 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  5 +++++
 3 files changed, 69 insertions(+)
 create mode 100644 tests/tcg/s390x/cgebra.c
 create mode 100644 tests/tcg/s390x/clgebr.c

diff --git a/tests/tcg/s390x/cgebra.c b/tests/tcg/s390x/cgebra.c
new file mode 100644
index 0000000000..f91e10d2d3
--- /dev/null
+++ b/tests/tcg/s390x/cgebra.c
@@ -0,0 +1,32 @@
+/*
+ * Test the CGEBRA instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <fenv.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    float r2 = 1E+300;
+    long long r1;
+    int cc;
+
+    feclearexcept(FE_ALL_EXCEPT);
+    asm("cgebra %[r1],%[m3],%[r2],%[m4]\n"
+        "ipm %[cc]\n"
+        : [r1] "=r" (r1)
+        , [cc] "=r" (cc)
+        : [m3] "i" (5) /* round toward 0 */
+        , [r2] "f" (r2)
+        , [m4] "i" (8) /* bit 0 is set, but must be ignored; XxC is not set */
+        : "cc");
+    cc >>= 28;
+
+    assert(r1 == 0x7fffffffffffffffLL);
+    assert(cc == 3);
+    assert(fetestexcept(FE_ALL_EXCEPT) == (FE_INVALID | FE_INEXACT));
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/clgebr.c b/tests/tcg/s390x/clgebr.c
new file mode 100644
index 0000000000..d491899b56
--- /dev/null
+++ b/tests/tcg/s390x/clgebr.c
@@ -0,0 +1,32 @@
+/*
+ * Test the CLGEBR instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <fenv.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    float r2 = -1;
+    long long r1;
+    int cc;
+
+    feclearexcept(FE_ALL_EXCEPT);
+    asm("clgebr %[r1],%[m3],%[r2],%[m4]\n"
+        "ipm %[cc]\n"
+        : [r1] "=r" (r1)
+        , [cc] "=r" (cc)
+        : [m3] "i" (5) /* round toward 0 */
+        , [r2] "f" (r2)
+        , [m4] "i" (8) /* bit 0 is set, but must be ignored; XxC is not set */
+        : "cc");
+    cc >>= 28;
+
+    assert(r1 == 0);
+    assert(cc == 3);
+    assert(fetestexcept(FE_ALL_EXCEPT) == (FE_INVALID | FE_INEXACT));
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 19fbbc6e53..71bf39b78d 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -39,12 +39,17 @@ TESTS+=mxdb
 TESTS+=epsw
 TESTS+=larl
 TESTS+=mdeb
+TESTS+=cgebra
+TESTS+=clgebr
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
 
 rxsbg: CFLAGS+=-O2
 
+cgebra: LDFLAGS+=-lm
+clgebr: LDFLAGS+=-lm
+
 include $(S390X_SRC)/pgm-specification.mak
 $(PGM_SPECIFICATION_TESTS): pgm-specification-user.o
 $(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
-- 
2.39.3


