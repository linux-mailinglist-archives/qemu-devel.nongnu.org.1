Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB47B1E05
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:23:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwt-0003jl-1w; Thu, 28 Sep 2023 09:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwZ-0003ZW-3V
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwO-0008FL-4t
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0ZApXiJBmVA2+yluBuXW6/Hc8px7ssG3YQ2RDU3dCE=;
 b=BYxpOcPaJGpOvUFX9nH+fUp83tAj+4FiC3GiEiLOUVuq5klqu2fgxH/WMzYJBpDOjvN3tw
 j4bWPbwrwyp+aHLPnlHKqALiTAxKy4O14ZQM0KCXWyz1RaK58+1yfGrOwv+bS6MUGfLJhn
 QwRslW/BriW6Vcl1suzWJm/GWkA1zbc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-1MPxTCxHMbGSbKp-6txDuw-1; Thu, 28 Sep 2023 09:20:25 -0400
X-MC-Unique: 1MPxTCxHMbGSbKp-6txDuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EF82811E8F;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CA2A2156711;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49FFB21E689F; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 43/53] migration/rdma: Convert
 qemu_rdma_post_recv_control() to Error
Date: Thu, 28 Sep 2023 15:20:09 +0200
Message-ID: <20230928132019.2544702-44-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index ce56ba9b40..336a960006 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1799,7 +1799,8 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
  * Post a RECV work request in anticipation of some future receipt
  * of data on the control channel.
  */
-static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx)
+static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx,
+                                       Error **errp)
 {
     struct ibv_recv_wr *bad_wr;
     struct ibv_sge sge = {
@@ -1816,6 +1817,7 @@ static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx)
 
 
     if (ibv_post_recv(rdma->qp, &recv_wr, &bad_wr)) {
+        error_setg(errp, "error posting control recv");
         return -1;
     }
 
@@ -1925,10 +1927,8 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
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
@@ -1936,9 +1936,8 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     /*
      * Post a WR to replace the one we just consumed for the READY message.
      */
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, errp);
     if (ret < 0) {
-        error_setg(errp, "rdma migration: error posting first control recv!");
         return -1;
     }
 
@@ -2022,9 +2021,8 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     /*
      * Post a new RECV work request to replace the one we just consumed.
      */
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, errp);
     if (ret < 0) {
-        error_setg(errp, "rdma migration: error posting second control recv!");
         return -1;
     }
 
@@ -2591,9 +2589,8 @@ static int qemu_rdma_connect(RDMAContext *rdma, bool return_path,
 
     caps_to_network(&cap);
 
-    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
+    ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY, errp);
     if (ret < 0) {
-        error_setg(errp, "RDMA ERROR: posting second control recv");
         goto err_rdma_source_connect;
     }
 
@@ -3397,6 +3394,7 @@ static void rdma_cm_poll_handler(void *opaque)
 
 static int qemu_rdma_accept(RDMAContext *rdma)
 {
+    Error *err = NULL;
     RDMACapabilities cap;
     struct rdma_conn_param conn_param = {
                                             .responder_resources = 2,
@@ -3533,9 +3531,9 @@ static int qemu_rdma_accept(RDMAContext *rdma)
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


