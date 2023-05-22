Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2BF70C5C8
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Aq1-0003Xf-E2; Mon, 22 May 2023 15:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apv-0003UI-P0
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aps-0003Yp-8U
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DnE5yLigiX1fw/dmNhgD7Ngi+RE5sDYe9MFcSHBcs9g=;
 b=LvGP6YAoFeMHQiLXaZnmCXlMd6FZ0OMn+MVWH9h6aYukqHJDiWyWdK43RouKvFXSC9Xgoj
 G+f8jSF4HytCG5Q+BBpFp77oXDC6X06IbjI0D4mycvaKniBi+oV1hW2qsGbEhlsxeTESm3
 JwJG+OBAMZGIuuTiAjke7xCZDMFyt90=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-SB3uojEtO3ye9vLlHiYXAA-1; Mon, 22 May 2023 15:04:46 -0400
X-MC-Unique: SB3uojEtO3ye9vLlHiYXAA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADDCA29AA2F6;
 Mon, 22 May 2023 19:04:44 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AE8B400DFF;
 Mon, 22 May 2023 19:04:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 02/19] test-cutils: Use g_assert_cmpuint where appropriate
Date: Mon, 22 May 2023 14:04:24 -0500
Message-Id: <20230522190441.64278-3-eblake@redhat.com>
In-Reply-To: <20230522190441.64278-1-eblake@redhat.com>
References: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

When debugging test failures, seeing unsigned values as large positive
values rather than negative values matters (assuming glib 2.78+; given
that I just fixed a bug in glib 2.76 [1] where g_assert_cmpuint
displays signed instead of unsigned values).  No impact when the test
is passing, but using a consistent style will matter more in upcoming
test additions.  Also, some tests are better with cmphex.

While at it, fix some spacing and minor typing issues spotted nearby.

[1] https://gitlab.gnome.org/GNOME/glib/-/issues/2997

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/unit/test-cutils.c | 148 +++++++++++++++++++--------------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 0202ac0d5b3..38bd3990207 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -39,7 +39,7 @@ static void test_parse_uint_null(void)
     r = parse_uint(NULL, &i, &endptr, 0);

     g_assert_cmpint(r, ==, -EINVAL);
-    g_assert_cmpint(i, ==, 0);
+    g_assert_cmpuint(i, ==, 0);
     g_assert_null(endptr);
 }

@@ -54,7 +54,7 @@ static void test_parse_uint_empty(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, -EINVAL);
-    g_assert_cmpint(i, ==, 0);
+    g_assert_cmpuint(i, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -69,7 +69,7 @@ static void test_parse_uint_whitespace(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, -EINVAL);
-    g_assert_cmpint(i, ==, 0);
+    g_assert_cmpuint(i, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -85,7 +85,7 @@ static void test_parse_uint_invalid(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, -EINVAL);
-    g_assert_cmpint(i, ==, 0);
+    g_assert_cmpuint(i, ==, 0);
     g_assert_true(endptr == str);
 }

@@ -101,7 +101,7 @@ static void test_parse_uint_trailing(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, 0);
-    g_assert_cmpint(i, ==, 123);
+    g_assert_cmpuint(i, ==, 123);
     g_assert_true(endptr == str + 3);
 }

@@ -116,7 +116,7 @@ static void test_parse_uint_correct(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, 0);
-    g_assert_cmpint(i, ==, 123);
+    g_assert_cmpuint(i, ==, 123);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -131,7 +131,7 @@ static void test_parse_uint_octal(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, 0);
-    g_assert_cmpint(i, ==, 0123);
+    g_assert_cmpuint(i, ==, 0123);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -146,7 +146,7 @@ static void test_parse_uint_decimal(void)
     r = parse_uint(str, &i, &endptr, 10);

     g_assert_cmpint(r, ==, 0);
-    g_assert_cmpint(i, ==, 123);
+    g_assert_cmpuint(i, ==, 123);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -162,7 +162,7 @@ static void test_parse_uint_llong_max(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, 0);
-    g_assert_cmpint(i, ==, (unsigned long long)LLONG_MAX + 1);
+    g_assert_cmpuint(i, ==, (unsigned long long)LLONG_MAX + 1);
     g_assert_true(endptr == str + strlen(str));

     g_free(str);
@@ -179,7 +179,7 @@ static void test_parse_uint_overflow(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, -ERANGE);
-    g_assert_cmpint(i, ==, ULLONG_MAX);
+    g_assert_cmpuint(i, ==, ULLONG_MAX);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -194,7 +194,7 @@ static void test_parse_uint_negative(void)
     r = parse_uint(str, &i, &endptr, 0);

     g_assert_cmpint(r, ==, -ERANGE);
-    g_assert_cmpint(i, ==, 0);
+    g_assert_cmpuint(i, ==, 0);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -208,7 +208,7 @@ static void test_parse_uint_full_trailing(void)
     r = parse_uint_full(str, &i, 0);

     g_assert_cmpint(r, ==, -EINVAL);
-    g_assert_cmpint(i, ==, 0);
+    g_assert_cmpuint(i, ==, 0);
 }

 static void test_parse_uint_full_correct(void)
@@ -220,7 +220,7 @@ static void test_parse_uint_full_correct(void)
     r = parse_uint_full(str, &i, 0);

     g_assert_cmpint(r, ==, 0);
-    g_assert_cmpint(i, ==, 123);
+    g_assert_cmpuint(i, ==, 123);
 }

 static void test_qemu_strtoi_correct(void)
@@ -428,7 +428,7 @@ static void test_qemu_strtoi_underflow(void)
     int res = 999;
     int err;

-    err  = qemu_strtoi(str, &endptr, 0, &res);
+    err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, INT_MIN);
@@ -479,10 +479,10 @@ static void test_qemu_strtoi_full_null(void)
 static void test_qemu_strtoi_full_empty(void)
 {
     const char *str = "";
-    int res = 999L;
+    int res = 999;
     int err;

-    err =  qemu_strtoi(str, NULL, 0, &res);
+    err = qemu_strtoi(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
 }
@@ -728,7 +728,7 @@ static void test_qemu_strtoui_underflow(void)
     unsigned int res = 999;
     int err;

-    err  = qemu_strtoui(str, &endptr, 0, &res);
+    err = qemu_strtoui(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpuint(res, ==, (unsigned int)-1);
@@ -1022,7 +1022,7 @@ static void test_qemu_strtol_underflow(void)
     long res = 999;
     int err;

-    err  = qemu_strtol(str, &endptr, 0, &res);
+    err = qemu_strtol(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, LONG_MIN);
@@ -1075,7 +1075,7 @@ static void test_qemu_strtol_full_empty(void)
     long res = 999L;
     int err;

-    err =  qemu_strtol(str, NULL, 0, &res);
+    err = qemu_strtol(str, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
 }
@@ -1320,7 +1320,7 @@ static void test_qemu_strtoul_underflow(void)
     unsigned long res = 999;
     int err;

-    err  = qemu_strtoul(str, &endptr, 0, &res);
+    err = qemu_strtoul(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpuint(res, ==, -1ul);
@@ -1613,7 +1613,7 @@ static void test_qemu_strtoi64_underflow(void)
     int64_t res = 999;
     int err;

-    err  = qemu_strtoi64(str, &endptr, 0, &res);
+    err = qemu_strtoi64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, LLONG_MIN);
@@ -1909,7 +1909,7 @@ static void test_qemu_strtou64_underflow(void)
     uint64_t res = 999;
     int err;

-    err  = qemu_strtou64(str, &endptr, 0, &res);
+    err = qemu_strtou64(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmphex(res, ==, -1ull);
@@ -2012,7 +2012,7 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str + 1);

     /* Leading 0 gives decimal results, not octal */
@@ -2021,7 +2021,7 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 8);
+    g_assert_cmpuint(res, ==, 8);
     g_assert_true(endptr == str + 2);

     /* Leading space is ignored */
@@ -2030,20 +2030,20 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345);
+    g_assert_cmpuint(res, ==, 12345);
     g_assert_true(endptr == str + 6);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345);
+    g_assert_cmpuint(res, ==, 12345);

     str = "9007199254740991"; /* 2^53-1 */
     endptr = str;
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x1fffffffffffff);
+    g_assert_cmphex(res, ==, 0x1fffffffffffffULL);
     g_assert_true(endptr == str + 16);

     str = "9007199254740992"; /* 2^53 */
@@ -2051,7 +2051,7 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x20000000000000);
+    g_assert_cmphex(res, ==, 0x20000000000000ULL);
     g_assert_true(endptr == str + 16);

     str = "9007199254740993"; /* 2^53+1 */
@@ -2059,7 +2059,7 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0x20000000000001);
+    g_assert_cmphex(res, ==, 0x20000000000001ULL);
     g_assert_true(endptr == str + 16);

     str = "18446744073709549568"; /* 0xfffffffffffff800 (53 msbs set) */
@@ -2067,7 +2067,7 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0xfffffffffffff800);
+    g_assert_cmphex(res, ==, 0xfffffffffffff800ULL);
     g_assert_true(endptr == str + 20);

     str = "18446744073709550591"; /* 0xfffffffffffffbff */
@@ -2075,7 +2075,7 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0xfffffffffffffbff);
+    g_assert_cmphex(res, ==, 0xfffffffffffffbffULL);
     g_assert_true(endptr == str + 20);

     str = "18446744073709551615"; /* 0xffffffffffffffff */
@@ -2083,7 +2083,7 @@ static void test_qemu_strtosz_simple(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0xffffffffffffffff);
+    g_assert_cmphex(res, ==, 0xffffffffffffffffULL);
     g_assert_true(endptr == str + 20);
 }

@@ -2099,7 +2099,7 @@ static void test_qemu_strtosz_hex(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str + 3);

     str = "0xab";
@@ -2107,7 +2107,7 @@ static void test_qemu_strtosz_hex(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 171);
+    g_assert_cmpuint(res, ==, 171);
     g_assert_true(endptr == str + 4);

     str = "0xae";
@@ -2115,7 +2115,7 @@ static void test_qemu_strtosz_hex(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 174);
+    g_assert_cmpuint(res, ==, 174);
     g_assert_true(endptr == str + 4);
 }

@@ -2138,56 +2138,56 @@ static void test_qemu_strtosz_units(void)
     res = 0xbaadf00d;
     err = qemu_strtosz_MiB(none, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, MiB);
+    g_assert_cmpuint(res, ==, MiB);
     g_assert_true(endptr == none + 1);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(b, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 1);
+    g_assert_cmpuint(res, ==, 1);
     g_assert_true(endptr == b + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(k, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, KiB);
+    g_assert_cmpuint(res, ==, KiB);
     g_assert_true(endptr == k + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(m, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, MiB);
+    g_assert_cmpuint(res, ==, MiB);
     g_assert_true(endptr == m + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(g, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, GiB);
+    g_assert_cmpuint(res, ==, GiB);
     g_assert_true(endptr == g + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(t, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, TiB);
+    g_assert_cmpuint(res, ==, TiB);
     g_assert_true(endptr == t + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(p, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, PiB);
+    g_assert_cmpuint(res, ==, PiB);
     g_assert_true(endptr == p + 2);

     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(e, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, EiB);
+    g_assert_cmpuint(res, ==, EiB);
     g_assert_true(endptr == e + 2);
 }

@@ -2203,7 +2203,7 @@ static void test_qemu_strtosz_float(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, EiB / 2);
+    g_assert_cmpuint(res, ==, EiB / 2);
     g_assert_true(endptr == str + 4);

     /* For convenience, a fraction of 0 is tolerated even on bytes */
@@ -2212,7 +2212,7 @@ static void test_qemu_strtosz_float(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 1);
+    g_assert_cmpuint(res, ==, 1);
     g_assert_true(endptr == str + 4);

     /* An empty fraction is tolerated */
@@ -2221,7 +2221,7 @@ static void test_qemu_strtosz_float(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 1024);
+    g_assert_cmpuint(res, ==, 1024);
     g_assert_true(endptr == str + 3);

     /* For convenience, we permit values that are not byte-exact */
@@ -2230,7 +2230,7 @@ static void test_qemu_strtosz_float(void)
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, (uint64_t) (12.345 * MiB + 0.5));
+    g_assert_cmpuint(res, ==, (uint64_t) (12.345 * MiB + 0.5));
     g_assert_true(endptr == str + 7);
 }

@@ -2245,35 +2245,35 @@ static void test_qemu_strtosz_invalid(void)
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     str = " \t ";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     str = "crap";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     str = "inf";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     str = "NaN";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     /* Fractional values require scale larger than bytes */
@@ -2281,14 +2281,14 @@ static void test_qemu_strtosz_invalid(void)
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     str = "1.1";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     /* No floating point exponents */
@@ -2296,14 +2296,14 @@ static void test_qemu_strtosz_invalid(void)
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     str = "1.5E+0k";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     /* No hex fractions */
@@ -2311,7 +2311,7 @@ static void test_qemu_strtosz_invalid(void)
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     /* No suffixes */
@@ -2319,7 +2319,7 @@ static void test_qemu_strtosz_invalid(void)
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     /* No negative values */
@@ -2327,14 +2327,14 @@ static void test_qemu_strtosz_invalid(void)
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);

     str = "-1";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str);
 }

@@ -2350,65 +2350,65 @@ static void test_qemu_strtosz_trailing(void)
     res = 0xbaadf00d;
     err = qemu_strtosz_MiB(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123 * MiB);
+    g_assert_cmpuint(res, ==, 123 * MiB);
     g_assert_true(endptr == str + 3);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);

     str = "1kiB";
     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 1024);
+    g_assert_cmpuint(res, ==, 1024);
     g_assert_true(endptr == str + 2);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);

     str = "0x";
     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str + 1);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);

     str = "0.NaN";
     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_true(endptr == str + 2);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);

     str = "123-45";
     endptr = NULL;
     res = 0xbaadf00d;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 123);
+    g_assert_cmpuint(res, ==, 123);
     g_assert_true(endptr == str + 3);

     res = 0xbaadf00d;
     err = qemu_strtosz(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
 }

 static void test_qemu_strtosz_erange(void)
@@ -2422,14 +2422,14 @@ static void test_qemu_strtosz_erange(void)
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str + 20);

     str = "20E";
     endptr = NULL;
     err = qemu_strtosz(str, &endptr, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
+    g_assert_cmphex(res, ==, 0xbaadf00d);
     g_assert_true(endptr == str + 3);
 }

@@ -2445,7 +2445,7 @@ static void test_qemu_strtosz_metric(void)
     res = 0xbaadf00d;
     err = qemu_strtosz_metric(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345000);
+    g_assert_cmpuint(res, ==, 12345000);
     g_assert_true(endptr == str + 6);

     str = "12.345M";
@@ -2453,7 +2453,7 @@ static void test_qemu_strtosz_metric(void)
     res = 0xbaadf00d;
     err = qemu_strtosz_metric(str, &endptr, &res);
     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, 12345000);
+    g_assert_cmpuint(res, ==, 12345000);
     g_assert_true(endptr == str + 7);
 }

-- 
2.40.1


