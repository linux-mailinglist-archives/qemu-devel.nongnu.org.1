Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B49E717D98
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JcR-0007gV-0c; Wed, 31 May 2023 07:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jc1-0007TD-Ff
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbu-0001fa-Ju
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685530969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mKzNMaMJeH3JwSykSj+IX99QH6A36+xK3k+tagyGoI=;
 b=ChoyivnU6H23Rf0oxtyvvI41PupLcGviHt8ZoGhIot/zgeNZml7RWOYQv22D4s44aU1R7z
 1FO1fQVmGvBz/Gzgbro3uYn1KKFhIDOa64VKPe1XPQLZBCDGP6udK5mUGwG697i3HwKZFr
 /xf/xi54hjqIqkHR/KmrXGqXfaEmutE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-on4MAxXWO1qe3UCEgFAwkQ-1; Wed, 31 May 2023 07:02:45 -0400
X-MC-Unique: on4MAxXWO1qe3UCEgFAwkQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77DD23C0F182;
 Wed, 31 May 2023 11:02:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6A120296C6;
 Wed, 31 May 2023 11:02:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 05/11] block: Fix AioContext locking in
 bdrv_attach_child_common()
Date: Wed, 31 May 2023 13:02:25 +0200
Message-Id: <20230531110231.262251-6-kwolf@redhat.com>
In-Reply-To: <20230531110231.262251-1-kwolf@redhat.com>
References: <20230531110231.262251-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

The function can move the child node to a different AioContext. In this
case, it also must take the AioContext lock for the new context before
calling functions that require the caller to hold the AioContext for the
child node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 3ed943467a..508e0e396b 100644
--- a/block.c
+++ b/block.c
@@ -2989,6 +2989,10 @@ static TransactionActionDrv bdrv_attach_child_common_drv = {
  * Function doesn't update permissions, caller is responsible for this.
  *
  * Returns new created child.
+ *
+ * The caller must hold the AioContext lock for @child_bs. Both @parent_bs and
+ * @child_bs can move to a different AioContext in this function. Callers must
+ * make sure that their AioContext locking is still correct after this.
  */
 static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
                                            const char *child_name,
@@ -2999,7 +3003,7 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
                                            Transaction *tran, Error **errp)
 {
     BdrvChild *new_child;
-    AioContext *parent_ctx;
+    AioContext *parent_ctx, *new_child_ctx;
     AioContext *child_ctx = bdrv_get_aio_context(child_bs);
 
     assert(child_class->get_parent_desc);
@@ -3050,6 +3054,12 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
         }
     }
 
+    new_child_ctx = bdrv_get_aio_context(child_bs);
+    if (new_child_ctx != child_ctx) {
+        aio_context_release(child_ctx);
+        aio_context_acquire(new_child_ctx);
+    }
+
     bdrv_ref(child_bs);
     /*
      * Let every new BdrvChild start with a drained parent. Inserting the child
@@ -3079,11 +3089,20 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
     };
     tran_add(tran, &bdrv_attach_child_common_drv, s);
 
+    if (new_child_ctx != child_ctx) {
+        aio_context_release(new_child_ctx);
+        aio_context_acquire(child_ctx);
+    }
+
     return new_child;
 }
 
 /*
  * Function doesn't update permissions, caller is responsible for this.
+ *
+ * The caller must hold the AioContext lock for @child_bs. Both @parent_bs and
+ * @child_bs can move to a different AioContext in this function. Callers must
+ * make sure that their AioContext locking is still correct after this.
  */
 static BdrvChild *bdrv_attach_child_noperm(BlockDriverState *parent_bs,
                                            BlockDriverState *child_bs,
-- 
2.40.1


