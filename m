Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBCD765D81
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:40:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7BF-0000pf-AL; Thu, 27 Jul 2023 16:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7B1-0000l4-Dh
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Ay-0002lp-Pv
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuwXOvKeRHEancDJS8OkcP0iOKy6UX86GAg2J5w7NHE=;
 b=eeWZXL+KqYzp5MpSclWtm6tRvMG9It5j4Yoxp0LSzx87AUzccLq1wnjjI05BClHuri91a8
 i6CQl4CeVGOJ3ryH57hA+LkHgFHo3UWkXfob4s1ivCA9r7DPyyaXd8ORGToJSoyXofaR/A
 BUzh1WOB30NhXxMYIEwKOomOH8PDNLw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-tXjbP1HXPpekAzV8j3GmDA-1; Thu, 27 Jul 2023 16:01:24 -0400
X-MC-Unique: tXjbP1HXPpekAzV8j3GmDA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62FDA185A7A3;
 Thu, 27 Jul 2023 20:01:23 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB32B492B02;
 Thu, 27 Jul 2023 20:01:22 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL for-8.1 6/8] block/blkio: retry blkio_connect() if it fails
 using `fd`
Date: Thu, 27 Jul 2023 16:00:56 -0400
Message-ID: <20230727200058.1071776-7-stefanha@redhat.com>
In-Reply-To: <20230727200058.1071776-1-stefanha@redhat.com>
References: <20230727200058.1071776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

libblkio 1.3.0 added support of "fd" property for virtio-blk-vhost-vdpa
driver. In QEMU, starting from commit cad2ccc395 ("block/blkio: use
qemu_open() to support fd passing for virtio-blk") we are using
`blkio_get_int(..., "fd")` to check if the "fd" property is supported
for all the virtio-blk-* driver.

Unfortunately that property is also available for those driver that do
not support it, such as virtio-blk-vhost-user.

So, `blkio_get_int()` is not enough to check whether the driver supports
the `fd` property or not. This is because the virito-blk common libblkio
driver only checks whether or not `fd` is set during `blkio_connect()`
and fails with -EINVAL for those transports that do not support it
(all except vhost-vdpa for now).

So let's handle the `blkio_connect()` failure, retrying it using `path`
directly.

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230727161020.84213-3-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/block/blkio.c b/block/blkio.c
index 8ad7c0b575..60d2d0f129 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -733,6 +733,35 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
     }
 
     ret = blkio_connect(s->blkio);
+    /*
+     * If the libblkio driver doesn't support the `fd` property, blkio_connect()
+     * will fail with -EINVAL. So let's try calling blkio_connect() again by
+     * directly setting `path`.
+     */
+    if (fd_supported && ret == -EINVAL) {
+        qemu_close(fd);
+
+        /*
+         * We need to clear the `fd` property we set previously by setting
+         * it to -1.
+         */
+        ret = blkio_set_int(s->blkio, "fd", -1);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set fd: %s",
+                             blkio_get_error_msg());
+            return ret;
+        }
+
+        ret = blkio_set_str(s->blkio, "path", path);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set path: %s",
+                             blkio_get_error_msg());
+            return ret;
+        }
+
+        ret = blkio_connect(s->blkio);
+    }
+
     if (ret < 0) {
         error_setg_errno(errp, -ret, "blkio_connect failed: %s",
                          blkio_get_error_msg());
-- 
2.41.0


