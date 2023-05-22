Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC1F70C5CB
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1AqX-0003hy-6p; Mon, 22 May 2023 15:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1AqA-0003de-QZ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq1-0003cf-8O
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nw56tjh133TeS93P96g5fiK8/TnmjSH7QruH8wScb6A=;
 b=I5DBgQYOVdD28PLX0/hDE7913q2rKUnH/eHcG0lOiazwojnN3FdqSioGsezc0lj2ZBx31O
 /ffd2GIA1cvM4sM5qyJWzntkpa8EN+1Rv+GOYE4N/W0BlXN7MydGR57a9CD2Lz70pfkCHi
 7kD0zgDAlXYYhfNe+gRyfnZCAK4O/sc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-I1sL9IFYNUyiRJ8AUBOx_g-1; Mon, 22 May 2023 15:04:54 -0400
X-MC-Unique: I1sL9IFYNUyiRJ8AUBOx_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 929ED1C03D90;
 Mon, 22 May 2023 19:04:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F0A8400DFF;
 Mon, 22 May 2023 19:04:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH v3 18/19] cutils: Improve qemu_strtod* error paths
Date: Mon, 22 May 2023 14:04:40 -0500
Message-Id: <20230522190441.64278-19-eblake@redhat.com>
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

Previous patches changed all integral qemu_strto*() error paths to
guarantee that *value is never left uninitialized.  Do likewise for
qemu_strtod.  Also, tighten qemu_strtod_finite() to never return a
non-finite value (prior to this patch, we were rejecting "inf" with
-EINVAL and unspecified result 0.0, but failing "9e999" with -ERANGE
and HUGE_VAL - which is infinite on IEEE machines - despite our
function claiming to recognize only finite values).

Auditing callers, we have no external callers of qemu_strtod, and
among the callers of qemu_strtod_finite:

- qapi/qobject-input-visitor.c:qobject_input_type_number_keyval() and
  qapi/string-input-visitor.c:parse_type_number() which reject all
  errors (does not matter what we store)

- utils/cutils.c:do_strtosz() incorrectly assumes that *endptr points
  to '.' on all failures (that is, it is not distinguishing between
  EINVAL and ERANGE; and therefore still does the WRONG THING for
  "9.9e999".  The change here does not entirely fix that (a later
  patch will tackle this more systematically), but at least it fixes
  the read-out-of-bounds first diagnosed in
  https://gitlab.com/qemu-project/qemu/-/issues/1629

- our testsuite, which we can update to match what we document

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
CC: qemu-stable@nongnu.org
---

v3: cc qemu-stable: given the low severity of issue 1629, and the
complexity of this series, I doubt this patch is worth backporting
either on its own or as part of the series; but including the stable
list will let others also weigh in on the question
---
 tests/unit/test-cutils.c | 63 +++++++++++++++++++++++-----------------
 util/cutils.c            | 32 +++++++++++---------
 2 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 8bdae856827..04381a1865d 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -2868,7 +2868,8 @@ static void test_qemu_strtod_einval(void)
     res = 999;
     err = qemu_strtod(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_null(endptr);

     /* not recognizable */
@@ -3101,7 +3102,8 @@ static void test_qemu_strtod_finite_einval(void)
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_true(endptr == str);

     /* NULL */
@@ -3110,7 +3112,8 @@ static void test_qemu_strtod_finite_einval(void)
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_null(endptr);

     /* not recognizable */
@@ -3119,7 +3122,8 @@ static void test_qemu_strtod_finite_einval(void)
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_true(endptr == str);
 }

@@ -3130,24 +3134,26 @@ static void test_qemu_strtod_finite_erange(void)
     int err;
     double res;

-    /* overflow */
+    /* overflow turns into EINVAL */
     str = "9e999";
     endptr = "somewhere";
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpfloat(res, ==, HUGE_VAL);
-    g_assert_true(endptr == str + 5);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
+    g_assert_true(endptr == str);

     str = "-9e+999";
     endptr = "somewhere";
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
-    g_assert_cmpint(err, ==, -ERANGE);
-    g_assert_cmpfloat(res, ==, -HUGE_VAL);
-    g_assert_true(endptr == str + 7);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
+    g_assert_true(endptr == str);

-    /* underflow */
+    /* underflow is still possible */
     str = "-9e-999";
     endptr = "somewhere";
     res = 999;
@@ -3172,7 +3178,8 @@ static void test_qemu_strtod_finite_nonfinite(void)
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_true(endptr == str);

     str = "-infinity";
@@ -3180,7 +3187,8 @@ static void test_qemu_strtod_finite_nonfinite(void)
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_true(endptr == str);

     /* not a number */
@@ -3189,7 +3197,8 @@ static void test_qemu_strtod_finite_nonfinite(void)
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_true(endptr == str);
 }

@@ -3213,7 +3222,8 @@ static void test_qemu_strtod_finite_trailing(void)
     res = 999;
     err = qemu_strtod_finite(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 1.0);
+    g_assert_false(signbit(res));

     /* trailing e is not an exponent */
     str = ".5e";
@@ -3228,7 +3238,7 @@ static void test_qemu_strtod_finite_trailing(void)
     res = 999;
     err = qemu_strtod_finite(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.5);

     /* trailing ( not part of long NaN */
     str = "nan(";
@@ -3236,14 +3246,16 @@ static void test_qemu_strtod_finite_trailing(void)
     res = 999;
     err = qemu_strtod_finite(str, &endptr, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
     g_assert_true(endptr == str);

     endptr = "somewhere";
     res = 999;
     err = qemu_strtod_finite(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
 }

 static void test_qemu_strtod_finite_erange_junk(void)
@@ -3269,7 +3281,8 @@ static void test_qemu_strtod_finite_erange_junk(void)
     res = 999;
     err = qemu_strtod_finite(str, NULL, &res);
     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
 }

 typedef int (*qemu_strtosz_fn)(const char *, const char **, uint64_t *);
@@ -3507,13 +3520,9 @@ static void test_qemu_strtosz_trailing(void)
                     0 /* FIXME EiB * 1.5 */, 0 /* FIXME 4 */,
                     -EINVAL, 0);

-    /*
-     * FIXME overflow in fraction is so buggy it can read beyond bounds
-     * if we don't stuff extra \0 in our literal
-     */
-    do_strtosz_full("1.5E999\0\0" /* FIXME 1.5E999" */, qemu_strtosz,
-                    0, 1 /* FIXME EiB * 1.5 */, 8 /* FIXME 4 */,
-                    0 /* FIXME -EINVAL */, 1 /* FIXME 0 */);
+    /* FIXME overflow in fraction is still buggy */
+    do_strtosz_full("1.5E999", qemu_strtosz, 0, 1 /* FIXME EiB * 1.5 */,
+                    2 /* FIXME 4 */, -EINVAL, 0);
 }

 static void test_qemu_strtosz_erange(void)
diff --git a/util/cutils.c b/util/cutils.c
index e3a49209a94..bde2da59bdd 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -660,12 +660,13 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,
  *
  * @nptr may be null, and no conversion is performed then.
  *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
+ * If no conversion is performed, store @nptr in *@endptr, +0.0 in
+ * @result, and return -EINVAL.
  *
  * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL. This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
+ * -EINVAL with @result set to the parsed value.  This is the case
+ * when the pointer that would be stored in a non-null @endptr points
+ * to a character other than '\0'.
  *
  * If the conversion overflows, store +/-HUGE_VAL in @result, depending
  * on the sign, and return -ERANGE.
@@ -680,6 +681,7 @@ int qemu_strtod(const char *nptr, const char **endptr, double *result)
     char *ep;

     if (!nptr) {
+        *result = 0.0;
         if (endptr) {
             *endptr = nptr;
         }
@@ -694,24 +696,28 @@ int qemu_strtod(const char *nptr, const char **endptr, double *result)
 /**
  * Convert string @nptr to a finite double.
  *
- * Works like qemu_strtod(), except that "NaN" and "inf" are rejected
- * with -EINVAL and no conversion is performed.
+ * Works like qemu_strtod(), except that "NaN", "inf", and strings
+ * that cause ERANGE overflow errors are rejected with -EINVAL as if
+ * no conversion is performed, storing 0.0 into @result regardless of
+ * any sign.  -ERANGE failures for underflow still preserve the parsed
+ * sign.
  */
 int qemu_strtod_finite(const char *nptr, const char **endptr, double *result)
 {
-    double tmp;
+    const char *tmp;
     int ret;

-    ret = qemu_strtod(nptr, endptr, &tmp);
-    if (!ret && !isfinite(tmp)) {
+    ret = qemu_strtod(nptr, &tmp, result);
+    if (!isfinite(*result)) {
         if (endptr) {
             *endptr = nptr;
         }
+        *result = 0.0;
+        ret = -EINVAL;
+    } else if (endptr) {
+        *endptr = tmp;
+    } else if (*tmp) {
         ret = -EINVAL;
-    }
-
-    if (ret != -EINVAL) {
-        *result = tmp;
     }
     return ret;
 }
-- 
2.40.1


