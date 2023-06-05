Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B97722194
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q661w-0005bj-Jo; Mon, 05 Jun 2023 04:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661q-0005aM-6V
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661j-0004qo-Vz
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7/sRF25qu39uZYRXHtibyYqShUXwTBUMwfqv07pVAs=;
 b=LXwOoPJNvqAUA6rOdIhG4hF4cBo6LkSlVky5xIXppqKFWCMrS1YkGCpSRe9wCMGOkmgj7Y
 JWPv/AZbeYPzu85ZdgU1YD6FSrxGpTa5gxiEcJub/QJIizH8AzVjCIvmI6iwSKDm2wshcn
 NkBVHsCJvurzZfYwPmagW2kF70ABuiM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-ICnV7xktPpCQX0iHJVLp1g-1; Mon, 05 Jun 2023 04:57:18 -0400
X-MC-Unique: ICnV7xktPpCQX0iHJVLp1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EE9C38294AD;
 Mon,  5 Jun 2023 08:57:18 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95C0D40C6EC4;
 Mon,  5 Jun 2023 08:57:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 02/11] qdev-properties-system: Lock AioContext for
 blk_insert_bs()
Date: Mon,  5 Jun 2023 10:57:02 +0200
Message-Id: <20230605085711.21261-3-kwolf@redhat.com>
In-Reply-To: <20230605085711.21261-1-kwolf@redhat.com>
References: <20230605085711.21261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

blk_insert_bs() requires that callers hold the AioContext lock for the
node that should be inserted. Take it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/core/qdev-properties-system.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index d42493f630..6d5d43eda2 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -143,11 +143,15 @@ static void set_drive_helper(Object *obj, Visitor *v, const char *name,
              * aware of iothreads require their BlockBackends to be in the main
              * AioContext.
              */
-            ctx = iothread ? bdrv_get_aio_context(bs) : qemu_get_aio_context();
-            blk = blk_new(ctx, 0, BLK_PERM_ALL);
+            ctx = bdrv_get_aio_context(bs);
+            blk = blk_new(iothread ? ctx : qemu_get_aio_context(),
+                          0, BLK_PERM_ALL);
             blk_created = true;
 
+            aio_context_acquire(ctx);
             ret = blk_insert_bs(blk, bs, errp);
+            aio_context_release(ctx);
+
             if (ret < 0) {
                 goto fail;
             }
-- 
2.40.1


