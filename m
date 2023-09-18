Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 771957A4B27
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:45:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSW-00035n-VE; Mon, 18 Sep 2023 10:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSO-00031d-QA
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bc-RN
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zejLdMwDMP+tVjE4lYej6MTtHi0RJ0bmWoM7imLV3NQ=;
 b=AUb7VLpHpmllcxG15wAOHk33HDjVXe2AAHWo93b1ops9Z+x2L5vndf/Y918djrL8CVKMwv
 7YaySOxc2ylzNBx4tfatZiV6FTkuL/+TjJrnbzNHW7Es6lVHOJQmAJAAIFeKCaONl/Lzk9
 UtKxOi8ObsKAV7k7GxCPZX8luXLNyb8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-7pzGYtcRP5qmiHE4is6orw-1; Mon, 18 Sep 2023 10:42:11 -0400
X-MC-Unique: 7pzGYtcRP5qmiHE4is6orw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52CA6945920
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 304CF4A9B13
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6259721E689E; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 42/52] migration/rdma: Convert qemu_rdma_post_recv_control()
 to Error
Date: Mon, 18 Sep 2023 16:41:56 +0200
Message-ID: <20230918144206.560120-43-armbru@redhat.com>
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

Just for symmetry with qemu_rdma_post_send_control().  Error messages
lose detail I consider of no use to users.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 25caf67aac..a727aa35d1 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1778,7 +1778,8 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
  * Post a RECV work request in anticipation of some future receipt
  * of data on the control channel.
  */
-static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx)
+static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx,
+                                       Error **errp)
 {
     struct ibv_recv_wr *bad_wr;
     struct ibv_sge sge = {
@@ -1795,6 +1796,7 @@ static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx)
 
 
     if (ibv_post_recv(rdma->qp, &recv_wr, &bad_wr)) {
+        error_setg(errp, "error posting control recv");
         return -1;
     }
 
@@ -1904,10 +1906,8 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      * If the user is expecting a response, post a WR in anticipation of it.
      */
     if (resp) {
-        ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_DATA);
+        ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_DATA, errp);
         if (ret < 0) {
-            error_setg(errp, "rdma migration: error posting"
-                    " extra control recv for anticipated result!");
             return -1;
         }
     }
@@ -1915,9 +1915,8 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     /*
      * Post a WR to replace the one we just consumed for the READY message.
      */
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, errp);
     if (ret < 0) {
-        error_setg(errp, "rdma migration: error posting first control recv!");
         return -1;
     }
 
@@ -2001,9 +2000,8 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     /*
      * Post a new RECV work request to replace the one we just consumed.
      */
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, errp);
     if (ret < 0) {
-        error_setg(errp, "rdma migration: error posting second control recv!");
         return -1;
     }
 
@@ -2569,9 +2567,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     caps_to_network(&cap);
 
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, errp);
     if (ret < 0) {
-        error_setg(errp, "RDMA ERROR: posting second control recv");
         goto err_rdma_source_connect;
     }
 
@@ -3370,6 +3367,7 @@ static void rdma_cm_poll_handler(void *opaque)
 
 static int qemu_rdma_accept(RDMAContext *rdma)
 {
+    Error *err = NULL;
     RDMACapabilities cap;
     struct rdma_conn_param conn_param = {
                                             .responder_resources = 2,
@@ -3506,9 +3504,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     rdma_ack_cm_event(cm_event);
     rdma->connected = true;
 
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, &err);
     if (ret < 0) {
-        error_report("rdma migration: error posting second control recv");
+        error_report_err(err);
         goto err_rdma_dest_wait;
     }
 
-- 
2.41.0


