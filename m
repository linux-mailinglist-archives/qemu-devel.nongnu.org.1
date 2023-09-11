Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C529979A6F4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:49:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVK-0005qZ-Tp; Mon, 11 Sep 2023 05:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVJ-0005qC-B2
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVD-0004fQ-HG
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WP2SX9xLm76PLqfii9UAowCAa0p/FrcNxpO7Vz5+4GA=;
 b=hT8jmgwPnseqkmdvK+b5bLDndHFsa7hcZrFNDoogaMQOUhXJ42AGA4EdUPN65hosI8+k3r
 8xPXoeK245uILX5McHYTW6DyK+Afom52LjKezCaxBXiUnZGnLexWveSGgmGCiD4/TJu4RY
 bwha4HZmA9ZxyPxsEUnMkv9TsdhdDNE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-WUmJTOYnOySZXUrep3v5KA-1; Mon, 11 Sep 2023 05:46:39 -0400
X-MC-Unique: WUmJTOYnOySZXUrep3v5KA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339AD3C19369;
 Mon, 11 Sep 2023 09:46:39 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0578F40C6EBF;
 Mon, 11 Sep 2023 09:46:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 05/21] block: Introduce bdrv_schedule_unref()
Date: Mon, 11 Sep 2023 11:46:04 +0200
Message-ID: <20230911094620.45040-6-kwolf@redhat.com>
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
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

bdrv_unref() is called by a lot of places that need to hold the graph
lock (it naturally happens in the context of operations that change the
graph). However, bdrv_unref() takes the graph writer lock internally, so
it can't actually be called while already holding a graph lock without
causing a deadlock.

bdrv_unref() also can't just become GRAPH_WRLOCK because it drains the
node before closing it, and draining requires that the graph is
unlocked.

The solution is to defer deleting the node until we don't hold the lock
any more and draining is possible again.

Note that keeping images open for longer than necessary can create
problems, too: You can't open an image again before it is really closed
(if image locking didn't prevent it, it would cause corruption).
Reopening an image immediately happens at least during bdrv_open() and
bdrv_co_create().

In order to solve this problem, make sure to run the deferred unref in
bdrv_graph_wrunlock(), i.e. the first possible place where we can drain
again. This is also why bdrv_schedule_unref() is marked GRAPH_WRLOCK.

The output of iotest 051 is updated because the additional polling
changes the order of HMP output, resulting in a new "(qemu)" prompt in
the test output that was previously on a separate line and filtered out.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  1 +
 block.c                            | 17 +++++++++++++++++
 block/graph-lock.c                 | 26 +++++++++++++++++++-------
 tests/qemu-iotests/051.pc.out      |  6 +++---
 4 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index f347199bff..e570799f85 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -224,6 +224,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
 void bdrv_ref(BlockDriverState *bs);
 void no_coroutine_fn bdrv_unref(BlockDriverState *bs);
 void coroutine_fn no_co_wrapper bdrv_co_unref(BlockDriverState *bs);
+void GRAPH_WRLOCK bdrv_schedule_unref(BlockDriverState *bs);
 void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
diff --git a/block.c b/block.c
index 9029ddd9ff..c8ac7cfac4 100644
--- a/block.c
+++ b/block.c
@@ -7044,6 +7044,23 @@ void bdrv_unref(BlockDriverState *bs)
     }
 }
 
+/*
+ * Release a BlockDriverState reference while holding the graph write lock.
+ *
+ * Calling bdrv_unref() directly is forbidden while holding the graph lock
+ * because bdrv_close() both involves polling and taking the graph lock
+ * internally. bdrv_schedule_unref() instead delays decreasing the refcount and
+ * possibly closing @bs until the graph lock is released.
+ */
+void bdrv_schedule_unref(BlockDriverState *bs)
+{
+    if (!bs) {
+        return;
+    }
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            (QEMUBHFunc *) bdrv_unref, bs);
+}
+
 struct BdrvOpBlocker {
     Error *reason;
     QLIST_ENTRY(BdrvOpBlocker) list;
diff --git a/block/graph-lock.c b/block/graph-lock.c
index f357a2c0b1..58a799065f 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -163,17 +163,29 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
 void bdrv_graph_wrunlock(void)
 {
     GLOBAL_STATE_CODE();
-    QEMU_LOCK_GUARD(&aio_context_list_lock);
     assert(qatomic_read(&has_writer));
 
+    WITH_QEMU_LOCK_GUARD(&aio_context_list_lock) {
+        /*
+         * No need for memory barriers, this works in pair with
+         * the slow path of rdlock() and both take the lock.
+         */
+        qatomic_store_release(&has_writer, 0);
+
+        /* Wake up all coroutines that are waiting to read the graph */
+        qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
+    }
+
     /*
-     * No need for memory barriers, this works in pair with
-     * the slow path of rdlock() and both take the lock.
+     * Run any BHs that were scheduled during the wrlock section and that
+     * callers might expect to have finished (in particular, this is important
+     * for bdrv_schedule_unref()).
+     *
+     * Do this only after restarting coroutines so that nested event loops in
+     * BHs don't deadlock if their condition relies on the coroutine making
+     * progress.
      */
-    qatomic_store_release(&has_writer, 0);
-
-    /* Wake up all coroutine that are waiting to read the graph */
-    qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
+    aio_bh_poll(qemu_get_aio_context());
 }
 
 void coroutine_fn bdrv_graph_co_rdlock(void)
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index 4d4af5a486..7e10c5fa1b 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -169,11 +169,11 @@ QEMU_PROG: -device scsi-hd,drive=disk: Device needs media, but drive is empty
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device ide-hd,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-QEMU_PROG: -device ide-hd,drive=disk,share-rw=on: Cannot change iothread of active block backend
+(qemu) QEMU_PROG: -device ide-hd,drive=disk,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-blk-pci,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-QEMU_PROG: -device virtio-blk-pci,drive=disk,share-rw=on: Cannot change iothread of active block backend
+(qemu) QEMU_PROG: -device virtio-blk-pci,drive=disk,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device lsi53c895a,id=lsi0 -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
@@ -185,7 +185,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-QEMU_PROG: -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on: Cannot change iothread of active block backend
+(qemu) QEMU_PROG: -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-scsi,id=virtio-scsi1,iothread=thread0 -device scsi-hd,bus=virtio-scsi1.0,drive=disk,share-rw=on
 QEMU X.Y.Z monitor - type 'help' for more information
-- 
2.41.0


