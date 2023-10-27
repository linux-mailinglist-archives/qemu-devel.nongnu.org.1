Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4BD7D9D84
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:54:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwP9q-0003UE-Hn; Fri, 27 Oct 2023 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9h-0003RT-G1
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9e-0002Wj-Av
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmykzKGDTM60uTLw15UVHmArE36P5/BF9ibO3Bz0LpI=;
 b=Yn8lNqkHFVnR3W7D6ecRQPCmB+0riRtTCTjJoKoILqeAznolDy+DDNCcRWhGbrmVgGa9uO
 WiyFTh2gGzD05/IlCV06Yrubmpst7XFiPs3Z15kxMC8a4NK5poWjPchAcfwYz1zuC4wEYr
 63C8ZkIcULvGihp9ZqX5cjMgR+cAbt8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-erNe8_dEMQW2RWfzx7tcdA-1; Fri, 27 Oct 2023 11:53:43 -0400
X-MC-Unique: erNe8_dEMQW2RWfzx7tcdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC50B185A785;
 Fri, 27 Oct 2023 15:53:42 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFEB65027;
 Fri, 27 Oct 2023 15:53:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 01/24] block: Mark bdrv_probe_blocksizes() and callers
 GRAPH_RDLOCK
Date: Fri, 27 Oct 2023 17:53:10 +0200
Message-ID: <20231027155333.420094-2-kwolf@redhat.com>
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_probe_blocksizes() need to hold a reader lock for the graph because
it calls bdrv_filter_bs(), which accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 2 +-
 include/block/block_int-common.h   | 3 ++-
 block/block-backend.c              | 2 ++
 block/raw-format.c                 | 3 ++-
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 6bfafe781d..fca0a40dbd 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -281,7 +281,7 @@ bool bdrv_child_change_aio_context(BdrvChild *c, AioContext *ctx,
 int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
                                 BdrvChild *ignore_child, Error **errp);
 
-int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz);
+int GRAPH_RDLOCK bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz);
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
 
 void GRAPH_WRLOCK
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index b8d9d24f39..8abdd2724b 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -386,7 +386,8 @@ struct BlockDriver {
      * On success, store them in @bsz and return zero.
      * On failure, return negative errno.
      */
-    int (*bdrv_probe_blocksizes)(BlockDriverState *bs, BlockSizes *bsz);
+    int GRAPH_RDLOCK_PTR (*bdrv_probe_blocksizes)(
+        BlockDriverState *bs, BlockSizes *bsz);
     /**
      * Try to get @bs's geometry (cyls, heads, sectors)
      * On success, store them in @geo and return 0.
diff --git a/block/block-backend.c b/block/block-backend.c
index 39aac1bbce..53cf3bb8b8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2666,6 +2666,8 @@ int blk_load_vmstate(BlockBackend *blk, uint8_t *buf, int64_t pos, int size)
 int blk_probe_blocksizes(BlockBackend *blk, BlockSizes *bsz)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!blk_is_available(blk)) {
         return -ENOMEDIUM;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index 8ff03adfa4..3fb77b0097 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -543,7 +543,8 @@ static int raw_probe(const uint8_t *buf, int buf_size, const char *filename)
     return 1;
 }
 
-static int raw_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
+static int GRAPH_RDLOCK
+raw_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
 {
     BDRVRawState *s = bs->opaque;
     int ret;
-- 
2.41.0


