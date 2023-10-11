Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DC17C4F40
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRO-0001hs-Ix; Wed, 11 Oct 2023 05:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRM-0001dp-2C
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRK-00054b-8g
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJhkYG40aawryzcE70ua59jlVDl4cENEC3N0ZSwUggo=;
 b=SSVBr48r6a/LTrtDYPM4i7TOCHwlBAkoHY0WRErAaU77DPoVpphmN81dTgGJmyh5hYdxMX
 89BZKrxEi5PfIZUpYkq/K0fLDlPqekDPQ5uY1KIEESfcJdkyhSO7YFJSsG4PD/IxCbus13
 Lt4GZwP6R5wNCv3VWOKqnLNqZhtLI64=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-qPnRA2GcNlaPRVh64kzeYQ-1; Wed, 11 Oct 2023 05:23:36 -0400
X-MC-Unique: qPnRA2GcNlaPRVh64kzeYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 070EA101B048;
 Wed, 11 Oct 2023 09:23:36 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 464261C060B0;
 Wed, 11 Oct 2023 09:23:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 44/65] migration/rdma: Convert
 qemu_rdma_exchange_get_response() to Error
Date: Wed, 11 Oct 2023 11:21:42 +0200
Message-ID: <20231011092203.1266-45-quintela@redhat.com>
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

qemu_rdma_exchange_send() and qemu_rdma_exchange_recv() violate this
principle: they call error_report() via
qemu_rdma_exchange_get_response().  I elected not to investigate how
callers handle the error, i.e. precise impact is not known.

Clean this up by converting qemu_rdma_exchange_get_response() to
Error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-38-armbru@redhat.com>
---
 migration/rdma.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 7866cf9bb7..87f2e6129e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1824,14 +1824,15 @@ static int qemu_rdma_post_recv_control(RDMAContext *rdma, int idx)
  * Block and wait for a RECV control channel message to arrive.
  */
 static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
-                RDMAControlHeader *head, uint32_t expecting, int idx)
+                RDMAControlHeader *head, uint32_t expecting, int idx,
+                Error **errp)
 {
     uint32_t byte_len;
     int ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RECV_CONTROL + idx,
                                        &byte_len);
 
     if (ret < 0) {
-        error_report("rdma migration: recv polling control error!");
+        error_setg(errp, "rdma migration: recv polling control error!");
         return -1;
     }
 
@@ -1844,7 +1845,7 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
         trace_qemu_rdma_exchange_get_response_none(control_desc(head->type),
                                              head->type);
     } else if (head->type != expecting || head->type == RDMA_CONTROL_ERROR) {
-        error_report("Was expecting a %s (%d) control message"
+        error_setg(errp, "Was expecting a %s (%d) control message"
                 ", but got: %s (%d), length: %d",
                 control_desc(expecting), expecting,
                 control_desc(head->type), head->type, head->len);
@@ -1854,11 +1855,12 @@ static int qemu_rdma_exchange_get_response(RDMAContext *rdma,
         return -1;
     }
     if (head->len > RDMA_CONTROL_MAX_BUFFER - sizeof(*head)) {
-        error_report("too long length: %d", head->len);
+        error_setg(errp, "too long length: %d", head->len);
         return -1;
     }
     if (sizeof(*head) + head->len != byte_len) {
-        error_report("Malformed length: %d byte_len %d", head->len, byte_len);
+        error_setg(errp, "Malformed length: %d byte_len %d",
+                   head->len, byte_len);
         return -1;
     }
 
@@ -1911,9 +1913,8 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 
         ret = qemu_rdma_exchange_get_response(rdma, &resp_ignored,
                                               RDMA_CONTROL_READY,
-                                              RDMA_WRID_READY);
+                                              RDMA_WRID_READY, errp);
         if (ret < 0) {
-            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
     }
@@ -1964,10 +1965,10 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 
         trace_qemu_rdma_exchange_send_waiting(control_desc(resp->type));
         ret = qemu_rdma_exchange_get_response(rdma, resp,
-                                              resp->type, RDMA_WRID_DATA);
+                                              resp->type, RDMA_WRID_DATA,
+                                              errp);
 
         if (ret < 0) {
-            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
 
@@ -2011,10 +2012,9 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
      * Block and wait for the message.
      */
     ret = qemu_rdma_exchange_get_response(rdma, head,
-                                          expecting, RDMA_WRID_READY);
+                                          expecting, RDMA_WRID_READY, errp);
 
     if (ret < 0) {
-        error_setg(errp, "FIXME temporary error message");
         return -1;
     }
 
-- 
2.41.0


