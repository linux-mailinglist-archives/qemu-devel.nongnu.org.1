Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D35C7613B1
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:13:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFxd-000288-Is; Tue, 25 Jul 2023 07:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOFxc-00027v-5t
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOFxa-00027M-P7
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690283529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D5d1Cxm+tUNr+QauuYeTFn4CDkMVFXljOOvWjY/jAqE=;
 b=KR4xOtgZmVmGVSnc7ClpDLHC+VRexxgGYcK93MPf6aG0aoOPX+ORjaZNTn5/49fS6q3Nef
 LbODSciJTglMqq7WRyFPeabeVZwRzfv1U01g4TPZ2ysucBrMYXnj0IQTpZ6+tyCeHPtkMY
 hISBGexUKuPezY/2GiemeQCLbSszVC8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-rnxQfzDWO6-9MH2nMEr42g-1; Tue, 25 Jul 2023 07:12:05 -0400
X-MC-Unique: rnxQfzDWO6-9MH2nMEr42g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fd2e898badso15594765e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690283524; x=1690888324;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D5d1Cxm+tUNr+QauuYeTFn4CDkMVFXljOOvWjY/jAqE=;
 b=fxdjT3qxQgJl5Iap6oxlgdTtUdgAfbQErKmtRomixVI6DoJjSZj5h2++rJ/MBUGMos
 71d471u1yX1sL0H8YQ05VitfcmIbpgoI+QwSXeXYKBcZx8pG/n1LDAUyHUW9N0M2Zyib
 vpog6TeMVxqnmbQvBYxaeRGV3csuhDtvzIPv2jolw0MeDQ5/Rkjc4QVYCd1FZ2NAeM6N
 YRxLO3yPhVhXRBMxPBxe6eHngsdPChnnFPk91g68TAo3PIC7l/eGXas41eu221KX1zhD
 +B+JOBfdw6/f4By+361vh1yN7yX61L/PKadSHTeKF6NfkR1Bd458B5cc9Ud7hqUefOLK
 M43w==
X-Gm-Message-State: ABy/qLaVWsrCZ2EaFsn+/lXyeLLZcuUNJtlKD6DtQxYn9H4V9Ij4DdZw
 NxgCjuPF5hPcaNvt9FmY9rRsqNkMwERpiNkvX3dVoQaRnKnhqfAQW7oFG/E+dujVltgHgMoWcIz
 9yKD63JkQwn3uZB+hw2chWAeHaUIbENIdN1BnzQEQWFS7s+3h02AritZZTmBSMLARKG+3ioR6Xb
 E=
X-Received: by 2002:a7b:c3d9:0:b0:3fa:9996:8e03 with SMTP id
 t25-20020a7bc3d9000000b003fa99968e03mr1789116wmj.10.1690283518949; 
 Tue, 25 Jul 2023 04:11:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH1vVuaFmIkbKFGjZkw8D0DJLoYghovudqg+kFZ/8i8AYXQrUYBuZIYBWah08SjRAK7eqbhwg==
X-Received: by 2002:a7b:c3d9:0:b0:3fa:9996:8e03 with SMTP id
 t25-20020a7bc3d9000000b003fa99968e03mr1789094wmj.10.1690283518542; 
 Tue, 25 Jul 2023 04:11:58 -0700 (PDT)
Received: from step1.redhat.com ([193.207.217.123])
 by smtp.gmail.com with ESMTPSA id
 9-20020a05600c024900b003fd32074e74sm7458116wmj.31.2023.07.25.04.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 04:11:57 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>, Qing Wang <qinwang@redhat.com>
Subject: [PATCH] block/blkio: do not use open flags in qemu_open()
Date: Tue, 25 Jul 2023 13:11:55 +0200
Message-ID: <20230725111155.85426-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
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

qemu_open() in blkio_virtio_blk_common_open() is used to open the
character device (e.g. /dev/vhost-vdpa-0 or /dev/vfio/vfio) or in
the future eventually the unix socket.

In all these cases we cannot open the path in read-only mode,
when the `read-only` option of blockdev is on, because the exchange
of IOCTL commands for example will fail.

In order to open the device read-only, we have to use the `read-only`
property of the libblkio driver as we already do in blkio_file_open().

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Reported-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 1798648134..fe9bf8ea5f 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -686,15 +686,7 @@ static int blkio_virtio_blk_common_open(BlockDriverState *bs,
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
+        fd = qemu_open(path, O_RDWR, errp);
         if (fd < 0) {
             return -EINVAL;
         }
-- 
2.41.0


