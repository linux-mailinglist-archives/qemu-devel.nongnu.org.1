Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD5577CFDD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 18:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVwY9-0006RO-4w; Tue, 15 Aug 2023 12:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVwY0-0006Oh-DN
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVwXy-0005K4-GA
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692115530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fqIGc7SqVa+mfrXtbKhnffOO+Ljcrez9JAWBMCAYV24=;
 b=PcIYv4hG8HkKkpkWvjbp+vj3V1Eoshcx3t+nvkJZeuIdkizHDKbZkhOvVILhbYZkApeXfi
 KlVD0mVLAflNxLcjMtUAt5mMmQuV/PrbDtSNju7c2dYrAxVBKp0aiEBefzFZ3QeHMop00o
 Up/HIzpVEzoI+190pxbbbb/tYJI/Jzc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-rmu2L4_sMe-_dwpZDz38qg-1; Tue, 15 Aug 2023 12:05:26 -0400
X-MC-Unique: rmu2L4_sMe-_dwpZDz38qg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 643AF101AA48;
 Tue, 15 Aug 2023 16:05:26 +0000 (UTC)
Received: from localhost (unknown [10.39.193.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3F3D2026D4B;
 Tue, 15 Aug 2023 16:05:25 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/2] block-backend: process I/O in the current AioContext
Date: Tue, 15 Aug 2023 12:05:20 -0400
Message-ID: <20230815160521.3357063-2-stefanha@redhat.com>
In-Reply-To: <20230815160521.3357063-1-stefanha@redhat.com>
References: <20230815160521.3357063-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

Switch blk_aio_*() APIs over to multi-queue by using
qemu_get_current_aio_context() instead of blk_get_aio_context(). This
change will allow devices to process I/O in multiple IOThreads in the
future.

I audited existing blk_aio_*() callers:
- migration/block.c: blk_mig_lock() protects the data accessed by the
  completion callback.
- The remaining emulated devices and exports run with
  qemu_get_aio_context() == blk_get_aio_context().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 4009ed5fed..39d969c919 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1533,7 +1533,7 @@ BlockAIOCB *blk_abort_aio_request(BlockBackend *blk,
     acb->blk = blk;
     acb->ret = ret;
 
-    replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+    replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
                                      error_callback_bh, acb);
     return &acb->common;
 }
@@ -1595,11 +1595,11 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset,
     acb->has_returned = false;
 
     co = qemu_coroutine_create(co_entry, acb);
-    aio_co_enter(blk_get_aio_context(blk), co);
+    aio_co_enter(qemu_get_current_aio_context(), co);
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
                                          blk_aio_complete_bh, acb);
     }
 
-- 
2.41.0


