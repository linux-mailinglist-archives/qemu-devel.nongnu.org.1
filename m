Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F3E7C5E73
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfvq-0005Gu-Qo; Wed, 11 Oct 2023 16:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvo-0005Gi-K5
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfvl-00033n-41
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y2LHK6VfUFbYPT3SpJ8DO+IC9lYv67yXDQXJvDfTekw=;
 b=WRHvRmy9EwGJByZxhsod2oyoJj34rmvieExWm7R25/hcd2t304+Th8Cgk/YJBxOdAw+V3L
 MvIjoBfrzSHLGgRVB4sk+f4eWCQaknt0u1LKDADTM0b5W4/0fdTndS3M2/OpSWMSMI09lt
 y3/SF3slbKyiIGw+gklBtZGHZqX+vzU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-V7gF9mTiMt-mlrCODgcVSA-1; Wed, 11 Oct 2023 16:35:43 -0400
X-MC-Unique: V7gF9mTiMt-mlrCODgcVSA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05AEC1C09A4B;
 Wed, 11 Oct 2023 20:35:43 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3C1C492B06;
 Wed, 11 Oct 2023 20:35:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 09/13] migration/rdma: Remove qemu_ prefix from exported
 functions
Date: Wed, 11 Oct 2023 22:35:23 +0200
Message-ID: <20231011203527.9061-10-quintela@redhat.com>
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

Functions are long enough even without this.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.h       | 12 ++++++------
 migration/ram.c        | 14 +++++++-------
 migration/rdma.c       | 40 +++++++++++++++++++---------------------
 migration/trace-events | 28 ++++++++++++++--------------
 4 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/migration/rdma.h b/migration/rdma.h
index 1ff3718a76..30b15b4466 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -42,19 +42,19 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp);
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
 static inline
-int qemu_rdma_registration_handle(QEMUFile *f) { return 0; }
+int rdma_registration_handle(QEMUFile *f) { return 0; }
 static inline
-int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
+int rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
 static inline
-int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
+int rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
 static inline
 int rdma_block_notification_handle(QEMUFile *f, const char *name) { return 0; }
 static inline
diff --git a/migration/ram.c b/migration/ram.c
index f9bbd17028..2f65535d05 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3063,12 +3063,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
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
@@ -3130,7 +3130,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         /* Read version before ram_list.blocks */
         smp_rmb();
 
-        ret = qemu_rdma_registration_start(f, RAM_CONTROL_ROUND);
+        ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
@@ -3190,7 +3190,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      * Must occur before EOS (or any QEMUFile operation)
      * because of RDMA protocol.
      */
-    ret = qemu_rdma_registration_stop(f, RAM_CONTROL_ROUND);
+    ret = rdma_registration_stop(f, RAM_CONTROL_ROUND);
     if (ret < 0) {
         qemu_file_set_error(f, ret);
     }
@@ -3241,7 +3241,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
             migration_bitmap_sync_precopy(rs, true);
         }
 
-        ret = qemu_rdma_registration_start(f, RAM_CONTROL_FINISH);
+        ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
@@ -3267,7 +3267,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
         ram_flush_compressed_data(rs);
 
-        int ret = qemu_rdma_registration_stop(f, RAM_CONTROL_FINISH);
+        int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
@@ -4074,7 +4074,7 @@ static int ram_load_precopy(QEMUFile *f)
             }
             break;
         case RAM_SAVE_FLAG_HOOK:
-            ret = qemu_rdma_registration_handle(f);
+            ret = rdma_registration_handle(f);
             if (ret < 0) {
                 qemu_file_set_error(f, ret);
             }
diff --git a/migration/rdma.c b/migration/rdma.c
index ca2a15be99..d3bba05262 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3541,7 +3541,7 @@ static int dest_ram_sort_func(const void *a, const void *b)
  *
  * Keep doing this until the source tells us to stop.
  */
-int qemu_rdma_registration_handle(QEMUFile *f)
+int rdma_registration_handle(QEMUFile *f)
 {
     RDMAControlHeader reg_resp = { .len = sizeof(RDMARegisterResult),
                                .type = RDMA_CONTROL_REGISTER_RESULT,
@@ -3587,7 +3587,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
     local = &rdma->local_ram_blocks;
     do {
-        trace_qemu_rdma_registration_handle_wait();
+        trace_rdma_registration_handle_wait();
 
         ret = qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_NONE, &err);
 
@@ -3607,9 +3607,9 @@ int qemu_rdma_registration_handle(QEMUFile *f)
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
@@ -3625,11 +3625,11 @@ int qemu_rdma_registration_handle(QEMUFile *f)
             break;
 
         case RDMA_CONTROL_REGISTER_FINISHED:
-            trace_qemu_rdma_registration_handle_finished();
+            trace_rdma_registration_handle_finished();
             return 0;
 
         case RDMA_CONTROL_RAM_BLOCKS_REQUEST:
-            trace_qemu_rdma_registration_handle_ram_blocks();
+            trace_rdma_registration_handle_ram_blocks();
 
             /* Sort our local RAM Block list so it's the same as the source,
              * we can do this since we've filled in a src_index in the list
@@ -3668,7 +3668,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
                 rdma->dest_blocks[i].length = local->block[i].length;
 
                 dest_block_to_network(&rdma->dest_blocks[i]);
-                trace_qemu_rdma_registration_handle_ram_blocks_loop(
+                trace_rdma_registration_handle_ram_blocks_loop(
                     local->block[i].block_name,
                     local->block[i].offset,
                     local->block[i].length,
@@ -3691,7 +3691,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
             break;
         case RDMA_CONTROL_REGISTER_REQUEST:
-            trace_qemu_rdma_registration_handle_register(head.repeat);
+            trace_rdma_registration_handle_register(head.repeat);
 
             reg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
@@ -3705,7 +3705,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
                 reg_result = &results[count];
 
-                trace_qemu_rdma_registration_handle_register_loop(count,
+                trace_rdma_registration_handle_register_loop(count,
                          reg->current_index, reg->key.current_addr, reg->chunks);
 
                 if (reg->current_index >= rdma->local_ram_blocks.nb_blocks) {
@@ -3753,8 +3753,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
                 reg_result->host_addr = (uintptr_t)block->local_host_addr;
 
-                trace_qemu_rdma_registration_handle_register_rkey(
-                                                           reg_result->rkey);
+                trace_rdma_registration_handle_register_rkey(reg_result->rkey);
 
                 result_to_network(reg_result);
             }
@@ -3768,7 +3767,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
             }
             break;
         case RDMA_CONTROL_UNREGISTER_REQUEST:
-            trace_qemu_rdma_registration_handle_unregister(head.repeat);
+            trace_rdma_registration_handle_unregister(head.repeat);
             unreg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
@@ -3776,7 +3775,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
                 reg = &registers[count];
                 network_to_register(reg);
 
-                trace_qemu_rdma_registration_handle_unregister_loop(count,
+                trace_rdma_registration_handle_unregister_loop(count,
                            reg->current_index, reg->key.chunk);
 
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
@@ -3792,8 +3791,7 @@ int qemu_rdma_registration_handle(QEMUFile *f)
 
                 rdma->total_registrations--;
 
-                trace_qemu_rdma_registration_handle_unregister_success(
-                                                       reg->key.chunk);
+                trace_rdma_registration_handle_unregister_success(reg->key.chunk);
             }
 
             ret = qemu_rdma_post_send_control(rdma, NULL, &unreg_resp, &err);
@@ -3860,7 +3858,7 @@ int rdma_block_notification_handle(QEMUFile *f, const char *name)
     return 0;
 }
 
-int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
+int rdma_registration_start(QEMUFile *f, uint64_t flags)
 {
     if (!migrate_rdma () || migration_in_postcopy()) {
         return 0;
@@ -3877,7 +3875,7 @@ int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
         return -1;
     }
 
-    trace_qemu_rdma_registration_start(flags);
+    trace_rdma_registration_start(flags);
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     qemu_fflush(f);
 
@@ -3888,7 +3886,7 @@ int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
  * Inform dest that dynamic registrations are done for now.
  * First, flush writes, if any.
  */
-int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
+int rdma_registration_stop(QEMUFile *f, uint64_t flags)
 {
     QIOChannelRDMA *rioc;
     Error *err = NULL;
@@ -3924,7 +3922,7 @@ int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
         int reg_result_idx, i, nb_dest_blocks;
 
         head.type = RDMA_CONTROL_RAM_BLOCKS_REQUEST;
-        trace_qemu_rdma_registration_stop_ram();
+        trace_rdma_registration_stop_ram();
 
         /*
          * Make sure that we parallelize the pinning on both sides.
@@ -3988,7 +3986,7 @@ int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
         }
     }
 
-    trace_qemu_rdma_registration_stop(flags);
+    trace_rdma_registration_stop(flags);
 
     head.type = RDMA_CONTROL_REGISTER_FINISHED;
     ret = qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL, &err);
diff --git a/migration/trace-events b/migration/trace-events
index ee9c8f4d63..b56442d7dd 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -231,20 +231,6 @@ qemu_rdma_post_send_control(const char *desc) "CONTROL: sending %s.."
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
@@ -263,6 +249,20 @@ qemu_rdma_write_one_zero(uint64_t chunk, int len, int index, int64_t offset) "En
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
2.41.0


