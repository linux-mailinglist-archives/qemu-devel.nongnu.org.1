Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AD879A6FA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVG-0005nV-84; Mon, 11 Sep 2023 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVB-0005l8-Vv
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdV9-0004dz-1A
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTOaGya4DKtPu2gi382rSuO1CtrdTKhcD4vpjzq1o/0=;
 b=eg/bLPfrFUo75rwknBhyEFOH9YIv+5hbyV8FSwpYmahag9Qwv/f6r/orE/+BFy+YMqqqYQ
 joI+StfUM8XwS6NO9/66owbvLuM9ejNuXk0Qmcg58PbTja7CV4yU65f+6gMaIsznlTg6zS
 HqtLVNoIh6fxg9X1KDhjZgiXOLQQwtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-vszdlBEUPu-jXOGNsaL5xw-1; Mon, 11 Sep 2023 05:46:36 -0400
X-MC-Unique: vszdlBEUPu-jXOGNsaL5xw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 328118164FB;
 Mon, 11 Sep 2023 09:46:36 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0176A40C6EA8;
 Mon, 11 Sep 2023 09:46:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 03/21] preallocate: Don't poll during permission updates
Date: Mon, 11 Sep 2023 11:46:02 +0200
Message-ID: <20230911094620.45040-4-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the permission related BlockDriver callbacks are called, we are in
the middle of an operation traversing the block graph. Polling in such a
place is a very bad idea because the graph could change in unexpected
ways. In the future, callers will also hold the graph lock, which is
likely to turn polling into a deadlock.

So we need to get rid of calls to functions like bdrv_getlength() or
bdrv_truncate() there as these functions poll internally. They are
currently used so that when no parent has write/resize permissions on
the image any more, the preallocate filter drops the extra preallocated
area in the image file and gives up write/resize permissions itself.

In order to achieve this without polling in .bdrv_check_perm, don't
immediately truncate the image, but only schedule a BH to do so. The
filter keeps the write/resize permissions a bit longer now until the BH
has executed.

There is one case in which delaying doesn't work: Reopening the image
read-only. In this case, bs->file will likely be reopened read-only,
too, so keeping write permissions a bit longer on it doesn't work. But
we can already cover this case in preallocate_reopen_prepare() and not
rely on the permission updates for it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/preallocate.c | 89 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 69 insertions(+), 20 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 3173d80534..bfb638d8b1 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -75,8 +75,14 @@ typedef struct BDRVPreallocateState {
      * be invalid (< 0) when we don't have both exclusive BLK_PERM_RESIZE and
      * BLK_PERM_WRITE permissions on file child.
      */
+
+    /* Gives up the resize permission on children when parents don't need it */
+    QEMUBH *drop_resize_bh;
 } BDRVPreallocateState;
 
+static int preallocate_drop_resize(BlockDriverState *bs, Error **errp);
+static void preallocate_drop_resize_bh(void *opaque);
+
 #define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
 #define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
 static QemuOptsList runtime_opts = {
@@ -142,6 +148,7 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
      * For this to work, mark them invalid.
      */
     s->file_end = s->zero_start = s->data_end = -EINVAL;
+    s->drop_resize_bh = qemu_bh_new(preallocate_drop_resize_bh, bs);
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
@@ -193,6 +200,9 @@ static void preallocate_close(BlockDriverState *bs)
 {
     BDRVPreallocateState *s = bs->opaque;
 
+    qemu_bh_cancel(s->drop_resize_bh);
+    qemu_bh_delete(s->drop_resize_bh);
+
     if (s->data_end >= 0) {
         preallocate_truncate_to_real_size(bs, NULL);
     }
@@ -211,6 +221,7 @@ static int preallocate_reopen_prepare(BDRVReopenState *reopen_state,
                                       BlockReopenQueue *queue, Error **errp)
 {
     PreallocateOpts *opts = g_new0(PreallocateOpts, 1);
+    int ret;
 
     if (!preallocate_absorb_opts(opts, reopen_state->options,
                                  reopen_state->bs->file->bs, errp)) {
@@ -218,6 +229,19 @@ static int preallocate_reopen_prepare(BDRVReopenState *reopen_state,
         return -EINVAL;
     }
 
+    /*
+     * Drop the preallocation already here if reopening read-only. The child
+     * might also be reopened read-only and then scheduling a BH during the
+     * permission update is too late.
+     */
+    if ((reopen_state->flags & BDRV_O_RDWR) == 0) {
+        ret = preallocate_drop_resize(reopen_state->bs, errp);
+        if (ret < 0) {
+            g_free(opts);
+            return ret;
+        }
+    }
+
     reopen_state->opaque = opts;
 
     return 0;
@@ -475,41 +499,61 @@ preallocate_co_getlength(BlockDriverState *bs)
     return ret;
 }
 
-static int preallocate_check_perm(BlockDriverState *bs,
-                                  uint64_t perm, uint64_t shared, Error **errp)
+static int preallocate_drop_resize(BlockDriverState *bs, Error **errp)
 {
     BDRVPreallocateState *s = bs->opaque;
+    int ret;
 
-    if (s->data_end >= 0 && !can_write_resize(perm)) {
-        /*
-         * Lose permissions.
-         * We should truncate in check_perm, as in set_perm bs->file->perm will
-         * be already changed, and we should not violate it.
-         */
-        return preallocate_truncate_to_real_size(bs, errp);
+    if (s->data_end < 0) {
+        return 0;
+    }
+
+    /*
+     * Before switching children to be read-only, truncate them to remove
+     * the preallocation and let them have the real size.
+     */
+    ret = preallocate_truncate_to_real_size(bs, errp);
+    if (ret < 0) {
+        return ret;
     }
 
+    /*
+     * We'll drop our permissions and will allow other users to take write and
+     * resize permissions (see preallocate_child_perm). Anyone will be able to
+     * change the child, so mark all states invalid. We'll regain control if a
+     * parent requests write access again.
+     */
+    s->data_end = s->file_end = s->zero_start = -EINVAL;
+
+    bdrv_graph_rdlock_main_loop();
+    bdrv_child_refresh_perms(bs, bs->file, NULL);
+    bdrv_graph_rdunlock_main_loop();
+
     return 0;
 }
 
+static void preallocate_drop_resize_bh(void *opaque)
+{
+    /*
+     * In case of errors, we'll simply keep the exclusive lock on the image
+     * indefinitely.
+     */
+    preallocate_drop_resize(opaque, NULL);
+}
+
 static void preallocate_set_perm(BlockDriverState *bs,
                                  uint64_t perm, uint64_t shared)
 {
     BDRVPreallocateState *s = bs->opaque;
 
     if (can_write_resize(perm)) {
+        qemu_bh_cancel(s->drop_resize_bh);
         if (s->data_end < 0) {
             s->data_end = s->file_end = s->zero_start =
-                bdrv_getlength(bs->file->bs);
+                bs->file->bs->total_sectors * BDRV_SECTOR_SIZE;
         }
     } else {
-        /*
-         * We drop our permissions, as well as allow shared
-         * permissions (see preallocate_child_perm), anyone will be able to
-         * change the child, so mark all states invalid. We'll regain control if
-         * get good permissions back.
-         */
-        s->data_end = s->file_end = s->zero_start = -EINVAL;
+        qemu_bh_schedule(s->drop_resize_bh);
     }
 }
 
@@ -517,10 +561,16 @@ static void preallocate_child_perm(BlockDriverState *bs, BdrvChild *c,
     BdrvChildRole role, BlockReopenQueue *reopen_queue,
     uint64_t perm, uint64_t shared, uint64_t *nperm, uint64_t *nshared)
 {
+    BDRVPreallocateState *s = bs->opaque;
+
     bdrv_default_perms(bs, c, role, reopen_queue, perm, shared, nperm, nshared);
 
-    if (can_write_resize(perm)) {
-        /* This should come by default, but let's enforce: */
+    /*
+     * We need exclusive write and resize permissions on the child not only when
+     * the parent can write to it, but also after the parent gave up write
+     * permissions until preallocate_drop_resize() has completed.
+     */
+    if (can_write_resize(perm) || s->data_end != -EINVAL) {
         *nperm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
 
         /*
@@ -550,7 +600,6 @@ static BlockDriver bdrv_preallocate_filter = {
     .bdrv_co_flush = preallocate_co_flush,
     .bdrv_co_truncate = preallocate_co_truncate,
 
-    .bdrv_check_perm = preallocate_check_perm,
     .bdrv_set_perm = preallocate_set_perm,
     .bdrv_child_perm = preallocate_child_perm,
 
-- 
2.41.0


