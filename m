Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638AD7C7296
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyT1-0003ju-5g; Thu, 12 Oct 2023 12:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySx-0003hG-7b
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySe-0000dl-Sh
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TBaDoSSKTicbLcP5sDO5M3Zpp5c+nijbacqQM5vZJPs=;
 b=hJpskDTEONmNniQ6pRsWV7iiOup/bEBDsWimz62lbiJLwbffz6HISpobAyKQtDD2ideb7m
 d+vRtHjaPOBFQr203pEF/s6tZcBOsjoe8IQdH0A2tCm3DP0PouxeBfJTaHSvBxDLp6T2+a
 NBRCPt/cI/lsP2ZnPKeAuT4uuFTpoBQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-W_ZWGIl9NNeyjq-8zzCdOw-1; Thu, 12 Oct 2023 12:22:54 -0400
X-MC-Unique: W_ZWGIl9NNeyjq-8zzCdOw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B670B8039C1;
 Thu, 12 Oct 2023 16:22:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 266C82026831;
 Thu, 12 Oct 2023 16:22:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 22/26] block: Mark bdrv_apply_auto_read_only() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:20 +0200
Message-ID: <20231012162224.240535-23-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_apply_auto_read_only() need to hold a reader lock for the graph
because it calls bdrv_can_set_read_only(), which indirectly accesses the
parents list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-19-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-io.h | 6 ++++--
 block.c                  | 4 ++--
 block/bochs.c            | 2 ++
 block/cloop.c            | 2 ++
 block/curl.c             | 2 ++
 block/dmg.c              | 2 ++
 block/gluster.c          | 2 ++
 block/iscsi.c            | 2 ++
 block/nbd.c              | 3 ++-
 block/rbd.c              | 2 ++
 10 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index 2c0c7b1906..e051e9bed6 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -163,8 +163,10 @@ bdrv_is_allocated_above(BlockDriverState *bs, BlockDriverState *base,
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset, int64_t bytes);
 
-int bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
-                              Error **errp);
+int GRAPH_RDLOCK
+bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
+                          Error **errp);
+
 bool bdrv_is_read_only(BlockDriverState *bs);
 bool bdrv_is_writable(BlockDriverState *bs);
 bool bdrv_is_sg(BlockDriverState *bs);
diff --git a/block.c b/block.c
index fd348f5069..2ac7406c77 100644
--- a/block.c
+++ b/block.c
@@ -320,8 +320,6 @@ int bdrv_apply_auto_read_only(BlockDriverState *bs, const char *errmsg,
     int ret = 0;
     IO_CODE();
 
-    assume_graph_lock(); /* FIXME */
-
     if (!(bs->open_flags & BDRV_O_RDWR)) {
         return 0;
     }
@@ -1908,7 +1906,9 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
 
     if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, ro)) {
         if (!ro && bdrv_is_whitelisted(drv, true)) {
+            bdrv_graph_rdlock_main_loop();
             ret = bdrv_apply_auto_read_only(bs, NULL, NULL);
+            bdrv_graph_rdunlock_main_loop();
         } else {
             ret = -ENOTSUP;
         }
diff --git a/block/bochs.c b/block/bochs.c
index 66e7a58e5e..8c659fa9b9 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -106,7 +106,9 @@ static int bochs_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
 
     /* No write support yet */
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_apply_auto_read_only(bs, NULL, errp);
+    bdrv_graph_rdunlock_main_loop();
     if (ret < 0) {
         return ret;
     }
diff --git a/block/cloop.c b/block/cloop.c
index 835a0fe3da..773d7918be 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -67,7 +67,9 @@ static int cloop_open(BlockDriverState *bs, QDict *options, int flags,
     uint32_t offsets_size, max_compressed_block_size = 1, i;
     int ret;
 
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_apply_auto_read_only(bs, NULL, errp);
+    bdrv_graph_rdunlock_main_loop();
     if (ret < 0) {
         return ret;
     }
diff --git a/block/curl.c b/block/curl.c
index 0fc42d03d7..419f7c89ef 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -696,8 +696,10 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     const char *protocol_delimiter;
     int ret;
 
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_apply_auto_read_only(bs, "curl driver does not support writes",
                                     errp);
+    bdrv_graph_rdunlock_main_loop();
     if (ret < 0) {
         return ret;
     }
diff --git a/block/dmg.c b/block/dmg.c
index 06a0244a9c..38ee72bbe5 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -452,7 +452,9 @@ static int dmg_open(BlockDriverState *bs, QDict *options, int flags,
     int64_t offset;
     int ret;
 
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_apply_auto_read_only(bs, NULL, errp);
+    bdrv_graph_rdunlock_main_loop();
     if (ret < 0) {
         return ret;
     }
diff --git a/block/gluster.c b/block/gluster.c
index ad5fadbe79..cc74af06dc 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -863,11 +863,13 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
     if (ret == -EACCES || ret == -EROFS) {
         /* Try to degrade to read-only, but if it doesn't work, still use the
          * normal error message. */
+        bdrv_graph_rdlock_main_loop();
         if (bdrv_apply_auto_read_only(bs, NULL, NULL) == 0) {
             open_flags = (open_flags & ~O_RDWR) | O_RDONLY;
             s->fd = glfs_open(s->glfs, gconf->path, open_flags);
             ret = s->fd ? 0 : -errno;
         }
+        bdrv_graph_rdunlock_main_loop();
     }
 
     s->supports_seek_data = qemu_gluster_test_seek(s->fd);
diff --git a/block/iscsi.c b/block/iscsi.c
index 5640c8b565..2ff14b7472 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1925,7 +1925,9 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     /* Check the write protect flag of the LUN if we want to write */
     if (iscsilun->type == TYPE_DISK && (flags & BDRV_O_RDWR) &&
         iscsilun->write_protected) {
+        bdrv_graph_rdlock_main_loop();
         ret = bdrv_apply_auto_read_only(bs, "LUN is write protected", errp);
+        bdrv_graph_rdunlock_main_loop();
         if (ret < 0) {
             goto out;
         }
diff --git a/block/nbd.c b/block/nbd.c
index 52ebc8b2f5..b9d4f935e0 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -275,7 +275,8 @@ static bool nbd_client_will_reconnect(BDRVNBDState *s)
  * Return failure if the server's advertised options are incompatible with the
  * client's needs.
  */
-static int nbd_handle_updated_info(BlockDriverState *bs, Error **errp)
+static int coroutine_fn GRAPH_RDLOCK
+nbd_handle_updated_info(BlockDriverState *bs, Error **errp)
 {
     BDRVNBDState *s = (BDRVNBDState *)bs->opaque;
     int ret;
diff --git a/block/rbd.c b/block/rbd.c
index 073bc92e39..84bb2fa5d7 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1168,7 +1168,9 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     /* If we are using an rbd snapshot, we must be r/o, otherwise
      * leave as-is */
     if (s->snap != NULL) {
+        bdrv_graph_rdlock_main_loop();
         r = bdrv_apply_auto_read_only(bs, "rbd snapshots are read-only", errp);
+        bdrv_graph_rdunlock_main_loop();
         if (r < 0) {
             goto failed_post_open;
         }
-- 
2.41.0


