Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6017C81F2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEMr-0005tg-L8; Fri, 13 Oct 2023 05:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMo-0005le-Gm; Fri, 13 Oct 2023 05:21:58 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qrEMl-00072n-Is; Fri, 13 Oct 2023 05:21:58 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7A98748F2A;
 Fri, 13 Oct 2023 11:21:51 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v3 6/9] qapi/block-core: use JobType for BlockJobInfo's type
Date: Fri, 13 Oct 2023 11:21:40 +0200
Message-Id: <20231013092143.365296-7-f.ebner@proxmox.com>
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

In preparation to turn BlockJobInfo into a union with @type as the
discriminator. That requires it to be an enum.

No functional change is intended.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

No changes in v3.

 block/monitor/block-hmp-cmds.c | 4 ++--
 blockjob.c                     | 2 +-
 qapi/block-core.json           | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index ca2599de44..f9f87e5c47 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -843,7 +843,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
     }
 
     while (list) {
-        if (strcmp(list->value->type, "stream") == 0) {
+        if (list->value->type == JOB_TYPE_STREAM) {
             monitor_printf(mon, "Streaming device %s: Completed %" PRId64
                            " of %" PRId64 " bytes, speed limit %" PRId64
                            " bytes/s\n",
@@ -855,7 +855,7 @@ void hmp_info_block_jobs(Monitor *mon, const QDict *qdict)
             monitor_printf(mon, "Type %s, device %s: Completed %" PRId64
                            " of %" PRId64 " bytes, speed limit %" PRId64
                            " bytes/s\n",
-                           list->value->type,
+                           JobType_str(list->value->type),
                            list->value->device,
                            list->value->offset,
                            list->value->len,
diff --git a/blockjob.c b/blockjob.c
index d53bc775d2..f8cf6e58e2 100644
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
index 01427c259a..a19718a69f 100644
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



