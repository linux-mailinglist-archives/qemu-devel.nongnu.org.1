Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9783765961
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3Zj-0008MY-AI; Thu, 27 Jul 2023 12:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3Ze-0008M8-Az
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3Zc-0003TG-OF
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690474244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jqeG9yHjAZRo995Zo9p4ae7SEMnzY0vCfyw0QCThnX8=;
 b=SJwcR+azxck1eSpZEmT+KXcbhfoMKFLitdMsa0C2OyGzixBS642yB1koM9nnRbGyvfSuhV
 ZlMgS/En0qvi+bOG6xN+1FJTnB2mSDQ1tZPtR+dfeyUMG2qXvIRRe/vI9emlt/4xslK7R+
 fK6+NMePL1PsUKDoXVqgO0GsLNB1GR4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-teRgy_WiOFOyIslLN3p2pg-1; Thu, 27 Jul 2023 12:10:42 -0400
X-MC-Unique: teRgy_WiOFOyIslLN3p2pg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so672501f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474241; x=1691079041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqeG9yHjAZRo995Zo9p4ae7SEMnzY0vCfyw0QCThnX8=;
 b=ZkZHpvqqmC7BJMsiF3cIqFdI2d4afeiu44W6xkfcfwGBmAA0iWExpBEU4GJp3MqdYy
 pP/hpggdBtQEjEPAwSnl/UvE28swJjI9bwqkOnqAx2TytrXhaAGn7q6ynWqvZpxjJRKx
 1NoJetv9ve/gbGEqgOclhlAQA34NPfbXu2e9uwoEhkpS2VP33DESN7jeEYu0GysxwG29
 DErSFzfMRN7baCz7+tHlrDrbQne1Ay8kwiMMWyNkM04FmY/6xqCq00U66M93vPIdF/jS
 oj095S9rNCy6plf0IyGwZ87f1Bhl5f/w6C1Dx7gpY5gWMG3O382klTg7uZa5beOKNJMe
 vQgw==
X-Gm-Message-State: ABy/qLbpU+pm9YmXRUxbmNhuVbOaO5Dhif2mUYNEwodSUt5i4H0Tvrbb
 8Lqs6otowPLxTPPEZsOLeDhOoC94RP7dQkbuTFXBDs211SfEVVApmpPq1nxjjLrvQdnIP7/r/7S
 WdxcmMw9riA+v4sP7gXbfA0it1h1rb4G7Xk3DGuCX6sR7xfTM7sK9krq0vGbqfILGlN4rlNMKnX
 M=
X-Received: by 2002:adf:dec1:0:b0:317:61af:d64a with SMTP id
 i1-20020adfdec1000000b0031761afd64amr2413232wrn.3.1690474241094; 
 Thu, 27 Jul 2023 09:10:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH9KkPEhif4cJq6kfNeGpkr0ct4rzMdspxy9Y6mMBPUlpPW+fLwETRRSybkO122bqRP5Q9dEg==
X-Received: by 2002:adf:dec1:0:b0:317:61af:d64a with SMTP id
 i1-20020adfdec1000000b0031761afd64amr2413202wrn.3.1690474240724; 
 Thu, 27 Jul 2023 09:10:40 -0700 (PDT)
Received: from step1.redhat.com ([193.207.170.163])
 by smtp.gmail.com with ESMTPSA id
 h16-20020adffa90000000b0031423a8f4f7sm2427734wrr.56.2023.07.27.09.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:10:40 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 1/4] block/blkio: move blkio_connect() in the drivers
 functions
Date: Thu, 27 Jul 2023 18:10:17 +0200
Message-ID: <20230727161020.84213-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727161020.84213-1-sgarzare@redhat.com>
References: <20230727161020.84213-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

This is in preparation for the next patch, where for virtio-blk
drivers we need to handle the failure of blkio_connect().

Let's also rename the *_open() functions to *_connect() to make
the code reflect the changes applied.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 67 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

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
@@ -737,24 +758,6 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    if (strcmp(blkio_driver, "io_uring") == 0) {
-        ret = blkio_io_uring_open(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, "nvme-io_uring") == 0) {
-        ret = blkio_nvme_io_uring(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, "virtio-blk-vfio-pci") == 0) {
-        ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, "virtio-blk-vhost-user") == 0) {
-        ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0) {
-        ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
-    } else {
-        g_assert_not_reached();
-    }
-    if (ret < 0) {
-        blkio_destroy(&s->blkio);
-        return ret;
-    }
-
     if (!(flags & BDRV_O_RDWR)) {
         ret = blkio_set_bool(s->blkio, "read-only", true);
         if (ret < 0) {
@@ -765,10 +768,20 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    ret = blkio_connect(s->blkio);
+    if (strcmp(blkio_driver, "io_uring") == 0) {
+        ret = blkio_io_uring_connect(bs, options, flags, errp);
+    } else if (strcmp(blkio_driver, "nvme-io_uring") == 0) {
+        ret = blkio_nvme_io_uring_connect(bs, options, flags, errp);
+    } else if (strcmp(blkio_driver, "virtio-blk-vfio-pci") == 0) {
+        ret = blkio_virtio_blk_connect(bs, options, flags, errp);
+    } else if (strcmp(blkio_driver, "virtio-blk-vhost-user") == 0) {
+        ret = blkio_virtio_blk_connect(bs, options, flags, errp);
+    } else if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0) {
+        ret = blkio_virtio_blk_connect(bs, options, flags, errp);
+    } else {
+        g_assert_not_reached();
+    }
     if (ret < 0) {
-        error_setg_errno(errp, -ret, "blkio_connect failed: %s",
-                         blkio_get_error_msg());
         blkio_destroy(&s->blkio);
         return ret;
     }
-- 
2.41.0


