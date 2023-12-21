Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7B481C004
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:25:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWq-0007uw-8J; Thu, 21 Dec 2023 16:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWn-0007mt-Kh
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWl-00086Z-UU
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkE6zYHAZbMBHYcsuhPzvBy+Dqzg3JkSMxYsuqyZKK4=;
 b=OeohwOry78nxMlFk70zEGDetJDAsDRGoi60kS3vjd0a5MQhlqYq4IpFzYxR+RjoHXTikzF
 PyKEcrfnNxlYbu74dRFKaXS8rxDGSGCR3jJf7qUzYPu6+yQqu4QGIzBnD9K7NXmWGyJoyb
 lu4jR5q+Osdk6pfXBi9zLkLhc2HPN2g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-_l362FRPPNyot1k4SPOebA-1; Thu,
 21 Dec 2023 16:24:21 -0500
X-MC-Unique: _l362FRPPNyot1k4SPOebA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26F403C1E9D4;
 Thu, 21 Dec 2023 21:24:21 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 920AEC15968;
 Thu, 21 Dec 2023 21:24:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/33] dma-helpers: don't lock AioContext in dma_blk_cb()
Date: Thu, 21 Dec 2023 22:23:19 +0100
Message-ID: <20231221212339.164439-15-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Message-ID: <20231204164259.1515217-5-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


