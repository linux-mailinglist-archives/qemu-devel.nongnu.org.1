Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 115337C4F27
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRa-00038n-Bl; Wed, 11 Oct 2023 05:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRX-0002sz-QH
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRV-00056h-Ug
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGf38nOwvkBL5NjS/0jXTUb9ZuLvIwBLVrqNG5Bqhqw=;
 b=LU+uVpMihIXvXs8O+N9ZTDSJ8zXNwlJAaK9zoT85WhnHwZU0AuL/1ibUb2Rgfuv0nNNezr
 oD6BodSmuL/3rMTvdWwCejRu7vR8VyUmSvSx2MYPHWRHJH8y910qCTd7VbG3E+O6RfjZFn
 qWRFqe0U8k6YFWhJfymxFX8pvlSId4M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-678-etFWm1TnPvGa6AdfE__zYw-1; Wed, 11 Oct 2023 05:23:46 -0400
X-MC-Unique: etFWm1TnPvGa6AdfE__zYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11ECC887E47;
 Wed, 11 Oct 2023 09:23:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54E341C060AE;
 Wed, 11 Oct 2023 09:23:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 49/65] migration/rdma: Convert qemu_rdma_post_send_control() to
 Error
Date: Wed, 11 Oct 2023 11:21:47 +0200
Message-ID: <20231011092203.1266-50-quintela@redhat.com>
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qemu_rdma_exchange_send() violates this principle: it calls
error_report() via qemu_rdma_post_send_control().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_post_send_control() to Error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-43-armbru@redhat.com>
---
 migration/rdma.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 9f45f6a91d..aeb0a8921e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1741,7 +1741,8 @@ err_block_for_wrid:
  * containing some data and block until the post completes.
  */
 static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
-                                       RDMAControlHeader *head)
+                                       RDMAControlHeader *head,
+                                       Error **errp)
 {
     int ret;
     RDMAWorkRequestData *wr = &rdma->wr_data[RDMA_WRID_CONTROL];
@@ -1781,13 +1782,13 @@ static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
     ret = ibv_post_send(rdma->qp, &send_wr, &bad_wr);
 
     if (ret > 0) {
-        error_report("Failed to use post IB SEND for control");
+        error_setg(errp, "Failed to use post IB SEND for control");
         return -1;
     }
 
     ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_SEND_CONTROL, NULL);
     if (ret < 0) {
-        error_report("rdma migration: send polling control error");
+        error_setg(errp, "rdma migration: send polling control error");
         return -1;
     }
 
@@ -1945,10 +1946,9 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     /*
      * Deliver the control message that was requested.
      */
-    ret = qemu_rdma_post_send_control(rdma, data, head);
+    ret = qemu_rdma_post_send_control(rdma, data, head, errp);
 
     if (ret < 0) {
-        error_setg(errp, "Failed to send control buffer!");
         return -1;
     }
 
@@ -2002,10 +2002,9 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     /*
      * Inform the source that we're ready to receive a message.
      */
-    ret = qemu_rdma_post_send_control(rdma, NULL, &ready);
+    ret = qemu_rdma_post_send_control(rdma, NULL, &ready, errp);
 
     if (ret < 0) {
-        error_setg(errp, "Failed to send control buffer!");
         return -1;
     }
 
@@ -2394,6 +2393,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
 
 static void qemu_rdma_cleanup(RDMAContext *rdma)
 {
+    Error *err = NULL;
     int idx;
 
     if (rdma->cm_id && rdma->connected) {
@@ -2405,7 +2405,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
                                        .repeat = 1,
                                      };
             error_report("Early error. Sending error.");
-            qemu_rdma_post_send_control(rdma, NULL, &head);
+            if (qemu_rdma_post_send_control(rdma, NULL, &head, &err) < 0) {
+                error_report_err(err);
+            }
         }
 
         rdma_disconnect(rdma->cm_id);
@@ -3705,10 +3707,11 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
 
             ret = qemu_rdma_post_send_control(rdma,
-                                        (uint8_t *) rdma->dest_blocks, &blocks);
+                                    (uint8_t *) rdma->dest_blocks, &blocks,
+                                    &err);
 
             if (ret < 0) {
-                error_report("rdma migration: error sending remote info");
+                error_report_err(err);
                 goto err;
             }
 
@@ -3783,10 +3786,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
             }
 
             ret = qemu_rdma_post_send_control(rdma,
-                            (uint8_t *) results, &reg_resp);
+                            (uint8_t *) results, &reg_resp, &err);
 
             if (ret < 0) {
-                error_report("Failed to send control buffer");
+                error_report_err(err);
                 goto err;
             }
             break;
@@ -3818,10 +3821,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                                                        reg->key.chunk);
             }
 
-            ret = qemu_rdma_post_send_control(rdma, NULL, &unreg_resp);
+            ret = qemu_rdma_post_send_control(rdma, NULL, &unreg_resp, &err);
 
             if (ret < 0) {
-                error_report("Failed to send control buffer");
+                error_report_err(err);
                 goto err;
             }
             break;
-- 
2.41.0


