Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FA3761113
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFQV-0006Kh-Me; Tue, 25 Jul 2023 06:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOFQS-0006K6-MG
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qOFQQ-00027l-It
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690281473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QzN5pQYPJw9+RkdXVX9FDXzeHuzLmamrY0hcJPFrH8A=;
 b=LGv0Dr3Z6BR+X0MFDlY1RHlKiTlujHZsm4mSIPpo2fwgg8WidTMVkm7mWpr3JWKzycJGHQ
 picjwAtorpi28sILfwpciyR5vV/D6ezGY8O+AnlukgMFW41FATjD6itqVvc24LRaL73mbG
 apBBxbS53rF5OY/cveDEnR591D7xu1E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-XBkPQZrNMD2HpkvanO5wLA-1; Tue, 25 Jul 2023 06:37:49 -0400
X-MC-Unique: XBkPQZrNMD2HpkvanO5wLA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbe356b8deso28503755e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690281467; x=1690886267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzN5pQYPJw9+RkdXVX9FDXzeHuzLmamrY0hcJPFrH8A=;
 b=OM6twgWQc7//hcU2XlzI42hK8VUJZW349B9DGlbeEj8j6/sQBUSf9SreDnfGYTv8Xi
 lrYBr+m2/sXrY5fybilaGlgL+plvdHaxO76rI6y3WkdzYYltD7X8fiaOvCo3eF8Z8pEq
 XY+IzGBfd6zj8M/9sjO4YMCcjeKD5rkw3x9KfDRTJ2Qsla3oD/L/MUInBiEP6Kb+iZEK
 FOBrDEKRDgUQcyDX99TqI0J787OoeX60Dc2phavAfDHl0c4VOWQYD6YPFxHdXoPGsXNZ
 09rMXQbqNuqVNaQQjIKZjW4HmU1nepCs3N84pya5Sc4/706tCPBSsxpa5TEgGlfQqUo1
 Np6w==
X-Gm-Message-State: ABy/qLYu3A09viiu+po/M2bwev679MpsmDjdndAU+qPDKrD4mO9CXEK4
 lkk8n4zjbe3vqN9FJ+HxWTv3xMB5/UkdsobgMoEyuzbl61y9AJEVODks3mbfawghtI2q8i3mE8y
 lh2GUjOXYIqDkY7vt9qxKgzL06IOmuGLAz5OMqhnFRjA/B3BPhCPGeG1MDBwpJ5HSioRsBdHG0+
 w=
X-Received: by 2002:adf:f848:0:b0:317:18a8:5fa1 with SMTP id
 d8-20020adff848000000b0031718a85fa1mr7460448wrq.69.1690281467805; 
 Tue, 25 Jul 2023 03:37:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGq/5A5T4lrZTDg2SKb4ozN2FM4cklLcx09xpVgrIRfk87T1DAiLsgGPMM4c4rTsKMU61u1xA==
X-Received: by 2002:adf:f848:0:b0:317:18a8:5fa1 with SMTP id
 d8-20020adff848000000b0031718a85fa1mr7460429wrq.69.1690281467445; 
 Tue, 25 Jul 2023 03:37:47 -0700 (PDT)
Received: from step1.redhat.com ([193.207.217.123])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adff748000000b00314374145e0sm15834957wrp.67.2023.07.25.03.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:37:46 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] block/blkio: enable the completion eventfd
Date: Tue, 25 Jul 2023 12:37:44 +0200
Message-ID: <20230725103744.77343-1-sgarzare@redhat.com>
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

Until libblkio 1.3.0, virtio-blk drivers had completion eventfd
notifications enabled from the start, but from the next releases
this is no longer the case, so we have to explicitly enable them.

In fact, the libblkio documentation says they could be disabled,
so we should always enable them at the start if we want to be
sure to get completion eventfd notifications:

    By default, the driver might not generate completion events for
    requests so it is necessary to explicitly enable the completion
    file descriptor before use:

    void blkioq_set_completion_fd_enabled(struct blkioq *q, bool enable);

I discovered this while trying a development version of libblkio:
the guest kernel hangs during boot, while probing the device.

Fixes: fd66dbd424f5 ("blkio: add libblkio block driver")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blkio.c b/block/blkio.c
index 1798648134..bc1fac48b7 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -845,6 +845,7 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
     QLIST_INIT(&s->bounce_bufs);
     s->blkioq = blkio_get_queue(s->blkio, 0);
     s->completion_fd = blkioq_get_completion_fd(s->blkioq);
+    blkioq_set_completion_fd_enabled(s->blkioq, true);
 
     blkio_attach_aio_context(bs, bdrv_get_aio_context(bs));
     return 0;
-- 
2.41.0


