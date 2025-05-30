Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBD9AC9274
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 17:20:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1Pf-0004iO-UM; Fri, 30 May 2025 11:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1Pb-0004Wx-GT; Fri, 30 May 2025 11:12:47 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PY-0002N1-Vw; Fri, 30 May 2025 11:12:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 228B04481B;
 Fri, 30 May 2025 17:11:49 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 41/48] block: mark bdrv_new() as GRAPH_UNLOCKED
Date: Fri, 30 May 2025 17:11:18 +0200
Message-Id: <20250530151125.955508-42-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The function bdrv_new() calls bdrv_drained_begin(), which must be
called with the graph unlocked.

Marking bdrv_new() as GRAPH_UNLOCKED requires making the locked
section in bdrv_open_inherit() shorter.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

I'm not sure if the TODO comment is only intended for the
lower half of the function, i.e. is moving it like this okay?

 block.c                            | 7 ++++---
 include/block/block-global-state.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 6f470aac2f..1b9c99dda9 100644
--- a/block.c
+++ b/block.c
@@ -3995,10 +3995,8 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
     GLOBAL_STATE_CODE();
     assert(!qemu_in_coroutine());
 
-    /* TODO We'll eventually have to take a writer lock in this function */
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
-
     if (reference) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
         bool options_non_empty = options ? qdict_size(options) : false;
         qobject_unref(options);
 
@@ -4019,6 +4017,9 @@ bdrv_open_inherit(const char *filename, const char *reference, QDict *options,
 
     bs = bdrv_new();
 
+    /* TODO We'll eventually have to take a writer lock in this function */
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /* NULL means an empty set of options */
     if (options == NULL) {
         options = qdict_new();
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index eec92a98da..b1f826dca6 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -67,7 +67,7 @@ int co_wrapper bdrv_create(BlockDriver *drv, const char *filename,
 int coroutine_fn GRAPH_UNLOCKED
 bdrv_co_create_file(const char *filename, QemuOpts *opts, Error **errp);
 
-BlockDriverState *bdrv_new(void);
+BlockDriverState * GRAPH_UNLOCKED bdrv_new(void);
 int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
                 Error **errp);
 
-- 
2.39.5



