Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F68F7C4F39
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:38:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRW-0002Wr-89; Wed, 11 Oct 2023 05:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRU-0002L5-0F
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRS-000563-3I
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wo4urtrHybEYHotXmuyphod4xEGeAt50t3yNuF9zYzs=;
 b=Z6tVY4YgMt5luLBOBHs9CFewqKfIm1u3nzLdOzvCnifro0KyY2r0gCvv30AZd4TDBIZ9DL
 irtbsjXSyV3oDlFd44/VR+B/Y7iNIh4Mcb/ykwV40XfxcEdrYA1i2+805vwtx7devzd68O
 GzrcTc8up5en5z2kJCYroKNGP98K0qE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-AUes_PhJP6K-tUY29ipF_Q-1; Wed, 11 Oct 2023 05:23:42 -0400
X-MC-Unique: AUes_PhJP6K-tUY29ipF_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09CAF185A795;
 Wed, 11 Oct 2023 09:23:42 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D0111C060AE;
 Wed, 11 Oct 2023 09:23:40 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 47/65] migration/rdma: Convert qemu_rdma_write_one() to Error
Date: Wed, 11 Oct 2023 11:21:45 +0200
Message-ID: <20231011092203.1266-48-quintela@redhat.com>
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

qemu_rdma_write_flush() violates this principle: it calls
error_report() via qemu_rdma_write_one().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_write_one() to Error.  Bonus:
resolves a FIXME about problematic use of errno.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-41-armbru@redhat.com>
---
 migration/rdma.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 1a74c6d955..369d30c895 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2041,9 +2041,8 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
  */
 static int qemu_rdma_write_one(RDMAContext *rdma,
                                int current_index, uint64_t current_addr,
-                               uint64_t length)
+                               uint64_t length, Error **errp)
 {
-    Error *err = NULL;
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
     struct ibv_send_wr *bad_wr;
@@ -2097,7 +2096,7 @@ retry:
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
 
         if (ret < 0) {
-            error_report("Failed to Wait for previous write to complete "
+            error_setg(errp, "Failed to Wait for previous write to complete "
                     "block %d chunk %" PRIu64
                     " current %" PRIu64 " len %" PRIu64 " %d",
                     current_index, chunk, sge.addr, length, rdma->nb_sent);
@@ -2129,10 +2128,9 @@ retry:
 
                 compress_to_network(rdma, &comp);
                 ret = qemu_rdma_exchange_send(rdma, &head,
-                                (uint8_t *) &comp, NULL, NULL, NULL, &err);
+                                (uint8_t *) &comp, NULL, NULL, NULL, errp);
 
                 if (ret < 0) {
-                    error_report_err(err);
                     return -1;
                 }
 
@@ -2167,9 +2165,8 @@ retry:
 
             register_to_network(rdma, &reg);
             ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                    &resp, &reg_result_idx, NULL, &err);
+                                    &resp, &reg_result_idx, NULL, errp);
             if (ret < 0) {
-                error_report_err(err);
                 return -1;
             }
 
@@ -2177,7 +2174,7 @@ retry:
             if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
-                error_report("cannot get lkey");
+                error_setg(errp, "cannot get lkey");
                 return -1;
             }
 
@@ -2196,7 +2193,7 @@ retry:
             if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
-                error_report("cannot get lkey!");
+                error_setg(errp, "cannot get lkey!");
                 return -1;
             }
         }
@@ -2208,7 +2205,7 @@ retry:
         if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                      &sge.lkey, NULL, chunk,
                                                      chunk_start, chunk_end)) {
-            error_report("cannot get lkey!");
+            error_setg(errp, "cannot get lkey!");
             return -1;
         }
     }
@@ -2242,7 +2239,7 @@ retry:
         trace_qemu_rdma_write_one_queue_full();
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
-            error_report("rdma migration: failed to make "
+            error_setg(errp, "rdma migration: failed to make "
                          "room in full send queue!");
             return -1;
         }
@@ -2250,12 +2247,8 @@ retry:
         goto retry;
 
     } else if (ret > 0) {
-        /*
-         * FIXME perror() is problematic, because whether
-         * ibv_post_send() sets errno is unclear.  Will go away later
-         * in this series.
-         */
-        perror("rdma migration: post rdma write failed");
+        error_setg_errno(errp, ret,
+                         "rdma migration: post rdma write failed");
         return -1;
     }
 
@@ -2291,11 +2284,10 @@ static int qemu_rdma_write_flush(RDMAContext *rdma, Error **errp)
         return 0;
     }
 
-    ret = qemu_rdma_write_one(rdma,
-            rdma->current_index, rdma->current_addr, rdma->current_length);
+    ret = qemu_rdma_write_one(rdma, rdma->current_index, rdma->current_addr,
+                              rdma->current_length, errp);
 
     if (ret < 0) {
-        error_setg(errp, "FIXME temporary error message");
         return -1;
     }
 
-- 
2.41.0


