Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E191830A6F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 17:08:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ8Sb-0006mQ-Cp; Wed, 17 Jan 2024 11:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SN-0006UF-Vm; Wed, 17 Jan 2024 11:08:00 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rQ8SI-0000Ge-R4; Wed, 17 Jan 2024 11:07:59 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:62a3:0:640:1524:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 82CA5622AA;
 Wed, 17 Jan 2024 19:07:50 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b43a::1:2b])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id c7sSt20Ih8c0-ASCdJRSP; Wed, 17 Jan 2024 19:07:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1705507669;
 bh=Sp7jr9Lr0dFya+46K+f0fi8Kwb8v7UKMqWgwkL1TfaA=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=e91Jjw5cuSn8UvxDYBqcYtBSrb1tpUdaVj0Fal5fWVLWD0kDKhs5CXp3618kWOj/P
 rE7AJdfIhMiddzx4ab63zhfMD9hElIVlLWjX3HKT3BAYE0LqFzxYzZT+K9CUqrmfNw
 jHsd21KGWM66jZiLrqRcLnRTCOi7sSLZiB6PKLck=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v2 3/4] qapi: blockdev-backup: add discard-source parameter
Date: Wed, 17 Jan 2024 19:07:36 +0300
Message-Id: <20240117160737.1057513-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
References: <20240117160737.1057513-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a parameter that enables discard-after-copy. That is mostly useful
in "push backup with fleecing" scheme, when source is snapshot-access
format driver node, based on copy-before-write filter snapshot-access
API:

[guest]      [snapshot-access] ~~ blockdev-backup ~~> [backup target]
   |            |
   | root       | file
   v            v
[copy-before-write]
   |             |
   | file        | target
   v             v
[active disk]   [temp.img]

In this case discard-after-copy does two things:

 - discard data in temp.img to save disk space
 - avoid further copy-before-write operation in discarded area

Note that we have to declare WRITE permission on source in
copy-before-write filter, for discard to work.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/backup.c                         |  5 +++--
 block/block-copy.c                     | 12 ++++++++++--
 block/copy-before-write.c              |  2 +-
 block/replication.c                    |  4 ++--
 blockdev.c                             |  2 +-
 include/block/block-copy.h             |  2 +-
 include/block/block_int-global-state.h |  2 +-
 qapi/block-core.json                   |  4 ++++
 8 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index ec29d6b810..0c86b5be55 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -356,7 +356,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
                   BitmapSyncMode bitmap_mode,
-                  bool compress,
+                  bool compress, bool discard_source,
                   const char *filter_node_name,
                   BackupPerf *perf,
                   BlockdevOnError on_source_error,
@@ -491,7 +491,8 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->len = len;
     job->perf = *perf;
 
-    block_copy_set_copy_opts(bcs, perf->use_copy_range, compress);
+    block_copy_set_copy_opts(bcs, perf->use_copy_range, compress,
+                             discard_source);
     block_copy_set_progress_meter(bcs, &job->common.job.progress);
     block_copy_set_speed(bcs, speed);
 
diff --git a/block/block-copy.c b/block/block-copy.c
index 8fca2c3698..eebf643e86 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -137,6 +137,7 @@ typedef struct BlockCopyState {
     CoMutex lock;
     int64_t in_flight_bytes;
     BlockCopyMethod method;
+    bool discard_source;
     BlockReqList reqs;
     QLIST_HEAD(, BlockCopyCallState) calls;
     /*
@@ -282,11 +283,12 @@ static uint32_t block_copy_max_transfer(BdrvChild *source, BdrvChild *target)
 }
 
 void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
-                              bool compress)
+                              bool compress, bool discard_source)
 {
     /* Keep BDRV_REQ_SERIALISING set (or not set) in block_copy_state_new() */
     s->write_flags = (s->write_flags & BDRV_REQ_SERIALISING) |
         (compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+    s->discard_source = discard_source;
 
     if (s->max_transfer < s->cluster_size) {
         /*
@@ -418,7 +420,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
                                     cluster_size),
     };
 
-    block_copy_set_copy_opts(s, false, false);
+    block_copy_set_copy_opts(s, false, false, false);
 
     ratelimit_init(&s->rate_limit);
     qemu_co_mutex_init(&s->lock);
@@ -589,6 +591,12 @@ static coroutine_fn int block_copy_task_entry(AioTask *task)
     co_put_to_shres(s->mem, t->req.bytes);
     block_copy_task_end(t, ret);
 
+    if (s->discard_source && ret == 0) {
+        int64_t nbytes =
+            MIN(t->req.offset + t->req.bytes, s->len) - t->req.offset;
+        bdrv_co_pdiscard(s->source, t->req.offset, nbytes);
+    }
+
     return ret;
 }
 
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 4cd9b7d91e..b208a80ade 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -370,7 +370,7 @@ cbw_child_perm(BlockDriverState *bs, BdrvChild *c, BdrvChildRole role,
              * works even if source node does not have any parents before backup
              * start
              */
-            *nperm = *nperm | BLK_PERM_CONSISTENT_READ;
+            *nperm = *nperm | BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
             *nshared &= ~(BLK_PERM_WRITE | BLK_PERM_RESIZE);
         }
     }
diff --git a/block/replication.c b/block/replication.c
index ca6bd0a720..0415a5e8b7 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -582,8 +582,8 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, NULL,
-                                &perf,
+                                0, MIRROR_SYNC_MODE_NONE, NULL, 0, false, false,
+                                NULL, &perf,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/blockdev.c b/blockdev.c
index 3a5e7222ec..aa64382f82 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2713,7 +2713,7 @@ static BlockJob *do_backup_common(BackupCommon *backup,
 
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->bitmap_mode,
-                            backup->compress,
+                            backup->compress, backup->discard_source,
                             backup->filter_node_name,
                             &perf,
                             backup->on_source_error,
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 8b41643bfa..9555de2562 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -31,7 +31,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
 
 /* Function should be called prior any actual copy request */
 void block_copy_set_copy_opts(BlockCopyState *s, bool use_copy_range,
-                              bool compress);
+                              bool compress, bool discard_source);
 void block_copy_set_progress_meter(BlockCopyState *s, ProgressMeter *pm);
 
 void block_copy_state_free(BlockCopyState *s);
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index ef31c58bb3..563aabf012 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -187,7 +187,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             MirrorSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
                             BitmapSyncMode bitmap_mode,
-                            bool compress,
+                            bool compress, bool discard_source,
                             const char *filter_node_name,
                             BackupPerf *perf,
                             BlockdevOnError on_source_error,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca390c5700..1735769f9f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1599,6 +1599,9 @@
 #     node specified by @drive.  If this option is not given, a node
 #     name is autogenerated.  (Since: 4.2)
 #
+# @discard-source: Discard blocks on source which are already copied
+#     to the target.  (Since 9.0)
+#
 # @x-perf: Performance options.  (Since 6.0)
 #
 # Features:
@@ -1620,6 +1623,7 @@
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
             '*filter-node-name': 'str',
+            '*discard-source': 'bool',
             '*x-perf': { 'type': 'BackupPerf',
                          'features': [ 'unstable' ] } } }
 
-- 
2.34.1


