Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AA37C726E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyT4-0003m5-83; Thu, 12 Oct 2023 12:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqyT1-0003lG-PK
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySi-0000fk-5e
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jj+l0keGqSPc+PEwURAMuv3ZMa6XXKcGcn9RUPkM0Ks=;
 b=iDVWCuhQq8HvS3Adrb+ctqs4m76HE9wH3zyTTt+5oMemOzxrceFuWWnmaYy8bEtJhGu7js
 dUBkmB0fPw1ZLh7WU82ATmuveqOriTKkVV5UhjbCZ+a84/ajPwGb/SsDAOCUaWjtbJh9He
 BOf5OUVm8vwlhQEJZ+WfnfyTpburcvc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-1RL2qNkeP22MXqISmAEH8Q-1; Thu, 12 Oct 2023 12:22:57 -0400
X-MC-Unique: 1RL2qNkeP22MXqISmAEH8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F064238107A1;
 Thu, 12 Oct 2023 16:22:56 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60D05202B17E;
 Thu, 12 Oct 2023 16:22:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 26/26] block: Add assertion for bdrv_graph_wrlock()
Date: Thu, 12 Oct 2023 18:22:24 +0200
Message-ID: <20231012162224.240535-27-kwolf@redhat.com>
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

bdrv_graph_wrlock() can't run in a coroutine (because it polls) and
requires holding the BQL. We already have GLOBAL_STATE_CODE() to assert
the latter. Assert the former as well and add a no_coroutine_fn marker.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-23-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/graph-lock.h | 3 ++-
 block/graph-lock.c         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index 7e04f98ff0..6f1cd12745 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -116,7 +116,8 @@ void unregister_aiocontext(AioContext *ctx);
  * This function polls. Callers must not hold the lock of any AioContext other
  * than the current one and the one of @bs.
  */
-void bdrv_graph_wrlock(BlockDriverState *bs) TSA_ACQUIRE(graph_lock) TSA_NO_TSA;
+void no_coroutine_fn TSA_ACQUIRE(graph_lock) TSA_NO_TSA
+bdrv_graph_wrlock(BlockDriverState *bs);
 
 /*
  * bdrv_graph_wrunlock:
diff --git a/block/graph-lock.c b/block/graph-lock.c
index 58a799065f..e5525ee2db 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -106,12 +106,13 @@ static uint32_t reader_count(void)
     return rd;
 }
 
-void bdrv_graph_wrlock(BlockDriverState *bs)
+void no_coroutine_fn bdrv_graph_wrlock(BlockDriverState *bs)
 {
     AioContext *ctx = NULL;
 
     GLOBAL_STATE_CODE();
     assert(!qatomic_read(&has_writer));
+    assert(!qemu_in_coroutine());
 
     /*
      * Release only non-mainloop AioContext. The mainloop often relies on the
-- 
2.41.0


