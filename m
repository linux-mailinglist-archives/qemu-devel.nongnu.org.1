Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEFA7E489C
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:47:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6G-0004WU-U6; Tue, 07 Nov 2023 13:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5p-00041m-LP
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5n-0001Wv-9U
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSMlr2c0p2zRk0oSfDiiW6SzlCn95BF8E0oL/jh5VI4=;
 b=JIEg2eI5ySaz/oOVdboAdjndg6SMig6aAG1r77cjKGC6QO+Cd0BgGT1Dc3sT2L6vZ3SIGU
 UO8Ka1mpRRpHF6ErU1I54kTo+s7QjTeByDvJD82Qd6UpujNqy3QpjBeLHNZiecpEPNz2ZP
 1pVZ52W5vE+gPAVyD8ougcr6ALtFBCI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-WF6yjdX6MP2QzbH0b-lesQ-1; Tue,
 07 Nov 2023 13:46:25 -0500
X-MC-Unique: WF6yjdX6MP2QzbH0b-lesQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F161A1C068DD
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD35C1290F;
 Tue,  7 Nov 2023 18:46:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 23/25] block: Take graph lock for most of .bdrv_open
Date: Tue,  7 Nov 2023 19:46:03 +0100
Message-ID: <20231107184605.236540-24-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Most implementations of .bdrv_open first open their file child (which is
an operation that internally takes the write lock and therefore we
shouldn't hold the graph lock while calling it), and afterwards many
operations that require holding the graph lock, e.g. for accessing
bs->file.

This changes block drivers that follow this pattern to take the graph
lock after opening the child node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-24-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blkdebug.c          | 16 ++++++++++------
 block/bochs.c             |  4 ++++
 block/cloop.c             |  4 ++++
 block/copy-before-write.c |  2 ++
 block/copy-on-read.c      |  4 ++--
 block/crypto.c            |  4 ++++
 block/dmg.c               |  5 +++++
 block/filter-compress.c   |  2 ++
 block/parallels.c         |  4 ++--
 block/preallocate.c       |  4 ++++
 block/qcow.c              | 11 +++++++----
 block/raw-format.c        |  6 ++++--
 block/snapshot-access.c   |  3 +++
 block/throttle.c          |  3 +++
 block/vdi.c               |  4 ++--
 block/vpc.c               |  4 ++--
 16 files changed, 60 insertions(+), 20 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index 230efa9e8d..9da8c9eddc 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -508,6 +508,8 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
+    bdrv_graph_rdlock_main_loop();
+
     bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
         (BDRV_REQ_FUA & bs->file->bs->supported_write_flags);
     bs->supported_zero_flags = BDRV_REQ_WRITE_UNCHANGED |
@@ -520,7 +522,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->align && (s->align >= INT_MAX || !is_power_of_2(s->align))) {
         error_setg(errp, "Cannot meet constraints with align %" PRIu64,
                    s->align);
-        goto out;
+        goto out_rdlock;
     }
     align = MAX(s->align, bs->file->bs->bl.request_alignment);
 
@@ -530,7 +532,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
          !QEMU_IS_ALIGNED(s->max_transfer, align))) {
         error_setg(errp, "Cannot meet constraints with max-transfer %" PRIu64,
                    s->max_transfer);
-        goto out;
+        goto out_rdlock;
     }
 
     s->opt_write_zero = qemu_opt_get_size(opts, "opt-write-zero", 0);
@@ -539,7 +541,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
          !QEMU_IS_ALIGNED(s->opt_write_zero, align))) {
         error_setg(errp, "Cannot meet constraints with opt-write-zero %" PRIu64,
                    s->opt_write_zero);
-        goto out;
+        goto out_rdlock;
     }
 
     s->max_write_zero = qemu_opt_get_size(opts, "max-write-zero", 0);
@@ -549,7 +551,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
                           MAX(s->opt_write_zero, align)))) {
         error_setg(errp, "Cannot meet constraints with max-write-zero %" PRIu64,
                    s->max_write_zero);
-        goto out;
+        goto out_rdlock;
     }
 
     s->opt_discard = qemu_opt_get_size(opts, "opt-discard", 0);
@@ -558,7 +560,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
          !QEMU_IS_ALIGNED(s->opt_discard, align))) {
         error_setg(errp, "Cannot meet constraints with opt-discard %" PRIu64,
                    s->opt_discard);
-        goto out;
+        goto out_rdlock;
     }
 
     s->max_discard = qemu_opt_get_size(opts, "max-discard", 0);
@@ -568,12 +570,14 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
                           MAX(s->opt_discard, align)))) {
         error_setg(errp, "Cannot meet constraints with max-discard %" PRIu64,
                    s->max_discard);
-        goto out;
+        goto out_rdlock;
     }
 
     bdrv_debug_event(bs, BLKDBG_NONE);
 
     ret = 0;
+out_rdlock:
+    bdrv_graph_rdunlock_main_loop();
 out:
     if (ret < 0) {
         qemu_mutex_destroy(&s->lock);
diff --git a/block/bochs.c b/block/bochs.c
index 8c659fa9b9..b099fb52fe 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -105,6 +105,8 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
     struct bochs_header bochs;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     /* No write support yet */
     bdrv_graph_rdlock_main_loop();
     ret = bdrv_apply_auto_read_only(bs, NULL, errp);
@@ -118,6 +120,8 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     ret = bdrv_pread(bs->file, 0, sizeof(bochs), &bochs, 0);
     if (ret < 0) {
         return ret;
diff --git a/block/cloop.c b/block/cloop.c
index 773d7918be..443af1444e 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -67,6 +67,8 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
     uint32_t offsets_size, max_compressed_block_size = 1, i;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     bdrv_graph_rdlock_main_loop();
     ret = bdrv_apply_auto_read_only(bs, NULL, errp);
     bdrv_graph_rdunlock_main_loop();
@@ -79,6 +81,8 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /* read header */
     ret = bdrv_pread(bs->file, 128, 4, &s->block_size, 0);
     if (ret < 0) {
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 8193d3a4cd..ad3b73cc4a 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -433,6 +433,8 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     ctx = bdrv_get_aio_context(bs);
     aio_context_acquire(ctx);
 
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 6f245b629a..c36f253d16 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -51,6 +51,8 @@ cor_open(BlockDriverState *bs, QDict *options, int flags, Error **errp)
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs->supported_read_flags = BDRV_REQ_PREFETCH;
 
     bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED |
@@ -61,8 +63,6 @@ cor_open(BlockDriverState *bs, QDict *options, int flags, Error **errp)
             bs->file->bs->supported_zero_flags);
 
     if (bottom_node) {
-        GRAPH_RDLOCK_GUARD_MAINLOOP();
-
         bottom_bs = bdrv_find_node(bottom_node);
         if (!bottom_bs) {
             error_setg(errp, "Bottom node '%s' not found", bottom_node);
diff --git a/block/crypto.c b/block/crypto.c
index b3f0233d53..6ee0cac4b6 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -263,11 +263,15 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     unsigned int cflags = 0;
     QDict *cryptoopts = NULL;
 
+    GLOBAL_STATE_CODE();
+
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs->supported_write_flags = BDRV_REQ_FUA &
         bs->file->bs->supported_write_flags;
 
diff --git a/block/dmg.c b/block/dmg.c
index 38ee72bbe5..853ad36a00 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -452,6 +452,8 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     int64_t offset;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     bdrv_graph_rdlock_main_loop();
     ret = bdrv_apply_auto_read_only(bs, NULL, errp);
     bdrv_graph_rdunlock_main_loop();
@@ -463,6 +465,9 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     if (ret < 0) {
         return ret;
     }
+
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /*
      * NB: if uncompress submodules are absent,
      * ie block_module_load return value == 0, the function pointers
diff --git a/block/filter-compress.c b/block/filter-compress.c
index e3fc82f322..9b68a2be64 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -36,6 +36,8 @@ static int compress_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!bs->file->bs->drv || !block_driver_can_compress(bs->file->bs->drv)) {
         error_setg(errp,
                    "Compression is not supported for underlying format: %s",
diff --git a/block/parallels.c b/block/parallels.c
index 9b9bd1f993..a04f836cc2 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1255,6 +1255,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     file_nb_sectors = bdrv_nb_sectors(bs->file->bs);
     if (file_nb_sectors < 0) {
         return -EINVAL;
@@ -1359,11 +1361,9 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         bitmap_new(DIV_ROUND_UP(s->header_size, s->bat_dirty_block));
 
     /* Disable migration until bdrv_activate method is added */
-    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The Parallels format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    bdrv_graph_rdunlock_main_loop();
 
     ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
diff --git a/block/preallocate.c b/block/preallocate.c
index 4e0c891ab2..f302d17d3f 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -143,6 +143,8 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVPreallocateState *s = bs->opaque;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     /*
      * s->data_end and friends should be initialized on permission update.
      * For this to work, mark them invalid.
@@ -155,6 +157,8 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!preallocate_absorb_opts(&s->opts, options, bs->file->bs, errp)) {
         return -EINVAL;
     }
diff --git a/block/qcow.c b/block/qcow.c
index 1e2835f1f4..c6d0e15f1e 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -124,9 +124,11 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
-        goto fail;
+        goto fail_unlocked;
     }
 
+    bdrv_graph_rdlock_main_loop();
+
     ret = bdrv_pread(bs->file, 0, sizeof(header), &header, 0);
     if (ret < 0) {
         goto fail;
@@ -301,11 +303,9 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Disable migration when qcow images are used */
-    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The qcow format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    bdrv_graph_rdunlock_main_loop();
 
     ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
@@ -315,9 +315,12 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     qobject_unref(encryptopts);
     qapi_free_QCryptoBlockOpenOptions(crypto_opts);
     qemu_co_mutex_init(&s->lock);
+    bdrv_graph_rdunlock_main_loop();
     return 0;
 
- fail:
+fail:
+    bdrv_graph_rdunlock_main_loop();
+fail_unlocked:
     g_free(s->l1_table);
     qemu_vfree(s->l2_cache);
     g_free(s->cluster_cache);
diff --git a/block/raw-format.c b/block/raw-format.c
index 2640d54801..66741be954 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -473,6 +473,8 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
     BdrvChildRole file_role;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     ret = raw_read_options(options, &offset, &has_size, &size, errp);
     if (ret < 0) {
         return ret;
@@ -490,6 +492,8 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
 
     bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                     file_role, false, errp);
+
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
     if (!bs->file) {
         return -EINVAL;
     }
@@ -504,9 +508,7 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                                    BDRV_REQ_ZERO_WRITE;
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
-        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(bs->file->bs);
-        bdrv_graph_rdunlock_main_loop();
         fprintf(stderr,
                 "WARNING: Image format was not specified for '%s' and probing "
                 "guessed raw.\n"
diff --git a/block/snapshot-access.c b/block/snapshot-access.c
index 7c45739eb1..84d0d13f86 100644
--- a/block/snapshot-access.c
+++ b/block/snapshot-access.c
@@ -85,6 +85,9 @@ static int snapshot_access_open(BlockDriverState *bs, QDict *options, int flags,
     bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
                     BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
                     false, errp);
+
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!bs->file) {
         return -EINVAL;
     }
diff --git a/block/throttle.c b/block/throttle.c
index 1098a4ae9a..97972d1f15 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -84,6 +84,9 @@ static int throttle_open(BlockDriverState *bs, QDict *options,
     if (ret < 0) {
         return ret;
     }
+
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs->supported_write_flags = bs->file->bs->supported_write_flags |
                                 BDRV_REQ_WRITE_UNCHANGED;
     bs->supported_zero_flags = bs->file->bs->supported_zero_flags |
diff --git a/block/vdi.c b/block/vdi.c
index 84150180ec..3b57becb9f 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -383,6 +383,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     logout("\n");
 
     ret = bdrv_pread(bs->file, 0, sizeof(header), &header, 0);
@@ -492,11 +494,9 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Disable migration when vdi images are used */
-    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The vdi format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    bdrv_graph_rdunlock_main_loop();
 
     ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
diff --git a/block/vpc.c b/block/vpc.c
index 483775103c..d95a204612 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -238,6 +238,8 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     opts = qemu_opts_create(&vpc_runtime_opts, NULL, 0, &error_abort);
     if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
@@ -446,11 +448,9 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Disable migration when VHD images are used */
-    bdrv_graph_rdlock_main_loop();
     error_setg(&s->migration_blocker, "The vpc format used by node '%s' "
                "does not support live migration",
                bdrv_get_device_or_node_name(bs));
-    bdrv_graph_rdunlock_main_loop();
 
     ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
     if (ret < 0) {
-- 
2.41.0


