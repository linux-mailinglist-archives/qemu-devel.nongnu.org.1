Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DC77C7297
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySu-0003eD-II; Thu, 12 Oct 2023 12:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySn-0003ZU-RS
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySb-0000cV-2w
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOV6fJn+msZVBLGGAlpHzUoM8g5FvZqvqLjSl8X/e0g=;
 b=Jdx8Ma12JxM2JtN/FtQx8Nq2OwDqbzOGZpR4Gt6hXOotchqL24P/5Xo2a1Z6gy/X2WpkFw
 nUUDi1kBjHLy16YbAykDlveyR7jCAUJQIrVZFhQli72Mczn0iLKVbYIojLxscFYqiLrix5
 7nhMXmpdQccKvhyoFg640E3iwtKS7JA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-Hw65bSAlNpeiucGn2Di8rA-1; Thu, 12 Oct 2023 12:22:41 -0400
X-MC-Unique: Hw65bSAlNpeiucGn2Di8rA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 541AE805B31;
 Thu, 12 Oct 2023 16:22:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B86022026831;
 Thu, 12 Oct 2023 16:22:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/26] block: Take graph rdlock in bdrv_inactivate_all()
Date: Thu, 12 Oct 2023 18:22:05 +0200
Message-ID: <20231012162224.240535-8-kwolf@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The function reads the parents list, so it needs to hold the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-4-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index af04c8ac6f..b62f6f3841 100644
--- a/block.c
+++ b/block.c
@@ -6976,7 +6976,8 @@ void bdrv_activate_all(Error **errp)
     }
 }
 
-static bool bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
+static bool GRAPH_RDLOCK
+bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
 {
     BdrvChild *parent;
     GLOBAL_STATE_CODE();
@@ -6993,14 +6994,13 @@ static bool bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
     return false;
 }
 
-static int bdrv_inactivate_recurse(BlockDriverState *bs)
+static int GRAPH_RDLOCK bdrv_inactivate_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *parent;
     int ret;
     uint64_t cumulative_perms, cumulative_shared_perms;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!bs->drv) {
         return -ENOMEDIUM;
@@ -7066,6 +7066,7 @@ int bdrv_inactivate_all(void)
     GSList *aio_ctxs = NULL, *ctx;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
-- 
2.41.0


