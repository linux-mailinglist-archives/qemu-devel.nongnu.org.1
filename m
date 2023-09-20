Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B98577A7731
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 11:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qitOZ-0007D8-8r; Wed, 20 Sep 2023 05:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitOV-0007AO-Un; Wed, 20 Sep 2023 05:21:15 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qitOS-0001fq-KP; Wed, 20 Sep 2023 05:21:15 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qitKw-0028Y8-2L;
 Wed, 20 Sep 2023 11:20:59 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Subject: [PULL 04/22] parallels: invent parallels_opts_prealloc() helper to
 parse prealloc opts
Date: Wed, 20 Sep 2023 11:20:50 +0200
Message-Id: <20230920092108.258898-5-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092108.258898-1-den@openvz.org>
References: <20230920092108.258898-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
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

This patch creates above mentioned helper and moves its usage to the
beginning of parallels_open(). This simplifies parallels_open() a bit.

The patch also ensures that we store prealloc_size on block driver state
always in sectors. This makes code cleaner and avoids wrong opinion at
the assignment that the value is in bytes.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 72 +++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index af7be427c9..ae006e7fc7 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1025,6 +1025,44 @@ static int parallels_update_header(BlockDriverState *bs)
     return bdrv_pwrite_sync(bs->file, 0, size, s->header, 0);
 }
 
+
+static int parallels_opts_prealloc(BlockDriverState *bs, QDict *options,
+                                   Error **errp)
+{
+    int err;
+    char *buf;
+    int64_t bytes;
+    BDRVParallelsState *s = bs->opaque;
+    Error *local_err = NULL;
+    QemuOpts *opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
+    if (!opts) {
+        return -ENOMEM;
+    }
+
+    err = -EINVAL;
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
+        goto done;
+    }
+
+    bytes = qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
+    s->prealloc_size = bytes >> BDRV_SECTOR_BITS;
+    buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
+    /* prealloc_mode can be downgraded later during allocate_clusters */
+    s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
+                                       PRL_PREALLOC_MODE_FALLOCATE,
+                                       &local_err);
+    g_free(buf);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        goto done;
+    }
+    err = 0;
+
+done:
+    qemu_opts_del(opts);
+    return err;
+}
+
 static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
                           Error **errp)
 {
@@ -1033,11 +1071,13 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     int ret, size, i;
     int64_t file_nb_sectors, sector;
     uint32_t data_start;
-    QemuOpts *opts = NULL;
-    Error *local_err = NULL;
-    char *buf;
     bool data_off_is_correct;
 
+    ret = parallels_opts_prealloc(bs, options, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
         return ret;
@@ -1078,6 +1118,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -EFBIG;
         goto fail;
     }
+    s->prealloc_size = MAX(s->tracks, s->prealloc_size);
     s->cluster_size = s->tracks << BDRV_SECTOR_BITS;
 
     s->bat_size = le32_to_cpu(ph.bat_entries);
@@ -1117,29 +1158,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         s->header_size = size;
     }
 
-    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
-    if (!opts) {
-        goto fail_options;
-    }
-
-    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
-        goto fail_options;
-    }
-
-    s->prealloc_size =
-        qemu_opt_get_size_del(opts, PARALLELS_OPT_PREALLOC_SIZE, 0);
-    s->prealloc_size = MAX(s->tracks, s->prealloc_size >> BDRV_SECTOR_BITS);
-    buf = qemu_opt_get_del(opts, PARALLELS_OPT_PREALLOC_MODE);
-    /* prealloc_mode can be downgraded later during allocate_clusters */
-    s->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
-                                       PRL_PREALLOC_MODE_FALLOCATE,
-                                       &local_err);
-    g_free(buf);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        goto fail_options;
-    }
-
     if (ph.ext_off) {
         if (flags & BDRV_O_RDWR) {
             /*
@@ -1214,10 +1232,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
 fail_format:
     error_setg(errp, "Image not in Parallels format");
-fail_options:
     ret = -EINVAL;
 fail:
-    qemu_opts_del(opts);
     /*
      * "s" object was allocated by g_malloc0 so we can safely
      * try to free its fields even they were not allocated.
-- 
2.34.1


