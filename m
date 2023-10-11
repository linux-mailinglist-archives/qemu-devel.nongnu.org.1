Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C43947C4F00
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:31:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRR-0001sj-Hn; Wed, 11 Oct 2023 05:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRQ-0001od-2t
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRO-00055H-DJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6wT3q2hbremT/Wm3YQwFuxxnNfWtrG9kS4r/6U2YGI=;
 b=YsOTBMVA0UhEB6Q0MTtIZL3BvwZUqrQWqiHa5sdP+xSNm55ZZLFPaE7nnOHd/RCXNmlY3F
 IxTtsD/u9rVjeZxApXiu+Y8SrFUaxaFz88Lgy5OKJvN8cIrlRq+YcV6pk8GMn46yvV+89u
 hnTR0cqf5GIMky7iM+RuIuca8zWnb+M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-LdxKr9qlPc2-58VRx7CHzA-1; Wed, 11 Oct 2023 05:23:32 -0400
X-MC-Unique: LdxKr9qlPc2-58VRx7CHzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F04DD185A7B4;
 Wed, 11 Oct 2023 09:23:31 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 290491C060AE;
 Wed, 11 Oct 2023 09:23:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 42/65] migration/rdma: Convert qemu_rdma_exchange_recv() to
 Error
Date: Wed, 11 Oct 2023 11:21:40 +0200
Message-ID: <20231011092203.1266-43-quintela@redhat.com>
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
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-36-armbru@redhat.com>
---
 migration/rdma.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index fdb527af39..b13fec6328 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1980,7 +1980,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
  * control-channel message.
  */
 static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
-                                   uint32_t expecting)
+                                   uint32_t expecting, Error **errp)
 {
     RDMAControlHeader ready = {
                                 .len = 0,
@@ -1995,7 +1995,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
     ret = qemu_rdma_post_send_control(rdma, NULL, &ready);
 
     if (ret < 0) {
-        error_report("Failed to send control buffer!");
+        error_setg(errp, "Failed to send control buffer!");
         return -1;
     }
 
@@ -2006,6 +2006,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
                                           expecting, RDMA_WRID_READY);
 
     if (ret < 0) {
+        error_setg(errp, "FIXME temporary error message");
         return -1;
     }
 
@@ -2016,7 +2017,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
      */
     ret = qemu_rdma_post_recv_control(rdma, RDMA_WRID_READY);
     if (ret < 0) {
-        error_report("rdma migration: error posting second control recv!");
+        error_setg(errp, "rdma migration: error posting second control recv!");
         return -1;
     }
 
@@ -2957,11 +2958,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
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
 
@@ -3575,6 +3576,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     RDMAControlHeader blocks = { .type = RDMA_CONTROL_RAM_BLOCKS_RESULT,
                                  .repeat = 1 };
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    Error *err = NULL;
     RDMAContext *rdma;
     RDMALocalBlocks *local;
     RDMAControlHeader head;
@@ -3604,9 +3606,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
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


