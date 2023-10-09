Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CB7BD7A2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmqi-000093-Ga; Mon, 09 Oct 2023 05:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqT-0008Rn-AV; Mon, 09 Oct 2023 05:46:37 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqQ-0005Zs-UY; Mon, 09 Oct 2023 05:46:37 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id D48B64493A;
 Mon,  9 Oct 2023 11:46:24 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v2 05/10] mirror: implement mirror_change method
Date: Mon,  9 Oct 2023 11:46:14 +0200
Message-Id: <20231009094619.469668-6-f.ebner@proxmox.com>
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

which allows switching the @copy-mode from 'background' to
'write-blocking'.

This is useful for management applications, so they can start out in
background mode to avoid limiting guest write speed and switch to
active mode when certain criteria are fulfilled.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v2:
    * update QEMU version in QAPI
    * update indentation in QAPI (like in a937b6aa73 ("qapi: Reformat
      doc comments to conform to current conventions"))
    * drop drained section and disable dirty bitmap call. It's already
      disabled, because the bitmap is now attached to the filter and
      set in bdrv_mirror_top_do_write(). See the earlier patch
      "block/mirror: move dirty bitmap to filter"

 block/mirror.c       | 22 ++++++++++++++++++++++
 qapi/block-core.json | 13 ++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index b84de56734..83aa4176c2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1246,6 +1246,27 @@ static bool commit_active_cancel(Job *job, bool force)
     return force || !job_is_ready(job);
 }
 
+static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
+                          Error **errp)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
+    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
+
+    if (s->copy_mode == change_opts->copy_mode) {
+        return;
+    }
+
+    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        error_setg(errp, "Cannot switch away from copy mode 'write-blocking'");
+        return;
+    }
+
+    assert(s->copy_mode == MIRROR_COPY_MODE_BACKGROUND &&
+           change_opts->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING);
+
+    s->copy_mode = MIRROR_COPY_MODE_WRITE_BLOCKING;
+}
+
 static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1260,6 +1281,7 @@ static const BlockJobDriver mirror_job_driver = {
         .cancel                 = mirror_cancel,
     },
     .drained_poll           = mirror_drained_poll,
+    .change                 = mirror_change,
 };
 
 static const BlockJobDriver commit_active_job_driver = {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c6f31a9399..01427c259a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3044,6 +3044,17 @@
 { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
   'allow-preconfig': true }
 
+##
+# @BlockJobChangeOptionsMirror:
+#
+# @copy-mode: Switch to this copy mode. Currenlty, only the switch
+#     from 'background' to 'write-blocking' is implemented.
+#
+# Since: 8.2
+##
+{ 'struct': 'BlockJobChangeOptionsMirror',
+  'data': { 'copy-mode' : 'MirrorCopyMode' } }
+
 ##
 # @BlockJobChangeOptions:
 #
@@ -3058,7 +3069,7 @@
 { 'union': 'BlockJobChangeOptions',
   'base': { 'id': 'str', 'type': 'JobType' },
   'discriminator': 'type',
-  'data': {} }
+  'data': { 'mirror': 'BlockJobChangeOptionsMirror' } }
 
 ##
 # @block-job-change:
-- 
2.39.2



