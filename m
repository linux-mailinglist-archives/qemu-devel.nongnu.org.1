Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E27807C4EF0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:29:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRE-0000Xz-Oq; Wed, 11 Oct 2023 05:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVR9-0008Pl-KB
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVR7-00052b-DT
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8fcfN+SoirDdOtjHvMi7Jhfd/ro8/PTkg9T5b073+Q=;
 b=UBQ/5rNrcCX008nrOdgQURSdGVTd8qpPXEcCfswqDVlOnx/Q9KFIb8WibJgS1RNqZTgA33
 0BH8FPxy/K/3/iQX2PqcYz1AzHevyzssyQeX0Z5QeEs6nHCzvNMn/uAoD4tniZ3Q4OK8jn
 DK16HYUIWEQFY8AYs5enTwveeFTa6E8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-uxyKBbIZN3uOboZSo6r9yA-1; Wed, 11 Oct 2023 05:23:19 -0400
X-MC-Unique: uxyKBbIZN3uOboZSo6r9yA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5535F8007A4;
 Wed, 11 Oct 2023 09:23:19 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97AB81C060AE;
 Wed, 11 Oct 2023 09:23:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 36/65] migration/rdma: Check negative error values the same way
 everywhere
Date: Wed, 11 Oct 2023 11:21:34 +0200
Message-ID: <20231011092203.1266-37-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

When a function returns 0 on success, negative value on error,
checking for non-zero suffices, but checking for negative is clearer.
So do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-30-armbru@redhat.com>
---
 migration/rdma.c | 82 ++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 08a82d5e57..b0125b01cf 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -953,7 +953,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &rdma->cm_id, NULL, RDMA_PS_TCP);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not create channel id");
         goto err_resolve_create_id;
     }
@@ -974,10 +974,10 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
         ret = rdma_resolve_addr(rdma->cm_id, NULL, e->ai_dst_addr,
                 RDMA_RESOLVE_TIMEOUT_MS);
-        if (!ret) {
+        if (ret >= 0) {
             if (e->ai_family == AF_INET6) {
                 ret = qemu_rdma_broken_ipv6_kernel(rdma->cm_id->verbs, errp);
-                if (ret) {
+                if (ret < 0) {
                     continue;
                 }
             }
@@ -994,7 +994,7 @@ route:
     qemu_rdma_dump_gid("source_resolve_addr", rdma->cm_id);
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not perform event_addr_resolved");
         goto err_resolve_get_addr;
     }
@@ -1010,13 +1010,13 @@ route:
 
     /* resolve route */
     ret = rdma_resolve_route(rdma->cm_id, RDMA_RESOLVE_TIMEOUT_MS);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not resolve rdma route");
         goto err_resolve_get_addr;
     }
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not perform event_route_resolved");
         goto err_resolve_get_addr;
     }
@@ -1124,7 +1124,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
     attr.qp_type = IBV_QPT_RC;
 
     ret = rdma_create_qp(rdma->cm_id, rdma->pd, &attr);
-    if (ret) {
+    if (ret < 0) {
         return -1;
     }
 
@@ -1567,7 +1567,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
 
                 if (pfds[1].revents) {
                     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-                    if (ret) {
+                    if (ret < 0) {
                         error_report("failed to get cm event while wait "
                                      "completion channel");
                         return -1;
@@ -1668,12 +1668,12 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
 
     while (1) {
         ret = qemu_rdma_wait_comp_channel(rdma, ch);
-        if (ret) {
+        if (ret < 0) {
             goto err_block_for_wrid;
         }
 
         ret = ibv_get_cq_event(ch, &cq, &cq_ctx);
-        if (ret) {
+        if (ret < 0) {
             /*
              * FIXME perror() is problematic, because ibv_reg_mr() is
              * not documented to set errno.  Will go away later in
@@ -1911,7 +1911,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      */
     if (resp) {
         ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_DATA);
-        if (ret) {
+        if (ret < 0) {
             error_report("rdma migration: error posting"
                     " extra control recv for anticipated result!");
             return -1;
@@ -1922,7 +1922,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      * Post a WR to replace the one we just consumed for the READY message.
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting first control recv!");
         return -1;
     }
@@ -2009,7 +2009,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
      * Post a new RECV work request to replace the one we just consumed.
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting second control recv!");
         return -1;
     }
@@ -2357,7 +2357,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
         ret = qemu_rdma_write_flush(rdma);
-        if (ret) {
+        if (ret < 0) {
             return -1;
         }
         rdma->current_length = 0;
@@ -2487,12 +2487,12 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     rdma->pin_all = pin_all;
 
     ret = qemu_rdma_resolve_host(rdma, errp);
-    if (ret) {
+    if (ret < 0) {
         goto err_rdma_source_init;
     }
 
     ret = qemu_rdma_alloc_pd_cq(rdma);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "rdma migration: error allocating pd and cq! Your mlock()"
                     " limits may be too low. Please check $ ulimit -a # and "
                     "search for 'ulimit -l' in the output");
@@ -2500,7 +2500,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     }
 
     ret = qemu_rdma_alloc_qp(rdma);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "rdma migration: error allocating qp!");
         goto err_rdma_source_init;
     }
@@ -2517,7 +2517,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
-        if (ret) {
+        if (ret < 0) {
             ERROR(errp, "rdma migration: error registering %d control!",
                                                             idx);
             goto err_rdma_source_init;
@@ -2591,13 +2591,13 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
     caps_to_network(&cap);
 
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "posting second control recv");
         goto err_rdma_source_connect;
     }
 
     ret = rdma_connect(rdma->cm_id, &conn_param);
-    if (ret) {
+    if (ret < 0) {
         perror("rdma_connect");
         ERROR(errp, "connecting to destination!");
         goto err_rdma_source_connect;
@@ -2611,7 +2611,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
             ERROR(errp, "failed to get cm event");
         }
     }
-    if (ret) {
+    if (ret < 0) {
         /*
          * FIXME perror() is wrong, because
          * qemu_get_cm_event_timeout() can fail without setting errno.
@@ -2684,7 +2684,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &listen_id, NULL, RDMA_PS_TCP);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not create cm_id!");
         goto err_dest_init_create_listen_id;
     }
@@ -2700,7 +2700,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     ret = rdma_set_option(listen_id, RDMA_OPTION_ID, RDMA_OPTION_ID_REUSEADDR,
                           &reuse, sizeof reuse);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "Error: could not set REUSEADDR option");
         goto err_dest_init_bind_addr;
     }
@@ -2709,12 +2709,12 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
             &((struct sockaddr_in *) e->ai_dst_addr)->sin_addr, ip, sizeof ip);
         trace_qemu_rdma_dest_init_trying(rdma->host, ip);
         ret = rdma_bind_addr(listen_id, e->ai_dst_addr);
-        if (ret) {
+        if (ret < 0) {
             continue;
         }
         if (e->ai_family == AF_INET6) {
             ret = qemu_rdma_broken_ipv6_kernel(listen_id->verbs, errp);
-            if (ret) {
+            if (ret < 0) {
                 continue;
             }
         }
@@ -3342,7 +3342,7 @@ static void rdma_cm_poll_handler(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         error_report("get_cm_event failed %d", errno);
         return;
     }
@@ -3382,7 +3382,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     int idx;
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         goto err_rdma_dest_wait;
     }
 
@@ -3452,13 +3452,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     qemu_rdma_dump_id("dest_init", verbs);
 
     ret = qemu_rdma_alloc_pd_cq(rdma);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error allocating pd and cq!");
         goto err_rdma_dest_wait;
     }
 
     ret = qemu_rdma_alloc_qp(rdma);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error allocating qp!");
         goto err_rdma_dest_wait;
     }
@@ -3467,7 +3467,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
-        if (ret) {
+        if (ret < 0) {
             error_report("rdma: error registering %d control", idx);
             goto err_rdma_dest_wait;
         }
@@ -3485,13 +3485,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     }
 
     ret = rdma_accept(rdma->cm_id, &conn_param);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma_accept failed");
         goto err_rdma_dest_wait;
     }
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma_accept get_cm_event failed");
         goto err_rdma_dest_wait;
     }
@@ -3506,7 +3506,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     rdma->connected = true;
 
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting second control recv");
         goto err_rdma_dest_wait;
     }
@@ -3635,7 +3635,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (rdma->pin_all) {
                 ret = qemu_rdma_reg_whole_ram_blocks(rdma);
-                if (ret) {
+                if (ret < 0) {
                     error_report("rdma migration: error dest "
                                     "registering ram blocks");
                     goto err;
@@ -4096,7 +4096,7 @@ static void rdma_accept_incoming_migration(void *opaque)
     trace_qemu_rdma_accept_incoming_migration();
     ret = qemu_rdma_accept(rdma);
 
-    if (ret) {
+    if (ret < 0) {
         fprintf(stderr, "RDMA ERROR: Migration initialization failed\n");
         return;
     }
@@ -4140,7 +4140,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     }
 
     ret = qemu_rdma_dest_init(rdma, errp);
-    if (ret) {
+    if (ret < 0) {
         goto err;
     }
 
@@ -4148,7 +4148,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 
     ret = rdma_listen(rdma->listen_id, 5);
 
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "listening on socket!");
         goto cleanup_rdma;
     }
@@ -4190,14 +4190,14 @@ void rdma_start_outgoing_migration(void *opaque,
 
     ret = qemu_rdma_source_init(rdma, migrate_rdma_pin_all(), errp);
 
-    if (ret) {
+    if (ret < 0) {
         goto err;
     }
 
     trace_rdma_start_outgoing_migration_after_rdma_source_init();
     ret = qemu_rdma_connect(rdma, false, errp);
 
-    if (ret) {
+    if (ret < 0) {
         goto err;
     }
 
@@ -4212,13 +4212,13 @@ void rdma_start_outgoing_migration(void *opaque,
         ret = qemu_rdma_source_init(rdma_return_path,
                                     migrate_rdma_pin_all(), errp);
 
-        if (ret) {
+        if (ret < 0) {
             goto return_path_err;
         }
 
         ret = qemu_rdma_connect(rdma_return_path, true, errp);
 
-        if (ret) {
+        if (ret < 0) {
             goto return_path_err;
         }
 
-- 
2.41.0


