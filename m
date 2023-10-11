Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FF97C4F23
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:37:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRb-0003Cz-5T; Wed, 11 Oct 2023 05:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRX-0002u7-Vi
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRW-00056o-4K
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GT8YFTbQJfUZd6mIeMfVrb3xHJxDPUhMukS/bZPvqG8=;
 b=CX/CiEWevliisdvR/gCZiRfo2uhK0s/H0wvdmV4dXqdhrx/0DsFNAK7nsUBn8o0OsybT77
 8bU0rScQKZjAifiL9AOXdqBi7v9KFgc8mb/35z11x061Us+1ByEiwlem8TqHAWmLXJah1x
 +j1wee0CwEu2fkrBrOc1BFhaoqw4ufQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-4N3psHV2MvGDASlpgQLmag-1; Wed, 11 Oct 2023 05:23:38 -0400
X-MC-Unique: 4N3psHV2MvGDASlpgQLmag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09E963C0EAA4;
 Wed, 11 Oct 2023 09:23:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE731C060AE;
 Wed, 11 Oct 2023 09:23:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 45/65] migration/rdma: Convert qemu_rdma_reg_whole_ram_blocks()
 to Error
Date: Wed, 11 Oct 2023 11:21:43 +0200
Message-ID: <20231011092203.1266-46-quintela@redhat.com>
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
error_report() via callback qemu_rdma_reg_whole_ram_blocks().  I
elected not to investigate how callers handle the error, i.e. precise
impact is not known.

Clean this up by converting the callback to Error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-39-armbru@redhat.com>
---
 migration/rdma.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 87f2e6129e..189932097e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -518,7 +518,8 @@ static void network_to_result(RDMARegisterResult *result)
 static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                    uint8_t *data, RDMAControlHeader *resp,
                                    int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma),
+                                   int (*callback)(RDMAContext *rdma,
+                                                   Error **errp),
                                    Error **errp);
 
 static inline uint64_t ram_chunk_index(const uint8_t *start,
@@ -1177,7 +1178,7 @@ static void qemu_rdma_advise_prefetch_mr(struct ibv_pd *pd, uint64_t addr,
 #endif
 }
 
-static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
+static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma, Error **errp)
 {
     int i;
     RDMALocalBlocks *local = &rdma->local_ram_blocks;
@@ -1217,16 +1218,16 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
         }
 
         if (!local->block[i].mr) {
-            perror("Failed to register local dest ram block!");
-            break;
+            error_setg_errno(errp, errno,
+                             "Failed to register local dest ram block!");
+            goto err;
         }
         rdma->total_registrations++;
     }
 
-    if (i >= local->nb_blocks) {
-        return 0;
-    }
+    return 0;
 
+err:
     for (i--; i >= 0; i--) {
         ibv_dereg_mr(local->block[i].mr);
         local->block[i].mr = NULL;
@@ -1899,7 +1900,8 @@ static void qemu_rdma_move_header(RDMAContext *rdma, int idx,
 static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                    uint8_t *data, RDMAControlHeader *resp,
                                    int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma),
+                                   int (*callback)(RDMAContext *rdma,
+                                                   Error **errp),
                                    Error **errp)
 {
     int ret;
@@ -1956,9 +1958,8 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
     if (resp) {
         if (callback) {
             trace_qemu_rdma_exchange_send_issue_callback();
-            ret = callback(rdma);
+            ret = callback(rdma, errp);
             if (ret < 0) {
-                error_setg(errp, "FIXME temporary error message");
                 return -1;
             }
         }
@@ -3671,10 +3672,9 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
             }
 
             if (rdma->pin_all) {
-                ret = qemu_rdma_reg_whole_ram_blocks(rdma);
+                ret = qemu_rdma_reg_whole_ram_blocks(rdma, &err);
                 if (ret < 0) {
-                    error_report("rdma migration: error dest "
-                                    "registering ram blocks");
+                    error_report_err(err);
                     goto err;
                 }
             }
-- 
2.41.0


