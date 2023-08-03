Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BC976E320
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 10:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRThJ-00063z-W5; Thu, 03 Aug 2023 04:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRThI-00063l-Km
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qRThH-0007rN-2G
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 04:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691051318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQj+RyBDUao2ZglCFKibOMg+XHj0z4ipB9ZybK94U/U=;
 b=CrWGVkTmiVtVUm0iIDjP4bOGsy7Wc+KxHQPwDieYzBM3v3c5J49pvF0/TUgv01v4TZlD2G
 SOfDVoVYFYL/HON9BWTVEBHKcm2wtNax9YEWxjE3H23E174uE62c/ZrrMqwcT/8FBxmoas
 HxK4AAD7vE8DWUsjS0Rwy9Y7axkgLM4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-FO3bK_nCO7GklkK4p_gtLw-1; Thu, 03 Aug 2023 04:28:37 -0400
X-MC-Unique: FO3bK_nCO7GklkK4p_gtLw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-52256d84ab1so475483a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 01:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691051316; x=1691656116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AQj+RyBDUao2ZglCFKibOMg+XHj0z4ipB9ZybK94U/U=;
 b=iM+GFhPYqiQmN/5WJ6165jRM6yFVbIDI+d4yuECCuyOCutg6ZCIFTK1GpV3KQCSaNm
 2nOZ6VTbCYix/xZauuvhF0Jts1vWLfl2nicPffOmGzfNu8WauDxB9eJFHlcvH8zeUp9y
 nsSsI3Xfp5UoeChM2qgNPlA0sA37fkCjX3qU1J9b5fOwI8GpENTMPnZFxez9gCD2dTp9
 1gGBFLRbKS4W8zwaCpqSf9IetewQDwgj0I6B3iHDbvtkn9zPRqGLq2tvdsyvAIjTp+Tk
 59LFrCaNW4TKeY4sAVnkA/glfByoaNN/RTi2KxxQTRZkbPedfP1vcRJDIkIZxMaZfwNN
 Jo7Q==
X-Gm-Message-State: ABy/qLYPJsZhppna/Ydzokj5XPWOHnA2YdsWKZk12i1epa3dVSz8nRBE
 eLlpvU2LwDJjWIxyj9Q4ibje/afI7Br8mhJ1K2E1b98babgn7sfsb1xthtiguvYDbS1WxzMVxIe
 +23uVZ7GT3CCtl7YfcuaWzFQaBjX6KzJPMPJ25/vWloqhMQTjrUfPcJMJeOdITnoQnv/KMqiiGi
 U=
X-Received: by 2002:a05:6402:1646:b0:522:3149:1596 with SMTP id
 s6-20020a056402164600b0052231491596mr6962671edx.13.1691051316145; 
 Thu, 03 Aug 2023 01:28:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWh3qtl3XHmIwpWDD9YOjicU/DDblWuL0UCNpZO9R2yZXCjgLJvwIDXirVUSfNVEdNT7gV+w==
X-Received: by 2002:a05:6402:1646:b0:522:3149:1596 with SMTP id
 s6-20020a056402164600b0052231491596mr6962659edx.13.1691051315962; 
 Thu, 03 Aug 2023 01:28:35 -0700 (PDT)
Received: from step1.home (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 v26-20020aa7d65a000000b0051e0be09297sm9774601edr.53.2023.08.03.01.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 01:28:35 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 2/2] block/blkio: add more comments on the fd passing
 handling
Date: Thu,  3 Aug 2023 10:28:25 +0200
Message-ID: <20230803082825.25293-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803082825.25293-1-sgarzare@redhat.com>
References: <20230803082825.25293-1-sgarzare@redhat.com>
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

As Hanna pointed out, it is not clear in the code why qemu_open()
can fail, and why blkio_set_int("fd") is not enough to discover
the `fd` property support.

Let's fix them by adding more details in the code comments.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index baba2f0b67..1dd495617c 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -713,6 +713,12 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
          */
         fd = qemu_open(path, O_RDWR, NULL);
         if (fd < 0) {
+            /*
+             * qemu_open() can fail if the user specifies a path that is not
+             * a file or device, for example in the case of Unix Domain Socket
+             * for the virtio-blk-vhost-user driver. In such cases let's have
+             * libblkio open the path directly.
+             */
             fd_supported = false;
         } else {
             ret = blkio_set_int(s->blkio, "fd", fd);
@@ -741,9 +747,12 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
     }
 
     /*
-     * If the libblkio driver doesn't support the `fd` property, blkio_connect()
-     * will fail with -EINVAL. So let's try calling blkio_connect() again by
-     * directly setting `path`.
+     * Before https://gitlab.com/libblkio/libblkio/-/merge_requests/208
+     * (libblkio <= v1.3.0), setting the `fd` property is not enough to check
+     * whether the driver supports the `fd` property or not. In that case,
+     * blkio_connect() will fail with -EINVAL.
+     * So let's try calling blkio_connect() again by directly setting `path`
+     * to cover this scenario.
      */
     if (fd_supported && ret == -EINVAL) {
         /*
-- 
2.41.0


