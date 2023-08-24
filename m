Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F81378764C
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDfj-0006H4-Le; Thu, 24 Aug 2023 12:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDfh-0006F0-1C
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDfe-0003S2-G0
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692896337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EJD2LIajjQtoGeGPnYi+7JdF7CSvrKKy9cQB+BYrwtY=;
 b=D5HVb0WUE9L7nwUVJrws87gG1zP/BY6ZKOeoy/KF8xRMDDbDJErAmv3GPiqw79uzngK9EO
 FHOWuqEiLIUeQV2WdPSlAHl1OMgWmE39QtqR9L11VP2BwJaCqsjwlAFKyYkJ3FF4646kPL
 7ubI+HeG3/co4hhrYukxXnDCBdfjdDQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-z2cB3R2PPDmWc3PD1CgTFg-1; Thu, 24 Aug 2023 12:58:53 -0400
X-MC-Unique: z2cB3R2PPDmWc3PD1CgTFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39AE0101A528;
 Thu, 24 Aug 2023 16:58:53 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CA11140E962;
 Thu, 24 Aug 2023 16:58:52 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PULL 6/8] block: add subcluster_size field to BlockDriverInfo
Date: Thu, 24 Aug 2023 12:58:31 -0400
Message-ID: <20230824165833.1689137-7-stefanha@redhat.com>
In-Reply-To: <20230824165833.1689137-1-stefanha@redhat.com>
References: <20230824165833.1689137-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Andrey Drobyshev via <qemu-devel@nongnu.org>

This is going to be used in the subsequent commit as requests alignment
(in particular, during copy-on-read).  This value only makes sense for
the formats which support subclusters (currently QCOW2 only).  If this
field isn't set by driver's own bdrv_get_info() implementation, we
simply set it equal to the cluster size thus treating each cluster as
having a single subcluster.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230711172553.234055-2-andrey.drobyshev@virtuozzo.com>
---
 include/block/block-common.h | 5 +++++
 block.c                      | 7 +++++++
 block/qcow2.c                | 1 +
 3 files changed, 13 insertions(+)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index e15395f2cb..df5ffc8d09 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -132,6 +132,11 @@ typedef struct BlockZoneWps {
 typedef struct BlockDriverInfo {
     /* in bytes, 0 if irrelevant */
     int cluster_size;
+    /*
+     * A fraction of cluster_size, if supported (currently QCOW2 only); if
+     * disabled or unsupported, set equal to cluster_size.
+     */
+    int subcluster_size;
     /* offset at which the VM state can be saved (0 if not possible) */
     int64_t vm_state_offset;
     bool is_dirty;
diff --git a/block.c b/block.c
index a307c151a8..0af890f647 100644
--- a/block.c
+++ b/block.c
@@ -6480,6 +6480,13 @@ int coroutine_fn bdrv_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     }
     memset(bdi, 0, sizeof(*bdi));
     ret = drv->bdrv_co_get_info(bs, bdi);
+    if (bdi->subcluster_size == 0) {
+        /*
+         * If the driver left this unset, subclusters are not supported.
+         * Then it is safe to treat each cluster as having only one subcluster.
+         */
+        bdi->subcluster_size = bdi->cluster_size;
+    }
     if (ret < 0) {
         return ret;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index c51388e99d..b48cd9ce63 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5197,6 +5197,7 @@ qcow2_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
 {
     BDRVQcow2State *s = bs->opaque;
     bdi->cluster_size = s->cluster_size;
+    bdi->subcluster_size = s->subcluster_size;
     bdi->vm_state_offset = qcow2_vm_state_offset(s);
     bdi->is_dirty = s->incompatible_features & QCOW2_INCOMPAT_DIRTY;
     return 0;
-- 
2.41.0


