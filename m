Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865ECA929A1
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 20:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UCB-0004jz-CQ; Thu, 17 Apr 2025 14:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBr-0004E3-L7
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBp-00030l-NE
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744915340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TSvZOan1GP0VtSPKXM3CrFSicyuh3mnQKzM0bDOKOE=;
 b=IOzIGX23uYZeouvqSfKL9z7OlxsxxKhw3US8vRIK2W4hfe/q8HCEGQTLTynXRppA5gloPT
 kjHgdaSzPZ4NFqtDvLfv6zMqsNvmJn10zxqUDNczXj3UUp1P1wouC0Sk6rcM6Tx8oFTL5W
 AYFq3iZqz3llJOG3J5VVqDchDoAhN1g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-TpUChdHxOAGvLvui-XKwrw-1; Thu,
 17 Apr 2025 14:42:14 -0400
X-MC-Unique: TpUChdHxOAGvLvui-XKwrw-1
X-Mimecast-MFC-AGG-ID: TpUChdHxOAGvLvui-XKwrw_1744915333
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DF7119560AB; Thu, 17 Apr 2025 18:42:13 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.121])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3F9C1956095; Thu, 17 Apr 2025 18:42:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 11/11] mirror: Allow QMP override to declare target already
 zero
Date: Thu, 17 Apr 2025 13:39:16 -0500
Message-ID: <20250417184133.105746-24-eblake@redhat.com>
In-Reply-To: <20250417184133.105746-13-eblake@redhat.com>
References: <20250417184133.105746-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

QEMU's attempts to learn whether a destination file starts life with
all zero contents are just a heuristic.  There may be cases where the
caller is aware of information that QEMU cannot learn quickly, in
which case telling QEMU what to assume about the destination can make
the mirror operation faster.  Given our existing example of "qemu-img
convert --target-is-zero", it is time to expose this override in QMP
for blockdev-mirror as well.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block-core.json                   |  8 +++++++-
 include/block/block_int-global-state.h |  3 ++-
 block/mirror.c                         | 23 +++++++++++++++--------
 blockdev.c                             | 18 +++++++++++-------
 tests/unit/test-block-iothread.c       |  2 +-
 5 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index b1937780e19..7f70ec6d3cb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2538,6 +2538,11 @@
 #     disappear from the query list without user intervention.
 #     Defaults to true.  (Since 3.1)
 #
+# @target-is-zero: Assume the destination reads as all zeroes before
+#     the mirror started.  Setting this to true can speed up the
+#     mirror.  Setting this to true when the destination is not
+#     actually all zero can corrupt the destination.  (Since 10.1)
+#
 # Since: 2.6
 #
 # .. qmp-example::
@@ -2557,7 +2562,8 @@
             '*on-target-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
             '*copy-mode': 'MirrorCopyMode',
-            '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
+            '*auto-finalize': 'bool', '*auto-dismiss': 'bool',
+            '*target-is-zero': 'bool'},
   'allow-preconfig': true }

 ##
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index eb2d92a2261..a2b96f90d44 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -140,6 +140,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,
  * @mode: Whether to collapse all images in the chain to the target.
  * @backing_mode: How to establish the target's backing chain after completion.
  * @zero_target: Whether the target should be explicitly zero-initialized
+ * @target_is_zero: Whether the target already is zero-initialized
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
  * @unmap: Whether to unmap target where source sectors only contain zeroes.
@@ -159,7 +160,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
-                  bool zero_target,
+                  bool zero_target, bool target_is_zero,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
diff --git a/block/mirror.c b/block/mirror.c
index 4770d87abf6..22cca5d22aa 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -55,6 +55,8 @@ typedef struct MirrorBlockJob {
     BlockMirrorBackingMode backing_mode;
     /* Whether the target image requires explicit zero-initialization */
     bool zero_target;
+    /* Whether the target should be assumed to be already zero initialized */
+    bool target_is_zero;
     /*
      * To be accesssed with atomics. Written only under the BQL (required by the
      * current implementation of mirror_change()).
@@ -883,9 +885,13 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
         int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);

         offset = 0;
-        bdrv_graph_co_rdlock();
-        ret = bdrv_co_is_all_zeroes(target_bs);
-        bdrv_graph_co_rdunlock();
+        if (s->target_is_zero) {
+            ret = 1;
+        } else {
+            bdrv_graph_co_rdlock();
+            ret = bdrv_co_is_all_zeroes(target_bs);
+            bdrv_graph_co_rdunlock();
+        }
         if (ret < 0) {
             return ret;
         }
@@ -1782,7 +1788,7 @@ static BlockJob *mirror_start_job(
                              const char *replaces, int64_t speed,
                              uint32_t granularity, int64_t buf_size,
                              BlockMirrorBackingMode backing_mode,
-                             bool zero_target,
+                             bool zero_target, bool target_is_zero,
                              BlockdevOnError on_source_error,
                              BlockdevOnError on_target_error,
                              bool unmap,
@@ -1951,6 +1957,7 @@ static BlockJob *mirror_start_job(
     s->is_none_mode = is_none_mode;
     s->backing_mode = backing_mode;
     s->zero_target = zero_target;
+    s->target_is_zero = target_is_zero;
     qatomic_set(&s->copy_mode, copy_mode);
     s->base = base;
     s->base_overlay = bdrv_find_overlay(bs, base);
@@ -2079,7 +2086,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                   int creation_flags, int64_t speed,
                   uint32_t granularity, int64_t buf_size,
                   MirrorSyncMode mode, BlockMirrorBackingMode backing_mode,
-                  bool zero_target,
+                  bool zero_target, bool target_is_zero,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   bool unmap, const char *filter_node_name,
@@ -2104,8 +2111,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,

     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode, zero_target,
-                     on_source_error, on_target_error, unmap, NULL, NULL,
-                     &mirror_job_driver, is_none_mode, base, false,
+                     target_is_zero, on_source_error, on_target_error, unmap,
+                     NULL, NULL, &mirror_job_driver, is_none_mode, base, false,
                      filter_node_name, true, copy_mode, false, errp);
 }

@@ -2131,7 +2138,7 @@ BlockJob *commit_active_start(const char *job_id, BlockDriverState *bs,

     job = mirror_start_job(
                      job_id, bs, creation_flags, base, NULL, speed, 0, 0,
-                     MIRROR_LEAVE_BACKING_CHAIN, false,
+                     MIRROR_LEAVE_BACKING_CHAIN, false, false,
                      on_error, on_error, true, cb, opaque,
                      &commit_active_job_driver, false, base, auto_complete,
                      filter_node_name, false, MIRROR_COPY_MODE_BACKGROUND,
diff --git a/blockdev.c b/blockdev.c
index 1d1f27cfff6..6f5373991c8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2798,7 +2798,7 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
                                    const char *replaces,
                                    enum MirrorSyncMode sync,
                                    BlockMirrorBackingMode backing_mode,
-                                   bool zero_target,
+                                   bool zero_target, bool target_is_zero,
                                    bool has_speed, int64_t speed,
                                    bool has_granularity, uint32_t granularity,
                                    bool has_buf_size, int64_t buf_size,
@@ -2909,11 +2909,10 @@ static void blockdev_mirror_common(const char *job_id, BlockDriverState *bs,
     /* pass the node name to replace to mirror start since it's loose coupling
      * and will allow to check whether the node still exist at mirror completion
      */
-    mirror_start(job_id, bs, target,
-                 replaces, job_flags,
+    mirror_start(job_id, bs, target, replaces, job_flags,
                  speed, granularity, buf_size, sync, backing_mode, zero_target,
-                 on_source_error, on_target_error, unmap, filter_node_name,
-                 copy_mode, errp);
+                 target_is_zero, on_source_error, on_target_error, unmap,
+                 filter_node_name, copy_mode, errp);
 }

 void qmp_drive_mirror(DriveMirror *arg, Error **errp)
@@ -2928,6 +2927,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     int64_t size;
     const char *format = arg->format;
     bool zero_target;
+    bool target_is_zero;
     int ret;

     bs = qmp_get_root_bs(arg->device, errp);
@@ -3044,6 +3044,8 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
                    (arg->mode == NEW_IMAGE_MODE_EXISTING ||
                     !bdrv_has_zero_init(target_bs)));
+    target_is_zero = (arg->mode == NEW_IMAGE_MODE_ABSOLUTE_PATHS &&
+                      bdrv_has_zero_init(target_bs));
     bdrv_graph_rdunlock_main_loop();


@@ -3055,7 +3057,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)

     blockdev_mirror_common(arg->job_id, bs, target_bs,
                            arg->replaces, arg->sync,
-                           backing_mode, zero_target,
+                           backing_mode, zero_target, target_is_zero,
                            arg->has_speed, arg->speed,
                            arg->has_granularity, arg->granularity,
                            arg->has_buf_size, arg->buf_size,
@@ -3085,6 +3087,7 @@ void qmp_blockdev_mirror(const char *job_id,
                          bool has_copy_mode, MirrorCopyMode copy_mode,
                          bool has_auto_finalize, bool auto_finalize,
                          bool has_auto_dismiss, bool auto_dismiss,
+                         bool has_target_is_zero, bool target_is_zero,
                          Error **errp)
 {
     BlockDriverState *bs;
@@ -3115,7 +3118,8 @@ void qmp_blockdev_mirror(const char *job_id,

     blockdev_mirror_common(job_id, bs, target_bs,
                            replaces, sync, backing_mode,
-                           zero_target, has_speed, speed,
+                           zero_target, has_target_is_zero && target_is_zero,
+                           has_speed, speed,
                            has_granularity, granularity,
                            has_buf_size, buf_size,
                            has_on_source_error, on_source_error,
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 8189b32fd52..ffc878d401e 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -755,7 +755,7 @@ static void test_propagate_mirror(void)

     /* Start a mirror job */
     mirror_start("job0", src, target, NULL, JOB_DEFAULT, 0, 0, 0,
-                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false,
+                 MIRROR_SYNC_MODE_NONE, MIRROR_OPEN_BACKING_CHAIN, false, false,
                  BLOCKDEV_ON_ERROR_REPORT, BLOCKDEV_ON_ERROR_REPORT,
                  false, "filter_node", MIRROR_COPY_MODE_BACKGROUND,
                  &error_abort);
-- 
2.49.0


