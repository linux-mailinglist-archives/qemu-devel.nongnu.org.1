Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6A78763A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDfh-0006Ed-2u; Thu, 24 Aug 2023 12:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDff-0006DY-7E
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDfc-0003Rc-U9
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692896336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mrbL2L5n4dlKXoxPhQ4bdIS4/YMrsyeedolVZYfUKA=;
 b=dO6BQYjl129L4vFLL5YGqJ81RZD1Ztq5lw3iwgTgCktNq9eohFY9HhqPetrZZ+JcjCKySw
 yijjfCfggyhhd4xQa/VLGy4f8/BeXF+JOAs9nYpjaD8RPkOP51FR6r+cfQuY1B6Z2aM3tg
 ceivskMKHrczisT+DYKDagAlIuLuycU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-QIbCbPBhNry-bs2ukGotlQ-1; Thu, 24 Aug 2023 12:58:53 -0400
X-MC-Unique: QIbCbPBhNry-bs2ukGotlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52AEE3C14AA1;
 Thu, 24 Aug 2023 16:58:51 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C45BEC1602B;
 Thu, 24 Aug 2023 16:58:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 5/8] block-migration: Ensure we don't crash during migration
 cleanup
Date: Thu, 24 Aug 2023 12:58:30 -0400
Message-ID: <20230824165833.1689137-6-stefanha@redhat.com>
In-Reply-To: <20230824165833.1689137-1-stefanha@redhat.com>
References: <20230824165833.1689137-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

We can fail the blk_insert_bs() at init_blk_migration(), leaving the
BlkMigDevState without a dirty_bitmap and BlockDriverState. Account
for the possibly missing elements when doing cleanup.

Fix the following crashes:

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
359         BlockDriverState *bs = bitmap->bs;
 #0  0x0000555555ec83ef in bdrv_release_dirty_bitmap (bitmap=0x0) at ../block/dirty-bitmap.c:359
 #1  0x0000555555bba331 in unset_dirty_tracking () at ../migration/block.c:371
 #2  0x0000555555bbad98 in block_migration_cleanup_bmds () at ../migration/block.c:681

Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
7073        QLIST_FOREACH_SAFE(blocker, &bs->op_blockers[op], list, next) {
 #0  0x0000555555e971ff in bdrv_op_unblock (bs=0x0, op=BLOCK_OP_TYPE_BACKUP_SOURCE, reason=0x0) at ../block.c:7073
 #1  0x0000555555e9734a in bdrv_op_unblock_all (bs=0x0, reason=0x0) at ../block.c:7095
 #2  0x0000555555bbae13 in block_migration_cleanup_bmds () at ../migration/block.c:690

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-id: 20230731203338.27581-1-farosas@suse.de
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/block.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/migration/block.c b/migration/block.c
index b9580a6c7e..86c2256a2b 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -368,7 +368,9 @@ static void unset_dirty_tracking(void)
     BlkMigDevState *bmds;
 
     QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
+        if (bmds->dirty_bitmap) {
+            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
+        }
     }
 }
 
@@ -676,13 +678,18 @@ static int64_t get_remaining_dirty(void)
 static void block_migration_cleanup_bmds(void)
 {
     BlkMigDevState *bmds;
+    BlockDriverState *bs;
     AioContext *ctx;
 
     unset_dirty_tracking();
 
     while ((bmds = QSIMPLEQ_FIRST(&block_mig_state.bmds_list)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&block_mig_state.bmds_list, entry);
-        bdrv_op_unblock_all(blk_bs(bmds->blk), bmds->blocker);
+
+        bs = blk_bs(bmds->blk);
+        if (bs) {
+            bdrv_op_unblock_all(bs, bmds->blocker);
+        }
         error_free(bmds->blocker);
 
         /* Save ctx, because bmds->blk can disappear during blk_unref.  */
-- 
2.41.0


