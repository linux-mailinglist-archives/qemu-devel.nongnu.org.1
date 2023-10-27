Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C417D9D89
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAA-0003nK-8J; Fri, 27 Oct 2023 11:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9o-0003Vi-1R
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9h-0002a9-RY
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l1NnzZCowBmuKNuYhNQ8vcJ+qQQyuvECyRw+quTAl98=;
 b=OvXlDlzh43I79ILx0iCkbsZ8bfMLw1wKAPAE64g6PW+9ze5NiYfyO+lvECohPzEW3f28tT
 AXwpvKxZbTBB9YmBkuNe5XPdB/cKWgjXsobRDsrIFBGB00qKp5lSKQft0VE2ZQAbMmZ1Us
 1AiIyPUUWsoSaC4m/2Iq4x7puMpSqxc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-IFYSMD3qO3KOmjuVM5ktaA-1; Fri,
 27 Oct 2023 11:53:46 -0400
X-MC-Unique: IFYSMD3qO3KOmjuVM5ktaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1EFC3C23646;
 Fri, 27 Oct 2023 15:53:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F035027;
 Fri, 27 Oct 2023 15:53:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 03/24] block: Mark bdrv_filter_bs() and callers GRAPH_RDLOCK
Date: Fri, 27 Oct 2023 17:53:12 +0200
Message-ID: <20231027155333.420094-4-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
bdrv_filter_bs() need to hold a reader lock for the graph because
it calls bdrv_filter_child(), which accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-io.h       | 2 +-
 include/block/block_int-io.h   | 3 ++-
 block.c                        | 9 +++++++--
 block/stream.c                 | 2 ++
 migration/block-dirty-bitmap.c | 4 ++++
 5 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index ad270b6ad2..58c4cf50a0 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -183,7 +183,7 @@ bdrv_co_eject(BlockDriverState *bs, bool eject_flag);
 
 const char *bdrv_get_format_name(BlockDriverState *bs);
 
-bool bdrv_supports_compressed_writes(BlockDriverState *bs);
+bool GRAPH_RDLOCK bdrv_supports_compressed_writes(BlockDriverState *bs);
 const char *bdrv_get_node_name(const BlockDriverState *bs);
 
 const char * GRAPH_RDLOCK
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 34eac72d7a..26bff94e4e 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -143,7 +143,8 @@ static inline BlockDriverState *bdrv_cow_bs(BlockDriverState *bs)
     return child_bs(bdrv_cow_child(bs));
 }
 
-static inline BlockDriverState *bdrv_filter_bs(BlockDriverState *bs)
+static inline BlockDriverState * GRAPH_RDLOCK
+bdrv_filter_bs(BlockDriverState *bs)
 {
     IO_CODE();
     return child_bs(bdrv_filter_child(bs));
diff --git a/block.c b/block.c
index 1171f47570..d85738b7dc 100644
--- a/block.c
+++ b/block.c
@@ -820,12 +820,17 @@ int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 {
     BlockDriver *drv = bs->drv;
-    BlockDriverState *filtered = bdrv_filter_bs(bs);
+    BlockDriverState *filtered;
+
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (drv && drv->bdrv_probe_geometry) {
         return drv->bdrv_probe_geometry(bs, geo);
-    } else if (filtered) {
+    }
+
+    filtered = bdrv_filter_bs(bs);
+    if (filtered) {
         return bdrv_probe_geometry(filtered, geo);
     }
 
diff --git a/block/stream.c b/block/stream.c
index ddaab7dbbd..b22d9c236b 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -268,6 +268,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         assert(!bottom->drv->is_filter);
         base_overlay = above_base = bottom;
     } else {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
         base_overlay = bdrv_find_overlay(bs, base);
         if (!base_overlay) {
             error_setg(errp, "'%s' is not in the backing chain of '%s'",
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 03cb2e72ee..24347ab0f7 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -607,6 +607,10 @@ static int init_dirty_bitmap_migration(DBMSaveState *s)
     BlockBackend *blk;
     GHashTable *alias_map = NULL;
 
+    /* Runs in the migration thread, but holds the iothread lock */
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (migrate_has_block_bitmap_mapping()) {
         alias_map = construct_alias_map(migrate_block_bitmap_mapping(), true,
                                         &error_abort);
-- 
2.41.0


