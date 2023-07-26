Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE44762EA0
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 09:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOZG1-0002FM-Ki; Wed, 26 Jul 2023 03:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOZFp-0002Eu-Lj
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOZFn-00045k-UY
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 03:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690357694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GSIzqlVHPCPdjN78Dilj6eHcUt7noYWn0bE3Mwrlts0=;
 b=gvGPfzK3fWevIMGyKGlFPCmJknuk+QC5oeWQOOfuQPjJfTxvqXU0/QMo1H+EBv0iS4hJPP
 3nOijvG8Dbc+7nUz3+OJ12Ahu/mnUQo3B9sDFLMJGFF4qB8hmTav5vnaYiAt8624YH1/vt
 HnOTwvqFf/xU21M7joZ51VAZUUcpMbc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-eRd-OT8JOx6Obpl_iy-eVQ-1; Wed, 26 Jul 2023 03:48:13 -0400
X-MC-Unique: eRd-OT8JOx6Obpl_iy-eVQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb76659d6cso69370e87.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 00:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690357691; x=1690962491;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GSIzqlVHPCPdjN78Dilj6eHcUt7noYWn0bE3Mwrlts0=;
 b=EotgG+g3FNKkbs9tbZLt4Na9AVJM52/hbw/CEIOAgHjLi/8ej4KUAvfkrWEpvwCVNr
 8odC8cMQsW3Fjt/5/E/hwyf5JgnlyN4lcdDP5dszCh2a2gbevA98MNptg004X+YBN2mu
 PHxzbEpIvZjWYQMvoogwdkdWWoW95CWH5gxytv8cYGpa0OlohRVVZe/PPWediY/meZxJ
 +UW8axJjZOxRjcLW82gSWfo/KBMnSMVZv+d+IP2LYAklvnq7brp3M3N4Zy2rG8VxeWCk
 tb0ZCjaH4G9T9V72LBORB/oGkZ+/8D0iQxMhycV0812kfbBFs2hpiEGR8h3+/qgcJI00
 Ve3g==
X-Gm-Message-State: ABy/qLbc2GdFNmkRFfkAebi3oC6bM6KjWsgWAn4GeN90YkIqBpDfGjzP
 vg8QDGDIzc+iXk8Mo264Pex7bk2UfE0HkXJ9IA89zU0dZm6f8OfwMenD5LV9R6kXaLYhIBebCbq
 sqc06KQ0MSTi4yP5SE1toJOzs6kNcA+K0bwf7jj2mbPlgDg6ih5biVjTceurK6/gV2DYUWAqpTU
 0=
X-Received: by 2002:a19:5042:0:b0:4fd:c8dc:2f55 with SMTP id
 z2-20020a195042000000b004fdc8dc2f55mr929957lfj.66.1690357691176; 
 Wed, 26 Jul 2023 00:48:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH8npHUbf2n6oT8VUYYITvxMTadk7CGBhU5RknDraB837I9al15DjzJM3YEiesfm3mJoxxDzw==
X-Received: by 2002:a19:5042:0:b0:4fd:c8dc:2f55 with SMTP id
 z2-20020a195042000000b004fdc8dc2f55mr929938lfj.66.1690357690774; 
 Wed, 26 Jul 2023 00:48:10 -0700 (PDT)
Received: from step1.lan ([5.77.111.137]) by smtp.gmail.com with ESMTPSA id
 l27-20020a056402345b00b0052279f773e3sm133221edc.32.2023.07.26.00.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 00:48:09 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 berrange@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 Qing Wang <qinwang@redhat.com>
Subject: [PATCH v2] block/blkio: do not use open flags in qemu_open()
Date: Wed, 26 Jul 2023 09:48:07 +0200
Message-ID: <20230726074807.14041-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
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
---

Notes:
    v2:
    - added comment on top of qemu_open() [Daniel]
    
    v1: https://lore.kernel.org/qemu-devel/20230725111155.85426-1-sgarzare@redhat.com/

 block/blkio.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 1798648134..cd6d2e55e7 100644
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


