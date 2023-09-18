Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B835E7A4B37
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFTL-0003xi-VA; Mon, 18 Sep 2023 10:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSP-000322-N0
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bm-JZ
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BL9WYdXxTscBZywRpqYSAaoVP+1Fl8ztB8ed+TAoURg=;
 b=OJAd/sT/wJlNSXF4Yo9vBkRpb0R8n+wHJhic0prW9ElN1MSSBSFMqfMIsDfCI+3PEHzsyf
 uLIl5PCxBenPvNWDsDFDK7STQ35PvaxFcE2w5ibq1EsIR/xdIDRWariS+tnCZ91TCiy72d
 FOO1KvHuQhfTJb2/k9AfRbeWWrYtrxo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-3bQHLdr5NW2a03fj9rz65g-1; Mon, 18 Sep 2023 10:42:11 -0400
X-MC-Unique: 3bQHLdr5NW2a03fj9rz65g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BCDA3800BA1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18E744011E4
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 570FF21E689A; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 38/52] migration/rdma: Convert qemu_rdma_write_flush() to Error
Date: Mon, 18 Sep 2023 16:41:52 +0200
Message-ID: <20230918144206.560120-39-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

qio_channel_rdma_writev() violates this principle: it calls
error_report() via qemu_rdma_write_flush().  I elected not to
investigate how callers handle the error, i.e. precise impact is not
known.

Clean this up by converting qemu_rdma_write_flush() to Error.

Necessitates setting an error when qemu_rdma_write_one() failed.
Since this error will go away later in this series, simply use "FIXME
temporary error message" there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index f1cd659a1f..c3c33fe242 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2238,7 +2238,8 @@ retry:
  * We support sending out multiple chunks at the same time.
  * Not all of them need to get signaled in the completion queue.
  */
-static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
+static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma,
+                                 Error **errp)
 {
     int ret;
 
@@ -2250,6 +2251,7 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
             rdma->current_index, rdma->current_addr, rdma->current_length);
 
     if (ret < 0) {
+        error_setg(errp, "FIXME temporary error message");
         return -1;
     }
 
@@ -2323,6 +2325,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
                            uint64_t block_offset, uint64_t offset,
                            uint64_t len)
 {
+    Error *err = NULL;
     uint64_t current_addr = block_offset + offset;
     uint64_t index = rdma->current_index;
     uint64_t chunk = rdma->current_chunk;
@@ -2330,8 +2333,9 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
-        ret = qemu_rdma_write_flush(f, rdma);
+        ret = qemu_rdma_write_flush(f, rdma, &err);
         if (ret < 0) {
+            error_report_err(err);
             return -1;
         }
         rdma->current_length = 0;
@@ -2348,7 +2352,10 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
     /* flush it if buffer is too large */
     if (rdma->current_length >= RDMA_MERGE_MAX) {
-        return qemu_rdma_write_flush(f, rdma);
+        if (qemu_rdma_write_flush(f, rdma, &err) < 0) {
+            error_report_err(err);
+            return -1;
+        }
     }
 
     return 0;
@@ -2809,10 +2816,9 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
      * Push out any writes that
      * we're queued up for VM's ram.
      */
-    ret = qemu_rdma_write_flush(f, rdma);
+    ret = qemu_rdma_write_flush(f, rdma, errp);
     if (ret < 0) {
         rdma->errored = true;
-        error_setg(errp, "qemu_rdma_write_flush failed");
         return -1;
     }
 
@@ -2954,9 +2960,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
  */
 static int qemu_rdma_drain_cq(QEMUFile *f, RDMAContext *rdma)
 {
+    Error *err = NULL;
     int ret;
 
-    if (qemu_rdma_write_flush(f, rdma) < 0) {
+    if (qemu_rdma_write_flush(f, rdma, &err) < 0) {
+        error_report_err(err);
         return -1;
     }
 
-- 
2.41.0


