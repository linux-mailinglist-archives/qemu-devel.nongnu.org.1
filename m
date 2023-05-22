Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D57B70C5BF
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:07:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ar4-0003xK-CM; Mon, 22 May 2023 15:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1AqO-0003gw-E9
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1AqH-0003rb-Gg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3z4HRdIoNZ2CEbq6afHzwS3bCfwkHX0Y7JvBcZe4JI=;
 b=WmXSdW++Y0QUHHpZ1Z+Ney97Wzw/BwRT9cUAzaJKEYI1VOvCUx1+ljpq1lil+2ATTAeSsn
 dQtNAenDA4QqRheulAOAwV8Y1QtS479CTbvfYIoOikoa5XEPCU3fG0eOqp7ma9X+Tq9jO4
 x+ZfZlLtKxUhG4CxunrmwtxK5Rw44NU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-kHlmbk_zOq6TcJKEF6RAkA-1; Mon, 22 May 2023 15:04:55 -0400
X-MC-Unique: kHlmbk_zOq6TcJKEF6RAkA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25F9E8007D9;
 Mon, 22 May 2023 19:04:55 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C66BE482060;
 Mon, 22 May 2023 19:04:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 19/19] cutils: Improve qemu_strtosz handling of fractions
Date: Mon, 22 May 2023 14:04:41 -0500
Message-Id: <20230522190441.64278-20-eblake@redhat.com>
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

We have several limitations and bugs worth fixing; they are
inter-related enough that it is not worth splitting this patch into
smaller pieces:

* ".5k" should work to specify 512, just as "0.5k" does
* "1.9999k" and "1." + "9"*50 + "k" should both produce the same
  result of 2048 after rounding
* "1." + "0"*350 + "1B" should not be treated the same as "1.0B";
  underflow in the fraction should not be lost
* "7.99e99" and "7.99e999" look similar, but our code was doing a
  read-out-of-bounds on the latter because it was not expecting ERANGE
  due to overflow. While we document that scientific notation is not
  supported, and the previous patch actually fixed
  qemu_strtod_finite() to no longer return ERANGE overflows, it is
  easier to pre-filter than to try and determine after the fact if
  strtod() consumed more than we wanted.  Note that this is a
  low-level semantic change (when endptr is not NULL, we can now
  successfully parse with a scale of 'E' and then report trailing
  junk, instead of failing outright with EINVAL); but an earlier
  commit already argued that this is not a high-level semantic change
  since the only caller passing in a non-NULL endptr also checks that
  the tail is whitespace-only.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1629
Fixes: cf923b78 ("utils: Improve qemu_strtosz() to have 64 bits of precision", 6.0.0)
Fixes: 7625a1ed ("utils: Use fixed-point arithmetic in qemu_strtosz", 6.0.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/unit/test-cutils.c | 50 +++++++++-------------
 util/cutils.c            | 89 ++++++++++++++++++++++++++++++----------
 2 files changed, 86 insertions(+), 53 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 04381a1865d..93f08a540fd 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3408,19 +3408,18 @@ static void test_qemu_strtosz_float(void)
     /* An empty fraction tail is tolerated */
     do_strtosz("1.k", 0, 1024, 3);

-    /* FIXME An empty fraction head should be tolerated */
-    do_strtosz(" .5k", -EINVAL /* FIXME 0 */, 0 /* FIXME 512 */,
-               0 /* FIXME 4 */);
+    /* An empty fraction head is tolerated */
+    do_strtosz(" .5k", 0, 512, 4);

     /* For convenience, we permit values that are not byte-exact */
     do_strtosz("12.345M", 0, (uint64_t) (12.345 * MiB + 0.5), 7);

-    /* FIXME Fraction tail should round correctly */
+    /* Fraction tail can round up */
     do_strtosz("1.9999k", 0, 2048, 7);
     do_strtosz("1.9999999999999999999999999999999999999999999999999999k", 0,
-               1024 /* FIXME 2048 */, 55);
+               2048, 55);

-    /* FIXME ERANGE underflow in the fraction tail should not matter for 'k' */
+    /* ERANGE underflow in the fraction tail does not matter for 'k' */
     do_strtosz("1."
                "00000000000000000000000000000000000000000000000000"
                "00000000000000000000000000000000000000000000000000"
@@ -3429,7 +3428,7 @@ static void test_qemu_strtosz_float(void)
                "00000000000000000000000000000000000000000000000000"
                "00000000000000000000000000000000000000000000000000"
                "00000000000000000000000000000000000000000000000000"
-               "1k", 0, 1 /* FIXME 1024 */, 354);
+               "1k", 0, 1024, 354);
 }

 static void test_qemu_strtosz_invalid(void)
@@ -3453,10 +3452,9 @@ static void test_qemu_strtosz_invalid(void)
     do_strtosz("1.1B", -EINVAL, 0, 0);
     do_strtosz("1.1", -EINVAL, 0, 0);

-    /* FIXME underflow in the fraction tail should matter for 'B' */
+    /* 'B' cannot have any nonzero fraction, even with rounding or underflow */
     do_strtosz("1.00001B", -EINVAL, 0, 0);
-    do_strtosz("1.00000000000000000001B", 0 /* FIXME -EINVAL */,
-               1 /* FIXME 0 */, 23 /* FIXME 0 */);
+    do_strtosz("1.00000000000000000001B", -EINVAL, 0, 0);
     do_strtosz("1."
                "00000000000000000000000000000000000000000000000000"
                "00000000000000000000000000000000000000000000000000"
@@ -3465,8 +3463,7 @@ static void test_qemu_strtosz_invalid(void)
                "00000000000000000000000000000000000000000000000000"
                "00000000000000000000000000000000000000000000000000"
                "00000000000000000000000000000000000000000000000000"
-               "1B", 0 /* FIXME -EINVAL */, 1 /* FIXME 0 */,
-               354 /* FIXME 0 */);
+               "1B", -EINVAL, 0, 0);

     /* No hex fractions */
     do_strtosz("0x1.8k", -EINVAL, 0, 0);
@@ -3512,28 +3509,20 @@ static void test_qemu_strtosz_trailing(void)
     do_strtosz_full("123-45", qemu_strtosz, 0, 123, 3, -EINVAL, 0);
     do_strtosz_full(" 123 - 45", qemu_strtosz, 0, 123, 4, -EINVAL, 0);

-    /* FIXME should stop parse after 'e'. No floating point exponents */
-    do_strtosz_full("1.5e1k", qemu_strtosz, -EINVAL /* FIXME 0 */,
-                    0 /* FIXME EiB * 1.5 */, 0 /* FIXME 4 */,
-                    -EINVAL, 0);
-    do_strtosz_full("1.5E+0k", qemu_strtosz, -EINVAL /* FIXME 0 */,
-                    0 /* FIXME EiB * 1.5 */, 0 /* FIXME 4 */,
-                    -EINVAL, 0);
-
-    /* FIXME overflow in fraction is still buggy */
-    do_strtosz_full("1.5E999", qemu_strtosz, 0, 1 /* FIXME EiB * 1.5 */,
-                    2 /* FIXME 4 */, -EINVAL, 0);
+    /* Parse stops at 'e', which is not a floating point exponent */
+    do_strtosz_full("1.5e1k", qemu_strtosz, 0, EiB * 1.5, 4, -EINVAL, 0);
+    do_strtosz_full("1.5E+0k", qemu_strtosz, 0, EiB * 1.5, 4, -EINVAL, 0);
+    do_strtosz_full("1.5E999", qemu_strtosz, 0, EiB * 1.5, 4, -EINVAL, 0);
 }

 static void test_qemu_strtosz_erange(void)
 {
-    /* FIXME negative values fit better as ERANGE */
+    /* no negative values */
     do_strtosz(" -0", -ERANGE, 0, 3);
     do_strtosz("-1", -ERANGE, 0, 2);
     do_strtosz_full("-2M", qemu_strtosz, -ERANGE, 0, 2, -EINVAL, 0);
-    do_strtosz(" -.0", -EINVAL /* FIXME -ERANGE */, 0, 0 /* FIXME 4 */);
-    do_strtosz_full("-.1k", qemu_strtosz, -EINVAL /* FIXME -ERANGE */, 0,
-                    0 /* FIXME 3 */, -EINVAL, 0);
+    do_strtosz(" -.0", -ERANGE, 0, 4);
+    do_strtosz_full("-.1k", qemu_strtosz, -ERANGE, 0, 3, -EINVAL, 0);
     do_strtosz_full(" -."
                     "00000000000000000000000000000000000000000000000000"
                     "00000000000000000000000000000000000000000000000000"
@@ -3542,17 +3531,16 @@ static void test_qemu_strtosz_erange(void)
                     "00000000000000000000000000000000000000000000000000"
                     "00000000000000000000000000000000000000000000000000"
                     "00000000000000000000000000000000000000000000000000"
-                    "1M", qemu_strtosz, -EINVAL /* FIXME -ERANGE */, 0,
-                    0 /* FIXME 354 */, -EINVAL, 0);
+                    "1M", qemu_strtosz, -ERANGE, 0, 354, -EINVAL, 0);

     /* 2^64; see strtosz_simple for 2^64-1 */
     do_strtosz("18446744073709551616", -ERANGE, 0, 20);

     do_strtosz("20E", -ERANGE, 0, 3);

-    /* FIXME Fraction tail can cause ERANGE overflow */
+    /* Fraction tail can cause ERANGE overflow */
     do_strtosz("15.9999999999999999999999999999999999999999999999999999E",
-               0 /* FIXME -ERANGE */, 15ULL * EiB /* FIXME 0 */, 56);
+               -ERANGE, 0, 56);

     /* EINVAL has priority over ERANGE */
     do_strtosz_full("100000Pjunk", qemu_strtosz, -ERANGE, 0, 7, -EINVAL, 0);
diff --git a/util/cutils.c b/util/cutils.c
index bde2da59bdd..7470e049e20 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -194,15 +194,18 @@ static int64_t suffix_mul(char suffix, int64_t unit)
  * - 12345 - decimal, scale determined by @default_suffix and @unit
  * - 12345{bBkKmMgGtTpPeE} - decimal, scale determined by suffix and @unit
  * - 12345.678{kKmMgGtTpPeE} - decimal, scale determined by suffix, and
- *   fractional portion is truncated to byte
+ *   fractional portion is truncated to byte, either side of . may be empty
  * - 0x7fEE - hexadecimal, unit determined by @default_suffix
  *
  * The following are intentionally not supported
- * - hex with scaling suffix, such as 0x20M
- * - octal, such as 08
- * - fractional hex, such as 0x1.8
- * - negative values, including -0
- * - floating point exponents, such as 1e3
+ * - hex with scaling suffix, such as 0x20M (0x1b is 27, not 1)
+ * - octal, such as 08 (parsed as decimal instead)
+ * - binary, such as 0b1000 (parsed as 0b with trailing garbage "1000")
+ * - fractional hex, such as 0x1.8 (parsed as 0 with trailing garbage "x1.8")
+ * - negative values, including -0 (fail with -ERANGE)
+ * - floating point exponents, such as 1e3 (parsed as 1e with trailing
+ *   garbage "3") or 0x1p3 (parsed as 1 with trailing garbage "p3")
+ * - non-finite values, such as inf or NaN (fail with -EINVAL)
  *
  * The end pointer will be returned in *end, if not NULL.  If there is
  * no fraction, the input can be decimal or hexadecimal; if there is a
@@ -221,17 +224,17 @@ static int do_strtosz(const char *nptr, const char **end,
                       uint64_t *result)
 {
     int retval;
-    const char *endptr, *f;
+    const char *endptr;
     unsigned char c;
-    uint64_t val, valf = 0;
+    uint64_t val = 0, valf = 0;
     int64_t mul;

     /* Parse integral portion as decimal. */
     retval = parse_uint(nptr, &endptr, 10, &val);
-    if (retval) {
+    if (retval == -ERANGE || !nptr) {
         goto out;
     }
-    if (val == 0 && (*endptr == 'x' || *endptr == 'X')) {
+    if (retval == 0 && val == 0 && (*endptr == 'x' || *endptr == 'X')) {
         /* Input looks like hex; reparse, and insist on no fraction or suffix. */
         retval = qemu_strtou64(nptr, &endptr, 16, &val);
         if (retval) {
@@ -242,27 +245,69 @@ static int do_strtosz(const char *nptr, const char **end,
             retval = -EINVAL;
             goto out;
         }
-    } else if (*endptr == '.') {
+    } else if (*endptr == '.' || (endptr == nptr && strchr(nptr, '.'))) {
         /*
          * Input looks like a fraction.  Make sure even 1.k works
-         * without fractional digits.  If we see an exponent, treat
-         * the entire input as invalid instead.
+         * without fractional digits.  strtod tries to treat 'e' as an
+         * exponent, but we want to treat it as a scaling suffix;
+         * doing this requires modifying a copy of the fraction.
          */
-        double fraction;
+        double fraction = 0.0;

-        f = endptr;
-        retval = qemu_strtod_finite(f, &endptr, &fraction);
-        if (retval) {
+        if (retval == 0 && *endptr == '.' && !isdigit(endptr[1])) {
+            /* If we got here, we parsed at least one digit already. */
             endptr++;
-        } else if (memchr(f, 'e', endptr - f) || memchr(f, 'E', endptr - f)) {
-            endptr = nptr;
-            retval = -EINVAL;
-            goto out;
         } else {
-            /* Extract into a 64-bit fixed-point fraction. */
+            char *e;
+            const char *tail;
+            g_autofree char *copy = g_strdup(endptr);
+
+            e = strchr(copy, 'e');
+            if (e) {
+                *e = '\0';
+            }
+            e = strchr(copy, 'E');
+            if (e) {
+                *e = '\0';
+            }
+            /*
+             * If this is a floating point, we are guaranteed that '.'
+             * appears before any possible digits in copy.  If it is
+             * not a floating point, strtod will fail.  Either way,
+             * there is now no exponent in copy, so if it parses, we
+             * know 0.0 <= abs(result) <= 1.0 (after rounding), and
+             * ERANGE is only possible on underflow which is okay.
+             */
+            retval = qemu_strtod_finite(copy, &tail, &fraction);
+            endptr += tail - copy;
+            if (signbit(fraction)) {
+                retval = -ERANGE;
+                goto out;
+            }
+        }
+
+        /* Extract into a 64-bit fixed-point fraction. */
+        if (fraction == 1.0) {
+            if (val == UINT64_MAX) {
+                retval = -ERANGE;
+                goto out;
+            }
+            val++;
+        } else if (retval == -ERANGE) {
+            /* See comments above about underflow */
+            valf = 1;
+            retval = 0;
+        } else {
+            /* We want non-zero valf for any non-zero fraction */
             valf = (uint64_t)(fraction * 0x1p64);
+            if (valf == 0 && fraction > 0.0) {
+                valf = 1;
+            }
         }
     }
+    if (retval) {
+        goto out;
+    }
     c = *endptr;
     mul = suffix_mul(c, unit);
     if (mul > 0) {
-- 
2.40.1


