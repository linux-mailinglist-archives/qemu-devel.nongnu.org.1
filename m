Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1237DCE5C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpEf-0001I2-Q6; Tue, 31 Oct 2023 09:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qxpE5-0000X1-6f; Tue, 31 Oct 2023 09:56:15 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qxpE0-0000qD-UM; Tue, 31 Oct 2023 09:56:11 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id DD8B242A84;
 Tue, 31 Oct 2023 14:55:51 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v4 06/10] qapi/block-core: use JobType for BlockJobInfo's type
Date: Tue, 31 Oct 2023 14:54:27 +0100
Message-Id: <20231031135431.393137-7-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031135431.393137-1-f.ebner@proxmox.com>
References: <20231031135431.393137-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

In preparation to turn BlockJobInfo into a union with @type as the
discriminator. That requires it to be an enum. Even without that
requirement, it's nicer to have an enum instead of a str here.

No functional change is intended.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---

Changes in v4:
    * Mention that it's nicer to have an enum regardless in commit
      message.

 block/monitor/block-hmp-cmds.c | 4 ++--
 blockjob.c                     | 2 +-
 qapi/block-core.json           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 7645c7e5fb..5b2c597e7a 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -846,7 +846,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
     }
 
     while (list) {
-        if (strcmp(list->value->type, "stream") == 0) {
+        if (list->value->type == JOB_TYPE_STREAM) {
             monitor_printf(mon, "Streaming device %s: Completed %" PRId64
                            " of %" PRId64 " bytes, speed limit %" PRId64
                            " bytes/s\n",
@@ -858,7 +858,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
                            " of %" PRId64 " bytes, speed limit %" PRId64
                            " bytes/s\n",
-                           list->value->type,
+                           JobType_str(list->value->type),
                            list->value->device,
                            list->value->offset,
                            list->value->len,
diff --git a/blockjob.c b/blockjob.c
index 11bae119bd..9665b02627 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -388,7 +388,7 @@ BlockJobInfo *block_job_query_locked(BlockJob *job, Error **errp)
                           &progress_total);
 
     info = g_new0(BlockJobInfo, 1);
-    info->type      = g_strdup(job_type_str(&job->job));
+    info->type      = job_type(&job->job);
     info->device    = g_strdup(job->job.id);
     info->busy      = job->job.busy;
     info->paused    = job->job.pause_count > 0;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6369207be2..9d03210664 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1396,7 +1396,7 @@
 # Since: 1.1
 ##
 { 'struct': 'BlockJobInfo',
-  'data': {'type': 'str', 'device': 'str', 'len': 'int',
+  'data': {'type': 'JobType', 'device': 'str', 'len': 'int',
            'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
            'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
            'status': 'JobStatus',
-- 
2.39.2



