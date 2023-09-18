Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE4C7A4B1F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:43:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSa-00037l-Hv; Mon, 18 Sep 2023 10:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSK-0002x5-V6
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002cT-NZ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ooSw5XQ9Uexwquu9yFVpETBvwFnVBespYIJTmG1qCHc=;
 b=cHIY1KByz7v3eJFCsoUPognIfLuowH0mBit/8v8MFDLdHDNwlilrE2DmHAv6AiJqxdxPTA
 g4IfxnBa1h4UamaLQUzXnL3AC0aIqs9J4MJOQaxXqQgrlxDcmPMzPqiFqcIyfXb7CXdgmj
 eRejupChjWJKee0I3EFG727/YZokHD4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-fVD2gPUyOs2xNRdAKo0KLA-1; Mon, 18 Sep 2023 10:42:12 -0400
X-MC-Unique: fVD2gPUyOs2xNRdAKo0KLA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C7B7811E8E
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 326581C5BB
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3A30021E688B; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 28/52] migration/rdma: Check negative error values the same
 way everywhere
Date: Mon, 18 Sep 2023 16:41:42 +0200
Message-ID: <20230918144206.560120-29-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

When a function returns 0 on success, negative value on error,
checking for non-zero suffices, but checking for negative is clearer.
So do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 82 ++++++++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 62d95b7d2c..6c643a1b30 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -947,7 +947,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &rdma->cm_id, NULL, RDMA_PS_TCP);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not create channel id");
         goto err_resolve_create_id;
     }
@@ -968,10 +968,10 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
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
@@ -988,7 +988,7 @@ route:
     qemu_rdma_dump_gid("source_resolve_addr", rdma->cm_id);
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not perform event_addr_resolved");
         goto err_resolve_get_addr;
     }
@@ -1004,13 +1004,13 @@ route:
 
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
@@ -1118,7 +1118,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
     attr.qp_type = IBV_QPT_RC;
 
     ret = rdma_create_qp(rdma->cm_id, rdma->pd, &attr);
-    if (ret) {
+    if (ret < 0) {
         return -1;
     }
 
@@ -1551,7 +1551,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
 
                 if (pfds[1].revents) {
                     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-                    if (ret) {
+                    if (ret < 0) {
                         error_report("failed to get cm event while wait "
                                      "completion channel");
                         return -1;
@@ -1652,12 +1652,12 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
 
     while (1) {
         ret = qemu_rdma_wait_comp_channel(rdma, ch);
-        if (ret) {
+        if (ret < 0) {
             goto err_block_for_wrid;
         }
 
         ret = ibv_get_cq_event(ch, &cq, &cq_ctx);
-        if (ret) {
+        if (ret < 0) {
             perror("ibv_get_cq_event");
             goto err_block_for_wrid;
         }
@@ -1888,7 +1888,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      */
     if (resp) {
         ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_DATA);
-        if (ret) {
+        if (ret < 0) {
             error_report("rdma migration: error posting"
                     " extra control recv for anticipated result!");
             return -1;
@@ -1899,7 +1899,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      * Post a WR to replace the one we just consumed for the READY message.
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting first control recv!");
         return -1;
     }
@@ -1986,7 +1986,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
      * Post a new RECV work request to replace the one we just consumed.
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting second control recv!");
         return -1;
     }
@@ -2311,7 +2311,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
         ret = qemu_rdma_write_flush(f, rdma);
-        if (ret) {
+        if (ret < 0) {
             return -1;
         }
         rdma->current_length = 0;
@@ -2441,12 +2441,12 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
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
@@ -2454,7 +2454,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     }
 
     ret = qemu_rdma_alloc_qp(rdma);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "rdma migration: error allocating qp!");
         goto err_rdma_source_init;
     }
@@ -2471,7 +2471,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
-        if (ret) {
+        if (ret < 0) {
             ERROR(errp, "rdma migration: error registering %d control!",
                                                             idx);
             goto err_rdma_source_init;
@@ -2545,13 +2545,13 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
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
@@ -2565,7 +2565,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
             ERROR(errp, "failed to get cm event");
         }
     }
-    if (ret) {
+    if (ret < 0) {
         perror("rdma_get_cm_event after rdma_connect");
         goto err_rdma_source_connect;
     }
@@ -2633,7 +2633,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &listen_id, NULL, RDMA_PS_TCP);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not create cm_id!");
         goto err_dest_init_create_listen_id;
     }
@@ -2649,7 +2649,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     ret = rdma_set_option(listen_id, RDMA_OPTION_ID, RDMA_OPTION_ID_REUSEADDR,
                           &reuse, sizeof reuse);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "Error: could not set REUSEADDR option");
         goto err_dest_init_bind_addr;
     }
@@ -2658,12 +2658,12 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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
@@ -3303,7 +3303,7 @@ static void rdma_cm_poll_handler(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         error_report("get_cm_event failed %d", errno);
         return;
     }
@@ -3343,7 +3343,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     int idx;
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         goto err_rdma_dest_wait;
     }
 
@@ -3413,13 +3413,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -3428,7 +3428,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
-        if (ret) {
+        if (ret < 0) {
             error_report("rdma: error registering %d control", idx);
             goto err_rdma_dest_wait;
         }
@@ -3446,13 +3446,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -3467,7 +3467,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     rdma->connected = true;
 
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting second control recv");
         goto err_rdma_dest_wait;
     }
@@ -3596,7 +3596,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (rdma->pin_all) {
                 ret = qemu_rdma_reg_whole_ram_blocks(rdma);
-                if (ret) {
+                if (ret < 0) {
                     error_report("rdma migration: error dest "
                                     "registering ram blocks");
                     goto err;
@@ -4057,7 +4057,7 @@ static void rdma_accept_incoming_migration(void *opaque)
     trace_qemu_rdma_accept_incoming_migration();
     ret = qemu_rdma_accept(rdma);
 
-    if (ret) {
+    if (ret < 0) {
         fprintf(stderr, "RDMA ERROR: Migration initialization failed\n");
         return;
     }
@@ -4101,7 +4101,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     }
 
     ret = qemu_rdma_dest_init(rdma, errp);
-    if (ret) {
+    if (ret < 0) {
         goto err;
     }
 
@@ -4109,7 +4109,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 
     ret = rdma_listen(rdma->listen_id, 5);
 
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "listening on socket!");
         goto cleanup_rdma;
     }
@@ -4151,14 +4151,14 @@ void rdma_start_outgoing_migration(void *opaque,
 
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
 
@@ -4173,13 +4173,13 @@ void rdma_start_outgoing_migration(void *opaque,
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


