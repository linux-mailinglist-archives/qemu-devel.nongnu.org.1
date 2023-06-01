Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789971F584
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:04:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOb-00088l-N9; Thu, 01 Jun 2023 18:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOE-000811-Vi
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO7-00040S-0F
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiXkXER8uesPX1hAnl9UtsUSmcZNtf/rlQzv7UVzhsQ=;
 b=H7/snjCfM7uMaRzVl3rP08UXi7QJSLPT3wuh1ycnthaMGoaRxfVjd8WG8fEVfWqEWD7LXO
 wM2qJdVag62bzDPF/3M+xBdPGjnDbrikpHZkp+CFMmkfK2ZvMIVgGGV8VkQMMyMzwvgaBa
 eCX+3BfBXrTXnTXff1tA7jP1w1rwEmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-94AmhW3INyW-2iTYjc-qpw-1; Thu, 01 Jun 2023 18:03:16 -0400
X-MC-Unique: 94AmhW3INyW-2iTYjc-qpw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92BCC101AA42
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 22:03:16 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 513E0492B0A;
 Thu,  1 Jun 2023 22:03:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 11/21] test-cutils: Add coverage of qemu_strtod
Date: Thu,  1 Jun 2023 17:02:55 -0500
Message-Id: <20230601220305.2130121-12-eblake@redhat.com>
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

It's hard to tweak code for consistency if I can't prove what will or
won't break from those tweaks.  Time to add unit tests for
qemu_strtod() and qemu_strtod_finite().

Among other things, I wrote a check whether we have C99 semantics for
strtod("0x1") (which MUST parse hex numbers) rather than C89 (which
must stop parsing at 'x').  These days, I suspect that is okay; but if
it fails CI checks, knowing the difference will help us decide what we
want to do about it.  Note that C2x, while not final at the time of
this patch, has been considering whether to make strtol("0b1") parse
as 1 with no slop instead of the C17 parse of 0 with slop "b1"; that
decision may also bleed over to strtod().  But for now, I didn't think
it worth adding unit tests on that front (to strtol or strtod) as
things may still change.

Likewise, there are plenty more corner cases of strtod proper that I
don't explicitly test here, but there are enough unit tests added here
that it covers all the branches reached in our wrappers.  In
particular, it demonstrates the difference on when *value is left
uninitialized, which an upcoming patch will normalize.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230522190441.64278-10-eblake@redhat.com>
---
 tests/unit/test-cutils.c | 512 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 512 insertions(+)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 20ab0ecb673..e05572cd92c 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -25,6 +25,8 @@
  * THE SOFTWARE.
  */

+#include <math.h>
+
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/units.h"
@@ -2789,6 +2791,487 @@ static void test_qemu_strtou64_full_erange_junk(void)
     g_assert_cmpuint(res, ==, UINT64_MAX);
 }

+static void test_qemu_strtod_simple(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* no radix or exponent */
+    str = "1";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 1.0);
+    g_assert_true(endptr == str + 1);
+
+    /* leading space and sign */
+    str = " -0.0";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, -0.0);
+    g_assert_true(signbit(res));
+    g_assert_true(endptr == str + 5);
+
+    /* fraction only */
+    str = "+.5";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 0.5);
+    g_assert_true(endptr == str + 3);
+
+    /* exponent */
+    str = "1.e+1";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 10.0);
+    g_assert_true(endptr == str + 5);
+
+    /* hex without radix */
+    str = "0x10";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 16.0);
+    g_assert_true(endptr == str + 4);
+}
+
+static void test_qemu_strtod_einval(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* empty */
+    str = "";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
+    g_assert_true(endptr == str);
+
+    /* NULL */
+    str = NULL;
+    endptr = "random";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_null(endptr);
+
+    /* not recognizable */
+    str = " junk";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
+    g_assert_true(endptr == str);
+}
+
+static void test_qemu_strtod_erange(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* overflow */
+    str = "9e999";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, ==, HUGE_VAL);
+    g_assert_true(endptr == str + 5);
+
+    str = "-9e+999";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, ==, -HUGE_VAL);
+    g_assert_true(endptr == str + 7);
+
+    /* underflow */
+    str = "-9e-999";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, >=, -DBL_MIN);
+    g_assert_cmpfloat(res, <=, -0.0);
+    g_assert_true(signbit(res));
+    g_assert_true(endptr == str + 7);
+}
+
+static void test_qemu_strtod_nonfinite(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* infinity */
+    str = "inf";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_true(isinf(res));
+    g_assert_false(signbit(res));
+    g_assert_true(endptr == str + 3);
+
+    str = "-infinity";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_true(isinf(res));
+    g_assert_true(signbit(res));
+    g_assert_true(endptr == str + 9);
+
+    /* not a number */
+    str = " NaN";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_true(isnan(res));
+    g_assert_true(endptr == str + 4);
+}
+
+static void test_qemu_strtod_trailing(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* trailing whitespace */
+    str = "1. ";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 1.0);
+    g_assert_true(endptr == str + 2);
+
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 1.0);
+
+    /* trailing e is not an exponent */
+    str = ".5e";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 0.5);
+    g_assert_true(endptr == str + 2);
+
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 0.5);
+
+    /* trailing ( not part of long NaN */
+    str = "nan(";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_true(isnan(res));
+    g_assert_true(endptr == str + 3);
+
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_true(isnan(res));
+}
+
+static void test_qemu_strtod_erange_junk(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* ERANGE with trailing junk... */
+    str = "1e-999junk";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, <=, DBL_MIN);
+    g_assert_cmpfloat(res, >=, 0.0);
+    g_assert_false(signbit(res));
+    g_assert_true(endptr == str + 6);
+
+    /* ...has less priority than EINVAL when full parse not possible */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 0.0);
+    g_assert_false(signbit(res));
+}
+
+static void test_qemu_strtod_finite_simple(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* no radix or exponent */
+    str = "1";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 1.0);
+    g_assert_true(endptr == str + 1);
+
+    /* leading space and sign */
+    str = " -0.0";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, -0.0);
+    g_assert_true(signbit(res));
+    g_assert_true(endptr == str + 5);
+
+    /* fraction only */
+    str = "+.5";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 0.5);
+    g_assert_true(endptr == str + 3);
+
+    /* exponent */
+    str = "1.e+1";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 10.0);
+    g_assert_true(endptr == str + 5);
+
+    /* hex without radix */
+    str = "0x10";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 16.0);
+    g_assert_true(endptr == str + 4);
+}
+
+static void test_qemu_strtod_finite_einval(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* empty */
+    str = "";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_true(endptr == str);
+
+    /* NULL */
+    str = NULL;
+    endptr = "random";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_null(endptr);
+
+    /* not recognizable */
+    str = " junk";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_true(endptr == str);
+}
+
+static void test_qemu_strtod_finite_erange(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* overflow */
+    str = "9e999";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, ==, HUGE_VAL);
+    g_assert_true(endptr == str + 5);
+
+    str = "-9e+999";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, ==, -HUGE_VAL);
+    g_assert_true(endptr == str + 7);
+
+    /* underflow */
+    str = "-9e-999";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, >=, -DBL_MIN);
+    g_assert_cmpfloat(res, <=, -0.0);
+    g_assert_true(signbit(res));
+    g_assert_true(endptr == str + 7);
+}
+
+static void test_qemu_strtod_finite_nonfinite(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* infinity */
+    str = "inf";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_true(endptr == str);
+
+    str = "-infinity";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_true(endptr == str);
+
+    /* not a number */
+    str = " NaN";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_true(endptr == str);
+}
+
+static void test_qemu_strtod_finite_trailing(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* trailing whitespace */
+    str = "1. ";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 1.0);
+    g_assert_true(endptr == str + 2);
+
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+
+    /* trailing e is not an exponent */
+    str = ".5e";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, 0);
+    g_assert_cmpfloat(res, ==, 0.5);
+    g_assert_true(endptr == str + 2);
+
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+
+    /* trailing ( not part of long NaN */
+    str = "nan(";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+    g_assert_true(endptr == str);
+
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+}
+
+static void test_qemu_strtod_finite_erange_junk(void)
+{
+    const char *str;
+    const char *endptr;
+    int err;
+    double res;
+
+    /* ERANGE with trailing junk... */
+    str = "1e-999junk";
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, &endptr, &res);
+    g_assert_cmpint(err, ==, -ERANGE);
+    g_assert_cmpfloat(res, <=, DBL_MIN);
+    g_assert_cmpfloat(res, >=, 0.0);
+    g_assert_false(signbit(res));
+    g_assert_true(endptr == str + 6);
+
+    /* ...has less priority than EINVAL when full parse not possible */
+    endptr = "somewhere";
+    res = 999;
+    err = qemu_strtod_finite(str, NULL, &res);
+    g_assert_cmpint(err, ==, -EINVAL);
+    g_assert_cmpfloat(res, ==, 999.0);
+}
+
 static void test_qemu_strtosz_simple(void)
 {
     const char *str;
@@ -3631,6 +4114,35 @@ int main(int argc, char **argv)
     g_test_add_func("/cutils/qemu_strtou64_full/erange_junk",
                     test_qemu_strtou64_full_erange_junk);

+    /* qemu_strtod() tests */
+    g_test_add_func("/cutils/qemu_strtod/simple",
+                    test_qemu_strtod_simple);
+    g_test_add_func("/cutils/qemu_strtod/einval",
+                    test_qemu_strtod_einval);
+    g_test_add_func("/cutils/qemu_strtod/erange",
+                    test_qemu_strtod_erange);
+    g_test_add_func("/cutils/qemu_strtod/nonfinite",
+                    test_qemu_strtod_nonfinite);
+    g_test_add_func("/cutils/qemu_strtod/trailing",
+                    test_qemu_strtod_trailing);
+    g_test_add_func("/cutils/qemu_strtod/erange_junk",
+                    test_qemu_strtod_erange_junk);
+
+    /* qemu_strtod_finite() tests */
+    g_test_add_func("/cutils/qemu_strtod_finite/simple",
+                    test_qemu_strtod_finite_simple);
+    g_test_add_func("/cutils/qemu_strtod_finite/einval",
+                    test_qemu_strtod_finite_einval);
+    g_test_add_func("/cutils/qemu_strtod_finite/erange",
+                    test_qemu_strtod_finite_erange);
+    g_test_add_func("/cutils/qemu_strtod_finite/nonfinite",
+                    test_qemu_strtod_finite_nonfinite);
+    g_test_add_func("/cutils/qemu_strtod_finite/trailing",
+                    test_qemu_strtod_finite_trailing);
+    g_test_add_func("/cutils/qemu_strtod_finite/erange_junk",
+                    test_qemu_strtod_finite_erange_junk);
+
+    /* qemu_strtosz() tests */
     g_test_add_func("/cutils/strtosz/simple",
                     test_qemu_strtosz_simple);
     g_test_add_func("/cutils/strtosz/hex",
-- 
2.40.1


