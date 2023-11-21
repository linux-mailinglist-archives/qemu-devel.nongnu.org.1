Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C457F2C1B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:54:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PJd-0003OV-4A; Tue, 21 Nov 2023 06:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJa-0003NM-4V
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJY-0004Gf-6J
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8uqfhuOlxC01EhY26GihrMudJmFQnq8y9K1i6poWLc=;
 b=U0aBr1RZGDRguaQFXwhBcG+XBKeSvkcQHdu+dDeAeR1oPsu6dCU6yAHR5//bDB/BNzUZRL
 awsoNCMMDu47X/tVFG51h6Hvap8XJAdjTmiBy6lVgSXL4YvzSqkB2TZc+mzZyL5PuPneA7
 lD1m+UEsAzC6cfpPWg6LJmnE0moc3c8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-9eCyFppQPaCVzeSfOvWTkQ-1; Tue, 21 Nov 2023 06:53:09 -0500
X-MC-Unique: 9eCyFppQPaCVzeSfOvWTkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F675101A53B;
 Tue, 21 Nov 2023 11:53:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 738B9492BFD;
 Tue, 21 Nov 2023 11:53:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 2/9] block: Fix bdrv_graph_wrlock() call in blk_remove_bs()
Date: Tue, 21 Nov 2023 12:52:55 +0100
Message-ID: <20231121115302.52214-3-kwolf@redhat.com>
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

While not all callers of blk_remove_bs() are correct in this respect,
the assumption in the function is that callers hold the AioContext lock
of the BlockBackend (this is required by the drain calls in it).

In order to avoid deadlock in the nested event loop, bdrv_graph_wrlock()
has then to be called with the root BlockDriverState as its parameter
instead of NULL, so that this AioContext lock is temporarily dropped.

Fixes: https://issues.redhat.com/browse/RHEL-1761
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231115172012.112727-2-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 4053134781..f6f05ead28 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -882,6 +882,8 @@ BlockBackend *blk_by_public(BlockBackendPublic *public)
 
 /*
  * Disassociates the currently associated BlockDriverState from @blk.
+ *
+ * The caller must hold the AioContext lock for the BlockBackend.
  */
 void blk_remove_bs(BlockBackend *blk)
 {
@@ -916,7 +918,7 @@ void blk_remove_bs(BlockBackend *blk)
     root = blk->root;
     blk->root = NULL;
 
-    bdrv_graph_wrlock(NULL);
+    bdrv_graph_wrlock(root->bs);
     bdrv_root_unref_child(root);
     bdrv_graph_wrunlock();
 }
-- 
2.42.0


