Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B22276EEC5
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRagG-0006qP-5C; Thu, 03 Aug 2023 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRag8-0006oX-NC
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qRag6-0004oF-Sz
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691078154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0nHXg7Hq0LS6ZaBQRM10/HgF4wbNdZndEcHXItpz8M=;
 b=BaWjY0f/RqI2SZC1qev8fC+GUrVxCn1e+VYDK2j/fcyMMPw48Yc6uQwiOPAELk4Paa5hFu
 wk5guq+VAZ3W1o5Sml0PvjTWORialAx0qR0NCzYAMHc+06MYNsaIgovP9mnsau24SLG+Tb
 5FRmQvoMVhRM6nQ8K9B682+Quy2ypAE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-nFHGfxbPP3mRc9iesPOptA-1; Thu, 03 Aug 2023 11:55:49 -0400
X-MC-Unique: nFHGfxbPP3mRc9iesPOptA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86ACD3C0C4A9;
 Thu,  3 Aug 2023 15:55:49 +0000 (UTC)
Received: from localhost (unknown [10.39.194.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0511D4021C9;
 Thu,  3 Aug 2023 15:55:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL for-8.1 1/2] block/blkio: close the fd when blkio_connect()
 fails
Date: Thu,  3 Aug 2023 11:55:44 -0400
Message-ID: <20230803155545.2349984-2-stefanha@redhat.com>
In-Reply-To: <20230803155545.2349984-1-stefanha@redhat.com>
References: <20230803155545.2349984-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

libblkio drivers take ownership of `fd` only after a successful
blkio_connect(), so if it fails, we are still the owners.

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-id: 20230803082825.25293-2-sgarzare@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 8e7ce42c79..baba2f0b67 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -678,7 +678,7 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
     const char *path = qdict_get_try_str(options, "path");
     BDRVBlkioState *s = bs->opaque;
     bool fd_supported = false;
-    int fd, ret;
+    int fd = -1, ret;
 
     if (!path) {
         error_setg(errp, "missing 'path' option");
@@ -719,6 +719,7 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
             if (ret < 0) {
                 fd_supported = false;
                 qemu_close(fd);
+                fd = -1;
             }
         }
     }
@@ -733,14 +734,18 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
     }
 
     ret = blkio_connect(s->blkio);
+    if (ret < 0 && fd >= 0) {
+        /* Failed to give the FD to libblkio, close it */
+        qemu_close(fd);
+        fd = -1;
+    }
+
     /*
      * If the libblkio driver doesn't support the `fd` property, blkio_connect()
      * will fail with -EINVAL. So let's try calling blkio_connect() again by
      * directly setting `path`.
      */
     if (fd_supported && ret == -EINVAL) {
-        qemu_close(fd);
-
         /*
          * We need to clear the `fd` property we set previously by setting
          * it to -1.
-- 
2.41.0


