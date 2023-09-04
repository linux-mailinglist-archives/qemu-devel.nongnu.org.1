Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259C791574
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:05:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6QW-00017V-HZ; Mon, 04 Sep 2023 06:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QR-00013L-IV
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QP-0007pp-98
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693821796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PiOkxVVgFoVupw9ZTs6y9TPZVi2SdaYNMkB5l50iluo=;
 b=CHqhCk/JYQB4cVB/pUaepy/C55EUL9jken3BQoHPPZqd/QnSydJ8U0te7CwUil/YGGqgcq
 2LBvUQKtiMfcs5D5ln2fBwmHiXE/6r50KW7n+L9UB7Dif2KctctSeadPSMzVREVD3kaDqi
 +VWMm+01TBeihX7wXxQ+0zNoOfLjVGg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-BfVcoHP8O469hfeUltIvWA-1; Mon, 04 Sep 2023 06:03:15 -0400
X-MC-Unique: BfVcoHP8O469hfeUltIvWA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401d8873904so8629035e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821793; x=1694426593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiOkxVVgFoVupw9ZTs6y9TPZVi2SdaYNMkB5l50iluo=;
 b=hxVfNlCLiooDgtpGu0TgSMP879UBaSuzZdahIoGjlZllxZC0odoDyuWI4kh79Vv8mD
 pULQ0q2THJM9GzZ7PjBPowsOe2F6iJcJ7OzsU/+QCu19rnEH0GQzvTcSmsLjZPHhqF+z
 /3ZDr8Yvz1Y4di4jTUFz59u+t5tZum6E++csdutYps7IxDN9khEET01Dshq1yF6QNPZg
 WfsrvAFT8FB/lFnnUBurIzD7tAyfU1xxA8R5KDSGWqCoN50+iphvmtUe7KbsmmjL+WjG
 /GGwsTHjcMKDJVHlFr1IedJFLGVfJleVvL+IGnZhVdIA2hocnYla+789XSVC4H9urbqn
 PjrQ==
X-Gm-Message-State: AOJu0Ywz5WFO9LPJtJNdlAWsGu6CEdhqmV9ooNqPU3mFzf24YkA83m4J
 TdQ1t51pZsaTYUd43WlGuKyMbGwtRP9YlqQKZPLLkysZ4MEChRLacn1VM9GukJrmdubH6y5mdCe
 MuDzPFFwrdipLkr6+wQAdSMqYvZM2cglDzZewyq9GKFZXwEjcD+lGlnqRhxBNZoSvApQOdvQMoA
 M=
X-Received: by 2002:a5d:55c1:0:b0:31d:c73d:d2ed with SMTP id
 i1-20020a5d55c1000000b0031dc73dd2edmr7550795wrw.5.1693821793658; 
 Mon, 04 Sep 2023 03:03:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuCfKmZ3/G8wMsND9+7thSTuLP1jGRPkN0bBvoGDhwVj9GozYrGFX/sCSWRehrbgf/EdkF/w==
X-Received: by 2002:a5d:55c1:0:b0:31d:c73d:d2ed with SMTP id
 i1-20020a5d55c1000000b0031dc73dd2edmr7550775wrw.5.1693821793337; 
 Mon, 04 Sep 2023 03:03:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l10-20020a5d4bca000000b003180155493esm14026098wrt.67.2023.09.04.03.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:03:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 3/4] block: switch to co_wrapper for bdrv_is_allocated_*
Date: Mon,  4 Sep 2023 12:03:05 +0200
Message-ID: <20230904100306.156197-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904100306.156197-1-pbonzini@redhat.com>
References: <20230904100306.156197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c               | 53 ++++++----------------------------------
 include/block/block-io.h | 12 +++++----
 2 files changed, 14 insertions(+), 51 deletions(-)

diff --git a/block/io.c b/block/io.c
index ea358b6b994..81c9630dac1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2770,45 +2770,6 @@ int coroutine_fn bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset,
     return !!(ret & BDRV_BLOCK_ALLOCATED);
 }
 
-int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      int64_t *pnum)
-{
-    int ret;
-    int64_t dummy;
-    IO_CODE();
-
-    ret = bdrv_common_block_status_above(bs, bs, true, false, offset,
-                                         bytes, pnum ? pnum : &dummy, NULL,
-                                         NULL, NULL);
-    if (ret < 0) {
-        return ret;
-    }
-    return !!(ret & BDRV_BLOCK_ALLOCATED);
-}
-
-/* See bdrv_is_allocated_above for documentation */
-int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *top,
-                                            BlockDriverState *base,
-                                            bool include_base, int64_t offset,
-                                            int64_t bytes, int64_t *pnum)
-{
-    int depth;
-    int ret;
-    IO_CODE();
-
-    ret = bdrv_co_common_block_status_above(top, base, include_base, false,
-                                            offset, bytes, pnum, NULL, NULL,
-                                            &depth);
-    if (ret < 0) {
-        return ret;
-    }
-
-    if (ret & BDRV_BLOCK_ALLOCATED) {
-        return depth;
-    }
-    return 0;
-}
-
 /*
  * Given an image chain: ... -> [BASE] -> [INTER1] -> [INTER2] -> [TOP]
  *
@@ -2826,18 +2787,18 @@ int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *top,
  * words, the result is not necessarily the maximum possible range);
  * but 'pnum' will only be 0 when end of file is reached.
  */
-int bdrv_is_allocated_above(BlockDriverState *top,
-                            BlockDriverState *base,
-                            bool include_base, int64_t offset,
-                            int64_t bytes, int64_t *pnum)
+int coroutine_fn bdrv_co_is_allocated_above(BlockDriverState *bs,
+                                            BlockDriverState *base,
+                                            bool include_base, int64_t offset,
+                                            int64_t bytes, int64_t *pnum)
 {
     int depth;
     int ret;
     IO_CODE();
 
-    ret = bdrv_common_block_status_above(top, base, include_base, false,
-                                         offset, bytes, pnum, NULL, NULL,
-                                         &depth);
+    ret = bdrv_co_common_block_status_above(bs, base, include_base, false,
+                                            offset, bytes, pnum, NULL, NULL,
+                                            &depth);
     if (ret < 0) {
         return ret;
     }
diff --git a/include/block/block-io.h b/include/block/block-io.h
index c539aa66945..2191d49c551 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -148,16 +148,18 @@ bdrv_block_status_above(BlockDriverState *bs, BlockDriverState *base,
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
                      int64_t *pnum);
-int bdrv_is_allocated(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                      int64_t *pnum);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_is_allocated(BlockDriverState *bs, int64_t offset,
+                  int64_t bytes, int64_t *pnum);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
                            bool include_base, int64_t offset, int64_t bytes,
                            int64_t *pnum);
-int bdrv_is_allocated_above(BlockDriverState *top, BlockDriverState *base,
-                            bool include_base, int64_t offset, int64_t bytes,
-                            int64_t *pnum);
+int co_wrapper_mixed_bdrv_rdlock
+bdrv_is_allocated_above(BlockDriverState *bs, BlockDriverState *base,
+                        bool include_base, int64_t offset,
+                        int64_t bytes, int64_t *pnum);
 
 int coroutine_fn GRAPH_RDLOCK
 bdrv_co_is_zero_fast(BlockDriverState *bs, int64_t offset, int64_t bytes);
-- 
2.41.0


