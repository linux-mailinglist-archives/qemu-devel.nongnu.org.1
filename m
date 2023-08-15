Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A477CFDE
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 18:06:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVwYN-0006T4-Od; Tue, 15 Aug 2023 12:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVwY2-0006RD-GT
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qVwY1-0005Mx-05
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692115532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ehBiVLEESOAQ7yF3UUQkVwDRNDcmxTmfFBDI5tIO/Lc=;
 b=Nn4JOBJ7HHUUS+IADXzvSNFaVoKgNCFzwi0Vtn2jj+TAVgXicqjNY5vjgoIPpT3zbnK28T
 vQo52bOKIXAbcXMzRmK/JHXPVCeYx6RXZmP1gAkLIVizdgMYYO7RVntfCUmwuvRdeGDkVg
 Ts17q++735NJurepIvqCreWsN94IiEA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-1aP8UKPGPve9JPKAwskG5Q-1; Tue, 15 Aug 2023 12:05:29 -0400
X-MC-Unique: 1aP8UKPGPve9JPKAwskG5Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4E6D8DC665;
 Tue, 15 Aug 2023 16:05:28 +0000 (UTC)
Received: from localhost (unknown [10.39.193.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51FF6140E950;
 Tue, 15 Aug 2023 16:05:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/2] block-backend: process zoned requests in the current
 AioContext
Date: Tue, 15 Aug 2023 12:05:21 -0400
Message-ID: <20230815160521.3357063-3-stefanha@redhat.com>
In-Reply-To: <20230815160521.3357063-1-stefanha@redhat.com>
References: <20230815160521.3357063-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Process zoned requests in the current thread's AioContext instead of in
the BlockBackend's AioContext.

There is no need to use the BlockBackend's AioContext thanks to CoMutex
bs->wps->colock, which protects zone metadata.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/block-backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 39d969c919..fae058913d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1901,11 +1901,11 @@ BlockAIOCB *blk_aio_zone_report(BlockBackend *blk, int64_t offset,
     acb->has_returned = false;
 
     co = qemu_coroutine_create(blk_aio_zone_report_entry, acb);
-    aio_co_enter(blk_get_aio_context(blk), co);
+    aio_co_enter(qemu_get_current_aio_context(), co);
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
                                          blk_aio_complete_bh, acb);
     }
 
@@ -1942,11 +1942,11 @@ BlockAIOCB *blk_aio_zone_mgmt(BlockBackend *blk, BlockZoneOp op,
     acb->has_returned = false;
 
     co = qemu_coroutine_create(blk_aio_zone_mgmt_entry, acb);
-    aio_co_enter(blk_get_aio_context(blk), co);
+    aio_co_enter(qemu_get_current_aio_context(), co);
 
     acb->has_returned = true;
     if (acb->rwco.ret != NOT_DONE) {
-        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+        replay_bh_schedule_oneshot_event(qemu_get_current_aio_context(),
                                          blk_aio_complete_bh, acb);
     }
 
@@ -1982,10 +1982,10 @@ BlockAIOCB *blk_aio_zone_append(BlockBackend *blk, int64_t *offset,
     acb->has_returned = false;
 
     co = qemu_coroutine_create(blk_aio_zone_append_entry, acb);
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


