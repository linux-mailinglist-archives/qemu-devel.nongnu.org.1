Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFA47B3620
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErr-00067g-UW; Fri, 29 Sep 2023 10:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmErX-00061q-Kt
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEr5-0004nn-Cv
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLMF14Wkb9O57T52ogJJaXw+wzbE8aNSuW9W70R1/4o=;
 b=IuvdcXQBGgNIkdQpT3+CeJ/a4dJJH3R4RlpDl2sk8cJBHsBzYqY4nQWlybdw2aMs8U4Eop
 aavwJbyu0ptdeEAeqvSJunYCeYlh25CTLSlcEt8WVI896n1Vviblz+fbFWYt5W5BMX08ei
 iAUEYuMxPnjVFUEVouzoYJaoVscEM5E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-rNErsIOkMxeX5GoleewDWQ-1; Fri, 29 Sep 2023 10:52:31 -0400
X-MC-Unique: rNErsIOkMxeX5GoleewDWQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D40E21C00D11;
 Fri, 29 Sep 2023 14:52:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A427B2026D4B;
 Fri, 29 Sep 2023 14:52:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 19/22] block: Mark bdrv_get_specific_info() and callers
 GRAPH_RDLOCK
Date: Fri, 29 Sep 2023 16:51:54 +0200
Message-ID: <20230929145157.45443-20-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
bdrv_get_specific_info() need to hold a reader lock for the graph.
This removes an assume_graph_lock() call in vmdk's implementation.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-io.h         | 5 +++--
 include/block/block_int-common.h | 4 ++--
 block/vmdk.c                     | 6 ++----
 qemu-io-cmds.c                   | 3 +++
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index 13cc756ed8..0c09693b0f 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -191,8 +191,9 @@ bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 int co_wrapper_mixed_bdrv_rdlock
 bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 
-ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
-                                          Error **errp);
+ImageInfoSpecific * GRAPH_RDLOCK
+bdrv_get_specific_info(BlockDriverState *bs, Error **errp);
+
 BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
 void bdrv_round_to_subclusters(BlockDriverState *bs,
                                int64_t offset, int64_t bytes,
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index d971d73f8f..024262b5a2 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -728,8 +728,8 @@ struct BlockDriver {
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_get_info)(
         BlockDriverState *bs, BlockDriverInfo *bdi);
 
-    ImageInfoSpecific *(*bdrv_get_specific_info)(BlockDriverState *bs,
-                                                 Error **errp);
+    ImageInfoSpecific * GRAPH_RDLOCK_PTR (*bdrv_get_specific_info)(
+        BlockDriverState *bs, Error **errp);
     BlockStatsSpecific *(*bdrv_get_specific_stats)(BlockDriverState *bs);
 
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_save_vmstate)(
diff --git a/block/vmdk.c b/block/vmdk.c
index e50965bc37..8a3b152798 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2990,16 +2990,14 @@ vmdk_co_check(BlockDriverState *bs, BdrvCheckResult *result, BdrvCheckMode fix)
     return ret;
 }
 
-static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs,
-                                                 Error **errp)
+static ImageInfoSpecific * GRAPH_RDLOCK
+vmdk_get_specific_info(BlockDriverState *bs, Error **errp)
 {
     int i;
     BDRVVmdkState *s = bs->opaque;
     ImageInfoSpecific *spec_info = g_new0(ImageInfoSpecific, 1);
     VmdkExtentInfoList **tail;
 
-    assume_graph_lock(); /* FIXME */
-
     *spec_info = (ImageInfoSpecific){
         .type = IMAGE_INFO_SPECIFIC_KIND_VMDK,
         .u = {
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 3f75d2f5a6..f5d7202a13 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -2037,6 +2037,9 @@ static int info_f(BlockBackend *blk, int argc, char **argv)
     char s1[64], s2[64];
     int ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (bs->drv && bs->drv->format_name) {
         printf("format name: %s\n", bs->drv->format_name);
     }
-- 
2.41.0


