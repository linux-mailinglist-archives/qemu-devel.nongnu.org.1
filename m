Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 922217A022E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkEa-0003f4-53; Thu, 14 Sep 2023 07:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkEV-0003ds-Vb; Thu, 14 Sep 2023 07:10:04 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkET-0006GS-4B; Thu, 14 Sep 2023 07:10:03 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=debian.fritz.box)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.zhadchenko@virtuozzo.com>)
 id 1qgkB4-003B3F-1Y; Thu, 14 Sep 2023 13:09:54 +0200
To: qemu-block@nongnu.org,
	kwolf@redhat.com
Cc: hreitz@redhat.com,
	qemu-devel@nongnu.org,
	den@virtuozzo.com
Subject: [PATCH 1/2] block: do not try to list nearly-dropped filters
Date: Thu, 14 Sep 2023 13:09:50 +0200
Message-Id: <20230914110951.845856-2-andrey.zhadchenko@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914110951.845856-1-andrey.zhadchenko@virtuozzo.com>
References: <20230914110951.845856-1-andrey.zhadchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.zhadchenko@virtuozzo.com; helo=relay.virtuozzo.com
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
Reply-to:  Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
From:  Andrey Zhadchenko via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

When the block job ends, it removes filter from the tree. However the
last reference to filter bds is dropped when the job is destroyed.
So when we have finalized but not dismissed job, if we try to
'query-named-block-nodes', QEMU will stumble upon a half-dead filter
and crash, since the filter now has no childs, no bd->file, etc.

Example of crash:

Thread 1 "qemu-storage-da" received signal SIGSEGV, Segmentation fault.
0x000000000048795e in bdrv_refresh_filename (bs=0x7a5280) at ../block.c:7860
7860	        assert(QLIST_NEXT(child, next) == NULL);
(gdb) bt
0  0x000000000048795e in bdrv_refresh_filename (bs=0x7a5280) at ../block.c:7860
1  0x00000000004e2804 in bdrv_block_device_info (blk=0x0, bs=0x7a5280, flat=false, errp=0x7fffffffdaa0) at ../block/qapi.c:58
2  0x000000000049634e in bdrv_named_nodes_list (flat=false, errp=0x7fffffffdaa0) at ../block.c:6098
3  0x000000000047fe1b in qmp_query_named_block_nodes (has_flat=false, flat=false, errp=0x7fffffffdaa0) at ../blockdev.c:3097
4  0x00000000005a381d in qmp_marshal_query_named_block_nodes (args=0x7fffe80075d0, ret=0x7ffff6c38e38, errp=0x7ffff6c38e40)
    at qapi/qapi-commands-block-core.c:554
5  0x00000000005de657 in do_qmp_dispatch_bh (opaque=0x7ffff6c38e08) at ../qapi/qmp-dispatch.c:128
6  0x0000000000603f42 in aio_bh_call (bh=0x773c00) at ../util/async.c:142
7  0x000000000060407d in aio_bh_poll (ctx=0x75de00) at ../util/async.c:170
8  0x00000000005eb809 in aio_dispatch (ctx=0x75de00) at ../util/aio-posix.c:421
9  0x0000000000604eea in aio_ctx_dispatch (source=0x75de00, callback=0x0, user_data=0x0) at ../util/async.c:312
10 0x00007ffff7c93d6f in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
11 0x0000000000617508 in glib_pollfds_poll () at ../util/main-loop.c:297
12 0x0000000000617360 in os_host_main_loop_wait (timeout=0) at ../util/main-loop.c:320
13 0x0000000000617263 in main_loop_wait (nonblocking=0) at ../util/main-loop.c:596
14 0x000000000046bbd6 in main (argc=13, argv=0x7fffffffde28) at ../storage-daemon/qemu-storage-daemon.c:409

Allow bdrv_block_device_info() to return NULL for filters in a such
state. Modify bdrv_named_nodes_list() to skip bds for which it cannot
get an info.

Signed-off-by: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
---
 block.c      | 7 +++++--
 block/qapi.c | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index a307c151a8..e559b0aafa 100644
--- a/block.c
+++ b/block.c
@@ -6145,16 +6145,19 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
     BlockDeviceInfoList *list;
     BlockDriverState *bs;
 
+    ERRP_GUARD();
     GLOBAL_STATE_CODE();
 
     list = NULL;
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
         BlockDeviceInfo *info = bdrv_block_device_info(NULL, bs, flat, errp);
-        if (!info) {
+        if (*errp) {
             qapi_free_BlockDeviceInfoList(list);
             return NULL;
         }
-        QAPI_LIST_PREPEND(list, info);
+        if (info) {
+            QAPI_LIST_PREPEND(list, info);
+        }
     }
 
     return list;
diff --git a/block/qapi.c b/block/qapi.c
index f34f95e0ef..b7b48f7540 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -57,6 +57,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         return NULL;
     }
 
+    /* Do not try to get info from empty filters */
+    if (bs->drv->is_filter && !QLIST_FIRST(&bs->children)) {
+        return NULL;
+    }
+
     bdrv_refresh_filename(bs);
 
     info = g_malloc0(sizeof(*info));
-- 
2.40.1


