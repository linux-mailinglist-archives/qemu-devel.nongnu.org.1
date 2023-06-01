Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222371A3C6
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kC9-0004bZ-La; Thu, 01 Jun 2023 11:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4kC7-0004ah-FK
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4kBr-0003VB-GT
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685633173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2jIiSec093zxYLQEOwE5JssP3b16O/dNh3vcZRftBM=;
 b=D5SvOMUkQYxtKKuoo7d8aPj1lek+3p1KfQlEkt5E3FSWFl3luku9Mtw9Q/NLYnfOBESB/D
 HsOcGe2Bp/EYNwpf1dDt4Eb28xn4OkWr0JaG2a0UXOOYSDqlPpoGlgtKwX8pR9XTNItigK
 nDU2gQurIdbJSFMCw2jBbbx2fwG4oFI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-uDT_KEXNMA2D1W8fWckpaA-1; Thu, 01 Jun 2023 11:26:10 -0400
X-MC-Unique: uDT_KEXNMA2D1W8fWckpaA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B4333823A15;
 Thu,  1 Jun 2023 15:26:09 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8F5A112132C;
 Thu,  1 Jun 2023 15:26:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, Thomas Huth <thuth@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, kvm@vger.kernel.org
Subject: [PULL 7/8] block/blkio: use qemu_open() to support fd passing for
 virtio-blk
Date: Thu,  1 Jun 2023 11:25:51 -0400
Message-Id: <20230601152552.1603119-8-stefanha@redhat.com>
In-Reply-To: <20230601152552.1603119-1-stefanha@redhat.com>
References: <20230601152552.1603119-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefano Garzarella <sgarzare@redhat.com>

Some virtio-blk drivers (e.g. virtio-blk-vhost-vdpa) supports the fd
passing. Let's expose this to the user, so the management layer
can pass the file descriptor of an already opened path.

If the libblkio virtio-blk driver supports fd passing, let's always
use qemu_open() to open the `path`, so we can handle fd passing
from the management layer through the "/dev/fdset/N" special path.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-id: 20230530071941.8954-2-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 53 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 11be8787a3..527323d625 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -673,25 +673,60 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
 {
     const char *path = qdict_get_try_str(options, "path");
     BDRVBlkioState *s = bs->opaque;
-    int ret;
+    bool fd_supported = false;
+    int fd, ret;
 
     if (!path) {
         error_setg(errp, "missing 'path' option");
         return -EINVAL;
     }
 
-    ret = blkio_set_str(s->blkio, "path", path);
-    qdict_del(options, "path");
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "failed to set path: %s",
-                         blkio_get_error_msg());
-        return ret;
-    }
-
     if (!(flags & BDRV_O_NOCACHE)) {
         error_setg(errp, "cache.direct=off is not supported");
         return -EINVAL;
     }
+
+    if (blkio_get_int(s->blkio, "fd", &fd) == 0) {
+        fd_supported = true;
+    }
+
+    /*
+     * If the libblkio driver supports fd passing, let's always use qemu_open()
+     * to open the `path`, so we can handle fd passing from the management
+     * layer through the "/dev/fdset/N" special path.
+     */
+    if (fd_supported) {
+        int open_flags;
+
+        if (flags & BDRV_O_RDWR) {
+            open_flags = O_RDWR;
+        } else {
+            open_flags = O_RDONLY;
+        }
+
+        fd = qemu_open(path, open_flags, errp);
+        if (fd < 0) {
+            return -EINVAL;
+        }
+
+        ret = blkio_set_int(s->blkio, "fd", fd);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set fd: %s",
+                             blkio_get_error_msg());
+            qemu_close(fd);
+            return ret;
+        }
+    } else {
+        ret = blkio_set_str(s->blkio, "path", path);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "failed to set path: %s",
+                             blkio_get_error_msg());
+            return ret;
+        }
+    }
+
+    qdict_del(options, "path");
+
     return 0;
 }
 
-- 
2.40.1


