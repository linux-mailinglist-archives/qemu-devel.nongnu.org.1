Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 498687A4B57
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:53:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSV-00035I-2F; Mon, 18 Sep 2023 10:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSN-0002yJ-IO
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bq-PY
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZZEVEpp7qTVI0/l9SeWztvjOBzkaHnlyrpbosDXOuo=;
 b=JGJAcFy7f7m55ULdFyu8cF0gPjxO2nNLhU4imvHLd2YUSPi7rjIPC1avJVK938wCKFr5Zo
 R2Ecj5F4/sx3+Ss2qHoa0xCSlw2/8j93nh1sIbQ9Ng+TNWz0jQAw83ea9WB/p/25hmqbTj
 H/4ad+jgQhAgSHK7Uq13oUYS+z6LnZQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-8CjOMPGaNJqVlTvdd1UajQ-1; Mon, 18 Sep 2023 10:42:11 -0400
X-MC-Unique: 8CjOMPGaNJqVlTvdd1UajQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5814A3800BAB
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A329140E953
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 59E0021E689B; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to Error
Date: Mon, 18 Sep 2023 16:41:53 +0200
Message-ID: <20230918144206.560120-40-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qemu_rdma_write_flush() violates this principle: it calls
error_report() via qemu_rdma_write_one().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_write_one() to Error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c3c33fe242..9b8cbadfcd 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2019,9 +2019,8 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
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
@@ -2075,7 +2074,7 @@ retry:
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
 
         if (ret < 0) {
-            error_report("Failed to Wait for previous write to complete "
+            error_setg(errp, "Failed to Wait for previous write to complete "
                     "block %d chunk %" PRIu64
                     " current %" PRIu64 " len %" PRIu64 " %d",
                     current_index, chunk, sge.addr, length, rdma->nb_sent);
@@ -2107,10 +2106,9 @@ retry:
 
                 compress_to_network(rdma, &comp);
                 ret = qemu_rdma_exchange_send(rdma, &head,
-                                (uint8_t *) &comp, NULL, NULL, NULL, &err);
+                                (uint8_t *) &comp, NULL, NULL, NULL, errp);
 
                 if (ret < 0) {
-                    error_report_err(err);
                     return -1;
                 }
 
@@ -2136,9 +2134,8 @@ retry:
 
             register_to_network(rdma, &reg);
             ret = qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                    &resp, &reg_result_idx, NULL, &err);
+                                    &resp, &reg_result_idx, NULL, errp);
             if (ret < 0) {
-                error_report_err(err);
                 return -1;
             }
 
@@ -2146,7 +2143,7 @@ retry:
             if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
-                error_report("cannot get lkey");
+                error_setg(errp, "cannot get lkey");
                 return -1;
             }
 
@@ -2165,7 +2162,7 @@ retry:
             if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                 &sge.lkey, NULL, chunk,
                                                 chunk_start, chunk_end)) {
-                error_report("cannot get lkey!");
+                error_setg(errp, "cannot get lkey!");
                 return -1;
             }
         }
@@ -2177,7 +2174,7 @@ retry:
         if (qemu_rdma_register_and_get_keys(rdma, block, sge.addr,
                                                      &sge.lkey, NULL, chunk,
                                                      chunk_start, chunk_end)) {
-            error_report("cannot get lkey!");
+            error_setg(errp, "cannot get lkey!");
             return -1;
         }
     }
@@ -2211,7 +2208,7 @@ retry:
         trace_qemu_rdma_write_one_queue_full();
         ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
         if (ret < 0) {
-            error_report("rdma migration: failed to make "
+            error_setg(errp, "rdma migration: failed to make "
                          "room in full send queue!");
             return -1;
         }
@@ -2219,7 +2216,7 @@ retry:
         goto retry;
 
     } else if (ret > 0) {
-        perror("rdma migration: post rdma write failed");
+        error_setg(errp, "rdma migration: post rdma write failed");
         return -1;
     }
 
@@ -2248,10 +2245,10 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma,
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


