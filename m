Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D374F73A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJH7m-0005wH-3f; Tue, 11 Jul 2023 13:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7j-0005um-89; Tue, 11 Jul 2023 13:26:03 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qJH7h-0006yV-Aj; Tue, 11 Jul 2023 13:26:03 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qJH6B-008F35-33;
 Tue, 11 Jul 2023 19:25:44 +0200
To: qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@openvz.org
Subject: [PATCH v2 1/3] block: add subcluster_size field to BlockDriverInfo
Date: Tue, 11 Jul 2023 20:25:51 +0300
Message-Id: <20230711172553.234055-2-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
References: <20230711172553.234055-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is going to be used in the subsequent commit as requests alignment
(in particular, during copy-on-read).  This value only makes sense for
the formats which support subclusters (currently QCOW2 only).  If this
field isn't set by driver's own bdrv_get_info() implementation, we
simply set it equal to the cluster size thus treating each cluster as
having a single subcluster.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block.c                      | 7 +++++++
 block/qcow2.c                | 1 +
 include/block/block-common.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/block.c b/block.c
index a307c151a8..0af890f647 100644
--- a/block.c
+++ b/block.c
@@ -6480,6 +6480,13 @@ int coroutine_fn bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     }
     memset(bdi, 0, sizeof(*bdi));
     ret = drv->bdrv_co_get_info(bs, bdi);
+    if (bdi->subcluster_size == 0) {
+        /*
+         * If the driver left this unset, subclusters are not supported.
+         * Then it is safe to treat each cluster as having only one subcluster.
+         */
+        bdi->subcluster_size = bdi->cluster_size;
+    }
     if (ret < 0) {
         return ret;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index c51388e99d..b48cd9ce63 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5197,6 +5197,7 @@ qcow2_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
     bdi->cluster_size = s->cluster_size;
+    bdi->subcluster_size = s->subcluster_size;
     bdi->vm_state_offset = qcow2_vm_state_offset(s);
     bdi->is_dirty = s->incompatible_features & QCOW2_INCOMPAT_DIRTY;
     return 0;
diff --git a/include/block/block-common.h b/include/block/block-common.h
index e15395f2cb..df5ffc8d09 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -132,6 +132,11 @@ typedef struct BlockZoneWps {
 typedef struct BlockDriverInfo {
     /* in bytes, 0 if irrelevant */
     int cluster_size;
+    /*
+     * A fraction of cluster_size, if supported (currently QCOW2 only); if
+     * disabled or unsupported, set equal to cluster_size.
+     */
+    int subcluster_size;
     /* offset at which the VM state can be saved (0 if not possible) */
     int64_t vm_state_offset;
     bool is_dirty;
-- 
2.39.3


