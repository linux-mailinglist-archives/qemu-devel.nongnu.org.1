Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1709D77F6DA
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcU3-0001Fn-Lx; Thu, 17 Aug 2023 08:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcT3-0007w6-3p
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcSx-0002cp-0F
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692276663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K8O3UC6gA9VhT7SmDtYjxtjNmQF9m7RF1rZHfIZbOf8=;
 b=WxfnwLPPI9jc2nd0K9YJo/6pUhZedhSKJLaY2iVs87u5dshRY22FkfTwBxoL6geF6TxuZb
 Q49y5cEWGwq6301z3u2GO5trkzKrMQfn51jO7l0rPSP9T/+G/j1WmnHF7vYxLtoa9wMRMo
 G0SNouzsxmgqqTbqr1OkvMi4mccEBPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-y93qUihAM465huNw39bung-1; Thu, 17 Aug 2023 08:50:59 -0400
X-MC-Unique: y93qUihAM465huNw39bung-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E9D285C711;
 Thu, 17 Aug 2023 12:50:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1179F1121314;
 Thu, 17 Aug 2023 12:50:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 05/21] block: Introduce bdrv_schedule_unref()
Date: Thu, 17 Aug 2023 14:50:04 +0200
Message-ID: <20230817125020.208339-6-kwolf@redhat.com>
In-Reply-To: <20230817125020.208339-1-kwolf@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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
 block.c                            |  9 +++++++++
 block/graph-lock.c                 | 23 ++++++++++++++++-------
 tests/qemu-iotests/051.pc.out      |  6 +++---
 4 files changed, 29 insertions(+), 10 deletions(-)

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
index 6376452768..9c4f24f4b9 100644
--- a/block.c
+++ b/block.c
@@ -7033,6 +7033,15 @@ void bdrv_unref(BlockDriverState *bs)
     }
 }
 
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
index 5e66f01ae8..395d387651 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -163,17 +163,26 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
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
+        /* Wake up all coroutine that are waiting to read the graph */
+        qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
+    }
+
     /*
-     * No need for memory barriers, this works in pair with
-     * the slow path of rdlock() and both take the lock.
+     * Run any BHs that were scheduled during the wrlock section and that
+     * callers might expect to have finished (e.g. bdrv_unref() calls). Do this
+     * only after restarting coroutines so that nested event loops in BHs don't
+     * deadlock if their condition relies on the coroutine making progress.
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


