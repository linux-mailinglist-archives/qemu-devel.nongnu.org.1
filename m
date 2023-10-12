Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 356257C7289
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:29:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySq-0003a4-5L; Thu, 12 Oct 2023 12:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySc-0003Vw-O2
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000aJ-J1
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/f01scmN4moabGuEAtyEl5ap1UsyJsJC9wnwe6DEnHA=;
 b=argjsy0NjOeEr0zTcyn9u55gYQhUh7mo7o/d/niV7CxLT00Ey7muIX4vtbpYPytJbYbSud
 ilJkzev3Ha4vvHRkxhq8Orc2gcvzHxHNfxsQhY9r0hKqTlwcs3j2bvuOQTW59i9K77s1tr
 hrjP2VzCpwFizRD9XNbDKJ/3tUc6unI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-463-pl8nnnUJOeamLIqIg5-Orw-1; Thu, 12 Oct 2023 12:22:37 -0400
X-MC-Unique: pl8nnnUJOeamLIqIg5-Orw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44EC63C170AA;
 Thu, 12 Oct 2023 16:22:37 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A919320296DB;
 Thu, 12 Oct 2023 16:22:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/26] block: complete public block status API
Date: Thu, 12 Oct 2023 18:22:00 +0200
Message-ID: <20231012162224.240535-3-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

From: Paolo Bonzini <pbonzini@redhat.com>

Include both coroutine and non-coroutine versions, the latter being
co_wrapper_mixed_bdrv_rdlock of the former.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230904100306.156197-3-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-io.h | 17 +++++++++++------
 block/io.c               | 18 +++++-------------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index f1c796a1ce..41f78f2fc5 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -127,17 +127,22 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   BdrvRequestFlags flags);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
-int bdrv_block_status(BlockDriverState *bs, int64_t offset,
-                      int64_t bytes, int64_t *pnum, int64_t *map,
-                      BlockDriverState **file);
+
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                     int64_t *pnum, int64_t *map, BlockDriverState **file);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                  int64_t *pnum, int64_t *map, BlockDriverState **file);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                            int64_t offset, int64_t bytes, int64_t *pnum,
                            int64_t *map, BlockDriverState **file);
-int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum,
-                            int64_t *map, BlockDriverState **file);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
+                        int64_t offset, int64_t bytes, int64_t *pnum,
+                        int64_t *map, BlockDriverState **file);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
diff --git a/block/io.c b/block/io.c
index 2ff4ffda1c..4ecc21c562 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2724,21 +2724,13 @@ int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                              bytes, pnum, map, file, NULL);
 }
 
-int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum,
-                            int64_t *map, BlockDriverState **file)
+int coroutine_fn bdrv_co_block_status(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, int64_t *pnum,
+                                      int64_t *map, BlockDriverState **file)
 {
     IO_CODE();
-    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
-                                          pnum, map, file, NULL);
-}
-
-int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      int64_t *pnum, int64_t *map, BlockDriverState **file)
-{
-    IO_CODE();
-    return bdrv_block_status_above(bs, bdrv_filter_or_cow_bs(bs),
-                                   offset, bytes, pnum, map, file);
+    return bdrv_co_block_status_above(bs, bdrv_filter_or_cow_bs(bs),
+                                      offset, bytes, pnum, map, file);
 }
 
 /*
-- 
2.41.0


