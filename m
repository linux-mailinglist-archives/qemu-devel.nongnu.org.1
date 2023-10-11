Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF197C4E7C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVRH-00017X-0b; Wed, 11 Oct 2023 05:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRF-0000gz-2b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRB-00053P-K6
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jr0Xwgqq3rv+fKxRN0WQh7d3Hj0a0pDVdiMkkv7dIpI=;
 b=B6N4i8lhHbOqRhkp1eWuA91YIDmIZ38Nlrt7dtc0MlUzwM6o5wUPKUL4LJ/nfxrknKFd7/
 9e/24N19hZYwX+UlzJid+onemEfkoeDN8UpM3RGLnq/5t1Ed75EhZP+9JDp5akLvbkZ06l
 3Om8bUvkJXneWvfo9NQsI1Bvor6HJaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-cOt1pZ4zPKKTFQgDnB06Kg-1; Wed, 11 Oct 2023 05:23:17 -0400
X-MC-Unique: cOt1pZ4zPKKTFQgDnB06Kg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 559EC185A79C;
 Wed, 11 Oct 2023 09:23:17 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 99F2B1C060AE;
 Wed, 11 Oct 2023 09:23:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 35/65] migration/rdma: Drop superfluous assignments to @ret
Date: Wed, 11 Oct 2023 11:21:33 +0200
Message-ID: <20231011092203.1266-36-quintela@redhat.com>
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230928132019.2544702-29-armbru@redhat.com>
---
 migration/rdma.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a57ec3791a..08a82d5e57 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1530,7 +1530,7 @@ static int qemu_rdma_wait_comp_channel(RDMAContext *rdma,
                                        struct ibv_comp_channel *comp_channel)
 {
     struct rdma_cm_event *cm_event;
-    int ret = -1;
+    int ret;
 
     /*
      * Coroutine doesn't start until migration_fd_process_incoming()
@@ -1635,7 +1635,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
                                     uint64_t wrid_requested,
                                     uint32_t *byte_len)
 {
-    int num_cq_events = 0, ret = 0;
+    int num_cq_events = 0, ret;
     struct ibv_cq *cq;
     void *cq_ctx;
     uint64_t wr_id = RDMA_WRID_NONE, wr_id_in;
@@ -1685,8 +1685,7 @@ static int qemu_rdma_block_for_wrid(RDMAContext *rdma,
 
         num_cq_events++;
 
-        ret = -ibv_req_notify_cq(cq, 0);
-        if (ret) {
+        if (ibv_req_notify_cq(cq, 0)) {
             goto err_block_for_wrid;
         }
 
@@ -1733,7 +1732,7 @@ err_block_for_wrid:
 static int qemu_rdma_post_send_control(RDMAContext *rdma, uint8_t *buf,
                                        RDMAControlHeader *head)
 {
-    int ret = 0;
+    int ret;
     RDMAWorkRequestData *wr = &rdma->wr_data[RDMA_WRID_CONTROL];
     struct ibv_send_wr *bad_wr;
     struct ibv_sge sge = {
@@ -1890,7 +1889,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
                                    int *resp_idx,
                                    int (*callback)(RDMAContext *rdma))
 {
-    int ret = 0;
+    int ret;
 
     /*
      * Wait until the dest is ready before attempting to deliver the message
@@ -2890,7 +2889,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
     RDMAContext *rdma;
     RDMAControlHeader head;
-    int ret = 0;
+    int ret;
     ssize_t done = 0;
     size_t i, len;
 
@@ -3379,7 +3378,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     RDMAContext *rdma_return_path = NULL;
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
-    int ret = -EINVAL;
+    int ret;
     int idx;
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
@@ -3389,7 +3388,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     if (cm_event->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3402,7 +3400,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
-            ret = -1;
             goto err_rdma_dest_wait;
         }
 
@@ -3417,7 +3414,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         error_report("Unknown source RDMA version: %d, bailing...",
                      cap.version);
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3450,7 +3446,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     } else if (rdma->verbs != verbs) {
         error_report("ibv context not matching %p, %p!", rdma->verbs,
                      verbs);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3504,7 +3499,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
         error_report("rdma_accept not event established");
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3567,7 +3561,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     static RDMARegisterResult results[RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE];
     RDMALocalBlock *block;
     void *host_addr;
-    int ret = 0;
+    int ret;
     int idx = 0;
     int count = 0;
     int i = 0;
@@ -3596,7 +3590,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
         if (head.repeat > RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE) {
             error_report("rdma: Too many requests in this message (%d)."
                             "Bailing.", head.repeat);
-            ret = -EIO;
             break;
         }
 
@@ -3612,7 +3605,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 error_report("rdma: 'compress' bad block index %u (vs %d)",
                              (unsigned int)comp->block_idx,
                              rdma->local_ram_blocks.nb_blocks);
-                ret = -EIO;
                 goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
@@ -3711,7 +3703,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                     error_report("rdma: 'register' bad block index %u (vs %d)",
                                  (unsigned int)reg->current_index,
                                  rdma->local_ram_blocks.nb_blocks);
-                    ret = -ENOENT;
                     goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
@@ -3721,7 +3712,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             " offset: %" PRIx64 " current_addr: %" PRIx64,
                             block->block_name, block->offset,
                             reg->key.current_addr);
-                        ret = -ERANGE;
                         goto err;
                     }
                     host_addr = (block->local_host_addr +
@@ -3737,7 +3727,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                         error_report("rdma: bad chunk for block %s"
                             " chunk: %" PRIx64,
                             block->block_name, reg->key.chunk);
-                        ret = -ERANGE;
                         goto err;
                     }
                 }
@@ -3749,7 +3738,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             (uintptr_t)host_addr, NULL, &tmp_rkey,
                             chunk, chunk_start, chunk_end)) {
                     error_report("cannot get rkey");
-                    ret = -EINVAL;
                     goto err;
                 }
                 reg_result->rkey = tmp_rkey;
@@ -3789,7 +3777,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
                 if (ret != 0) {
                     perror("rdma unregistration chunk failed");
-                    ret = -ret;
                     goto err;
                 }
 
@@ -3808,11 +3795,9 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
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
@@ -3916,7 +3901,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
-    int ret = 0;
+    int ret;
 
     if (migration_in_postcopy()) {
         return 0;
@@ -4190,7 +4175,7 @@ void rdma_start_outgoing_migration(void *opaque,
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
     RDMAContext *rdma;
-    int ret = 0;
+    int ret;
 
     /* Avoid ram_block_discard_disable(), cannot change during migration. */
     if (ram_block_discard_is_required()) {
-- 
2.41.0


