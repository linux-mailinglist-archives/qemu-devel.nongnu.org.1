Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BA976B954
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQrqn-0001qf-6L; Tue, 01 Aug 2023 12:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qQrqg-0001WE-Ia
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qQrqe-0005BK-US
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690905828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e8287JZxFoKQYSGJDbSuajwiLjtWsxVc7SmfZQR3i98=;
 b=Fuf2xa2raLWESOZimGzmUvVEpchImDfwQfmhyDpUp6V9MNhXFQWSuMpoqQiRGRhgFIMPc7
 iuKQVl2u+u+5Okm7oIEWxCvv2U+KeKftWlPuwYlfJ9QtxRh11bSE7RLPuFRScSBZVCVDpT
 IBIMJpBT5er+SJWr1ubIdeFFq3P/ym4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-SPBHbtrBPgKOhTiyNs0dTQ-1; Tue, 01 Aug 2023 12:03:46 -0400
X-MC-Unique: SPBHbtrBPgKOhTiyNs0dTQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31775a8546fso3617833f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 09:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690905825; x=1691510625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8287JZxFoKQYSGJDbSuajwiLjtWsxVc7SmfZQR3i98=;
 b=SrEZjIbi+0uh3lGBGBbKouxOozIpDz9YTmU9M+8sN2Y4xTBHMzwutwePujajBPK8kZ
 aOOeYjGNF9G+wBg7aO/5GqPPQqeRgL5Yrqfdd/edhlV6jB4oXaYbrgNpes9NJma/Hodm
 40FFEiQjzk84lwVfMSXvxnnQFZ5DeSZawvKUjffwQy8HT/vjYowaftIjXamRxtJhB9Dr
 YbJwM4JXpLyX/FiwF8JESsy825vPxqpyljRVen/eivIhHqelJ7BtKJprcYtQMdrZkFEl
 OT5HOr8dO8b/qo5VxK7T9WYRdAabMHTmtq2Kt3l+N8FYVpjlCTkf/65Jh0nlhKv5prti
 cFAg==
X-Gm-Message-State: ABy/qLZbX0TNkycZGPXwoifZSmtu5h3YYRd3qCjnw/+YkJtUMj6YQy/Q
 zJvGUWrhgz6Btf6vclI7gHZipIfajGSr0vXFpnSECnA0695Rw0Jrpu4Hc/9f89gIBGiJPQWQCvt
 9mJ4y1bzdfsi1RtqMOc1dqMp1rAYIXBkmHIEml+kJsWN0bWReMPD4LeTbq7MfmyqwmD+65MhgiT
 Y=
X-Received: by 2002:adf:ecc8:0:b0:314:336e:d4d8 with SMTP id
 s8-20020adfecc8000000b00314336ed4d8mr2981954wro.8.1690905825350; 
 Tue, 01 Aug 2023 09:03:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGR4eJpjWsyQgVBlBg3kNCqcMAnpXI5eMr020YCQd9JT1DlDHWmNGP+rSJJHWUiwO7+pTj+cg==
X-Received: by 2002:adf:ecc8:0:b0:314:336e:d4d8 with SMTP id
 s8-20020adfecc8000000b00314336ed4d8mr2981916wro.8.1690905824600; 
 Tue, 01 Aug 2023 09:03:44 -0700 (PDT)
Received: from step1.. (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 o10-20020a056000010a00b00317b063590fsm1728460wrx.55.2023.08.01.09.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 09:03:43 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/2] block/blkio: add more comments on the fd passing handling
Date: Tue,  1 Aug 2023 18:03:32 +0200
Message-ID: <20230801160332.122564-3-sgarzare@redhat.com>
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

As Hanna pointed out, it is not clear in the code why qemu_open()
can fail, and why blkio_set_int("fd") is not enough to discover
the `fd` property support.

Let's fix them by adding more details in the code comments.

Suggested-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/blkio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 2d53a865e7..848b8189d0 100644
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
@@ -734,9 +740,12 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
 
     ret = blkio_connect(s->blkio);
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
         fd_supported = false;
-- 
2.41.0


