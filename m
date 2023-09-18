Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E954E7A4B38
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSW-00035f-EM; Mon, 18 Sep 2023 10:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSO-00030j-Cz
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002aw-Qz
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A/pQwlA5/88DqjoZAaKjQ6Z2V9aa+vA72DV9LshQIek=;
 b=YYQugAerQwfYzuOtBf0WnLzNY/JS70glkQeu2aAOWocSZ9R3alKV8ttVnyNAL+y5FLUKF3
 gq6qMWu5Q5SGg/KMpnkUz4JgAgA4hByAKGfz0nSC/pvFrfoBYG+Zc2zXK/c5tyrTxyROXL
 klBEcg98S+gnKeWL0YBHzjFnNIbACI0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-sRu-9fazOmqA_RMRnN4ULw-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: sRu-9fazOmqA_RMRnN4ULw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6326E3C0E440
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2521A492C37
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E35C21E6886; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 24/52] migration/rdma: Return -1 instead of negative errno code
Date: Mon, 18 Sep 2023 16:41:38 +0200
Message-ID: <20230918144206.560120-25-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Several functions return negative errno codes on failure.  Callers
check for specific codes exactly never.  For some of the functions,
callers couldn't check even if they wanted to, because the functions
also return negative values that aren't errno codes, leaving readers
confused on what the function actually returns.

Clean up and simplify: return -1 instead of negative errno code.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index efbb3c7754..d0af258468 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -857,14 +857,14 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
                 } else {
                     error_setg_errno(errp, errno,
                                      "could not open RDMA device context");
-                    return -EINVAL;
+                    return -1;
                 }
             }
 
             if (ibv_query_port(verbs, 1, &port_attr)) {
                 ibv_close_device(verbs);
                 ERROR(errp, "Could not query initial IB port");
-                return -EINVAL;
+                return -1;
             }
 
             if (port_attr.link_layer == IBV_LINK_LAYER_INFINIBAND) {
@@ -889,7 +889,7 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
                 ERROR(errp, "You only have RoCE / iWARP devices in your systems"
                             " and your management software has specified '[::]'"
                             ", but IPv6 over RoCE / iWARP is not supported in Linux.");
-                return -ENONET;
+                return -1;
             }
         }
 
@@ -905,13 +905,13 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
     /* IB ports start with 1, not 0 */
     if (ibv_query_port(verbs, 1, &port_attr)) {
         ERROR(errp, "Could not query initial IB port");
-        return -EINVAL;
+        return -1;
     }
 
     if (port_attr.link_layer == IBV_LINK_LAYER_ETHERNET) {
         ERROR(errp, "Linux kernel's RoCE / iWARP does not support IPv6 "
                     "(but patches on linux-rdma in progress)");
-        return -ENONET;
+        return -1;
     }
 
 #endif
@@ -1409,7 +1409,7 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
 
         if (ret != 0) {
             perror("unregistration chunk failed");
-            return -ret;
+            return -1;
         }
         rdma->total_registrations--;
 
@@ -1554,7 +1554,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                     if (ret) {
                         error_report("failed to get cm event while wait "
                                      "completion channel");
-                        return -EPIPE;
+                        return -1;
                     }
 
                     error_report("receive cm event while wait comp channel,"
@@ -1562,7 +1562,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                     if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
                         cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
                         rdma_ack_cm_event(cm_event);
-                        return -EPIPE;
+                        return -1;
                     }
                     rdma_ack_cm_event(cm_event);
                 }
@@ -1575,18 +1575,18 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                       * I don't trust errno from qemu_poll_ns
                      */
                 error_report("%s: poll failed", __func__);
-                return -EPIPE;
+                return -1;
             }
 
             if (migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) {
                 /* Bail out and let the cancellation happen */
-                return -EPIPE;
+                return -1;
             }
         }
     }
 
     if (rdma->received_error) {
-        return -EPIPE;
+        return -1;
     }
     return -!!rdma->error_state;
 }
@@ -1751,7 +1751,7 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
 
     if (ret > 0) {
         error_report("Failed to use post IB SEND for control");
-        return -ret;
+        return -1;
     }
 
     ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_SEND_CONTROL, NULL);
@@ -1820,15 +1820,15 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
         if (head->type == RDMA_CONTROL_ERROR) {
             rdma->received_error = true;
         }
-        return -EIO;
+        return -1;
     }
     if (head->len > RDMA_CONTROL_MAX_BUFFER - sizeof(*head)) {
         error_report("too long length: %d", head->len);
-        return -EINVAL;
+        return -1;
     }
     if (sizeof(*head) + head->len != byte_len) {
         error_report("Malformed length: %d byte_len %d", head->len, byte_len);
-        return -EINVAL;
+        return -1;
     }
 
     return 0;
@@ -2092,7 +2092,7 @@ retry:
                                 (uint8_t *) &comp, NULL, NULL, NULL);
 
                 if (ret < 0) {
-                    return -EIO;
+                    return -1;
                 }
 
                 stat64_add(&mig_stats.zero_pages,
@@ -2127,7 +2127,7 @@ retry:
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
                 error_report("cannot get lkey");
-                return -EINVAL;
+                return -1;
             }
 
             reg_result = (RDMARegisterResult *)
@@ -2146,7 +2146,7 @@ retry:
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
                 error_report("cannot get lkey!");
-                return -EINVAL;
+                return -1;
             }
         }
 
@@ -2158,7 +2158,7 @@ retry:
                                                      &sge.lkey, NULL, chunk,
                                                      chunk_start, chunk_end)) {
             error_report("cannot get lkey!");
-            return -EINVAL;
+            return -1;
         }
     }
 
@@ -2200,7 +2200,7 @@ retry:
 
     } else if (ret > 0) {
         perror("rdma migration: post rdma write failed");
-        return -ret;
+        return -1;
     }
 
     set_bit(chunk, block->transit_bitmap);
@@ -2920,14 +2920,14 @@ static int qemu_rdma_drain_cq(QEMUFile *f, RDMAContext *rdma)
     int ret;
 
     if (qemu_rdma_write_flush(f, rdma) < 0) {
-        return -EIO;
+        return -1;
     }
 
     while (rdma->nb_sent) {
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
             error_report("rdma migration: complete polling error!");
-            return -EIO;
+            return -1;
         }
     }
 
-- 
2.41.0


