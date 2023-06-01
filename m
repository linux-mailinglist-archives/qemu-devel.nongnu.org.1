Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A0071F596
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:07:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOe-0008B5-Ov; Thu, 01 Jun 2023 18:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOG-00081g-FC
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO8-000412-2E
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685656999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GyTl+Ld/Oi1vtUXKnleRiAn3DZZk9c0a1qdSLdUY6R8=;
 b=jTPhGhTawNV9x8AcO+a10xO6/74g3w9LfgZOPgmNfcAL9TTMecSQqHBc4DKIbO+81UdRZB
 x7v6PJAv7oe7rmf5XgjdyPb+2g3EHCLJidwgZ+Ardia2bo0+tNe2zXLs1OGOSFYvqWK0r4
 go1ltdX8PT5xpaC3YF4dvV548IoQzsw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-V2LBeceNM46R3_QJpAyTkg-1; Thu, 01 Jun 2023 18:03:18 -0400
X-MC-Unique: V2LBeceNM46R3_QJpAyTkg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07A3D8007D9;
 Thu,  1 Jun 2023 22:03:18 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA562492B0A;
 Thu,  1 Jun 2023 22:03:17 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 14/21] cutils: Allow NULL str in qemu_strtosz
Date: Thu,  1 Jun 2023 17:02:58 -0500
Message-Id: <20230601220305.2130121-15-eblake@redhat.com>
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com>
References: <20230601220305.2130121-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

All the other qemu_strto* and parse_uint allow a NULL str.  Having
qemu_strtosz not crash on qemu_strtosz(NULL, NULL, &value) is an easy
fix that adds some consistency between our string parsers.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230522190441.64278-13-eblake@redhat.com>
---
 tests/unit/test-cutils.c | 10 +++++++++-
 util/cutils.c            |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index 96bc9d1f202..26e3ba4b9f3 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3285,7 +3285,12 @@ static void do_strtosz_full(const char *str, qemu_strtosz_fn fn,
     ret = fn(str, &endptr, &val);
     g_assert_cmpint(ret, ==, exp_ptr_ret);
     g_assert_cmpuint(val, ==, exp_ptr_val);
-    g_assert_true(endptr == str + exp_ptr_offset);
+    if (str) {
+        g_assert_true(endptr == str + exp_ptr_offset);
+    } else {
+        g_assert_cmpint(exp_ptr_offset, ==, 0);
+        g_assert_null(endptr);
+    }

     val = 0xbaadf00d;
     ret = fn(str, NULL, &val);
@@ -3383,6 +3388,9 @@ static void test_qemu_strtosz_float(void)

 static void test_qemu_strtosz_invalid(void)
 {
+    do_strtosz(NULL, -EINVAL, 0xbaadf00d, 0);
+
+    /* Must parse at least one digit */
     do_strtosz("", -EINVAL, 0xbaadf00d, 0);
     do_strtosz(" \t ", -EINVAL, 0xbaadf00d, 0);
     do_strtosz("crap", -EINVAL, 0xbaadf00d, 0);
diff --git a/util/cutils.c b/util/cutils.c
index 56a2aced8d4..1dc67d201dc 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -306,7 +306,7 @@ static int do_strtosz(const char *nptr, const char **end,
 out:
     if (end) {
         *end = endptr;
-    } else if (*endptr) {
+    } else if (nptr && *endptr) {
         retval = -EINVAL;
     }
     if (retval == 0) {
-- 
2.40.1


