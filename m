Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E907B1E27
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:25:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwy-0003oA-GE; Thu, 28 Sep 2023 09:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwd-0003bi-9H
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwP-0008HW-N0
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvoAxvYZaqo7bzchnP58oSUeeoRm4YLTIfoBKaMl0mM=;
 b=X+5HuliACwtm9kPvhW3rDEx3wbOWaxQPeiSka2OEJVBNtzBUtdf+oEend+yA0ONamyF8E9
 MSs/SnTeBFbiFn/ed0eYrPnkhW02OVSo21UMoMFRLlYeMfSyrEeDKWtOvmfwj7L2QuLRMB
 ffRMp5y6ZzNXYgP4K9J2TCzsJ5VprO4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-mVq5IydKNmyJdQxRrsr_Tg-1; Thu, 28 Sep 2023 09:20:24 -0400
X-MC-Unique: mVq5IydKNmyJdQxRrsr_Tg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C2CF280A9CD;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D24F40C6E76;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4153621E689C; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 40/53] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Date: Thu, 28 Sep 2023 15:20:06 +0200
Message-ID: <20230928132019.2544702-41-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 migration/rdma.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index feed8712bb..928d09d177 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2040,9 +2040,8 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
  */
 static int qemu_rdma_write_one(QEMUFile *f, RDMAContext *rdma,
                                int current_index, uint64_t current_addr,
-                               uint64_t length)
+                               uint64_t length, Error **errp)
 {
-    Error *err = NULL;
     struct ibv_sge sge;
     struct ibv_send_wr send_wr = { 0 };
     struct ibv_send_wr *bad_wr;
@@ -2096,7 +2095,7 @@ retry:
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
 
         if (ret < 0) {
-            error_report("Failed to Wait for previous write to complete "
+            error_setg(errp, "Failed to Wait for previous write to complete "
                     "block %d chunk %" PRIu64
                     " current %" PRIu64 " len %" PRIu64 " %d",
                     current_index, chunk, sge.addr, length, rdma->nb_sent);
@@ -2128,10 +2127,9 @@ retry:
 
                 compress_to_network(rdma, &comp);
                 ret = qemu_rdma_exchange_send(rdma, &head,
-                                (uint8_t *) &comp, NULL, NULL, NULL, &err);
+                                (uint8_t *) &comp, NULL, NULL, NULL, errp);
 
                 if (ret < 0) {
-                    error_report_err(err);
                     return -1;
                 }
 
@@ -2157,9 +2155,8 @@ retry:
 
             register_to_network(rdma, &reg);
             ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                    &resp, &reg_result_idx, NULL, &err);
+                                    &resp, &reg_result_idx, NULL, errp);
             if (ret < 0) {
-                error_report_err(err);
                 return -1;
             }
 
@@ -2167,7 +2164,7 @@ retry:
             if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
-                error_report("cannot get lkey");
+                error_setg(errp, "cannot get lkey");
                 return -1;
             }
 
@@ -2186,7 +2183,7 @@ retry:
             if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
-                error_report("cannot get lkey!");
+                error_setg(errp, "cannot get lkey!");
                 return -1;
             }
         }
@@ -2198,7 +2195,7 @@ retry:
         if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                      &sge.lkey, NULL, chunk,
                                                      chunk_start, chunk_end)) {
-            error_report("cannot get lkey!");
+            error_setg(errp, "cannot get lkey!");
             return -1;
         }
     }
@@ -2232,7 +2229,7 @@ retry:
         trace_qemu_rdma_write_one_queue_full();
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
-            error_report("rdma migration: failed to make "
+            error_setg(errp, "rdma migration: failed to make "
                          "room in full send queue!");
             return -1;
         }
@@ -2240,12 +2237,8 @@ retry:
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
 
@@ -2274,10 +2267,10 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma,
     }
 
     ret = qemu_rdma_write_one(f, rdma,
-            rdma->current_index, rdma->current_addr, rdma->current_length);
+            rdma->current_index, rdma->current_addr, rdma->current_length,
+            errp);
 
     if (ret < 0) {
-        error_setg(errp, "FIXME temporary error message");
         return -1;
     }
 
-- 
2.41.0


