Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E862276E322
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 10:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRThH-0005vG-5X; Thu, 03 Aug 2023 04:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRThF-0005t2-61
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRThD-0007qf-P2
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691051314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yR04ak6EpRTzBzWjBrh7Bwe/4mz3xwmXIHbNOJbbDLM=;
 b=HC1wHNpV81RPC2E7/1yiDDm+JrE2YM63hhS2THvMT3r+Y+CtzFznvFPQ0kdHYBctnCrbIk
 b84+qBgGmCocFhnt+4BT/2OAGH3FbGG3kTJNG2mLQomFgfNBjZQXzHWRV0KB27vLzLRlG8
 975sXvl7iRL8EZTsvKArfuAGosslKeY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-X4pboDjuM3mGMw7jXCuyWA-1; Thu, 03 Aug 2023 04:28:33 -0400
X-MC-Unique: X4pboDjuM3mGMw7jXCuyWA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bfe6a531bso85243166b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 01:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691051312; x=1691656112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yR04ak6EpRTzBzWjBrh7Bwe/4mz3xwmXIHbNOJbbDLM=;
 b=StoNU6jDkTtyHZ10Ki+mixt9woy0pwbtco7kppjXH+U2je//QdpJx16km8MMjnSig4
 WNugZ1hz6Uc2AnS/yHkxmU/72tDCsKjRuLD0hI1h6wkT8v/FU9uGOY1xmSWF1JtornA/
 MDcttK1i0kSzhBhCpr5K4tFyZlDsNndu4oYpkZPGS+K+0Q81wof17R8ibP+B8y7zEiVO
 4d41cPx4byuLC9rADemW1FlgMu6+q/0M/uKsofpUqg1o/icNOegEjLOmI14DFVlFi7EY
 KdsBjkbF7fet7kyZPIitrpElkB7G34OHa4hhAu+rAVmbn99BefS7uEmPX29HSWdSxZOh
 EH5Q==
X-Gm-Message-State: ABy/qLYkGcociferSE4UWosGuoNXKaTFnwmJtuvQgWtnDpQeIobIvg/c
 Z4ZQ8Y1OZEkca+Ogq5HIBF/4zISYzIGLLGIliSLg+et7/3i2vxWQUFIIC+7H0huRDA+iTC3BBOW
 ZHSpGObW452zm3CdXk5ddI5fkQvUN2CcJgco8b9HD2oZaBqOieZH6Vx+yxHUM74GMyTlp/i+Dgf
 E=
X-Received: by 2002:a17:906:7389:b0:99b:4bab:2838 with SMTP id
 f9-20020a170906738900b0099b4bab2838mr7155513ejl.0.1691051312298; 
 Thu, 03 Aug 2023 01:28:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGmhOLvW23SjK5Qx0lfsu8Z9VF5vgwAaZTgTqOekffdxDSJT5V1sN8ayydvH6Ys0HEFcHbYkg==
X-Received: by 2002:a17:906:7389:b0:99b:4bab:2838 with SMTP id
 f9-20020a170906738900b0099b4bab2838mr7155468ejl.0.1691051311111; 
 Thu, 03 Aug 2023 01:28:31 -0700 (PDT)
Received: from step1.home (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 qp3-20020a170907206300b00991e2b5a27dsm10233139ejb.37.2023.08.03.01.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 01:28:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 1/2] block/blkio: close the fd when blkio_connect() fails
Date: Thu,  3 Aug 2023 10:28:24 +0200
Message-ID: <20230803082825.25293-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803082825.25293-1-sgarzare@redhat.com>
References: <20230803082825.25293-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

libblkio drivers take ownership of `fd` only after a successful
blkio_connect(), so if it fails, we are still the owners.

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v2:
    - avoid to use `fd_supported` to track a valid fd [Hanna]

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


