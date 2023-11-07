Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1847E4854
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:34:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qsb-0002si-FY; Tue, 07 Nov 2023 13:32:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsZ-0002ql-Q6
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsY-0007PU-5r
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubA66O50Knk7PN+0Jzi5BAyjq6VNaG1ymKy8TI/O8AQ=;
 b=bOjtjizeTxVrndkmLKjDpgzTgzaAoNhU/UMETnbG5/TGPB4fv28y34j7YOkMmBqbK3aKcT
 sxIJH1psw53J8LJmkIDNQv3luue1Y+/2K7yy+c5ejNhbeVTwWEsFGk7WWBRwNMjCmvFSSD
 zNy1YZxvLzoBChkjohoUcDunUJJsc7w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-Ps3OYlFJPkeogs2V8TKbYA-1; Tue, 07 Nov 2023 13:32:43 -0500
X-MC-Unique: Ps3OYlFJPkeogs2V8TKbYA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BBB3811E86;
 Tue,  7 Nov 2023 18:32:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87C222166B26;
 Tue,  7 Nov 2023 18:32:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/11] tests/tcg/s390x: Test CLC with inaccessible second
 operand
Date: Tue,  7 Nov 2023 19:32:24 +0100
Message-ID: <20231107183228.276424-8-thuth@redhat.com>
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

Add a small test to prevent regressions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231106093605.1349201-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/clc.c           | 48 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 49 insertions(+)
 create mode 100644 tests/tcg/s390x/clc.c

diff --git a/tests/tcg/s390x/clc.c b/tests/tcg/s390x/clc.c
new file mode 100644
index 0000000000..e14189bd75
--- /dev/null
+++ b/tests/tcg/s390x/clc.c
@@ -0,0 +1,48 @@
+/*
+ * Test the CLC instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+static void handle_sigsegv(int sig, siginfo_t *info, void *ucontext)
+{
+    mcontext_t *mcontext = &((ucontext_t *)ucontext)->uc_mcontext;
+    if (mcontext->gregs[0] != 600) {
+        write(STDERR_FILENO, "bad r0\n", 7);
+        _exit(EXIT_FAILURE);
+    }
+    if (((mcontext->psw.mask >> 44) & 3) != 1) {
+        write(STDERR_FILENO, "bad cc\n", 7);
+        _exit(EXIT_FAILURE);
+    }
+    _exit(EXIT_SUCCESS);
+}
+
+int main(void)
+{
+    register unsigned long r0 asm("r0");
+    unsigned long mem = 42, rhs = 500;
+    struct sigaction act;
+    int err;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = handle_sigsegv;
+    act.sa_flags = SA_SIGINFO;
+    err = sigaction(SIGSEGV, &act, NULL);
+    assert(err == 0);
+
+    r0 = 100;
+    asm("algr %[r0],%[rhs]\n"
+        "clc 0(8,%[mem]),0(0)\n"  /* The 2nd operand will cause a SEGV. */
+        : [r0] "+r" (r0)
+        : [mem] "r" (&mem)
+        , [rhs] "r" (rhs)
+        : "cc", "memory");
+
+    return EXIT_FAILURE;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 826f0a18e4..ccd4f4e68d 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -41,6 +41,7 @@ TESTS+=larl
 TESTS+=mdeb
 TESTS+=cgebra
 TESTS+=clgebr
+TESTS+=clc
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.41.0


