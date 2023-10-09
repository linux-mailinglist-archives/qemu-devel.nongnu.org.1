Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EED7BD788
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmqm-0000BG-AN; Mon, 09 Oct 2023 05:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqT-0008Rp-EA; Mon, 09 Oct 2023 05:46:37 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqQ-0005Zr-V0; Mon, 09 Oct 2023 05:46:37 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id E54BB44948;
 Mon,  9 Oct 2023 11:46:24 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v2 09/10] mirror: return mirror-specific information upon query
Date: Mon,  9 Oct 2023 11:46:18 +0200
Message-Id: <20231009094619.469668-10-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009094619.469668-1-f.ebner@proxmox.com>
References: <20231009094619.469668-1-f.ebner@proxmox.com>
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

To start out, only actively-synced is returned.

For example, this is useful for jobs that started out in background
mode and switched to active mode. Once actively-synced is true, it's
clear that the mode switch has been completed. Note that completion of
the switch might happen much earlier, e.g. if the switch happens
before the job is ready, once all background operations have finished.
It's assumed that whether the disks are actively-synced or not is more
interesting than whether the mode switch completed. That information
can still be added if required in the future.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
    * udpate QEMU version in QAPI
    * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
      doc comments to conform to current conventions"))

 block/mirror.c       | 10 ++++++++++
 qapi/block-core.json | 16 +++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index 83aa4176c2..33b72ec5e5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1267,6 +1267,15 @@ static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
     s->copy_mode = MIRROR_COPY_MODE_WRITE_BLOCKING;
 }
 
+static void mirror_query(BlockJob *job, BlockJobInfo *info)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
+
+    info->u.mirror = (BlockJobInfoMirror) {
+        .actively_synced = s->actively_synced,
+    };
+}
+
 static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1282,6 +1291,7 @@ static const BlockJobDriver mirror_job_driver = {
     },
     .drained_poll           = mirror_drained_poll,
     .change                 = mirror_change,
+    .query                  = mirror_query,
 };
 
 static const BlockJobDriver commit_active_job_driver = {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 950542b735..35d67410cc 100644
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
-- 
2.39.2



