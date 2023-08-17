Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528F877F6E5
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcTW-0000as-Dk; Thu, 17 Aug 2023 08:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcTF-0008Hj-W3
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcTD-0002ot-1r
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692276682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/5C33TUwvkmnARvtgrE7YduLRq8M770XlYqo/+wWS2g=;
 b=O8l2tqPzxNjPT+x6taxwCDZGtcqdfs/gXmalcEB3DO+jFspI8j9yCvD/9lkENDNyG4p41b
 8sSjeVK0JSs/z9RcG4XGP4svIF0ZFkqu0u9HKKmiSE+GS52m1LK6ArJtSB/5fzYWqS51aE
 mJqoi2IwNJJKOd64vzUBxKkS02GPfxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-DodP5TI3NGyHvDcBBGOJIg-1; Thu, 17 Aug 2023 08:51:18 -0400
X-MC-Unique: DodP5TI3NGyHvDcBBGOJIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8473D85C710;
 Thu, 17 Aug 2023 12:51:18 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 590571121314;
 Thu, 17 Aug 2023 12:51:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 18/21] block: Take graph rdlock in bdrv_change_aio_context()
Date: Thu, 17 Aug 2023 14:50:17 +0200
Message-ID: <20230817125020.208339-19-kwolf@redhat.com>
In-Reply-To: <20230817125020.208339-1-kwolf@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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
---
 block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block.c b/block.c
index a82389f742..c0a8460434 100644
--- a/block.c
+++ b/block.c
@@ -7669,17 +7669,21 @@ static bool bdrv_change_aio_context(BlockDriverState *bs, AioContext *ctx,
         return true;
     }
 
+    bdrv_graph_rdlock_main_loop();
     QLIST_FOREACH(c, &bs->parents, next_parent) {
         if (!bdrv_parent_change_aio_context(c, ctx, visited, tran, errp)) {
+            bdrv_graph_rdunlock_main_loop();
             return false;
         }
     }
 
     QLIST_FOREACH(c, &bs->children, next) {
         if (!bdrv_child_change_aio_context(c, ctx, visited, tran, errp)) {
+            bdrv_graph_rdunlock_main_loop();
             return false;
         }
     }
+    bdrv_graph_rdunlock_main_loop();
 
     state = g_new(BdrvStateSetAioContext, 1);
     *state = (BdrvStateSetAioContext) {
-- 
2.41.0


