Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C97A4B48
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:49:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFTI-0003YT-N3; Mon, 18 Sep 2023 10:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSO-00030e-9I
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bM-Qq
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+kR7wA8Z1+2AA5LRtU9j3o2Sy/Y0eHC9q/nH7PbZOs=;
 b=Kv7xe1qR0csWGBQU1EIjXiEe1gqCq4yCYf0IoTezhDg41EDEIrxg6Y7QOldAl6yl6qHIpw
 k2YDvBlyiLOXbf9WWZtRbDMjITNzR8UNu+rWHJkXMfAFY3zjMr9Qs2tTehOHrke8YmOFYj
 vbCRXIvCSu/3CaXub0c4DNfJ3h0bMek=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-Y4zHFK4fP1Wea0tYiNIupw-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: Y4zHFK4fP1Wea0tYiNIupw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A3DC29AA3BF
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B72C4A9B13
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 314CF21E6887; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 25/52] migration/rdma: Dumb down remaining int error values to
 -1
Date: Mon, 18 Sep 2023 16:41:39 +0200
Message-ID: <20230918144206.560120-26-armbru@redhat.com>
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

This is just to make the error value more obvious.  Callers don't
mind.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d0af258468..ad314cc10a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1418,7 +1418,7 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
         ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
                                 &resp, NULL, NULL);
         if (ret < 0) {
-            return ret;
+            return -1;
         }
 
         trace_qemu_rdma_unregister_waiting_complete(chunk);
@@ -1459,7 +1459,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
 
     if (ret < 0) {
         error_report("ibv_poll_cq failed");
-        return ret;
+        return -1;
     }
 
     wr_id = wc.wr_id & RDMA_WRID_TYPE_MASK;
@@ -1633,7 +1633,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
     while (wr_id != wrid_requested) {
         ret = qemu_rdma_poll(rdma, poll_cq, &wr_id_in, byte_len);
         if (ret < 0) {
-            return ret;
+            return -1;
         }
 
         wr_id = wr_id_in & RDMA_WRID_TYPE_MASK;
@@ -1702,7 +1702,7 @@ err_block_for_wrid:
     }
 
     rdma->error_state = ret;
-    return ret;
+    return -1;
 }
 
 /*
@@ -1757,9 +1757,10 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
     ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_SEND_CONTROL, NULL);
     if (ret < 0) {
         error_report("rdma migration: send polling control error");
+        return -1;
     }
 
-    return ret;
+    return 0;
 }
 
 /*
@@ -1801,7 +1802,7 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
 
     if (ret < 0) {
         error_report("rdma migration: recv polling control error!");
-        return ret;
+        return -1;
     }
 
     network_to_control((void *) rdma->wr_data[idx].control);
@@ -1879,7 +1880,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
         ret = qemu_rdma_exchange_get_response(rdma,
                                     &resp, RDMA_CONTROL_READY, RDMA_WRID_READY);
         if (ret < 0) {
-            return ret;
+            return -1;
         }
     }
 
@@ -1891,7 +1892,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
         if (ret) {
             error_report("rdma migration: error posting"
                     " extra control recv for anticipated result!");
-            return ret;
+            return -1;
         }
     }
 
@@ -1901,7 +1902,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret) {
         error_report("rdma migration: error posting first control recv!");
-        return ret;
+        return -1;
     }
 
     /*
@@ -1911,7 +1912,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 
     if (ret < 0) {
         error_report("Failed to send control buffer!");
-        return ret;
+        return -1;
     }
 
     /*
@@ -1922,7 +1923,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
             trace_qemu_rdma_exchange_send_issue_callback();
             ret = callback(rdma);
             if (ret < 0) {
-                return ret;
+                return -1;
             }
         }
 
@@ -1931,7 +1932,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                               resp->type, RDMA_WRID_DATA);
 
         if (ret < 0) {
-            return ret;
+            return -1;
         }
 
         qemu_rdma_move_header(rdma, RDMA_WRID_DATA, resp);
@@ -1967,7 +1968,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
 
     if (ret < 0) {
         error_report("Failed to send control buffer!");
-        return ret;
+        return -1;
     }
 
     /*
@@ -1977,7 +1978,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
                                           expecting, RDMA_WRID_READY);
 
     if (ret < 0) {
-        return ret;
+        return -1;
     }
 
     qemu_rdma_move_header(rdma, RDMA_WRID_READY, head);
@@ -1988,7 +1989,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret) {
         error_report("rdma migration: error posting second control recv!");
-        return ret;
+        return -1;
     }
 
     return 0;
@@ -2061,7 +2062,7 @@ retry:
                     "block %d chunk %" PRIu64
                     " current %" PRIu64 " len %" PRIu64 " %d",
                     current_index, chunk, sge.addr, length, rdma->nb_sent);
-            return ret;
+            return -1;
         }
     }
 
@@ -2119,7 +2120,7 @@ retry:
             ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
                                     &resp, &reg_result_idx, NULL);
             if (ret < 0) {
-                return ret;
+                return -1;
             }
 
             /* try to overlap this single registration with the one we sent. */
@@ -2193,7 +2194,7 @@ retry:
         if (ret < 0) {
             error_report("rdma migration: failed to make "
                          "room in full send queue!");
-            return ret;
+            return -1;
         }
 
         goto retry;
@@ -2230,7 +2231,7 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
             rdma->current_index, rdma->current_addr, rdma->current_length);
 
     if (ret < 0) {
-        return ret;
+        return -1;
     }
 
     if (ret == 0) {
@@ -2312,7 +2313,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
     if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
         ret = qemu_rdma_write_flush(f, rdma);
         if (ret) {
-            return ret;
+            return -1;
         }
         rdma->current_length = 0;
         rdma->current_addr = current_addr;
@@ -3485,7 +3486,7 @@ err_rdma_dest_wait:
     rdma->error_state = ret;
     qemu_rdma_cleanup(rdma);
     g_free(rdma_return_path);
-    return ret;
+    return -1;
 }
 
 static int dest_ram_sort_func(const void *a, const void *b)
-- 
2.41.0


