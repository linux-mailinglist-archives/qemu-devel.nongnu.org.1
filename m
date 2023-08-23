Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FBB78571C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:50:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJk-0001Zn-Ve; Wed, 23 Aug 2023 07:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJK-0001Uy-I2
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJG-0001TA-B3
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qOFBWFRg4NE622W93HZhBOXECakhIqIfisekBTHA2Ck=;
 b=J7nYV3a1METEcOf1K+A9KA0+t+0zj4v1Odo14Gn1aVYTsJT0UOKUBYLQtpmIei2l7h06Bm
 9B+844abpz/BsVsKW/I/JvvOQJfCcsxmhWpmGFwQUy0MD3WbeJhzj/be0O0/eSB0Hj4Vr1
 xGNIifYG2XSiPkHDbWNZPuUsj+8ArC4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-o3a2_J2RPMK60pxeSrqo0g-1; Wed, 23 Aug 2023 07:45:58 -0400
X-MC-Unique: o3a2_J2RPMK60pxeSrqo0g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D1183C11A04;
 Wed, 23 Aug 2023 11:45:57 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E01CC15BB8;
 Wed, 23 Aug 2023 11:45:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 07/12] tests/tcg/s390x: Test VREP
Date: Wed, 23 Aug 2023 13:45:39 +0200
Message-Id: <20230823114544.216520-8-thuth@redhat.com>
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
Message-Id: <20230807163459.849766-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/vrep.c          | 81 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 82 insertions(+)
 create mode 100644 tests/tcg/s390x/vrep.c

diff --git a/tests/tcg/s390x/vrep.c b/tests/tcg/s390x/vrep.c
new file mode 100644
index 0000000000..d5a3bd8eb2
--- /dev/null
+++ b/tests/tcg/s390x/vrep.c
@@ -0,0 +1,81 @@
+/*
+ * Test the VREP instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "vx.h"
+
+static void handle_sigill(int sig, siginfo_t *info, void *ucontext)
+{
+    mcontext_t *mcontext = &((ucontext_t *)ucontext)->uc_mcontext;
+    char *insn = (char *)info->si_addr;
+
+    if (insn[0] != 0xe7 || insn[5] != 0x4d) {
+        _exit(EXIT_FAILURE);
+    }
+
+    mcontext->gregs[2] = SIGILL;
+}
+
+static inline __attribute__((__always_inline__)) unsigned long
+vrep(S390Vector *v1, const S390Vector *v3, const uint16_t i2, const uint8_t m4)
+{
+    register unsigned long sig asm("r2") = -1;
+
+    asm("vrep %[v1],%[v3],%[i2],%[m4]\n"
+        : [v1] "=v" (v1->v)
+        , [sig] "+r" (sig)
+        : [v3] "v" (v3->v)
+        , [i2] "i" (i2)
+        , [m4] "i" (m4));
+
+    return sig;
+}
+
+int main(int argc, char *argv[])
+{
+    S390Vector v3 = {.d[0] = 1, .d[1] = 2};
+    struct sigaction act;
+    S390Vector v1;
+    int err;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigill;
+    act.sa_flags = SA_SIGINFO;
+    err = sigaction(SIGILL, &act, NULL);
+    assert(err == 0);
+
+    assert(vrep(&v1, &v3, 7, 0) == -1);
+    assert(v1.d[0] == 0x0101010101010101ULL);
+    assert(v1.d[1] == 0x0101010101010101ULL);
+
+    assert(vrep(&v1, &v3, 7, 1) == -1);
+    assert(v1.d[0] == 0x0002000200020002ULL);
+    assert(v1.d[1] == 0x0002000200020002ULL);
+
+    assert(vrep(&v1, &v3, 1, 2) == -1);
+    assert(v1.d[0] == 0x0000000100000001ULL);
+    assert(v1.d[1] == 0x0000000100000001ULL);
+
+    assert(vrep(&v1, &v3, 1, 3) == -1);
+    assert(v1.d[0] == 2);
+    assert(v1.d[1] == 2);
+
+    assert(vrep(&v1, &v3, 0x10, 0) == SIGILL);
+    assert(vrep(&v1, &v3, 0x101, 0) == SIGILL);
+    assert(vrep(&v1, &v3, 0x8, 1) == SIGILL);
+    assert(vrep(&v1, &v3, 0x108, 1) == SIGILL);
+    assert(vrep(&v1, &v3, 0x4, 2) == SIGILL);
+    assert(vrep(&v1, &v3, 0x104, 2) == SIGILL);
+    assert(vrep(&v1, &v3, 0x2, 3) == SIGILL);
+    assert(vrep(&v1, &v3, 0x102, 3) == SIGILL);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index e280c8c280..a6062b5c07 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -60,6 +60,7 @@ Z13_TESTS+=lcbb
 Z13_TESTS+=locfhr
 Z13_TESTS+=vcksm
 Z13_TESTS+=vstl
+Z13_TESTS+=vrep
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
-- 
2.39.3


