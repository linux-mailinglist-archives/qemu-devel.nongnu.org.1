Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A57B1E54
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwn-0003gk-20; Thu, 28 Sep 2023 09:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwb-0003bH-T7
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwP-0008G9-Cj
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HBSYcgbMjpFLppiBSk+jEA/Y9CEn75eYRMPPawtwHNA=;
 b=Jtnc7d3fKwEYBoscY/owwxNR3y/wkwer0LJ5zOnwLCl2OdXEK31BAQeajGneH56Mg1gCwt
 hVaJ42O3ob0RhktRp8hLkJa4Y3Gr7boZronhvJ/XGYnPqUBALzdWIWwFsYhzYTJTEIZApr
 pw2Zb1DXuhIUc5JL94bNIj1OrjywnKI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-693-crh1dRODM0C25PAlP_TXCg-1; Thu, 28 Sep 2023 09:20:24 -0400
X-MC-Unique: crh1dRODM0C25PAlP_TXCg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FD38811E7D;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D302215670B;
 Thu, 28 Sep 2023 13:20:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3B3CD21E689A; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 38/53] migration/rdma: Convert
 qemu_rdma_reg_whole_ram_blocks() to Error
Date: Thu, 28 Sep 2023 15:20:04 +0200
Message-ID: <20230928132019.2544702-39-armbru@redhat.com>
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
---
 migration/rdma.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 2f6e22e1f2..fa15b1f6ce 100644
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
@@ -1955,9 +1957,8 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
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
@@ -3664,10 +3665,9 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
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


