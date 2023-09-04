Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07317919C7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhY-0002PS-4e; Mon, 04 Sep 2023 10:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhR-0002Hq-Bo
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhM-0001mH-1X
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCa6uMnIGe5vy4MJfndt1m6rm1ATKiYAl/dKe3jmApY=;
 b=TTmVYOPRVi4kNUC9tr2YuNAWJjXuEsgbrqeGFroFOCo1xMifDUfqu3dQ+mk8LjePZADx1E
 o6vj4iAr7hOFwo6rmaWM//MjS+47mQSr0y4MikjA9t1apznSixCK6f4thKG7z+W4tROWRY
 1bRjkhBS9QgOzD7ikr1FaPs3IlJ4QZQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-7YVDzPbXMSiqHzZ8tkIK-w-1; Mon, 04 Sep 2023 10:37:00 -0400
X-MC-Unique: 7YVDzPbXMSiqHzZ8tkIK-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 021621C07243;
 Mon,  4 Sep 2023 14:37:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64E48400F5A;
 Mon,  4 Sep 2023 14:36:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/14] block: Remove bdrv_query_block_node_info
Date: Mon,  4 Sep 2023 16:36:42 +0200
Message-ID: <20230904143643.259916-14-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The last call site of this function has been removed by commit
c04d0ab026 ("qemu-img: Let info print block graph").

Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20230901184605.32260-2-farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/qapi.h |  3 ---
 block/qapi.c         | 27 ---------------------------
 2 files changed, 30 deletions(-)

diff --git a/include/block/qapi.h b/include/block/qapi.h
index 18d48ddb70..8663971c58 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -36,9 +36,6 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 int bdrv_query_snapshot_info_list(BlockDriverState *bs,
                                   SnapshotInfoList **p_list,
                                   Error **errp);
-void bdrv_query_block_node_info(BlockDriverState *bs,
-                                BlockNodeInfo **p_info,
-                                Error **errp);
 void bdrv_query_image_info(BlockDriverState *bs,
                            ImageInfo **p_info,
                            bool flat,
diff --git a/block/qapi.c b/block/qapi.c
index f34f95e0ef..79bf80c503 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -309,33 +309,6 @@ out:
     aio_context_release(bdrv_get_aio_context(bs));
 }
 
-/**
- * bdrv_query_block_node_info:
- * @bs: block node to examine
- * @p_info: location to store node information
- * @errp: location to store error information
- *
- * Store image information about @bs in @p_info.
- *
- * @p_info will be set only on success. On error, store error in @errp.
- */
-void bdrv_query_block_node_info(BlockDriverState *bs,
-                                BlockNodeInfo **p_info,
-                                Error **errp)
-{
-    BlockNodeInfo *info;
-    ERRP_GUARD();
-
-    info = g_new0(BlockNodeInfo, 1);
-    bdrv_do_query_node_info(bs, info, errp);
-    if (*errp) {
-        qapi_free_BlockNodeInfo(info);
-        return;
-    }
-
-    *p_info = info;
-}
-
 /**
  * bdrv_query_image_info:
  * @bs: block node to examine
-- 
2.41.0


