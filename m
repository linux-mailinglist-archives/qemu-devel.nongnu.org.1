Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 057157658ED
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:40:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3Zz-0008Vg-6H; Thu, 27 Jul 2023 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3Zx-0008Us-1o
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3Zv-0003Yc-Jj
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690474262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yY0mIuMY/oj77dWAV1QfGssmJeEQkLaFlBf8TdE2K+M=;
 b=aG0IYRoXraA+bGH83WALePznYhJpOEiydpYQAlV8Q+wLXqFtgzqHQ+CaHZx68ZhYIFL+pr
 ByXSfQcBz/R227/Db+pytfQCdJ1bnu/SSfFUlN5UxWPLDzL18xMpbt3AZH+hoVhO/W4Fdn
 eg3zchsW/yuEmc5PWuM3fZy4cDgTAM4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-VFvo0EXqN2mfXTXAqP0lWQ-1; Thu, 27 Jul 2023 12:11:00 -0400
X-MC-Unique: VFvo0EXqN2mfXTXAqP0lWQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbb0fdd060so6869375e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474259; x=1691079059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yY0mIuMY/oj77dWAV1QfGssmJeEQkLaFlBf8TdE2K+M=;
 b=SBcWWjq9wnn0TPCAAvH4dm/JQuWcgUp5SHjvw5Ktdhtbd805WwsXPC8RKTar8Kf1YC
 jSodOoaN28Qxk2uJJnPOflNHMjA5TAbMf8UfCT2qyoEvZZ7CyvYK3j6f1qi5ukLMZBrM
 Sxlk549w7dmnJE2xTqiWuq4K/AkMkG5J/LRfz6xzsZdBlCK/4yDblSfSnY7a/AQIpnTR
 wq4s6oOBrFirdx4l92fZWFYZhZNm/rNcwTzY7DcFtMYzLnWZvHEEh3khLFiPp+waJmIj
 Uf6QF5iSuQEWpuiqQdafcC7uiDTu2kemHSX9PrpmsHHmCSBlQfj+lsyyW4ZVAu9vJ0C8
 zJaA==
X-Gm-Message-State: ABy/qLaJuT5biIXMqAEUzZZP55fnVsllXi3A2eic0M6c0mZaf+VSYKtc
 Kctcuxhb6xlkQnwb2UjOUlsEHh8P+li/K81g08o/yWz/M+jSfrzrMABY3/uxAx4jHKTAtcr8jM8
 Vjcf331dkqKpBvEe7IkYNbjgGNmcBDa36rD8oeeyR6b+gmtCKrtxav2/TzSZsCLYx6vr7L0rvuR
 E=
X-Received: by 2002:a5d:690d:0:b0:314:a3f:9c08 with SMTP id
 t13-20020a5d690d000000b003140a3f9c08mr2203670wru.39.1690474259418; 
 Thu, 27 Jul 2023 09:10:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFuOMsUPGVbQByuKZ/t23QPV1F/YF7YWiQ7eS97LOMECuahhGTDBi1e8IGJwqEInBHajgrYwQ==
X-Received: by 2002:a5d:690d:0:b0:314:a3f:9c08 with SMTP id
 t13-20020a5d690d000000b003140a3f9c08mr2203652wru.39.1690474259142; 
 Thu, 27 Jul 2023 09:10:59 -0700 (PDT)
Received: from step1.redhat.com ([193.207.170.163])
 by smtp.gmail.com with ESMTPSA id
 m12-20020adff38c000000b00313f031876esm2459803wro.43.2023.07.27.09.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:10:58 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>, Qing Wang <qinwang@redhat.com>
Subject: [PATCH v2 3/4] block/blkio: fall back on using `path` when `fd`
 setting fails
Date: Thu, 27 Jul 2023 18:10:19 +0200
Message-ID: <20230727161020.84213-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727161020.84213-1-sgarzare@redhat.com>
References: <20230727161020.84213-1-sgarzare@redhat.com>
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

qemu_open() fails if called with an unix domain socket in this way:
    -blockdev node-name=drive0,driver=virtio-blk-vhost-user,path=vhost-user-blk.sock,cache.direct=on: Could not open 'vhost-user-blk.sock': No such device or address

Since virtio-blk-vhost-user does not support fd passing, let`s always fall back
on using `path` if we fail the fd passing.

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Reported-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
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


