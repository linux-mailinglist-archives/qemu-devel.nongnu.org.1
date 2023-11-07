Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F0C7E48A4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:48:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6E-0004Sm-Gm; Tue, 07 Nov 2023 13:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5d-0003uK-VF
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5b-0001Tc-I1
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=473Ecpc2faSQYEtUrg89rO0F58KFORSbfSxuL6EM7og=;
 b=IRHSU45oJbpG+SmTJmqLCPTECB2lQvszI183yY/gTozGpUAQFR2jjWARdquELtiBlmR3SR
 A9lm70sdMROcBFR6ZvezbQ8gST/SXnXCB04cSIBEDc/ZWBER7k9UoC5LGkmWm378WfUAXi
 JHiroPGz7zHEkAiNPm3VDK1ppPkYybE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-DixG_fAGNn2qpweRM-P4Ug-1; Tue,
 07 Nov 2023 13:46:11 -0500
X-MC-Unique: DixG_fAGNn2qpweRM-P4Ug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 779CF2803023
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0151FC1290F;
 Tue,  7 Nov 2023 18:46:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 05/25] block: Mark block_job_add_bdrv() GRAPH_WRLOCK
Date: Tue,  7 Nov 2023 19:45:45 +0100
Message-ID: <20231107184605.236540-6-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Instead of taking the writer lock internally, require callers to already
hold it when calling block_job_add_bdrv(). These callers will typically
already hold the graph lock once the locking work is completed, which
means that they can't call functions that take it internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-6-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     |  5 +++--
 include/block/blockjob_int.h |  9 +++++----
 block/backup.c               | 21 +++++++++++++++------
 block/commit.c               |  5 +++++
 block/mirror.c               |  5 +++++
 block/stream.c               |  4 ++++
 blockjob.c                   |  8 +++++---
 tests/unit/test-bdrv-drain.c |  3 +++
 8 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 95854f1477..e594c10d23 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -138,8 +138,9 @@ BlockJob *block_job_get_locked(const char *id);
  * @job. This means that all operations will be blocked on @bs while
  * @job exists.
  */
-int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
-                       uint64_t perm, uint64_t shared_perm, Error **errp);
+int GRAPH_WRLOCK
+block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
+                   uint64_t perm, uint64_t shared_perm, Error **errp);
 
 /**
  * block_job_remove_all_bdrv:
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 18ee6f7bf0..4c3d2e25a2 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -111,10 +111,11 @@ struct BlockJobDriver {
  * This function is not part of the public job interface; it should be
  * called from a wrapper that is specific to the job type.
  */
-void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       JobTxn *txn, BlockDriverState *bs, uint64_t perm,
-                       uint64_t shared_perm, int64_t speed, int flags,
-                       BlockCompletionFunc *cb, void *opaque, Error **errp);
+void * GRAPH_UNLOCKED
+block_job_create(const char *job_id, const BlockJobDriver *driver,
+                 JobTxn *txn, BlockDriverState *bs, uint64_t perm,
+                 uint64_t shared_perm, int64_t speed, int flags,
+                 BlockCompletionFunc *cb, void *opaque, Error **errp);
 
 /**
  * block_job_free:
diff --git a/block/backup.c b/block/backup.c
index 9a3c4bdc82..5bad7d116f 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -374,7 +374,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     assert(bs);
     assert(target);
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     /* QMP interface protects us from these cases */
     assert(sync_mode != MIRROR_SYNC_MODE_INCREMENTAL);
@@ -385,31 +384,33 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
+    bdrv_graph_rdlock_main_loop();
     if (!bdrv_is_inserted(bs)) {
         error_setg(errp, "Device is not inserted: %s",
                    bdrv_get_device_name(bs));
-        return NULL;
+        goto error_rdlock;
     }
 
     if (!bdrv_is_inserted(target)) {
         error_setg(errp, "Device is not inserted: %s",
                    bdrv_get_device_name(target));
-        return NULL;
+        goto error_rdlock;
     }
 
     if (compress && !bdrv_supports_compressed_writes(target)) {
         error_setg(errp, "Compression is not supported for this drive %s",
                    bdrv_get_device_name(target));
-        return NULL;
+        goto error_rdlock;
     }
 
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_BACKUP_SOURCE, errp)) {
-        return NULL;
+        goto error_rdlock;
     }
 
     if (bdrv_op_is_blocked(target, BLOCK_OP_TYPE_BACKUP_TARGET, errp)) {
-        return NULL;
+        goto error_rdlock;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     if (perf->max_workers < 1 || perf->max_workers > INT_MAX) {
         error_setg(errp, "max-workers must be between 1 and %d", INT_MAX);
@@ -437,6 +438,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     len = bdrv_getlength(bs);
     if (len < 0) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
         error_setg_errno(errp, -len, "Unable to get length for '%s'",
                          bdrv_get_device_or_node_name(bs));
         goto error;
@@ -444,6 +446,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
 
     target_len = bdrv_getlength(target);
     if (target_len < 0) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
         error_setg_errno(errp, -target_len, "Unable to get length for '%s'",
                          bdrv_get_device_or_node_name(bs));
         goto error;
@@ -493,8 +496,10 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     block_copy_set_speed(bcs, speed);
 
     /* Required permissions are taken by copy-before-write filter target */
+    bdrv_graph_wrlock(target);
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
+    bdrv_graph_wrunlock();
 
     return &job->common;
 
@@ -507,4 +512,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     return NULL;
+
+error_rdlock:
+    bdrv_graph_rdunlock_main_loop();
+    return NULL;
 }
diff --git a/block/commit.c b/block/commit.c
index 43d1de7577..fc3ad79749 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -342,6 +342,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      */
     iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
 
+    bdrv_graph_wrlock(top);
     for (iter = top; iter != base; iter = bdrv_filter_or_cow_bs(iter)) {
         if (iter == filtered_base) {
             /*
@@ -354,16 +355,20 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                  iter_shared_perms, errp);
         if (ret < 0) {
+            bdrv_graph_wrunlock();
             goto fail;
         }
     }
 
     if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
+        bdrv_graph_wrunlock();
         goto fail;
     }
     s->chain_frozen = true;
 
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
+    bdrv_graph_wrunlock();
+
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/mirror.c b/block/mirror.c
index c839542774..a03247a31b 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1888,11 +1888,13 @@ static BlockJob *mirror_start_job(
      */
     bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
+    bdrv_graph_wrlock(bs);
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
                              BLK_PERM_CONSISTENT_READ,
                              errp);
     if (ret < 0) {
+        bdrv_graph_wrunlock();
         goto fail;
     }
 
@@ -1937,14 +1939,17 @@ static BlockJob *mirror_start_job(
             ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                      iter_shared_perms, errp);
             if (ret < 0) {
+                bdrv_graph_wrunlock();
                 goto fail;
             }
         }
 
         if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
+            bdrv_graph_wrunlock();
             goto fail;
         }
     }
+    bdrv_graph_wrunlock();
 
     QTAILQ_INIT(&s->ops_in_flight);
 
diff --git a/block/stream.c b/block/stream.c
index b22d9c236b..51333e460b 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -352,8 +352,10 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached.
      */
+    bdrv_graph_wrlock(bs);
     if (block_job_add_bdrv(&s->common, "active node", bs, 0,
                            basic_flags | BLK_PERM_WRITE, errp)) {
+        bdrv_graph_wrunlock();
         goto fail;
     }
 
@@ -373,9 +375,11 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                  basic_flags, errp);
         if (ret < 0) {
+            bdrv_graph_wrunlock();
             goto fail;
         }
     }
+    bdrv_graph_wrunlock();
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
diff --git a/blockjob.c b/blockjob.c
index 7920f6e500..af44322cbe 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -248,10 +248,8 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
         }
         aio_context_acquire(ctx);
     }
-    bdrv_graph_wrlock(bs);
     c = bdrv_root_attach_child(bs, name, &child_job, 0, perm, shared_perm, job,
                                errp);
-    bdrv_graph_wrunlock();
     if (need_context_ops) {
         aio_context_release(ctx);
         if (job->job.aio_context != qemu_get_aio_context()) {
@@ -515,7 +513,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     BlockJob *job;
     int ret;
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_graph_wrlock(bs);
 
     if (job_id == NULL && !(flags & JOB_INTERNAL)) {
         job_id = bdrv_get_device_name(bs);
@@ -524,6 +523,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job = job_create(job_id, &driver->job_driver, txn, bdrv_get_aio_context(bs),
                      flags, cb, opaque, errp);
     if (job == NULL) {
+        bdrv_graph_wrunlock();
         return NULL;
     }
 
@@ -563,9 +563,11 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         goto fail;
     }
 
+    bdrv_graph_wrunlock();
     return job;
 
 fail:
+    bdrv_graph_wrunlock();
     job_early_fail(&job->job);
     return NULL;
 }
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index f67e9df01c..40d17b4c5a 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -794,7 +794,10 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
                             0, 0, NULL, NULL, &error_abort);
     tjob->bs = src;
     job = &tjob->common;
+
+    bdrv_graph_wrlock(target);
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
+    bdrv_graph_wrunlock();
 
     switch (result) {
     case TEST_JOB_SUCCESS:
-- 
2.41.0


