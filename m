Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7AB7B1E3C
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwl-0003fK-L9; Thu, 28 Sep 2023 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwX-0003YT-TQ
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwN-0008FQ-UC
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFRv12GNg6KBmUOKNaXYFzMwOCG24lFNbPGy3s8wZ7I=;
 b=epoCsH4FbckmaSSB6ruj4DSIq5/IC5kXjEja7uKs30Wma6ytLISyrt/p35pUwg6bPspNtH
 VLLxjfzMcm2YBSevw1CtIYp2OvSZcdQbaPp2soeU384em0x0H9mBVzZwiezJJR1bed8etE
 KEDFMAyoNkBhr/QgZaDQbT6eIAtdMIY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-QS_T2bSON6CtWpnm4OSwkA-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: QS_T2bSON6CtWpnm4OSwkA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75477280A9CB;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35C8814171CA;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E55021E688D; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 28/53] migration/rdma: Drop superfluous assignments to @ret
Date: Thu, 28 Sep 2023 15:19:54 +0200
Message-ID: <20230928132019.2544702-29-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d92be4869a..2af9395696 100644
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
@@ -2871,7 +2870,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
     RDMAContext *rdma;
     RDMAControlHeader head;
-    int ret = 0;
+    int ret;
     ssize_t done = 0;
     size_t i, len;
 
@@ -3371,7 +3370,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     RDMAContext *rdma_return_path = NULL;
     struct rdma_cm_event *cm_event;
     struct ibv_context *verbs;
-    int ret = -EINVAL;
+    int ret;
     int idx;
 
     ret = rdma_get_cm_event(rdma->channel, &cm_event);
@@ -3381,7 +3380,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
 
     if (cm_event->event != RDMA_CM_EVENT_CONNECT_REQUEST) {
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3394,7 +3392,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         rdma_return_path = qemu_rdma_data_init(rdma->host_port, NULL);
         if (rdma_return_path == NULL) {
             rdma_ack_cm_event(cm_event);
-            ret = -1;
             goto err_rdma_dest_wait;
         }
 
@@ -3409,7 +3406,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         error_report("Unknown source RDMA version: %d, bailing...",
                      cap.version);
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3442,7 +3438,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     } else if (rdma->verbs != verbs) {
         error_report("ibv context not matching %p, %p!", rdma->verbs,
                      verbs);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3496,7 +3491,6 @@ static int qemu_rdma_accept(RDMAContext *rdma)
     if (cm_event->event != RDMA_CM_EVENT_ESTABLISHED) {
         error_report("rdma_accept not event established");
         rdma_ack_cm_event(cm_event);
-        ret = -1;
         goto err_rdma_dest_wait;
     }
 
@@ -3559,7 +3553,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     static RDMARegisterResult results[RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE];
     RDMALocalBlock *block;
     void *host_addr;
-    int ret = 0;
+    int ret;
     int idx = 0;
     int count = 0;
     int i = 0;
@@ -3588,7 +3582,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
         if (head.repeat > RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE) {
             error_report("rdma: Too many requests in this message (%d)."
                             "Bailing.", head.repeat);
-            ret = -EIO;
             break;
         }
 
@@ -3604,7 +3597,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 error_report("rdma: 'compress' bad block index %u (vs %d)",
                              (unsigned int)comp->block_idx,
                              rdma->local_ram_blocks.nb_blocks);
-                ret = -EIO;
                 goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
@@ -3703,7 +3695,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                     error_report("rdma: 'register' bad block index %u (vs %d)",
                                  (unsigned int)reg->current_index,
                                  rdma->local_ram_blocks.nb_blocks);
-                    ret = -ENOENT;
                     goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
@@ -3713,7 +3704,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             " offset: %" PRIx64 " current_addr: %" PRIx64,
                             block->block_name, block->offset,
                             reg->key.current_addr);
-                        ret = -ERANGE;
                         goto err;
                     }
                     host_addr = (block->local_host_addr +
@@ -3729,7 +3719,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                         error_report("rdma: bad chunk for block %s"
                             " chunk: %" PRIx64,
                             block->block_name, reg->key.chunk);
-                        ret = -ERANGE;
                         goto err;
                     }
                 }
@@ -3741,7 +3730,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             (uintptr_t)host_addr, NULL, &tmp_rkey,
                             chunk, chunk_start, chunk_end)) {
                     error_report("cannot get rkey");
-                    ret = -EINVAL;
                     goto err;
                 }
                 reg_result->rkey = tmp_rkey;
@@ -3781,7 +3769,6 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
                 if (ret != 0) {
                     perror("rdma unregistration chunk failed");
-                    ret = -ret;
                     goto err;
                 }
 
@@ -3800,11 +3787,9 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
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
@@ -3908,7 +3893,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
-    int ret = 0;
+    int ret;
 
     if (migration_in_postcopy()) {
         return 0;
@@ -4182,7 +4167,7 @@ void rdma_start_outgoing_migration(void *opaque,
     MigrationState *s = opaque;
     RDMAContext *rdma_return_path = NULL;
     RDMAContext *rdma;
-    int ret = 0;
+    int ret;
 
     /* Avoid ram_block_discard_disable(), cannot change during migration. */
     if (ram_block_discard_is_required()) {
-- 
2.41.0


