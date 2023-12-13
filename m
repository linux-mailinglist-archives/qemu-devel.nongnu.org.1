Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EDC812085
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:16:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDWaJ-0005Rk-Vi; Wed, 13 Dec 2023 16:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWaH-0005R9-EX
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:16:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWaF-0004zZ-6G
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:16:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702502158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/bfZTQ/Qk+XmmvEXyrRlW2d2kJ+ljwFnVi9qYIwrQ2s=;
 b=LBhhpUt0CG1thVvcoUTJbx/JTCIbXj3OlrvJOrw/1F6WJWmoFcYSfqQqSoBXxpXmVO7Yf+
 lYXCeBYN2VJXuRSD7NhPurWf6E/qE5xyBCgNFo+ZTEqAar/C/h6eVLUu82uFX42/saiCEq
 uRxFjVk1f+ivIDXpKTBHrtGmb8I42Zs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-x8kwkfqvNhyC-5sxcgT5GQ-1; Wed,
 13 Dec 2023 16:15:54 -0500
X-MC-Unique: x8kwkfqvNhyC-5sxcgT5GQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97EDD29AB443;
 Wed, 13 Dec 2023 21:15:54 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 05BAD3C25;
 Wed, 13 Dec 2023 21:15:53 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 3/3] aio-posix: call ->poll_end() when removing AioHandler
Date: Wed, 13 Dec 2023 16:15:44 -0500
Message-ID: <20231213211544.1601971-4-stefanha@redhat.com>
In-Reply-To: <20231213211544.1601971-1-stefanha@redhat.com>
References: <20231213211544.1601971-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hanna Czenczek found the root cause for --device
virtio-scsi-pci,iothread= hangs across hotplug/unplug. When AioContext
polling has started on the virtqueue host notifier in the IOThread and
the main loop thread calls aio_set_fd_handler(), then the io_poll_end()
callback is not invoked on the virtqueue host notifier. The virtqueue is
left with polling disabled and never detects guest activity once
attached again (because virtqueue kicks are not enabled and AioContext
only starts polling after the fd becomes active for the first time). The
result is that the virtio-scsi device stops responding to its virtqueue.

Previous patches made aio_set_fd_handler() run in the AioContext's home
thread so it's now possible to call ->io_poll_end() to solve this bug.

Buglink: https://issues.redhat.com/browse/RHEL-3934
Cc: Hanna Czenczek <hreitz@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 53 ++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 86e232e9d3..2245a9659b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -64,8 +64,11 @@ static AioHandler *find_aio_handler(AioContext *ctx, int fd)
     return NULL;
 }
 
-static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
+static void aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
 {
+    bool poll_ready;
+    bool delete_node = false;
+
     /* If the GSource is in the process of being destroyed then
      * g_source_remove_poll() causes an assertion failure.  Skip
      * removal in that case, because glib cleans up its state during
@@ -76,25 +79,40 @@ static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
     }
 
     node->pfd.revents = 0;
+    poll_ready = node->poll_ready;
     node->poll_ready = false;
 
     /* If the fd monitor has already marked it deleted, leave it alone */
-    if (QLIST_IS_INSERTED(node, node_deleted)) {
-        return false;
+    if (!QLIST_IS_INSERTED(node, node_deleted)) {
+        /* If a read is in progress, just mark the node as deleted */
+        if (ctx->walking_handlers > 0) {
+            QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
+        } else {
+            /* Otherwise, delete it for real.  We can't just mark it as
+             * deleted because deleted nodes are only cleaned up while
+             * no one is walking the handlers list.
+             */
+            QLIST_SAFE_REMOVE(node, node_poll);
+            QLIST_REMOVE(node, node);
+            delete_node = true;
+        }
     }
 
-    /* If a read is in progress, just mark the node as deleted */
-    if (ctx->walking_handlers > 0) {
-        QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
-        return false;
+    /* If polling was started on the node then end it now */
+    if (ctx->poll_started && node->io_poll_end) {
+        node->io_poll_end(node->opaque);
+
+        /* Poll one last time in case ->io_poll_end() raced with the event */
+        if (node->io_poll(node->opaque)) {
+            poll_ready = true;
+        }
+    }
+    if (poll_ready) {
+        node->io_poll_ready(node->opaque);
+    }
+    if (delete_node) {
+        g_free(node);
     }
-    /* Otherwise, delete it for real.  We can't just mark it as
-     * deleted because deleted nodes are only cleaned up while
-     * no one is walking the handlers list.
-     */
-    QLIST_SAFE_REMOVE(node, node_poll);
-    QLIST_REMOVE(node, node);
-    return true;
 }
 
 /* Perform aio_set_fd_handler() in this thread's AioContext */
@@ -109,7 +127,6 @@ static void aio_set_fd_handler_local(AioContext *ctx,
     AioHandler *node;
     AioHandler *new_node = NULL;
     bool is_new = false;
-    bool deleted = false;
     int poll_disable_change;
 
     if (io_poll && !io_poll_ready) {
@@ -166,13 +183,9 @@ static void aio_set_fd_handler_local(AioContext *ctx,
 
     ctx->fdmon_ops->update(ctx, node, new_node);
     if (node) {
-        deleted = aio_remove_fd_handler(ctx, node);
+        aio_remove_fd_handler(ctx, node);
     }
     aio_notify(ctx);
-
-    if (deleted) {
-        g_free(node);
-    }
 }
 
 typedef struct {
-- 
2.43.0


