Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D7C7A4B20
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSw-0003Af-Bf; Mon, 18 Sep 2023 10:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSJ-0002wp-QU
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002c3-MX
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeBT8Hn8XJQ6c1Y79NelGYSFYQUD6nVYE8uS3ifobCE=;
 b=hneHU3+wS1wcbku/rhxwTqOoTML0owKhvmzb+RSWMlU1viP2MJ7YFJh5ca/XEuMqKvYTE1
 a2ImfShFcoYUyDGMErOhAbI/qkADti4SuUhlH2KbTtZOavxKUd9j5I0+2h9DOvTnUI3O4v
 lzlpoEv1ZV3k9OA9mXmsGl+Gs8YUmkw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-RlD1gWOHM5eeBopOOxGVEQ-1; Mon, 18 Sep 2023 10:42:11 -0400
X-MC-Unique: RlD1gWOHM5eeBopOOxGVEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 468913800BA4
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 247CE40C2064
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5CB1F21E689C; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 40/52] migration/rdma: Convert qemu_rdma_write() to Error
Date: Mon, 18 Sep 2023 16:41:54 +0200
Message-ID: <20230918144206.560120-41-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Just for consistency with qemu_rdma_write_one() and
qemu_rdma_write_flush(), and for slightly simpler code.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 9b8cbadfcd..5bb78a6ad8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2320,9 +2320,8 @@ static inline bool qemu_rdma_buffer_mergable(RDMAContext *rdma,
  */
 static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
                            uint64_t block_offset, uint64_t offset,
-                           uint64_t len)
+                           uint64_t len, Error **errp)
 {
-    Error *err = NULL;
     uint64_t current_addr = block_offset + offset;
     uint64_t index = rdma->current_index;
     uint64_t chunk = rdma->current_chunk;
@@ -2330,9 +2329,8 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
-        ret = qemu_rdma_write_flush(f, rdma, &err);
+        ret = qemu_rdma_write_flush(f, rdma, errp);
         if (ret < 0) {
-            error_report_err(err);
             return -1;
         }
         rdma->current_length = 0;
@@ -2349,10 +2347,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
     /* flush it if buffer is too large */
     if (rdma->current_length >= RDMA_MERGE_MAX) {
-        if (qemu_rdma_write_flush(f, rdma, &err) < 0) {
-            error_report_err(err);
-            return -1;
-        }
+        return qemu_rdma_write_flush(f, rdma, errp);
     }
 
     return 0;
@@ -3248,6 +3243,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
                                   size_t size, uint64_t *bytes_sent)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    Error *err = NULL;
     RDMAContext *rdma;
     int ret;
 
@@ -3273,9 +3269,9 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
      * is full, or the page doesn't belong to the current chunk,
      * an actual RDMA write will occur and a new chunk will be formed.
      */
-    ret = qemu_rdma_write(f, rdma, block_offset, offset, size);
+    ret = qemu_rdma_write(f, rdma, block_offset, offset, size, &err);
     if (ret < 0) {
-        error_report("rdma migration: write error");
+        error_report_err(err);
         goto err;
     }
 
-- 
2.41.0


