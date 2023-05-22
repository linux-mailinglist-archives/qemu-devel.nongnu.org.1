Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14B70C5C1
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Apz-0003Vd-0R; Mon, 22 May 2023 15:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apw-0003UJ-Lb
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apr-0003Ye-Kf
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSwtAXS+55h2/n7s69hRM7FxxoknqQ8dA0uCeMs3OkM=;
 b=McIyCrFjv2DAqgrdKO9VLd9xPf0mgvEgTzBiMHpa2Hqwr9WDM77Ze3mZ0FnEe/069anlmC
 tgojL/naegAww5d7n+jVL7sUEmLMN1tnrDXODO2tvR51/39RdvsPPcRMc5RPPD7wgmqRsA
 dTCHdGGtgNyq9sNpqRdMDufUMI/CG2Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-wY-HGyltMFawFeIFzimfvA-1; Mon, 22 May 2023 15:04:44 -0400
X-MC-Unique: wY-HGyltMFawFeIFzimfvA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 261BC811E7F;
 Mon, 22 May 2023 19:04:44 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F95C400DFF;
 Mon, 22 May 2023 19:04:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/19] test-cutils: Avoid g_assert in unit tests
Date: Mon, 22 May 2023 14:04:23 -0500
Message-Id: <20230522190441.64278-2-eblake@redhat.com>
In-Reply-To: <20230522190441.64278-1-eblake@redhat.com>
References: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

glib documentation[1] is clear: g_assert() should be avoided in unit
tests because it is ineffective if G_DISABLE_ASSERT is defined; unit
tests should stick to constructs based on g_assert_true() instead.
Note that since commit 262a69f428, we intentionally state that you
cannot define G_DISABLE_ASSERT while building qemu; but our code can
be copied to other projects without that restriction, so we should be
consistent.

For most of the replacements in this patch, using g_assert_cmpstr()
would be a regression in quality - although it would helpfully display
the string contents of both pointers on test failure, here, we really
do care about pointer equality, not just string content equality.  But
when a NULL pointer is expected, g_assert_null works fine.

[1] https://libsoup.org/glib/glib-Testing.html#g-assert

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-cutils.c | 324 +++++++++++++++++++--------------------
 1 file changed, 162 insertions(+), 162 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 3c4f8754202..0202ac0d5b3 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -1,7 +1,7 @@
 /*
  * cutils.c unit-tests
  *
- * Copyright (C) 2013 Red Hat Inc.
+ * Copyright Red Hat
  *
  * Authors:
  *  Eduardo Habkost <ehabkost@redhat.com>
@@ -40,7 +40,7 @@ static void test_parse_uint_null(void)

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpint(i, ==, 0);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_parse_uint_empty(void)
@@ -55,7 +55,7 @@ static void test_parse_uint_empty(void)

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpint(i, ==, 0);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_parse_uint_whitespace(void)
@@ -70,7 +70,7 @@ static void test_parse_uint_whitespace(void)

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpint(i, ==, 0);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }


@@ -86,7 +86,7 @@ static void test_parse_uint_invalid(void)

     g_assert_cmpint(r, ==, -EINVAL);
     g_assert_cmpint(i, ==, 0);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }


@@ -102,7 +102,7 @@ static void test_parse_uint_trailing(void)

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpint(i, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_parse_uint_correct(void)
@@ -117,7 +117,7 @@ static void test_parse_uint_correct(void)

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpint(i, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_parse_uint_octal(void)
@@ -132,7 +132,7 @@ static void test_parse_uint_octal(void)

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpint(i, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_parse_uint_decimal(void)
@@ -147,7 +147,7 @@ static void test_parse_uint_decimal(void)

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpint(i, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }


@@ -163,7 +163,7 @@ static void test_parse_uint_llong_max(void)

     g_assert_cmpint(r, ==, 0);
     g_assert_cmpint(i, ==, (unsigned long long)LLONG_MAX + 1);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     g_free(str);
 }
@@ -180,7 +180,7 @@ static void test_parse_uint_overflow(void)

     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpint(i, ==, ULLONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_parse_uint_negative(void)
@@ -195,7 +195,7 @@ static void test_parse_uint_negative(void)

     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpint(i, ==, 0);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }


@@ -235,7 +235,7 @@ static void test_qemu_strtoi_correct(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345);
-    g_assert(endptr == str + 5);
+    g_assert_true(endptr == str + 5);
 }

 static void test_qemu_strtoi_null(void)
@@ -248,7 +248,7 @@ static void test_qemu_strtoi_null(void)
     err = qemu_strtoi(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtoi_empty(void)
@@ -262,7 +262,7 @@ static void test_qemu_strtoi_empty(void)
     err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoi_whitespace(void)
@@ -276,7 +276,7 @@ static void test_qemu_strtoi_whitespace(void)
     err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoi_invalid(void)
@@ -290,7 +290,7 @@ static void test_qemu_strtoi_invalid(void)
     err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoi_trailing(void)
@@ -305,7 +305,7 @@ static void test_qemu_strtoi_trailing(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_qemu_strtoi_octal(void)
@@ -320,7 +320,7 @@ static void test_qemu_strtoi_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     res = 999;
     endptr = &f;
@@ -328,7 +328,7 @@ static void test_qemu_strtoi_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi_decimal(void)
@@ -343,7 +343,7 @@ static void test_qemu_strtoi_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "123";
     res = 999;
@@ -352,7 +352,7 @@ static void test_qemu_strtoi_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi_hex(void)
@@ -367,7 +367,7 @@ static void test_qemu_strtoi_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x123";
     res = 999;
@@ -376,7 +376,7 @@ static void test_qemu_strtoi_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x";
     res = 999;
@@ -385,7 +385,7 @@ static void test_qemu_strtoi_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);
 }

 static void test_qemu_strtoi_max(void)
@@ -400,7 +400,7 @@ static void test_qemu_strtoi_max(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, INT_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -416,7 +416,7 @@ static void test_qemu_strtoi_overflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, INT_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -432,7 +432,7 @@ static void test_qemu_strtoi_underflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, INT_MIN);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -448,7 +448,7 @@ static void test_qemu_strtoi_negative(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, -321);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi_full_correct(void)
@@ -473,7 +473,7 @@ static void test_qemu_strtoi_full_null(void)
     err = qemu_strtoi(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtoi_full_empty(void)
@@ -535,7 +535,7 @@ static void test_qemu_strtoui_correct(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 12345);
-    g_assert(endptr == str + 5);
+    g_assert_true(endptr == str + 5);
 }

 static void test_qemu_strtoui_null(void)
@@ -548,7 +548,7 @@ static void test_qemu_strtoui_null(void)
     err = qemu_strtoui(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtoui_empty(void)
@@ -562,7 +562,7 @@ static void test_qemu_strtoui_empty(void)
     err = qemu_strtoui(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoui_whitespace(void)
@@ -576,7 +576,7 @@ static void test_qemu_strtoui_whitespace(void)
     err = qemu_strtoui(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoui_invalid(void)
@@ -590,7 +590,7 @@ static void test_qemu_strtoui_invalid(void)
     err = qemu_strtoui(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoui_trailing(void)
@@ -605,7 +605,7 @@ static void test_qemu_strtoui_trailing(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_qemu_strtoui_octal(void)
@@ -620,7 +620,7 @@ static void test_qemu_strtoui_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     res = 999;
     endptr = &f;
@@ -628,7 +628,7 @@ static void test_qemu_strtoui_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoui_decimal(void)
@@ -643,7 +643,7 @@ static void test_qemu_strtoui_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "123";
     res = 999;
@@ -652,7 +652,7 @@ static void test_qemu_strtoui_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoui_hex(void)
@@ -667,7 +667,7 @@ static void test_qemu_strtoui_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x123";
     res = 999;
@@ -676,7 +676,7 @@ static void test_qemu_strtoui_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x";
     res = 999;
@@ -685,7 +685,7 @@ static void test_qemu_strtoui_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);
 }

 static void test_qemu_strtoui_max(void)
@@ -700,7 +700,7 @@ static void test_qemu_strtoui_max(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, UINT_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -716,7 +716,7 @@ static void test_qemu_strtoui_overflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmphex(res, ==, UINT_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -732,7 +732,7 @@ static void test_qemu_strtoui_underflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpuint(res, ==, (unsigned int)-1);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -748,7 +748,7 @@ static void test_qemu_strtoui_negative(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, (unsigned int)-321);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoui_full_correct(void)
@@ -830,7 +830,7 @@ static void test_qemu_strtol_correct(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345);
-    g_assert(endptr == str + 5);
+    g_assert_true(endptr == str + 5);
 }

 static void test_qemu_strtol_null(void)
@@ -843,7 +843,7 @@ static void test_qemu_strtol_null(void)
     err = qemu_strtol(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtol_empty(void)
@@ -857,7 +857,7 @@ static void test_qemu_strtol_empty(void)
     err = qemu_strtol(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtol_whitespace(void)
@@ -871,7 +871,7 @@ static void test_qemu_strtol_whitespace(void)
     err = qemu_strtol(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtol_invalid(void)
@@ -885,7 +885,7 @@ static void test_qemu_strtol_invalid(void)
     err = qemu_strtol(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtol_trailing(void)
@@ -900,7 +900,7 @@ static void test_qemu_strtol_trailing(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_qemu_strtol_octal(void)
@@ -915,7 +915,7 @@ static void test_qemu_strtol_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     res = 999;
     endptr = &f;
@@ -923,7 +923,7 @@ static void test_qemu_strtol_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtol_decimal(void)
@@ -938,7 +938,7 @@ static void test_qemu_strtol_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "123";
     res = 999;
@@ -947,7 +947,7 @@ static void test_qemu_strtol_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtol_hex(void)
@@ -962,7 +962,7 @@ static void test_qemu_strtol_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x123";
     res = 999;
@@ -971,7 +971,7 @@ static void test_qemu_strtol_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x";
     res = 999;
@@ -980,7 +980,7 @@ static void test_qemu_strtol_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);
 }

 static void test_qemu_strtol_max(void)
@@ -995,7 +995,7 @@ static void test_qemu_strtol_max(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, LONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -1011,7 +1011,7 @@ static void test_qemu_strtol_overflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, LONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtol_underflow(void)
@@ -1026,7 +1026,7 @@ static void test_qemu_strtol_underflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, LONG_MIN);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtol_negative(void)
@@ -1041,7 +1041,7 @@ static void test_qemu_strtol_negative(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, -321);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtol_full_correct(void)
@@ -1066,7 +1066,7 @@ static void test_qemu_strtol_full_null(void)
     err = qemu_strtol(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtol_full_empty(void)
@@ -1128,7 +1128,7 @@ static void test_qemu_strtoul_correct(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 12345);
-    g_assert(endptr == str + 5);
+    g_assert_true(endptr == str + 5);
 }

 static void test_qemu_strtoul_null(void)
@@ -1141,7 +1141,7 @@ static void test_qemu_strtoul_null(void)
     err = qemu_strtoul(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtoul_empty(void)
@@ -1155,7 +1155,7 @@ static void test_qemu_strtoul_empty(void)
     err = qemu_strtoul(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoul_whitespace(void)
@@ -1169,7 +1169,7 @@ static void test_qemu_strtoul_whitespace(void)
     err = qemu_strtoul(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoul_invalid(void)
@@ -1183,7 +1183,7 @@ static void test_qemu_strtoul_invalid(void)
     err = qemu_strtoul(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoul_trailing(void)
@@ -1198,7 +1198,7 @@ static void test_qemu_strtoul_trailing(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_qemu_strtoul_octal(void)
@@ -1213,7 +1213,7 @@ static void test_qemu_strtoul_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     res = 999;
     endptr = &f;
@@ -1221,7 +1221,7 @@ static void test_qemu_strtoul_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoul_decimal(void)
@@ -1236,7 +1236,7 @@ static void test_qemu_strtoul_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "123";
     res = 999;
@@ -1245,7 +1245,7 @@ static void test_qemu_strtoul_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoul_hex(void)
@@ -1260,7 +1260,7 @@ static void test_qemu_strtoul_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x123";
     res = 999;
@@ -1269,7 +1269,7 @@ static void test_qemu_strtoul_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x";
     res = 999;
@@ -1278,7 +1278,7 @@ static void test_qemu_strtoul_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);
 }

 static void test_qemu_strtoul_max(void)
@@ -1293,7 +1293,7 @@ static void test_qemu_strtoul_max(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, ULONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -1309,7 +1309,7 @@ static void test_qemu_strtoul_overflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmphex(res, ==, ULONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoul_underflow(void)
@@ -1324,7 +1324,7 @@ static void test_qemu_strtoul_underflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpuint(res, ==, -1ul);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoul_negative(void)
@@ -1339,7 +1339,7 @@ static void test_qemu_strtoul_negative(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, -321ul);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoul_full_correct(void)
@@ -1421,7 +1421,7 @@ static void test_qemu_strtoi64_correct(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345);
-    g_assert(endptr == str + 5);
+    g_assert_true(endptr == str + 5);
 }

 static void test_qemu_strtoi64_null(void)
@@ -1434,7 +1434,7 @@ static void test_qemu_strtoi64_null(void)
     err = qemu_strtoi64(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtoi64_empty(void)
@@ -1448,7 +1448,7 @@ static void test_qemu_strtoi64_empty(void)
     err = qemu_strtoi64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoi64_whitespace(void)
@@ -1462,7 +1462,7 @@ static void test_qemu_strtoi64_whitespace(void)
     err = qemu_strtoi64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoi64_invalid(void)
@@ -1476,7 +1476,7 @@ static void test_qemu_strtoi64_invalid(void)
     err = qemu_strtoi64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtoi64_trailing(void)
@@ -1491,7 +1491,7 @@ static void test_qemu_strtoi64_trailing(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_qemu_strtoi64_octal(void)
@@ -1506,7 +1506,7 @@ static void test_qemu_strtoi64_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     endptr = &f;
     res = 999;
@@ -1514,7 +1514,7 @@ static void test_qemu_strtoi64_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi64_decimal(void)
@@ -1529,7 +1529,7 @@ static void test_qemu_strtoi64_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "123";
     endptr = &f;
@@ -1538,7 +1538,7 @@ static void test_qemu_strtoi64_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi64_hex(void)
@@ -1553,7 +1553,7 @@ static void test_qemu_strtoi64_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x123";
     endptr = &f;
@@ -1562,7 +1562,7 @@ static void test_qemu_strtoi64_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x";
     endptr = &f;
@@ -1571,7 +1571,7 @@ static void test_qemu_strtoi64_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);
 }

 static void test_qemu_strtoi64_max(void)
@@ -1586,7 +1586,7 @@ static void test_qemu_strtoi64_max(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, LLONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -1602,7 +1602,7 @@ static void test_qemu_strtoi64_overflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, LLONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi64_underflow(void)
@@ -1617,7 +1617,7 @@ static void test_qemu_strtoi64_underflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, LLONG_MIN);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi64_negative(void)
@@ -1632,7 +1632,7 @@ static void test_qemu_strtoi64_negative(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, -321);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi64_full_correct(void)
@@ -1717,7 +1717,7 @@ static void test_qemu_strtou64_correct(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 12345);
-    g_assert(endptr == str + 5);
+    g_assert_true(endptr == str + 5);
 }

 static void test_qemu_strtou64_null(void)
@@ -1730,7 +1730,7 @@ static void test_qemu_strtou64_null(void)
     err = qemu_strtou64(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == NULL);
+    g_assert_null(endptr);
 }

 static void test_qemu_strtou64_empty(void)
@@ -1744,7 +1744,7 @@ static void test_qemu_strtou64_empty(void)
     err = qemu_strtou64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtou64_whitespace(void)
@@ -1758,7 +1758,7 @@ static void test_qemu_strtou64_whitespace(void)
     err = qemu_strtou64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtou64_invalid(void)
@@ -1772,7 +1772,7 @@ static void test_qemu_strtou64_invalid(void)
     err = qemu_strtou64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtou64_trailing(void)
@@ -1787,7 +1787,7 @@ static void test_qemu_strtou64_trailing(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_qemu_strtou64_octal(void)
@@ -1802,7 +1802,7 @@ static void test_qemu_strtou64_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     endptr = &f;
     res = 999;
@@ -1810,7 +1810,7 @@ static void test_qemu_strtou64_octal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 0123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtou64_decimal(void)
@@ -1825,7 +1825,7 @@ static void test_qemu_strtou64_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "123";
     endptr = &f;
@@ -1834,7 +1834,7 @@ static void test_qemu_strtou64_decimal(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, 123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtou64_hex(void)
@@ -1849,7 +1849,7 @@ static void test_qemu_strtou64_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x123";
     endptr = &f;
@@ -1858,7 +1858,7 @@ static void test_qemu_strtou64_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0x123);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));

     str = "0x";
     endptr = &f;
@@ -1867,7 +1867,7 @@ static void test_qemu_strtou64_hex(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);
 }

 static void test_qemu_strtou64_max(void)
@@ -1882,7 +1882,7 @@ static void test_qemu_strtou64_max(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmphex(res, ==, ULLONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

@@ -1898,7 +1898,7 @@ static void test_qemu_strtou64_overflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmphex(res, ==, ULLONG_MAX);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtou64_underflow(void)
@@ -1913,7 +1913,7 @@ static void test_qemu_strtou64_underflow(void)

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmphex(res, ==, -1ull);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtou64_negative(void)
@@ -1928,7 +1928,7 @@ static void test_qemu_strtou64_negative(void)

     g_assert_cmpint(err, ==, 0);
     g_assert_cmpuint(res, ==, -321ull);
-    g_assert(endptr == str + strlen(str));
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtou64_full_correct(void)
@@ -2013,7 +2013,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);

     /* Leading 0 gives decimal results, not octal */
     str = "08";
@@ -2022,7 +2022,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 8);
-    g_assert(endptr == str + 2);
+    g_assert_true(endptr == str + 2);

     /* Leading space is ignored */
     str = " 12345";
@@ -2031,7 +2031,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345);
-    g_assert(endptr == str + 6);
+    g_assert_true(endptr == str + 6);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
@@ -2044,7 +2044,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x1fffffffffffff);
-    g_assert(endptr == str + 16);
+    g_assert_true(endptr == str + 16);

     str = "9007199254740992"; /* 2^53 */
     endptr = str;
@@ -2052,7 +2052,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x20000000000000);
-    g_assert(endptr == str + 16);
+    g_assert_true(endptr == str + 16);

     str = "9007199254740993"; /* 2^53+1 */
     endptr = str;
@@ -2060,7 +2060,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0x20000000000001);
-    g_assert(endptr == str + 16);
+    g_assert_true(endptr == str + 16);

     str = "18446744073709549568"; /* 0xfffffffffffff800 (53 msbs set) */
     endptr = str;
@@ -2068,7 +2068,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0xfffffffffffff800);
-    g_assert(endptr == str + 20);
+    g_assert_true(endptr == str + 20);

     str = "18446744073709550591"; /* 0xfffffffffffffbff */
     endptr = str;
@@ -2076,7 +2076,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0xfffffffffffffbff);
-    g_assert(endptr == str + 20);
+    g_assert_true(endptr == str + 20);

     str = "18446744073709551615"; /* 0xffffffffffffffff */
     endptr = str;
@@ -2084,7 +2084,7 @@ static void test_qemu_strtosz_simple(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0xffffffffffffffff);
-    g_assert(endptr == str + 20);
+    g_assert_true(endptr == str + 20);
 }

 static void test_qemu_strtosz_hex(void)
@@ -2100,7 +2100,7 @@ static void test_qemu_strtosz_hex(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);

     str = "0xab";
     endptr = str;
@@ -2108,7 +2108,7 @@ static void test_qemu_strtosz_hex(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 171);
-    g_assert(endptr == str + 4);
+    g_assert_true(endptr == str + 4);

     str = "0xae";
     endptr = str;
@@ -2116,7 +2116,7 @@ static void test_qemu_strtosz_hex(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 174);
-    g_assert(endptr == str + 4);
+    g_assert_true(endptr == str + 4);
 }

 static void test_qemu_strtosz_units(void)
@@ -2139,56 +2139,56 @@ static void test_qemu_strtosz_units(void)
     err = qemu_strtosz_MiB(none, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, MiB);
-    g_assert(endptr == none + 1);
+    g_assert_true(endptr == none + 1);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(b, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 1);
-    g_assert(endptr == b + 2);
+    g_assert_true(endptr == b + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(k, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, KiB);
-    g_assert(endptr == k + 2);
+    g_assert_true(endptr == k + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(m, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, MiB);
-    g_assert(endptr == m + 2);
+    g_assert_true(endptr == m + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(g, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, GiB);
-    g_assert(endptr == g + 2);
+    g_assert_true(endptr == g + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(t, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, TiB);
-    g_assert(endptr == t + 2);
+    g_assert_true(endptr == t + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(p, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, PiB);
-    g_assert(endptr == p + 2);
+    g_assert_true(endptr == p + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(e, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, EiB);
-    g_assert(endptr == e + 2);
+    g_assert_true(endptr == e + 2);
 }

 static void test_qemu_strtosz_float(void)
@@ -2204,7 +2204,7 @@ static void test_qemu_strtosz_float(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, EiB / 2);
-    g_assert(endptr == str + 4);
+    g_assert_true(endptr == str + 4);

     /* For convenience, a fraction of 0 is tolerated even on bytes */
     str = "1.0B";
@@ -2213,7 +2213,7 @@ static void test_qemu_strtosz_float(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 1);
-    g_assert(endptr == str + 4);
+    g_assert_true(endptr == str + 4);

     /* An empty fraction is tolerated */
     str = "1.k";
@@ -2222,7 +2222,7 @@ static void test_qemu_strtosz_float(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 1024);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);

     /* For convenience, we permit values that are not byte-exact */
     str = "12.345M";
@@ -2231,7 +2231,7 @@ static void test_qemu_strtosz_float(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, (uint64_t) (12.345 * MiB + 0.5));
-    g_assert(endptr == str + 7);
+    g_assert_true(endptr == str + 7);
 }

 static void test_qemu_strtosz_invalid(void)
@@ -2246,35 +2246,35 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     str = " \t ";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     str = "crap";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     str = "inf";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     str = "NaN";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     /* Fractional values require scale larger than bytes */
     str = "1.1B";
@@ -2282,14 +2282,14 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     str = "1.1";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     /* No floating point exponents */
     str = "1.5e1k";
@@ -2297,14 +2297,14 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     str = "1.5E+0k";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     /* No hex fractions */
     str = "0x1.8k";
@@ -2312,7 +2312,7 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     /* No suffixes */
     str = "0x18M";
@@ -2320,7 +2320,7 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     /* No negative values */
     str = "-0";
@@ -2328,14 +2328,14 @@ static void test_qemu_strtosz_invalid(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);

     str = "-1";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str);
+    g_assert_true(endptr == str);
 }

 static void test_qemu_strtosz_trailing(void)
@@ -2351,7 +2351,7 @@ static void test_qemu_strtosz_trailing(void)
     err = qemu_strtosz_MiB(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123 * MiB);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
@@ -2364,7 +2364,7 @@ static void test_qemu_strtosz_trailing(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 1024);
-    g_assert(endptr == str + 2);
+    g_assert_true(endptr == str + 2);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
@@ -2377,7 +2377,7 @@ static void test_qemu_strtosz_trailing(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
-    g_assert(endptr == str + 1);
+    g_assert_true(endptr == str + 1);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
@@ -2390,7 +2390,7 @@ static void test_qemu_strtosz_trailing(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 0);
-    g_assert(endptr == str + 2);
+    g_assert_true(endptr == str + 2);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
@@ -2403,7 +2403,7 @@ static void test_qemu_strtosz_trailing(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 123);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
@@ -2423,14 +2423,14 @@ static void test_qemu_strtosz_erange(void)
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str + 20);
+    g_assert_true(endptr == str + 20);

     str = "20E";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, 0xbaadf00d);
-    g_assert(endptr == str + 3);
+    g_assert_true(endptr == str + 3);
 }

 static void test_qemu_strtosz_metric(void)
@@ -2446,7 +2446,7 @@ static void test_qemu_strtosz_metric(void)
     err = qemu_strtosz_metric(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345000);
-    g_assert(endptr == str + 6);
+    g_assert_true(endptr == str + 6);

     str = "12.345M";
     endptr = str;
@@ -2454,7 +2454,7 @@ static void test_qemu_strtosz_metric(void)
     err = qemu_strtosz_metric(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, 12345000);
-    g_assert(endptr == str + 7);
+    g_assert_true(endptr == str + 7);
 }

 static void test_freq_to_str(void)
-- 
2.40.1


