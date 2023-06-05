Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A777221A6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q661o-0005a6-KN; Mon, 05 Jun 2023 04:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661m-0005Yg-H6
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661j-0004qh-Si
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAgKX9pf+aMAEQIxO3NZ4uYyinG2INC8puKoVVrBqR0=;
 b=DCsjch1oIkIqUXtnBYlWbgqC2cRrFQhcgVHYn9QevpS94smOdiuFNHW5OsLFSoZgAR8jmY
 7Z61L8WzsihxiJBtiJD9ETKfUVuy+zu7qhdnmXZKsLG1bfgSkYkcTHlBbF92HIIUR/o2Qe
 gj6U4pn2qyI0fna0FV3lUzy6+S0gzNY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-Pdoi393dOrastjC2RtmA5g-1; Mon, 05 Jun 2023 04:57:20 -0400
X-MC-Unique: Pdoi393dOrastjC2RtmA5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB33C2A5956A;
 Mon,  5 Jun 2023 08:57:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C483E40C6EC4;
 Mon,  5 Jun 2023 08:57:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 03/11] test-block-iothread: Lock AioContext for
 blk_insert_bs()
Date: Mon,  5 Jun 2023 10:57:03 +0200
Message-Id: <20230605085711.21261-4-kwolf@redhat.com>
In-Reply-To: <20230605085711.21261-1-kwolf@redhat.com>
References: <20230605085711.21261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

blk_insert_bs() requires that callers hold the AioContext lock for the
node that should be inserted. Take it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/unit/test-block-iothread.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index f081c09729..d727a5fee8 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -825,6 +825,7 @@ static void test_attach_second_node(void)
     BlockDriverState *bs, *filter;
     QDict *options;
 
+    aio_context_acquire(main_ctx);
     blk = blk_new(ctx, BLK_PERM_ALL, BLK_PERM_ALL);
     bs = bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_abort);
     blk_insert_bs(blk, bs, &error_abort);
@@ -833,7 +834,6 @@ static void test_attach_second_node(void)
     qdict_put_str(options, "driver", "raw");
     qdict_put_str(options, "file", "base");
 
-    aio_context_acquire(main_ctx);
     filter = bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort);
     aio_context_release(main_ctx);
 
@@ -857,9 +857,11 @@ static void test_attach_preserve_blk_ctx(void)
 {
     IOThread *iothread = iothread_new();
     AioContext *ctx = iothread_get_aio_context(iothread);
+    AioContext *main_ctx = qemu_get_aio_context();
     BlockBackend *blk;
     BlockDriverState *bs;
 
+    aio_context_acquire(main_ctx);
     blk = blk_new(ctx, BLK_PERM_ALL, BLK_PERM_ALL);
     bs = bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_abort);
     bs->total_sectors = 65536 / BDRV_SECTOR_SIZE;
@@ -868,6 +870,7 @@ static void test_attach_preserve_blk_ctx(void)
     blk_insert_bs(blk, bs, &error_abort);
     g_assert(blk_get_aio_context(blk) == ctx);
     g_assert(bdrv_get_aio_context(bs) == ctx);
+    aio_context_release(main_ctx);
 
     /* Remove the node again */
     aio_context_acquire(ctx);
@@ -877,7 +880,9 @@ static void test_attach_preserve_blk_ctx(void)
     g_assert(bdrv_get_aio_context(bs) == qemu_get_aio_context());
 
     /* Re-attach the node */
+    aio_context_acquire(main_ctx);
     blk_insert_bs(blk, bs, &error_abort);
+    aio_context_release(main_ctx);
     g_assert(blk_get_aio_context(blk) == ctx);
     g_assert(bdrv_get_aio_context(bs) == ctx);
 
-- 
2.40.1


