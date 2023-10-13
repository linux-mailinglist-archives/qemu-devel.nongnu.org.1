Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 389447C81EA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEMp-0005li-9c; Fri, 13 Oct 2023 05:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMl-0005id-Qh; Fri, 13 Oct 2023 05:21:55 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMj-00071n-JR; Fri, 13 Oct 2023 05:21:55 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 626EA48F24;
 Fri, 13 Oct 2023 11:21:51 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v3 1/9] blockjob: introduce block-job-change QMP command
Date: Fri, 13 Oct 2023 11:21:35 +0200
Message-Id: <20231013092143.365296-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013092143.365296-1-f.ebner@proxmox.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

which will allow changing job-type-specific options after job
creation.

In the JobVerbTable, the same allow bits as for set-speed are used,
because set-speed can be considered an existing change command.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

No changes in v3.

 blockdev.c                   | 14 ++++++++++++++
 blockjob.c                   | 20 ++++++++++++++++++++
 include/block/blockjob.h     | 11 +++++++++++
 include/block/blockjob_int.h |  5 +++++
 job.c                        |  1 +
 qapi/block-core.json         | 26 ++++++++++++++++++++++++++
 qapi/job.json                |  4 +++-
 7 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 325b7a3bef..d0e274ff8b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3344,6 +3344,20 @@ void qmp_block_job_dismiss(const char *id, Error **errp)
     job_dismiss_locked(&job, errp);
 }
 
+void qmp_block_job_change(BlockJobChangeOptions *opts, Error **errp)
+{
+    BlockJob *job;
+
+    JOB_LOCK_GUARD();
+    job = find_block_job_locked(opts->id, errp);
+
+    if (!job) {
+        return;
+    }
+
+    block_job_change_locked(job, opts, errp);
+}
+
 void qmp_change_backing_file(const char *device,
                              const char *image_node_name,
                              const char *backing_file,
diff --git a/blockjob.c b/blockjob.c
index 58c5d64539..d53bc775d2 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -328,6 +328,26 @@ static bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     return block_job_set_speed_locked(job, speed, errp);
 }
 
+void block_job_change_locked(BlockJob *job, BlockJobChangeOptions *opts,
+                             Error **errp)
+{
+    const BlockJobDriver *drv = block_job_driver(job);
+
+    GLOBAL_STATE_CODE();
+
+    if (job_apply_verb_locked(&job->job, JOB_VERB_CHANGE, errp)) {
+        return;
+    }
+
+    if (drv->change) {
+        job_unlock();
+        drv->change(job, opts, errp);
+        job_lock();
+    } else {
+        error_setg(errp, "Job type does not support change");
+    }
+}
+
 void block_job_ratelimit_processed_bytes(BlockJob *job, uint64_t n)
 {
     IO_CODE();
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 058b0c824c..95854f1477 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -172,6 +172,17 @@ bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs);
  */
 bool block_job_set_speed_locked(BlockJob *job, int64_t speed, Error **errp);
 
+/**
+ * block_job_change_locked:
+ * @job: The job to change.
+ * @opts: The new options.
+ * @errp: Error object.
+ *
+ * Change the job according to opts.
+ */
+void block_job_change_locked(BlockJob *job, BlockJobChangeOptions *opts,
+                             Error **errp);
+
 /**
  * block_job_query_locked:
  * @job: The job to get information about.
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 104824040c..f604985315 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -67,6 +67,11 @@ struct BlockJobDriver {
     void (*attached_aio_context)(BlockJob *job, AioContext *new_context);
 
     void (*set_speed)(BlockJob *job, int64_t speed);
+
+    /*
+     * Change the @job's options according to @opts.
+     */
+    void (*change)(BlockJob *job, BlockJobChangeOptions *opts, Error **errp);
 };
 
 /*
diff --git a/job.c b/job.c
index 72d57f0934..99a2e54b54 100644
--- a/job.c
+++ b/job.c
@@ -80,6 +80,7 @@ bool JobVerbTable[JOB_VERB__MAX][JOB_STATUS__MAX] = {
     [JOB_VERB_COMPLETE]             = {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
     [JOB_VERB_FINALIZE]             = {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
     [JOB_VERB_DISMISS]              = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
+    [JOB_VERB_CHANGE]               = {0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
 };
 
 /* Transactional group of jobs */
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 89751d81f2..c6f31a9399 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3044,6 +3044,32 @@
 { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
   'allow-preconfig': true }
 
+##
+# @BlockJobChangeOptions:
+#
+# Block job options that can be changed after job creation.
+#
+# @id: The job identifier
+#
+# @type: The job type
+#
+# Since 8.2
+##
+{ 'union': 'BlockJobChangeOptions',
+  'base': { 'id': 'str', 'type': 'JobType' },
+  'discriminator': 'type',
+  'data': {} }
+
+##
+# @block-job-change:
+#
+# Change the block job's options.
+#
+# Since: 8.2
+##
+{ 'command': 'block-job-change',
+  'data': 'BlockJobChangeOptions', 'boxed': true }
+
 ##
 # @BlockdevDiscardOptions:
 #
diff --git a/qapi/job.json b/qapi/job.json
index 7f0ba090de..b3957207a4 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -105,11 +105,13 @@
 #
 # @finalize: see @job-finalize
 #
+# @change: see @block-job-change (since 8.2)
+#
 # Since: 2.12
 ##
 { 'enum': 'JobVerb',
   'data': ['cancel', 'pause', 'resume', 'set-speed', 'complete', 'dismiss',
-           'finalize' ] }
+           'finalize', 'change' ] }
 
 ##
 # @JOB_STATUS_CHANGE:
-- 
2.39.2



