Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE670DA34
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P4p-0000iX-Cz; Tue, 23 May 2023 06:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4m-0000h8-PM; Tue, 23 May 2023 06:17:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4k-00028e-P0; Tue, 23 May 2023 06:17:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CAC9E7D06;
 Tue, 23 May 2023 13:15:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 11E867296;
 Tue, 23 May 2023 13:15:53 +0300 (MSK)
Received: (nullmailer pid 85551 invoked by uid 1000);
 Tue, 23 May 2023 10:15:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 56/59] tested: add test for nested aio_poll() in poll
 handlers
Date: Tue, 23 May 2023 13:15:16 +0300
Message-Id: <20230523101536.85424-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Cc: qemu-stable@nongnu.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230502184134.534703-3-stefanha@redhat.com>
[kwolf: Restrict to CONFIG_POSIX, Windows doesn't support polling]
Tested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 844a12a63e12b1235a8fc17f9b278929dc6eb00e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 3bc78d8660..8ed81786ee 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -114,7 +114,10 @@ if have_block
     tests += {'test-crypto-xts': [crypto, io]}
   endif
   if 'CONFIG_POSIX' in config_host
-    tests += {'test-image-locking': [testblock]}
+    tests += {
+      'test-image-locking': [testblock],
+      'test-nested-aio-poll': [testblock],
+    }
   endif
   if config_host_data.get('CONFIG_REPLICATION')
     tests += {'test-replication': [testblock]}
diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
new file mode 100644
index 0000000000..9bbe18b839
--- /dev/null
+++ b/tests/unit/test-nested-aio-poll.c
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Test that poll handlers are not re-entrant in nested aio_poll()
+ *
+ * Copyright Red Hat
+ *
+ * Poll handlers are usually level-triggered. That means they continue firing
+ * until the condition is reset (e.g. a virtqueue becomes empty). If a poll
+ * handler calls nested aio_poll() before the condition is reset, then infinite
+ * recursion occurs.
+ *
+ * aio_poll() is supposed to prevent this by disabling poll handlers in nested
+ * aio_poll() calls. This test case checks that this is indeed what happens.
+ */
+#include "qemu/osdep.h"
+#include "block/aio.h"
+#include "qapi/error.h"
+
+typedef struct {
+    AioContext *ctx;
+
+    /* This is the EventNotifier that drives the test */
+    EventNotifier poll_notifier;
+
+    /* This EventNotifier is only used to wake aio_poll() */
+    EventNotifier dummy_notifier;
+
+    bool nested;
+} TestData;
+
+static void io_read(EventNotifier *notifier)
+{
+    fprintf(stderr, "%s %p\n", __func__, notifier);
+    event_notifier_test_and_clear(notifier);
+}
+
+static bool io_poll_true(void *opaque)
+{
+    fprintf(stderr, "%s %p\n", __func__, opaque);
+    return true;
+}
+
+static bool io_poll_false(void *opaque)
+{
+    fprintf(stderr, "%s %p\n", __func__, opaque);
+    return false;
+}
+
+static void io_poll_ready(EventNotifier *notifier)
+{
+    TestData *td = container_of(notifier, TestData, poll_notifier);
+
+    fprintf(stderr, "> %s\n", __func__);
+
+    g_assert(!td->nested);
+    td->nested = true;
+
+    /* Wake the following nested aio_poll() call */
+    event_notifier_set(&td->dummy_notifier);
+
+    /* This nested event loop must not call io_poll()/io_poll_ready() */
+    g_assert(aio_poll(td->ctx, true));
+
+    td->nested = false;
+
+    fprintf(stderr, "< %s\n", __func__);
+}
+
+/* dummy_notifier never triggers */
+static void io_poll_never_ready(EventNotifier *notifier)
+{
+    g_assert_not_reached();
+}
+
+static void test(void)
+{
+    TestData td = {
+        .ctx = aio_context_new(&error_abort),
+    };
+
+    qemu_set_current_aio_context(td.ctx);
+
+    /* Enable polling */
+    aio_context_set_poll_params(td.ctx, 1000000, 2, 2, &error_abort);
+
+    /*
+     * The GSource is unused but this has the side-effect of changing the fdmon
+     * that AioContext uses.
+     */
+    aio_get_g_source(td.ctx);
+
+    /* Make the event notifier active (set) right away */
+    event_notifier_init(&td.poll_notifier, 1);
+    aio_set_event_notifier(td.ctx, &td.poll_notifier, false,
+                           io_read, io_poll_true, io_poll_ready);
+
+    /* This event notifier will be used later */
+    event_notifier_init(&td.dummy_notifier, 0);
+    aio_set_event_notifier(td.ctx, &td.dummy_notifier, false,
+                           io_read, io_poll_false, io_poll_never_ready);
+
+    /* Consume aio_notify() */
+    g_assert(!aio_poll(td.ctx, false));
+
+    /*
+     * Run the io_read() handler. This has the side-effect of activating
+     * polling in future aio_poll() calls.
+     */
+    g_assert(aio_poll(td.ctx, true));
+
+    /* The second time around the io_poll()/io_poll_ready() handler runs */
+    g_assert(aio_poll(td.ctx, true));
+
+    /* Run io_poll()/io_poll_ready() one more time to show it keeps working */
+    g_assert(aio_poll(td.ctx, true));
+
+    aio_set_event_notifier(td.ctx, &td.dummy_notifier, false,
+                           NULL, NULL, NULL);
+    aio_set_event_notifier(td.ctx, &td.poll_notifier, false, NULL, NULL, NULL);
+    event_notifier_cleanup(&td.dummy_notifier);
+    event_notifier_cleanup(&td.poll_notifier);
+    aio_context_unref(td.ctx);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_func("/nested-aio-poll", test);
+    return g_test_run();
+}
-- 
2.39.2


