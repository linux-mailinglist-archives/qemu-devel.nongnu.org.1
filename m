Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 981657C4F34
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:38:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRD-0000EA-9N; Wed, 11 Oct 2023 05:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVR7-000893-KZ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVR5-00052Q-Jp
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6MFEnGCFzXsKXFim89lb3xJaqgvpA2Gccn5I75fVenw=;
 b=a7eim1O1ucKrgJMmdGgkoZwmuvLCW7MK9WNt+VSY5pT89Ur9jqUZdQtvlo8Nn5NCZtROQk
 CdPS8GZ2AIdovBIJTev+v1Czd56bxTbwp/ZiPHQhnWNBBx7oX6TfxNSa6KGqFNkB/CyEn3
 F5GXIUWxTqSQc/kUOlW93TsotyCW79Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-iHvdKv-hPpCpXzhTP8UgVg-1; Wed, 11 Oct 2023 05:23:11 -0400
X-MC-Unique: iHvdKv-hPpCpXzhTP8UgVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B6CA1C02163;
 Wed, 11 Oct 2023 09:23:11 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E0781C060B0;
 Wed, 11 Oct 2023 09:23:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 32/65] migration/rdma: Return -1 instead of negative errno code
Date: Wed, 11 Oct 2023 11:21:30 +0200
Message-ID: <20231011092203.1266-33-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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

From: Markus Armbruster <armbru@redhat.com>

Several functions return negative errno codes on failure.  Callers
check for specific codes exactly never.  For some of the functions,
callers couldn't check even if they wanted to, because the functions
also return negative values that aren't errno codes, leaving readers
confused on what the function actually returns.

Clean up and simplify: return -1 instead of negative errno code.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-26-armbru@redhat.com>
---
 migration/rdma.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index dd0b073792..bc39b7ab2e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -863,14 +863,14 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
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
@@ -895,7 +895,7 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
                 ERROR(errp, "You only have RoCE / iWARP devices in your systems"
                             " and your management software has specified '[::]'"
                             ", but IPv6 over RoCE / iWARP is not supported in Linux.");
-                return -ENONET;
+                return -1;
             }
         }
 
@@ -911,13 +911,13 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
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
@@ -1425,7 +1425,7 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
              * this series.
              */
             perror("unregistration chunk failed");
-            return -ret;
+            return -1;
         }
         rdma->total_registrations--;
 
@@ -1570,7 +1570,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                     if (ret) {
                         error_report("failed to get cm event while wait "
                                      "completion channel");
-                        return -EPIPE;
+                        return -1;
                     }
 
                     error_report("receive cm event while wait comp channel,"
@@ -1578,7 +1578,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                     if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
                         cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
                         rdma_ack_cm_event(cm_event);
-                        return -EPIPE;
+                        return -1;
                     }
                     rdma_ack_cm_event(cm_event);
                 }
@@ -1591,18 +1591,18 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
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
     return rdma->error_state;
 }
@@ -1772,7 +1772,7 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
 
     if (ret > 0) {
         error_report("Failed to use post IB SEND for control");
-        return -ret;
+        return -1;
     }
 
     ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_SEND_CONTROL, NULL);
@@ -1841,15 +1841,15 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
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
@@ -2115,7 +2115,7 @@ retry:
                                 (uint8_t *) &comp, NULL, NULL, NULL);
 
                 if (ret < 0) {
-                    return -EIO;
+                    return -1;
                 }
 
                 /*
@@ -2159,7 +2159,7 @@ retry:
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
                 error_report("cannot get lkey");
-                return -EINVAL;
+                return -1;
             }
 
             reg_result = (RDMARegisterResult *)
@@ -2178,7 +2178,7 @@ retry:
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
                 error_report("cannot get lkey!");
-                return -EINVAL;
+                return -1;
             }
         }
 
@@ -2190,7 +2190,7 @@ retry:
                                                      &sge.lkey, NULL, chunk,
                                                      chunk_start, chunk_end)) {
             error_report("cannot get lkey!");
-            return -EINVAL;
+            return -1;
         }
     }
 
@@ -2237,7 +2237,7 @@ retry:
          * in this series.
          */
         perror("rdma migration: post rdma write failed");
-        return -ret;
+        return -1;
     }
 
     set_bit(chunk, block->transit_bitmap);
@@ -2969,14 +2969,14 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
     int ret;
 
     if (qemu_rdma_write_flush(rdma) < 0) {
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


