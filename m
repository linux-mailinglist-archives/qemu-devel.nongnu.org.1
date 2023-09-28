Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3347B1E29
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:25:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwr-0003iB-Hz; Thu, 28 Sep 2023 09:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwS-0003TT-G3
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwM-0008AB-70
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAf9/S0ZojPplmxHbWVyVKT//hV1aoc1NmZNVRvV3+4=;
 b=CpSemj3DKi03kQW6AagnVV4J2qIgCS5aRc0XKw9juXxsFGDxw8pc/4q2RDRBRJSL+6NIxI
 ur8dCfaCuZwx4JGaqzFSEf1vYo7yvTK2ziCup3fCx3bETcoukJRJIztnoU1Uoo4T6XprVt
 hbw1Sn+hir+sYwOVnpK46tH6EmBA7HY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-8mNYuNnVPzeZBIf9RSyT4w-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: 8mNYuNnVPzeZBIf9RSyT4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90A0980C8E4;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 361FA2026D17;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 212C821E6890; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 29/53] migration/rdma: Check negative error values the same
 way everywhere
Date: Thu, 28 Sep 2023 15:19:55 +0200
Message-ID: <20230928132019.2544702-30-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
index 2af9395696..c57692e5a3 100644
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
@@ -1909,7 +1909,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      */
     if (resp) {
         ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_DATA);
-        if (ret) {
+        if (ret < 0) {
             error_report("rdma migration: error posting"
                     " extra control recv for anticipated result!");
             return -1;
@@ -1920,7 +1920,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      * Post a WR to replace the one we just consumed for the READY message.
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting first control recv!");
         return -1;
     }
@@ -2007,7 +2007,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
      * Post a new RECV work request to replace the one we just consumed.
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting second control recv!");
         return -1;
     }
@@ -2337,7 +2337,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
         ret = qemu_rdma_write_flush(f, rdma);
-        if (ret) {
+        if (ret < 0) {
             return -1;
         }
         rdma->current_length = 0;
@@ -2467,12 +2467,12 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
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
@@ -2480,7 +2480,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     }
 
     ret = qemu_rdma_alloc_qp(rdma);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "rdma migration: error allocating qp!");
         goto err_rdma_source_init;
     }
@@ -2497,7 +2497,7 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
-        if (ret) {
+        if (ret < 0) {
             ERROR(errp, "rdma migration: error registering %d control!",
                                                             idx);
             goto err_rdma_source_init;
@@ -2571,13 +2571,13 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
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
@@ -2591,7 +2591,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
             ERROR(errp, "failed to get cm event");
         }
     }
-    if (ret) {
+    if (ret < 0) {
         /*
          * FIXME perror() is wrong, because
          * qemu_get_cm_event_timeout() can fail without setting errno.
@@ -2664,7 +2664,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &listen_id, NULL, RDMA_PS_TCP);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "could not create cm_id!");
         goto err_dest_init_create_listen_id;
     }
@@ -2680,7 +2680,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     ret = rdma_set_option(listen_id, RDMA_OPTION_ID, RDMA_OPTION_ID_REUSEADDR,
                           &reuse, sizeof reuse);
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "Error: could not set REUSEADDR option");
         goto err_dest_init_bind_addr;
     }
@@ -2689,12 +2689,12 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
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
@@ -3334,7 +3334,7 @@ static void rdma_cm_poll_handler(void *opaque)
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         error_report("get_cm_event failed %d", errno);
         return;
     }
@@ -3374,7 +3374,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     int idx;
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret) {
+    if (ret < 0) {
         goto err_rdma_dest_wait;
     }
 
@@ -3444,13 +3444,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -3459,7 +3459,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
-        if (ret) {
+        if (ret < 0) {
             error_report("rdma: error registering %d control", idx);
             goto err_rdma_dest_wait;
         }
@@ -3477,13 +3477,13 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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
@@ -3498,7 +3498,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     rdma->connected = true;
 
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
-    if (ret) {
+    if (ret < 0) {
         error_report("rdma migration: error posting second control recv");
         goto err_rdma_dest_wait;
     }
@@ -3627,7 +3627,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (rdma->pin_all) {
                 ret = qemu_rdma_reg_whole_ram_blocks(rdma);
-                if (ret) {
+                if (ret < 0) {
                     error_report("rdma migration: error dest "
                                     "registering ram blocks");
                     goto err;
@@ -4088,7 +4088,7 @@ static void rdma_accept_incoming_migration(void *opaque)
     trace_qemu_rdma_accept_incoming_migration();
     ret = qemu_rdma_accept(rdma);
 
-    if (ret) {
+    if (ret < 0) {
         fprintf(stderr, "RDMA ERROR: Migration initialization failed\n");
         return;
     }
@@ -4132,7 +4132,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     }
 
     ret = qemu_rdma_dest_init(rdma, errp);
-    if (ret) {
+    if (ret < 0) {
         goto err;
     }
 
@@ -4140,7 +4140,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
 
     ret = rdma_listen(rdma->listen_id, 5);
 
-    if (ret) {
+    if (ret < 0) {
         ERROR(errp, "listening on socket!");
         goto cleanup_rdma;
     }
@@ -4182,14 +4182,14 @@ void rdma_start_outgoing_migration(void *opaque,
 
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
 
@@ -4204,13 +4204,13 @@ void rdma_start_outgoing_migration(void *opaque,
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


