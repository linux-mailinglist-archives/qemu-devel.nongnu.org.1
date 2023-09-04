Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785E791570
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6QS-00012X-BD; Mon, 04 Sep 2023 06:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QO-00010M-LK
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qd6QL-0007p0-WE
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693821793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bF+pbL5tZCJXn2MdnBzudY2ER9D0akSW12zaE/Q7pE=;
 b=TriV+K1yyAn8Wgudq3x0h9u6R/dVYMegJsnRI/KVFQv/4vsULOYrNHsw+/PqZXa/vVKDrC
 CbcWainqYjCOPPHTQb5MYCIcZJ1dDa80JcBiT5g+Cz6HSPi9lXU4fDYDr8xMcAWcknPow7
 wPUh8Jld1m+OYMRizBbm3IOswAFSdRo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-QKFL2YmVNwGwJdVq5QR0Yg-1; Mon, 04 Sep 2023 06:03:12 -0400
X-MC-Unique: QKFL2YmVNwGwJdVq5QR0Yg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402d1892cecso2137985e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:03:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693821790; x=1694426590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8bF+pbL5tZCJXn2MdnBzudY2ER9D0akSW12zaE/Q7pE=;
 b=A+Xeb9Xx5dzVWhLR0TkEpuYmVaIDtsCrlIIv/TlXHmO9ztXHCw1FCwYxn1XTHjrlAK
 cYlqAenUBA0hYRAmAstke45F+O07QgsIu90gPJ64AO5mgcftjpopqED1r2NghFVnvwWe
 0kcaLWZq2CfzA4xXeU1l3GUKelGkuJEkb0+jjP85drp7cV1aadD8sqwtP5zVAj8Wth6h
 fCFDJmYI6gC8FGTMie7o2N3gg5ak8pBpgqMcc/zC7gv1v+YuidJ6PA3C4A+iaIRwn5Q7
 dwwo4TbFd99NaW17VC+d7AAMEpzuU2ZMAv546yGDo6AJTpis+2DWpjAKhUg/p258EeES
 JAVw==
X-Gm-Message-State: AOJu0Yyyu6mKlo5tynqYZ8SVf/J9c87l3uqrHrOodgQ8tlzksjMZLvZd
 QCfWP5YD0HmKWKz8axqN9A1EE36O6LliSbbh+fmlG5HsBq54ngt91/tsjXf8Jc5s5ZCG3zxr4EO
 WrCYn7mQQbwsWfgM87xXXFdCnrrEkgDkch6yUzlmDgkSW9bn/V9QXNq7ryD7gPOPYoTSNNs2XYg
 o=
X-Received: by 2002:a05:600c:4656:b0:401:b24b:8279 with SMTP id
 n22-20020a05600c465600b00401b24b8279mr9722145wmo.1.1693821790038; 
 Mon, 04 Sep 2023 03:03:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEpTrxIGJ1QMe3wG2wIf5jcCmDqbkuC3y9ohSuIwOvs3ueFPDTTZhKobkoRIqzuyhItlpdNw==
X-Received: by 2002:a05:600c:4656:b0:401:b24b:8279 with SMTP id
 n22-20020a05600c465600b00401b24b8279mr9722128wmo.1.1693821789807; 
 Mon, 04 Sep 2023 03:03:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a05600c014300b003fefd46df47sm16696378wmm.29.2023.09.04.03.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:03:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com,
	kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH v3 1/4] block: rename the bdrv_co_block_status static function
Date: Mon,  4 Sep 2023 12:03:03 +0200
Message-ID: <20230904100306.156197-2-pbonzini@redhat.com>
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

bdrv_block_status exists as a wrapper for bdrv_block_status_above, but
the name of the (hypothetical) coroutine version, bdrv_co_block_status,
is squatted by a random static function.  Rename it to
bdrv_co_do_block_status.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/io.c b/block/io.c
index 76e7df18d81..6b9e39c350d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2376,9 +2376,9 @@ int bdrv_flush_all(void)
  * set to the host mapping and BDS corresponding to the guest offset.
  */
 static int coroutine_fn GRAPH_RDLOCK
-bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
-                     int64_t offset, int64_t bytes,
-                     int64_t *pnum, int64_t *map, BlockDriverState **file)
+bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
+                        int64_t offset, int64_t bytes,
+                        int64_t *pnum, int64_t *map, BlockDriverState **file)
 {
     int64_t total_size;
     int64_t n; /* bytes */
@@ -2537,8 +2537,8 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
 
     if (ret & BDRV_BLOCK_RAW) {
         assert(ret & BDRV_BLOCK_OFFSET_VALID && local_file);
-        ret = bdrv_co_block_status(local_file, want_zero, local_map,
-                                   *pnum, pnum, &local_map, &local_file);
+        ret = bdrv_co_do_block_status(local_file, want_zero, local_map,
+                                      *pnum, pnum, &local_map, &local_file);
         goto out;
     }
 
@@ -2565,8 +2565,8 @@ bdrv_co_block_status(BlockDriverState *bs, bool want_zero,
         int64_t file_pnum;
         int ret2;
 
-        ret2 = bdrv_co_block_status(local_file, want_zero, local_map,
-                                    *pnum, &file_pnum, NULL, NULL);
+        ret2 = bdrv_co_do_block_status(local_file, want_zero, local_map,
+                                       *pnum, &file_pnum, NULL, NULL);
         if (ret2 >= 0) {
             /* Ignore errors.  This is just providing extra information, it
              * is useful but not necessary.
@@ -2633,7 +2633,8 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
         return 0;
     }
 
-    ret = bdrv_co_block_status(bs, want_zero, offset, bytes, pnum, map, file);
+    ret = bdrv_co_do_block_status(bs, want_zero, offset, bytes, pnum,
+                                  map, file);
     ++*depth;
     if (ret < 0 || *pnum == 0 || ret & BDRV_BLOCK_ALLOCATED || bs == base) {
         return ret;
@@ -2649,8 +2650,8 @@ bdrv_co_common_block_status_above(BlockDriverState *bs,
     for (p = bdrv_filter_or_cow_bs(bs); include_base || p != base;
          p = bdrv_filter_or_cow_bs(p))
     {
-        ret = bdrv_co_block_status(p, want_zero, offset, bytes, pnum, map,
-                                   file);
+        ret = bdrv_co_do_block_status(p, want_zero, offset, bytes, pnum,
+                                      map, file);
         ++*depth;
         if (ret < 0) {
             return ret;
-- 
2.41.0


