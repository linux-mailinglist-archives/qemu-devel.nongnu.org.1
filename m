Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A6C7DD677
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:02:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyk-0004QE-Ox; Tue, 31 Oct 2023 15:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyO-0004Jw-NL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxo-00069O-No
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6t+CAONX0I/FpxKm+20LNomzln0cdMjNgXhxO4YSWdA=;
 b=ccLwjYVucNovnZ7KBahXyav0iZC0YB+yDqAgQCxGoGIsfV43wKMwHBLUUzil19dFifoPu3
 cNY0ckNPtV9SIqQurU7nM46N9FLaL1C96qqPSI3sw/v5+EE3GiX6Mx5FCa+zvvG7q2IerB
 f0MMDa90Dt4N0na9c0NLmCP+xqncT5Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-Q6khd0W_ONSaPlaq2e5L3A-1; Tue, 31 Oct 2023 14:59:35 -0400
X-MC-Unique: Q6khd0W_ONSaPlaq2e5L3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F4A7821C20;
 Tue, 31 Oct 2023 18:59:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1EF6143;
 Tue, 31 Oct 2023 18:59:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 18/27] blockjob: introduce block-job-change QMP command
Date: Tue, 31 Oct 2023 19:59:09 +0100
Message-ID: <20231031185918.346940-19-kwolf@redhat.com>
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

which will allow changing job-type-specific options after job
creation.

In the JobVerbTable, the same allow bits as for set-speed are used,
because set-speed can be considered an existing change command.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20231031135431.393137-2-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json         | 26 ++++++++++++++++++++++++++
 qapi/job.json                |  4 +++-
 include/block/blockjob.h     | 11 +++++++++++
 include/block/blockjob_int.h |  7 +++++++
 blockdev.c                   | 14 ++++++++++++++
 blockjob.c                   | 20 ++++++++++++++++++++
 job.c                        |  1 +
 7 files changed, 82 insertions(+), 1 deletion(-)

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
index 104824040c..a4656d4cb5 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -67,6 +67,13 @@ struct BlockJobDriver {
     void (*attached_aio_context)(BlockJob *job, AioContext *new_context);
 
     void (*set_speed)(BlockJob *job, int64_t speed);
+
+    /*
+     * Change the @job's options according to @opts.
+     *
+     * Note that this can already be called before the job coroutine is running.
+     */
+    void (*change)(BlockJob *job, BlockJobChangeOptions *opts, Error **errp);
 };
 
 /*
diff --git a/blockdev.c b/blockdev.c
index 877e3a26d4..1517dc6210 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3392,6 +3392,20 @@ void qmp_block_job_dismiss(const char *id, Error **errp)
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
index 953dc1b6dc..f0505ad232 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -330,6 +330,26 @@ static bool block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
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
-- 
2.41.0


