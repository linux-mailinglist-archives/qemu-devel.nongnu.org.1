Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AB674D513
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoX-0000rv-Qv; Mon, 10 Jul 2023 08:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoE-0000lC-0H
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoB-0003Qv-Qn
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8q9wyGYtWt6HFrbFfTQ4DP9eTVhCTiRGqRc/gf9Y9xk=;
 b=Me4TpayKPFUWTjUoB/AEztEtDNJ7//zSN2Nq/EmdtpjHQHZoOSkaZ9btj4bQDK3oxKgA5/
 niJpGFy01pO1uaOb7q0TT/bJct3q0fFOn1T9uZNWNwhFurZrFxOSV0L9bzCJsMYjrwY2xM
 X6Ll5pttvoRCpqOK9L5ZmQutKWm0IKY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-nxJx8Jn8NPCOIhLBT2KzNQ-1; Mon, 10 Jul 2023 08:16:00 -0400
X-MC-Unique: nxJx8Jn8NPCOIhLBT2KzNQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ED88380671D;
 Mon, 10 Jul 2023 12:16:00 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65BD0F5CFA;
 Mon, 10 Jul 2023 12:15:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 10/21] tests/tcg/s390x: Test LARL with a large offset
Date: Mon, 10 Jul 2023 14:15:32 +0200
Message-Id: <20230710121543.197250-11-thuth@redhat.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230704081506.276055-10-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/larl.c          | 21 +++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 22 insertions(+)
 create mode 100644 tests/tcg/s390x/larl.c

diff --git a/tests/tcg/s390x/larl.c b/tests/tcg/s390x/larl.c
new file mode 100644
index 0000000000..7c95f89be7
--- /dev/null
+++ b/tests/tcg/s390x/larl.c
@@ -0,0 +1,21 @@
+/*
+ * Test the LARL instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <stdlib.h>
+
+int main(void)
+{
+    long algfi = (long)main;
+    long larl;
+
+    /*
+     * The compiler may emit larl for the C addition, so compute the expected
+     * value using algfi.
+     */
+    asm("algfi %[r],0xd0000000" : [r] "+r" (algfi) : : "cc");
+    asm("larl %[r],main+0xd0000000" : [r] "=r" (larl));
+
+    return algfi == larl ? EXIT_SUCCESS : EXIT_FAILURE;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 2ef22c88d9..dbf64c991e 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -37,6 +37,7 @@ TESTS+=ex-relative-long
 TESTS+=ex-branch
 TESTS+=mxdb
 TESTS+=epsw
+TESTS+=larl
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.39.3


