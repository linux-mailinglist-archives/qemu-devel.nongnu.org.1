Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F94765D7E
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7BF-0000qS-Os; Thu, 27 Jul 2023 16:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Au-0000gO-5z
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7As-0002kb-8V
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3+AAufHnWErj5VG+DPHAeiau76Tcpt2M705gGpBbEk=;
 b=Ems8JvefWOlxz2TXiBHKcvO7eyDswXix+kkume3eUx1yjRNSvVbeF4nmrr7wTaHx0NI2/p
 MApa1GE7zH4rs4yALsdg6m98reGU5OslkGZaMSeRI10CVbj8jVC73DndWnLbZnoxjWVJWn
 EcGgV/6I/l190elKttKJk9rQAAD5Atg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-102-mwJ4Yi3BP4et9knOizb37Q-1; Thu, 27 Jul 2023 16:01:21 -0400
X-MC-Unique: mwJ4Yi3BP4et9knOizb37Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9819180027F;
 Thu, 27 Jul 2023 20:01:20 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F28391121330;
 Thu, 27 Jul 2023 20:01:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL for-8.1 5/8] block/blkio: move blkio_connect() in the drivers
 functions
Date: Thu, 27 Jul 2023 16:00:55 -0400
Message-ID: <20230727200058.1071776-6-stefanha@redhat.com>
In-Reply-To: <20230727200058.1071776-1-stefanha@redhat.com>
References: <20230727200058.1071776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

From: Stefano Garzarella <sgarzare@redhat.com>

This is in preparation for the next patch, where for virtio-blk
drivers we need to handle the failure of blkio_connect().

Let's also rename the *_open() functions to *_connect() to make
the code reflect the changes applied.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230727161020.84213-2-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 71 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 7eb1b94820..8ad7c0b575 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -603,8 +603,8 @@ static void blkio_unregister_buf(BlockDriverState *bs, void *host, size_t size)
     }
 }
 
-static int blkio_io_uring_open(BlockDriverState *bs, QDict *options, int flags,
-                               Error **errp)
+static int blkio_io_uring_connect(BlockDriverState *bs, QDict *options,
+                                  int flags, Error **errp)
 {
     const char *filename = qdict_get_str(options, "filename");
     BDRVBlkioState *s = bs->opaque;
@@ -627,11 +627,18 @@ static int blkio_io_uring_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
+    ret = blkio_connect(s->blkio);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "blkio_connect failed: %s",
+                         blkio_get_error_msg());
+        return ret;
+    }
+
     return 0;
 }
 
-static int blkio_nvme_io_uring(BlockDriverState *bs, QDict *options, int flags,
-                               Error **errp)
+static int blkio_nvme_io_uring_connect(BlockDriverState *bs, QDict *options,
+                                       int flags, Error **errp)
 {
     const char *path = qdict_get_try_str(options, "path");
     BDRVBlkioState *s = bs->opaque;
@@ -655,11 +662,18 @@ static int blkio_nvme_io_uring(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
+    ret = blkio_connect(s->blkio);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "blkio_connect failed: %s",
+                         blkio_get_error_msg());
+        return ret;
+    }
+
     return 0;
 }
 
-static int blkio_virtio_blk_common_open(BlockDriverState *bs,
-        QDict *options, int flags, Error **errp)
+static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
+                                    int flags, Error **errp)
 {
     const char *path = qdict_get_try_str(options, "path");
     BDRVBlkioState *s = bs->opaque;
@@ -718,6 +732,13 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
         }
     }
 
+    ret = blkio_connect(s->blkio);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "blkio_connect failed: %s",
+                         blkio_get_error_msg());
+        return ret;
+    }
+
     qdict_del(options, "path");
 
     return 0;
@@ -737,16 +758,26 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    if (!(flags & BDRV_O_RDWR)) {
+        ret = blkio_set_bool(s->blkio, "read-only", true);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set read-only: %s",
+                             blkio_get_error_msg());
+            blkio_destroy(&s->blkio);
+            return ret;
+        }
+    }
+
     if (strcmp(blkio_driver, "io_uring") == 0) {
-        ret = blkio_io_uring_open(bs, options, flags, errp);
+        ret = blkio_io_uring_connect(bs, options, flags, errp);
     } else if (strcmp(blkio_driver, "nvme-io_uring") == 0) {
-        ret = blkio_nvme_io_uring(bs, options, flags, errp);
+        ret = blkio_nvme_io_uring_connect(bs, options, flags, errp);
     } else if (strcmp(blkio_driver, "virtio-blk-vfio-pci") == 0) {
-        ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
+        ret = blkio_virtio_blk_connect(bs, options, flags, errp);
     } else if (strcmp(blkio_driver, "virtio-blk-vhost-user") == 0) {
-        ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
+        ret = blkio_virtio_blk_connect(bs, options, flags, errp);
     } else if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0) {
-        ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
+        ret = blkio_virtio_blk_connect(bs, options, flags, errp);
     } else {
         g_assert_not_reached();
     }
@@ -755,24 +786,6 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    if (!(flags & BDRV_O_RDWR)) {
-        ret = blkio_set_bool(s->blkio, "read-only", true);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "failed to set read-only: %s",
-                             blkio_get_error_msg());
-            blkio_destroy(&s->blkio);
-            return ret;
-        }
-    }
-
-    ret = blkio_connect(s->blkio);
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "blkio_connect failed: %s",
-                         blkio_get_error_msg());
-        blkio_destroy(&s->blkio);
-        return ret;
-    }
-
     ret = blkio_get_bool(s->blkio,
                          "needs-mem-regions",
                          &s->needs_mem_regions);
-- 
2.41.0


