Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179807B3617
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErv-0006Qc-T9; Fri, 29 Sep 2023 10:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmErY-000632-TQ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEr9-0004r8-88
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YbaIPZsRT9+LO8rvQZqjHRZxeRzQt3qOxrJ12fm4id8=;
 b=dG9o5hK1fsCBHO9+XGheVw4XBbLbV4rPEposPHIlGIyE71Sm/5XPEs0HFOx/Px1irH5sxZ
 Z/NdjBz4Q+oQmB7VxXVt446uH+5HMy6P3Wr+3iR+XCPyn37k7+bCx9aOTwL+OrcEJbFw6N
 ZQmy5kdRXNJCGaaYA8bAN/fSA+wxCuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-F08mdBcDOXumZE4ve285cw-1; Fri, 29 Sep 2023 10:52:35 -0400
X-MC-Unique: F08mdBcDOXumZE4ve285cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B00E811E7D;
 Fri, 29 Sep 2023 14:52:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEE952026D4B;
 Fri, 29 Sep 2023 14:52:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 22/22] block: Add assertion for bdrv_graph_wrlock()
Date: Fri, 29 Sep 2023 16:51:57 +0200
Message-ID: <20230929145157.45443-23-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

bdrv_graph_wrlock() can't run in a coroutine (because it polls) and
requires holding the BQL. We already have GLOBAL_STATE_CODE() to assert
the latter. Assert the former as well and add a no_coroutine_fn marker.

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


