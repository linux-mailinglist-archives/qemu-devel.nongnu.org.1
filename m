Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C6E7B1E1D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwo-0003gs-Sv; Thu, 28 Sep 2023 09:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwf-0003dr-3h
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwQ-0008I0-II
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XBSUbeUcQ6TqxrAOOSaLrqlPPWjH713jSTenuIBROE=;
 b=NALAGDEbtDmRJOmij5cxCFY8husukfp/f4t+SThvhpqz0jwRJrmgAIJihBgHsl5Ku7FLGs
 /48l9AzSpTtYhhSzxSHzbf6QKYQpPewNkLE/XsUpwlt2kM7tJTeEa26amFtObku9C+sRyk
 sHM8PK9JiJv4RQZlVT1IK9P23r1Nmsw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-DDpddKduNr2uDyiPkezd0Q-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: DDpddKduNr2uDyiPkezd0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6C9B918175A8;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DBB910EE6C9;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1B6DD21E688B; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 27/53] migration/rdma: Replace int error_state by bool
 errored
Date: Thu, 28 Sep 2023 15:19:53 +0200
Message-ID: <20230928132019.2544702-28-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 66 ++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index fe101236c4..d92be4869a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -352,7 +352,7 @@ typedef struct RDMAContext {
      * memory registration, then do not attempt any future work
      * and remember the error state.
      */
-    int error_state;
+    bool errored;
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
@@ -1547,7 +1547,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
          * But we need to be able to handle 'cancel' or an error
          * without hanging forever.
          */
-        while (!rdma->error_state  && !rdma->received_error) {
+        while (!rdma->errored && !rdma->received_error) {
             GPollFD pfds[2];
             pfds[0].fd = comp_channel->fd;
             pfds[0].events = G_IO_IN | G_IO_HUP | G_IO_ERR;
@@ -1604,7 +1604,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
     if (rdma->received_error) {
         return -1;
     }
-    return -!!rdma->error_state;
+    return -rdma->errored;
 }
 
 static struct ibv_comp_channel *to_channel(RDMAContext *rdma, uint64_t wrid)
@@ -1722,7 +1722,7 @@ err_block_for_wrid:
         ibv_ack_cq_events(cq, num_cq_events);
     }
 
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
@@ -2366,7 +2366,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
     int idx;
 
     if (rdma->cm_id && rdma->connected) {
-        if ((rdma->error_state ||
+        if ((rdma->errored ||
              migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
             !rdma->received_error) {
             RDMAControlHeader head = { .len = 0,
@@ -2652,14 +2652,14 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
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
 
@@ -2717,7 +2717,7 @@ err_dest_init_bind_addr:
 err_dest_init_create_listen_id:
     rdma_destroy_event_channel(rdma->channel);
     rdma->channel = NULL;
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 
 }
@@ -2793,7 +2793,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         return -1;
     }
 
-    if (rdma->error_state) {
+    if (rdma->errored) {
         error_setg(errp,
                    "RDMA is in an error state waiting migration to abort!");
         return -1;
@@ -2805,7 +2805,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
      */
     ret = qemu_rdma_write_flush(f, rdma);
     if (ret < 0) {
-        rdma->error_state = ret;
+        rdma->errored = true;
         error_setg(errp, "qemu_rdma_write_flush failed");
         return -1;
     }
@@ -2825,7 +2825,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
             ret = qemu_rdma_exchange_send(rdma, &head, data, NULL, NULL, NULL);
 
             if (ret < 0) {
-                rdma->error_state = ret;
+                rdma->errored = true;
                 error_setg(errp, "qemu_rdma_exchange_send failed");
                 return -1;
             }
@@ -2883,7 +2883,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         return -1;
     }
 
-    if (rdma->error_state) {
+    if (rdma->errored) {
         error_setg(errp,
                    "RDMA is in an error state waiting migration to abort!");
         return -1;
@@ -2919,7 +2919,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_QEMU_FILE);
 
         if (ret < 0) {
-            rdma->error_state = ret;
+            rdma->errored = true;
             error_setg(errp, "qemu_rdma_exchange_recv failed");
             return -1;
         }
@@ -3193,21 +3193,21 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
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
@@ -3252,7 +3252,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3321,7 +3321,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
     return RAM_SAVE_CONTROL_DELAYED;
 
 err:
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
@@ -3342,13 +3342,13 @@ static void rdma_cm_poll_handler(void *opaque)
 
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
@@ -3514,7 +3514,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     return 0;
 
 err_rdma_dest_wait:
-    rdma->error_state = ret;
+    rdma->errored = true;
     qemu_rdma_cleanup(rdma);
     g_free(rdma_return_path);
     return -1;
@@ -3571,7 +3571,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3810,7 +3810,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     } while (1);
 
 err:
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
@@ -3887,7 +3887,7 @@ static int qemu_rdma_registration_start(QEMUFile *f,
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3920,7 +3920,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
         return -1;
     }
 
-    if (check_error_state(rdma)) {
+    if (rdma_errored(rdma)) {
         return -1;
     }
 
@@ -3974,7 +3974,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                     "Your QEMU command line parameters are probably "
                     "not identical on both the source and destination.",
                     local->nb_blocks, nb_dest_blocks);
-            rdma->error_state = -EINVAL;
+            rdma->errored = true;
             return -1;
         }
 
@@ -3990,7 +3990,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                         "vs %" PRIu64, local->block[i].block_name, i,
                         local->block[i].length,
                         rdma->dest_blocks[i].length);
-                rdma->error_state = -EINVAL;
+                rdma->errored = true;
                 return -1;
             }
             local->block[i].remote_host_addr =
@@ -4010,7 +4010,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
 
     return 0;
 err:
-    rdma->error_state = ret;
+    rdma->errored = true;
     return -1;
 }
 
-- 
2.41.0


