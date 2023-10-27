Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D67D9DA5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAK-0004ae-1Z; Fri, 27 Oct 2023 11:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPAF-0004E7-HT
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPAB-000339-3U
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FIzNbK9jezl6MoPP5y8i5ZHqAspsH5tkidkwckiWbEk=;
 b=LLzyYtY1isSgDEW2PsoQLp8QNDsAvgd2lYkTIdcM05ubyeO5Gk/up9S3v/tXvj7m30LJiW
 Ecw1PzzwODPjHG5tY0uCE7rhCpIQFaL1yEN8dAUdzUww7Zivkw6na6XNS94QHfuElR83dl
 azBYZWC5cSi3KmOX7mA7E3aqTddWcns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-qHVlaUlgNIma5rX1EcUa5g-1; Fri, 27 Oct 2023 11:54:08 -0400
X-MC-Unique: qHVlaUlgNIma5rX1EcUa5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8A98E801958;
 Fri, 27 Oct 2023 15:54:08 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D7CC5027;
 Fri, 27 Oct 2023 15:54:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 19/24] block: Introduce bdrv_co_change_backing_file()
Date: Fri, 27 Oct 2023 17:53:28 +0200
Message-ID: <20231027155333.420094-20-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

bdrv_change_backing_file() is called both inside and outside coroutine
context. This makes it difficult for it to take the graph lock
internally. It also means that driver implementations need to be able to
run outside of coroutines, too. Switch it to the usual model with a
coroutine based implementation and a co_wrapper instead. The new
function is marked GRAPH_RDLOCK.

As the co_wrapper now runs the function in the AioContext of the node
(as it should always have done), this is not GLOBAL_STATE_CODE() any
more.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  3 +-
 include/block/block-io.h           |  8 ++++
 include/block/block_int-common.h   |  5 ++-
 block.c                            | 11 ++---
 block/qcow2.c                      | 18 +++++----
 block/qed.c                        | 64 +++++++++++++++---------------
 tests/unit/test-bdrv-drain.c       |  8 ++--
 7 files changed, 65 insertions(+), 52 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 9e0ccc1c32..6b21fbc73f 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -142,8 +142,7 @@ bdrv_refresh_limits(BlockDriverState *bs, Transaction *tran, Error **errp);
 
 int bdrv_commit(BlockDriverState *bs);
 int GRAPH_RDLOCK bdrv_make_empty(BdrvChild *c, Error **errp);
-int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
-                             const char *backing_fmt, bool warn);
+
 void bdrv_register(BlockDriver *bdrv);
 int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
                            const char *backing_file_str);
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 58c4cf50a0..f8729ccc55 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -210,6 +210,14 @@ void bdrv_round_to_subclusters(BlockDriverState *bs,
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
 
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_change_backing_file(BlockDriverState *bs, const char *backing_file,
+                            const char *backing_fmt, bool warn);
+
+int co_wrapper_bdrv_rdlock
+bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
+                         const char *backing_fmt, bool warn);
+
 int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
                       int64_t pos, int size);
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index ed6066929a..59f6d7f195 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -331,8 +331,9 @@ struct BlockDriver {
                                   const char *name,
                                   Error **errp);
 
-    int (*bdrv_change_backing_file)(BlockDriverState *bs,
-        const char *backing_file, const char *backing_fmt);
+    int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_change_backing_file)(
+        BlockDriverState *bs, const char *backing_file,
+        const char *backing_fmt);
 
     /* TODO Better pass a option string/QDict/QemuOpts to add any rule? */
     int (*bdrv_debug_breakpoint)(BlockDriverState *bs, const char *event,
diff --git a/block.c b/block.c
index 41164983a3..5749358720 100644
--- a/block.c
+++ b/block.c
@@ -5760,13 +5760,14 @@ int coroutine_fn bdrv_co_check(BlockDriverState *bs,
  *            image file header
  * -ENOTSUP - format driver doesn't support changing the backing file
  */
-int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
-                             const char *backing_fmt, bool require)
+int coroutine_fn
+bdrv_co_change_backing_file(BlockDriverState *bs, const char *backing_file,
+                            const char *backing_fmt, bool require)
 {
     BlockDriver *drv = bs->drv;
     int ret;
 
-    GLOBAL_STATE_CODE();
+    IO_CODE();
 
     if (!drv) {
         return -ENOMEDIUM;
@@ -5781,8 +5782,8 @@ int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
         return -EINVAL;
     }
 
-    if (drv->bdrv_change_backing_file != NULL) {
-        ret = drv->bdrv_change_backing_file(bs, backing_file, backing_fmt);
+    if (drv->bdrv_co_change_backing_file != NULL) {
+        ret = drv->bdrv_co_change_backing_file(bs, backing_file, backing_fmt);
     } else {
         ret = -ENOTSUP;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index a1443a31aa..63c7cd882e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3155,8 +3155,9 @@ fail:
     return ret;
 }
 
-static int qcow2_change_backing_file(BlockDriverState *bs,
-    const char *backing_file, const char *backing_fmt)
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_co_change_backing_file(BlockDriverState *bs, const char *backing_file,
+                             const char *backing_fmt)
 {
     BDRVQcow2State *s = bs->opaque;
 
@@ -3816,8 +3817,11 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
             backing_format = BlockdevDriver_str(qcow2_opts->backing_fmt);
         }
 
-        ret = bdrv_change_backing_file(blk_bs(blk), qcow2_opts->backing_file,
-                                       backing_format, false);
+        bdrv_graph_co_rdlock();
+        ret = bdrv_co_change_backing_file(blk_bs(blk), qcow2_opts->backing_file,
+                                          backing_format, false);
+        bdrv_graph_co_rdunlock();
+
         if (ret < 0) {
             error_setg_errno(errp, -ret, "Could not assign backing file '%s' "
                              "with format '%s'", qcow2_opts->backing_file,
@@ -6155,9 +6159,9 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_co_save_vmstate   = qcow2_co_save_vmstate,
     .bdrv_co_load_vmstate   = qcow2_co_load_vmstate,
 
-    .is_format                  = true,
-    .supports_backing           = true,
-    .bdrv_change_backing_file   = qcow2_change_backing_file,
+    .is_format                      = true,
+    .supports_backing               = true,
+    .bdrv_co_change_backing_file    = qcow2_co_change_backing_file,
 
     .bdrv_refresh_limits        = qcow2_refresh_limits,
     .bdrv_co_invalidate_cache   = qcow2_co_invalidate_cache,
diff --git a/block/qed.c b/block/qed.c
index 686ad711f7..996aa384fe 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1498,9 +1498,9 @@ bdrv_qed_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
-static int bdrv_qed_change_backing_file(BlockDriverState *bs,
-                                        const char *backing_file,
-                                        const char *backing_fmt)
+static int coroutine_fn GRAPH_RDLOCK
+bdrv_qed_co_change_backing_file(BlockDriverState *bs, const char *backing_file,
+                                const char *backing_fmt)
 {
     BDRVQEDState *s = bs->opaque;
     QEDHeader new_header, le_header;
@@ -1562,7 +1562,7 @@ static int bdrv_qed_change_backing_file(BlockDriverState *bs,
     }
 
     /* Write new header */
-    ret = bdrv_pwrite_sync(bs->file, 0, buffer_len, buffer, 0);
+    ret = bdrv_co_pwrite_sync(bs->file, 0, buffer_len, buffer, 0);
     g_free(buffer);
     if (ret == 0) {
         memcpy(&s->header, &new_header, sizeof(new_header));
@@ -1636,34 +1636,34 @@ static QemuOptsList qed_create_opts = {
 };
 
 static BlockDriver bdrv_qed = {
-    .format_name              = "qed",
-    .instance_size            = sizeof(BDRVQEDState),
-    .create_opts              = &qed_create_opts,
-    .is_format                = true,
-    .supports_backing         = true,
-
-    .bdrv_probe               = bdrv_qed_probe,
-    .bdrv_open                = bdrv_qed_open,
-    .bdrv_close               = bdrv_qed_close,
-    .bdrv_reopen_prepare      = bdrv_qed_reopen_prepare,
-    .bdrv_child_perm          = bdrv_default_perms,
-    .bdrv_co_create           = bdrv_qed_co_create,
-    .bdrv_co_create_opts      = bdrv_qed_co_create_opts,
-    .bdrv_has_zero_init       = bdrv_has_zero_init_1,
-    .bdrv_co_block_status     = bdrv_qed_co_block_status,
-    .bdrv_co_readv            = bdrv_qed_co_readv,
-    .bdrv_co_writev           = bdrv_qed_co_writev,
-    .bdrv_co_pwrite_zeroes    = bdrv_qed_co_pwrite_zeroes,
-    .bdrv_co_truncate         = bdrv_qed_co_truncate,
-    .bdrv_co_getlength        = bdrv_qed_co_getlength,
-    .bdrv_co_get_info         = bdrv_qed_co_get_info,
-    .bdrv_refresh_limits      = bdrv_qed_refresh_limits,
-    .bdrv_change_backing_file = bdrv_qed_change_backing_file,
-    .bdrv_co_invalidate_cache = bdrv_qed_co_invalidate_cache,
-    .bdrv_co_check            = bdrv_qed_co_check,
-    .bdrv_detach_aio_context  = bdrv_qed_detach_aio_context,
-    .bdrv_attach_aio_context  = bdrv_qed_attach_aio_context,
-    .bdrv_drain_begin         = bdrv_qed_drain_begin,
+    .format_name                    = "qed",
+    .instance_size                  = sizeof(BDRVQEDState),
+    .create_opts                    = &qed_create_opts,
+    .is_format                      = true,
+    .supports_backing               = true,
+
+    .bdrv_probe                     = bdrv_qed_probe,
+    .bdrv_open                      = bdrv_qed_open,
+    .bdrv_close                     = bdrv_qed_close,
+    .bdrv_reopen_prepare            = bdrv_qed_reopen_prepare,
+    .bdrv_child_perm                = bdrv_default_perms,
+    .bdrv_co_create                 = bdrv_qed_co_create,
+    .bdrv_co_create_opts            = bdrv_qed_co_create_opts,
+    .bdrv_has_zero_init             = bdrv_has_zero_init_1,
+    .bdrv_co_block_status           = bdrv_qed_co_block_status,
+    .bdrv_co_readv                  = bdrv_qed_co_readv,
+    .bdrv_co_writev                 = bdrv_qed_co_writev,
+    .bdrv_co_pwrite_zeroes          = bdrv_qed_co_pwrite_zeroes,
+    .bdrv_co_truncate               = bdrv_qed_co_truncate,
+    .bdrv_co_getlength              = bdrv_qed_co_getlength,
+    .bdrv_co_get_info               = bdrv_qed_co_get_info,
+    .bdrv_refresh_limits            = bdrv_qed_refresh_limits,
+    .bdrv_co_change_backing_file    = bdrv_qed_co_change_backing_file,
+    .bdrv_co_invalidate_cache       = bdrv_qed_co_invalidate_cache,
+    .bdrv_co_check                  = bdrv_qed_co_check,
+    .bdrv_detach_aio_context        = bdrv_qed_detach_aio_context,
+    .bdrv_attach_aio_context        = bdrv_qed_attach_aio_context,
+    .bdrv_drain_begin               = bdrv_qed_drain_begin,
 };
 
 static void bdrv_qed_init(void)
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index ba4e42b197..8d05538bf6 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -96,9 +96,9 @@ static int coroutine_fn bdrv_test_co_preadv(BlockDriverState *bs,
     return 0;
 }
 
-static int bdrv_test_change_backing_file(BlockDriverState *bs,
-                                         const char *backing_file,
-                                         const char *backing_fmt)
+static int bdrv_test_co_change_backing_file(BlockDriverState *bs,
+                                            const char *backing_file,
+                                            const char *backing_fmt)
 {
     return 0;
 }
@@ -116,7 +116,7 @@ static BlockDriver bdrv_test = {
 
     .bdrv_child_perm        = bdrv_default_perms,
 
-    .bdrv_change_backing_file = bdrv_test_change_backing_file,
+    .bdrv_co_change_backing_file = bdrv_test_co_change_backing_file,
 };
 
 static void aio_ret_cb(void *opaque, int ret)
-- 
2.41.0


