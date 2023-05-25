Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1AE710C5C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:49:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AOC-0000Fo-KN; Thu, 25 May 2023 08:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANw-0008Gs-WB
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANs-00021b-TI
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y0K5Asqj4Uud3Vi5s3FniNSdo4dtDJ/tUWbyu/pEXTY=;
 b=He4v5UAFIHqDGzI6ZOWjuSrYFQ6ChCwi1EUP513gmY2zHbDGb4bWkL/aguGq0jeVsbVTvX
 TYJrkzeaM+fRNem9IjshpEPAGhQrIhsXeeVaje4pyrOyswaAMlVIbWKctbSxSnXg6YvFU3
 ob1/h/1Hr4JlcQ3M5gTO9PUvSvPlh8Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-82ly8gzHN_elPrjMTMN3SA-1; Thu, 25 May 2023 08:47:34 -0400
X-MC-Unique: 82ly8gzHN_elPrjMTMN3SA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 532F73C13501;
 Thu, 25 May 2023 12:47:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 485278162;
 Thu, 25 May 2023 12:47:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 09/12] block: Take AioContext lock in bdrv_open_driver()
Date: Thu, 25 May 2023 14:47:10 +0200
Message-Id: <20230525124713.401149-10-kwolf@redhat.com>
In-Reply-To: <20230525124713.401149-1-kwolf@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

bdrv_refresh_total_sectors() and bdrv_refresh_limits() expect to be
called under the AioContext lock of the node. Take the lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block.c b/block.c
index be9ae364fb..e368a43761 100644
--- a/block.c
+++ b/block.c
@@ -1613,6 +1613,7 @@ static int no_coroutine_fn GRAPH_UNLOCKED
 bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
                  QDict *options, int open_flags, Error **errp)
 {
+    AioContext *ctx;
     Error *local_err = NULL;
     int i, ret;
     GLOBAL_STATE_CODE();
@@ -1660,15 +1661,21 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
     bs->supported_read_flags |= BDRV_REQ_REGISTERED_BUF;
     bs->supported_write_flags |= BDRV_REQ_REGISTERED_BUF;
 
+    /* Get the context after .bdrv_open, it can change the context */
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+
     ret = bdrv_refresh_total_sectors(bs, bs->total_sectors);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector count");
+        aio_context_release(ctx);
         return ret;
     }
 
     bdrv_graph_rdlock_main_loop();
     bdrv_refresh_limits(bs, NULL, &local_err);
     bdrv_graph_rdunlock_main_loop();
+    aio_context_release(ctx);
 
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.40.1


