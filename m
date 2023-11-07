Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FC7E48AB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:49:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6C-0004Q0-99; Tue, 07 Nov 2023 13:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5j-0003vc-7y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5h-0001Va-Dz
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INYB7n+QawKoYeQfVvQsSGeZKTEYgzBISam7H2frffc=;
 b=VQBzcN9zJTPCqy9pKAWsLuokV/ebCHdMl3p6J/f9+zvjhqNUbBw3tndnYh+KpEkSum0uuL
 QAMbWNYUYNmIMR9UzSmy9ITz1pQvGuu2vYus4NF9wXp+CMtXm07qS/vXbyKkfjdJgbNoWO
 1qm0+PJqdxjIExChKKB6ncOFfMyoqc4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-vM39sbkrNi2sUA0vfhb2Tg-1; Tue,
 07 Nov 2023 13:46:18 -0500
X-MC-Unique: vM39sbkrNi2sUA0vfhb2Tg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 515433C1CC27
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:18 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1173C1290F;
 Tue,  7 Nov 2023 18:46:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 14/25] block: Inline bdrv_set_backing_noperm()
Date: Tue,  7 Nov 2023 19:45:54 +0100
Message-ID: <20231107184605.236540-15-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

It's only a single line and has a single caller. Inlining makes things
a bit easier to follow.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-15-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/block.c b/block.c
index d79a6f41f9..dc43e36f69 100644
--- a/block.c
+++ b/block.c
@@ -3532,19 +3532,7 @@ out:
  *
  * If a backing child is already present (i.e. we're detaching a node), that
  * child node must be drained.
- *
- * After calling this function, the transaction @tran may only be completed
- * while holding a writer lock for the graph.
  */
-static int GRAPH_WRLOCK
-bdrv_set_backing_noperm(BlockDriverState *bs,
-                        BlockDriverState *backing_hd,
-                        Transaction *tran, Error **errp)
-{
-    GLOBAL_STATE_CODE();
-    return bdrv_set_file_or_backing_noperm(bs, backing_hd, true, tran, errp);
-}
-
 int bdrv_set_backing_hd_drained(BlockDriverState *bs,
                                 BlockDriverState *backing_hd,
                                 Error **errp)
@@ -3558,7 +3546,7 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
         assert(bs->backing->bs->quiesce_counter > 0);
     }
 
-    ret = bdrv_set_backing_noperm(bs, backing_hd, tran, errp);
+    ret = bdrv_set_file_or_backing_noperm(bs, backing_hd, true, tran, errp);
     if (ret < 0) {
         goto out;
     }
-- 
2.41.0


