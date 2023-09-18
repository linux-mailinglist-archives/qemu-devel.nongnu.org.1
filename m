Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFD77A4B23
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFT1-0003EF-0R; Mon, 18 Sep 2023 10:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSO-00030k-Cq
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bn-RJ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ao1lL2fUsrg7+XgQqlyGegTRchK9OqkMocZDWWo+amg=;
 b=GAZN/3lUyI2g7HW31+pOhkboIbg/V10VNjV6cpyd6+vIiL1tGRxWfGDCGjFR1XJF38E66c
 v4G5WaTD4PFYj6LO30mAV68DjDT6eC7jZRLxuV3ClrJya62pWkJfKoR0jujzPGrr/+cfAs
 EPDagcYhHR6rSeRkfmgKhkqROqt6BAs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-R-nFck-qN_66qwqy37Lfog-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: R-nFck-qN_66qwqy37Lfog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88744858286
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 66283140E964
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4B7FC21E6896; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 34/52] migration/rdma: Convert qemu_rdma_exchange_recv() to
 Error
Date: Mon, 18 Sep 2023 16:41:48 +0200
Message-ID: <20230918144206.560120-35-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job.  When the caller does, the error is reported twice.  When it
doesn't (because it recovered from the error), there is no error to
report, i.e. the report is bogus.

qio_channel_rdma_readv() violates this principle: it calls
error_report() via qemu_rdma_exchange_recv().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_exchange_recv() to Error.

Necessitates setting an error when qemu_rdma_exchange_get_response()
failed.  Since this error will go away later in this series, simply
use "FIXME temporary error message" there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index c88cd1f468..50546b3a27 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1957,7 +1957,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
  * control-channel message.
  */
 static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
-                                   uint32_t expecting)
+                                   uint32_t expecting, Error **errp)
 {
     RDMAControlHeader ready = {
                                 .len = 0,
@@ -1972,7 +1972,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_send_control(rdma, NULL, &ready);
 
     if (ret < 0) {
-        error_report("Failed to send control buffer!");
+        error_setg(errp, "Failed to send control buffer!");
         return -1;
     }
 
@@ -1983,6 +1983,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
                                           expecting, RDMA_WRID_READY);
 
     if (ret < 0) {
+        error_setg(errp, "FIXME temporary error message");
         return -1;
     }
 
@@ -1993,7 +1994,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret < 0) {
-        error_report("rdma migration: error posting second control recv!");
+        error_setg(errp, "rdma migration: error posting second control recv!");
         return -1;
     }
 
@@ -2908,11 +2909,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         /* We've got nothing at all, so lets wait for
          * more to arrive
          */
-        ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_QEMU_FILE);
+        ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_QEMU_FILE,
+                                      errp);
 
         if (ret < 0) {
             rdma->errored = true;
-            error_setg(errp, "qemu_rdma_exchange_recv failed");
             return -1;
         }
 
@@ -3536,6 +3537,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     RDMAControlHeader blocks = { .type = RDMA_CONTROL_RAM_BLOCKS_RESULT,
                                  .repeat = 1 };
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    Error *err = NULL;
     RDMAContext *rdma;
     RDMALocalBlocks *local;
     RDMAControlHeader head;
@@ -3565,9 +3567,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     do {
         trace_qemu_rdma_registration_handle_wait();
 
-        ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_NONE);
+        ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_NONE, &err);
 
         if (ret < 0) {
+            error_report_err(err);
             break;
         }
 
-- 
2.41.0


