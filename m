Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B62007C4F28
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:37:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRT-00029K-AW; Wed, 11 Oct 2023 05:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRQ-0001qT-I8
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRO-00055S-W9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLijd1iDfCXXZWPn6vTfVcDAw5ir/75x8u4aoAK9BdU=;
 b=TGE8gS3SlncvcUQI+wY01K+Psb9OEBqeXicy+DnuAZ+O25uZNomjHM2Hd5OVI9+Bjcx3wh
 5fkyTTY7epWivEVAFaLN8FKyEqgnErR5PGTwD3KU9WCJYpsRfs7YdEUKKaoQJyJ8+gcPWg
 48deA1cK6rDS5UdvEPiIymH2mfuxn7c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-f6buMa1uNAi0oV_BvWImIw-1; Wed, 11 Oct 2023 05:23:40 -0400
X-MC-Unique: f6buMa1uNAi0oV_BvWImIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07A4F2825EA4;
 Wed, 11 Oct 2023 09:23:40 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BEE21C060B6;
 Wed, 11 Oct 2023 09:23:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 46/65] migration/rdma: Convert qemu_rdma_write_flush() to Error
Date: Wed, 11 Oct 2023 11:21:44 +0200
Message-ID: <20231011092203.1266-47-quintela@redhat.com>
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

qio_channel_rdma_writev() violates this principle: it calls
error_report() via qemu_rdma_write_flush().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_write_flush() to Error.

Necessitates setting an error when qemu_rdma_write_one() failed.
Since this error will go away later in this series, simply use "FIXME
temporary error message" there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-40-armbru@redhat.com>
---
 migration/rdma.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 189932097e..1a74c6d955 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2283,7 +2283,7 @@ retry:
  * We support sending out multiple chunks at the same time.
  * Not all of them need to get signaled in the completion queue.
  */
-static int qemu_rdma_write_flush(RDMAContext *rdma)
+static int qemu_rdma_write_flush(RDMAContext *rdma, Error **errp)
 {
     int ret;
 
@@ -2295,6 +2295,7 @@ static int qemu_rdma_write_flush(RDMAContext *rdma)
             rdma->current_index, rdma->current_addr, rdma->current_length);
 
     if (ret < 0) {
+        error_setg(errp, "FIXME temporary error message");
         return -1;
     }
 
@@ -2368,6 +2369,7 @@ static int qemu_rdma_write(RDMAContext *rdma,
                            uint64_t block_offset, uint64_t offset,
                            uint64_t len)
 {
+    Error *err = NULL;
     uint64_t current_addr = block_offset + offset;
     uint64_t index = rdma->current_index;
     uint64_t chunk = rdma->current_chunk;
@@ -2375,8 +2377,9 @@ static int qemu_rdma_write(RDMAContext *rdma,
 
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
-        ret = qemu_rdma_write_flush(rdma);
+        ret = qemu_rdma_write_flush(rdma, &err);
         if (ret < 0) {
+            error_report_err(err);
             return -1;
         }
         rdma->current_length = 0;
@@ -2393,7 +2396,10 @@ static int qemu_rdma_write(RDMAContext *rdma,
 
     /* flush it if buffer is too large */
     if (rdma->current_length >= RDMA_MERGE_MAX) {
-        return qemu_rdma_write_flush(rdma);
+        if (qemu_rdma_write_flush(rdma, &err) < 0) {
+            error_report_err(err);
+            return -1;
+        }
     }
 
     return 0;
@@ -2857,10 +2863,9 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
      * Push out any writes that
      * we're queued up for VM's ram.
      */
-    ret = qemu_rdma_write_flush(rdma);
+    ret = qemu_rdma_write_flush(rdma, errp);
     if (ret < 0) {
         rdma->errored = true;
-        error_setg(errp, "qemu_rdma_write_flush failed");
         return -1;
     }
 
@@ -3002,9 +3007,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
  */
 static int qemu_rdma_drain_cq(RDMAContext *rdma)
 {
+    Error *err = NULL;
     int ret;
 
-    if (qemu_rdma_write_flush(rdma) < 0) {
+    if (qemu_rdma_write_flush(rdma, &err) < 0) {
+        error_report_err(err);
         return -1;
     }
 
-- 
2.41.0


