Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE078D5A7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:50:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJhv-0003Rb-5s; Wed, 30 Aug 2023 07:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhs-0003PA-Dj
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:49:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qbJhp-0003gI-W0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693396193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gKxF0jpSy2jpgUjoIwkX9hfmhlsS/bKIAWxJtzJQZrE=;
 b=PdNrFSBrg7LahcneNdzj5Q/pj/5kWXQhVcbpv1vHW+HGwwH7vbjz9AtyyYlk4HszLdMtYw
 uV8TqZwoSmjbRX29Rx1wLrqZ+cR6FmLgsF5NSUedTnXrMoYVoV7G3SyqiIecAX2VcZXlsH
 /ilFH9YcY/pcDlaUHPW0rHBlcwdS1WU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-E06kURzINPOnAd1oidh3hQ-1; Wed, 30 Aug 2023 07:49:50 -0400
X-MC-Unique: E06kURzINPOnAd1oidh3hQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6F71A280D588;
 Wed, 30 Aug 2023 11:49:49 +0000 (UTC)
Received: from localhost (unknown [10.39.193.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74A1540C6F4C;
 Wed, 30 Aug 2023 11:49:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PULL v3 2/5] block: add subcluster_size field to BlockDriverInfo
Date: Wed, 30 Aug 2023 07:49:39 -0400
Message-ID: <20230830114942.449060-3-stefanha@redhat.com>
In-Reply-To: <20230830114942.449060-1-stefanha@redhat.com>
References: <20230830114942.449060-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

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


