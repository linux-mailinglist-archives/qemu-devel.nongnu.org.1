Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4557D7A4B32
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFT1-0003EH-08; Mon, 18 Sep 2023 10:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSN-0002yF-H9
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bR-O5
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnBjhSC/3GPfyTVkp9EdCLWua8G5Rk0xH3nuRyXXXFs=;
 b=hFXm/sc3oT2V/aVkPpgNnznu2nvJiKcLl/BiaZjnHiPYT4+GC6hKOv0Fgms3zuhEMCr4u+
 ubAA8anW8znW/QO+JjvbbnA4+/HDS3/N8hOVW61z8EipW+JizfW5+M1G7nK1csq8Z2tf6S
 xaSV2Sq/RC+gT88m/r3xuTwzV0GF2fg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-tW5FmdM2O-2IkGSNdnT6YQ-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: tW5FmdM2O-2IkGSNdnT6YQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 947093800BB6
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 397854011E4
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 42C1121E6893; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 31/52] migration/rdma: Retire macro ERROR()
Date: Mon, 18 Sep 2023 16:41:45 +0200
Message-ID: <20230918144206.560120-32-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

ERROR() has become "error_setg() unless an error has been set
already".  Hiding the conditional in the macro is in the way of
further work.  Replace the macro uses by their expansion, and delete
the macro.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 168 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 120 insertions(+), 48 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index be31694d4f..df5b3a8e2c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -40,13 +40,6 @@
 #include "options.h"
 #include <poll.h>
 
-#define ERROR(errp, fmt, ...) \
-    do { \
-        if (errp && (*(errp) == NULL)) { \
-            error_setg(errp, "RDMA ERROR: " fmt, ## __VA_ARGS__); \
-        } \
-    } while (0)
-
 #define RDMA_RESOLVE_TIMEOUT_MS 10000
 
 /* Do not merge data if larger than this. */
@@ -859,7 +852,10 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 
             if (ibv_query_port(verbs, 1, &port_attr)) {
                 ibv_close_device(verbs);
-                ERROR(errp, "Could not query initial IB port");
+                if (errp && !*errp) {
+                    error_setg(errp,
+                               "RDMA ERROR: Could not query initial IB port");
+                }
                 return -1;
             }
 
@@ -882,9 +878,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
                                 " migrate over the IB fabric until the kernel "
                                 " fixes the bug.\n");
             } else {
-                ERROR(errp, "You only have RoCE / iWARP devices in your systems"
-                            " and your management software has specified '[::]'"
-                            ", but IPv6 over RoCE / iWARP is not supported in Linux.");
+                if (errp && !*errp) {
+                    error_setg(errp, "RDMA ERROR: "
+                               "You only have RoCE / iWARP devices in your systems"
+                               " and your management software has specified '[::]'"
+                               ", but IPv6 over RoCE / iWARP is not supported in Linux.");
+                }
                 return -1;
             }
         }
@@ -900,13 +899,18 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
 
     /* IB ports start with 1, not 0 */
     if (ibv_query_port(verbs, 1, &port_attr)) {
-        ERROR(errp, "Could not query initial IB port");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: Could not query initial IB port");
+        }
         return -1;
     }
 
     if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
-        ERROR(errp, "Linux kernel's RoCE / iWARP does not support IPv6 "
-                    "(but patches on linux-rdma in progress)");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: "
+                       "Linux kernel's RoCE / iWARP does not support IPv6 "
+                       "(but patches on linux-rdma in progress)");
+        }
         return -1;
     }
 
@@ -930,21 +934,27 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
     struct rdma_addrinfo *e;
 
     if (rdma->host == NULL || !strcmp(rdma->host, "")) {
-        ERROR(errp, "RDMA hostname has not been set");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: RDMA hostname has not been set");
+        }
         return -1;
     }
 
     /* create CM channel */
     rdma->channel = rdma_create_event_channel();
     if (!rdma->channel) {
-        ERROR(errp, "could not create CM channel");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not create CM channel");
+        }
         return -1;
     }
 
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &rdma->cm_id, NULL, RDMA_PS_TCP);
     if (ret < 0) {
-        ERROR(errp, "could not create channel id");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not create channel id");
+        }
         goto err_resolve_create_id;
     }
 
@@ -953,7 +963,10 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
     if (ret) {
-        ERROR(errp, "could not rdma_getaddrinfo address %s", rdma->host);
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not rdma_getaddrinfo address %s",
+                       rdma->host);
+        }
         goto err_resolve_get_addr;
     }
 
@@ -976,7 +989,10 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
     }
 
     rdma_freeaddrinfo(res);
-    ERROR(errp, "could not resolve address %s", rdma->host);
+    if (errp && !*errp) {
+        error_setg(errp, "RDMA ERROR: could not resolve address %s",
+                   rdma->host);
+    }
     goto err_resolve_get_addr;
 
 route:
@@ -985,13 +1001,18 @@ route:
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
     if (ret < 0) {
-        ERROR(errp, "could not perform event_addr_resolved");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not perform event_addr_resolved");
+        }
         goto err_resolve_get_addr;
     }
 
     if (cm_event->event != RDMA_CM_EVENT_ADDR_RESOLVED) {
-        ERROR(errp, "result not equal to event_addr_resolved %s",
-                rdma_event_str(cm_event->event));
+        if (errp && !*errp) {
+            error_setg(errp,
+                       "RDMA ERROR: result not equal to event_addr_resolved %s",
+                       rdma_event_str(cm_event->event));
+        }
         error_report("rdma_resolve_addr");
         rdma_ack_cm_event(cm_event);
         goto err_resolve_get_addr;
@@ -1001,18 +1022,25 @@ route:
     /* resolve route */
     ret = rdma_resolve_route(rdma->cm_id, RDMA_RESOLVE_TIMEOUT_MS);
     if (ret < 0) {
-        ERROR(errp, "could not resolve rdma route");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not resolve rdma route");
+        }
         goto err_resolve_get_addr;
     }
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
     if (ret < 0) {
-        ERROR(errp, "could not perform event_route_resolved");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not perform event_route_resolved");
+        }
         goto err_resolve_get_addr;
     }
     if (cm_event->event != RDMA_CM_EVENT_ROUTE_RESOLVED) {
-        ERROR(errp, "result not equal to event_route_resolved: %s",
-                        rdma_event_str(cm_event->event));
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: "
+                       "result not equal to event_route_resolved: %s",
+                       rdma_event_str(cm_event->event));
+        }
         rdma_ack_cm_event(cm_event);
         goto err_resolve_get_addr;
     }
@@ -2443,15 +2471,20 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
 
     ret = qemu_rdma_alloc_pd_cq(rdma);
     if (ret < 0) {
-        ERROR(errp, "rdma migration: error allocating pd and cq! Your mlock()"
-                    " limits may be too low. Please check $ ulimit -a # and "
-                    "search for 'ulimit -l' in the output");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: "
+                       "rdma migration: error allocating pd and cq! Your mlock()"
+                       " limits may be too low. Please check $ ulimit -a # and "
+                       "search for 'ulimit -l' in the output");
+        }
         goto err_rdma_source_init;
     }
 
     ret = qemu_rdma_alloc_qp(rdma);
     if (ret < 0) {
-        ERROR(errp, "rdma migration: error allocating qp!");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: rdma migration: error allocating qp!");
+        }
         goto err_rdma_source_init;
     }
 
@@ -2468,8 +2501,11 @@ static int qemu_rdma_source_init(RDMAContext *rdma, bool pin_all, Error **errp)
     for (idx = 0; idx < RDMA_WRID_MAX; idx++) {
         ret = qemu_rdma_reg_control(rdma, idx);
         if (ret < 0) {
-            ERROR(errp, "rdma migration: error registering %d control!",
-                                                            idx);
+            if (errp && !*errp) {
+                error_setg(errp,
+                           "RDMA ERROR: rdma migration: error registering %d control!",
+                           idx);
+            }
             goto err_rdma_source_init;
         }
     }
@@ -2497,19 +2533,29 @@ static int qemu_get_cm_event_timeout(RDMAContext *rdma,
     } while (ret < 0 && errno == EINTR);
 
     if (ret == 0) {
-        ERROR(errp, "poll cm event timeout");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: poll cm event timeout");
+        }
         return -1;
     } else if (ret < 0) {
-        ERROR(errp, "failed to poll cm event, errno=%i", errno);
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: failed to poll cm event, errno=%i",
+                       errno);
+        }
         return -1;
     } else if (poll_fd.revents & POLLIN) {
         if (rdma_get_cm_event(rdma->channel, cm_event) < 0) {
-            ERROR(errp, "failed to get cm event");
+            if (errp && !*errp) {
+                error_setg(errp, "RDMA ERROR: failed to get cm event");
+            }
             return -1;
         }
         return 0;
     } else {
-        ERROR(errp, "no POLLIN event, revent=%x", poll_fd.revents);
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: no POLLIN event, revent=%x",
+                       poll_fd.revents);
+        }
         return -1;
     }
 }
@@ -2542,14 +2588,18 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret < 0) {
-        ERROR(errp, "posting second control recv");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: posting second control recv");
+        }
         goto err_rdma_source_connect;
     }
 
     ret = rdma_connect(rdma->cm_id, &conn_param);
     if (ret < 0) {
         perror("rdma_connect");
-        ERROR(errp, "connecting to destination!");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: connecting to destination!");
+        }
         goto err_rdma_source_connect;
     }
 
@@ -2558,7 +2608,9 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
     } else {
         ret = rdma_get_cm_event(rdma->channel, &cm_event);
         if (ret < 0) {
-            ERROR(errp, "failed to get cm event");
+            if (errp && !*errp) {
+                error_setg(errp, "RDMA ERROR: failed to get cm event");
+            }
         }
     }
     if (ret < 0) {
@@ -2568,7 +2620,9 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
         error_report("rdma_get_cm_event != EVENT_ESTABLISHED after rdma_connect");
-        ERROR(errp, "connecting to destination!");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: connecting to destination!");
+        }
         rdma_ack_cm_event(cm_event);
         goto err_rdma_source_connect;
     }
@@ -2615,14 +2669,18 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
     }
 
     if (!rdma->host || !rdma->host[0]) {
-        ERROR(errp, "RDMA host is not set!");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: RDMA host is not set!");
+        }
         rdma->errored = true;
         return -1;
     }
     /* create CM channel */
     rdma->channel = rdma_create_event_channel();
     if (!rdma->channel) {
-        ERROR(errp, "could not create rdma event channel");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not create rdma event channel");
+        }
         rdma->errored = true;
         return -1;
     }
@@ -2630,7 +2688,9 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
     /* create CM id */
     ret = rdma_create_id(rdma->channel, &listen_id, NULL, RDMA_PS_TCP);
     if (ret < 0) {
-        ERROR(errp, "could not create cm_id!");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not create cm_id!");
+        }
         goto err_dest_init_create_listen_id;
     }
 
@@ -2639,14 +2699,19 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     ret = rdma_getaddrinfo(rdma->host, port_str, NULL, &res);
     if (ret) {
-        ERROR(errp, "could not rdma_getaddrinfo address %s", rdma->host);
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: could not rdma_getaddrinfo address %s",
+                       rdma->host);
+        }
         goto err_dest_init_bind_addr;
     }
 
     ret = rdma_set_option(listen_id, RDMA_OPTION_ID, RDMA_OPTION_ID_REUSEADDR,
                           &reuse, sizeof reuse);
     if (ret < 0) {
-        ERROR(errp, "Error: could not set REUSEADDR option");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: Error: could not set REUSEADDR option");
+        }
         goto err_dest_init_bind_addr;
     }
     for (e = res; e != NULL; e = e->ai_next) {
@@ -2668,7 +2733,9 @@ static int qemu_rdma_dest_init(RDMAContext *rdma, Error **errp)
 
     rdma_freeaddrinfo(res);
     if (!e) {
-        ERROR(errp, "Error: could not rdma_bind_addr!");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: Error: could not rdma_bind_addr!");
+        }
         goto err_dest_init_bind_addr;
     }
 
@@ -2720,7 +2787,10 @@ static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
         rdma->host = g_strdup(addr->host);
         rdma->host_port = g_strdup(host_port);
     } else {
-        ERROR(errp, "bad RDMA migration address '%s'", host_port);
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: bad RDMA migration address '%s'",
+                       host_port);
+        }
         g_free(rdma);
         rdma = NULL;
     }
@@ -4106,7 +4176,9 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     ret = rdma_listen(rdma->listen_id, 5);
 
     if (ret < 0) {
-        ERROR(errp, "listening on socket!");
+        if (errp && !*errp) {
+            error_setg(errp, "RDMA ERROR: listening on socket!");
+        }
         goto cleanup_rdma;
     }
 
-- 
2.41.0


