Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75327765A21
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3Zr-0008Sz-3I; Thu, 27 Jul 2023 12:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3Zp-0008SF-7n
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3Zn-0003Vg-NO
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690474255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/gg+RbKBeeQMtBE1iLrClo2NCkAFcmUaOrV45LPbjM=;
 b=NmA1lWQpz0LcOI3iXYN3j2sgNa5UcUxMVUuDmXt3Qp5gGicdwqTvHioXnL7Q5GsdyweWU8
 hHAIcRZwBV/EfNRESflS4OhNA27ggO0NN9tLz9zXP20ixUqR0vxxyUmR0JxtVXDEUrshMA
 fyVpEa4ujGngJ4zoucEYvxqcUXYk8j8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-ql7huGlCNkOpR2BfHSZ6RQ-1; Thu, 27 Jul 2023 12:10:51 -0400
X-MC-Unique: ql7huGlCNkOpR2BfHSZ6RQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso606770f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474250; x=1691079050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/gg+RbKBeeQMtBE1iLrClo2NCkAFcmUaOrV45LPbjM=;
 b=NsN5ndWM/qthP5ZCQc5Ws3kQkKNmUF7ps+HMlZwsnYToA8UF5rcnOyQpvU/qSrpNtl
 sFWC4hTesIR3RovMVBcaItA1b+wJxppwYO5S+Cs2biOy4yA4yOShk4mrvI0PvjSZ+dew
 83lzMkcwIi3FTpdYhpV+7soZHURs4mVIBa4gfNVtp03nZHnvPe2NOmyWhwdkdbextvrv
 C/c/PADGBqpPi8H47of8e2/iJXcFu1IY3EDRAM1wOR5nkjWbEkQ+5WVk0m9JWdaGv7Ln
 eC+VHPFZ3PxzXW8ackuPyc/rzTDUqmvgajKsKEicgobbCLJMK8QutnhDAGqZiCxImBq1
 5tpw==
X-Gm-Message-State: ABy/qLYZxqFNqpRZJp0m1+FvO00ub1Ob+8dFPEiy+MS5PCCGnmWOx/U0
 3YUKVwZYX9A08rsnJX0fPHebjggGCIFrbVg1K0jbL4USNK3C+WVJ6/jw/QkDXYR7nUXZRCDHdbr
 RGHn+tYxMoJ1O4zTHNA/AZdBwc0QqEhaE3tUDNvKhehMNL2yI/ic6Vg+/jY9TILf87WjjWl5cFF
 U=
X-Received: by 2002:a05:6000:1146:b0:316:f5b1:98c with SMTP id
 d6-20020a056000114600b00316f5b1098cmr2104237wrx.24.1690474250102; 
 Thu, 27 Jul 2023 09:10:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHh1jpgH47RbF/5wD7KFPg4htWAQYmjvR0cJngReSpTeQPsoeTTgsh/y7jgVuLL/Hf5VCPHCQ==
X-Received: by 2002:a05:6000:1146:b0:316:f5b1:98c with SMTP id
 d6-20020a056000114600b00316f5b1098cmr2104216wrx.24.1690474249801; 
 Thu, 27 Jul 2023 09:10:49 -0700 (PDT)
Received: from step1.redhat.com ([193.207.170.163])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a5d4407000000b0031766e99429sm2398506wrq.115.2023.07.27.09.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:10:49 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 2/4] block/blkio: retry blkio_connect() if it fails using
 `fd`
Date: Thu, 27 Jul 2023 18:10:18 +0200
Message-ID: <20230727161020.84213-3-sgarzare@redhat.com>
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
---

Notes:
    v2:
    - reworked retrying blkio_connect() [Stefan]

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


