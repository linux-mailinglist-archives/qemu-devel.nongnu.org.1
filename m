Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F17D93ED
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:38:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJHW-0002Ow-9G; Fri, 27 Oct 2023 05:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHU-0002OV-Cc
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJHS-0002m0-Nc
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698399446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3EGtR8ICZJdFV3k33PAaGnx20Fnaqp2qqlexz1kr+e4=;
 b=jLWrH7Y0JV2UgBAlYiteXTcXmEz2dQX330CqQQG6Fd58Fs2MD/y9nwfXRTRaVp33knZHta
 Tlv1K/cN6t332mIWzSnPAqISnj1Z0BP9VbpTGBr8C0nTzT1sUYYn5pM9NSH2vM8rIRBpwL
 LzT6KF4GyML9v4wymz7Ma666Pn60/us=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-IKZgMaV7NeamH_cH9jYhDg-1; Fri, 27 Oct 2023 05:37:24 -0400
X-MC-Unique: IKZgMaV7NeamH_cH9jYhDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D44E4811E7E;
 Fri, 27 Oct 2023 09:37:23 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 889491121319;
 Fri, 27 Oct 2023 09:37:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/11] tests/coroutine: Clean up global variable shadowing
Date: Fri, 27 Oct 2023 11:37:07 +0200
Message-ID: <20231027093710.273558-9-thuth@redhat.com>
In-Reply-To: <20231027093710.273558-1-thuth@redhat.com>
References: <20231027093710.273558-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Rename the global variable to avoid:

  tests/unit/test-coroutine.c:430:11: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      bool *done = opaque;
            ^
  tests/unit/test-coroutine.c:438:10: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      bool done = false;
           ^
  tests/unit/test-coroutine.c:198:12: note: previous declaration is here
  static int done;
             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231009100251.56019-11-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/unit/test-coroutine.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-coroutine.c b/tests/unit/test-coroutine.c
index a2563647e7..49d4d9b251 100644
--- a/tests/unit/test-coroutine.c
+++ b/tests/unit/test-coroutine.c
@@ -195,7 +195,7 @@ static void test_no_dangling_access(void)
 }
 
 static bool locked;
-static int done;
+static int done_count;
 
 static void coroutine_fn mutex_fn(void *opaque)
 {
@@ -206,7 +206,7 @@ static void coroutine_fn mutex_fn(void *opaque)
     qemu_coroutine_yield();
     locked = false;
     qemu_co_mutex_unlock(m);
-    done++;
+    done_count++;
 }
 
 static void coroutine_fn lockable_fn(void *opaque)
@@ -218,7 +218,7 @@ static void coroutine_fn lockable_fn(void *opaque)
     qemu_coroutine_yield();
     locked = false;
     qemu_lockable_unlock(x);
-    done++;
+    done_count++;
 }
 
 static void do_test_co_mutex(CoroutineEntry *entry, void *opaque)
@@ -226,7 +226,7 @@ static void do_test_co_mutex(CoroutineEntry *entry, void *opaque)
     Coroutine *c1 = qemu_coroutine_create(entry, opaque);
     Coroutine *c2 = qemu_coroutine_create(entry, opaque);
 
-    done = 0;
+    done_count = 0;
     qemu_coroutine_enter(c1);
     g_assert(locked);
     qemu_coroutine_enter(c2);
@@ -235,11 +235,11 @@ static void do_test_co_mutex(CoroutineEntry *entry, void *opaque)
      * terminates.
      */
     qemu_coroutine_enter(c1);
-    g_assert_cmpint(done, ==, 1);
+    g_assert_cmpint(done_count, ==, 1);
     g_assert(locked);
 
     qemu_coroutine_enter(c2);
-    g_assert_cmpint(done, ==, 2);
+    g_assert_cmpint(done_count, ==, 2);
     g_assert(!locked);
 }
 
-- 
2.41.0


