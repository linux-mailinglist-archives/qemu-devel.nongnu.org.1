Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23DE70DA44
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P4n-0000gg-MV; Tue, 23 May 2023 06:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4k-0000aH-MB; Tue, 23 May 2023 06:17:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P4i-000284-M2; Tue, 23 May 2023 06:17:06 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 907457D05;
 Tue, 23 May 2023 13:15:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CB61D7295;
 Tue, 23 May 2023 13:15:52 +0300 (MSK)
Received: (nullmailer pid 85548 invoked by uid 1000);
 Tue, 23 May 2023 10:15:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 55/59] aio-posix: do not nest poll handlers
Date: Tue, 23 May 2023 13:15:15 +0300
Message-Id: <20230523101536.85424-19-mjt@tls.msk.ru>
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

QEMU's event loop supports nesting, which means that event handler
functions may themselves call aio_poll(). The condition that triggered a
handler must be reset before the nested aio_poll() call, otherwise the
same handler will be called and immediately re-enter aio_poll. This
leads to an infinite loop and stack exhaustion.

Poll handlers are especially prone to this issue, because they typically
reset their condition by finishing the processing of pending work.
Unfortunately it is during the processing of pending work that nested
aio_poll() calls typically occur and the condition has not yet been
reset.

Disable a poll handler during ->io_poll_ready() so that a nested
aio_poll() call cannot invoke ->io_poll_ready() again. As a result, the
disabled poll handler and its associated fd handler do not run during
the nested aio_poll(). Calling aio_set_fd_handler() from inside nested
aio_poll() could cause it to run again. If the fd handler is pending
inside nested aio_poll(), then it will also run again.

In theory fd handlers can be affected by the same issue, but they are
more likely to reset the condition before calling nested aio_poll().

This is a special case and it's somewhat complex, but I don't see a way
around it as long as nested aio_poll() is supported.

Cc: qemu-stable@nongnu.org
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2186181
Fixes: c38270692593 ("block: Mark bdrv_co_io_(un)plug() and callers GRAPH_RDLOCK")
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20230502184134.534703-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 6d740fb01b9f0f5ea7a82f4d5e458d91940a19ee)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/aio-posix.c b/util/aio-posix.c
index a8be940f76..34bc2a64d8 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -353,8 +353,19 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
         poll_ready && revents == 0 &&
         aio_node_check(ctx, node->is_external) &&
         node->io_poll_ready) {
+        /*
+         * Remove temporarily to avoid infinite loops when ->io_poll_ready()
+         * calls aio_poll() before clearing the condition that made the poll
+         * handler become ready.
+         */
+        QLIST_SAFE_REMOVE(node, node_poll);
+
         node->io_poll_ready(node->opaque);
 
+        if (!QLIST_IS_INSERTED(node, node_poll)) {
+            QLIST_INSERT_HEAD(&ctx->poll_aio_handlers, node, node_poll);
+        }
+
         /*
          * Return early since revents was zero. aio_notify() does not count as
          * progress.
-- 
2.39.2


