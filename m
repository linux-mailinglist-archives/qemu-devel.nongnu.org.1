Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB4F7DD68B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyt-0004s9-AC; Tue, 31 Oct 2023 15:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyd-0004W2-EI
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxu-0006BJ-Ty
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQ+yLjCSYg+hcTyjt3C0npoKvWcwo7cjr3w7EYuYwL0=;
 b=c/WMRUxCLOKbM6jm8awq4ZR/LTeQcs5d6Ysp7mqzRifi2IXeyDrCrAMcRfVxHPXhsjOclz
 erMmwms1SK3vURQAvRF2SWDwAuxlnMUGZcUAc5NHqtIth7V8LFWnbIN1402NDFj2yVK/Zq
 ucAnBvyY+Bl5sdG4KjbpKVS80OJlGhU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-IXw4Qk6YMeS1cv49yxFjkA-1; Tue, 31 Oct 2023 14:59:39 -0400
X-MC-Unique: IXw4Qk6YMeS1cv49yxFjkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F947835289;
 Tue, 31 Oct 2023 18:59:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED0133DD;
 Tue, 31 Oct 2023 18:59:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 22/27] mirror: implement mirror_change method
Date: Tue, 31 Oct 2023 19:59:13 +0100
Message-ID: <20231031185918.346940-23-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

which allows switching the @copy-mode from 'background' to
'write-blocking'.

This is useful for management applications, so they can start out in
background mode to avoid limiting guest write speed and switch to
active mode when certain criteria are fulfilled.

In presence of an iothread, the copy_mode member is now shared between
the iothread and the main thread, so turn accesses to it atomic.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231031135431.393137-6-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 13 ++++++++++++-
 block/mirror.c       | 44 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c6f31a9399..6369207be2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3044,6 +3044,17 @@
 { 'command': 'block-job-finalize', 'data': { 'id': 'str' },
   'allow-preconfig': true }
 
+##
+# @BlockJobChangeOptionsMirror:
+#
+# @copy-mode: Switch to this copy mode.  Currently, only the switch
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
diff --git a/block/mirror.c b/block/mirror.c
index 31da1526eb..4016d89253 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -55,6 +55,10 @@ typedef struct MirrorBlockJob {
     BlockMirrorBackingMode backing_mode;
     /* Whether the target image requires explicit zero-initialization */
     bool zero_target;
+    /*
+     * To be accesssed with atomics. Written only under the BQL (required by the
+     * current implementation of mirror_change()).
+     */
     MirrorCopyMode copy_mode;
     BlockdevOnError on_source_error, on_target_error;
     /* Set when the target is synced (dirty bitmap is clean, nothing
@@ -1075,7 +1079,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
                  */
                 job_transition_to_ready(&s->common.job);
             }
-            if (s->copy_mode != MIRROR_COPY_MODE_BACKGROUND) {
+            if (qatomic_read(&s->copy_mode) != MIRROR_COPY_MODE_BACKGROUND) {
                 s->actively_synced = true;
             }
 
@@ -1246,6 +1250,39 @@ static bool commit_active_cancel(Job *job, bool force)
     return force || !job_is_ready(job);
 }
 
+static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
+                          Error **errp)
+{
+    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
+    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
+    MirrorCopyMode current;
+
+    /*
+     * The implementation relies on the fact that copy_mode is only written
+     * under the BQL. Otherwise, further synchronization would be required.
+     */
+
+    GLOBAL_STATE_CODE();
+
+    if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
+        return;
+    }
+
+    if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
+        error_setg(errp, "Change to copy mode '%s' is not implemented",
+                   MirrorCopyMode_str(change_opts->copy_mode));
+        return;
+    }
+
+    current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
+                              change_opts->copy_mode);
+    if (current != MIRROR_COPY_MODE_BACKGROUND) {
+        error_setg(errp, "Expected current copy mode '%s', got '%s'",
+                   MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
+                   MirrorCopyMode_str(current));
+    }
+}
+
 static const BlockJobDriver mirror_job_driver = {
     .job_driver = {
         .instance_size          = sizeof(MirrorBlockJob),
@@ -1260,6 +1297,7 @@ static const BlockJobDriver mirror_job_driver = {
         .cancel                 = mirror_cancel,
     },
     .drained_poll           = mirror_drained_poll,
+    .change                 = mirror_change,
 };
 
 static const BlockJobDriver commit_active_job_driver = {
@@ -1467,7 +1505,7 @@ static bool should_copy_to_target(MirrorBDSOpaque *s)
 {
     return s->job && s->job->ret >= 0 &&
         !job_is_cancelled(&s->job->common.job) &&
-        s->job->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING;
+        qatomic_read(&s->job->copy_mode) == MIRROR_COPY_MODE_WRITE_BLOCKING;
 }
 
 static int coroutine_fn GRAPH_RDLOCK
@@ -1813,7 +1851,7 @@ static BlockJob *mirror_start_job(
     s->is_none_mode = is_none_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
-    s->copy_mode = copy_mode;
+    qatomic_set(&s->copy_mode, copy_mode);
     s->base = base;
     s->base_overlay = bdrv_find_overlay(bs, base);
     s->granularity = granularity;
-- 
2.41.0


