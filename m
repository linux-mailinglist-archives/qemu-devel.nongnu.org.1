Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C184E7A4B2B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:45:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSO-00030F-OU; Mon, 18 Sep 2023 10:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSD-0002tH-4K
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS2-0002bL-Ie
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0pMzbKeYA2mBaiKQm70INKSazOiYyzJPBPalzfExC70=;
 b=gSCZtYbOPNjumeQIqIoeDmX99Mw8avQo1MpPPDBxzvj/yNwMdY02ZeVvQ0/xr2dfUVJgg3
 /6b2PTMO3PbHvp3ik/zaTXuDaGy9ffTsz8DFO5BnHbiuj08wT0LMnwFAlgO/zpdFFmyypU
 IGJTNXZSsdD0cErbgmXJZSxZHM9U528=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-uV2CpbFcNIOk13b4nX4yDw-1; Mon, 18 Sep 2023 10:42:10 -0400
X-MC-Unique: uV2CpbFcNIOk13b4nX4yDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FF233800BB3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 320CFC15BB8
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 372E121E688A; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 27/52] migration/rdma: Drop superfluous assignments to @ret
Date: Mon, 18 Sep 2023 16:41:41 +0200
Message-ID: <20230918144206.560120-28-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 85f6b274bf..62d95b7d2c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1514,7 +1514,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                                        struct ibv_comp_channel *comp_channel)
 {
     struct rdma_cm_event *cm_event;
-    int ret = -1;
+    int ret;
 
     /*
      * Coroutine doesn't start until migration_fd_process_incoming()
@@ -1619,7 +1619,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
                                     uint64_t wrid_requested,
                                     uint32_t *byte_len)
 {
-    int num_cq_events = 0, ret = 0;
+    int num_cq_events = 0, ret;
     struct ibv_cq *cq;
     void *cq_ctx;
     uint64_t wr_id = RDMA_WRID_NONE, wr_id_in;
@@ -1664,8 +1664,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
 
         num_cq_events++;
 
-        ret = -ibv_req_notify_cq(cq, 0);
-        if (ret) {
+        if (ibv_req_notify_cq(cq, 0)) {
             goto err_block_for_wrid;
         }
 
@@ -1712,7 +1711,7 @@ err_block_for_wrid:
 static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
                                        RDMAControlHeader *head)
 {
-    int ret = 0;
+    int ret;
     RDMAWorkRequestData *wr = &rdma->wr_data[RDMA_WRID_CONTROL];
     struct ibv_send_wr *bad_wr;
     struct ibv_sge sge = {
@@ -1869,7 +1868,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                    int *resp_idx,
                                    int (*callback)(RDMAContext *rdma))
 {
-    int ret = 0;
+    int ret;
 
     /*
      * Wait until the dest is ready before attempting to deliver the message
@@ -2841,7 +2840,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
     RDMAContext *rdma;
     RDMAControlHeader head;
-    int ret = 0;
+    int ret;
     size_t i;
     size_t done = 0;
 
@@ -3340,7 +3339,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     RDMAContext *rdma_return_path = NULL;
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
-    int ret = -EINVAL;
+    int ret;
     int idx;
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
@@ -3350,7 +3349,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     if (cm_event->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3363,7 +3361,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
-            ret = -1;
             goto err_rdma_dest_wait;
         }
 
@@ -3378,7 +3375,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         error_report("Unknown source RDMA version: %d, bailing...",
                      cap.version);
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3411,7 +3407,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     } else if (rdma->verbs != verbs) {
         error_report("ibv context not matching %p, %p!", rdma->verbs,
                      verbs);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3465,7 +3460,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
         error_report("rdma_accept not event established");
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3528,7 +3522,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     static RDMARegisterResult results[RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE];
     RDMALocalBlock *block;
     void *host_addr;
-    int ret = 0;
+    int ret;
     int idx = 0;
     int count = 0;
     int i = 0;
@@ -3557,7 +3551,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
         if (head.repeat > RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE) {
             error_report("rdma: Too many requests in this message (%d)."
                             "Bailing.", head.repeat);
-            ret = -EIO;
             break;
         }
 
@@ -3573,7 +3566,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 error_report("rdma: 'compress' bad block index %u (vs %d)",
                              (unsigned int)comp->block_idx,
                              rdma->local_ram_blocks.nb_blocks);
-                ret = -EIO;
                 goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
@@ -3672,7 +3664,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                     error_report("rdma: 'register' bad block index %u (vs %d)",
                                  (unsigned int)reg->current_index,
                                  rdma->local_ram_blocks.nb_blocks);
-                    ret = -ENOENT;
                     goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
@@ -3682,7 +3673,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             " offset: %" PRIx64 " current_addr: %" PRIx64,
                             block->block_name, block->offset,
                             reg->key.current_addr);
-                        ret = -ERANGE;
                         goto err;
                     }
                     host_addr = (block->local_host_addr +
@@ -3698,7 +3688,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                         error_report("rdma: bad chunk for block %s"
                             " chunk: %" PRIx64,
                             block->block_name, reg->key.chunk);
-                        ret = -ERANGE;
                         goto err;
                     }
                 }
@@ -3710,7 +3699,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             (uintptr_t)host_addr, NULL, &tmp_rkey,
                             chunk, chunk_start, chunk_end)) {
                     error_report("cannot get rkey");
-                    ret = -EINVAL;
                     goto err;
                 }
                 reg_result->rkey = tmp_rkey;
@@ -3750,7 +3738,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
                 if (ret != 0) {
                     perror("rdma unregistration chunk failed");
-                    ret = -ret;
                     goto err;
                 }
 
@@ -3769,11 +3756,9 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
             break;
         case RDMA_CONTROL_REGISTER_RESULT:
             error_report("Invalid RESULT message at dest.");
-            ret = -EIO;
             goto err;
         default:
             error_report("Unknown control message %s", control_desc(head.type));
-            ret = -EIO;
             goto err;
         }
     } while (1);
@@ -3877,7 +3862,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
-    int ret = 0;
+    int ret;
 
     if (migration_in_postcopy()) {
         return 0;
@@ -4151,7 +4136,7 @@ void rdma_start_outgoing_migration(void *opaque,
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
     RDMAContext *rdma;
-    int ret = 0;
+    int ret;
 
     /* Avoid ram_block_discard_disable(), cannot change during migration. */
     if (ram_block_discard_is_required()) {
-- 
2.41.0


