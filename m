Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 311AD706ED5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNK-00042G-I0; Wed, 17 May 2023 12:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNH-0003zV-AK
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNE-0001RM-La
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tx+qYlE8xKIGeYOqmcaS/dqt7uqb6gVj6jPjOw4sl3M=;
 b=JyVFgsws5trzT9jdA+4kv4+aYQRxZGrQehj0gQ9KeBXk6gSUHcLOxHNBjq1owOOcqMHVvq
 0JvVP4Z4TCBIaU5c0HdXcEyZZDtdNgqZ51AMJ1uuZsmaKLaIsztAP9B3a+/wN7e8S+FYN9
 HugZo7NTE22Kc7nYWex3ZWUNdfpbwFg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-nULxxuSNOV2pDKNzXOh46Q-1; Wed, 17 May 2023 12:51:32 -0400
X-MC-Unique: nULxxuSNOV2pDKNzXOh46Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35FFD38184E5;
 Wed, 17 May 2023 16:51:32 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4434078908;
 Wed, 17 May 2023 16:51:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 09/18] block/export: Fix null pointer dereference in error path
Date: Wed, 17 May 2023 18:51:07 +0200
Message-Id: <20230517165116.475123-10-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

There are some error paths in blk_exp_add() that jump to 'fail:' before
'exp' is even created. So we can't just unconditionally access exp->blk.

Add a NULL check, and switch from exp->blk to blk, which is available
earlier, just to be extra sure that we really cover all cases where
BlockDevOps could have been set for it (in practice, this only happens
in drv->create() today, so this part of the change isn't strictly
necessary).

Fixes: Coverity CID 1509238
Fixes: de79b52604e43fdeba6cee4f5af600b62169f2d2
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510203601.418015-3-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/export.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/export/export.c b/block/export/export.c
index 62c7c22d45..a5c8f42f53 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -192,8 +192,10 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     return exp;
 
 fail:
-    blk_set_dev_ops(exp->blk, NULL, NULL);
-    blk_unref(blk);
+    if (blk) {
+        blk_set_dev_ops(blk, NULL, NULL);
+        blk_unref(blk);
+    }
     aio_context_release(ctx);
     if (exp) {
         g_free(exp->id);
-- 
2.40.1


