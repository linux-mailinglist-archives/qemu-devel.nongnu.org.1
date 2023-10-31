Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CC07DD682
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:04:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyv-00051d-Hr; Tue, 31 Oct 2023 15:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyo-0004lY-RY
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxz-0006Cc-9I
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dnn6oU8kqpnDFmVsKXU/dpTnmKj4y6tD5lMYmysirUQ=;
 b=Jw4ssKQGONYKTx29JHvA8YQ0YBekSOzpfzoerC0UAqroJBU8q+BvDXdK9fn7JOuBs6pvpq
 9AAIbQbg2yMu4epWKMlv14P5rfaDezH/aO99nnlxg5VdDfQoJZmQ5iYOJiXaRSOTcvyXlr
 pSm25iaZys1NurSJwK8PYoo8+K+EB+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-X28V2RoKPGiboserqLd0Jg-1; Tue, 31 Oct 2023 14:59:42 -0400
X-MC-Unique: X28V2RoKPGiboserqLd0Jg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2717831714;
 Tue, 31 Oct 2023 18:59:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3683F3DB;
 Tue, 31 Oct 2023 18:59:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 26/27] mirror: return mirror-specific information upon query
Date: Tue, 31 Oct 2023 19:59:17 +0100
Message-ID: <20231031185918.346940-27-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

To start out, only actively-synced is returned.

For example, this is useful for jobs that started out in background
mode and switched to active mode. Once actively-synced is true, it's
clear that the mode switch has been completed. Note that completion of
the switch might happen much earlier, e.g. if the switch happens
before the job is ready, once all background operations have finished.
It's assumed that whether the disks are actively-synced or not is more
interesting than whether the mode switch completed. That information
can still be added if required in the future.

In presence of an iothread, the actively_synced member is now shared
between the iothread and the main thread, so turn accesses to it
atomic.

Requires to adapt the output for iotest 109.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231031135431.393137-10-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       | 16 +++++++++++++++-
 block/mirror.c             | 31 +++++++++++++++++++++++--------
 tests/qemu-iotests/109.out | 24 ++++++++++++------------
 3 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index dca0e94bb0..99961256f2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1352,6 +1352,20 @@
 { 'enum': 'MirrorCopyMode',
   'data': ['background', 'write-blocking'] }
 
+##
+# @BlockJobInfoMirror:
+#
+# Information specific to mirror block jobs.
+#
+# @actively-synced: Whether the source is actively synced to the
+#     target, i.e. same data and new writes are done synchronously to
+#     both.
+#
+# Since 8.2
+##
+{ 'struct': 'BlockJobInfoMirror',
+  'data': { 'actively-synced': 'bool' } }
+
 ##
 # @BlockJobInfo:
 #
@@ -1403,7 +1417,7 @@
            'auto-finalize': 'bool', 'auto-dismiss': 'bool',
            '*error': 'str' },
   'discriminator': 'type',
-  'data': {} }
+  'data': { 'mirror': 'BlockJobInfoMirror' } }
 
 ##
 # @query-block-jobs:
diff --git a/block/mirror.c b/block/mirror.c
index 4016d89253..c839542774 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -61,8 +61,12 @@ typedef struct MirrorBlockJob {
      */
     MirrorCopyMode copy_mode;
     BlockdevOnError on_source_error, on_target_error;
-    /* Set when the target is synced (dirty bitmap is clean, nothing
-     * in flight) and the job is running in active mode */
+    /*
+     * To be accessed with atomics.
+     *
+     * Set when the target is synced (dirty bitmap is clean, nothing in flight)
+     * and the job is running in active mode.
+     */
     bool actively_synced;
     bool should_complete;
     int64_t granularity;
@@ -126,7 +130,7 @@ typedef enum MirrorMethod {
 static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
                                             int error)
 {
-    s->actively_synced = false;
+    qatomic_set(&s->actively_synced, false);
     if (read) {
         return block_job_error_action(&s->common, s->on_source_error,
                                       true, error);
@@ -966,7 +970,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     if (s->bdev_length == 0) {
         /* Transition to the READY state and wait for complete. */
         job_transition_to_ready(&s->common.job);
-        s->actively_synced = true;
+        qatomic_set(&s->actively_synced, true);
         while (!job_cancel_requested(&s->common.job) && !s->should_complete) {
             job_yield(&s->common.job);
         }
@@ -1080,7 +1084,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
                 job_transition_to_ready(&s->common.job);
             }
             if (qatomic_read(&s->copy_mode) != MIRROR_COPY_MODE_BACKGROUND) {
-                s->actively_synced = true;
+                qatomic_set(&s->actively_synced, true);
             }
 
             should_complete = s->should_complete ||
@@ -1283,6 +1287,15 @@ static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
     }
 }
 
+static void mirror_query(BlockJob *job, BlockJobInfo *info)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
+
+    info->u.mirror = (BlockJobInfoMirror) {
+        .actively_synced = qatomic_read(&s->actively_synced),
+    };
+}
+
 static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1298,6 +1311,7 @@ static const BlockJobDriver mirror_job_driver = {
     },
     .drained_poll           = mirror_drained_poll,
     .change                 = mirror_change,
+    .query                  = mirror_query,
 };
 
 static const BlockJobDriver commit_active_job_driver = {
@@ -1416,7 +1430,7 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
         bitmap_end = QEMU_ALIGN_UP(offset + bytes, job->granularity);
         bdrv_set_dirty_bitmap(job->dirty_bitmap, bitmap_offset,
                               bitmap_end - bitmap_offset);
-        job->actively_synced = false;
+        qatomic_set(&job->actively_synced, false);
 
         action = mirror_error_action(job, false, -ret);
         if (action == BLOCK_ERROR_ACTION_REPORT) {
@@ -1475,7 +1489,8 @@ static void coroutine_fn GRAPH_RDLOCK active_write_settle(MirrorOp *op)
     uint64_t end_chunk = DIV_ROUND_UP(op->offset + op->bytes,
                                       op->s->granularity);
 
-    if (!--op->s->in_active_write_counter && op->s->actively_synced) {
+    if (!--op->s->in_active_write_counter &&
+        qatomic_read(&op->s->actively_synced)) {
         BdrvChild *source = op->s->mirror_top_bs->backing;
 
         if (QLIST_FIRST(&source->bs->parents) == source &&
@@ -1539,7 +1554,7 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
     }
 
     if (!copy_to_target && s->job && s->job->dirty_bitmap) {
-        s->job->actively_synced = false;
+        qatomic_set(&s->job->actively_synced, false);
         bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
     }
 
diff --git a/tests/qemu-iotests/109.out b/tests/qemu-iotests/109.out
index 2611d6a40f..965c9a6a0a 100644
--- a/tests/qemu-iotests/109.out
+++ b/tests/qemu-iotests/109.out
@@ -38,7 +38,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -90,7 +90,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 197120, "offset": 197120, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 197120, "offset": 197120, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -142,7 +142,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -194,7 +194,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 1024, "offset": 1024, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 1024, "offset": 1024, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -246,7 +246,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 65536, "offset": 65536, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 65536, "offset": 65536, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -298,7 +298,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -349,7 +349,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2560, "offset": 2560, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2560, "offset": 2560, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -400,7 +400,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 31457280, "offset": 31457280, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 31457280, "offset": 31457280, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -451,7 +451,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 327680, "offset": 327680, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 327680, "offset": 327680, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -502,7 +502,7 @@ read 512/512 bytes at offset 0
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 2048, "offset": 2048, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 2048, "offset": 2048, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -533,7 +533,7 @@ WARNING: Image format was not specified for 'TEST_DIR/t.raw' and probing guessed
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
@@ -557,7 +557,7 @@ Images are identical.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "src"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "src", "len": 512, "offset": 512, "speed": 0, "type": "mirror"}}
 {"execute":"query-block-jobs"}
-{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror"}]}
+{"return": [{"auto-finalize": true, "io-status": "ok", "device": "src", "auto-dismiss": true, "busy": false, "len": 512, "offset": 512, "status": "ready", "paused": false, "speed": 0, "ready": true, "type": "mirror", "actively-synced": false}]}
 {"execute":"quit"}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
-- 
2.41.0


