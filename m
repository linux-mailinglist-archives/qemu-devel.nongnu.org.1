Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF699762062
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 19:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOM2S-0006hI-Jk; Tue, 25 Jul 2023 13:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOM22-0006dU-Cb; Tue, 25 Jul 2023 13:41:12 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qOM1z-00046i-Ln; Tue, 25 Jul 2023 13:41:10 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9a90:0:640:d8ed:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 774515E900;
 Tue, 25 Jul 2023 20:40:41 +0300 (MSK)
Received: from vsementsov-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:1220::1:1d])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BeObRW0OrKo0-ZVYKMUoh; Tue, 25 Jul 2023 20:40:40 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690306840; bh=AYYG/GHXoL739G5O2KbB7PAMUmRsKpoCKQWcfdG2BD4=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=sej2lJaPJUEdHfrHetJXcrF1kTJRF+/M9We65nRrAtp6mwFH/lA2ABVTJyNoskqjj
 7LovvO+n6FH5uw/pmbzKBQd3eqyARtEWXBA58vDVVW8+pdicvNeKXA9TCm60LiO1ME
 1z3RxF028p06mn/gXYUnx9xCqrHlsUcMhg1sai8w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, den@openvz.org,
 Evanzhang@archeros.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: [PATCH v4] block-jobs: flush target at the end of .run()
Date: Tue, 25 Jul 2023 20:40:08 +0300
Message-Id: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Actually block job is not completed without this final flush. It's
rather unexpected to have broken target when job was successfully
completed long ago and now we fail to flush or process just
crashed/killed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c               |  7 +++++--
 block/commit.c               |  2 +-
 block/mirror.c               |  4 ++++
 block/stream.c               |  7 ++++++-
 blockjob.c                   | 18 ++++++++++++++++++
 include/block/blockjob_int.h | 11 +++++++++++
 6 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index db3791f4d1..b9ff63359a 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -295,10 +295,13 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
             job_yield(job);
         }
     } else {
-        return backup_loop(s);
+        ret = backup_loop(s);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
-    return 0;
+    return block_job_final_target_flush(&s->common, s->target_bs);
 }
 
 static void coroutine_fn backup_pause(Job *job)
diff --git a/block/commit.c b/block/commit.c
index aa45beb0f0..15df96b4f3 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -187,7 +187,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         }
     }
 
-    return 0;
+    return block_job_final_target_flush(&s->common, blk_bs(s->base));
 }
 
 static const BlockJobDriver commit_job_driver = {
diff --git a/block/mirror.c b/block/mirror.c
index d3cacd1708..cd19b49f7f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1143,6 +1143,10 @@ immediate_exit:
     g_free(s->in_flight_bitmap);
     bdrv_dirty_iter_free(s->dbi);
 
+    if (ret >= 0) {
+        ret = block_job_final_target_flush(&s->common, blk_bs(s->target));
+    }
+
     if (need_drain) {
         s->in_drain = true;
         bdrv_drained_begin(bs);
diff --git a/block/stream.c b/block/stream.c
index e522bbdec5..f7e8b35e94 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -131,6 +131,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
     int64_t len;
     int64_t offset = 0;
+    int ret;
     int error = 0;
     int64_t n = 0; /* bytes */
 
@@ -149,7 +150,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
     for ( ; offset < len; offset += n) {
         bool copy;
-        int ret;
 
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -207,6 +207,11 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
     }
 
+    ret = block_job_final_target_flush(&s->common, s->target_bs);
+    if (error == 0) {
+        error = ret;
+    }
+
     /* Do not remove the backing file if an error was there but ignored. */
     return error;
 }
diff --git a/blockjob.c b/blockjob.c
index 25fe8e625d..313e586b0d 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -611,3 +611,21 @@ AioContext *block_job_get_aio_context(BlockJob *job)
     GLOBAL_STATE_CODE();
     return job->job.aio_context;
 }
+
+int coroutine_fn
+block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs)
+{
+    int ret;
+
+    WITH_GRAPH_RDLOCK_GUARD() {
+        ret = bdrv_co_flush(target_bs);
+    }
+
+    if (ret < 0 && !block_job_is_internal(job)) {
+        qapi_event_send_block_job_error(job->job.id,
+                                        IO_OPERATION_TYPE_WRITE,
+                                        BLOCK_ERROR_ACTION_REPORT);
+    }
+
+    return ret;
+}
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 104824040c..617e40b916 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -152,4 +152,15 @@ void block_job_ratelimit_sleep(BlockJob *job);
 BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
                                         int is_read, int error);
 
+/**
+ * block_job_final_target_flush:
+ * @job: The job to signal an error for if flush failed.
+ * @target_bs: The bs to flush.
+ *
+ * The function is intended to be called at the end of .run() for any data
+ * copying job.
+ */
+int coroutine_fn
+block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs);
+
 #endif
-- 
2.34.1


