Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958D47B817D
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2N7-0005wB-6F; Wed, 04 Oct 2023 09:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo2N2-0005uA-QB; Wed, 04 Oct 2023 09:57:01 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo2Mx-00051j-39; Wed, 04 Oct 2023 09:57:00 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id A454E60DBC;
 Wed,  4 Oct 2023 16:56:48 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a413::1:9])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id YuX2Zj2OlCg0-g8XO8rDF; Wed, 04 Oct 2023 16:56:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696427805;
 bh=PS7xLMRHLgk/ydLaBYBrrkPgfO7n2MQtbUdgD4lGMCA=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=qzWxpOA2v7PYdpk63csaNWrHunDV/3eNOeuILjDAzZudT74wkLrXDqn9e7Oxdev6G
 SDnGK9c7N/JCgWoijpJ2ibjR9htd8apqBwNqdah627MAsfmMHOFWOxXE7Hsf0GXUte
 a9wfmM8pxRZi9NABGuiOgghe1t4/HcR5UA07NT9s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, Evanzhang@archeros.com,
 den@openvz.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: [PATCH] block-jobs: add final flush
Date: Wed,  4 Oct 2023 16:56:32 +0300
Message-Id: <20231004135632.18196-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Actually block job is not completed without the final flush. It's
rather unexpected to have broken target when job was successfully
completed long ago and now we fail to flush or process just
crashed/killed.

Mirror job already has mirror_flush() for this. So, it's OK.

Add similar things for other jobs: backup, stream, commit.

Note, that stream has (documented) different treatment of IGNORE
action: it don't retry the operation, continue execution and report
error at last. We keep it for final flush too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

Was: [PATCH v4] block-jobs: flush target at the end of .run()
  But now rewritten.
Supersedes: <20230725174008.1147467-1-vsementsov@yandex-team.ru>

 block/backup.c             |  2 +-
 block/block-copy.c         |  7 +++++++
 block/commit.c             | 16 ++++++++++++----
 block/stream.c             | 21 +++++++++++++++++----
 include/block/block-copy.h |  1 +
 5 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index db3791f4d1..6a1321092a 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -156,7 +156,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
         job->bg_bcs_call = s = block_copy_async(job->bcs, 0,
                 QEMU_ALIGN_UP(job->len, job->cluster_size),
                 job->perf.max_workers, job->perf.max_chunk,
-                backup_block_copy_callback, job);
+                true, backup_block_copy_callback, job);
 
         while (!block_copy_call_finished(s) &&
                !job_is_cancelled(&job->common.job))
diff --git a/block/block-copy.c b/block/block-copy.c
index 1c60368d72..9b8672d4c8 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -54,6 +54,7 @@ typedef struct BlockCopyCallState {
     int max_workers;
     int64_t max_chunk;
     bool ignore_ratelimit;
+    bool need_final_flush;
     BlockCopyAsyncCallbackFunc cb;
     void *cb_opaque;
     /* Coroutine where async block-copy is running */
@@ -880,6 +881,10 @@ block_copy_common(BlockCopyCallState *call_state)
          */
     } while (ret > 0 && !qatomic_read(&call_state->cancelled));
 
+    if (ret == 0 && call_state->need_final_flush) {
+        ret = bdrv_co_flush(s->target->bs);
+    }
+
     qatomic_store_release(&call_state->finished, true);
 
     if (call_state->cb) {
@@ -935,6 +940,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t start, int64_t bytes,
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
                                      int max_workers, int64_t max_chunk,
+                                     bool need_final_flush,
                                      BlockCopyAsyncCallbackFunc cb,
                                      void *cb_opaque)
 {
@@ -946,6 +952,7 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s,
         .bytes = bytes,
         .max_workers = max_workers,
         .max_chunk = max_chunk,
+        .need_final_flush = need_final_flush,
         .cb = cb,
         .cb_opaque = cb_opaque,
 
diff --git a/block/commit.c b/block/commit.c
index aa45beb0f0..5205c77ec9 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -120,6 +120,7 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
     int64_t n = 0; /* bytes */
     QEMU_AUTO_VFREE void *buf = NULL;
     int64_t len, base_len;
+    BlockErrorAction action;
 
     len = blk_co_getlength(s->top);
     if (len < 0) {
@@ -169,9 +170,8 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
             }
         }
         if (ret < 0) {
-            BlockErrorAction action =
-                block_job_error_action(&s->common, s->on_error,
-                                       error_in_source, -ret);
+            action = block_job_error_action(&s->common, s->on_error,
+                                            error_in_source, -ret);
             if (action == BLOCK_ERROR_ACTION_REPORT) {
                 return ret;
             } else {
@@ -187,7 +187,15 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
         }
     }
 
-    return 0;
+    do {
+        ret = blk_co_flush(s->base);
+        if (ret < 0) {
+            action = block_job_error_action(&s->common, s->on_error,
+                                            false, -ret);
+        }
+    } while (ret < 0 && action != BLOCK_ERROR_ACTION_REPORT);
+
+    return ret;
 }
 
 static const BlockJobDriver commit_job_driver = {
diff --git a/block/stream.c b/block/stream.c
index 133cb72fb4..41eb536feb 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -143,6 +143,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     int64_t offset = 0;
     int error = 0;
     int64_t n = 0; /* bytes */
+    BlockErrorAction action;
+    int ret;
 
     if (unfiltered_bs == s->base_overlay) {
         /* Nothing to stream */
@@ -159,7 +161,6 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
     for ( ; offset < len; offset += n) {
         bool copy;
-        int ret;
 
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
@@ -196,8 +197,8 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
             ret = stream_populate(s->blk, offset, n);
         }
         if (ret < 0) {
-            BlockErrorAction action =
-                block_job_error_action(&s->common, s->on_error, true, -ret);
+            action = block_job_error_action(&s->common, s->on_error,
+                                            true, -ret);
             if (action == BLOCK_ERROR_ACTION_STOP) {
                 n = 0;
                 continue;
@@ -206,7 +207,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
                 error = ret;
             }
             if (action == BLOCK_ERROR_ACTION_REPORT) {
-                break;
+                return error;
             }
         }
 
@@ -217,6 +218,18 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         }
     }
 
+    do {
+        ret = blk_co_flush(s->blk);
+        if (ret < 0) {
+            action = block_job_error_action(&s->common, s->on_error,
+                                            false, -ret);
+        }
+    } while (ret < 0 && action == BLOCK_ERROR_ACTION_STOP);
+
+    if (error == 0) {
+        error = ret;
+    }
+
     /* Do not remove the backing file if an error was there but ignored. */
     return error;
 }
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0700953ab8..6fe1e07aa3 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -60,6 +60,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t bytes,
 BlockCopyCallState *block_copy_async(BlockCopyState *s,
                                      int64_t offset, int64_t bytes,
                                      int max_workers, int64_t max_chunk,
+                                     bool need_final_flush,
                                      BlockCopyAsyncCallbackFunc cb,
                                      void *cb_opaque);
 
-- 
2.34.1


