Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B767B1E0A
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwk-0003eh-Ph; Thu, 28 Sep 2023 09:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwZ-0003a6-CJ
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwO-0008Fd-9k
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=muVt9+mJK5tZ4PWTa88llBlGB24wRA8moVIF+LRy5u4=;
 b=dmzXkhRfiQJm3YCZuW9C4Kq/w3N9pe/rWOrSdkwvBxG6eiGgNgyc90GNwCc4Dxn4tTGTFs
 EUHaRdDLellTlQjho3NU0OpARfJAJFq+MXO6764OubZeeKi6wjVVOxS24TzWJZMuyF7vo4
 x4Xb4liVWnw5hz/My7UDC/aDDw4thDY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-2wNYGPSmMZ6WPNhGA2hhgQ-1; Thu, 28 Sep 2023 09:20:23 -0400
X-MC-Unique: 2wNYGPSmMZ6WPNhGA2hhgQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55F47280A9D6;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 172CE1005E29;
 Thu, 28 Sep 2023 13:20:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FCFF21E6886; Thu, 28 Sep 2023 15:20:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 23/53] migration/rdma: Fix QEMUFileHooks method return
 values
Date: Thu, 28 Sep 2023 15:19:49 +0200
Message-ID: <20230928132019.2544702-24-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

The QEMUFileHooks methods don't come with a written contract.  Digging
through the code calling them, we find:

* save_page():

  Negative values RAM_SAVE_CONTROL_DELAYED and
  RAM_SAVE_CONTROL_NOT_SUPP are special.  Any other negative value is
  an unspecified error.

  qemu_rdma_save_page() returns -EIO or rdma->error_state on error.  I
  believe the latter is always negative.  Nothing stops either of them
  to clash with the special values, though.  Feels unlikely, but fix
  it anyway to return only the special values and -1.

* before_ram_iterate(), after_ram_iterate():

  Negative value means error.  qemu_rdma_registration_start() and
  qemu_rdma_registration_stop() comply as far as I can tell.  Make
  them comply *obviously*, by returning -1 on error.

* hook_ram_load:

  Negative value means error.  rdma_load_hook() already returns -1 on
  error.  Leave it alone.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 79 +++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 1ae2f87906..a58c2734e3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3250,12 +3250,11 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
     rdma = qatomic_rcu_read(&rioc->rdmaout);
 
     if (!rdma) {
-        return -EIO;
+        return -1;
     }
 
-    ret = check_error_state(rdma);
-    if (ret) {
-        return ret;
+    if (check_error_state(rdma)) {
+        return -1;
     }
 
     qemu_fflush(f);
@@ -3321,9 +3320,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
     }
 
     return RAM_SAVE_CONTROL_DELAYED;
+
 err:
     rdma->error_state = ret;
-    return ret;
+    return -1;
 }
 
 static void rdma_accept_incoming_migration(void *opaque);
@@ -3569,12 +3569,11 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
     rdma = qatomic_rcu_read(&rioc->rdmain);
 
     if (!rdma) {
-        return -EIO;
+        return -1;
     }
 
-    ret = check_error_state(rdma);
-    if (ret) {
-        return ret;
+    if (check_error_state(rdma)) {
+        return -1;
     }
 
     local = &rdma->local_ram_blocks;
@@ -3607,7 +3606,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                              (unsigned int)comp->block_idx,
                              rdma->local_ram_blocks.nb_blocks);
                 ret = -EIO;
-                goto out;
+                goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
 
@@ -3619,7 +3618,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
         case RDMA_CONTROL_REGISTER_FINISHED:
             trace_qemu_rdma_registration_handle_finished();
-            goto out;
+            return 0;
 
         case RDMA_CONTROL_RAM_BLOCKS_REQUEST:
             trace_qemu_rdma_registration_handle_ram_blocks();
@@ -3640,7 +3639,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 if (ret) {
                     error_report("rdma migration: error dest "
                                     "registering ram blocks");
-                    goto out;
+                    goto err;
                 }
             }
 
@@ -3679,7 +3678,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (ret < 0) {
                 error_report("rdma migration: error sending remote info");
-                goto out;
+                goto err;
             }
 
             break;
@@ -3706,7 +3705,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                                  (unsigned int)reg->current_index,
                                  rdma->local_ram_blocks.nb_blocks);
                     ret = -ENOENT;
-                    goto out;
+                    goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
                 if (block->is_ram_block) {
@@ -3716,7 +3715,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             block->block_name, block->offset,
                             reg->key.current_addr);
                         ret = -ERANGE;
-                        goto out;
+                        goto err;
                     }
                     host_addr = (block->local_host_addr +
                                 (reg->key.current_addr - block->offset));
@@ -3732,7 +3731,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             " chunk: %" PRIx64,
                             block->block_name, reg->key.chunk);
                         ret = -ERANGE;
-                        goto out;
+                        goto err;
                     }
                 }
                 chunk_start = ram_chunk_start(block, chunk);
@@ -3744,7 +3743,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             chunk, chunk_start, chunk_end)) {
                     error_report("cannot get rkey");
                     ret = -EINVAL;
-                    goto out;
+                    goto err;
                 }
                 reg_result->rkey = tmp_rkey;
 
@@ -3761,7 +3760,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (ret < 0) {
                 error_report("Failed to send control buffer");
-                goto out;
+                goto err;
             }
             break;
         case RDMA_CONTROL_UNREGISTER_REQUEST:
@@ -3784,7 +3783,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 if (ret != 0) {
                     perror("rdma unregistration chunk failed");
                     ret = -ret;
-                    goto out;
+                    goto err;
                 }
 
                 rdma->total_registrations--;
@@ -3797,24 +3796,23 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (ret < 0) {
                 error_report("Failed to send control buffer");
-                goto out;
+                goto err;
             }
             break;
         case RDMA_CONTROL_REGISTER_RESULT:
             error_report("Invalid RESULT message at dest.");
             ret = -EIO;
-            goto out;
+            goto err;
         default:
             error_report("Unknown control message %s", control_desc(head.type));
             ret = -EIO;
-            goto out;
+            goto err;
         }
     } while (1);
-out:
-    if (ret < 0) {
-        rdma->error_state = ret;
-    }
-    return ret;
+
+err:
+    rdma->error_state = ret;
+    return -1;
 }
 
 /* Destination:
@@ -3836,7 +3834,7 @@ rdma_block_notification_handle(QEMUFile *f, const char *name)
     rdma = qatomic_rcu_read(&rioc->rdmain);
 
     if (!rdma) {
-        return -EIO;
+        return -1;
     }
 
     /* Find the matching RAMBlock in our local list */
@@ -3849,7 +3847,7 @@ rdma_block_notification_handle(QEMUFile *f, const char *name)
 
     if (found == -1) {
         error_report("RAMBlock '%s' not found on destination", name);
-        return -ENOENT;
+        return -1;
     }
 
     rdma->local_ram_blocks.block[curr].src_index = rdma->next_src_index;
@@ -3879,7 +3877,6 @@ static int qemu_rdma_registration_start(QEMUFile *f,
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
-    int ret;
 
     if (migration_in_postcopy()) {
         return 0;
@@ -3888,12 +3885,11 @@ static int qemu_rdma_registration_start(QEMUFile *f,
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
     if (!rdma) {
-        return -EIO;
+        return -1;
     }
 
-    ret = check_error_state(rdma);
-    if (ret) {
-        return ret;
+    if (check_error_state(rdma)) {
+        return -1;
     }
 
     trace_qemu_rdma_registration_start(flags);
@@ -3922,12 +3918,11 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
     if (!rdma) {
-        return -EIO;
+        return -1;
     }
 
-    ret = check_error_state(rdma);
-    if (ret) {
-        return ret;
+    if (check_error_state(rdma)) {
+        return -1;
     }
 
     qemu_fflush(f);
@@ -3958,7 +3953,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                     qemu_rdma_reg_whole_ram_blocks : NULL);
         if (ret < 0) {
             fprintf(stderr, "receiving remote info!");
-            return ret;
+            return -1;
         }
 
         nb_dest_blocks = resp.len / sizeof(RDMADestBlock);
@@ -3981,7 +3976,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                     "not identical on both the source and destination.",
                     local->nb_blocks, nb_dest_blocks);
             rdma->error_state = -EINVAL;
-            return -EINVAL;
+            return -1;
         }
 
         qemu_rdma_move_header(rdma, reg_result_idx, &resp);
@@ -3997,7 +3992,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                         local->block[i].length,
                         rdma->dest_blocks[i].length);
                 rdma->error_state = -EINVAL;
-                return -EINVAL;
+                return -1;
             }
             local->block[i].remote_host_addr =
                     rdma->dest_blocks[i].remote_host_addr;
@@ -4017,7 +4012,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     return 0;
 err:
     rdma->error_state = ret;
-    return ret;
+    return -1;
 }
 
 static const QEMUFileHooks rdma_read_hooks = {
-- 
2.41.0


