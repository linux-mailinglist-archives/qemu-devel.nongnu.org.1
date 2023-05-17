Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A479706ED1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNP-00046e-FK; Wed, 17 May 2023 12:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNM-00043x-3g
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNK-0001WO-AA
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kPtbJb0tidbQu+RP75JRK8WweAJ9YC1/xKnt9hfbn4=;
 b=T3mOK2cnjioOmdbolCXfDoPCsaUZzyWWD/8E5BZhx3kfeXXirOgOpIQs7IxwHEE0D6vcwb
 qG2w6MaaM0YGqnwGmVh6XfbnHK+OPHznjmxPq2OJgqfEHcXAWqSZZKERnk1qGceBxDl+09
 8snXdojGcvhEY9eZ7ZvK7I8r+mCHOIo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-wuIUyhqGM6GQG6pF0T06Rw-1; Wed, 17 May 2023 12:51:37 -0400
X-MC-Unique: wuIUyhqGM6GQG6pF0T06Rw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D891688B770;
 Wed, 17 May 2023 16:51:36 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A33740C6EC4;
 Wed, 17 May 2023 16:51:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 14/18] blockjob: Adhere to rate limit even when reentered early
Date: Wed, 17 May 2023 18:51:12 +0200
Message-Id: <20230517165116.475123-15-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

When jobs are sleeping, for example to enforce a given rate limit, they
can be reentered early, in particular in order to get paused, to update
the rate limit or to get cancelled.

Before this patch, they behave in this case as if they had fully
completed their rate limiting delay. This means that requests are sped
up beyond their limit, violating the constraints that the user gave us.

Change the block jobs to sleep in a loop until the necessary delay is
completed, while still allowing cancelling them immediately as well
pausing (handled by the pause point in job_sleep_ns()) and updating the
rate limit.

This change is also motivated by iotests cases being prone to fail
because drain operations pause and unpause them so often that block jobs
complete earlier than they are supposed to. In particular, the next
commit would fail iotests 030 without this change.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510203601.418015-8-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob_int.h | 14 ++++++++++----
 block/commit.c               |  7 ++-----
 block/mirror.c               | 23 ++++++++++-------------
 block/stream.c               |  7 ++-----
 blockjob.c                   | 22 ++++++++++++++++++++--
 5 files changed, 44 insertions(+), 29 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f008446285..104824040c 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -126,12 +126,18 @@ void block_job_user_resume(Job *job);
  */
 
 /**
- * block_job_ratelimit_get_delay:
+ * block_job_ratelimit_processed_bytes:
  *
- * Calculate and return delay for the next request in ns. See the documentation
- * of ratelimit_calculate_delay() for details.
+ * To be called after some work has been done. Adjusts the delay for the next
+ * request. See the documentation of ratelimit_calculate_delay() for details.
  */
-int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n);
+void block_job_ratelimit_processed_bytes(BlockJob *job, uint64_t n);
+
+/**
+ * Put the job to sleep (assuming that it wasn't canceled) to throttle it to the
+ * right speed according to its rate limiting.
+ */
+void block_job_ratelimit_sleep(BlockJob *job);
 
 /**
  * block_job_error_action:
diff --git a/block/commit.c b/block/commit.c
index 2b20fd0fd4..aa45beb0f0 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -116,7 +116,6 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     int64_t offset;
-    uint64_t delay_ns = 0;
     int ret = 0;
     int64_t n = 0; /* bytes */
     QEMU_AUTO_VFREE void *buf = NULL;
@@ -149,7 +148,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
-        job_sleep_ns(&s->common.job, delay_ns);
+        block_job_ratelimit_sleep(&s->common);
         if (job_is_cancelled(&s->common.job)) {
             break;
         }
@@ -184,9 +183,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         job_progress_update(&s->common.job, n);
 
         if (copy) {
-            delay_ns = block_job_ratelimit_get_delay(&s->common, n);
-        } else {
-            delay_ns = 0;
+            block_job_ratelimit_processed_bytes(&s->common, n);
         }
     }
 
diff --git a/block/mirror.c b/block/mirror.c
index 717442ca4d..b7d92d1378 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -471,12 +471,11 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
     return bytes_handled;
 }
 
-static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
+static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
     BlockDriverState *source = s->mirror_top_bs->backing->bs;
     MirrorOp *pseudo_op;
     int64_t offset;
-    uint64_t delay_ns = 0, ret = 0;
     /* At least the first dirty chunk is mirrored in one iteration. */
     int nb_chunks = 1;
     bool write_zeroes_ok = bdrv_can_write_zeroes_with_unmap(blk_bs(s->target));
@@ -608,16 +607,13 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         assert(io_bytes);
         offset += io_bytes;
         nb_chunks -= DIV_ROUND_UP(io_bytes, s->granularity);
-        delay_ns = block_job_ratelimit_get_delay(&s->common, io_bytes_acct);
+        block_job_ratelimit_processed_bytes(&s->common, io_bytes_acct);
     }
 
-    ret = delay_ns;
 fail:
     QTAILQ_REMOVE(&s->ops_in_flight, pseudo_op, next);
     qemu_co_queue_restart_all(&pseudo_op->waiting_requests);
     g_free(pseudo_op);
-
-    return ret;
 }
 
 static void mirror_free_init(MirrorBlockJob *s)
@@ -1011,7 +1007,6 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     assert(!s->dbi);
     s->dbi = bdrv_dirty_iter_new(s->dirty_bitmap);
     for (;;) {
-        uint64_t delay_ns = 0;
         int64_t cnt, delta;
         bool should_complete;
 
@@ -1051,7 +1046,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
                 mirror_wait_for_free_in_flight_slot(s);
                 continue;
             } else if (cnt != 0) {
-                delay_ns = mirror_iteration(s);
+                mirror_iteration(s);
             }
         }
 
@@ -1114,12 +1109,14 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
         }
 
         if (job_is_ready(&s->common.job) && !should_complete) {
-            delay_ns = (s->in_flight == 0 &&
-                        cnt == 0 ? BLOCK_JOB_SLICE_TIME : 0);
+            if (s->in_flight == 0 && cnt == 0) {
+                trace_mirror_before_sleep(s, cnt, job_is_ready(&s->common.job),
+                                          BLOCK_JOB_SLICE_TIME);
+                job_sleep_ns(&s->common.job, BLOCK_JOB_SLICE_TIME);
+            }
+        } else {
+            block_job_ratelimit_sleep(&s->common);
         }
-        trace_mirror_before_sleep(s, cnt, job_is_ready(&s->common.job),
-                                  delay_ns);
-        job_sleep_ns(&s->common.job, delay_ns);
         s->last_pause_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     }
 
diff --git a/block/stream.c b/block/stream.c
index 7f9e1ecdbb..e522bbdec5 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -131,7 +131,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
     int64_t len;
     int64_t offset = 0;
-    uint64_t delay_ns = 0;
     int error = 0;
     int64_t n = 0; /* bytes */
 
@@ -155,7 +154,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
          */
-        job_sleep_ns(&s->common.job, delay_ns);
+        block_job_ratelimit_sleep(&s->common);
         if (job_is_cancelled(&s->common.job)) {
             break;
         }
@@ -204,9 +203,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         /* Publish progress */
         job_progress_update(&s->common.job, n);
         if (copy) {
-            delay_ns = block_job_ratelimit_get_delay(&s->common, n);
-        } else {
-            delay_ns = 0;
+            block_job_ratelimit_processed_bytes(&s->common, n);
         }
     }
 
diff --git a/blockjob.c b/blockjob.c
index 659c3cb9de..913da3cbf7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -319,10 +319,28 @@ static bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     return block_job_set_speed_locked(job, speed, errp);
 }
 
-int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n)
+void block_job_ratelimit_processed_bytes(BlockJob *job, uint64_t n)
 {
     IO_CODE();
-    return ratelimit_calculate_delay(&job->limit, n);
+    ratelimit_calculate_delay(&job->limit, n);
+}
+
+void block_job_ratelimit_sleep(BlockJob *job)
+{
+    uint64_t delay_ns;
+
+    /*
+     * Sleep at least once. If the job is reentered early, keep waiting until
+     * we've waited for the full time that is necessary to keep the job at the
+     * right speed.
+     *
+     * Make sure to recalculate the delay after each (possibly interrupted)
+     * sleep because the speed can change while the job has yielded.
+     */
+    do {
+        delay_ns = ratelimit_calculate_delay(&job->limit, 0);
+        job_sleep_ns(&job->job, delay_ns);
+    } while (delay_ns && !job_is_cancelled(&job->job));
 }
 
 BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
-- 
2.40.1


