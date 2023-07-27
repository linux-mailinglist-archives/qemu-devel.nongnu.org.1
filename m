Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302FE765D09
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7BG-0000qf-3g; Thu, 27 Jul 2023 16:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Az-0000jM-J4
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Ax-0002lj-RU
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hz9W4uu3OMb54XF8JKznaOXgNmLIjjW6sqlVLyyADKY=;
 b=IrOyRLmGCyHA0/ZaAlUMHxnfqJXa/l4ou9HIF/Kyhj3wBvMU47MTekXTC8nZCpzfgz8U6a
 cuoI5fghYs8TbGyel4g61Fptin37TYkW0gUfM4Z2d2xM8FNnIxYikmubrI5cbITkQBdIAg
 97vB9PPEMAe6VobsNip+aza2YzlBqZk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-VbPgJ9CWNaGnMVgbk2PYTA-1; Thu, 27 Jul 2023 16:01:27 -0400
X-MC-Unique: VbPgJ9CWNaGnMVgbk2PYTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFC54856F67;
 Thu, 27 Jul 2023 20:01:25 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3528C1121330;
 Thu, 27 Jul 2023 20:01:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Qing Wang <qinwang@redhat.com>
Subject: [PULL for-8.1 7/8] block/blkio: fall back on using `path` when `fd`
 setting fails
Date: Thu, 27 Jul 2023 16:00:57 -0400
Message-ID: <20230727200058.1071776-8-stefanha@redhat.com>
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

qemu_open() fails if called with an unix domain socket in this way:
    -blockdev node-name=drive0,driver=virtio-blk-vhost-user,path=vhost-user-blk.sock,cache.direct=on: Could not open 'vhost-user-blk.sock': No such device or address

Since virtio-blk-vhost-user does not support fd passing, let`s always fall back
on using `path` if we fail the fd passing.

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Reported-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230727161020.84213-4-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 60d2d0f129..72b46d61fd 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -711,19 +711,19 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
          * In order to open the device read-only, we are using the `read-only`
          * property of the libblkio driver in blkio_file_open().
          */
-        fd = qemu_open(path, O_RDWR, errp);
+        fd = qemu_open(path, O_RDWR, NULL);
         if (fd < 0) {
-            return -EINVAL;
+            fd_supported = false;
+        } else {
+            ret = blkio_set_int(s->blkio, "fd", fd);
+            if (ret < 0) {
+                fd_supported = false;
+                qemu_close(fd);
+            }
         }
+    }
 
-        ret = blkio_set_int(s->blkio, "fd", fd);
-        if (ret < 0) {
-            error_setg_errno(errp, -ret, "failed to set fd: %s",
-                             blkio_get_error_msg());
-            qemu_close(fd);
-            return ret;
-        }
-    } else {
+    if (!fd_supported) {
         ret = blkio_set_str(s->blkio, "path", path);
         if (ret < 0) {
             error_setg_errno(errp, -ret, "failed to set path: %s",
-- 
2.41.0


