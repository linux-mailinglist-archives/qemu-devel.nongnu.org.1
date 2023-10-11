Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D78B07C4EE0
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVR6-0007yf-RI; Wed, 11 Oct 2023 05:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVR1-0007UJ-Ne
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVQz-00051W-VO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvsfYGfmwCFyIS+RjP11n8JHWwLT4mAxwdk4+3EtsCY=;
 b=ZaYXeVyTBrKnKslkF8sRs6v5Uo35TMmJeZZbXexqy4+/0PUEIkYkRr03wCcBlDrBcEIAjw
 0dWh2Ij08zBcXw0E4p5hUPxxPCryqmZC5eeyQ9QoI15gWLvAyL1IQ2olFRyeiEqpzKdrDX
 3//hTY8NjynS9eBz5mnqdRnhMzainFg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-aplKE1zpO1iyQeWDu8ZDEw-1; Wed, 11 Oct 2023 05:23:13 -0400
X-MC-Unique: aplKE1zpO1iyQeWDu8ZDEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A59D3814587;
 Wed, 11 Oct 2023 09:23:13 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 808C51C060AE;
 Wed, 11 Oct 2023 09:23:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 33/65] migration/rdma: Dumb down remaining int error values to
 -1
Date: Wed, 11 Oct 2023 11:21:31 +0200
Message-ID: <20231011092203.1266-34-quintela@redhat.com>
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

This is just to make the error value more obvious.  Callers don't
mind.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-27-armbru@redhat.com>
---
 migration/rdma.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index bc39b7ab2e..3c7518d65a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1434,7 +1434,7 @@ static int qemu_rdma_unregister_waiting(RDMAContext *rdma)
         ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
                                 &resp, NULL, NULL);
         if (ret < 0) {
-            return ret;
+            return -1;
         }
 
         trace_qemu_rdma_unregister_waiting_complete(chunk);
@@ -1475,7 +1475,7 @@ static int qemu_rdma_poll(RDMAContext *rdma, struct ibv_cq *cq,
 
     if (ret < 0) {
         error_report("ibv_poll_cq failed");
-        return ret;
+        return -1;
     }
 
     wr_id = wc.wr_id & RDMA_WRID_TYPE_MASK;
@@ -1604,7 +1604,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
     if (rdma->received_error) {
         return -1;
     }
-    return rdma->error_state;
+    return -!!rdma->error_state;
 }
 
 static struct ibv_comp_channel *to_channel(RDMAContext *rdma, uint64_t wrid)
@@ -1649,7 +1649,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
     while (wr_id != wrid_requested) {
         ret = qemu_rdma_poll(rdma, poll_cq, &wr_id_in, byte_len);
         if (ret < 0) {
-            return ret;
+            return -1;
         }
 
         wr_id = wr_id_in & RDMA_WRID_TYPE_MASK;
@@ -1723,7 +1723,7 @@ err_block_for_wrid:
     }
 
     rdma->error_state = ret;
-    return ret;
+    return -1;
 }
 
 /*
@@ -1778,9 +1778,10 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
     ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_SEND_CONTROL, NULL);
     if (ret < 0) {
         error_report("rdma migration: send polling control error");
+        return -1;
     }
 
-    return ret;
+    return 0;
 }
 
 /*
@@ -1822,7 +1823,7 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
 
     if (ret < 0) {
         error_report("rdma migration: recv polling control error!");
-        return ret;
+        return -1;
     }
 
     network_to_control((void *) rdma->wr_data[idx].control);
@@ -1902,7 +1903,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                               RDMA_CONTROL_READY,
                                               RDMA_WRID_READY);
         if (ret < 0) {
-            return ret;
+            return -1;
         }
     }
 
@@ -1914,7 +1915,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
         if (ret) {
             error_report("rdma migration: error posting"
                     " extra control recv for anticipated result!");
-            return ret;
+            return -1;
         }
     }
 
@@ -1924,7 +1925,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret) {
         error_report("rdma migration: error posting first control recv!");
-        return ret;
+        return -1;
     }
 
     /*
@@ -1934,7 +1935,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 
     if (ret < 0) {
         error_report("Failed to send control buffer!");
-        return ret;
+        return -1;
     }
 
     /*
@@ -1945,7 +1946,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
             trace_qemu_rdma_exchange_send_issue_callback();
             ret = callback(rdma);
             if (ret < 0) {
-                return ret;
+                return -1;
             }
         }
 
@@ -1954,7 +1955,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                               resp->type, RDMA_WRID_DATA);
 
         if (ret < 0) {
-            return ret;
+            return -1;
         }
 
         qemu_rdma_move_header(rdma, RDMA_WRID_DATA, resp);
@@ -1990,7 +1991,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
 
     if (ret < 0) {
         error_report("Failed to send control buffer!");
-        return ret;
+        return -1;
     }
 
     /*
@@ -2000,7 +2001,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
                                           expecting, RDMA_WRID_READY);
 
     if (ret < 0) {
-        return ret;
+        return -1;
     }
 
     qemu_rdma_move_header(rdma, RDMA_WRID_READY, head);
@@ -2011,7 +2012,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret) {
         error_report("rdma migration: error posting second control recv!");
-        return ret;
+        return -1;
     }
 
     return 0;
@@ -2084,7 +2085,7 @@ retry:
                     "block %d chunk %" PRIu64
                     " current %" PRIu64 " len %" PRIu64 " %d",
                     current_index, chunk, sge.addr, length, rdma->nb_sent);
-            return ret;
+            return -1;
         }
     }
 
@@ -2151,7 +2152,7 @@ retry:
             ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
                                     &resp, &reg_result_idx, NULL);
             if (ret < 0) {
-                return ret;
+                return -1;
             }
 
             /* try to overlap this single registration with the one we sent. */
@@ -2225,7 +2226,7 @@ retry:
         if (ret < 0) {
             error_report("rdma migration: failed to make "
                          "room in full send queue!");
-            return ret;
+            return -1;
         }
 
         goto retry;
@@ -2276,7 +2277,7 @@ static int qemu_rdma_write_flush(RDMAContext *rdma)
             rdma->current_index, rdma->current_addr, rdma->current_length);
 
     if (ret < 0) {
-        return ret;
+        return -1;
     }
 
     if (ret == 0) {
@@ -2358,7 +2359,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
     if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
         ret = qemu_rdma_write_flush(rdma);
         if (ret) {
-            return ret;
+            return -1;
         }
         rdma->current_length = 0;
         rdma->current_addr = current_addr;
@@ -3524,7 +3525,7 @@ err_rdma_dest_wait:
     rdma->error_state = ret;
     qemu_rdma_cleanup(rdma);
     g_free(rdma_return_path);
-    return ret;
+    return -1;
 }
 
 static int dest_ram_sort_func(const void *a, const void *b)
-- 
2.41.0


