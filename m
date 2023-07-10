Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EEA74D537
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpof-0000y9-OU; Mon, 10 Jul 2023 08:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoJ-0000nO-SM
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoH-0003U9-3n
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XKG+IdrSFCbt8KYi+OUUAnu0eDxrPCRnBTiP1C63aFo=;
 b=cQWU27rRiZO+06JLmih3lCSZ7kRv9LNAIcV98ZPDBwf185fxrfQHEd+tJ8koLOJeaNM/Rk
 83eWdN0n6HFpXXbcO3r7tTB4i/MUED1swn+FiPZCoE7iPqNj71nEQvonN+Bcq4nzxixm/W
 QBH/23wTiZ56fobDu+iGa/Y0YNZqWsw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-MFNyCgjCMFmMEtEkQXaNvA-1; Mon, 10 Jul 2023 08:16:05 -0400
X-MC-Unique: MFNyCgjCMFmMEtEkQXaNvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F1AF101146C;
 Mon, 10 Jul 2023 12:16:04 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62090F66BA;
 Mon, 10 Jul 2023 12:16:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL 13/21] tests/tcg/s390x: Test MVCRL with a large value in R0
Date: Mon, 10 Jul 2023 14:15:35 +0200
Message-Id: <20230710121543.197250-14-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20230704081506.276055-13-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tcg/s390x/mie3-mvcrl.c | 46 ++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/tests/tcg/s390x/mie3-mvcrl.c b/tests/tcg/s390x/mie3-mvcrl.c
index 93c7b0a290..ec78dd1d49 100644
--- a/tests/tcg/s390x/mie3-mvcrl.c
+++ b/tests/tcg/s390x/mie3-mvcrl.c
@@ -1,29 +1,55 @@
+#include <stdbool.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include <string.h>
 
-
-static inline void mvcrl_8(const char *dst, const char *src)
+static void mvcrl(const char *dst, const char *src, size_t len)
 {
+    register long r0 asm("r0") = len;
+
     asm volatile (
-        "llill %%r0, 8\n"
         ".insn sse, 0xE50A00000000, 0(%[dst]), 0(%[src])"
-        : : [dst] "d" (dst), [src] "d" (src)
-        : "r0", "memory");
+        : : [dst] "d" (dst), [src] "d" (src), "r" (r0)
+        : "memory");
 }
 
-
-int main(int argc, char *argv[])
+static bool test(void)
 {
     const char *alpha = "abcdefghijklmnop";
 
     /* array missing 'i' */
-    char tstr[17] = "abcdefghjklmnop\0" ;
+    char tstr[17] = "abcdefghjklmnop\0";
 
     /* mvcrl reference use: 'open a hole in an array' */
-    mvcrl_8(tstr + 9, tstr + 8);
+    mvcrl(tstr + 9, tstr + 8, 8);
 
     /* place missing 'i' */
     tstr[8] = 'i';
 
-    return strncmp(alpha, tstr, 16ul);
+    return strncmp(alpha, tstr, 16ul) == 0;
+}
+
+static bool test_bad_r0(void)
+{
+    char src[256];
+
+    /*
+     * PoP says: Bits 32-55 of general register 0 should contain zeros;
+     * otherwise, the program may not operate compatibly in the future.
+     *
+     * Try it anyway in order to check whether this would crash QEMU itself.
+     */
+    mvcrl(src, src, (size_t)-1);
+
+    return true;
+}
+
+int main(void)
+{
+    bool ok = true;
+
+    ok &= test();
+    ok &= test_bad_r0();
+
+    return ok ? EXIT_SUCCESS : EXIT_FAILURE;
 }
-- 
2.39.3


