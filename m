Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB117DD68F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:06:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyn-0004dV-4t; Tue, 31 Oct 2023 15:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyS-0004O4-Qm
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxs-0006AH-Au
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MwEbPouUpXWE2Huz+iABmttbaFStGbmXgMdXNCcCxa4=;
 b=Mdrufm23xtd3ha0YiAWjKHZlPH9yxa96amxsQgZbPL/ZjyOtC3mZT2Wmjd3LJhzEp5ca+Q
 XEZJc3lNqtnvDY0oVYwa6m9N8fG81F9YDoIPp0cIztdZLHQHBnZrJXFp1E/VeiSj8XIlnC
 +X6u2WGlW0/tH/U75NTgNRD1ZN2GOz4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-33nsijf7NuqZkr_whRCdkA-1; Tue, 31 Oct 2023 14:59:30 -0400
X-MC-Unique: 33nsijf7NuqZkr_whRCdkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69B8485A58C;
 Tue, 31 Oct 2023 18:59:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDB8B143;
 Tue, 31 Oct 2023 18:59:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/27] block: avoid potential deadlock during
 bdrv_graph_wrlock() in bdrv_close()
Date: Tue, 31 Oct 2023 19:59:03 +0100
Message-ID: <20231031185918.346940-13-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

by passing the BlockDriverState along, so the held AioContext can be
dropped before polling. See commit 31b2ddfea3 ("graph-lock: Unlock the
AioContext while polling") which introduced this functionality for
more information.

The only way to reach bdrv_close() is via bdrv_unref() and for calling
that the BlockDriverState's AioContext lock is supposed to be held.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231019131936.414246-3-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index f9cf05ddcf..a527aa1a4c 100644
--- a/block.c
+++ b/block.c
@@ -5200,7 +5200,7 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
-    bdrv_graph_wrlock(NULL);
+    bdrv_graph_wrlock(bs);
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
     }
-- 
2.41.0


