Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EE6A5C3A6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 15:19:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0SB-00009u-8m; Tue, 11 Mar 2025 10:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts0S6-0008V4-VB
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ts0S4-0008K7-Fi
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741702763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Sqb+IRiAK1k2sJ+AoHuZ62AvayljAzfcjq800f8O8ng=;
 b=NwLCjt4ba9SHn8ZkvDAr3u9udlhyKLIj+nQhy09t7sXZR3BG87XXrtlTwVeA/xlPwhyDju
 EqKcx1OzOJzeJ5ZCYPVUy9DeAaJF9z1xQ0G+0Oh6PqNDWjg9eVzlpTR4Mo3ItQiwBsBNwL
 RKByQePh82YFoN8vPpqlwbMO2ZkX/5Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-uFZ05b6eM9OThzONzUsVDw-1; Tue,
 11 Mar 2025 10:19:19 -0400
X-MC-Unique: uFZ05b6eM9OThzONzUsVDw-1
X-Mimecast-MFC-AGG-ID: uFZ05b6eM9OThzONzUsVDw_1741702758
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D09121954B1C; Tue, 11 Mar 2025 14:19:16 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.33.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEFD118001F6; Tue, 11 Mar 2025 14:19:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH] aio-posix: Adjust polling time also for new handlers
Date: Tue, 11 Mar 2025 15:19:12 +0100
Message-ID: <20250311141912.135657-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

aio_dispatch_handler() adds handlers to ctx->poll_aio_handlers if
polling should be enabled. If we call adjust_polling_time() for all
polling handlers before this, new polling handlers are still left at
poll->ns = 0 and polling is only actually enabled after the next event.
Move the adjust_polling_time() call after aio_dispatch_handler().

This fixes test-nested-aio-poll, which expects that polling becomes
effective the first time around.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/aio-posix.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 80785c29d2..2e0a5dadc4 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -28,6 +28,9 @@
 /* Stop userspace polling on a handler if it isn't active for some time */
 #define POLL_IDLE_INTERVAL_NS (7 * NANOSECONDS_PER_SECOND)
 
+static void adjust_polling_time(AioContext *ctx, AioPolledEvent *poll,
+                                int64_t block_ns);
+
 bool aio_poll_disabled(AioContext *ctx)
 {
     return qatomic_read(&ctx->poll_disable_cnt);
@@ -392,7 +395,8 @@ static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
  * scanning all handlers with aio_dispatch_handlers().
  */
 static bool aio_dispatch_ready_handlers(AioContext *ctx,
-                                        AioHandlerList *ready_list)
+                                        AioHandlerList *ready_list,
+                                        int64_t block_ns)
 {
     bool progress = false;
     AioHandler *node;
@@ -400,6 +404,14 @@ static bool aio_dispatch_ready_handlers(AioContext *ctx,
     while ((node = QLIST_FIRST(ready_list))) {
         QLIST_REMOVE(node, node_ready);
         progress = aio_dispatch_handler(ctx, node) || progress;
+
+        /*
+         * Adjust polling time only after aio_dispatch_handler(), which can
+         * add the handler to ctx->poll_aio_handlers.
+         */
+        if (ctx->poll_max_ns && QLIST_IS_INSERTED(node, node_poll)) {
+            adjust_polling_time(ctx, &node->poll, block_ns);
+        }
     }
 
     return progress;
@@ -653,6 +665,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     bool use_notify_me;
     int64_t timeout;
     int64_t start = 0;
+    int64_t block_ns = 0;
 
     /*
      * There cannot be two concurrent aio_poll calls for the same AioContext (or
@@ -725,20 +738,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
 
     aio_notify_accept(ctx);
 
-    /* Adjust polling time */
+    /* Calculate blocked time for adaptive polling */
     if (ctx->poll_max_ns) {
-        AioHandler *node;
-        int64_t block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
-
-        QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
-            if (QLIST_IS_INSERTED(node, node_ready)) {
-                adjust_polling_time(ctx, &node->poll, block_ns);
-            }
-        }
+        block_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - start;
     }
 
     progress |= aio_bh_poll(ctx);
-    progress |= aio_dispatch_ready_handlers(ctx, &ready_list);
+    progress |= aio_dispatch_ready_handlers(ctx, &ready_list, block_ns);
 
     aio_free_deleted_handlers(ctx);
 
-- 
2.48.1


