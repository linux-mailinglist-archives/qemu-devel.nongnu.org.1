Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F971F586
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOJ-00080c-57; Thu, 01 Jun 2023 18:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO9-0007zl-PD
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO4-0003zP-Py
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJvrFraKWslNVXjvTrG/kgTi3MNLv6kwQBNv6XwrjlY=;
 b=Du9PdjYOTRB6GjR88PGFS9jXLJPHc6iJj8R/+xDnXGsJA6oug5ah05hHorew26PMZedtfV
 lPqM/p3AR56J8k7UIsa2M7YckvZstwwVqd3urLWUmkM8eiBOw2tMtJceadnrJlyRUY8R+h
 3PVKWyJhL14vqnHVY1+Or51lzgatiOE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-UbMcT7KOOgSx_ugqWqoK6g-1; Thu, 01 Jun 2023 18:03:13 -0400
X-MC-Unique: UbMcT7KOOgSx_ugqWqoK6g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C55361C05AB1
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 22:03:12 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8487D492B0A;
 Thu,  1 Jun 2023 22:03:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 05/21] test-cutils: Test integral qemu_strto* value on failures
Date: Thu,  1 Jun 2023 17:02:49 -0500
Message-Id: <20230601220305.2130121-6-eblake@redhat.com>
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com>
References: <20230601220305.2130121-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

We are inconsistent on the contents of *value after a strto* parse
failure.  I found the following behaviors:

- parse_uint() and parse_uint_full(), which document that *value is
  slammed to 0 on all EINVAL failures and 0 or UINT_MAX on ERANGE
  failures, and has unit tests for that (note that parse_uint requires
  non-NULL endptr, and does not fail with EINVAL for trailing junk)

- qemu_strtosz(), which leaves *value untouched on all failures (both
  EINVAL and ERANGE), and has unit tests but not documentation for
  that

- qemu_strtoi() and other integral friends, which document *value on
  ERANGE failures but is unspecified on EINVAL (other than implicitly
  by comparison to libc strto*); there, *value is untouched for NULL
  string, slammed to 0 on no conversion, and left at the prefix value
  on NULL endptr; unit tests do not consistently check the value

- qemu_strtod(), which documents *value on ERANGE failures but is
  unspecified on EINVAL; there, *value is untouched for NULL string,
  slammed to 0.0 for no conversion, and left at the prefix value on
  NULL endptr; there are no unit tests (other than indirectly through
  qemu_strtosz)

- qemu_strtod_finite(), which documents *value on ERANGE failures but
  is unspecified on EINVAL; there, *value is left at the prefix for
  'inf' or 'nan' and untouched in all other cases; there are no unit
  tests (other than indirectly through qemu_strtosz)

Upcoming patches will change behaviors for consistency, but it's best
to first have more unit test coverage to see the impact of those
changes.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230522190441.64278-4-eblake@redhat.com>
---
 tests/unit/test-cutils.c | 58 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 38bd3990207..1eeaf21ae22 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -248,6 +248,7 @@ static void test_qemu_strtoi_null(void)
     err = qemu_strtoi(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -262,6 +263,7 @@ static void test_qemu_strtoi_empty(void)
     err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -276,6 +278,7 @@ static void test_qemu_strtoi_whitespace(void)
     err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -290,6 +293,7 @@ static void test_qemu_strtoi_invalid(void)
     err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -473,6 +477,7 @@ static void test_qemu_strtoi_full_null(void)
     err = qemu_strtoi(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -485,6 +490,7 @@ static void test_qemu_strtoi_full_empty(void)
     err = qemu_strtoi(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
 }

 static void test_qemu_strtoi_full_negative(void)
@@ -502,18 +508,19 @@ static void test_qemu_strtoi_full_negative(void)
 static void test_qemu_strtoi_full_trailing(void)
 {
     const char *str = "123xxx";
-    int res;
+    int res = 999;
     int err;

     err = qemu_strtoi(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 123);
 }

 static void test_qemu_strtoi_full_max(void)
 {
     char *str = g_strdup_printf("%d", INT_MAX);
-    int res;
+    int res = 999;
     int err;

     err = qemu_strtoi(str, NULL, 0, &res);
@@ -548,6 +555,7 @@ static void test_qemu_strtoui_null(void)
     err = qemu_strtoui(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -562,6 +570,7 @@ static void test_qemu_strtoui_empty(void)
     err = qemu_strtoui(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -576,6 +585,7 @@ static void test_qemu_strtoui_whitespace(void)
     err = qemu_strtoui(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -590,6 +600,7 @@ static void test_qemu_strtoui_invalid(void)
     err = qemu_strtoui(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -771,6 +782,7 @@ static void test_qemu_strtoui_full_null(void)
     err = qemu_strtoui(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 999);
 }

 static void test_qemu_strtoui_full_empty(void)
@@ -782,7 +794,9 @@ static void test_qemu_strtoui_full_empty(void)
     err = qemu_strtoui(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
 }
+
 static void test_qemu_strtoui_full_negative(void)
 {
     const char *str = " \t -321";
@@ -797,12 +811,13 @@ static void test_qemu_strtoui_full_negative(void)
 static void test_qemu_strtoui_full_trailing(void)
 {
     const char *str = "123xxx";
-    unsigned int res;
+    unsigned int res = 999;
     int err;

     err = qemu_strtoui(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 123);
 }

 static void test_qemu_strtoui_full_max(void)
@@ -843,6 +858,7 @@ static void test_qemu_strtol_null(void)
     err = qemu_strtol(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -857,6 +873,7 @@ static void test_qemu_strtol_empty(void)
     err = qemu_strtol(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -871,6 +888,7 @@ static void test_qemu_strtol_whitespace(void)
     err = qemu_strtol(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -885,6 +903,7 @@ static void test_qemu_strtol_invalid(void)
     err = qemu_strtol(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1066,6 +1085,7 @@ static void test_qemu_strtol_full_null(void)
     err = qemu_strtol(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -1078,6 +1098,7 @@ static void test_qemu_strtol_full_empty(void)
     err = qemu_strtol(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
 }

 static void test_qemu_strtol_full_negative(void)
@@ -1095,18 +1116,19 @@ static void test_qemu_strtol_full_negative(void)
 static void test_qemu_strtol_full_trailing(void)
 {
     const char *str = "123xxx";
-    long res;
+    long res = 999;
     int err;

     err = qemu_strtol(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 123);
 }

 static void test_qemu_strtol_full_max(void)
 {
     char *str = g_strdup_printf("%ld", LONG_MAX);
-    long res;
+    long res = 999;
     int err;

     err = qemu_strtol(str, NULL, 0, &res);
@@ -1141,6 +1163,7 @@ static void test_qemu_strtoul_null(void)
     err = qemu_strtoul(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -1155,6 +1178,7 @@ static void test_qemu_strtoul_empty(void)
     err = qemu_strtoul(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1169,6 +1193,7 @@ static void test_qemu_strtoul_whitespace(void)
     err = qemu_strtoul(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1183,6 +1208,7 @@ static void test_qemu_strtoul_invalid(void)
     err = qemu_strtoul(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1362,6 +1388,7 @@ static void test_qemu_strtoul_full_null(void)
     err = qemu_strtoul(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 999);
 }

 static void test_qemu_strtoul_full_empty(void)
@@ -1373,7 +1400,9 @@ static void test_qemu_strtoul_full_empty(void)
     err = qemu_strtoul(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
 }
+
 static void test_qemu_strtoul_full_negative(void)
 {
     const char *str = " \t -321";
@@ -1388,12 +1417,13 @@ static void test_qemu_strtoul_full_negative(void)
 static void test_qemu_strtoul_full_trailing(void)
 {
     const char *str = "123xxx";
-    unsigned long res;
+    unsigned long res = 999;
     int err;

     err = qemu_strtoul(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 123);
 }

 static void test_qemu_strtoul_full_max(void)
@@ -1434,6 +1464,7 @@ static void test_qemu_strtoi64_null(void)
     err = qemu_strtoi64(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -1448,6 +1479,7 @@ static void test_qemu_strtoi64_empty(void)
     err = qemu_strtoi64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1462,6 +1494,7 @@ static void test_qemu_strtoi64_whitespace(void)
     err = qemu_strtoi64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1476,6 +1509,7 @@ static void test_qemu_strtoi64_invalid(void)
     err = qemu_strtoi64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1655,6 +1689,7 @@ static void test_qemu_strtoi64_full_null(void)
     err = qemu_strtoi64(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 999);
 }

 static void test_qemu_strtoi64_full_empty(void)
@@ -1666,6 +1701,7 @@ static void test_qemu_strtoi64_full_empty(void)
     err = qemu_strtoi64(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 0);
 }

 static void test_qemu_strtoi64_full_negative(void)
@@ -1689,13 +1725,14 @@ static void test_qemu_strtoi64_full_trailing(void)
     err = qemu_strtoi64(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, 123);
 }

 static void test_qemu_strtoi64_full_max(void)
 {

     char *str = g_strdup_printf("%lld", LLONG_MAX);
-    int64_t res;
+    int64_t res = 999;
     int err;

     err = qemu_strtoi64(str, NULL, 0, &res);
@@ -1730,6 +1767,7 @@ static void test_qemu_strtou64_null(void)
     err = qemu_strtou64(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 999);
     g_assert_null(endptr);
 }

@@ -1744,6 +1782,7 @@ static void test_qemu_strtou64_empty(void)
     err = qemu_strtou64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1758,6 +1797,7 @@ static void test_qemu_strtou64_whitespace(void)
     err = qemu_strtou64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1772,6 +1812,7 @@ static void test_qemu_strtou64_invalid(void)
     err = qemu_strtou64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -1951,6 +1992,7 @@ static void test_qemu_strtou64_full_null(void)
     err = qemu_strtou64(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 999);
 }

 static void test_qemu_strtou64_full_empty(void)
@@ -1962,6 +2004,7 @@ static void test_qemu_strtou64_full_empty(void)
     err = qemu_strtou64(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 0);
 }

 static void test_qemu_strtou64_full_negative(void)
@@ -1985,6 +2028,7 @@ static void test_qemu_strtou64_full_trailing(void)
     err = qemu_strtou64(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, 18446744073709551614ULL);
 }

 static void test_qemu_strtou64_full_max(void)
-- 
2.40.1


