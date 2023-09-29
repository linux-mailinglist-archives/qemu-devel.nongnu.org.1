Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DDE7B3619
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErr-00068j-Ui; Fri, 29 Sep 2023 10:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmErY-00062F-LB
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEr8-0004po-Ao
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yF1Rmn7Fl483X3N3fAqagt5a4cprBdHF6g6WScuqeVk=;
 b=aL4EbkajuYinmEQKOvqsr/odq15lTPLyCngahcB4O3UCaHrqVQdqST3W4iCR2IuMsbQqHQ
 h6VePbA51s6jKf724gkXYapW4LthtHfKGMfGOn77cD0Xvm0DdFKfu18onsoOgwh7Svry2M
 7/DHUhHx4w/Ls77LrCLZ2a27BIz+d88=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-PC1RN7LrPNGerpwUiO0hyg-1; Fri, 29 Sep 2023 10:52:32 -0400
X-MC-Unique: PC1RN7LrPNGerpwUiO0hyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 446A92810D5D;
 Fri, 29 Sep 2023 14:52:32 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1527A2026D4B;
 Fri, 29 Sep 2023 14:52:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 20/22] block: Protect bs->parents with graph_lock
Date: Fri, 29 Sep 2023 16:51:55 +0200
Message-ID: <20230929145157.45443-21-kwolf@redhat.com>
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

Almost all functions that access the parent link already take the graph
lock now. Add locking to the remaining user in a test case and finally
annotate the struct field itself as protected by the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 4 ++--
 tests/unit/test-block-iothread.c | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 024262b5a2..0e37acd976 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1043,7 +1043,7 @@ struct BdrvChild {
     bool quiesced_parent;
 
     QLIST_ENTRY(BdrvChild) next;
-    QLIST_ENTRY(BdrvChild) next_parent;
+    QLIST_ENTRY(BdrvChild GRAPH_RDLOCK_PTR) next_parent;
 };
 
 /*
@@ -1180,7 +1180,7 @@ struct BlockDriverState {
     BdrvChild *backing;
     BdrvChild *file;
 
-    QLIST_HEAD(, BdrvChild) parents;
+    QLIST_HEAD(, BdrvChild GRAPH_RDLOCK_PTR) parents;
 
     QDict *options;
     QDict *explicit_options;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 151049bda5..9b15d2768c 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -471,11 +471,16 @@ static void test_sync_op(const void *opaque)
     BlockDriverState *bs;
     BdrvChild *c;
 
+    GLOBAL_STATE_CODE();
+
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     bs = bdrv_new_open_driver(&bdrv_test, "base", BDRV_O_RDWR, &error_abort);
     bs->total_sectors = 65536 / BDRV_SECTOR_SIZE;
     blk_insert_bs(blk, bs, &error_abort);
+
+    bdrv_graph_rdlock_main_loop();
     c = QLIST_FIRST(&bs->parents);
+    bdrv_graph_rdunlock_main_loop();
 
     blk_set_aio_context(blk, ctx, &error_abort);
     aio_context_acquire(ctx);
-- 
2.41.0


