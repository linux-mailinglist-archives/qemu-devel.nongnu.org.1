Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCDD717D91
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JcS-0007jn-Tv; Wed, 31 May 2023 07:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jc0-0007Sp-Mz
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbu-0001fO-Ix
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685530967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6IwGvA6A66KFFU4BphP+CRoFw0sM6jkp7gZI9tsn52k=;
 b=HjGXaZb7lBpPWWypIGvm/xZ1TOBHyWTyQAjYbZilnCRGeiC9iMk/EMU0bCyDCF4Q62z2pu
 DCtWjbafgwA3JhR5lsEtdugeGbEG8kGYxVjnN44zQkifOhk/8EfEDPpIiHfH+X9S+9dcd9
 zTlflAjEN1WEukOif7NNHFOxDQCHhdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-vixmxTF_PsKBsVdvdXeeEw-1; Wed, 31 May 2023 07:02:44 -0400
X-MC-Unique: vixmxTF_PsKBsVdvdXeeEw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC67D801182;
 Wed, 31 May 2023 11:02:43 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4B1620296C6;
 Wed, 31 May 2023 11:02:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 04/11] block: Fix AioContext locking in bdrv_open_child()
Date: Wed, 31 May 2023 13:02:24 +0200
Message-Id: <20230531110231.262251-5-kwolf@redhat.com>
In-Reply-To: <20230531110231.262251-1-kwolf@redhat.com>
References: <20230531110231.262251-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

bdrv_attach_child() requires that the caller holds the AioContext lock
for the new child node. Take it in bdrv_open_child() and document that
the caller must not hold any AioContext apart from the main AioContext.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index dae629075c..3ed943467a 100644
--- a/block.c
+++ b/block.c
@@ -3654,6 +3654,7 @@ done:
  *
  * The BlockdevRef will be removed from the options QDict.
  *
+ * The caller must hold the lock of the main AioContext and no other AioContext.
  * @parent can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
  */
@@ -3665,6 +3666,8 @@ BdrvChild *bdrv_open_child(const char *filename,
                            bool allow_none, Error **errp)
 {
     BlockDriverState *bs;
+    BdrvChild *child;
+    AioContext *ctx;
 
     GLOBAL_STATE_CODE();
 
@@ -3674,13 +3677,19 @@ BdrvChild *bdrv_open_child(const char *filename,
         return NULL;
     }
 
-    return bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
-                             errp);
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
+    child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
+                              errp);
+    aio_context_release(ctx);
+
+    return child;
 }
 
 /*
  * Wrapper on bdrv_open_child() for most popular case: open primary child of bs.
  *
+ * The caller must hold the lock of the main AioContext and no other AioContext.
  * @parent can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
  */
-- 
2.40.1


