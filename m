Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6748770C5C7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:12:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Aqe-0003o5-CO; Mon, 22 May 2023 15:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq5-0003bm-UR
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Apz-0003by-Tl
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dc9eeU+FPa0e/vO/yRRtTZdLLU1H4h7osgJQWd5kc4k=;
 b=EZXVPe5B9U/1HwmfWR9jloAzcQ7ic5wQVjjpLc2dslzVoSPOkLqBSVkJlm07v4IRVPSjyY
 XsnNRZhRoK+dqrMxESSnFbc+XyOxlFUEb+rbPNzj68Q6m4PQHUGFGSQYF5BfQib87BtQp4
 fd3rhY22PHR+W8+qVZ8GsI+Xn7Q7Ddc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-1tMZPC4ONGuDcBmVqBwAfg-1; Mon, 22 May 2023 15:04:53 -0400
X-MC-Unique: 1tMZPC4ONGuDcBmVqBwAfg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A2A4101A52C;
 Mon, 22 May 2023 19:04:53 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06B18400DFF;
 Mon, 22 May 2023 19:04:52 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 16/19] cutils: Set value in all integral qemu_strto* error
 paths
Date: Mon, 22 May 2023 14:04:38 -0500
Message-Id: <20230522190441.64278-17-eblake@redhat.com>
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

Our goal in writing qemu_strtoi() and friends is to have an interface
harder to abuse than libc's strtol().  Leaving the return value
uninitialized on some but not all error paths does not lend itself
well to this goal; and our documentation wasn't helpful on what to
expect.

Note that the previous patch changed all qemu_strtosz() EINVAL error
paths to slam value to 0 rather than stay uninitialized, even when the
EINVAL eror occurs because of trailing junk.  But for the remaining
integral qemu_strto*, it's easier to return the parsed value than to
force things back to zero, in part because of how check_strtox_error
works; in part because people expect that from libc strto* (while
there is no libc strtosz to compare to), and in part because doing so
creates less churn in the testsuite.

Here, the list of affected callers is much longer ('git grep
"qemu_strto[ui]" "*.c" "**/*.c" | grep -v tests/ |wc -l' outputs 107,
although a few of those are the implementation in in cutils.c), so
touching as little as possible is the wisest course of action.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/unit/test-cutils.c | 24 +++++++++++------------
 util/cutils.c            | 42 +++++++++++++++++++++++++---------------
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index d174ce675a5..adc9878f93d 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -320,7 +320,7 @@ static void test_qemu_strtoi_null(void)
     err = qemu_strtoi(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 999);
+    g_assert_cmpint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -661,7 +661,7 @@ static void test_qemu_strtoi_full_null(void)
     err = qemu_strtoi(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 999);
+    g_assert_cmpint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -764,7 +764,7 @@ static void test_qemu_strtoui_null(void)
     err = qemu_strtoui(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpuint(res, ==, 999);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -1102,7 +1102,7 @@ static void test_qemu_strtoui_full_null(void)
     err = qemu_strtoui(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpuint(res, ==, 999);
+    g_assert_cmpuint(res, ==, 0);
 }

 static void test_qemu_strtoui_full_empty(void)
@@ -1202,7 +1202,7 @@ static void test_qemu_strtol_null(void)
     err = qemu_strtol(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 999);
+    g_assert_cmpint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -1516,7 +1516,7 @@ static void test_qemu_strtol_full_null(void)
     err = qemu_strtol(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 999);
+    g_assert_cmpint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -1619,7 +1619,7 @@ static void test_qemu_strtoul_null(void)
     err = qemu_strtoul(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpuint(res, ==, 999);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -1932,7 +1932,7 @@ static void test_qemu_strtoul_full_null(void)
     err = qemu_strtoul(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpuint(res, ==, 999);
+    g_assert_cmpuint(res, ==, 0);
 }

 static void test_qemu_strtoul_full_empty(void)
@@ -2032,7 +2032,7 @@ static void test_qemu_strtoi64_null(void)
     err = qemu_strtoi64(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 999);
+    g_assert_cmpint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -2322,7 +2322,7 @@ static void test_qemu_strtoi64_full_null(void)
     err = qemu_strtoi64(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpint(res, ==, 999);
+    g_assert_cmpint(res, ==, 0);
 }

 static void test_qemu_strtoi64_full_empty(void)
@@ -2425,7 +2425,7 @@ static void test_qemu_strtou64_null(void)
     err = qemu_strtou64(NULL, &endptr, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpuint(res, ==, 999);
+    g_assert_cmpuint(res, ==, 0);
     g_assert_null(endptr);
 }

@@ -2714,7 +2714,7 @@ static void test_qemu_strtou64_full_null(void)
     err = qemu_strtou64(NULL, NULL, 0, &res);

     g_assert_cmpint(err, ==, -EINVAL);
-    g_assert_cmpuint(res, ==, 999);
+    g_assert_cmpuint(res, ==, 0);
 }

 static void test_qemu_strtou64_full_empty(void)
diff --git a/util/cutils.c b/util/cutils.c
index c5530a5c2be..edfb71a2171 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -384,12 +384,13 @@ static int check_strtox_error(const char *nptr, char *ep,
  *
  * @nptr may be null, and no conversion is performed then.
  *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
+ * If no conversion is performed, store @nptr in *@endptr, 0 in
+ * @result, and return -EINVAL.
  *
  * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
+ * -EINVAL with @result set to the parsed value.  This is the case
+ * when the pointer that would be stored in a non-null @endptr points
+ * to a character other than '\0'.
  *
  * If the conversion overflows @result, store INT_MAX in @result,
  * and return -ERANGE.
@@ -410,6 +411,7 @@ int qemu_strtoi(const char *nptr, const char **endptr, int base,

     assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
+        *result = 0;
         if (endptr) {
             *endptr = nptr;
         }
@@ -439,12 +441,13 @@ int qemu_strtoi(const char *nptr, const char **endptr, int base,
  *
  * @nptr may be null, and no conversion is performed then.
  *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
+ * If no conversion is performed, store @nptr in *@endptr, 0 in
+ * @result, and return -EINVAL.
  *
  * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
+ * -EINVAL with @result set to the parsed value.  This is the case
+ * when the pointer that would be stored in a non-null @endptr points
+ * to a character other than '\0'.
  *
  * If the conversion overflows @result, store UINT_MAX in @result,
  * and return -ERANGE.
@@ -465,6 +468,7 @@ int qemu_strtoui(const char *nptr, const char **endptr, int base,

     assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
+        *result = 0;
         if (endptr) {
             *endptr = nptr;
         }
@@ -508,12 +512,13 @@ int qemu_strtoui(const char *nptr, const char **endptr, int base,
  *
  * @nptr may be null, and no conversion is performed then.
  *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
+ * If no conversion is performed, store @nptr in *@endptr, 0 in
+ * @result, and return -EINVAL.
  *
  * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
+ * -EINVAL with @result set to the parsed value.  This is the case
+ * when the pointer that would be stored in a non-null @endptr points
+ * to a character other than '\0'.
  *
  * If the conversion overflows @result, store LONG_MAX in @result,
  * and return -ERANGE.
@@ -530,6 +535,7 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,

     assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
+        *result = 0;
         if (endptr) {
             *endptr = nptr;
         }
@@ -550,12 +556,13 @@ int qemu_strtol(const char *nptr, const char **endptr, int base,
  *
  * @nptr may be null, and no conversion is performed then.
  *
- * If no conversion is performed, store @nptr in *@endptr and return
- * -EINVAL.
+ * If no conversion is performed, store @nptr in *@endptr, 0 in
+ * @result, and return -EINVAL.
  *
  * If @endptr is null, and the string isn't fully converted, return
- * -EINVAL.  This is the case when the pointer that would be stored in
- * a non-null @endptr points to a character other than '\0'.
+ * -EINVAL with @result set to the parsed value.  This is the case
+ * when the pointer that would be stored in a non-null @endptr points
+ * to a character other than '\0'.
  *
  * If the conversion overflows @result, store ULONG_MAX in @result,
  * and return -ERANGE.
@@ -573,6 +580,7 @@ int qemu_strtoul(const char *nptr, const char **endptr, int base,

     assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
+        *result = 0;
         if (endptr) {
             *endptr = nptr;
         }
@@ -601,6 +609,7 @@ int qemu_strtoi64(const char *nptr, const char **endptr, int base,

     assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
+        *result = 0;
         if (endptr) {
             *endptr = nptr;
         }
@@ -628,6 +637,7 @@ int qemu_strtou64(const char *nptr, const char **endptr, int base,

     assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
+        *result = 0;
         if (endptr) {
             *endptr = nptr;
         }
-- 
2.40.1


