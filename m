Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142E27BD78E
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmqc-0008VT-PH; Mon, 09 Oct 2023 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqQ-0008QS-S5; Mon, 09 Oct 2023 05:46:36 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qpmqM-0005Yf-J5; Mon, 09 Oct 2023 05:46:33 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id C9D1B44928;
 Mon,  9 Oct 2023 11:46:23 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: [PATCH v2 03/10] block/mirror: move dirty bitmap to filter
Date: Mon,  9 Oct 2023 11:46:12 +0200
Message-Id: <20231009094619.469668-4-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009094619.469668-1-f.ebner@proxmox.com>
References: <20231009094619.469668-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
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

In preparation to allow switching to active mode without draining.
Initialization of the bitmap in mirror_dirty_init() still happens with
the original/backing BlockDriverState, which should be fine, because
the mirror top has the same length.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v2.

 block/mirror.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index b764ad5108..0ed54754e2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1500,6 +1500,10 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
         abort();
     }
 
+    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
+        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
+    }
+
     if (ret < 0) {
         goto out;
     }
@@ -1823,13 +1827,17 @@ static BlockJob *mirror_start_job(
         s->should_complete = true;
     }
 
-    s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
+    s->dirty_bitmap = bdrv_create_dirty_bitmap(s->mirror_top_bs, granularity,
+                                               NULL, errp);
     if (!s->dirty_bitmap) {
         goto fail;
     }
-    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
-        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
-    }
+
+    /*
+     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
+     * mode.
+     */
+    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
-- 
2.39.2



