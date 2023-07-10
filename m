Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A1874D515
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoV-0000r5-O7; Mon, 10 Jul 2023 08:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoE-0000lE-1c
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoB-0003RH-Rg
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iOJW22hQ1EPwtqBZ0ASFxS6CsEKLXv3KDbZSFynh3QM=;
 b=bL/GEIFNq8dLiaFnJZ6M1Vl5BkQS+vX110r5JT4IVmJo0tDqWyxMBZH0j70z9QZ9vVUvDj
 kAusXWKwMl4DEnRpNO7L0yJ9QaEBjCP0qbBjbHwHXOG1BqRomMeXo+6sJgASoeFr//ip+e
 GP+yrPEZGyHes/uEayVnm0Z3IF1FVwo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-aOQt-jxMNry5HxIBM0Ycag-1; Mon, 10 Jul 2023 08:15:59 -0400
X-MC-Unique: aOQt-jxMNry5HxIBM0Ycag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24AAD810BB4;
 Mon, 10 Jul 2023 12:15:59 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B101F66B9;
 Mon, 10 Jul 2023 12:15:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 09/21] tests/tcg/s390x: Test EPSW
Date: Mon, 10 Jul 2023 14:15:31 +0200
Message-Id: <20230710121543.197250-10-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230704081506.276055-9-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/epsw.c          | 23 +++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 tests/tcg/s390x/epsw.c

diff --git a/tests/tcg/s390x/epsw.c b/tests/tcg/s390x/epsw.c
new file mode 100644
index 0000000000..affb1a5e3a
--- /dev/null
+++ b/tests/tcg/s390x/epsw.c
@@ -0,0 +1,23 @@
+/*
+ * Test the EPSW instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    unsigned long r1 = 0x1234567887654321UL, r2 = 0x8765432112345678UL;
+
+    asm("cr %[r1],%[r2]\n"  /* cc = 1 */
+        "epsw %[r1],%[r2]"
+        : [r1] "+r" (r1), [r2] "+r" (r2) : : "cc");
+
+    /* Do not check the R and RI bits. */
+    r1 &= ~0x40000008UL;
+    assert(r1 == 0x1234567807051001UL);
+    assert(r2 == 0x8765432180000000UL);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 85abfbb98c..2ef22c88d9 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -36,6 +36,7 @@ TESTS+=rxsbg
 TESTS+=ex-relative-long
 TESTS+=ex-branch
 TESTS+=mxdb
+TESTS+=epsw
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.39.3


