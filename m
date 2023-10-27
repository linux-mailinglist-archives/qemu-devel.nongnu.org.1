Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F967D9DAF
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAI-0004SF-RC; Fri, 27 Oct 2023 11:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA6-0003h3-As
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA0-0002ok-U3
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bCP+iJnjnH5d4u20iLnP/JEyFasQcLC5B1yNg+p40UY=;
 b=NstWDF4xi6MmyLyBa3Tby2NCoxSZgCXQN+6NQNkx1u5dMW8bOzKB38/JEFauuC5fpFSm5a
 Houbl+mgdZOt6UP8HVxko/g0h/wy00n1oUnpNAW27iP0nRbH+W1nl8FiH/2GR/12jHC8En
 ILT1Vyo56iQESp0z6IvYfsUgo1nSm58=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-i0luOXJtP6mwhVv5ZexLCQ-1; Fri,
 27 Oct 2023 11:54:01 -0400
X-MC-Unique: i0luOXJtP6mwhVv5ZexLCQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73A4F1C382B3;
 Fri, 27 Oct 2023 15:54:01 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44DDB5027;
 Fri, 27 Oct 2023 15:54:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 14/24] block: Inline bdrv_set_backing_noperm()
Date: Fri, 27 Oct 2023 17:53:23 +0200
Message-ID: <20231027155333.420094-15-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

It's only a single line and has a single caller. Inlining makes things
a bit easier to follow.

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


