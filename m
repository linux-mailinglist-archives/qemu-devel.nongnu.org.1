Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367167B3618
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEqs-0005a4-0a; Fri, 29 Sep 2023 10:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqn-0005Zk-Db
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqk-0004d1-Dn
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqu81Pcu8ejwV038mFsez0hGcJs6mcEEv4QNQG9ZaNw=;
 b=RcOhmwuOPbMjpcq7lfED77QBb9LPDae3HUjGn2bRtUYjfWJHQSGrDSc0qbybFgzX+nNBLM
 pvlyhXlijqUPfCcpkOO399iA/H2bV/opiONr7CvOh8asOlvDFugxA/HI4OYqSacL2gbqkz
 8jekjH2HiqHVhf0QWEA9H3kGuozBWYs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-EJc8rNQIOPqVuJ8dCZ71Yw-1; Fri, 29 Sep 2023 10:52:08 -0400
X-MC-Unique: EJc8rNQIOPqVuJ8dCZ71Yw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E44A73C1CC20;
 Fri, 29 Sep 2023 14:52:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B56F32026D4B;
 Fri, 29 Sep 2023 14:52:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 03/22] block: Take graph rdlock in bdrv_inactivate_all()
Date: Fri, 29 Sep 2023 16:51:38 +0200
Message-ID: <20230929145157.45443-4-kwolf@redhat.com>
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

The function reads the parents list, so it needs to hold the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index e7f349b25c..73fd386076 100644
--- a/block.c
+++ b/block.c
@@ -6975,7 +6975,8 @@ void bdrv_activate_all(Error **errp)
     }
 }
 
-static bool bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
+static bool GRAPH_RDLOCK
+bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
 {
     BdrvChild *parent;
     GLOBAL_STATE_CODE();
@@ -6992,14 +6993,13 @@ static bool bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
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
@@ -7065,6 +7065,7 @@ int bdrv_inactivate_all(void)
     GSList *aio_ctxs = NULL, *ctx;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
-- 
2.41.0


