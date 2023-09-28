Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C107B1E19
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqws-0003jf-UW; Thu, 28 Sep 2023 09:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwU-0003U2-FF
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwN-0008Ca-3k
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iSv0Pu1IwbZy01gFu8V7gIoIIGwmYp2Ct+GrIbCBwN0=;
 b=YikziM38kQFuIbBEmAGUlMdju+1I9H66TR2XbyU4DXQbLdk5TwpNKQukEAIqlmh2yjUS43
 FkNHI4Nkuz7iicBztpBnwpp7YKXQD5QwUFj1/Qxu5hM1NgB4M64Tq2BoMPQBJWNg6ZSoEF
 c7aOSdgkfheK90UdJ8ZuCowuVcl23HA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-549-rqWfNp2YO3uyxxZWhcKRew-1; Thu, 28 Sep 2023 09:20:24 -0400
X-MC-Unique: rqWfNp2YO3uyxxZWhcKRew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D2A33C13930;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 039B72156702;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F99021E6896; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 34/53] migration/rdma: Drop "@errp is clear" guards around
 error_setg()
Date: Thu, 28 Sep 2023 15:20:00 +0200
Message-ID: <20230928132019.2544702-35-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These guards are all redundant now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 164 +++++++++++++++--------------------------------
 1 file changed, 51 insertions(+), 113 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 4fec6dbf86..45e55178a8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -858,10 +858,8 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 
             if (ibv_query_port(verbs, 1, &port_attr)) {
                 ibv_close_device(verbs);
-                if (errp && !*errp) {
-                    error_setg(errp,
-                               "RDMA ERROR: Could not query initial IB port");
-                }
+                error_setg(errp,
+                           "RDMA ERROR: Could not query initial IB port");
                 return -1;
             }
 
@@ -884,12 +882,10 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
                                 " migrate over the IB fabric until the kernel "
                                 " fixes the bug.\n");
             } else {
-                if (errp && !*errp) {
-                    error_setg(errp, "RDMA ERROR: "
-                               "You only have RoCE / iWARP devices in your systems"
-                               " and your management software has specified '[::]'"
-                               ", but IPv6 over RoCE / iWARP is not supported in Linux.");
-                }
+                error_setg(errp, "RDMA ERROR: "
+                           "You only have RoCE / iWARP devices in your systems"
+                           " and your management software has specified '[::]'"
+                           ", but IPv6 over RoCE / iWARP is not supported in Linux.");
                 return -1;
             }
         }
@@ -905,18 +901,14 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 
     /* IB ports start with 1, not 0 */
     if (ibv_query_port(verbs, 1, &port_attr)) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: Could not query initial IB port");
-        }
+        error_setg(errp, "RDMA ERROR: Could not query initial IB port");
         return -1;
     }
 
     if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: "
-                       "Linux kernel's RoCE / iWARP does not support IPv6 "
-                       "(but patches on linux-rdma in progress)");
-        }
+        error_setg(errp, "RDMA ERROR: "
+                   "Linux kernel's RoCE / iWARP does not support IPv6 "
+                   "(but patches on linux-rdma in progress)");
         return -1;
     }
 
@@ -941,27 +933,21 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
     struct rdma_addrinfo *e;
 
     if (rdma->host == NULL || !strcmp(rdma->host, "")) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: RDMA hostname has not been set");
-        }
+        error_setg(errp, "RDMA ERROR: RDMA hostname has not been set");
         return -1;
     }
 
     /* create CM channel */
     rdma->channel = rdma_create_event_channel();
     if (!rdma->channel) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not create CM channel");
-        }
+        error_setg(errp, "RDMA ERROR: could not create CM channel");
         return -1;
     }
 
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &rdma->cm_id, NULL, RDMA_PS_TCP);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not create channel id");
-        }
+        error_setg(errp, "RDMA ERROR: could not create channel id");
         goto err_resolve_create_id;
     }
 
@@ -970,10 +956,8 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
     if (ret) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not rdma_getaddrinfo address %s",
-                       rdma->host);
-        }
+        error_setg(errp, "RDMA ERROR: could not rdma_getaddrinfo address %s",
+                   rdma->host);
         goto err_resolve_get_addr;
     }
 
@@ -1015,18 +999,14 @@ route:
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not perform event_addr_resolved");
-        }
+        error_setg(errp, "RDMA ERROR: could not perform event_addr_resolved");
         goto err_resolve_get_addr;
     }
 
     if (cm_event->event != RDMA_CM_EVENT_ADDR_RESOLVED) {
-        if (errp && !*errp) {
-            error_setg(errp,
-                       "RDMA ERROR: result not equal to event_addr_resolved %s",
-                       rdma_event_str(cm_event->event));
-        }
+        error_setg(errp,
+                   "RDMA ERROR: result not equal to event_addr_resolved %s",
+                   rdma_event_str(cm_event->event));
         error_report("rdma_resolve_addr");
         rdma_ack_cm_event(cm_event);
         goto err_resolve_get_addr;
@@ -1036,25 +1016,19 @@ route:
     /* resolve route */
     ret = rdma_resolve_route(rdma->cm_id, RDMA_RESOLVE_TIMEOUT_MS);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not resolve rdma route");
-        }
+        error_setg(errp, "RDMA ERROR: could not resolve rdma route");
         goto err_resolve_get_addr;
     }
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not perform event_route_resolved");
-        }
+        error_setg(errp, "RDMA ERROR: could not perform event_route_resolved");
         goto err_resolve_get_addr;
     }
     if (cm_event->event != RDMA_CM_EVENT_ROUTE_RESOLVED) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: "
-                       "result not equal to event_route_resolved: %s",
-                       rdma_event_str(cm_event->event));
-        }
+        error_setg(errp, "RDMA ERROR: "
+                   "result not equal to event_route_resolved: %s",
+                   rdma_event_str(cm_event->event));
         rdma_ack_cm_event(cm_event);
         goto err_resolve_get_addr;
     }
@@ -2505,20 +2479,16 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
     ret = qemu_rdma_alloc_pd_cq(rdma);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: "
-                       "rdma migration: error allocating pd and cq! Your mlock()"
-                       " limits may be too low. Please check $ ulimit -a # and "
-                       "search for 'ulimit -l' in the output");
-        }
+        error_setg(errp, "RDMA ERROR: "
+                   "rdma migration: error allocating pd and cq! Your mlock()"
+                   " limits may be too low. Please check $ ulimit -a # and "
+                   "search for 'ulimit -l' in the output");
         goto err_rdma_source_init;
     }
 
     ret = qemu_rdma_alloc_qp(rdma);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: rdma migration: error allocating qp!");
-        }
+        error_setg(errp, "RDMA ERROR: rdma migration: error allocating qp!");
         goto err_rdma_source_init;
     }
 
@@ -2535,11 +2505,9 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
         if (ret < 0) {
-            if (errp && !*errp) {
-                error_setg(errp,
-                           "RDMA ERROR: rdma migration: error registering %d control!",
-                           idx);
-            }
+            error_setg(errp,
+                       "RDMA ERROR: rdma migration: error registering %d control!",
+                       idx);
             goto err_rdma_source_init;
         }
     }
@@ -2567,29 +2535,21 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
     } while (ret < 0 && errno == EINTR);
 
     if (ret == 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: poll cm event timeout");
-        }
+        error_setg(errp, "RDMA ERROR: poll cm event timeout");
         return -1;
     } else if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: failed to poll cm event, errno=%i",
-                       errno);
-        }
+        error_setg(errp, "RDMA ERROR: failed to poll cm event, errno=%i",
+                   errno);
         return -1;
     } else if (poll_fd.revents & POLLIN) {
         if (rdma_get_cm_event(rdma->channel, cm_event) < 0) {
-            if (errp && !*errp) {
-                error_setg(errp, "RDMA ERROR: failed to get cm event");
-            }
+            error_setg(errp, "RDMA ERROR: failed to get cm event");
             return -1;
         }
         return 0;
     } else {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: no POLLIN event, revent=%x",
-                       poll_fd.revents);
-        }
+        error_setg(errp, "RDMA ERROR: no POLLIN event, revent=%x",
+                   poll_fd.revents);
         return -1;
     }
 }
@@ -2622,18 +2582,14 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: posting second control recv");
-        }
+        error_setg(errp, "RDMA ERROR: posting second control recv");
         goto err_rdma_source_connect;
     }
 
     ret = rdma_connect(rdma->cm_id, &conn_param);
     if (ret < 0) {
         perror("rdma_connect");
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: connecting to destination!");
-        }
+        error_setg(errp, "RDMA ERROR: connecting to destination!");
         goto err_rdma_source_connect;
     }
 
@@ -2642,9 +2598,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
     } else {
         ret = rdma_get_cm_event(rdma->channel, &cm_event);
         if (ret < 0) {
-            if (errp && !*errp) {
-                error_setg(errp, "RDMA ERROR: failed to get cm event");
-            }
+            error_setg(errp, "RDMA ERROR: failed to get cm event");
         }
     }
     if (ret < 0) {
@@ -2659,9 +2613,7 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
         error_report("rdma_get_cm_event != EVENT_ESTABLISHED after rdma_connect");
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: connecting to destination!");
-        }
+        error_setg(errp, "RDMA ERROR: connecting to destination!");
         rdma_ack_cm_event(cm_event);
         goto err_rdma_source_connect;
     }
@@ -2709,18 +2661,14 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
     }
 
     if (!rdma->host || !rdma->host[0]) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: RDMA host is not set!");
-        }
+        error_setg(errp, "RDMA ERROR: RDMA host is not set!");
         rdma->errored = true;
         return -1;
     }
     /* create CM channel */
     rdma->channel = rdma_create_event_channel();
     if (!rdma->channel) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not create rdma event channel");
-        }
+        error_setg(errp, "RDMA ERROR: could not create rdma event channel");
         rdma->errored = true;
         return -1;
     }
@@ -2728,9 +2676,7 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &listen_id, NULL, RDMA_PS_TCP);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not create cm_id!");
-        }
+        error_setg(errp, "RDMA ERROR: could not create cm_id!");
         goto err_dest_init_create_listen_id;
     }
 
@@ -2739,19 +2685,15 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
     if (ret) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: could not rdma_getaddrinfo address %s",
-                       rdma->host);
-        }
+        error_setg(errp, "RDMA ERROR: could not rdma_getaddrinfo address %s",
+                   rdma->host);
         goto err_dest_init_bind_addr;
     }
 
     ret = rdma_set_option(listen_id, RDMA_OPTION_ID, RDMA_OPTION_ID_REUSEADDR,
                           &reuse, sizeof reuse);
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: Error: could not set REUSEADDR option");
-        }
+        error_setg(errp, "RDMA ERROR: Error: could not set REUSEADDR option");
         goto err_dest_init_bind_addr;
     }
 
@@ -2835,10 +2777,8 @@ static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
         rdma->host = g_strdup(addr->host);
         rdma->host_port = g_strdup(host_port);
     } else {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: bad RDMA migration address '%s'",
-                       host_port);
-        }
+        error_setg(errp, "RDMA ERROR: bad RDMA migration address '%s'",
+                   host_port);
         g_free(rdma);
         rdma = NULL;
     }
@@ -4224,9 +4164,7 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     ret = rdma_listen(rdma->listen_id, 5);
 
     if (ret < 0) {
-        if (errp && !*errp) {
-            error_setg(errp, "RDMA ERROR: listening on socket!");
-        }
+        error_setg(errp, "RDMA ERROR: listening on socket!");
         goto cleanup_rdma;
     }
 
-- 
2.41.0


