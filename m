Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F0880A3B9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 13:45:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBaDA-0006di-B1; Fri, 08 Dec 2023 07:44:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rBaD8-0006dY-NS
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rBaD7-00037t-4w
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 07:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702039444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8pXml5/Y9kknCNvq95S1/zECYp6R8f+59oINf2was3c=;
 b=LJ56fBP7VEk2gnkpjghnjPXXpZckRUTGrf8XUKdGvlR52T3DTWDNNb8CGnD8RIUDKuYTNO
 4ti9NFMsypIBCzY7XmAe0NzI37RRAU9fohD7KPrVxD1foVcRm2EWSo3+gb1A3P4SCARX/i
 8hJ8syiDtBIU+lRSJkGfP3i3jVvrUaU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-P0O8VB_GP0O3_LKBZi-vcQ-1; Fri,
 08 Dec 2023 07:43:59 -0500
X-MC-Unique: P0O8VB_GP0O3_LKBZi-vcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 505921C0F476;
 Fri,  8 Dec 2023 12:43:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 62A9F40C6EB9;
 Fri,  8 Dec 2023 12:43:58 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH for-8.2] block: Fix AioContext locking in qmp_block_resize()
Date: Fri,  8 Dec 2023 13:43:52 +0100
Message-ID: <20231208124352.30295-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AioContext must be unlocked before calling blk_co_unref(), because
it takes the AioContext lock internally in blk_unref_bh(), which is
scheduled in the main thread. If we don't unlock, the AioContext is
locked twice and nested event loops such as in bdrv_graph_wrlock() will
deadlock.

Cc: qemu-stable@nongnu.org
Fixes: https://issues.redhat.com/browse/RHEL-15965
Fixes: 0c7d204f50c382c6baac8c94bd57af4a022b3888
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 4c1177e8db..c91f49e7b6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2400,8 +2400,9 @@ void coroutine_fn qmp_block_resize(const char *device, const char *node_name,
 
     bdrv_co_lock(bs);
     bdrv_drained_end(bs);
-    blk_co_unref(blk);
     bdrv_co_unlock(bs);
+
+    blk_co_unref(blk);
 }
 
 void qmp_block_stream(const char *job_id, const char *device,
-- 
2.43.0


