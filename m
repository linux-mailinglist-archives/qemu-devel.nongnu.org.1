Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDBC7B1E6C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:31:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlr67-0000A8-R5; Thu, 28 Sep 2023 09:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlr60-0008VC-Mk
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlr5y-0002AU-3P
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvSdTwT4YxNh7LQx8AAvRG7FkEwC6IT5b8c9oaYOX4E=;
 b=b+AXfdpWNMYSjHQJBCpXb9ggfdbPmXL8MZrWVGyCX4VZI3mTHpn8BYtNz+RImHPdA+K51i
 x4S4cqlbK/6Je7q5D1DQCeuiDfdaoWveUQEblA86tFs2gLjz9+WGHVhgaWCsWN/Z4sKW+t
 RXZELBCo0G4D6+lEgH4JAE1h7EifV6k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-sEAK8owkPFqMG1RET1IzUw-1; Thu, 28 Sep 2023 09:30:19 -0400
X-MC-Unique: sEAK8owkPFqMG1RET1IzUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6745E8039C8;
 Thu, 28 Sep 2023 13:30:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2957B14171B6;
 Thu, 28 Sep 2023 13:30:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3847821E6899; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 37/53] migration/rdma: Convert
 qemu_rdma_exchange_get_response() to Error
Date: Thu, 28 Sep 2023 15:20:03 +0200
Message-ID: <20230928132019.2544702-38-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
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

qemu_rdma_exchange_send() and qemu_rdma_exchange_recv() violate this
principle: they call error_report() via
qemu_rdma_exchange_get_response().  I elected not to investigate how
callers handle the error, i.e. precise impact is not known.

Clean this up by converting qemu_rdma_exchange_get_response() to
Error.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f77bf1d453..2f6e22e1f2 100644
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
 
@@ -1908,10 +1910,10 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
      */
     if (rdma->control_ready_expected) {
         RDMAControlHeader resp;
-        ret = qemu_rdma_exchange_get_response(rdma,
-                                    &resp, RDMA_CONTROL_READY, RDMA_WRID_READY);
+        ret = qemu_rdma_exchange_get_response(rdma, &resp,
+                                              RDMA_CONTROL_READY,
+                                              RDMA_WRID_READY, errp);
         if (ret < 0) {
-            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
     }
@@ -1962,10 +1964,10 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
 
         trace_qemu_rdma_exchange_send_waiting(control_desc(resp->type));
         ret = qemu_rdma_exchange_get_response(rdma, resp,
-                                              resp->type, RDMA_WRID_DATA);
+                                              resp->type, RDMA_WRID_DATA,
+                                              errp);
 
         if (ret < 0) {
-            error_setg(errp, "FIXME temporary error message");
             return -1;
         }
 
@@ -2009,10 +2011,9 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
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


