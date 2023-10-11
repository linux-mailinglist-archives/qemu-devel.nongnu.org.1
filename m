Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FA47C5E7D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:37:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfwM-0005ka-HK; Wed, 11 Oct 2023 16:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfwL-0005iA-By
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:36:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfwJ-0003FO-IU
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hMZ/Im8CDGWdic4kq0mnTpu0EPhSBpilRlc7eATBD/E=;
 b=fnOfe3iCcNARy8X1jSSV2wVxxpG2iPS9i++NVlIiZoqaqGeDRw788/FijCYiB6HkyuQ+sT
 toSWPAvZa+L+q5L11z01VaIzNMqRjio7wrt4md7jOUFRGvxQzgG2yaOFnDI8JKmrs3iwJf
 7Ts951puQCpKl1cUgj6edo3fThh+CDs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-154-tDcIV7uYO8mRr1GBGUtQAw-1; Wed, 11 Oct 2023 16:35:51 -0400
X-MC-Unique: tDcIV7uYO8mRr1GBGUtQAw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E75C4858280;
 Wed, 11 Oct 2023 20:35:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFD36492B07;
 Wed, 11 Oct 2023 20:35:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 12/13] migration/rdma: Declare for index variables local
Date: Wed, 11 Oct 2023 22:35:26 +0200
Message-ID: <20231011203527.9061-13-quintela@redhat.com>
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

Declare all variables that are only used inside a for loop inside the
for statement.

This makes clear that they are not used outside of the for loop.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index e29e5551d1..a43527a83c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -559,10 +559,8 @@ static void rdma_add_block(RDMAContext *rdma, const char *block_name,
     local->block = g_new0(RDMALocalBlock, local->nb_blocks + 1);
 
     if (local->nb_blocks) {
-        int x;
-
         if (rdma->blockmap) {
-            for (x = 0; x < local->nb_blocks; x++) {
+            for (int x = 0; x < local->nb_blocks; x++) {
                 g_hash_table_remove(rdma->blockmap,
                                     (void *)(uintptr_t)old[x].offset);
                 g_hash_table_insert(rdma->blockmap,
@@ -649,15 +647,12 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
 {
     RDMALocalBlocks *local = &rdma->local_ram_blocks;
     RDMALocalBlock *old = local->block;
-    int x;
 
     if (rdma->blockmap) {
         g_hash_table_remove(rdma->blockmap, (void *)(uintptr_t)block->offset);
     }
     if (block->pmr) {
-        int j;
-
-        for (j = 0; j < block->nb_chunks; j++) {
+        for (int j = 0; j < block->nb_chunks; j++) {
             if (!block->pmr[j]) {
                 continue;
             }
@@ -687,7 +682,7 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
     block->block_name = NULL;
 
     if (rdma->blockmap) {
-        for (x = 0; x < local->nb_blocks; x++) {
+        for (int x = 0; x < local->nb_blocks; x++) {
             g_hash_table_remove(rdma->blockmap,
                                 (void *)(uintptr_t)old[x].offset);
         }
@@ -705,7 +700,7 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
             memcpy(local->block + block->index, old + (block->index + 1),
                 sizeof(RDMALocalBlock) *
                     (local->nb_blocks - (block->index + 1)));
-            for (x = block->index; x < local->nb_blocks - 1; x++) {
+            for (int x = block->index; x < local->nb_blocks - 1; x++) {
                 local->block[x].index--;
             }
         }
@@ -725,7 +720,7 @@ static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
     local->nb_blocks--;
 
     if (local->nb_blocks && rdma->blockmap) {
-        for (x = 0; x < local->nb_blocks; x++) {
+        for (int x = 0; x < local->nb_blocks; x++) {
             g_hash_table_insert(rdma->blockmap,
                                 (void *)(uintptr_t)local->block[x].offset,
                                 &local->block[x]);
@@ -828,12 +823,12 @@ static int qemu_rdma_broken_ipv6_kernel(struct ibv_context *verbs, Error **errp)
      * Otherwise, there are no guarantees until the bug is fixed in linux.
      */
     if (!verbs) {
-        int num_devices, x;
+        int num_devices;
         struct ibv_device **dev_list = ibv_get_device_list(&num_devices);
         bool roce_found = false;
         bool ib_found = false;
 
-        for (x = 0; x < num_devices; x++) {
+        for (int x = 0; x < num_devices; x++) {
             verbs = ibv_open_device(dev_list[x]);
             /*
              * ibv_open_device() is not documented to set errno.  If
@@ -925,7 +920,6 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
     char port_str[16];
     struct rdma_cm_event *cm_event;
     char ip[40] = "unknown";
-    struct rdma_addrinfo *e;
 
     if (rdma->host == NULL || !strcmp(rdma->host, "")) {
         error_setg(errp, "RDMA ERROR: RDMA hostname has not been set");
@@ -957,7 +951,7 @@ static int qemu_rdma_resolve_host(RDMAContext *rdma, Error **errp)
     }
 
     /* Try all addresses, saving the first error in @err */
-    for (e = res; e != NULL; e = e->ai_next) {
+    for (struct rdma_addrinfo *e = res; e != NULL; e = e->ai_next) {
         Error **local_errp = err ? NULL : &err;
 
         inet_ntop(e->ai_family,
@@ -2777,7 +2771,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     RDMAContext *rdma;
     int ret;
     ssize_t done = 0;
-    size_t i, len;
+    size_t len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
@@ -2803,7 +2797,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         return -1;
     }
 
-    for (i = 0; i < niov; i++) {
+    for (int i = 0; i < niov; i++) {
         size_t remaining = iov[i].iov_len;
         uint8_t * data = (void *)iov[i].iov_base;
         while (remaining) {
@@ -2866,7 +2860,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     RDMAControlHeader head;
     int ret;
     ssize_t done = 0;
-    size_t i, len;
+    size_t len;
 
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmain);
@@ -2882,7 +2876,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
         return -1;
     }
 
-    for (i = 0; i < niov; i++) {
+    for (int i = 0; i < niov; i++) {
         size_t want = iov[i].iov_len;
         uint8_t *data = (void *)iov[i].iov_base;
 
@@ -3557,8 +3551,6 @@ int rdma_registration_handle(QEMUFile *f)
     void *host_addr;
     int ret;
     int idx = 0;
-    int count = 0;
-    int i = 0;
 
     if (!migrate_rdma()) {
         return 0;
@@ -3629,7 +3621,7 @@ int rdma_registration_handle(QEMUFile *f)
             qsort(rdma->local_ram_blocks.block,
                   rdma->local_ram_blocks.nb_blocks,
                   sizeof(RDMALocalBlock), dest_ram_sort_func);
-            for (i = 0; i < local->nb_blocks; i++) {
+            for (int i = 0; i < local->nb_blocks; i++) {
                 local->block[i].index = i;
             }
 
@@ -3647,7 +3639,7 @@ int rdma_registration_handle(QEMUFile *f)
              * Both sides use the "remote" structure to communicate and update
              * their "local" descriptions with what was sent.
              */
-            for (i = 0; i < local->nb_blocks; i++) {
+            for (int i = 0; i < local->nb_blocks; i++) {
                 rdma->dest_blocks[i].remote_host_addr =
                     (uintptr_t)(local->block[i].local_host_addr);
 
@@ -3687,7 +3679,7 @@ int rdma_registration_handle(QEMUFile *f)
             reg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
-            for (count = 0; count < head.repeat; count++) {
+            for (int count = 0; count < head.repeat; count++) {
                 uint64_t chunk;
                 uint8_t *chunk_start, *chunk_end;
 
@@ -3762,7 +3754,7 @@ int rdma_registration_handle(QEMUFile *f)
             unreg_resp.repeat = head.repeat;
             registers = (RDMARegister *) rdma->wr_data[idx].control_curr;
 
-            for (count = 0; count < head.repeat; count++) {
+            for (int count = 0; count < head.repeat; count++) {
                 reg = &registers[count];
                 network_to_register(reg);
 
@@ -3910,7 +3902,7 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     if (flags == RAM_CONTROL_SETUP) {
         RDMAControlHeader resp = {.type = RDMA_CONTROL_RAM_BLOCKS_RESULT };
         RDMALocalBlocks *local = &rdma->local_ram_blocks;
-        int reg_result_idx, i, nb_dest_blocks;
+        int reg_result_idx, nb_dest_blocks;
 
         head.type = RDMA_CONTROL_RAM_BLOCKS_REQUEST;
         trace_rdma_registration_stop_ram();
@@ -3958,7 +3950,7 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
         qemu_rdma_move_header(rdma, reg_result_idx, &resp);
         memcpy(rdma->dest_blocks,
             rdma->wr_data[reg_result_idx].control_curr, resp.len);
-        for (i = 0; i < nb_dest_blocks; i++) {
+        for (int i = 0; i < nb_dest_blocks; i++) {
             network_to_dest_block(&rdma->dest_blocks[i]);
 
             /* We require that the blocks are in the same order */
-- 
2.41.0


