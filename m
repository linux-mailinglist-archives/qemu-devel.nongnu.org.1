Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B34707527
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 00:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzPMC-0003ep-TZ; Wed, 17 May 2023 18:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzPMA-0003du-IY
 for qemu-devel@nongnu.org; Wed, 17 May 2023 18:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzPM8-0002Ud-3b
 for qemu-devel@nongnu.org; Wed, 17 May 2023 18:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684361447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oAMrkGRvsGP9WognGT4SAJgv9CJG1xPxVEQ07vb4i/g=;
 b=amJNMPzWL/RO4jJFq+LhTlN4+Wi1zf5Mp3q3lTdv24Qt80yy9RV9x2GIFhp0uIH23j4SFz
 QWiOyyp+V5sjDi0ulKMK53n8GaDhvp6nzojBYTHdebZZu/258vteTzinRuzDv8oKVzTPPN
 AJQ+KW/Fu2WgPy++Q5s3cqepqUhjyfs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-ZuGjwf9_O02pHtA8FBXCrg-1; Wed, 17 May 2023 18:10:42 -0400
X-MC-Unique: ZuGjwf9_O02pHtA8FBXCrg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6832838184E6;
 Wed, 17 May 2023 22:10:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C65272026D16;
 Wed, 17 May 2023 22:10:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Julia Suvorova <jusual@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 6/6] block: remove bdrv_co_io_plug() API
Date: Wed, 17 May 2023 18:10:22 -0400
Message-Id: <20230517221022.325091-7-stefanha@redhat.com>
In-Reply-To: <20230517221022.325091-1-stefanha@redhat.com>
References: <20230517221022.325091-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

No block driver implements .bdrv_co_io_plug() anymore. Get rid of the
function pointers.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block-io.h         |  3 ---
 include/block/block_int-common.h | 11 ----------
 block/io.c                       | 37 --------------------------------
 3 files changed, 51 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index a27e471a87..43af816d75 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -259,9 +259,6 @@ void coroutine_fn bdrv_co_leave(BlockDriverState *bs, AioContext *old_ctx);
 
 AioContext *child_of_bds_get_parent_aio_context(BdrvChild *c);
 
-void coroutine_fn GRAPH_RDLOCK bdrv_co_io_plug(BlockDriverState *bs);
-void coroutine_fn GRAPH_RDLOCK bdrv_co_io_unplug(BlockDriverState *bs);
-
 bool coroutine_fn GRAPH_RDLOCK
 bdrv_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
                                    uint32_t granularity, Error **errp);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index dbec0e3bb4..fa369d83dd 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -753,11 +753,6 @@ struct BlockDriver {
     void coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_debug_event)(
         BlockDriverState *bs, BlkdebugEvent event);
 
-    /* io queue for linux-aio */
-    void coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_io_plug)(BlockDriverState *bs);
-    void coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_io_unplug)(
-        BlockDriverState *bs);
-
     /**
      * bdrv_drain_begin is called if implemented in the beginning of a
      * drain operation to drain and stop any internal sources of requests in
@@ -1227,12 +1222,6 @@ struct BlockDriverState {
     unsigned int in_flight;
     unsigned int serialising_in_flight;
 
-    /*
-     * counter for nested bdrv_io_plug.
-     * Accessed with atomic ops.
-     */
-    unsigned io_plugged;
-
     /* do we need to tell the quest if we have a volatile write cache? */
     int enable_write_cache;
 
diff --git a/block/io.c b/block/io.c
index 4d54fda593..56b0c1ce6c 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3219,43 +3219,6 @@ void *qemu_try_blockalign0(BlockDriverState *bs, size_t size)
     return mem;
 }
 
-void coroutine_fn bdrv_co_io_plug(BlockDriverState *bs)
-{
-    BdrvChild *child;
-    IO_CODE();
-    assert_bdrv_graph_readable();
-
-    QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_co_io_plug(child->bs);
-    }
-
-    if (qatomic_fetch_inc(&bs->io_plugged) == 0) {
-        BlockDriver *drv = bs->drv;
-        if (drv && drv->bdrv_co_io_plug) {
-            drv->bdrv_co_io_plug(bs);
-        }
-    }
-}
-
-void coroutine_fn bdrv_co_io_unplug(BlockDriverState *bs)
-{
-    BdrvChild *child;
-    IO_CODE();
-    assert_bdrv_graph_readable();
-
-    assert(bs->io_plugged);
-    if (qatomic_fetch_dec(&bs->io_plugged) == 1) {
-        BlockDriver *drv = bs->drv;
-        if (drv && drv->bdrv_co_io_unplug) {
-            drv->bdrv_co_io_unplug(bs);
-        }
-    }
-
-    QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_co_io_unplug(child->bs);
-    }
-}
-
 /* Helper that undoes bdrv_register_buf() when it fails partway through */
 static void GRAPH_RDLOCK
 bdrv_register_buf_rollback(BlockDriverState *bs, void *host, size_t size,
-- 
2.40.1


