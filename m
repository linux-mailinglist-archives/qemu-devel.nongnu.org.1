Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EA87659D4
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3a8-0008WA-Bq; Thu, 27 Jul 2023 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3a6-0008Vz-8M
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3a4-0003Zv-Pr
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690474272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V5xCvY8FMsjvIKpr8rv2B4p4oWtKvFI4eWZNtN5mtzU=;
 b=c4+eCtth9XaVc4H1ISDqxu17T+JQVv3/u4REdRBHZa0a1RjBdVJE0FhYmIO11Toz74ul4r
 jthT1+kyW5XoZTNX5iYW5X+HxtM7ZWjDnKiYGdW0LKuWeFh+wiCCYj7Kq8Yj5OxDn0pSun
 xXvyY8GnVKp4QEnSP3uO8cZb+3RjKpQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-LYeSPoOsMWyJiYquyEuhQw-1; Thu, 27 Jul 2023 12:11:11 -0400
X-MC-Unique: LYeSPoOsMWyJiYquyEuhQw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-315a03cae87so1185591f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474269; x=1691079069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V5xCvY8FMsjvIKpr8rv2B4p4oWtKvFI4eWZNtN5mtzU=;
 b=UXjAgpZ9ttXCkctDqJUMrHz0XRwLuYN3dUZmb9apbBB/9Z74wy0MTF9ALJK8jK7Ie/
 KllqMMRN1z7z9aTNUqFa+Nrtr+QCXNWqLQXJ8U7Gx7AhUF8NN6UpWaMNAYErGKbjoOh/
 A4eWXpBsfPKKGLtCDA5lo/1+1/4KZ1JvPtzDUh+j+1/z8WiHLARvIujPOt7AkLk0u/Rf
 XPByrdeyYgkw4sA8x8Mcc2AXqxCf3d1BaqHJl/bozP6xrwfqBa5ko8j8nsGcvWMEYbDj
 tbCdhCSu0O9NAGtStPFtR/lsvYXGnuUN7tdLDqbqtdYzAVvDSA5be5Zn+F7qnU0Op9TG
 R4vw==
X-Gm-Message-State: ABy/qLbPjOPmUliGmw7W5PmLOw7hIK/L6+zKN4RFHTH1pXe2kiHnKeZt
 XqIME8VMwti4QsaOp6OOelwxjd9jWla5JUV1T+NiDR/6IY7TCV5BqE+l4lun8rQKKl1G/xxi8og
 iybTSx1NkIE8iTj79R08y9dUn3e3/0snSvWyts0s01n2YDdMEUJNa4F0TeUwjs1T8REc9/2hV2x
 w=
X-Received: by 2002:adf:ecd1:0:b0:317:67fa:eea6 with SMTP id
 s17-20020adfecd1000000b0031767faeea6mr2238715wro.22.1690474269683; 
 Thu, 27 Jul 2023 09:11:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHlq8KbgUobuvtPe6jcRbF6T2bxOhrW7cjvH7mpOarLqvZNZgvkrfV1UC7VLCju9FTHyiLhhQ==
X-Received: by 2002:adf:ecd1:0:b0:317:67fa:eea6 with SMTP id
 s17-20020adfecd1000000b0031767faeea6mr2238694wro.22.1690474269447; 
 Thu, 27 Jul 2023 09:11:09 -0700 (PDT)
Received: from step1.redhat.com ([193.207.170.163])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a5d4941000000b00314427091a2sm2401190wrs.98.2023.07.27.09.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:11:08 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 4/4] block/blkio: use blkio_set_int("fd") to check fd
 support
Date: Thu, 27 Jul 2023 18:10:20 +0200
Message-ID: <20230727161020.84213-5-sgarzare@redhat.com>
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

Setting the `fd` property fails with virtio-blk-* libblkio drivers
that do not support fd passing since
https://gitlab.com/libblkio/libblkio/-/merge_requests/208.

Getting the `fd` property, on the other hand, always succeeds for
virtio-blk-* libblkio drivers even when they don't support fd passing.

This patch switches to setting the `fd` property because it is a
better mechanism for probing fd passing support than getting the `fd`
property.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---

Notes:
    v2:
    - changed commit description [Stefan]

 block/blkio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index 72b46d61fd..8e7ce42c79 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -690,7 +690,7 @@ static int blkio_virtio_blk_connect(BlockDriverState *bs, QDict *options,
         return -EINVAL;
     }
 
-    if (blkio_get_int(s->blkio, "fd", &fd) == 0) {
+    if (blkio_set_int(s->blkio, "fd", -1) == 0) {
         fd_supported = true;
     }
 
-- 
2.41.0


