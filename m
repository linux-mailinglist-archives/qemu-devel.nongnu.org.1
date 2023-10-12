Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604E7C729E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:30:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySt-0003cc-Dr; Thu, 12 Oct 2023 12:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySf-0003W8-6n
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000aT-KT
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShzWgIWiL0gD5g5ncYeUabCclTABsTdPbJKFea9fGLA=;
 b=Z+E/BULr0s6wnrzxXchbp+NW3jEOgu0vPV8UFjRFRiP/LgvqrlqJ6LX9MFEUq+j4hb8Fe6
 wpwyfE/pWvtOonwx8x6fJWU5JcMPRNhMa6f9AyFrz84Z/25cR+/geRPUo1onQguuOjhVpW
 1JPwxFsYJrq44SKYhwjsuNZ1HTIK0zE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-pYbyq1e8Or2rYlnOqCD3TA-1; Thu, 12 Oct 2023 12:22:46 -0400
X-MC-Unique: pYbyq1e8Or2rYlnOqCD3TA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 300E31C07597;
 Thu, 12 Oct 2023 16:22:46 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94AEB2026831;
 Thu, 12 Oct 2023 16:22:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/26] block: Mark bdrv_get_xdbg_block_graph() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:11 +0200
Message-ID: <20231012162224.240535-14-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_get_xdbg_block_graph() need to hold a reader lock for the graph
because it accesses the children list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-10-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 2 +-
 blockdev.c                         | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 505a0d0c11..4d80b3d554 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -192,7 +192,7 @@ int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
 BlockDeviceInfoList *bdrv_named_nodes_list(bool flat, Error **errp);
-XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp);
+XDbgBlockGraph * GRAPH_RDLOCK bdrv_get_xdbg_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
diff --git a/blockdev.c b/blockdev.c
index 43e0c4ddf2..ff5ee9ff7b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2846,6 +2846,8 @@ BlockDeviceInfoList *qmp_query_named_block_nodes(bool has_flat,
 
 XDbgBlockGraph *qmp_x_debug_query_block_graph(Error **errp)
 {
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     return bdrv_get_xdbg_block_graph(errp);
 }
 
-- 
2.41.0


