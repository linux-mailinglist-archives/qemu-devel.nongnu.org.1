Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BBD7C5E79
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfwC-0005RC-T7; Wed, 11 Oct 2023 16:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfw6-0005Oq-OG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfw1-0003CR-P1
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qtmc3KGTusy7cfgz4qom4SunS56CKsgeizxUNwC5MCc=;
 b=Mh33Wf4hrlB9B5akFk6uEuHUcNIRY5gHnzq2ZgYbZAH47YB/Pmga/kPv4dFg//TIkVHwmZ
 di0LcWcbqfDNjY/4pixoc56rE84Zrb3AtAvBgAl3TkIyPEm700StikN3kl/7So9yafhNCv
 xp8OjjndD6Xb+enPKfY43B/9tdYsJ5U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-6Ta4wqfhM6qVc3ncW0WE-A-1; Wed, 11 Oct 2023 16:35:49 -0400
X-MC-Unique: 6Ta4wqfhM6qVc3ncW0WE-A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CB34101A550;
 Wed, 11 Oct 2023 20:35:48 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3717B492B06;
 Wed, 11 Oct 2023 20:35:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 13/13] migration/rdma: Remove all "ret" variables that are
 used only once
Date: Wed, 11 Oct 2023 22:35:27 +0200
Message-ID: <20231011203527.9061-14-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-1-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
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

Change code that is:

int ret;
...

ret = foo();
if (ret[ < 0]?) {

to:

if (foo()[ < 0]) {

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a43527a83c..c382588b26 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1107,7 +1107,6 @@ err_alloc_pd_cq:
 static int qemu_rdma_alloc_qp(RDMAContext *rdma)
 {
     struct ibv_qp_init_attr attr = { 0 };
-    int ret;
 
     attr.cap.max_send_wr = RDMA_SIGNALED_SEND_MAX;
     attr.cap.max_recv_wr = 3;
@@ -1117,8 +1116,7 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
     attr.recv_cq = rdma->recv_cq;
     attr.qp_type = IBV_QPT_RC;
 
-    ret = rdma_create_qp(rdma->cm_id, rdma->pd, &attr);
-    if (ret < 0) {
+    if (rdma_create_qp(rdma->cm_id, rdma->pd, &attr) < 0) {
         return -1;
     }
 
@@ -1130,8 +1128,8 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
 static bool rdma_support_odp(struct ibv_context *dev)
 {
     struct ibv_device_attr_ex attr = {0};
-    int ret = ibv_query_device_ex(dev, NULL, &attr);
-    if (ret) {
+
+    if (ibv_query_device_ex(dev, NULL, &attr)) {
         return false;
     }
 
@@ -1508,7 +1506,6 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                                        struct ibv_comp_channel *comp_channel)
 {
     struct rdma_cm_event *cm_event;
-    int ret;
 
     /*
      * Coroutine doesn't start until migration_fd_process_incoming()
@@ -1544,8 +1541,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                 }
 
                 if (pfds[1].revents) {
-                    ret = rdma_get_cm_event(rdma->channel, &cm_event);
-                    if (ret < 0) {
+                    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
                         return -1;
                     }
 
@@ -2317,12 +2313,10 @@ static int qemu_rdma_write(RDMAContext *rdma,
     uint64_t current_addr = block_offset + offset;
     uint64_t index = rdma->current_index;
     uint64_t chunk = rdma->current_chunk;
-    int ret;
 
     /* If we cannot merge it, we flush the current buffer first. */
     if (!qemu_rdma_buffer_mergeable(rdma, current_addr, len)) {
-        ret = qemu_rdma_write_flush(rdma, errp);
-        if (ret < 0) {
+        if (qemu_rdma_write_flush(rdma, errp) < 0) {
             return -1;
         }
         rdma->current_length = 0;
@@ -2936,7 +2930,6 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
 static int qemu_rdma_drain_cq(RDMAContext *rdma)
 {
     Error *err = NULL;
-    int ret;
 
     if (qemu_rdma_write_flush(rdma, &err) < 0) {
         error_report_err(err);
@@ -2944,8 +2937,7 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
     }
 
     while (rdma->nb_sent) {
-        ret = qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL);
-        if (ret < 0) {
+        if (qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL) < 0) {
             error_report("rdma migration: complete polling error!");
             return -1;
         }
@@ -3324,12 +3316,10 @@ static void rdma_accept_incoming_migration(void *opaque);
 static void rdma_cm_poll_handler(void *opaque)
 {
     RDMAContext *rdma = opaque;
-    int ret;
     struct rdma_cm_event *cm_event;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    ret = rdma_get_cm_event(rdma->channel, &cm_event);
-    if (ret < 0) {
+    if (rdma_get_cm_event(rdma->channel, &cm_event) < 0) {
         error_report("get_cm_event failed %d", errno);
         return;
     }
@@ -4054,14 +4044,11 @@ static QEMUFile *rdma_new_output(RDMAContext *rdma)
 static void rdma_accept_incoming_migration(void *opaque)
 {
     RDMAContext *rdma = opaque;
-    int ret;
     QEMUFile *f;
     Error *local_err = NULL;
 
     trace_qemu_rdma_accept_incoming_migration();
-    ret = qemu_rdma_accept(rdma);
-
-    if (ret < 0) {
+    if (qemu_rdma_accept(rdma) < 0) {
         error_report("RDMA ERROR: Migration initialization failed");
         return;
     }
-- 
2.41.0


