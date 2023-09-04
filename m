Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B00E791572
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6QU-00015Y-AC; Mon, 04 Sep 2023 06:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QQ-00012a-Hz
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QN-0007pL-J7
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:18 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-g5GNhzx1MYOUoGQWkVJnAQ-1; Mon, 04 Sep 2023 06:03:13 -0400
X-MC-Unique: g5GNhzx1MYOUoGQWkVJnAQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31f3cfe7269so637507f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821792; x=1694426592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mz4vUlbA1PQ7FFngVck7W+C8qd8hq4R/Gu/3TNbVJB8=;
 b=A6KabY9yoK4TTKvJdpjeFRSELf5WU7OIgxb8dcluGFB+mG7rsx05975DEvUAHkdoUm
 k6us13XyqudGY7XUmK86t5gmAVmfARyZIBYENZnQFxK70W15k1vzIqS8gxpibNy5kA0e
 N7l+Z/9wipPBlapo76dQDEvsb8bwZ1Dh8AjZVDOBL73FXquNe7XxOBLptWXG3yFdKpYL
 +qWPMREmotNuk60KClHaty7aX9dBREF5D0KQaAurhuBhONSzjOTjxTIWPE5PQAn9rb0L
 GoNFy2m/eBiChmtFpUlIZ2lcqRgInAzHbHKQC3or54vufZ0DtONtH0Vw+unewFavLJH4
 sG4g==
X-Gm-Message-State: AOJu0Yw7s8MQMZtRJEMNIEsjNzpk23rwKKCKm32bXEwGBUzTPnn6+D+c
 P4cuiC+S56pJtYuF3GKwOSK9XCZNgYJYRQoyLDZzv/gbrR2J4IU+tvJWVMiHzTGIDVy8qBpRTRd
 6pvfUA0SwC/HBV0Oldny9rEl0e/kY9DdlLre5bFyoY6XT3XVjvVixxc5YQz8c5CX1gWrlKVfzDE
 g=
X-Received: by 2002:a5d:424b:0:b0:31c:4c68:e73a with SMTP id
 s11-20020a5d424b000000b0031c4c68e73amr6909014wrr.66.1693821791905; 
 Mon, 04 Sep 2023 03:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0VqaSTCrngr2UQhgbFhiGKVcdylHC+D9iiKvuWzR5mFmxO4e8PMmPHRzb6q06eppAzfn+Pg==
X-Received: by 2002:a5d:424b:0:b0:31c:4c68:e73a with SMTP id
 s11-20020a5d424b000000b0031c4c68e73amr6908994wrr.66.1693821791548; 
 Mon, 04 Sep 2023 03:03:11 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 b4-20020adfde04000000b0031aef72a021sm13913648wrm.86.2023.09.04.03.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:03:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 2/4] block: complete public block status API
Date: Mon,  4 Sep 2023 12:03:04 +0200
Message-ID: <20230904100306.156197-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904100306.156197-1-pbonzini@redhat.com>
References: <20230904100306.156197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Include both coroutine and non-coroutine versions, the latter being
co_wrapper_mixed_bdrv_rdlock of the former.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c               | 18 +++++-------------
 include/block/block-io.h | 17 +++++++++++------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/block/io.c b/block/io.c
index 6b9e39c350d..ea358b6b994 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2717,21 +2717,13 @@ int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
                                              bytes, pnum, map, file, NULL);
 }
 
-int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum,
-                            int64_t *map, BlockDriverState **file)
+int coroutine_fn bdrv_co_block_status(BlockDriverState *bs, int64_t offset,
+                                      int64_t bytes, int64_t *pnum,
+                                      int64_t *map, BlockDriverState **file)
 {
     IO_CODE();
-    return bdrv_common_block_status_above(bs, base, false, true, offset, bytes,
-                                          pnum, map, file, NULL);
-}
-
-int bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      int64_t *pnum, int64_t *map, BlockDriverState **file)
-{
-    IO_CODE();
-    return bdrv_block_status_above(bs, bdrv_filter_or_cow_bs(bs),
-                                   offset, bytes, pnum, map, file);
+    return bdrv_co_block_status_above(bs, bdrv_filter_or_cow_bs(bs),
+                                      offset, bytes, pnum, map, file);
 }
 
 /*
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 6db48f2d359..c539aa66945 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -128,17 +128,22 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   BdrvRequestFlags flags);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
-int bdrv_block_status(BlockDriverState *bs, int64_t offset,
-                      int64_t bytes, int64_t *pnum, int64_t *map,
-                      BlockDriverState **file);
+
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                     int64_t *pnum, int64_t *map, BlockDriverState **file);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_block_status(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                  int64_t *pnum, int64_t *map, BlockDriverState **file);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_block_status_above(BlockDriverState *bs, BlockDriverState *base,
                            int64_t offset, int64_t bytes, int64_t *pnum,
                            int64_t *map, BlockDriverState **file);
-int bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
-                            int64_t offset, int64_t bytes, int64_t *pnum,
-                            int64_t *map, BlockDriverState **file);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
+                        int64_t offset, int64_t bytes, int64_t *pnum,
+                        int64_t *map, BlockDriverState **file);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
-- 
2.41.0


