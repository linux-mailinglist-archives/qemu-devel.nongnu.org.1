Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB64ACE42C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Jun 2025 20:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsVT-0000JG-Vy; Wed, 04 Jun 2025 14:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsV4-0000DW-2L
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 14:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsV2-00025Y-4r
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 14:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749060361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ja41yrXMXkxb9nyZhS+Klic+i89IEtaNdZx/kY7uJGM=;
 b=Abr6ey2JdsF9eIBpEqy/16BiX1UD0XaSsJIEMzifaZWI3GI+7GfOiCdP/TvR/2bjRBYJsB
 1m8FSPKsl4sGFne/aoGp+9+dj7tghrAeHMh/fh0Z36q9L6KpEOuG0cPsvRXYckMdUisYXN
 8URceUhhk+mg0El4+WQpMoP+PIin1t0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-QhcRrrNhPXCXUCBlxJgL_Q-1; Wed,
 04 Jun 2025 13:56:45 -0400
X-MC-Unique: QhcRrrNhPXCXUCBlxJgL_Q-1
X-Mimecast-MFC-AGG-ID: QhcRrrNhPXCXUCBlxJgL_Q_1749059805
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9D7B1955D69; Wed,  4 Jun 2025 17:56:44 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93C7018002B3; Wed,  4 Jun 2025 17:56:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/24] block: move drain outside of quorum_add_child()
Date: Wed,  4 Jun 2025 19:56:03 +0200
Message-ID: <20250604175613.344113-15-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The quorum_add_child() callback runs under the graph lock, so it is
not allowed to drain. It is only called as the .bdrv_add_child()
callback, which is only called in the bdrv_add_child() function, which
also runs under the graph lock.

The bdrv_add_child() function is called by qmp_x_blockdev_change(),
where a drained section is introduced.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20250530151125.955508-15-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h |  7 +++++++
 block.c                          | 10 ++++++++--
 block/quorum.c                   |  2 --
 blockdev.c                       |  2 ++
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 168f703fa1..f9e742f812 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -396,6 +396,13 @@ struct BlockDriver {
     int GRAPH_RDLOCK_PTR (*bdrv_probe_geometry)(
         BlockDriverState *bs, HDGeometry *geo);
 
+    /**
+     * Hot add a BDS's child. Used in combination with bdrv_del_child, so the
+     * user can take a child offline when it is broken and take a new child
+     * online.
+     *
+     * All block nodes must be drained.
+     */
     void GRAPH_WRLOCK_PTR (*bdrv_add_child)(
         BlockDriverState *parent, BlockDriverState *child, Error **errp);
 
diff --git a/block.c b/block.c
index 6fc87aa318..f6c2f7e208 100644
--- a/block.c
+++ b/block.c
@@ -8220,8 +8220,10 @@ char *bdrv_dirname(BlockDriverState *bs, Error **errp)
 }
 
 /*
- * Hot add/remove a BDS's child. So the user can take a child offline when
- * it is broken and take a new child online
+ * Hot add a BDS's child. Used in combination with bdrv_del_child, so the user
+ * can take a child offline when it is broken and take a new child online.
+ *
+ * All block nodes must be drained.
  */
 void bdrv_add_child(BlockDriverState *parent_bs, BlockDriverState *child_bs,
                     Error **errp)
@@ -8261,6 +8263,10 @@ void bdrv_add_child(BlockDriverState *parent_bs, BlockDriverState *child_bs,
     parent_bs->drv->bdrv_add_child(parent_bs, child_bs, errp);
 }
 
+/*
+ * Hot remove a BDS's child. Used in combination with bdrv_add_child, so the
+ * user can take a child offline when it is broken and take a new child online.
+ */
 void bdrv_del_child(BlockDriverState *parent_bs, BdrvChild *child, Error **errp)
 {
     BdrvChild *tmp;
diff --git a/block/quorum.c b/block/quorum.c
index ea17b0ec13..ed8ce801ee 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1096,10 +1096,8 @@ quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs, Error **errp)
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
-    bdrv_drain_all_begin();
     child = bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
                               BDRV_CHILD_DATA, errp);
-    bdrv_drain_all_end();
     if (child == NULL) {
         s->next_child_index--;
         return;
diff --git a/blockdev.c b/blockdev.c
index 750beba41f..bd5ca77619 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3531,6 +3531,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     BlockDriverState *parent_bs, *new_bs = NULL;
     BdrvChild *p_child;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     parent_bs = bdrv_lookup_bs(parent, parent, errp);
@@ -3568,6 +3569,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
 
 out:
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
-- 
2.49.0


