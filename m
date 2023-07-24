Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DFD75FB1E
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNxlr-00068s-EX; Mon, 24 Jul 2023 11:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qNxla-00066g-H2
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qNxlY-0007iK-O6
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690213591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTZDcbYTrt9yo1zwCVODNFBUI8LfoL6/Mfzp+qj134o=;
 b=QXgSUGlTTWHjLY1WM3VIvM2eJ3HPjN6LJ4QrVTqIBGmfbtVjhnDR+zkpuqu9z1RXnZFHW+
 lF9aKNtSBVESDFf+8nAhIR3eun1KOCw0etf+0nsUc4F0rq40NMJ/mvo5w4ktni5+g33H+H
 K+bVwhhgbgt4r5PeST2YAB0bCG4SjAM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-7HXf7LFMOkuKATd67jNAGA-1; Mon, 24 Jul 2023 11:46:27 -0400
X-MC-Unique: 7HXf7LFMOkuKATd67jNAGA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7659cb9c3b3so477493385a.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690213586; x=1690818386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZTZDcbYTrt9yo1zwCVODNFBUI8LfoL6/Mfzp+qj134o=;
 b=UK05VlYkRiKy4XIBnygLSeKnWA4eAnaknoRYL6NvCZZEcmgqhKArd6GskJ9tKfKsBq
 vdA6mi9Mvr0/2gg6UC4F9OSHVceJ6JUsmJKN8MHcPhqReuVxQ8eXhOoturJUa02GOJoe
 1lQiuni82MAKISgVsJfrl0qhEny/RB3YasxtgZhh+GqY9e1uONpVPYhpWzy+GbxTGv4k
 +05mBfVkhx9u6dOiWGSiEq5j9INEU6dt+NKLOmyccOuGVMSuP9BAGqWqOnOroKB4Oxl7
 xqo+t5fsoc8ER17+kWwhS6Av82scs4iZRdvBkgMGFte1ywu2y7eW8eeeW+eTIbMMHO7J
 kTww==
X-Gm-Message-State: ABy/qLZA+h6PlMRZ1ZdMVy39jSqIvDrXTXbi8NcYOn+to7L35jYcYfAY
 dGKmBlL+rt7dxmE9XuBTJBptaFOwnZixCRtW3VHGAviESgdrjKqyB+5X/eeAt4vRzWn3pv3v0D4
 JYBhndlVa+xfbzcshBBB5INC0f8l8QIOR7scfvHz0u0GXWRY8amMJ7NTc8GD5Zo5cqjq5FOJyKA
 g=
X-Received: by 2002:ac8:5c94:0:b0:403:2dc0:e895 with SMTP id
 r20-20020ac85c94000000b004032dc0e895mr101694qta.59.1690213586669; 
 Mon, 24 Jul 2023 08:46:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIrUVPKupAqKb7Fqjab1IekwS/69TFy8WIq+FOAy6VKpb0LXQzisVY2o4fnX6GGf6oU45YyQ==
X-Received: by 2002:ac8:5c94:0:b0:403:2dc0:e895 with SMTP id
 r20-20020ac85c94000000b004032dc0e895mr101676qta.59.1690213586403; 
 Mon, 24 Jul 2023 08:46:26 -0700 (PDT)
Received: from step1.redhat.com ([5.77.105.74])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a05622a124400b004054b7cc490sm2672771qtx.73.2023.07.24.08.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 08:46:25 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>, Qing Wang <qinwang@redhat.com>
Subject: [PATCH 1/2] block/blkio: fix opening virtio-blk drivers
Date: Mon, 24 Jul 2023 17:46:10 +0200
Message-ID: <20230724154611.178858-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724154611.178858-1-sgarzare@redhat.com>
References: <20230724154611.178858-1-sgarzare@redhat.com>
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
not support it, such as virtio-blk-vhost-user. Indeed now QEMU is
failing if used with virtio-blk-vhost-user in this way:

   -blockdev node-name=drive0,driver=virtio-blk-vhost-user,path=vhost-user-blk.sock,cache.direct=on: Could not open 'vhost-user-blk.sock': No such device or address

So, `blkio_get_int()` is not enough to check whether the driver supports
the `fd` property or not. This is because the virito-blk common libblkio
driver only checks whether or not `fd` is set during `blkio_connect()`
and fails for those transports that do not support it (all except
vhost-vdpa for now).

So for now let's also check that the driver is virtio-blk-vhost-vdpa,
since that's the only one that supports it.

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Reported-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index 1798648134..ca1149042a 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -662,6 +662,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
         QDict *options, int flags, Error **errp)
 {
     const char *path = qdict_get_try_str(options, "path");
+    const char *blkio_driver = bs->drv->protocol_name;
     BDRVBlkioState *s = bs->opaque;
     bool fd_supported = false;
     int fd, ret;
@@ -676,7 +677,8 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
         return -EINVAL;
     }
 
-    if (blkio_get_int(s->blkio, "fd", &fd) == 0) {
+    if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0 &&
+        blkio_get_int(s->blkio, "fd", &fd) == 0) {
         fd_supported = true;
     }
 
-- 
2.41.0


