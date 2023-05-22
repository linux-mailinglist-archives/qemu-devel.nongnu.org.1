Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D6670C5B4
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:06:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Aq6-0003ah-5P; Mon, 22 May 2023 15:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq2-0003ZQ-Bq
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apw-0003aS-UW
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kl7b3XJPScT3Nb4cVZf4ajuV4fUUqt18115sX5L5Vno=;
 b=hbak2t0Mzgosr2MEpOgFkxBfEEegeLrLDA7C/Ag1ZiDSmWGRnYsi07FlGwdrWKWGAeNI/+
 EWLmjWGD8NznJV7cY1P45rFE1nYgyypO/8EnCVYkFIsz5w8I+i2sdVvPnsl6RPvaJVSTb7
 lP3Da6hsFx9qYY7LJgE+yT/DZDz7oVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-2eZWPMPaMTak79dqOMgRSQ-1; Mon, 22 May 2023 15:04:50 -0400
X-MC-Unique: 2eZWPMPaMTak79dqOMgRSQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6529D811E7C;
 Mon, 22 May 2023 19:04:50 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10E4E400DFF;
 Mon, 22 May 2023 19:04:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 11/19] test-cutils: Refactor qemu_strtosz tests for less
 boilerplate
Date: Mon, 22 May 2023 14:04:33 -0500
Message-Id: <20230522190441.64278-12-eblake@redhat.com>
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

No need to copy-and-paste lots of boilerplate per string tested, when
we can consolidate that behind helper functions.  Plus, this adds a
bit more coverage (we now test all strings both with and without
endptr, whereas before some tests skipped the NULL endptr case), which
exposed a SEGFAULT on qemu_strtosz(NULL, NULL, &val) that will be
fixed in an upcoming patch.

Note that duplicating boilerplate has one advantage lost here - a
failed test tells you which line number failed; but a helper function
does not show the call stack that reached the failure.  Since we call
the helper more than once within many of the "unit tests", even the
unit test name doesn't point out which call is failing.  But that only
matters when tests fail (they normally pass); at which point I'm
debugging the failures under gdb anyways, so I'm not too worried about
it.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---

v3: minor commit message tweak, R-b added
---
 tests/unit/test-cutils.c | 503 ++++++++-------------------------------
 1 file changed, 100 insertions(+), 403 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index f615dd0471c..ebc6015a600 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3272,473 +3272,170 @@ static void test_qemu_strtod_finite_erange_junk(void)
     g_assert_cmpfloat(res, ==, 999.0);
 }

+typedef int (*qemu_strtosz_fn)(const char *, const char **, uint64_t *);
+static void do_strtosz_full(const char *str, qemu_strtosz_fn fn,
+                            int exp_ptr_ret, uint64_t exp_ptr_val,
+                            size_t exp_ptr_offset, int exp_null_ret,
+                            uint64_t exp_null_val)
+{
+    const char *endptr = "somewhere";
+    uint64_t val = 0xbaadf00d;
+    int ret;
+
+    ret = fn(str, &endptr, &val);
+    g_assert_cmpint(ret, ==, exp_ptr_ret);
+    g_assert_cmpuint(val, ==, exp_ptr_val);
+    g_assert_true(endptr == str + exp_ptr_offset);
+
+    val = 0xbaadf00d;
+    ret = fn(str, NULL, &val);
+    g_assert_cmpint(ret, ==, exp_null_ret);
+    g_assert_cmpuint(val, ==, exp_null_val);
+}
+
+static void do_strtosz(const char *str, int exp_ret, uint64_t exp_val,
+                       size_t exp_offset)
+{
+    do_strtosz_full(str, qemu_strtosz, exp_ret, exp_val, exp_offset,
+                    exp_ret, exp_val);
+}
+
+static void do_strtosz_MiB(const char *str, int exp_ret, uint64_t exp_val,
+                           size_t exp_offset)
+{
+    do_strtosz_full(str, qemu_strtosz_MiB, exp_ret, exp_val, exp_offset,
+                    exp_ret, exp_val);
+}
+
+static void do_strtosz_metric(const char *str, int exp_ret, uint64_t exp_val,
+                              size_t exp_offset)
+{
+    do_strtosz_full(str, qemu_strtosz_metric, exp_ret, exp_val, exp_offset,
+                    exp_ret, exp_val);
+}
+
 static void test_qemu_strtosz_simple(void)
 {
-    const char *str;
-    const char *endptr;
-    int err;
-    uint64_t res;
-
-    str = "0";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 0);
-    g_assert_true(endptr == str + 1);
+    do_strtosz("0", 0, 0, 1);

     /* Leading 0 gives decimal results, not octal */
-    str = "08";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 8);
-    g_assert_true(endptr == str + 2);
+    do_strtosz("08", 0, 8, 2);

     /* Leading space is ignored */
-    str = " 12345";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 12345);
-    g_assert_true(endptr == str + 6);
+    do_strtosz(" 12345", 0, 12345, 6);

-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 12345);
+    /* 2^53-1 */
+    do_strtosz("9007199254740991", 0, 0x1fffffffffffffULL, 16);

-    str = "9007199254740991"; /* 2^53-1 */
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmphex(res, ==, 0x1fffffffffffffULL);
-    g_assert_true(endptr == str + 16);
+    /* 2^53 */
+    do_strtosz("9007199254740992", 0, 0x20000000000000ULL, 16);

-    str = "9007199254740992"; /* 2^53 */
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmphex(res, ==, 0x20000000000000ULL);
-    g_assert_true(endptr == str + 16);
+    /* 2^53+1 */
+    do_strtosz("9007199254740993", 0, 0x20000000000001ULL, 16);

-    str = "9007199254740993"; /* 2^53+1 */
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmphex(res, ==, 0x20000000000001ULL);
-    g_assert_true(endptr == str + 16);
+    /* 0xfffffffffffff800 (53 msbs set) */
+    do_strtosz("18446744073709549568", 0, 0xfffffffffffff800ULL, 20);

-    str = "18446744073709549568"; /* 0xfffffffffffff800 (53 msbs set) */
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmphex(res, ==, 0xfffffffffffff800ULL);
-    g_assert_true(endptr == str + 20);
+    /* 0xfffffffffffffbff */
+    do_strtosz("18446744073709550591", 0, 0xfffffffffffffbffULL, 20);

-    str = "18446744073709550591"; /* 0xfffffffffffffbff */
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmphex(res, ==, 0xfffffffffffffbffULL);
-    g_assert_true(endptr == str + 20);
-
-    str = "18446744073709551615"; /* 0xffffffffffffffff */
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmphex(res, ==, 0xffffffffffffffffULL);
-    g_assert_true(endptr == str + 20);
+    /* 0xffffffffffffffff */
+    do_strtosz("18446744073709551615", 0, 0xffffffffffffffffULL, 20);
 }

 static void test_qemu_strtosz_hex(void)
 {
-    const char *str;
-    const char *endptr;
-    int err;
-    uint64_t res;
+    do_strtosz("0x0", 0, 0, 3);

-    str = "0x0";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 0);
-    g_assert_true(endptr == str + 3);
+    do_strtosz("0xab", 0, 171, 4);

-    str = "0xab";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 171);
-    g_assert_true(endptr == str + 4);
-
-    str = "0xae";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 174);
-    g_assert_true(endptr == str + 4);
+    do_strtosz("0xae", 0, 174, 4);
 }

 static void test_qemu_strtosz_units(void)
 {
-    const char *none = "1";
-    const char *b = "1B";
-    const char *k = "1K";
-    const char *m = "1M";
-    const char *g = "1G";
-    const char *t = "1T";
-    const char *p = "1P";
-    const char *e = "1E";
-    int err;
-    const char *endptr;
-    uint64_t res;
-
     /* default is M */
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz_MiB(none, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, MiB);
-    g_assert_true(endptr == none + 1);
+    do_strtosz_MiB("1", 0, MiB, 1);

-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(b, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 1);
-    g_assert_true(endptr == b + 2);
+    do_strtosz("1B", 0, 1, 2);

-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(k, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, KiB);
-    g_assert_true(endptr == k + 2);
-
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(m, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, MiB);
-    g_assert_true(endptr == m + 2);
-
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(g, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, GiB);
-    g_assert_true(endptr == g + 2);
-
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(t, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, TiB);
-    g_assert_true(endptr == t + 2);
-
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(p, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, PiB);
-    g_assert_true(endptr == p + 2);
-
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(e, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, EiB);
-    g_assert_true(endptr == e + 2);
+    do_strtosz("1K", 0, KiB, 2);
+    do_strtosz("1M", 0, MiB, 2);
+    do_strtosz("1G", 0, GiB, 2);
+    do_strtosz("1T", 0, TiB, 2);
+    do_strtosz("1P", 0, PiB, 2);
+    do_strtosz("1E", 0, EiB, 2);
 }

 static void test_qemu_strtosz_float(void)
 {
-    const char *str;
-    int err;
-    const char *endptr;
-    uint64_t res;
-
-    str = "0.5E";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, EiB / 2);
-    g_assert_true(endptr == str + 4);
+    do_strtosz("0.5E", 0, EiB / 2, 4);

     /* For convenience, a fraction of 0 is tolerated even on bytes */
-    str = "1.0B";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 1);
-    g_assert_true(endptr == str + 4);
+    do_strtosz("1.0B", 0, 1, 4);

     /* An empty fraction is tolerated */
-    str = "1.k";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 1024);
-    g_assert_true(endptr == str + 3);
+    do_strtosz("1.k", 0, 1024, 3);

     /* For convenience, we permit values that are not byte-exact */
-    str = "12.345M";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, (uint64_t) (12.345 * MiB + 0.5));
-    g_assert_true(endptr == str + 7);
+    do_strtosz("12.345M", 0, (uint64_t) (12.345 * MiB + 0.5), 7);
 }

 static void test_qemu_strtosz_invalid(void)
 {
-    const char *str;
-    const char *endptr;
-    int err;
-    uint64_t res = 0xbaadf00d;
-
-    str = "";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
-    str = " \t ";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
-    str = "crap";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
-    str = "inf";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
-    str = "NaN";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
+    do_strtosz("", -EINVAL, 0xbaadf00d, 0);
+    do_strtosz(" \t ", -EINVAL, 0xbaadf00d, 0);
+    do_strtosz("crap", -EINVAL, 0xbaadf00d, 0);
+    do_strtosz("inf", -EINVAL, 0xbaadf00d, 0);
+    do_strtosz("NaN", -EINVAL, 0xbaadf00d, 0);

     /* Fractional values require scale larger than bytes */
-    str = "1.1B";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
-    str = "1.1";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
+    do_strtosz("1.1B", -EINVAL, 0xbaadf00d, 0);
+    do_strtosz("1.1", -EINVAL, 0xbaadf00d, 0);

     /* No hex fractions */
-    str = "0x1.8k";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
+    do_strtosz("0x1.8k", -EINVAL, 0xbaadf00d, 0);

     /* No suffixes */
-    str = "0x18M";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
+    do_strtosz("0x18M", -EINVAL, 0xbaadf00d, 0);

     /* No negative values */
-    str = "-0";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
-
-    str = "-1";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str);
+    do_strtosz("-0", -EINVAL, 0xbaadf00d, 0);
+    do_strtosz("-1", -EINVAL, 0xbaadf00d, 0);
 }

 static void test_qemu_strtosz_trailing(void)
 {
-    const char *str;
-    const char *endptr;
-    int err;
-    uint64_t res;
+    do_strtosz_full("123xxx", qemu_strtosz_MiB, 0, 123 * MiB, 3,
+                    -EINVAL, 0xbaadf00d);

-    str = "123xxx";
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz_MiB(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 123 * MiB);
-    g_assert_true(endptr == str + 3);
-
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-
-    str = "1kiB";
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 1024);
-    g_assert_true(endptr == str + 2);
-
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-
-    str = "0x";
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 0);
-    g_assert_true(endptr == str + 1);
-
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-
-    str = "0.NaN";
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 0);
-    g_assert_true(endptr == str + 2);
-
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-
-    str = "123-45";
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 123);
-    g_assert_true(endptr == str + 3);
-
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
+    do_strtosz_full("1kiB", qemu_strtosz, 0, 1024, 2, -EINVAL, 0xbaadf00d);
+    do_strtosz_full("0x", qemu_strtosz, 0, 0, 1, -EINVAL, 0xbaadf00d);
+    do_strtosz_full("0.NaN", qemu_strtosz, 0, 0, 2, -EINVAL, 0xbaadf00d);
+    do_strtosz_full("123-45", qemu_strtosz, 0, 123, 3, -EINVAL, 0xbaadf00d);

     /* FIXME should stop parse after 'e'. No floating point exponents */
-    str = "1.5e1k";
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL /* FIXME 0 */);
-    g_assert_cmphex(res, ==, 0xbaadf00d /* FIXME EiB * 1.5 */);
-    g_assert_true(endptr == str /* FIXME + 4 */);
+    do_strtosz_full("1.5e1k", qemu_strtosz, -EINVAL /* FIXME 0 */,
+                    0xbaadf00d /* FIXME EiB * 1.5 */, 0 /* FIXME 4 */,
+                    -EINVAL, 0xbaadf00d);

-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 0xbaadf00d);
-
-    str = "1.5E+0k";
-    endptr = NULL;
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -EINVAL /* FIXME 0 */);
-    g_assert_cmphex(res, ==, 0xbaadf00d /* FIXME EiB * 1.5 */);
-    g_assert_true(endptr == str /* FIXME + 4 */);
-
-    res = 0xbaadf00d;
-    err = qemu_strtosz(str, NULL, &res);
-    g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
+    do_strtosz_full("1.5E+0k", qemu_strtosz, -EINVAL /* FIXME 0 */,
+                    0xbaadf00d /* FIXME EiB * 1.5 */, 0 /* FIXME 4 */,
+                    -EINVAL, 0xbaadf00d);
 }

 static void test_qemu_strtosz_erange(void)
 {
-    const char *str;
-    const char *endptr;
-    int err;
-    uint64_t res = 0xbaadf00d;
+    /* 2^64; see strtosz_simple for 2^64-1 */
+    do_strtosz("18446744073709551616", -ERANGE, 0xbaadf00d, 20);

-    str = "18446744073709551616"; /* 2^64; see strtosz_simple for 2^64-1 */
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str + 20);
-
-    str = "20E";
-    endptr = NULL;
-    err = qemu_strtosz(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmphex(res, ==, 0xbaadf00d);
-    g_assert_true(endptr == str + 3);
+    do_strtosz("20E", -ERANGE, 0xbaadf00d, 3);
 }

 static void test_qemu_strtosz_metric(void)
 {
-    const char *str;
-    int err;
-    const char *endptr;
-    uint64_t res;
-
-    str = "12345k";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz_metric(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 12345000);
-    g_assert_true(endptr == str + 6);
-
-    str = "12.345M";
-    endptr = str;
-    res = 0xbaadf00d;
-    err = qemu_strtosz_metric(str, &endptr, &res);
-    g_assert_cmpint(err, ==, 0);
-    g_assert_cmpuint(res, ==, 12345000);
-    g_assert_true(endptr == str + 7);
+    do_strtosz_metric("12345k", 0, 12345000, 6);
+    do_strtosz_metric("12.345M", 0, 12345000, 7);
 }

 static void test_freq_to_str(void)
-- 
2.40.1


