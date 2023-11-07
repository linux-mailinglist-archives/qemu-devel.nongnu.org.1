Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 368897E48AF
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R68-00041K-1I; Tue, 07 Nov 2023 13:46:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5h-0003vQ-Mz
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5f-0001Ue-9m
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bR2VYRJOr0FUz5LyixeiagYhQMQG2K629OQ/c03qinA=;
 b=eX1HMo3UDhpukVkYnDeR9SnyvEDy2pK+5ufo7jeUX6cIYohd/KvcuDjDQA5yz3S7gpXDom
 ixE06R2AHUVM7LEdr9sDnOim90trWK9p32ItCBR5FtvwTkW6iCpIo8MwpQAesvMJkv7Y/m
 mKrUzqDDJdiBlOFgo/D9tSEPF1IoflM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-Bhf95x6DOk66MQiKLlKq1w-1; Tue,
 07 Nov 2023 13:46:16 -0500
X-MC-Unique: Bhf95x6DOk66MQiKLlKq1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3704D1C068D4
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF3C2C1290F;
 Tue,  7 Nov 2023 18:46:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 11/25] block: Mark bdrv_filter_child() and callers GRAPH_RDLOCK
Date: Tue,  7 Nov 2023 19:45:51 +0100
Message-ID: <20231107184605.236540-12-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bdrv_filter_child() need to hold a reader lock for the graph because it
accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-12-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h | 4 ++--
 block.c                      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 4e7bf57a5e..17547a2dab 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -131,8 +131,8 @@ int co_wrapper_mixed_bdrv_rdlock
 bdrv_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
 BdrvChild *bdrv_cow_child(BlockDriverState *bs);
-BdrvChild *bdrv_filter_child(BlockDriverState *bs);
-BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
+BdrvChild * GRAPH_RDLOCK bdrv_filter_child(BlockDriverState *bs);
+BdrvChild * GRAPH_RDLOCK bdrv_filter_or_cow_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_primary_child(BlockDriverState *bs);
 BlockDriverState * GRAPH_RDLOCK bdrv_skip_filters(BlockDriverState *bs);
 BlockDriverState * GRAPH_RDLOCK bdrv_backing_chain_next(BlockDriverState *bs);
diff --git a/block.c b/block.c
index bb322df7d8..499b147315 100644
--- a/block.c
+++ b/block.c
@@ -8491,8 +8491,8 @@ BdrvChild *bdrv_primary_child(BlockDriverState *bs)
     return found;
 }
 
-static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
-                                              bool stop_on_explicit_filter)
+static BlockDriverState * GRAPH_RDLOCK
+bdrv_do_skip_filters(BlockDriverState *bs, bool stop_on_explicit_filter)
 {
     BdrvChild *c;
 
-- 
2.41.0


