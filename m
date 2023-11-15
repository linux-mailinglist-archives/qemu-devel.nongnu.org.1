Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8A57EC994
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:21:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JZ1-0007e0-EP; Wed, 15 Nov 2023 12:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3JZ0-0007dl-A4
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3JYy-0003CL-Q4
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700068828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=70hLchKKDMD2HpZFpzNZq73fWIcmHKXu1vjidAtQ9QA=;
 b=Ar0BblzNwQuDCg+Yiaup88aFtMovxRWCqvceauJTLbRHIMewfIelUo6oKRTGkLl8d9H2kY
 VDR3lXUI6WGRZaY9Yhyfawm6/AMG8BVgCh1DJve7g6kJW/NRKvphxicdNb5hDtHwspJbP1
 tlF6NB1PMICYwf89kSBonmt9AMMk7ko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-ctUyZJtqPximIYwcBk0V_w-1; Wed, 15 Nov 2023 12:20:26 -0500
X-MC-Unique: ctUyZJtqPximIYwcBk0V_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBC96185A7AD;
 Wed, 15 Nov 2023 17:20:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E3FE36E;
 Wed, 15 Nov 2023 17:20:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH for-8.2 1/4] block: Fix bdrv_graph_wrlock() call in
 blk_remove_bs()
Date: Wed, 15 Nov 2023 18:20:09 +0100
Message-ID: <20231115172012.112727-2-kwolf@redhat.com>
In-Reply-To: <20231115172012.112727-1-kwolf@redhat.com>
References: <20231115172012.112727-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While not all callers of blk_remove_bs() are correct in this respect,
the assumption in the function is that callers hold the AioContext lock
of the BlockBackend (this is required by the drain calls in it).

In order to avoid deadlock in the nested event loop, bdrv_graph_wrlock()
has then to be called with the root BlockDriverState as its parameter
instead of NULL, so that this AioContext lock is temporarily dropped.

Fixes: https://issues.redhat.com/browse/RHEL-1761
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
2.41.0


