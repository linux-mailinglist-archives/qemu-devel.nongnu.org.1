Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAFD71F587
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOa-00088R-U5; Thu, 01 Jun 2023 18:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOC-00080S-F7
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO4-0003zq-CR
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xo4cdGe56xOEkNTtvItoYp42II7lEn0WKg3twFmUOF8=;
 b=NhkRNUj3XYGX6zUNwDGDFMF+h0gcJIzmhpIbqaMAsxvmONVp6R5zyuWLUaHClTzplbzt+C
 lG/Q4WaImk3SSwPBJtLbmIN2GxhxGRoNMZOCHCvMDXrTOIPWaXjDJ836f7nnvCfKfrYZRa
 L1BqL7taMVT+SEEBPsci2DpMHhhqhOs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-XlIUMsebOE2toA18NF7xGA-1; Thu, 01 Jun 2023 18:03:14 -0400
X-MC-Unique: XlIUMsebOE2toA18NF7xGA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5FBE800888;
 Thu,  1 Jun 2023 22:03:13 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85657492B0A;
 Thu,  1 Jun 2023 22:03:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 07/21] cutils: Fix wraparound parsing in qemu_strtoui
Date: Thu,  1 Jun 2023 17:02:51 -0500
Message-Id: <20230601220305.2130121-8-eblake@redhat.com>
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

While we were matching 32-bit strtol in qemu_strtoi, our use of a
64-bit parse was leaking through for some inaccurate answers in
qemu_strtoui in comparison to a 32-bit strtoul (see the unit test for
examples).  The comment for that function even described what we have
to do for a correct parse, but didn't implement it correctly: since
strtoull checks for overflow against the wrong values and then
negates, we have to temporarily undo negation before checking for
overflow against our desired value.

Our int wrappers would be a lot easier to write if libc had a
guaranteed 32-bit parser even on platforms with 64-bit long.

Whether we parse C2x binary strings like "0b1000" is currently up to
what libc does; our unit tests intentionally don't cover that at the
moment, though.

Fixes: 473a2a331e ("cutils: add qemu_strtoi & qemu_strtoui parsers for int/unsigned int types", v2.12.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
CC: qemu-stable@nongnu.org
Message-Id: <20230522190441.64278-6-eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 tests/unit/test-cutils.c | 20 +++++++++-----------
 util/cutils.c            | 25 +++++++++++++++++++------
 2 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 011123a2111..ce71900cb73 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -909,7 +909,7 @@ static void test_qemu_strtoui_hex(void)

 static void test_qemu_strtoui_wrap(void)
 {
-    /* FIXME - wraparound should be consistent with 32-bit strtoul */
+    /* wraparound is consistent with 32-bit strtoul */
     const char *str = "-4294967295"; /* 1 mod 2^32 */
     char f = 'X';
     const char *endptr = &f;
@@ -918,8 +918,8 @@ static void test_qemu_strtoui_wrap(void)

     err = qemu_strtoui(str, &endptr, 0, &res);

-    g_assert_cmpint(err, ==, -ERANGE /* FIXME 0 */);
-    g_assert_cmphex(res, ==, UINT_MAX /* FIXME 1 */);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmphex(res, ==, 1);
     g_assert_true(endptr == str + strlen(str));
 }

@@ -978,13 +978,12 @@ static void test_qemu_strtoui_overflow(void)
     g_assert_cmpuint(res, ==, UINT_MAX);
     g_assert_true(endptr == str + strlen(str));

-    /* FIXME - overflow should be consistent with 32-bit strtoul */
     str = "0xfffffffffffffffe"; /* ULLONG_MAX - 1 (not UINT_MAX - 1) */
     endptr = "somewhere";
     res = 999;
     err = qemu_strtoui(str, &endptr, 0, &res);
-    g_assert_cmpint(err, ==, 0 /* FIXME -ERANGE */);
-    g_assert_cmpuint(res, ==, UINT_MAX - 1 /* FIXME UINT_MAX */);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
     g_assert_true(endptr == str + strlen(str));

     str = "0x10000000000000000"; /* 65 bits, 32-bit sign bit clear */
@@ -1019,21 +1018,20 @@ static void test_qemu_strtoui_underflow(void)
     g_assert_cmpuint(res, ==, UINT_MAX);
     g_assert_true(endptr == str + strlen(str));

-    /* FIXME - overflow should be consistent with 32-bit strtoul */
     str = "-18446744073709551615"; /* -UINT64_MAX (not -(-1)) */
     endptr = "somewhere";
     res = 999;
     err = qemu_strtoui(str, &endptr, 0, &res);
-    g_assert_cmpint(err, ==, 0 /* FIXME -ERANGE */);
-    g_assert_cmpuint(res, ==, 1 /* FIXME UINT_MAX */);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
     g_assert_true(endptr == str + strlen(str));

     str = "-0xffffffff00000002";
     endptr = "somewhere";
     res = 999;
     err = qemu_strtoui(str, &endptr, 0, &res);
-    g_assert_cmpint(err, ==, 0 /* FIXME -ERANGE */);
-    g_assert_cmpuint(res, ==, UINT_MAX - 1 /* FIXME UINT_MAX */);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpuint(res, ==, UINT_MAX);
     g_assert_true(endptr == str + strlen(str));

     str = "-0x10000000000000000"; /* 65 bits, 32-bit sign bit clear */
diff --git a/util/cutils.c b/util/cutils.c
index 5887e744140..9b6ce9179c4 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -391,6 +391,9 @@ static int check_strtox_error(const char *nptr, char *ep,
  * and return -ERANGE.
  *
  * Else store the converted value in @result, and return zero.
+ *
+ * This matches the behavior of strtol() on 32-bit platforms, even on
+ * platforms where long is 64-bits.
  */
 int qemu_strtoi(const char *nptr, const char **endptr, int base,
                 int *result)
@@ -443,13 +446,15 @@ int qemu_strtoi(const char *nptr, const char **endptr, int base,
  *
  * Note that a number with a leading minus sign gets converted without
  * the minus sign, checked for overflow (see above), then negated (in
- * @result's type).  This is exactly how strtoul() works.
+ * @result's type).  This matches the behavior of strtoul() on 32-bit
+ * platforms, even on platforms where long is 64-bits.
  */
 int qemu_strtoui(const char *nptr, const char **endptr, int base,
                  unsigned int *result)
 {
     char *ep;
-    long long lresult;
+    unsigned long long lresult;
+    bool neg;

     assert((unsigned) base <= 36 && base != 1);
     if (!nptr) {
@@ -466,14 +471,22 @@ int qemu_strtoui(const char *nptr, const char **endptr, int base,
     if (errno == ERANGE) {
         *result = -1;
     } else {
+        /*
+         * Note that platforms with 32-bit strtoul only accept input
+         * in the range [-4294967295, 4294967295]; but we used 64-bit
+         * strtoull which wraps -18446744073709551615 to 1 instead of
+         * declaring overflow.  So we must check if '-' was parsed,
+         * and if so, undo the negation before doing our bounds check.
+         */
+        neg = memchr(nptr, '-', ep - nptr) != NULL;
+        if (neg) {
+            lresult = -lresult;
+        }
         if (lresult > UINT_MAX) {
             *result = UINT_MAX;
             errno = ERANGE;
-        } else if (lresult < INT_MIN) {
-            *result = UINT_MAX;
-            errno = ERANGE;
         } else {
-            *result = lresult;
+            *result = neg ? -lresult : lresult;
         }
     }
     return check_strtox_error(nptr, ep, endptr, lresult == 0, errno);
-- 
2.40.1


