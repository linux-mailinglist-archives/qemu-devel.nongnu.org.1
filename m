Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34A72A4AD
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7iaX-000268-4f; Fri, 09 Jun 2023 16:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7iaT-00024O-CR; Fri, 09 Jun 2023 16:19:57 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7iaR-0000EO-HK; Fri, 09 Jun 2023 16:19:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA5E321A8C;
 Fri,  9 Jun 2023 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686341986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enuupaTJDX4N+4BscN7GlbxD/HxwHwJVr5Z+5Z5sObA=;
 b=kaUPKoAYt5RDGsGfdaCO2116pTjaxBy093NXvyjeqcHMBtAg+kj2bkKQMmlqgEbv2wHrY/
 w+WbyHa5YTPnolIwU6QgIqvEBA7Pqgp15IJwHW0w85jVc8WyKBzp/1Bc+r+XBgXflhXIM4
 HoLyYEZ7Rhzn+GghfQyE3nwPjAbVYzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686341986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enuupaTJDX4N+4BscN7GlbxD/HxwHwJVr5Z+5Z5sObA=;
 b=BHNsJbxSScxTewwhqltYKgYpZj4upKBgqTEYeWoJ76mMYS83dlugUXUi4gFiEe+kqBUth1
 3VV3zoWprYqGeGAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C348D139C8;
 Fri,  9 Jun 2023 20:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6N+2IV+Jg2R/SwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 09 Jun 2023 20:19:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 09/10] block: Convert qmp_query_block() to coroutine_fn
Date: Fri,  9 Jun 2023 17:19:09 -0300
Message-Id: <20230609201910.12100-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609201910.12100-1-farosas@suse.de>
References: <20230609201910.12100-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is another caller of bdrv_get_allocated_file_size() that needs to
be converted to a coroutine because that function will be made
asynchronous when called (indirectly) from the QMP dispatcher.

This QMP command is a candidate because it calls bdrv_do_query_node_info(),
which in turn calls bdrv_get_allocated_file_size().

We've determined bdrv_do_query_node_info() to be coroutine-safe (see
previous commits), so we can just put this QMP command in a coroutine.

Since qmp_query_block() now expects to run in a coroutine, its callers
need to be converted as well. Convert hmp_info_block(), which calls
only coroutine-safe code, including qmp_query_named_block_nodes()
which has been converted to coroutine in the previous patches.

Now that all callers of bdrv_[co_]block_device_info() are using the
coroutine version, a few things happen:

 - we can return to using bdrv_block_device_info() without a wrapper;

 - bdrv_get_allocated_file_size() can stop being mixed;

 - bdrv_co_get_allocated_file_size() needs to be put under the graph
   lock because it is being called wthout the wrapper;

 - bdrv_do_query_node_info() doesn't need to acquire the AioContext
   because it doesn't call aio_poll anymore;

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block.c                        |  2 +-
 block/monitor/block-hmp-cmds.c |  2 +-
 block/qapi.c                   | 18 +++++++++---------
 hmp-commands-info.hx           |  1 +
 include/block/block-hmp-cmds.h |  2 +-
 include/block/block-io.h       |  2 +-
 include/block/qapi.h           | 12 ++++--------
 qapi/block-core.json           |  2 +-
 8 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/block.c b/block.c
index abed744b60..f94cee8930 100644
--- a/block.c
+++ b/block.c
@@ -6148,7 +6148,7 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
 
     list = NULL;
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
-        BlockDeviceInfo *info = bdrv_co_block_device_info(NULL, bs, flat, errp);
+        BlockDeviceInfo *info = bdrv_block_device_info(NULL, bs, flat, errp);
         if (!info) {
             qapi_free_BlockDeviceInfoList(list);
             return NULL;
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 26116fe831..1049f9b006 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -742,7 +742,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
     }
 }
 
-void hmp_info_block(Monitor *mon, const QDict *qdict)
+void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict)
 {
     BlockInfoList *block_list, *info;
     BlockDeviceInfoList *blockdev_list, *blockdev;
diff --git a/block/qapi.c b/block/qapi.c
index 20660e15d6..3b4bc0b782 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -41,10 +41,10 @@
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 
-BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
-                                                        BlockDriverState *bs,
-                                                        bool flat,
-                                                        Error **errp)
+BlockDeviceInfo *coroutine_fn bdrv_block_device_info(BlockBackend *blk,
+                                                     BlockDriverState *bs,
+                                                     bool flat,
+                                                     Error **errp)
 {
     ImageInfo **p_image_info;
     ImageInfo *backing_info;
@@ -235,8 +235,6 @@ static void bdrv_do_query_node_info(BlockDriverState *bs,
     int ret;
     Error *err = NULL;
 
-    aio_context_acquire(bdrv_get_aio_context(bs));
-
     size = bdrv_getlength(bs);
     if (size < 0) {
         error_setg_errno(errp, -size, "Can't get image size '%s'",
@@ -249,7 +247,9 @@ static void bdrv_do_query_node_info(BlockDriverState *bs,
     info->filename        = g_strdup(bs->filename);
     info->format          = g_strdup(bdrv_get_format_name(bs));
     info->virtual_size    = size;
-    info->actual_size     = bdrv_get_allocated_file_size(bs);
+    bdrv_graph_co_rdlock();
+    info->actual_size     = bdrv_co_get_allocated_file_size(bs);
+    bdrv_graph_co_rdunlock();
     info->has_actual_size = info->actual_size >= 0;
     if (bs->encrypted) {
         info->encrypted = true;
@@ -305,7 +305,7 @@ static void bdrv_do_query_node_info(BlockDriverState *bs,
     }
 
 out:
-    aio_context_release(bdrv_get_aio_context(bs));
+    return;
 }
 
 /**
@@ -668,7 +668,7 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
     return s;
 }
 
-BlockInfoList *qmp_query_block(Error **errp)
+BlockInfoList *coroutine_fn qmp_query_block(Error **errp)
 {
     BlockInfoList *head = NULL, **p_next = &head;
     BlockBackend *blk;
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 47d63d26db..996895f417 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -65,6 +65,7 @@ ERST
         .help       = "show info of one block device or all block devices "
                       "(-n: show named nodes; -v: show details)",
         .cmd        = hmp_info_block,
+        .coroutine  = true,
     },
 
 SRST
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7ef..6d9152318f 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -48,7 +48,7 @@ void hmp_eject(Monitor *mon, const QDict *qdict);
 
 void hmp_qemu_io(Monitor *mon, const QDict *qdict);
 
-void hmp_info_block(Monitor *mon, const QDict *qdict);
+void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict);
 void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
 void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
 void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
diff --git a/include/block/block-io.h b/include/block/block-io.h
index f31e25cf56..43af816d75 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -87,7 +87,7 @@ int64_t co_wrapper_mixed_bdrv_rdlock bdrv_getlength(BlockDriverState *bs);
 int64_t coroutine_fn GRAPH_RDLOCK
 bdrv_co_get_allocated_file_size(BlockDriverState *bs);
 
-int64_t co_wrapper_mixed_bdrv_rdlock
+int64_t co_wrapper_bdrv_rdlock
 bdrv_get_allocated_file_size(BlockDriverState *bs);
 
 BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 5cb0202791..c37cba2a09 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -30,14 +30,10 @@
 #include "block/snapshot.h"
 #include "qapi/qapi-types-block-core.h"
 
-BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
-                                                        BlockDriverState *bs,
-                                                        bool flat,
-                                                        Error **errp);
-BlockDeviceInfo *co_wrapper bdrv_block_device_info(BlockBackend *blk,
-                                                   BlockDriverState *bs,
-                                                   bool flat,
-                                                   Error **errp);
+BlockDeviceInfo *coroutine_fn bdrv_block_device_info(BlockBackend *blk,
+                                                     BlockDriverState *bs,
+                                                     bool flat,
+                                                     Error **errp);
 int bdrv_query_snapshot_info_list(BlockDriverState *bs,
                                   SnapshotInfoList **p_list,
                                   Error **errp);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9d4c92f2c9..a78dc92493 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -838,7 +838,7 @@
 #    }
 ##
 { 'command': 'query-block', 'returns': ['BlockInfo'],
-  'allow-preconfig': true }
+  'allow-preconfig': true, 'coroutine': true }
 
 ##
 # @BlockDeviceTimedStats:
-- 
2.35.3


