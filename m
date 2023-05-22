Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 503FB70C5B5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Aq1-0003Xx-Nj; Mon, 22 May 2023 15:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apx-0003Up-7I
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aps-0003Yw-KQ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAyAqRyO5Fw96Zq3R98ET2LI/vmsyOkSNcGdhxn2ohk=;
 b=ilx/SJ8qQJVXGB/Nq3+df6CmiLIf9mPeCsKazX6NzeQ3wHwpcMwkf5UA3YqEyT5BbiP9kh
 au6W4TCzWia6cRW7bVg4tksAtPiatyM+pA19S6XyeC3hXNRWgVsuFY0OmT7+q34zzjSyKW
 n5n6DC0mbU5sklWhvbWVlcED9PgnTgg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-27-dWUZWhLQMRGBUZwzALHGzw-1; Mon, 22 May 2023 15:04:46 -0400
X-MC-Unique: dWUZWhLQMRGBUZwzALHGzw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D959F811E7C;
 Mon, 22 May 2023 19:04:45 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72A71400DFF;
 Mon, 22 May 2023 19:04:45 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 04/19] test-cutils: Test more integer corner cases
Date: Mon, 22 May 2023 14:04:26 -0500
Message-Id: <20230522190441.64278-5-eblake@redhat.com>
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

We have quite a few undertested and underdocumented integer parsing
corner cases.  To ensure that any changes we make in the code are
intentional rather than accidental semantic changes, it is time to add
more unit tests of existing behavior.

In particular, this demonstrates that parse_uint() and qemu_strtou64()
behave differently.  For "-0", it's hard to argue why parse_uint needs
to reject it (it's not a negative integer), but the documentation sort
of mentions it; but it is intentional that all other negative values
are treated as ERANGE with value 0 (compared to qemu_strtou64()
treating "-2" as success and UINT64_MAX-1, for example).

Also, when mixing overflow/underflow with a check for no trailing
junk, parse_uint_full favors ERANGE over EINVAL, while qemu_strto[iu]*
favor EINVAL.  This behavior is outside the C standard, so we can pick
whatever we want, but it would be nice to be consistent.

Note that C requires that "9223372036854775808" fail strtoll() with
ERANGE/INT64_MAX, but "-9223372036854775808" pass with INT64_MIN; we
weren't testing this.  For strtol(), the behavior depends on whether
long is 32- or 64-bits (the cutoff point either being the same as
strtoll() or at "-2147483648").  Meanwhile, C is clear that
"-18446744073709551615" pass stroull() (but not strtoll) with value 1,
even though we want it to fail parse_uint().  And although
qemu_strtoui() has no C counterpart, it makes more sense if we design
it like 32-bit strtoul() (that is, where "-4294967296" be an alternate
acceptable spelling for "1", but "-0xffffffff00000001" should be
treated as overflow and return 0xffffffff rather than 1).  We aren't
there yet, so some of the tests added in this patch have FIXME
comments.

However, note that C2x will (likely) be adding a SILENT semantic
change, where C17 strtol("0b1", &ep, 2) returns 0 with ep="b1", but
C2x will have it return 1 with ep="".  I did not feel like adding
testing for those corner cases, in part because the next version of C
is not standard and libc support for binary parsing is not yet
wide-spread (as of this patch, glibc.git still misparses bare "0b":
https://sourceware.org/bugzilla/show_bug.cgi?id=30371).

Signed-off-by: Eric Blake <eblake@redhat.com>
---

v3: use cmpuint in more places [Hanna], expose another strtoui flaw
and add compaanion tests to strtoul, expand commit message, R-b dropped
---
 tests/unit/test-cutils.c | 929 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 864 insertions(+), 65 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 1eeaf21ae22..7d0ab4ca4c2 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -150,7 +150,6 @@ static void test_parse_uint_decimal(void)
     g_assert_true(endptr == str + strlen(str));
 }

-
 static void test_parse_uint_llong_max(void)
 {
     unsigned long long i = 999;
@@ -168,27 +167,87 @@ static void test_parse_uint_llong_max(void)
     g_free(str);
 }

+static void test_parse_uint_max(void)
+{
+    unsigned long long i = 999;
+    char f = 'X';
+    char *endptr = &f;
+    char *str = g_strdup_printf("%llu", ULLONG_MAX);
+    int r;
+
+    r = parse_uint(str, &i, &endptr, 0);
+
+    g_assert_cmpint(r, ==, 0);
+    g_assert_cmpuint(i, ==, ULLONG_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    g_free(str);
+}
+
 static void test_parse_uint_overflow(void)
 {
-    unsigned long long i = 999;
+    unsigned long long i;
     char f = 'X';
-    char *endptr = &f;
-    const char *str = "99999999999999999999999999999999999999";
+    char *endptr;
+    const char *str;
     int r;

+    i = 999;
+    endptr = &f;
+    str = "99999999999999999999999999999999999999";
     r = parse_uint(str, &i, &endptr, 0);
+    g_assert_cmpint(r, ==, -ERANGE);
+    g_assert_cmpuint(i, ==, ULLONG_MAX);
+    g_assert_true(endptr == str + strlen(str));

+    i = 999;
+    endptr = &f;
+    str = "0x10000000000000000"; /* 65 bits, 64-bit sign bit clear */
+    r = parse_uint(str, &i, &endptr, 0);
+    g_assert_cmpint(r, ==, -ERANGE);
+    g_assert_cmpuint(i, ==, ULLONG_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    i = 999;
+    endptr = &f;
+    str = "0x18000000080000000"; /* 65 bits, 64-bit sign bit set */
+    r = parse_uint(str, &i, &endptr, 0);
     g_assert_cmpint(r, ==, -ERANGE);
     g_assert_cmpuint(i, ==, ULLONG_MAX);
     g_assert_true(endptr == str + strlen(str));
 }

 static void test_parse_uint_negative(void)
+{
+    unsigned long long i;
+    char f = 'X';
+    char *endptr;
+    const char *str;
+    int r;
+
+    i = 999;
+    endptr = &f;
+    str = " \t -321";
+    r = parse_uint(str, &i, &endptr, 0);
+    g_assert_cmpint(r, ==, -ERANGE);
+    g_assert_cmpuint(i, ==, 0);
+    g_assert_true(endptr == str + strlen(str));
+
+    i = 999;
+    endptr = &f;
+    str = "-0xffffffff00000001";
+    r = parse_uint(str, &i, &endptr, 0);
+    g_assert_cmpint(r, ==, -ERANGE);
+    g_assert_cmpuint(i, ==, 0);
+    g_assert_true(endptr == str + strlen(str));
+}
+
+static void test_parse_uint_negzero(void)
 {
     unsigned long long i = 999;
     char f = 'X';
     char *endptr = &f;
-    const char *str = " \t -321";
+    const char *str = " -0";
     int r;

     r = parse_uint(str, &i, &endptr, 0);
@@ -198,7 +257,6 @@ static void test_parse_uint_negative(void)
     g_assert_true(endptr == str + strlen(str));
 }

-
 static void test_parse_uint_full_trailing(void)
 {
     unsigned long long i = 999;
@@ -223,6 +281,19 @@ static void test_parse_uint_full_correct(void)
     g_assert_cmpuint(i, ==, 123);
 }

+static void test_parse_uint_full_erange_junk(void)
+{
+    /* FIXME - inconsistent with qemu_strto* which favors EINVAL */
+    unsigned long long i = 999;
+    const char *str = "-2junk";
+    int r;
+
+    r = parse_uint_full(str, &i, 0);
+
+    g_assert_cmpint(r, ==, -ERANGE /* FIXME -EINVAL */);
+    g_assert_cmpuint(i, ==, 0);
+}
+
 static void test_qemu_strtoi_correct(void)
 {
     const char *str = "12345 foo";
@@ -410,7 +481,55 @@ static void test_qemu_strtoi_max(void)

 static void test_qemu_strtoi_overflow(void)
 {
-    char *str = g_strdup_printf("%lld", (long long)INT_MAX + 1ll);
+    const char *str;
+    const char *endptr;
+    int res;
+    int err;
+
+    str = "2147483648"; /* INT_MAX + 1ll */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x7fffffffffffffff"; /* LLONG_MAX */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x8000000000000000"; /* (uint64_t)LLONG_MIN */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x10000000000000000"; /* 65 bits, 32-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x18000000080000000"; /* 65 bits, 32-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_min(void)
+{
+    char *str = g_strdup_printf("%d", INT_MIN);
     char f = 'X';
     const char *endptr = &f;
     int res = 999;
@@ -418,31 +537,95 @@ static void test_qemu_strtoi_overflow(void)

     err = qemu_strtoi(str, &endptr, 0, &res);

-    g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, INT_MAX);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, INT_MIN);
     g_assert_true(endptr == str + strlen(str));
     g_free(str);
 }

 static void test_qemu_strtoi_underflow(void)
 {
-    char *str = g_strdup_printf("%lld", (long long)INT_MIN - 1ll);
-    char f = 'X';
-    const char *endptr = &f;
-    int res = 999;
+    const char *str;
+    const char *endptr;
+    int res;
     int err;

+    str = "-2147483649"; /* INT_MIN - 1ll */
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MIN);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x7fffffffffffffff"; /* -LLONG_MAX */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MIN);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x8000000000000000"; /* (uint64_t)LLONG_MIN */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MIN);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-18446744073709551615"; /* -UINT64_MAX (not 1) */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MIN);
+    g_assert_true(endptr == str + strlen(str));

+    str = "-0x10000000000000000"; /* 65 bits, 32-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT_MIN);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x18000000080000000"; /* 65 bits, 32-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, INT_MIN);
     g_assert_true(endptr == str + strlen(str));
-    g_free(str);
 }

 static void test_qemu_strtoi_negative(void)
 {
-    const char *str = "  \t -321";
+    const char *str;
+    const char *endptr;
+    int res;
+    int err;
+
+    str = "  \t -321";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, -321);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-2147483648"; /* INT_MIN */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, INT_MIN);
+    g_assert_true(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtoi_negzero(void)
+{
+    const char *str = " -0";
     char f = 'X';
     const char *endptr = &f;
     int res = 999;
@@ -451,7 +634,7 @@ static void test_qemu_strtoi_negative(void)
     err = qemu_strtoi(str, &endptr, 0, &res);

     g_assert_cmpint(err, ==, 0);
-    g_assert_cmpint(res, ==, -321);
+    g_assert_cmpint(res, ==, 0);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -505,6 +688,18 @@ static void test_qemu_strtoi_full_negative(void)
     g_assert_cmpint(res, ==, -321);
 }

+static void test_qemu_strtoi_full_negzero(void)
+{
+    const char *str = " -0";
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0);
+}
+
 static void test_qemu_strtoi_full_trailing(void)
 {
     const char *str = "123xxx";
@@ -530,6 +725,19 @@ static void test_qemu_strtoi_full_max(void)
     g_free(str);
 }

+static void test_qemu_strtoi_full_erange_junk(void)
+{
+    /* EINVAL has priority over ERANGE */
+    const char *str = "-9999999999junk";
+    int res = 999;
+    int err;
+
+    err = qemu_strtoi(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, INT_MIN);
+}
+
 static void test_qemu_strtoui_correct(void)
 {
     const char *str = "12345 foo";
@@ -699,6 +907,22 @@ static void test_qemu_strtoui_hex(void)
     g_assert_true(endptr == str + 1);
 }

+static void test_qemu_strtoui_wrap(void)
+{
+    /* FIXME - wraparound should be consistent with 32-bit strtoul */
+    const char *str = "-4294967295"; /* 1 mod 2^32 */
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, -ERANGE /* FIXME 0 */);
+    g_assert_cmphex(res, ==, UINT_MAX /* FIXME 1 */);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtoui_max(void)
 {
     char *str = g_strdup_printf("%u", UINT_MAX);
@@ -717,34 +941,116 @@ static void test_qemu_strtoui_max(void)

 static void test_qemu_strtoui_overflow(void)
 {
-    char *str = g_strdup_printf("%lld", (long long)UINT_MAX + 1ll);
-    char f = 'X';
-    const char *endptr = &f;
-    unsigned int res = 999;
+    const char *str;
+    const char *endptr;
+    unsigned int res;
     int err;

+    str = "4294967296"; /* UINT_MAX + 1ll */
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x7fffffffffffffff"; /* LLONG_MAX */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x8000000000000000"; /* (uint64_t)LLONG_MIN */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0xffffffff00000001"; /* ULLONG_MAX - UINT_MAX + 1 (not 1) */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    /* FIXME - overflow should be consistent with 32-bit strtoul */
+    str = "0xfffffffffffffffe"; /* ULLONG_MAX - 1 (not UINT_MAX - 1) */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, 0 /* FIXME -ERANGE */);
+    g_assert_cmpuint(res, ==, UINT_MAX - 1 /* FIXME UINT_MAX */);
+    g_assert_true(endptr == str + strlen(str));

+    str = "0x10000000000000000"; /* 65 bits, 32-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x18000000080000000"; /* 65 bits, 32-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmphex(res, ==, UINT_MAX);
+    g_assert_cmpuint(res, ==, UINT_MAX);
     g_assert_true(endptr == str + strlen(str));
-    g_free(str);
 }

 static void test_qemu_strtoui_underflow(void)
 {
-    char *str = g_strdup_printf("%lld", (long long)INT_MIN - 1ll);
-    char f = 'X';
-    const char *endptr = &f;
-    unsigned int res = 999;
+    const char *str;
+    const char *endptr;
+    unsigned int res;
     int err;

+    str = "-4294967296"; /* -(long long)UINT_MAX - 1ll */
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+    g_assert_true(endptr == str + strlen(str));

+    /* FIXME - overflow should be consistent with 32-bit strtoul */
+    str = "-18446744073709551615"; /* -UINT64_MAX (not -(-1)) */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, 0 /* FIXME -ERANGE */);
+    g_assert_cmpuint(res, ==, 1 /* FIXME UINT_MAX */);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0xffffffff00000002";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, 0 /* FIXME -ERANGE */);
+    g_assert_cmpuint(res, ==, UINT_MAX - 1 /* FIXME UINT_MAX */);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x10000000000000000"; /* 65 bits, 32-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x18000000080000000"; /* 65 bits, 32-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoui(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpuint(res, ==, (unsigned int)-1);
+    g_assert_cmpuint(res, ==, UINT_MAX);
     g_assert_true(endptr == str + strlen(str));
-    g_free(str);
 }

 static void test_qemu_strtoui_negative(void)
@@ -762,6 +1068,21 @@ static void test_qemu_strtoui_negative(void)
     g_assert_true(endptr == str + strlen(str));
 }

+static void test_qemu_strtoui_negzero(void)
+{
+    const char *str = " -0";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtoui_full_correct(void)
 {
     const char *str = "123";
@@ -808,6 +1129,17 @@ static void test_qemu_strtoui_full_negative(void)
     g_assert_cmpuint(res, ==, (unsigned int)-321);
 }

+static void test_qemu_strtoui_full_negzero(void)
+{
+    const char *str = " -0";
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, NULL, 0, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
+}
+
 static void test_qemu_strtoui_full_trailing(void)
 {
     const char *str = "123xxx";
@@ -833,6 +1165,19 @@ static void test_qemu_strtoui_full_max(void)
     g_free(str);
 }

+static void test_qemu_strtoui_full_erange_junk(void)
+{
+    /* EINVAL has priority over ERANGE */
+    const char *str = "-9999999999junk";
+    unsigned int res = 999;
+    int err;
+
+    err = qemu_strtoui(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, UINT_MAX);
+}
+
 static void test_qemu_strtol_correct(void)
 {
     const char *str = "12345 foo";
@@ -1020,7 +1365,50 @@ static void test_qemu_strtol_max(void)

 static void test_qemu_strtol_overflow(void)
 {
-    const char *str = "99999999999999999999999999999999999999999999";
+    const char *str;
+    const char *endptr;
+    long res;
+    int err;
+
+    /* 1 more than LONG_MAX */
+    str = LONG_MAX == INT_MAX ? "2147483648" : "9223372036854775808";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtol(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, LONG_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    if (LONG_MAX == INT_MAX) {
+        str = "0xffffffff00000001"; /* ULLONG_MAX - UNIT_MAX + 1 (not 1) */
+        endptr = "somewhere";
+        res = 999;
+        err = qemu_strtol(str, &endptr, 0, &res);
+        g_assert_cmpint(err, ==, -ERANGE);
+        g_assert_cmpint(res, ==, LONG_MIN);
+        g_assert_true(endptr == str + strlen(str));
+    }
+
+    str = "0x10000000000000000"; /* 65 bits, either sign bit position clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtol(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, LONG_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x18000000080000000"; /* 65 bits, either sign bit position set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtol(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, LONG_MAX);
+    g_assert_true(endptr == str + strlen(str));
+}
+
+static void test_qemu_strtol_min(void)
+{
+    char *str = g_strdup_printf("%ld", LONG_MIN);
     char f = 'X';
     const char *endptr = &f;
     long res = 999;
@@ -1028,21 +1416,50 @@ static void test_qemu_strtol_overflow(void)

     err = qemu_strtol(str, &endptr, 0, &res);

-    g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, LONG_MAX);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, LONG_MIN);
     g_assert_true(endptr == str + strlen(str));
+    g_free(str);
 }

 static void test_qemu_strtol_underflow(void)
 {
-    const char *str = "-99999999999999999999999999999999999999999999";
-    char f = 'X';
-    const char *endptr = &f;
-    long res = 999;
+    const char *str;
+    const char *endptr;
+    long res;
     int err;

+    /* 1 less than LONG_MIN */
+    str = LONG_MIN == INT_MIN ? "-2147483649" : "-9223372036854775809";
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtol(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, LONG_MIN);
+    g_assert_true(endptr == str + strlen(str));

+    if (LONG_MAX == INT_MAX) {
+        str = "-18446744073709551615"; /* -UINT64_MAX (not 1) */
+        endptr = "somewhere";
+        res = 999;
+        err = qemu_strtol(str, &endptr, 0, &res);
+        g_assert_cmpint(err, ==, -ERANGE);
+        g_assert_cmpint(res, ==, LONG_MIN);
+        g_assert_true(endptr == str + strlen(str));
+    }
+
+    str = "-0x10000000000000000"; /* 65 bits, either sign bit position clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtol(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, LONG_MIN);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x18000000080000000"; /* 65 bits, either sign bit position set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtol(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
     g_assert_cmpint(res, ==, LONG_MIN);
     g_assert_true(endptr == str + strlen(str));
@@ -1063,6 +1480,21 @@ static void test_qemu_strtol_negative(void)
     g_assert_true(endptr == str + strlen(str));
 }

+static void test_qemu_strtol_negzero(void)
+{
+    const char *str = " -0";
+    char f = 'X';
+    const char *endptr = &f;
+    long res = 999;
+    int err;
+
+    err = qemu_strtol(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtol_full_correct(void)
 {
     const char *str = "123";
@@ -1113,6 +1545,18 @@ static void test_qemu_strtol_full_negative(void)
     g_assert_cmpint(res, ==, -321);
 }

+static void test_qemu_strtol_full_negzero(void)
+{
+    const char *str = " -0";
+    long res = 999;
+    int err;
+
+    err = qemu_strtol(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0);
+}
+
 static void test_qemu_strtol_full_trailing(void)
 {
     const char *str = "123xxx";
@@ -1138,6 +1582,19 @@ static void test_qemu_strtol_full_max(void)
     g_free(str);
 }

+static void test_qemu_strtol_full_erange_junk(void)
+{
+    /* EINVAL has priority over ERANGE */
+    const char *str = "-99999999999999999999junk";
+    long res = 999;
+    int err;
+
+    err = qemu_strtol(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, LONG_MIN);
+}
+
 static void test_qemu_strtoul_correct(void)
 {
     const char *str = "12345 foo";
@@ -1307,6 +1764,23 @@ static void test_qemu_strtoul_hex(void)
     g_assert_true(endptr == str + 1);
 }

+static void test_qemu_strtoul_wrap(void)
+{
+    const char *str;
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned long res = 999;
+    int err;
+
+    /* 1 mod 2^(sizeof(long)*8) */
+    str = LONG_MAX == INT_MAX ? "-4294967295" : "-18446744073709551615";
+    err = qemu_strtoul(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmphex(res, ==, 1);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtoul_max(void)
 {
     char *str = g_strdup_printf("%lu", ULONG_MAX);
@@ -1325,31 +1799,87 @@ static void test_qemu_strtoul_max(void)

 static void test_qemu_strtoul_overflow(void)
 {
-    const char *str = "99999999999999999999999999999999999999999999";
-    char f = 'X';
-    const char *endptr = &f;
-    unsigned long res = 999;
+    const char *str;
+    const char *endptr;
+    unsigned long res;
     int err;

+    /* 1 more than ULONG_MAX */
+    str = ULONG_MAX == UINT_MAX ? "4294967296" : "18446744073709551616";
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtoul(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    if (LONG_MAX == INT_MAX) {
+        str = "0xffffffff00000001"; /* UINT64_MAX - UINT_MAX + 1 (not 1) */
+        endptr = "somewhere";
+        res = 999;
+        err = qemu_strtoul(str, &endptr, 0, &res);
+        g_assert_cmpint(err, ==, -ERANGE);
+        g_assert_cmpuint(res, ==, ULONG_MAX);
+        g_assert_true(endptr == str + strlen(str));
+    }
+
+    str = "0x10000000000000000"; /* 65 bits, either sign bit position clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoul(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
+    g_assert_true(endptr == str + strlen(str));

+    str = "0x18000000080000000"; /* 65 bits, either sign bit position set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoul(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmphex(res, ==, ULONG_MAX);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
     g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoul_underflow(void)
 {
-    const char *str = "-99999999999999999999999999999999999999999999";
-    char f = 'X';
-    const char *endptr = &f;
-    unsigned long res = 999;
+    const char *str;
+    const char *endptr;
+    unsigned long res;
     int err;

+    /* 1 less than -ULONG_MAX */
+    str = ULONG_MAX == UINT_MAX ? "-4294967296" : "-18446744073709551616";
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtoul(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, ULONG_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    if (LONG_MAX == INT_MAX) {
+        str = "-0xffffffff00000002";
+        endptr = "somewhere";
+        res = 999;
+        err = qemu_strtoul(str, &endptr, 0, &res);
+        g_assert_cmpint(err, ==, -ERANGE);
+        g_assert_cmpuint(res, ==, ULONG_MAX);
+        g_assert_true(endptr == str + strlen(str));
+    }
+
+    str = "-0x10000000000000000"; /* 65 bits, either sign bit position clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoul(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
+    g_assert_true(endptr == str + strlen(str));

+    str = "-0x18000000080000000"; /* 65 bits, either sign bit position set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoul(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpuint(res, ==, -1ul);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -1368,6 +1898,21 @@ static void test_qemu_strtoul_negative(void)
     g_assert_true(endptr == str + strlen(str));
 }

+static void test_qemu_strtoul_negzero(void)
+{
+    const char *str = " -0";
+    char f = 'X';
+    const char *endptr = &f;
+    unsigned long res = 999;
+    int err;
+
+    err = qemu_strtoul(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtoul_full_correct(void)
 {
     const char *str = "123";
@@ -1414,6 +1959,17 @@ static void test_qemu_strtoul_full_negative(void)
     g_assert_cmpuint(res, ==, -321ul);
 }

+static void test_qemu_strtoul_full_negzero(void)
+{
+    const char *str = " -0";
+    unsigned long res = 999;
+    int err;
+
+    err = qemu_strtoul(str, NULL, 0, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
+}
+
 static void test_qemu_strtoul_full_trailing(void)
 {
     const char *str = "123xxx";
@@ -1439,6 +1995,19 @@ static void test_qemu_strtoul_full_max(void)
     g_free(str);
 }

+static void test_qemu_strtoul_full_erange_junk(void)
+{
+    /* EINVAL has priority over ERANGE */
+    const char *str = "-99999999999999999999junk";
+    unsigned long res = 999;
+    int err;
+
+    err = qemu_strtoul(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, ULONG_MAX);
+}
+
 static void test_qemu_strtoi64_correct(void)
 {
     const char *str = "12345 foo";
@@ -1626,22 +2195,39 @@ static void test_qemu_strtoi64_max(void)

 static void test_qemu_strtoi64_overflow(void)
 {
-    const char *str = "99999999999999999999999999999999999999999999";
-    char f = 'X';
-    const char *endptr = &f;
-    int64_t res = 999;
+    const char *str;
+    const char *endptr;
+    int64_t res;
     int err;

+    str = "9223372036854775808"; /* 1 more than INT64_MAX */
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtoi64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT64_MAX);
+    g_assert_true(endptr == str + strlen(str));

+    str = "0x10000000000000000"; /* 65 bits, 64-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT64_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x18000000080000000"; /* 65 bits, 64-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi64(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpint(res, ==, LLONG_MAX);
+    g_assert_cmpint(res, ==, INT64_MAX);
     g_assert_true(endptr == str + strlen(str));
 }

-static void test_qemu_strtoi64_underflow(void)
+static void test_qemu_strtoi64_min(void)
 {
-    const char *str = "-99999999999999999999999999999999999999999999";
+    char *str = g_strdup_printf("%lld", LLONG_MIN);
     char f = 'X';
     const char *endptr = &f;
     int64_t res = 999;
@@ -1649,9 +2235,42 @@ static void test_qemu_strtoi64_underflow(void)

     err = qemu_strtoi64(str, &endptr, 0, &res);

-    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(err, ==, 0);
     g_assert_cmpint(res, ==, LLONG_MIN);
     g_assert_true(endptr == str + strlen(str));
+    g_free(str);
+}
+
+static void test_qemu_strtoi64_underflow(void)
+{
+    const char *str;
+    const char *endptr;
+    int64_t res;
+    int err;
+
+    str = "-9223372036854775809"; /* 1 less than INT64_MIN */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT64_MIN);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x10000000000000000"; /* 65 bits, 64-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT64_MIN);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x18000000080000000"; /* 65 bits, 64-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtoi64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpint(res, ==, INT64_MIN);
+    g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtoi64_negative(void)
@@ -1669,6 +2288,21 @@ static void test_qemu_strtoi64_negative(void)
     g_assert_true(endptr == str + strlen(str));
 }

+static void test_qemu_strtoi64_negzero(void)
+{
+    const char *str = " -0";
+    char f = 'X';
+    const char *endptr = &f;
+    int64_t res = 999;
+    int err;
+
+    err = qemu_strtoi64(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtoi64_full_correct(void)
 {
     const char *str = "123";
@@ -1716,6 +2350,18 @@ static void test_qemu_strtoi64_full_negative(void)
     g_assert_cmpint(res, ==, -321);
 }

+static void test_qemu_strtoi64_full_negzero(void)
+{
+    const char *str = " -0";
+    int64_t res = 999;
+    int err;
+
+    err = qemu_strtoi64(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpint(res, ==, 0);
+}
+
 static void test_qemu_strtoi64_full_trailing(void)
 {
     const char *str = "123xxx";
@@ -1742,6 +2388,19 @@ static void test_qemu_strtoi64_full_max(void)
     g_free(str);
 }

+static void test_qemu_strtoi64_full_erange_junk(void)
+{
+    /* EINVAL has priority over ERANGE */
+    const char *str = "-99999999999999999999junk";
+    int64_t res = 999;
+    int err;
+
+    err = qemu_strtoi64(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpint(res, ==, INT64_MIN);
+}
+
 static void test_qemu_strtou64_correct(void)
 {
     const char *str = "12345 foo";
@@ -1911,6 +2570,21 @@ static void test_qemu_strtou64_hex(void)
     g_assert_true(endptr == str + 1);
 }

+static void test_qemu_strtou64_wrap(void)
+{
+    const char *str = "-18446744073709551615"; /* 1 mod 2^64 */
+    char f = 'X';
+    const char *endptr = &f;
+    uint64_t res = 999;
+    int err;
+
+    err = qemu_strtou64(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 1);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtou64_max(void)
 {
     char *str = g_strdup_printf("%llu", ULLONG_MAX);
@@ -1929,31 +2603,65 @@ static void test_qemu_strtou64_max(void)

 static void test_qemu_strtou64_overflow(void)
 {
-    const char *str = "99999999999999999999999999999999999999999999";
-    char f = 'X';
-    const char *endptr = &f;
-    uint64_t res = 999;
+    const char *str;
+    const char *endptr;
+    uint64_t res;
     int err;

+    str = "18446744073709551616"; /* 1 more than UINT64_MAX */
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtou64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT64_MAX);
+    g_assert_true(endptr == str + strlen(str));

+    str = "0x10000000000000000"; /* 65 bits, 64-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtou64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT64_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "0x18000000080000000"; /* 65 bits, 64-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtou64(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmphex(res, ==, ULLONG_MAX);
+    g_assert_cmpuint(res, ==, UINT64_MAX);
     g_assert_true(endptr == str + strlen(str));
 }

 static void test_qemu_strtou64_underflow(void)
 {
-    const char *str = "-99999999999999999999999999999999999999999999";
-    char f = 'X';
-    const char *endptr = &f;
-    uint64_t res = 999;
+    const char *str;
+    const char *endptr;
+    uint64_t res;
     int err;

+    str = "-99999999999999999999999999999999999999999999";
+    endptr = "somewhere";
+    res = 999;
     err = qemu_strtou64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT64_MAX);
+    g_assert_true(endptr == str + strlen(str));

+    str = "-0x10000000000000000"; /* 65 bits, 64-bit sign bit clear */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtou64(str, &endptr, 0, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT64_MAX);
+    g_assert_true(endptr == str + strlen(str));
+
+    str = "-0x18000000080000000"; /* 65 bits, 64-bit sign bit set */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtou64(str, &endptr, 0, &res);
     g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmphex(res, ==, -1ull);
+    g_assert_cmpuint(res, ==, UINT64_MAX);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -1972,6 +2680,21 @@ static void test_qemu_strtou64_negative(void)
     g_assert_true(endptr == str + strlen(str));
 }

+static void test_qemu_strtou64_negzero(void)
+{
+    const char *str = " -0";
+    char f = 'X';
+    const char *endptr = &f;
+    uint64_t res = 999;
+    int err;
+
+    err = qemu_strtou64(str, &endptr, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
+    g_assert_true(endptr == str + strlen(str));
+}
+
 static void test_qemu_strtou64_full_correct(void)
 {
     const char *str = "18446744073709551614";
@@ -2019,6 +2742,18 @@ static void test_qemu_strtou64_full_negative(void)
     g_assert_cmpuint(res, ==, -321ull);
 }

+static void test_qemu_strtou64_full_negzero(void)
+{
+    const char *str = " -0";
+    uint64_t res = 999;
+    int err;
+
+    err = qemu_strtou64(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpuint(res, ==, 0);
+}
+
 static void test_qemu_strtou64_full_trailing(void)
 {
     const char *str = "18446744073709551614xxxxxx";
@@ -2044,6 +2779,19 @@ static void test_qemu_strtou64_full_max(void)
     g_free(str);
 }

+static void test_qemu_strtou64_full_erange_junk(void)
+{
+    /* EINVAL has priority over ERANGE */
+    const char *str = "-99999999999999999999junk";
+    uint64_t res = 999;
+    int err;
+
+    err = qemu_strtou64(str, NULL, 0, &res);
+
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpuint(res, ==, UINT64_MAX);
+}
+
 static void test_qemu_strtosz_simple(void)
 {
     const char *str;
@@ -2585,12 +3333,16 @@ int main(int argc, char **argv)
     g_test_add_func("/cutils/parse_uint/octal", test_parse_uint_octal);
     g_test_add_func("/cutils/parse_uint/decimal", test_parse_uint_decimal);
     g_test_add_func("/cutils/parse_uint/llong_max", test_parse_uint_llong_max);
+    g_test_add_func("/cutils/parse_uint/max", test_parse_uint_max);
     g_test_add_func("/cutils/parse_uint/overflow", test_parse_uint_overflow);
     g_test_add_func("/cutils/parse_uint/negative", test_parse_uint_negative);
+    g_test_add_func("/cutils/parse_uint/negzero", test_parse_uint_negzero);
     g_test_add_func("/cutils/parse_uint_full/trailing",
                     test_parse_uint_full_trailing);
     g_test_add_func("/cutils/parse_uint_full/correct",
                     test_parse_uint_full_correct);
+    g_test_add_func("/cutils/parse_uint_full/erange_junk",
+                    test_parse_uint_full_erange_junk);

     /* qemu_strtoi() tests */
     g_test_add_func("/cutils/qemu_strtoi/correct",
@@ -2615,10 +3367,14 @@ int main(int argc, char **argv)
                     test_qemu_strtoi_max);
     g_test_add_func("/cutils/qemu_strtoi/overflow",
                     test_qemu_strtoi_overflow);
+    g_test_add_func("/cutils/qemu_strtoi/min",
+                    test_qemu_strtoi_min);
     g_test_add_func("/cutils/qemu_strtoi/underflow",
                     test_qemu_strtoi_underflow);
     g_test_add_func("/cutils/qemu_strtoi/negative",
                     test_qemu_strtoi_negative);
+    g_test_add_func("/cutils/qemu_strtoi/negzero",
+                    test_qemu_strtoi_negzero);
     g_test_add_func("/cutils/qemu_strtoi_full/correct",
                     test_qemu_strtoi_full_correct);
     g_test_add_func("/cutils/qemu_strtoi_full/null",
@@ -2627,10 +3383,14 @@ int main(int argc, char **argv)
                     test_qemu_strtoi_full_empty);
     g_test_add_func("/cutils/qemu_strtoi_full/negative",
                     test_qemu_strtoi_full_negative);
+    g_test_add_func("/cutils/qemu_strtoi_full/negzero",
+                    test_qemu_strtoi_full_negzero);
     g_test_add_func("/cutils/qemu_strtoi_full/trailing",
                     test_qemu_strtoi_full_trailing);
     g_test_add_func("/cutils/qemu_strtoi_full/max",
                     test_qemu_strtoi_full_max);
+    g_test_add_func("/cutils/qemu_strtoi_full/erange_junk",
+                    test_qemu_strtoi_full_erange_junk);

     /* qemu_strtoui() tests */
     g_test_add_func("/cutils/qemu_strtoui/correct",
@@ -2651,6 +3411,8 @@ int main(int argc, char **argv)
                     test_qemu_strtoui_decimal);
     g_test_add_func("/cutils/qemu_strtoui/hex",
                     test_qemu_strtoui_hex);
+    g_test_add_func("/cutils/qemu_strtoui/wrap",
+                    test_qemu_strtoui_wrap);
     g_test_add_func("/cutils/qemu_strtoui/max",
                     test_qemu_strtoui_max);
     g_test_add_func("/cutils/qemu_strtoui/overflow",
@@ -2659,6 +3421,8 @@ int main(int argc, char **argv)
                     test_qemu_strtoui_underflow);
     g_test_add_func("/cutils/qemu_strtoui/negative",
                     test_qemu_strtoui_negative);
+    g_test_add_func("/cutils/qemu_strtoui/negzero",
+                    test_qemu_strtoui_negzero);
     g_test_add_func("/cutils/qemu_strtoui_full/correct",
                     test_qemu_strtoui_full_correct);
     g_test_add_func("/cutils/qemu_strtoui_full/null",
@@ -2667,10 +3431,14 @@ int main(int argc, char **argv)
                     test_qemu_strtoui_full_empty);
     g_test_add_func("/cutils/qemu_strtoui_full/negative",
                     test_qemu_strtoui_full_negative);
+    g_test_add_func("/cutils/qemu_strtoui_full/negzero",
+                    test_qemu_strtoui_full_negzero);
     g_test_add_func("/cutils/qemu_strtoui_full/trailing",
                     test_qemu_strtoui_full_trailing);
     g_test_add_func("/cutils/qemu_strtoui_full/max",
                     test_qemu_strtoui_full_max);
+    g_test_add_func("/cutils/qemu_strtoui_full/erange_junk",
+                    test_qemu_strtoui_full_erange_junk);

     /* qemu_strtol() tests */
     g_test_add_func("/cutils/qemu_strtol/correct",
@@ -2695,10 +3463,14 @@ int main(int argc, char **argv)
                     test_qemu_strtol_max);
     g_test_add_func("/cutils/qemu_strtol/overflow",
                     test_qemu_strtol_overflow);
+    g_test_add_func("/cutils/qemu_strtol/min",
+                    test_qemu_strtol_min);
     g_test_add_func("/cutils/qemu_strtol/underflow",
                     test_qemu_strtol_underflow);
     g_test_add_func("/cutils/qemu_strtol/negative",
                     test_qemu_strtol_negative);
+    g_test_add_func("/cutils/qemu_strtol/negzero",
+                    test_qemu_strtol_negzero);
     g_test_add_func("/cutils/qemu_strtol_full/correct",
                     test_qemu_strtol_full_correct);
     g_test_add_func("/cutils/qemu_strtol_full/null",
@@ -2707,10 +3479,14 @@ int main(int argc, char **argv)
                     test_qemu_strtol_full_empty);
     g_test_add_func("/cutils/qemu_strtol_full/negative",
                     test_qemu_strtol_full_negative);
+    g_test_add_func("/cutils/qemu_strtol_full/negzero",
+                    test_qemu_strtol_full_negzero);
     g_test_add_func("/cutils/qemu_strtol_full/trailing",
                     test_qemu_strtol_full_trailing);
     g_test_add_func("/cutils/qemu_strtol_full/max",
                     test_qemu_strtol_full_max);
+    g_test_add_func("/cutils/qemu_strtol_full/erange_junk",
+                    test_qemu_strtol_full_erange_junk);

     /* qemu_strtoul() tests */
     g_test_add_func("/cutils/qemu_strtoul/correct",
@@ -2731,6 +3507,8 @@ int main(int argc, char **argv)
                     test_qemu_strtoul_decimal);
     g_test_add_func("/cutils/qemu_strtoul/hex",
                     test_qemu_strtoul_hex);
+    g_test_add_func("/cutils/qemu_strtoul/wrap",
+                    test_qemu_strtoul_wrap);
     g_test_add_func("/cutils/qemu_strtoul/max",
                     test_qemu_strtoul_max);
     g_test_add_func("/cutils/qemu_strtoul/overflow",
@@ -2739,6 +3517,8 @@ int main(int argc, char **argv)
                     test_qemu_strtoul_underflow);
     g_test_add_func("/cutils/qemu_strtoul/negative",
                     test_qemu_strtoul_negative);
+    g_test_add_func("/cutils/qemu_strtoul/negzero",
+                    test_qemu_strtoul_negzero);
     g_test_add_func("/cutils/qemu_strtoul_full/correct",
                     test_qemu_strtoul_full_correct);
     g_test_add_func("/cutils/qemu_strtoul_full/null",
@@ -2747,10 +3527,14 @@ int main(int argc, char **argv)
                     test_qemu_strtoul_full_empty);
     g_test_add_func("/cutils/qemu_strtoul_full/negative",
                     test_qemu_strtoul_full_negative);
+    g_test_add_func("/cutils/qemu_strtoul_full/negzero",
+                    test_qemu_strtoul_full_negzero);
     g_test_add_func("/cutils/qemu_strtoul_full/trailing",
                     test_qemu_strtoul_full_trailing);
     g_test_add_func("/cutils/qemu_strtoul_full/max",
                     test_qemu_strtoul_full_max);
+    g_test_add_func("/cutils/qemu_strtoul_full/erange_junk",
+                    test_qemu_strtoul_full_erange_junk);

     /* qemu_strtoi64() tests */
     g_test_add_func("/cutils/qemu_strtoi64/correct",
@@ -2761,8 +3545,7 @@ int main(int argc, char **argv)
                     test_qemu_strtoi64_empty);
     g_test_add_func("/cutils/qemu_strtoi64/whitespace",
                     test_qemu_strtoi64_whitespace);
-    g_test_add_func("/cutils/qemu_strtoi64/invalid"
-                    ,
+    g_test_add_func("/cutils/qemu_strtoi64/invalid",
                     test_qemu_strtoi64_invalid);
     g_test_add_func("/cutils/qemu_strtoi64/trailing",
                     test_qemu_strtoi64_trailing);
@@ -2776,10 +3559,14 @@ int main(int argc, char **argv)
                     test_qemu_strtoi64_max);
     g_test_add_func("/cutils/qemu_strtoi64/overflow",
                     test_qemu_strtoi64_overflow);
+    g_test_add_func("/cutils/qemu_strtoi64/min",
+                    test_qemu_strtoi64_min);
     g_test_add_func("/cutils/qemu_strtoi64/underflow",
                     test_qemu_strtoi64_underflow);
     g_test_add_func("/cutils/qemu_strtoi64/negative",
                     test_qemu_strtoi64_negative);
+    g_test_add_func("/cutils/qemu_strtoi64/negzero",
+                    test_qemu_strtoi64_negzero);
     g_test_add_func("/cutils/qemu_strtoi64_full/correct",
                     test_qemu_strtoi64_full_correct);
     g_test_add_func("/cutils/qemu_strtoi64_full/null",
@@ -2788,10 +3575,14 @@ int main(int argc, char **argv)
                     test_qemu_strtoi64_full_empty);
     g_test_add_func("/cutils/qemu_strtoi64_full/negative",
                     test_qemu_strtoi64_full_negative);
+    g_test_add_func("/cutils/qemu_strtoi64_full/negzero",
+                    test_qemu_strtoi64_full_negzero);
     g_test_add_func("/cutils/qemu_strtoi64_full/trailing",
                     test_qemu_strtoi64_full_trailing);
     g_test_add_func("/cutils/qemu_strtoi64_full/max",
                     test_qemu_strtoi64_full_max);
+    g_test_add_func("/cutils/qemu_strtoi64_full/erange_junk",
+                    test_qemu_strtoi64_full_erange_junk);

     /* qemu_strtou64() tests */
     g_test_add_func("/cutils/qemu_strtou64/correct",
@@ -2812,6 +3603,8 @@ int main(int argc, char **argv)
                     test_qemu_strtou64_decimal);
     g_test_add_func("/cutils/qemu_strtou64/hex",
                     test_qemu_strtou64_hex);
+    g_test_add_func("/cutils/qemu_strtou64/wrap",
+                    test_qemu_strtou64_wrap);
     g_test_add_func("/cutils/qemu_strtou64/max",
                     test_qemu_strtou64_max);
     g_test_add_func("/cutils/qemu_strtou64/overflow",
@@ -2820,6 +3613,8 @@ int main(int argc, char **argv)
                     test_qemu_strtou64_underflow);
     g_test_add_func("/cutils/qemu_strtou64/negative",
                     test_qemu_strtou64_negative);
+    g_test_add_func("/cutils/qemu_strtou64/negzero",
+                    test_qemu_strtou64_negzero);
     g_test_add_func("/cutils/qemu_strtou64_full/correct",
                     test_qemu_strtou64_full_correct);
     g_test_add_func("/cutils/qemu_strtou64_full/null",
@@ -2828,10 +3623,14 @@ int main(int argc, char **argv)
                     test_qemu_strtou64_full_empty);
     g_test_add_func("/cutils/qemu_strtou64_full/negative",
                     test_qemu_strtou64_full_negative);
+    g_test_add_func("/cutils/qemu_strtou64_full/negzero",
+                    test_qemu_strtou64_full_negzero);
     g_test_add_func("/cutils/qemu_strtou64_full/trailing",
                     test_qemu_strtou64_full_trailing);
     g_test_add_func("/cutils/qemu_strtou64_full/max",
                     test_qemu_strtou64_full_max);
+    g_test_add_func("/cutils/qemu_strtou64_full/erange_junk",
+                    test_qemu_strtou64_full_erange_junk);

     g_test_add_func("/cutils/strtosz/simple",
                     test_qemu_strtosz_simple);
-- 
2.40.1


