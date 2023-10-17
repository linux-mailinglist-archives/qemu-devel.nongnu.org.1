Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4DC7CCB04
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:48:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsp4L-0005xy-Of; Tue, 17 Oct 2023 14:45:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp44-0005p5-2W; Tue, 17 Oct 2023 14:45:12 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp3u-0004sE-6t; Tue, 17 Oct 2023 14:45:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 7FA8260D9D;
 Tue, 17 Oct 2023 21:44:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jipbAUIOliE0-NAEBWjI4; Tue, 17 Oct 2023 21:44:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697568298;
 bh=FmPvGFA7lfMzol2r+q0KSE9AEVqCapXiWX4D099sUQk=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LR3nZXYF1GcsZj4muTN9uTULvkBrwFQXZEDnGFYv9fO69xybpcdiGltustR/K0ehI
 JmBt9IoU9skh8by8EB0AZFNgQne+waleQpfZNTNTBAhPRc3MGxV07dlaVguD2JJo+c
 GpnLHGxe7ZBj1NL4MbKhcHPi3UH4DV5m0TGSdkGs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v8 3/7] block: make bdrv_find_child() function public
Date: Tue, 17 Oct 2023 21:44:40 +0300
Message-Id: <20231017184444.932733-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017184444.932733-1-vsementsov@yandex-team.ru>
References: <20231017184444.932733-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

To be reused soon for blockdev-replace functionality.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block.c                      | 13 +++++++++++++
 blockdev.c                   | 14 --------------
 include/block/block_int-io.h |  2 ++
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index f9cf05ddcf..6215ee9f28 100644
--- a/block.c
+++ b/block.c
@@ -8378,6 +8378,19 @@ int bdrv_make_empty(BdrvChild *c, Error **errp)
     return 0;
 }
 
+BdrvChild *bdrv_find_child(BlockDriverState *parent_bs, const char *child_name)
+{
+    BdrvChild *child;
+
+    QLIST_FOREACH(child, &parent_bs->children, next) {
+        if (strcmp(child->name, child_name) == 0) {
+            return child;
+        }
+    }
+
+    return NULL;
+}
+
 /*
  * Return the child that @bs acts as an overlay for, and from which data may be
  * copied in COW or COR operations.  Usually this is the backing file.
diff --git a/blockdev.c b/blockdev.c
index a01c62596b..49d0aab356 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3587,20 +3587,6 @@ out:
     aio_context_release(aio_context);
 }
 
-static BdrvChild * GRAPH_RDLOCK
-bdrv_find_child(BlockDriverState *parent_bs, const char *child_name)
-{
-    BdrvChild *child;
-
-    QLIST_FOREACH(child, &parent_bs->children, next) {
-        if (strcmp(child->name, child_name) == 0) {
-            return child;
-        }
-    }
-
-    return NULL;
-}
-
 void qmp_x_blockdev_change(const char *parent, const char *child,
                            const char *node, Error **errp)
 {
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 34eac72d7a..656037a49d 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -130,6 +130,8 @@ bdrv_co_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 int co_wrapper_mixed_bdrv_rdlock
 bdrv_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
+BdrvChild * GRAPH_RDLOCK
+bdrv_find_child(BlockDriverState *parent_bs, const char *child_name);
 BdrvChild *bdrv_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
-- 
2.34.1


