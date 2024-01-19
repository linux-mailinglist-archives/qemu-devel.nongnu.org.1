Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F31832EB2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:14:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNJ-0001fY-Sq; Fri, 19 Jan 2024 13:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN9-0001cy-OE
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN5-0007bK-Vk
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YirToRa5ScB2Piwjcv0ToWz+Q4DVNA0SLcAoOpyrkZc=;
 b=eNKsLiHtorjY+z+loQ6hnZk8OVYPPURZC6Ht1/e75owzL7N/UDHknIe1O3EdnyE5/O7Z+m
 JzLNLa2K1ZvSf1R1t3rPxMJbU85E6wUH8DL4kHqpo5HGQwwHnFR+LGK5JpcCjJvh1z+yv8
 p+89XeJ3wYdN9r48E+Zhl+1Y20+0qnA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-DCFs0OuLOViN9ztCO4iQWA-1; Fri, 19 Jan 2024 13:13:35 -0500
X-MC-Unique: DCFs0OuLOViN9ztCO4iQWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D2C886794C;
 Fri, 19 Jan 2024 18:13:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3B56494;
 Fri, 19 Jan 2024 18:13:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/14] commit: Allow users to request only format driver names
 in backing file format
Date: Fri, 19 Jan 2024 19:13:16 +0100
Message-ID: <20240119181327.236745-4-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

From: Peter Krempa <pkrempa@redhat.com>

Introduce a new flag 'backing-mask-protocol' for the block-commit QMP
command which instructs the internals to use 'raw' instead of the
protocol driver in case when a image is used without a dummy 'raw'
wrapper.

The flag is designed such that it can be always asserted by management
tools even when there isn't any update to backing files.

The flag will be used by libvirt so that the backing images still
reference the proper format even when libvirt will stop using the dummy
raw driver (raw driver with no other config). Libvirt needs this so that
the images stay compatible with older libvirt versions which didn't
expect that a protocol driver name can appear in the backing file format
field.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <2cb46e37093ce793ea1604abc8bbb90f4c8e434b.1701796348.git.pkrempa@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json                   |  8 +++++-
 include/block/block-global-state.h     |  3 ++-
 include/block/block_int-common.h       |  4 ++-
 include/block/block_int-global-state.h |  3 +++
 block.c                                | 37 +++++++++++++++++++++-----
 block/commit.c                         |  6 ++++-
 blockdev.c                             |  6 +++++
 tests/unit/test-bdrv-drain.c           |  3 ++-
 8 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ca390c5700..726145ec8a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1810,6 +1810,11 @@
 #     Care should be taken when specifying the string, to specify a
 #     valid filename or protocol.  (Since 2.1)
 #
+# @backing-mask-protocol: If true, replace any protocol mentioned in the
+#     'backing file format' with 'raw', rather than storing the protocol
+#     name as the backing format.  Can be used even when no image header
+#     will be updated (default false; since 9.0).
+#
 # @speed: the maximum speed, in bytes per second
 #
 # @on-error: the action to take on an error.  'ignore' means that the
@@ -1856,7 +1861,8 @@
             '*base': { 'type': 'str', 'features': [ 'deprecated' ] },
             '*top-node': 'str',
             '*top': { 'type': 'str', 'features': [ 'deprecated' ] },
-            '*backing-file': 'str', '*speed': 'int',
+            '*backing-file': 'str', '*backing-mask-protocol': 'bool',
+            '*speed': 'int',
             '*on-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 4ec0b217f0..bd7cecd1cf 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -144,7 +144,8 @@ int GRAPH_RDLOCK bdrv_make_empty(BdrvChild *c, Error **errp);
 
 void bdrv_register(BlockDriver *bdrv);
 int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
-                           const char *backing_file_str);
+                           const char *backing_file_str,
+                           bool backing_mask_protocol);
 
 BlockDriverState * GRAPH_RDLOCK
 bdrv_find_overlay(BlockDriverState *active, BlockDriverState *bs);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 151279d481..761276127e 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -985,7 +985,9 @@ struct BdrvChildClass {
      * can update its reference.
      */
     int (*update_filename)(BdrvChild *child, BlockDriverState *new_base,
-                           const char *filename, Error **errp);
+                           const char *filename,
+                           bool backing_mask_protocol,
+                           Error **errp);
 
     bool (*change_aio_ctx)(BdrvChild *child, AioContext *ctx,
                            GHashTable *visited, Transaction *tran,
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index ef31c58bb3..2162269df6 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -82,6 +82,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @on_error: The action to take upon error.
  * @backing_file_str: String to use as the backing file in @top's overlay
+ * @backing_mask_protocol: Replace potential protocol name with 'raw' in
+ *                         'backing file format' header
  * @filter_node_name: The node name that should be assigned to the filter
  * driver that the commit job inserts into the graph above @top. NULL means
  * that a node name should be autogenerated.
@@ -92,6 +94,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, BlockDriverState *top,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
+                  bool backing_mask_protocol,
                   const char *filter_node_name, Error **errp);
 /**
  * commit_active_start:
diff --git a/block.c b/block.c
index a097772238..30afdcbba6 100644
--- a/block.c
+++ b/block.c
@@ -1309,11 +1309,14 @@ static void bdrv_backing_detach(BdrvChild *c)
 }
 
 static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
-                                        const char *filename, Error **errp)
+                                        const char *filename,
+                                        bool backing_mask_protocol,
+                                        Error **errp)
 {
     BlockDriverState *parent = c->opaque;
     bool read_only = bdrv_is_read_only(parent);
     int ret;
+    const char *format_name;
     GLOBAL_STATE_CODE();
 
     if (read_only) {
@@ -1323,9 +1326,23 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
         }
     }
 
-    ret = bdrv_change_backing_file(parent, filename,
-                                   base->drv ? base->drv->format_name : "",
-                                   false);
+    if (base->drv) {
+        /*
+         * If the new base image doesn't have a format driver layer, which we
+         * detect by the fact that @base is a protocol driver, we record
+         * 'raw' as the format instead of putting the protocol name as the
+         * backing format
+         */
+        if (backing_mask_protocol && base->drv->protocol_name) {
+            format_name = "raw";
+        } else {
+            format_name = base->drv->format_name;
+        }
+    } else {
+        format_name = "";
+    }
+
+    ret = bdrv_change_backing_file(parent, filename, format_name, false);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not update backing file link");
     }
@@ -1479,10 +1496,14 @@ static void GRAPH_WRLOCK bdrv_child_cb_detach(BdrvChild *child)
 }
 
 static int bdrv_child_cb_update_filename(BdrvChild *c, BlockDriverState *base,
-                                         const char *filename, Error **errp)
+                                         const char *filename,
+                                         bool backing_mask_protocol,
+                                         Error **errp)
 {
     if (c->role & BDRV_CHILD_COW) {
-        return bdrv_backing_update_filename(c, base, filename, errp);
+        return bdrv_backing_update_filename(c, base, filename,
+                                            backing_mask_protocol,
+                                            errp);
     }
     return 0;
 }
@@ -5803,7 +5824,8 @@ void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base)
  *
  */
 int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
-                           const char *backing_file_str)
+                           const char *backing_file_str,
+                           bool backing_mask_protocol)
 {
     BlockDriverState *explicit_top = top;
     bool update_inherits_from;
@@ -5869,6 +5891,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 
         if (c->klass->update_filename) {
             ret = c->klass->update_filename(c, base, backing_file_str,
+                                            backing_mask_protocol,
                                             &local_err);
             if (ret < 0) {
                 /*
diff --git a/block/commit.c b/block/commit.c
index 1dd7a65ffb..7c3fdcb0ca 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -42,6 +42,7 @@ typedef struct CommitBlockJob {
     bool base_read_only;
     bool chain_frozen;
     char *backing_file_str;
+    bool backing_mask_protocol;
 } CommitBlockJob;
 
 static int commit_prepare(Job *job)
@@ -61,7 +62,8 @@ static int commit_prepare(Job *job)
     /* FIXME: bdrv_drop_intermediate treats total failures and partial failures
      * identically. Further work is needed to disambiguate these cases. */
     return bdrv_drop_intermediate(s->commit_top_bs, s->base_bs,
-                                  s->backing_file_str);
+                                  s->backing_file_str,
+                                  s->backing_mask_protocol);
 }
 
 static void commit_abort(Job *job)
@@ -254,6 +256,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, BlockDriverState *top,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error, const char *backing_file_str,
+                  bool backing_mask_protocol,
                   const char *filter_node_name, Error **errp)
 {
     CommitBlockJob *s;
@@ -408,6 +411,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     blk_set_disable_request_queuing(s->top, true);
 
     s->backing_file_str = g_strdup(backing_file_str);
+    s->backing_mask_protocol = backing_mask_protocol;
     s->on_error = on_error;
 
     trace_commit_start(bs, base, top, s);
diff --git a/blockdev.c b/blockdev.c
index 3a5e7222ec..292c8af3f9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2420,6 +2420,8 @@ void qmp_block_commit(const char *job_id, const char *device,
                       const char *top_node,
                       const char *top,
                       const char *backing_file,
+                      bool has_backing_mask_protocol,
+                      bool backing_mask_protocol,
                       bool has_speed, int64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
                       const char *filter_node_name,
@@ -2450,6 +2452,9 @@ void qmp_block_commit(const char *job_id, const char *device,
     if (has_auto_dismiss && !auto_dismiss) {
         job_flags |= JOB_MANUAL_DISMISS;
     }
+    if (!has_backing_mask_protocol) {
+        backing_mask_protocol = false;
+    }
 
     /* Important Note:
      *  libvirt relies on the DeviceNotFound error class in order to probe for
@@ -2591,6 +2596,7 @@ void qmp_block_commit(const char *job_id, const char *device,
         }
         commit_start(job_id, bs, base_bs, top_bs, job_flags,
                      speed, on_error, backing_file,
+                     backing_mask_protocol,
                      filter_node_name, &local_err);
     }
     if (local_err != NULL) {
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 17830a69c1..666880472b 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1591,6 +1591,7 @@ static const BlockJobDriver test_simple_job_driver = {
 static int drop_intermediate_poll_update_filename(BdrvChild *child,
                                                   BlockDriverState *new_base,
                                                   const char *filename,
+                                                  bool backing_mask_protocol,
                                                   Error **errp)
 {
     /*
@@ -1702,7 +1703,7 @@ static void test_drop_intermediate_poll(void)
     job->should_complete = true;
 
     g_assert(!job_has_completed);
-    ret = bdrv_drop_intermediate(chain[1], chain[0], NULL);
+    ret = bdrv_drop_intermediate(chain[1], chain[0], NULL, false);
     aio_poll(qemu_get_aio_context(), false);
     g_assert(ret == 0);
     g_assert(job_has_completed);
-- 
2.43.0


