Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ECA703E07
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:00:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeLF-00021C-4D; Mon, 15 May 2023 15:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKu-0001Qh-TO
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyeKs-0005Ww-LO
 for qemu-devel@nongnu.org; Mon, 15 May 2023 15:58:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684180700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vhk6rop+cTT+GAlqjeKDryhAk2ZhYNKypyyyjbsJ6QQ=;
 b=bhd0mzL4uuzUz4GzYETUScNCsPfEfgY1PrQJcSbQq9NJdEMWgZbYCCzAmBO5ut1bUzaANk
 RsJcv2Zy0fjUnyLxt2pLD1J/bQtoxlSJNYQxIfeLxTZQ91BazT4uApkB4Bal8GTlP0o52L
 TeaAYnXY0oRIE6c39ss4VHKqMy6peQQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-WxE2cb3uN0y0jLb3LYYmRQ-1; Mon, 15 May 2023 15:58:11 -0400
X-MC-Unique: WxE2cb3uN0y0jLb3LYYmRQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3559101A555;
 Mon, 15 May 2023 19:58:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03F9D492B00;
 Mon, 15 May 2023 19:58:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v2 12/16] migration/rdma: Remove QEMUFile parameter when not
 used
Date: Mon, 15 May 2023 21:57:05 +0200
Message-Id: <20230515195709.63843-13-quintela@redhat.com>
In-Reply-To: <20230515195709.63843-1-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 074456f9df..416dec00a2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2027,7 +2027,7 @@ static int qemu_rdma_exchange_recv(RDMAContext *rdma, RDMAControlHeader *head,
  * If we're using dynamic registration on the dest-side, we have to
  * send a registration command first.
  */
-static int qemu_rdma_write_one(QEMUFile *f, RDMAContext *rdma,
+static int qemu_rdma_write_one(RDMAContext *rdma,
                                int current_index, uint64_t current_addr,
                                uint64_t length)
 {
@@ -2263,7 +2263,7 @@ retry:
  * We support sending out multiple chunks at the same time.
  * Not all of them need to get signaled in the completion queue.
  */
-static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
+static int qemu_rdma_write_flush(RDMAContext *rdma)
 {
     int ret;
 
@@ -2271,7 +2271,7 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAContext *rdma)
         return 0;
     }
 
-    ret = qemu_rdma_write_one(f, rdma,
+    ret = qemu_rdma_write_one(rdma,
             rdma->current_index, rdma->current_addr, rdma->current_length);
 
     if (ret < 0) {
@@ -2344,7 +2344,7 @@ static inline int qemu_rdma_buffer_mergable(RDMAContext *rdma,
  *    and only require that a batch gets acknowledged in the completion
  *    queue instead of each individual chunk.
  */
-static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
+static int qemu_rdma_write(RDMAContext *rdma,
                            uint64_t block_offset, uint64_t offset,
                            uint64_t len)
 {
@@ -2355,7 +2355,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergable(rdma, current_addr, len)) {
-        ret = qemu_rdma_write_flush(f, rdma);
+        ret = qemu_rdma_write_flush(rdma);
         if (ret) {
             return ret;
         }
@@ -2377,7 +2377,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
 
     /* flush it if buffer is too large */
     if (rdma->current_length >= RDMA_MERGE_MAX) {
-        return qemu_rdma_write_flush(f, rdma);
+        return qemu_rdma_write_flush(rdma);
     }
 
     return 0;
@@ -2798,7 +2798,6 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
                                        Error **errp)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
-    QEMUFile *f = rioc->file;
     RDMAContext *rdma;
     int ret;
     ssize_t done = 0;
@@ -2819,7 +2818,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
      * Push out any writes that
      * we're queued up for VM's ram.
      */
-    ret = qemu_rdma_write_flush(f, rdma);
+    ret = qemu_rdma_write_flush(rdma);
     if (ret < 0) {
         rdma->error_state = ret;
         error_setg(errp, "qemu_rdma_write_flush returned %d", ret);
@@ -2958,11 +2957,11 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
 /*
  * Block until all the outstanding chunks have been delivered by the hardware.
  */
-static int qemu_rdma_drain_cq(QEMUFile *f, RDMAContext *rdma)
+static int qemu_rdma_drain_cq(RDMAContext *rdma)
 {
     int ret;
 
-    if (qemu_rdma_write_flush(f, rdma) < 0) {
+    if (qemu_rdma_write_flush(rdma) < 0) {
         return -EIO;
     }
 
@@ -3272,7 +3271,7 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
      * is full, or the page doesn't belong to the current chunk,
      * an actual RDMA write will occur and a new chunk will be formed.
      */
-    ret = qemu_rdma_write(f, rdma, block_offset, offset, size);
+    ret = qemu_rdma_write(rdma, block_offset, offset, size);
     if (ret < 0) {
         error_report("rdma migration: write error! %d", ret);
         goto err;
@@ -3927,7 +3926,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     CHECK_ERROR_STATE();
 
     qemu_fflush(f);
-    ret = qemu_rdma_drain_cq(f, rdma);
+    ret = qemu_rdma_drain_cq(rdma);
 
     if (ret < 0) {
         goto err;
-- 
2.40.1


