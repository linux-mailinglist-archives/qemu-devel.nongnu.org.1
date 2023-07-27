Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6E0765D51
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 22:27:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP7B1-0000fZ-1c; Thu, 27 Jul 2023 16:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Ag-0000ez-8l
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qP7Ae-0002ie-IQ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 16:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690488071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBxH1iRanqco3HtF82nh9FMyY8AR3YyxU+2pBdaif24=;
 b=KjBFYZPPaxHjTzAmFduMurtJEC1wSZiJD5Lq+NU8kmWQE/lSaWnqCUHALd9J783y+Qoe+h
 Q2IyEydltL8DgU2o/V7v7u8nLY75/YngYES6QMaxtadG40mO+rNDit/hqscE+wwC5Q/D9h
 4XjjOoAcrPgQGu5XpMac5aWo663byz8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-f5ICcI7kMFG2uOf07W61wg-1; Thu, 27 Jul 2023 16:01:08 -0400
X-MC-Unique: f5ICcI7kMFG2uOf07W61wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9C5938149B8;
 Thu, 27 Jul 2023 20:01:06 +0000 (UTC)
Received: from localhost (unknown [10.39.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE2C2C57964;
 Thu, 27 Jul 2023 20:01:05 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Qing Wang <qinwang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL for-8.1 2/8] block/blkio: do not use open flags in qemu_open()
Date: Thu, 27 Jul 2023 16:00:52 -0400
Message-ID: <20230727200058.1071776-3-stefanha@redhat.com>
In-Reply-To: <20230727200058.1071776-1-stefanha@redhat.com>
References: <20230727200058.1071776-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

qemu_open() in blkio_virtio_blk_common_open() is used to open the
character device (e.g. /dev/vhost-vdpa-0 or /dev/vfio/vfio) or in
the future eventually the unix socket.

In all these cases we cannot open the path in read-only mode,
when the `read-only` option of blockdev is on, because the exchange
of IOCTL commands for example will fail.

In order to open the device read-only, we have to use the `read-only`
property of the libblkio driver as we already do in blkio_file_open().

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2225439
Reported-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230726074807.14041-1-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index bc1fac48b7..7eb1b94820 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -686,15 +686,18 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
      * layer through the "/dev/fdset/N" special path.
      */
     if (fd_supported) {
-        int open_flags;
-
-        if (flags & BDRV_O_RDWR) {
-            open_flags = O_RDWR;
-        } else {
-            open_flags = O_RDONLY;
-        }
-
-        fd = qemu_open(path, open_flags, errp);
+        /*
+         * `path` can contain the path of a character device
+         * (e.g. /dev/vhost-vdpa-0 or /dev/vfio/vfio) or a unix socket.
+         *
+         * So, we should always open it with O_RDWR flag, also if BDRV_O_RDWR
+         * is not set in the open flags, because the exchange of IOCTL commands
+         * for example will fail.
+         *
+         * In order to open the device read-only, we are using the `read-only`
+         * property of the libblkio driver in blkio_file_open().
+         */
+        fd = qemu_open(path, O_RDWR, errp);
         if (fd < 0) {
             return -EINVAL;
         }
-- 
2.41.0


