Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE7D82B39B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:04:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQs-0004Ey-5y; Thu, 11 Jan 2024 12:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQo-0004Cc-NE
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQn-0003tO-5u
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQad4yDRCpcNWWrgW2CP+Bi/GxO2s1Bcd/pkAeD9COM=;
 b=GbI+7sl2ykErZ+Spwb4FA3QXCV63MrjlZIbFeMNC++cyjDBXOZTyDvkH0BLqD+Sz9UmVlC
 EznQyGJOmBTp7umYAOPQwtSqvX8zql1m8Jwqv04p+uKTSNIEGwWTkcWNHbBowKwSOG0YNs
 rGwtvFlhfpZJgLYWvBHcF+szegYHt4g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-37hoxWSQN8aL8lJewkfdPA-1; Thu,
 11 Jan 2024 12:01:21 -0500
X-MC-Unique: 37hoxWSQN8aL8lJewkfdPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A17AF3C0F37C;
 Thu, 11 Jan 2024 17:01:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B47251D5;
 Thu, 11 Jan 2024 17:01:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 16/17] tests/tcg/s390x: Test LOAD ADDRESS EXTENDED
Date: Thu, 11 Jan 2024 18:00:45 +0100
Message-ID: <20240111170047.909117-17-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
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

Add a small test to prevent regressions. Userspace runs in primary
mode, so LAE should always set the access register to 0.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240111092328.929421-3-iii@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/lae.c           | 31 +++++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 tests/tcg/s390x/lae.c

diff --git a/tests/tcg/s390x/lae.c b/tests/tcg/s390x/lae.c
new file mode 100644
index 0000000000..59712b5e37
--- /dev/null
+++ b/tests/tcg/s390x/lae.c
@@ -0,0 +1,31 @@
+/*
+ * Test the LOAD ADDRESS EXTENDED instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+int main(void)
+{
+    unsigned long long ar = -1, b2 = 100000, r, x2 = 500;
+    /*
+     * Hardcode the register number, since clang does not allow using %rN in
+     * place of %aN.
+     */
+    register unsigned long long r2 __asm__("2");
+    int tmp;
+
+    asm("ear %[tmp],%%a2\n"
+        "lae %%r2,42(%[x2],%[b2])\n"
+        "ear %[ar],%%a2\n"
+        "sar %%a2,%[tmp]"
+        : [tmp] "=&r" (tmp), "=&r" (r2), [ar] "+r" (ar)
+        : [b2] "r" (b2), [x2] "r" (x2)
+        : "memory");
+    r = r2;
+    assert(ar == 0xffffffff00000000ULL);
+    assert(r == 100542);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 0e670f3f8b..30994dcf9c 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -44,6 +44,7 @@ TESTS+=clgebr
 TESTS+=clc
 TESTS+=laalg
 TESTS+=add-logical-with-carry
+TESTS+=lae
 
 cdsg: CFLAGS+=-pthread
 cdsg: LDFLAGS+=-pthread
-- 
2.43.0


