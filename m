Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D336570C5BE
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1AqZ-0003ik-0F; Mon, 22 May 2023 15:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq5-0003bS-Ma
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq0-0003cJ-CQ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/cWcWX5ZyWeigY3MAY8KkuL3pxeIiGO564Q9l8OTcxE=;
 b=Zxt/s3ZJOroT8/XZo5eFdrArdyvu5cXHXHWwCm8KBGglcYFCu8IPI+2HnRQ1+Y7N1dlYDC
 YzPutZfO/MA90Gw4I7CtZN8yik1T2r9PerrCdQGLw2+/ctiIcHufRF7mso1Vj5vPPEKOJU
 guwy2gCyFb7cupcGaJ/xmgQusBCsBZs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-B3MDF79fNmyTOHoAk87FVw-1; Mon, 22 May 2023 15:04:50 -0400
X-MC-Unique: B3MDF79fNmyTOHoAk87FVw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0C33811E7F;
 Mon, 22 May 2023 19:04:49 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD05400DFF;
 Mon, 22 May 2023 19:04:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 10/19] test-cutils: Prepare for upcoming semantic change in
 qemu_strtosz
Date: Mon, 22 May 2023 14:04:32 -0500
Message-Id: <20230522190441.64278-11-eblake@redhat.com>
In-Reply-To: <20230522190441.64278-1-eblake@redhat.com>
References: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

A quick search for 'qemu_strtosz' in the code base shows that outside
of the testsuite, the ONLY place that passes a non-NULL pointer to
@endptr of any variant of a size parser is in hmp.c (the 'o' parser of
monitor_parse_arguments), and that particular caller warns of
"extraneous characters at the end of line" unless the trailing bytes
are purely whitespace.  Thus, it makes no semantic difference at the
high level whether we parse "1.5e1k" as "1" + ".5e1" + "k" (an attempt
to use scientific notation in strtod with a scaling suffix of 'k' with
no trailing junk, but which qemu_strtosz says should fail with
EINVAL), or as "1.5e" + "1k" (a valid size with scaling suffix of 'e'
for exabytes, followed by two junk bytes) - either way, any user
passing such a string will get an error message about a parse failure.

However, an upcoming patch to qemu_strtosz will fix other corner case
bugs in handling the fractional portion of a size, and in doing so, it
is easier to declare that qemu_strtosz() itself stops parsing at the
first 'e' rather than blindly consuming whatever strtod() will
recognize.  Once that is fixed, the difference will be visible at the
low level (getting a valid parse with trailing garbage when @endptr is
non-NULL, while continuing to get -EINVAL when @endptr is NULL); this
is easier to demonstrate by moving the affected strings from
test_qemu_strtosz_invalid() (which declares them as always -EINVAL) to
test_qemu_strtosz_trailing() (where @endptr affects behavior, for now
with FIXME comments).

Note that a similar argument could be made for having "0x1.5" or
"0x1M" parse as 0x1 with ".5" or "M" as trailing junk, instead of
blindly treating it as -EINVAL; however, as these cases do not suffer
from the same problems as floating point, they are not worth changing
at this time.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/unit/test-cutils.c | 42 ++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index e69b672ae57..f615dd0471c 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3563,21 +3563,6 @@ static void test_qemu_strtosz_invalid(void)
     g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

-    /* No floating point exponents */
-    str = "1.5e1k";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
-    str = "1.5E+0k";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
     /* No hex fractions */
     str = "0x1.8k";
     endptr = NULL;
@@ -3681,6 +3666,33 @@ static void test_qemu_strtosz_trailing(void)
     err = qemu_strtosz(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmphex(res, ==, 0xbaadf00d);
+
+    /* FIXME should stop parse after 'e'. No floating point exponents */
+    str = "1.5e1k";
+    endptr = NULL;
+    res = 0xbaadf00d;
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL /* FIXME 0 */);
+    g_assert_cmphex(res, ==, 0xbaadf00d /* FIXME EiB * 1.5 */);
+    g_assert_true(endptr == str /* FIXME + 4 */);
+
+    res = 0xbaadf00d;
+    err = qemu_strtosz(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0xbaadf00d);
+
+    str = "1.5E+0k";
+    endptr = NULL;
+    res = 0xbaadf00d;
+    err = qemu_strtosz(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL /* FIXME 0 */);
+    g_assert_cmphex(res, ==, 0xbaadf00d /* FIXME EiB * 1.5 */);
+    g_assert_true(endptr == str /* FIXME + 4 */);
+
+    res = 0xbaadf00d;
+    err = qemu_strtosz(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
 }

 static void test_qemu_strtosz_erange(void)
-- 
2.40.1


