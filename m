Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE84803AA0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 17:44:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAC2z-0005it-Qu; Mon, 04 Dec 2023 11:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2v-0005hs-OH
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAC2q-0003fv-Br
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 11:43:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701708222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LFbfzn0uWEVgSJqhghAiPqOrVkXEXPxN7owVjxzB5I=;
 b=X5vlWXuaVcePhw0rDNCrqBZ03i3WWLNR9Utbt95GuNN41R/6zb92f0sHB4UvpWTN+yC3rz
 XNyyEe3ayGn9oOPW93KLNZvurY8e/Xb+NC34MyFqyiSHEcesEByFID7JBY0sXS8YfdgQ+1
 cTRNflhbfNqi5h0hfezFc+LF4kPNMhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-jTI_Bfl7NjG_vVkWnRiztA-1; Mon, 04 Dec 2023 11:43:38 -0500
X-MC-Unique: jTI_Bfl7NjG_vVkWnRiztA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F29D101B041;
 Mon,  4 Dec 2023 16:43:38 +0000 (UTC)
Received: from localhost (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6ACDE2166B26;
 Mon,  4 Dec 2023 16:43:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 4/4] dma-helpers: don't lock AioContext in dma_blk_cb()
Date: Mon,  4 Dec 2023 11:42:59 -0500
Message-ID: <20231204164259.1515217-5-stefanha@redhat.com>
In-Reply-To: <20231204164259.1515217-1-stefanha@redhat.com>
References: <20231204164259.1515217-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Commit abfcd2760b3e ("dma-helpers: prevent dma_blk_cb() vs
dma_aio_cancel() race") acquired the AioContext lock inside dma_blk_cb()
to avoid a race with scsi_device_purge_requests() running in the main
loop thread.

The SCSI code no longer calls dma_aio_cancel() from the main loop thread
while I/O is running in the IOThread AioContext. Therefore it is no
longer necessary to take this lock to protect DMAAIOCB fields. The
->cb() function also does not require the lock because blk_aio_*() and
friends do not need the AioContext lock.

Both hw/ide/core.c and hw/ide/macio.c also call dma_blk_io() but don't
rely on it taking the AioContext lock, so this change is safe.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 system/dma-helpers.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 36211acc7e..528117f256 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -119,13 +119,12 @@ static void dma_blk_cb(void *opaque, int ret)
 
     trace_dma_blk_cb(dbs, ret);
 
-    aio_context_acquire(ctx);
     dbs->acb = NULL;
     dbs->offset += dbs->iov.size;
 
     if (dbs->sg_cur_index == dbs->sg->nsg || ret < 0) {
         dma_complete(dbs, ret);
-        goto out;
+        return;
     }
     dma_blk_unmap(dbs);
 
@@ -168,7 +167,7 @@ static void dma_blk_cb(void *opaque, int ret)
         trace_dma_map_wait(dbs);
         dbs->bh = aio_bh_new(ctx, reschedule_dma, dbs);
         cpu_register_map_client(dbs->bh);
-        goto out;
+        return;
     }
 
     if (!QEMU_IS_ALIGNED(dbs->iov.size, dbs->align)) {
@@ -179,8 +178,6 @@ static void dma_blk_cb(void *opaque, int ret)
     dbs->acb = dbs->io_func(dbs->offset, &dbs->iov,
                             dma_blk_cb, dbs, dbs->io_func_opaque);
     assert(dbs->acb);
-out:
-    aio_context_release(ctx);
 }
 
 static void dma_aio_cancel(BlockAIOCB *acb)
-- 
2.43.0


