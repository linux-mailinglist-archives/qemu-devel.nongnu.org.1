Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7808C76B955
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrqm-0001hx-6i; Tue, 01 Aug 2023 12:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qQrqd-0001Rg-V8
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qQrqc-0005A9-Ht
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690905824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RrVmqGVyCP1CPTJBHML95V4Gsgpeo1SRnEgQv8e8fwE=;
 b=WXXxx2avAS+QcmtiVPS1jLyL/5zDm6MKhG7P4j4KDnbsexmC3OMXbIa1TcFOKOJOe6Q+7D
 +EIjGd3DVfX8Kf4YqumTNxSEUvc9dEfD0qpScwmxiLpPkIk2c+5JqFCNnc67+FFss0qWih
 g1NXrJzy27K7Uh6agxK9Gvb/r/8AQ3w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-ITYDWcD9O1CkRvZK1e-dEQ-1; Tue, 01 Aug 2023 12:03:41 -0400
X-MC-Unique: ITYDWcD9O1CkRvZK1e-dEQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-317a0d22311so1456850f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 09:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690905820; x=1691510620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RrVmqGVyCP1CPTJBHML95V4Gsgpeo1SRnEgQv8e8fwE=;
 b=bOEqljiErMwMPZaosamxn7lbyL12rlgYav8HIcYWd95HIYUKtOfpr0Pafc1KWb8FfA
 7crW87Y3Huo61/ocPgHZkuQEB/Lp3DCNbCkbQmP0xbwBO4BDGXKRXtnN6NubUMY1U4hO
 6mH2j6krqbZJx/CVRydBdr5BZyTVc9zjsXT2GNoB/4atkuey0t2H/fO8kOcBP+qXVW7B
 MBCqGHx/VsJA88B6wmsY50L8D/cx0NSalu68KvsE2Dm23MqR9QxOKDD7SOv3C+2K4CUa
 KnhpolwnrbWyVwixk882JM8ZK3HhB9C5Zh15xJQq/OSfUx5gqHuPByzzzzU8M1UmhCGV
 bd9Q==
X-Gm-Message-State: ABy/qLbQ/YhoPXpf715fDX1svqY6vdeDFLuKePIdPMRxHyKtf9u3hKg0
 CVO0iVs+6nu82rvQxYlrenUOIIRP/01dka31f/HEIAxYvp6o+Wgp0WkmpK3pUNSRzwXUXtnETyi
 CCFK8fEcazbpMEvHEEtf8dO7Zb4wid5VFG2ytDSvNLuu+UyiCW3MtmqvWW0z55O6d4+aIPJ8OmZ
 o=
X-Received: by 2002:adf:ee52:0:b0:317:57f0:fae with SMTP id
 w18-20020adfee52000000b0031757f00faemr2762912wro.63.1690905820018; 
 Tue, 01 Aug 2023 09:03:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHz1xUYMFW0RnkpMhsVBCeDxq9bj11RthHaQMlfH+gafDbpmeI/EYok9nTlLxuvMD97KByqYw==
X-Received: by 2002:adf:ee52:0:b0:317:57f0:fae with SMTP id
 w18-20020adfee52000000b0031757f00faemr2762886wro.63.1690905819653; 
 Tue, 01 Aug 2023 09:03:39 -0700 (PDT)
Received: from step1.. (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 f11-20020adff58b000000b003143aa0ca8asm16400418wro.13.2023.08.01.09.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 09:03:38 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/2] block/blkio: close the fd when blkio_connect() fails
Date: Tue,  1 Aug 2023 18:03:31 +0200
Message-ID: <20230801160332.122564-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801160332.122564-1-sgarzare@redhat.com>
References: <20230801160332.122564-1-sgarzare@redhat.com>
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

libblkio drivers take ownership of `fd` only after a successful
blkio_connect(), so if it fails, we are still the owners.

Fixes: cad2ccc395 ("block/blkio: use qemu_open() to support fd passing for virtio-blk")
Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/block/blkio.c b/block/blkio.c
index 8e7ce42c79..2d53a865e7 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -739,6 +739,7 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
      * directly setting `path`.
      */
     if (fd_supported && ret == -EINVAL) {
+        fd_supported = false;
         qemu_close(fd);
 
         /*
@@ -763,6 +764,14 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
     }
 
     if (ret < 0) {
+        if (fd_supported) {
+            /*
+             * libblkio drivers take ownership of `fd` only after a successful
+             * blkio_connect(), so if it fails, we are still the owners.
+             */
+            qemu_close(fd);
+        }
+
         error_setg_errno(errp, -ret, "blkio_connect failed: %s",
                          blkio_get_error_msg());
         return ret;
-- 
2.41.0


