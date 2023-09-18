Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 756637A4B24
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFTF-0003Jg-Fm; Mon, 18 Sep 2023 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSQ-00032H-1b
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS3-0002cp-0t
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrNnSh8+IHIVPaW/qP+RDKnXdtNzmzzrM/G8PvBfdCw=;
 b=hy4giUKoW3zIISlCXx3/34tUuQ5ImcT1xJ3IvENxXT1K76NJabduDwPolEMS+tjSwvGqET
 8q+21LXN4s9wCBhxL1FrxYG5O8TePl3hvT/mqmvmKvttfdtG7jnRerfksGgjuasrJMxv4i
 KgGibgaaUCq6ZFcpaCJu5ApEh7sr/bU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-HILKO8dONXK-Ig3qmdxldQ-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: HILKO8dONXK-Ig3qmdxldQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6946294592C
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B30E40C200A
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 342CF21E6888; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 26/52] migration/rdma: Replace int error_state by bool errored
Date: Mon, 18 Sep 2023 16:41:40 +0200
Message-ID: <20230918144206.560120-27-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All we do with the value of RDMAContext member @error_state is test
whether it's zero.  Change to bool and rename to @errored.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 66 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ad314cc10a..85f6b274bf 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -352,7 +352,7 @@ typedef struct RDMAContext {
      * memory registration, then do not attempt any future work
      * and remember the error state.
      */
-    int error_state;
+    int errored;
     bool error_reported;
     bool received_error;
 
@@ -439,14 +439,14 @@ typedef struct QEMU_PACKED {
     uint64_t chunks;            /* how many sequential chunks to register */
 } RDMARegister;
 
-static int check_error_state(RDMAContext *rdma)
+static bool rdma_errored(RDMAContext *rdma)
 {
-    if (rdma->error_state && !rdma->error_reported) {
+    if (rdma->errored && !rdma->error_reported) {
         error_report("RDMA is in an error state waiting migration"
                      " to abort!");
         rdma->error_reported = true;
     }
-    return rdma->error_state;
+    return rdma->errored;
 }
 
 static void register_to_network(RDMAContext *rdma, RDMARegister *reg)
@@ -1531,7 +1531,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
          * But we need to be able to handle 'cancel' or an error
          * without hanging forever.
          */
-        while (!rdma->error_state  && !rdma->received_error) {
+        while (!rdma->errored && !rdma->received_error) {
             GPollFD pfds[2];
             pfds[0].fd = comp_channel->fd;
             pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
@@ -1588,7 +1588,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
     if (rdma->received_error) {
         return -1;
     }
-    return -!!rdma->error_state;
+    return -rdma->errored;
 }
 
 static struct ibv_comp_channel *to_channel(RDMAContext *rdma, uint64_t wrid)
@@ -1701,7 +1701,7 @@ err_block_for_wrid:
         ibv_ack_cq_events(cq, num_cq_events);
     }
 
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
@@ -2340,7 +2340,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
     int idx;
 
     if (rdma->cm_id && rdma->connected) {
-        if ((rdma->error_state ||
+        if ((rdma->errored ||
              migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
             !rdma->received_error) {
             RDMAControlHeader head = { .len = 0,
@@ -2621,14 +2621,14 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     if (!rdma->host || !rdma->host[0]) {
         ERROR(errp, "RDMA host is not set!");
-        rdma->error_state = -EINVAL;
+        rdma->errored = true;
         return -1;
     }
     /* create CM channel */
     rdma->channel = rdma_create_event_channel();
     if (!rdma->channel) {
         ERROR(errp, "could not create rdma event channel");
-        rdma->error_state = -EINVAL;
+        rdma->errored = true;
         return -1;
     }
 
@@ -2686,7 +2686,7 @@ err_dest_init_bind_addr:
 err_dest_init_create_listen_id:
     rdma_destroy_event_channel(rdma->channel);
     rdma->channel = NULL;
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 
 }
@@ -2763,7 +2763,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         return -1;
     }
 
-    if (rdma->error_state) {
+    if (rdma->errored) {
         error_setg(errp,
                    "RDMA is in an error state waiting migration to abort!");
         return -1;
@@ -2775,7 +2775,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
      */
     ret = qemu_rdma_write_flush(f, rdma);
     if (ret < 0) {
-        rdma->error_state = ret;
+        rdma->errored = true;
         error_setg(errp, "qemu_rdma_write_flush failed");
         return -1;
     }
@@ -2795,7 +2795,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
             ret = qemu_rdma_exchange_send(rdma, &head, data, NULL, NULL, NULL);
 
             if (ret < 0) {
-                rdma->error_state = ret;
+                rdma->errored = true;
                 error_setg(errp, "qemu_rdma_exchange_send failed");
                 return -1;
             }
@@ -2853,7 +2853,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         return -1;
     }
 
-    if (rdma->error_state) {
+    if (rdma->errored) {
         error_setg(errp,
                    "RDMA is in an error state waiting migration to abort!");
         return -1;
@@ -2889,7 +2889,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_QEMU_FILE);
 
         if (ret < 0) {
-            rdma->error_state = ret;
+            rdma->errored = true;
             error_setg(errp, "qemu_rdma_exchange_recv failed");
             return -1;
         }
@@ -3162,21 +3162,21 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
     switch (how) {
     case QIO_CHANNEL_SHUTDOWN_READ:
         if (rdmain) {
-            rdmain->error_state = -1;
+            rdmain->errored = true;
         }
         break;
     case QIO_CHANNEL_SHUTDOWN_WRITE:
         if (rdmaout) {
-            rdmaout->error_state = -1;
+            rdmaout->errored = true;
         }
         break;
     case QIO_CHANNEL_SHUTDOWN_BOTH:
     default:
         if (rdmain) {
-            rdmain->error_state = -1;
+            rdmain->errored = true;
         }
         if (rdmaout) {
-            rdmaout->error_state = -1;
+            rdmaout->errored = true;
         }
         break;
     }
@@ -3221,7 +3221,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3290,7 +3290,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
     return RAM_SAVE_CONTROL_DELAYED;
 
 err:
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
@@ -3311,13 +3311,13 @@ static void rdma_cm_poll_handler(void *opaque)
 
     if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
         cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
-        if (!rdma->error_state &&
+        if (!rdma->errored &&
             migration_incoming_get_current()->state !=
               MIGRATION_STATUS_COMPLETED) {
             error_report("receive cm event, cm event is %d", cm_event->event);
-            rdma->error_state = -EPIPE;
+            rdma->errored = true;
             if (rdma->return_path) {
-                rdma->return_path->error_state = -EPIPE;
+                rdma->return_path->errored = true;
             }
         }
         rdma_ack_cm_event(cm_event);
@@ -3483,7 +3483,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     return 0;
 
 err_rdma_dest_wait:
-    rdma->error_state = ret;
+    rdma->errored = true;
     qemu_rdma_cleanup(rdma);
     g_free(rdma_return_path);
     return -1;
@@ -3540,7 +3540,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3779,7 +3779,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     } while (1);
 
 err:
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
@@ -3856,7 +3856,7 @@ static int qemu_rdma_registration_start(QEMUFile *f,
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3889,7 +3889,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3943,7 +3943,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                     "Your QEMU command line parameters are probably "
                     "not identical on both the source and destination.",
                     local->nb_blocks, nb_dest_blocks);
-            rdma->error_state = -EINVAL;
+            rdma->errored = true;
             return -1;
         }
 
@@ -3959,7 +3959,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                         "vs %" PRIu64, local->block[i].block_name, i,
                         local->block[i].length,
                         rdma->dest_blocks[i].length);
-                rdma->error_state = -EINVAL;
+                rdma->errored = true;
                 return -1;
             }
             local->block[i].remote_host_addr =
@@ -3979,7 +3979,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
 
     return 0;
 err:
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
-- 
2.41.0


