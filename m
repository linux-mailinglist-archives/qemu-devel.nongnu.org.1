Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 864DC723700
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 07:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6PgP-0004mo-1Z; Tue, 06 Jun 2023 01:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgL-0004lp-H3
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6PgJ-00046f-QJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 01:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686030995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVXMEjYxa0jQWA9rMKBIZLrOCvcgNOpUUDH8hbg8kHQ=;
 b=CLaDLVKXYJokIjoQQ37uoNFFaGLm96OlKh9mFt2wdrauCUKF5a2td881vSFM+HWMWKRMDk
 KOVE6RvqmHPAu/WinxbT/Xw0E6wK5CXEm7agBf7kOFehCCqZg17/CQ40euSXqI/EoXDQDH
 dQ7pkiIUaW0n6tcSx3aiiwCA38n6dBI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-HsChm1LINuet6YaCXdjlkg-1; Tue, 06 Jun 2023 01:56:31 -0400
X-MC-Unique: HsChm1LINuet6YaCXdjlkg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F3493C025D8;
 Tue,  6 Jun 2023 05:56:31 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1482A2166B25;
 Tue,  6 Jun 2023 05:56:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 04/18] tests/tcg/s390x: Test LOCFHR
Date: Tue,  6 Jun 2023 07:56:07 +0200
Message-Id: <20230606055621.523175-5-thuth@redhat.com>
In-Reply-To: <20230606055621.523175-1-thuth@redhat.com>
References: <20230606055621.523175-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Add a small test to prevent regressions.

Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230526181240.1425579-5-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/locfhr.c        | 29 +++++++++++++++++++++++++++++
 tests/tcg/s390x/Makefile.target |  1 +
 2 files changed, 30 insertions(+)
 create mode 100644 tests/tcg/s390x/locfhr.c

diff --git a/tests/tcg/s390x/locfhr.c b/tests/tcg/s390x/locfhr.c
new file mode 100644
index 0000000000..ab9ff6e449
--- /dev/null
+++ b/tests/tcg/s390x/locfhr.c
@@ -0,0 +1,29 @@
+/*
+ * Test the LOCFHR instruction.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <assert.h>
+#include <stdlib.h>
+
+static inline __attribute__((__always_inline__)) long
+locfhr(long r1, long r2, int m3, int cc)
+{
+    cc <<= 28;
+    asm("spm %[cc]\n"
+        "locfhr %[r1],%[r2],%[m3]\n"
+        : [r1] "+r" (r1)
+        : [cc] "r" (cc), [r2] "r" (r2), [m3] "i" (m3)
+        : "cc");
+    return r1;
+}
+
+int main(void)
+{
+    assert(locfhr(0x1111111122222222, 0x3333333344444444, 8, 0) ==
+           0x3333333322222222);
+    assert(locfhr(0x5555555566666666, 0x7777777788888888, 11, 1) ==
+           0x5555555566666666);
+
+    return EXIT_SUCCESS;
+}
diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
index 4ed07c6ab0..b14c0bd84b 100644
--- a/tests/tcg/s390x/Makefile.target
+++ b/tests/tcg/s390x/Makefile.target
@@ -48,6 +48,7 @@ TESTS += $(PGM_SPECIFICATION_TESTS)
 
 Z13_TESTS=vistr
 Z13_TESTS+=lcbb
+Z13_TESTS+=locfhr
 $(Z13_TESTS): CFLAGS+=-march=z13 -O2
 TESTS+=$(Z13_TESTS)
 
-- 
2.31.1


