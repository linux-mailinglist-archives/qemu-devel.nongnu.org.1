Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AADA715E1D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xxI-0006tj-2m; Tue, 30 May 2023 07:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwV-0005Yz-28
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwO-0000Er-11
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ori2HeU5LwHHa0GmaDNf7uNrmJVs2fJ9kjhRycn77n4=;
 b=b0xnm31TCi/95nyhHejkQN1QXsCffbXLVCbvgo6xK4aA1Hj1ZKRgA27krniaIZf+L35mbB
 GWijsuKgpgqlU4VUJWTvBdBAYJl8hjvFvxajkoXhDESGn1DQ4TmIH1T+hT8whoEzmGCk3t
 0JjNcdygejEtZaHZySRbXOJjQXQZj0M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-sqf_dDnRPReti0_aIvOarQ-1; Tue, 30 May 2023 07:55:01 -0400
X-MC-Unique: sqf_dDnRPReti0_aIvOarQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0499381D1EC
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:54:59 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE3F440C6EC4;
 Tue, 30 May 2023 11:54:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 20/21] migration/rdma: Remove qemu_ prefix from exported
 functions
Date: Tue, 30 May 2023 13:54:28 +0200
Message-Id: <20230530115429.1998-21-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Functions are long enough even without this.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230509120700.78359-10-quintela@redhat.com>
---
 migration/rdma.h       | 12 ++++++------
 migration/ram.c        | 14 +++++++-------
 migration/rdma.c       | 40 +++++++++++++++++++---------------------
 migration/trace-events | 28 ++++++++++++++--------------
 4 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/migration/rdma.h b/migration/rdma.h
index 9f3ace0900..9b28736902 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -42,16 +42,16 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp);
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
 #ifdef CONFIG_RDMA
-int qemu_rdma_registration_handle(QEMUFile *f);
-int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
-int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags);
+int rdma_registration_handle(QEMUFile *f);
+int rdma_registration_start(QEMUFile *f, uint64_t flags);
+int rdma_registration_stop(QEMUFile *f, uint64_t flags);
 int rdma_block_notification_handle(QEMUFile *f, const char *name);
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size);
 #else
-int qemu_rdma_registration_handle(QEMUFile *f) { return 0; }
-int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
-int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
+int rdma_registration_handle(QEMUFile *f) { return 0; }
+int rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
+int rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
 int rdma_block_notification_handle(QEMUFile *f, const char *name) { return 0; }
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size) { return false; }
diff --git a/migration/ram.c b/migration/ram.c
index 83da952823..87fc504674 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3013,12 +3013,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         }
     }
 
-    ret = qemu_rdma_registration_start(f, RAM_CONTROL_SETUP);
+    ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
     }
 
-    ret = qemu_rdma_registration_stop(f, RAM_CONTROL_SETUP);
+    ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
     }
@@ -3080,7 +3080,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         /* Read version before ram_list.blocks */
         smp_rmb();
 
-        ret = qemu_rdma_registration_start(f, RAM_CONTROL_ROUND);
+        ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
@@ -3140,7 +3140,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      * Must occur before EOS (or any QEMUFile operation)
      * because of RDMA protocol.
      */
-    ret = qemu_rdma_registration_stop(f, RAM_CONTROL_ROUND);
+    ret = rdma_registration_stop(f, RAM_CONTROL_ROUND);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
     }
@@ -3191,7 +3191,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
             migration_bitmap_sync_precopy(rs, true);
         }
 
-        ret = qemu_rdma_registration_start(f, RAM_CONTROL_FINISH);
+        ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
@@ -3217,7 +3217,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
         ram_flush_compressed_data(rs);
 
-        int ret = qemu_rdma_registration_stop(f, RAM_CONTROL_FINISH);
+        int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
@@ -4026,7 +4026,7 @@ static int ram_load_precopy(QEMUFile *f)
             }
             break;
         case RAM_SAVE_FLAG_HOOK:
-            ret = qemu_rdma_registration_handle(f);
+            ret = rdma_registration_handle(f);
             if (ret < 0) {
                 qemu_file_set_error(f, ret);
             }
diff --git a/migration/rdma.c b/migration/rdma.c
index b85259263a..cf0681575d 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3549,7 +3549,7 @@ static int dest_ram_sort_func(const void *a, const void *b)
  *
  * Keep doing this until the source tells us to stop.
  */
-int qemu_rdma_registration_handle(QEMUFile *f)
+int rdma_registration_handle(QEMUFile *f)
 {
     RDMAControlHeader reg_resp = { .len = sizeof(RDMARegisterResult),
                                .type = RDMA_CONTROL_REGISTER_RESULT,
@@ -3591,7 +3591,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
     local = &rdma->local_ram_blocks;
     do {
-        trace_qemu_rdma_registration_handle_wait();
+        trace_rdma_registration_handle_wait();
 
         ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_NONE);
 
@@ -3611,9 +3611,9 @@ int qemu_rdma_registration_handle(QEMUFile *f)
             comp = (RDMACompress *) rdma->wr_data[idx].control_curr;
             network_to_compress(comp);
 
-            trace_qemu_rdma_registration_handle_compress(comp->length,
-                                                         comp->block_idx,
-                                                         comp->offset);
+            trace_rdma_registration_handle_compress(comp->length,
+                                                    comp->block_idx,
+                                                    comp->offset);
             if (comp->block_idx >= rdma->local_ram_blocks.nb_blocks) {
                 error_report("rdma: 'compress' bad block index %u (vs %d)",
                              (unsigned int)comp->block_idx,
@@ -3630,11 +3630,11 @@ int qemu_rdma_registration_handle(QEMUFile *f)
             break;
 
         case RDMA_CONTROL_REGISTER_FINISHED:
-            trace_qemu_rdma_registration_handle_finished();
+            trace_rdma_registration_handle_finished();
             goto out;
 
         case RDMA_CONTROL_RAM_BLOCKS_REQUEST:
-            trace_qemu_rdma_registration_handle_ram_blocks();
+            trace_rdma_registration_handle_ram_blocks();
 
             /* Sort our local RAM Block list so it's the same as the source,
              * we can do this since we've filled in a src_index in the list
@@ -3674,7 +3674,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
                 rdma->dest_blocks[i].length = local->block[i].length;
 
                 dest_block_to_network(&rdma->dest_blocks[i]);
-                trace_qemu_rdma_registration_handle_ram_blocks_loop(
+                trace_rdma_registration_handle_ram_blocks_loop(
                     local->block[i].block_name,
                     local->block[i].offset,
                     local->block[i].length,
@@ -3696,7 +3696,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
             break;
         case RDMA_CONTROL_REGISTER_REQUEST:
-            trace_qemu_rdma_registration_handle_register(head.repeat);
+            trace_rdma_registration_handle_register(head.repeat);
 
             reg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
@@ -3710,7 +3710,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
                 reg_result = &results[count];
 
-                trace_qemu_rdma_registration_handle_register_loop(count,
+                trace_rdma_registration_handle_register_loop(count,
                          reg->current_index, reg->key.current_addr, reg->chunks);
 
                 if (reg->current_index >= rdma->local_ram_blocks.nb_blocks) {
@@ -3762,8 +3762,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
                 reg_result->host_addr = (uintptr_t)block->local_host_addr;
 
-                trace_qemu_rdma_registration_handle_register_rkey(
-                                                           reg_result->rkey);
+                trace_rdma_registration_handle_register_rkey(reg_result->rkey);
 
                 result_to_network(reg_result);
             }
@@ -3777,7 +3776,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
             }
             break;
         case RDMA_CONTROL_UNREGISTER_REQUEST:
-            trace_qemu_rdma_registration_handle_unregister(head.repeat);
+            trace_rdma_registration_handle_unregister(head.repeat);
             unreg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
@@ -3785,7 +3784,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
                 reg = &registers[count];
                 network_to_register(reg);
 
-                trace_qemu_rdma_registration_handle_unregister_loop(count,
+                trace_rdma_registration_handle_unregister_loop(count,
                            reg->current_index, reg->key.chunk);
 
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
@@ -3801,8 +3800,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
                 rdma->total_registrations--;
 
-                trace_qemu_rdma_registration_handle_unregister_success(
-                                                       reg->key.chunk);
+                trace_rdma_registration_handle_unregister_success(reg->key.chunk);
             }
 
             ret = qemu_rdma_post_send_control(rdma, NULL, &unreg_resp);
@@ -3873,7 +3871,7 @@ int rdma_block_notification_handle(QEMUFile *f, const char *name)
     return 0;
 }
 
-int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
+int rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
@@ -3890,7 +3888,7 @@ int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
 
     CHECK_ERROR_STATE();
 
-    trace_qemu_rdma_registration_start(flags);
+    trace_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     qemu_fflush(f);
 
@@ -3901,7 +3899,7 @@ int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
  * Inform dest that dynamic registrations are done for now.
  * First, flush writes, if any.
  */
-int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
+int rdma_registration_stop(QEMUFile *f, uint64_t flags)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
@@ -3933,7 +3931,7 @@ int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
         int reg_result_idx, i, nb_dest_blocks;
 
         head.type = RDMA_CONTROL_RAM_BLOCKS_REQUEST;
-        trace_qemu_rdma_registration_stop_ram();
+        trace_rdma_registration_stop_ram();
 
         /*
          * Make sure that we parallelize the pinning on both sides.
@@ -3995,7 +3993,7 @@ int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
         }
     }
 
-    trace_qemu_rdma_registration_stop(flags);
+    trace_rdma_registration_stop(flags);
 
     head.type = RDMA_CONTROL_REGISTER_FINISHED;
     ret = qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL);
diff --git a/migration/trace-events b/migration/trace-events
index 54ae5653fd..5ad9d9edbe 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -224,20 +224,6 @@ qemu_rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
 qemu_rdma_register_and_get_keys(uint64_t len, void *start) "Registering %" PRIu64 " bytes @ %p"
 qemu_rdma_register_odp_mr(const char *name) "Try to register On-Demand Paging memory region: %s"
 qemu_rdma_advise_mr(const char *name, uint32_t len, uint64_t addr, const char *res) "Try to advise block %s prefetch at %" PRIu32 "@0x%" PRIx64 ": %s"
-qemu_rdma_registration_handle_compress(int64_t length, int index, int64_t offset) "Zapping zero chunk: %" PRId64 " bytes, index %d, offset %" PRId64
-qemu_rdma_registration_handle_finished(void) ""
-qemu_rdma_registration_handle_ram_blocks(void) ""
-qemu_rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint64_t length, void *local_host_addr, unsigned int src_index) "%s: @0x%" PRIx64 "/%" PRIu64 " host:@%p src_index: %u"
-qemu_rdma_registration_handle_register(int requests) "%d requests"
-qemu_rdma_registration_handle_register_loop(int req, int index, uint64_t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PRIu64 " chunks: %" PRIu64
-qemu_rdma_registration_handle_register_rkey(int rkey) "0x%x"
-qemu_rdma_registration_handle_unregister(int requests) "%d requests"
-qemu_rdma_registration_handle_unregister_loop(int count, int index, uint64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
-qemu_rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
-qemu_rdma_registration_handle_wait(void) ""
-qemu_rdma_registration_start(uint64_t flags) "%" PRIu64
-qemu_rdma_registration_stop(uint64_t flags) "%" PRIu64
-qemu_rdma_registration_stop_ram(void) ""
 qemu_rdma_resolve_host_trying(const char *host, const char *ip) "Trying %s => %s"
 qemu_rdma_signal_unregister_append(uint64_t chunk, int pos) "Appending unregister chunk %" PRIu64 " at position %d"
 qemu_rdma_signal_unregister_already(uint64_t chunk) "Unregister chunk %" PRIu64 " already in queue"
@@ -256,6 +242,20 @@ qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "En
 rdma_add_block(const char *block_name, int block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Added Block: '%s':%d, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
 rdma_block_notification_handle(const char *name, int index) "%s at %d"
 rdma_delete_block(void *block, uint64_t addr, uint64_t offset, uint64_t len, uint64_t end, uint64_t bits, int chunks) "Deleted Block: %p, addr: %" PRIu64 ", offset: %" PRIu64 " length: %" PRIu64 " end: %" PRIu64 " bits %" PRIu64 " chunks %d"
+rdma_registration_handle_compress(int64_t length, int index, int64_t offset) "Zapping zero chunk: %" PRId64 " bytes, index %d, offset %" PRId64
+rdma_registration_handle_finished(void) ""
+rdma_registration_handle_ram_blocks(void) ""
+rdma_registration_handle_ram_blocks_loop(const char *name, uint64_t offset, uint64_t length, void *local_host_addr, unsigned int src_index) "%s: @0x%" PRIx64 "/%" PRIu64 " host:@%p src_index: %u"
+rdma_registration_handle_register(int requests) "%d requests"
+rdma_registration_handle_register_loop(int req, int index, uint64_t addr, uint64_t chunks) "Registration request (%d): index %d, current_addr %" PRIu64 " chunks: %" PRIu64
+rdma_registration_handle_register_rkey(int rkey) "0x%x"
+rdma_registration_handle_unregister(int requests) "%d requests"
+rdma_registration_handle_unregister_loop(int count, int index, uint64_t chunk) "Unregistration request (%d): index %d, chunk %" PRIu64
+rdma_registration_handle_unregister_success(uint64_t chunk) "%" PRIu64
+rdma_registration_handle_wait(void) ""
+rdma_registration_start(uint64_t flags) "%" PRIu64
+rdma_registration_stop(uint64_t flags) "%" PRIu64
+rdma_registration_stop_ram(void) ""
 rdma_start_incoming_migration(void) ""
 rdma_start_incoming_migration_after_dest_init(void) ""
 rdma_start_incoming_migration_after_rdma_listen(void) ""
-- 
2.40.1


