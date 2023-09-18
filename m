Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F107A4B54
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:53:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFT4-0003Hf-VA; Mon, 18 Sep 2023 10:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSV-00035j-Hg
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS5-0002cZ-6r
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HQ61j2Zgip8o1cN4xMcrEYRa/ZV8n/yZ2vZdVFbDNtA=;
 b=eWWfA6oyz56K6Jt4BegFNlmeryT3+gN0qoj9I83MJSeSyfrrcjB9oE1HM4SOCgfFL2WG7k
 WSfPGk/3wNYRqLWJx4XKI/yK4VyaLTDwoxjt7m5oEfWGeBDlh+ApzJFB0i7NZ3qvTE6oUc
 DXeMWiq2FmNQp0ObtULweXK2TROk+Ro=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-gkQ-I8lQNLGkn2rdOrxPXg-1; Mon, 18 Sep 2023 10:42:11 -0400
X-MC-Unique: gkQ-I8lQNLGkn2rdOrxPXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55AFF85A5BD
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 165B040C2064
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 25C1821E6883; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 21/52] migration/rdma: Fix QEMUFileHooks method return values
Date: Mon, 18 Sep 2023 16:41:35 +0200
Message-ID: <20230918144206.560120-22-armbru@redhat.com>
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
---
 migration/rdma.c | 79 +++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index cc59155a50..46b5859268 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3219,12 +3219,11 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
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
@@ -3290,9 +3289,10 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
     }
 
     return RAM_SAVE_CONTROL_DELAYED;
+
 err:
     rdma->error_state = ret;
-    return ret;
+    return -1;
 }
 
 static void rdma_accept_incoming_migration(void *opaque);
@@ -3538,12 +3538,11 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
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
@@ -3576,7 +3575,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                              (unsigned int)comp->block_idx,
                              rdma->local_ram_blocks.nb_blocks);
                 ret = -EIO;
-                goto out;
+                goto err;
             }
             block = &(rdma->local_ram_blocks.block[comp->block_idx]);
 
@@ -3588,7 +3587,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
         case RDMA_CONTROL_REGISTER_FINISHED:
             trace_qemu_rdma_registration_handle_finished();
-            goto out;
+            return 0;
 
         case RDMA_CONTROL_RAM_BLOCKS_REQUEST:
             trace_qemu_rdma_registration_handle_ram_blocks();
@@ -3609,7 +3608,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 if (ret) {
                     error_report("rdma migration: error dest "
                                     "registering ram blocks");
-                    goto out;
+                    goto err;
                 }
             }
 
@@ -3648,7 +3647,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (ret < 0) {
                 error_report("rdma migration: error sending remote info");
-                goto out;
+                goto err;
             }
 
             break;
@@ -3675,7 +3674,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                                  (unsigned int)reg->current_index,
                                  rdma->local_ram_blocks.nb_blocks);
                     ret = -ENOENT;
-                    goto out;
+                    goto err;
                 }
                 block = &(rdma->local_ram_blocks.block[reg->current_index]);
                 if (block->is_ram_block) {
@@ -3685,7 +3684,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             block->block_name, block->offset,
                             reg->key.current_addr);
                         ret = -ERANGE;
-                        goto out;
+                        goto err;
                     }
                     host_addr = (block->local_host_addr +
                                 (reg->key.current_addr - block->offset));
@@ -3701,7 +3700,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             " chunk: %" PRIx64,
                             block->block_name, reg->key.chunk);
                         ret = -ERANGE;
-                        goto out;
+                        goto err;
                     }
                 }
                 chunk_start = ram_chunk_start(block, chunk);
@@ -3713,7 +3712,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                             chunk, chunk_start, chunk_end)) {
                     error_report("cannot get rkey");
                     ret = -EINVAL;
-                    goto out;
+                    goto err;
                 }
                 reg_result->rkey = tmp_rkey;
 
@@ -3730,7 +3729,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
             if (ret < 0) {
                 error_report("Failed to send control buffer");
-                goto out;
+                goto err;
             }
             break;
         case RDMA_CONTROL_UNREGISTER_REQUEST:
@@ -3753,7 +3752,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
                 if (ret != 0) {
                     perror("rdma unregistration chunk failed");
                     ret = -ret;
-                    goto out;
+                    goto err;
                 }
 
                 rdma->total_registrations--;
@@ -3766,24 +3765,23 @@ static int qemu_rdma_registration_handle(QEMUFile *f)
 
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
@@ -3805,7 +3803,7 @@ rdma_block_notification_handle(QEMUFile *f, const char *name)
     rdma = qatomic_rcu_read(&rioc->rdmain);
 
     if (!rdma) {
-        return -EIO;
+        return -1;
     }
 
     /* Find the matching RAMBlock in our local list */
@@ -3818,7 +3816,7 @@ rdma_block_notification_handle(QEMUFile *f, const char *name)
 
     if (found == -1) {
         error_report("RAMBlock '%s' not found on destination", name);
-        return -ENOENT;
+        return -1;
     }
 
     rdma->local_ram_blocks.block[curr].src_index = rdma->next_src_index;
@@ -3848,7 +3846,6 @@ static int qemu_rdma_registration_start(QEMUFile *f,
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
     RDMAContext *rdma;
-    int ret;
 
     if (migration_in_postcopy()) {
         return 0;
@@ -3857,12 +3854,11 @@ static int qemu_rdma_registration_start(QEMUFile *f,
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
@@ -3891,12 +3887,11 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
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
@@ -3927,7 +3922,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                     qemu_rdma_reg_whole_ram_blocks : NULL);
         if (ret < 0) {
             fprintf(stderr, "receiving remote info!");
-            return ret;
+            return -1;
         }
 
         nb_dest_blocks = resp.len / sizeof(RDMADestBlock);
@@ -3950,7 +3945,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                     "not identical on both the source and destination.",
                     local->nb_blocks, nb_dest_blocks);
             rdma->error_state = -EINVAL;
-            return -EINVAL;
+            return -1;
         }
 
         qemu_rdma_move_header(rdma, reg_result_idx, &resp);
@@ -3966,7 +3961,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
                         local->block[i].length,
                         rdma->dest_blocks[i].length);
                 rdma->error_state = -EINVAL;
-                return -EINVAL;
+                return -1;
             }
             local->block[i].remote_host_addr =
                     rdma->dest_blocks[i].remote_host_addr;
@@ -3986,7 +3981,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,
     return 0;
 err:
     rdma->error_state = ret;
-    return ret;
+    return -1;
 }
 
 static const QEMUFileHooks rdma_read_hooks = {
-- 
2.41.0


