Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF07719B44
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:54:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqG-00084G-TR; Thu, 01 Jun 2023 07:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqE-0007wE-B9
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqB-0000Er-Ou
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ag5pNhrb5hTB5gn6ymSBOVwkjeLkC2szXKGwtyFkPow=;
 b=NnW9IvTSc4LA5q58VY2dOoiDFPk5fjT7osTTHEiqlVgAPfifefrBeVkyB21QgTMWRrE4/L
 tv3KyAWZfri99MQiUttIIFs+DjOzgY/kheCWnOhMtfQh0DaV3DkF9RbQJGHtcZVAdNt5xU
 oxKdy7dO6bolXPzZxBqDuz2gj02qLMc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-mzk0J0HSOT-Q8AU2fxfmsA-1; Thu, 01 Jun 2023 07:51:37 -0400
X-MC-Unique: mzk0J0HSOT-Q8AU2fxfmsA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f6fee8123so51944266b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620296; x=1688212296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ag5pNhrb5hTB5gn6ymSBOVwkjeLkC2szXKGwtyFkPow=;
 b=FZIvUeUPUiPwFV4DqZ8oChs080xgmm01G75Yj/ETiLjKKp59qMhj5weNMHJWtp5hfR
 CvOl5QN7A/PlPn2E+lrY94YT/43V2dKEMCbiBNnOxwYZOPyPySL7UNEQp9xo67T8LLZZ
 BvZhW7rOsLpYKSnswMHa5uBUqivZZBlLoaNA0pra+Kk16InLKhHf4fAukE/oCc9Ymxdz
 aO2PyYCwdPbEfnDFARaBloYivThjiM4fNbaJ9zt2mWGZLYTr8LFlSGBFlK0PqpP+d/Fa
 LZUzOgO3BcUmjONvTYAqUNrnEFM4u2vJDuaz3vhnX/ZXIUhlScRSO0j1ibwzJMOmj8A8
 qlNQ==
X-Gm-Message-State: AC+VfDzgFyCsagQSzMc1UcQsuQcfQ3feJ5qG11aCKyTQpnvrv+Kuq2uD
 PtmG6MTcWf47kPdN8UwyDG98UflfgL6XXXMLrdLFOGlGBDQveT4gjlUjdx6AW0G94O5rZcT6ESG
 BY1Whg9m5zLkXPi9VUoz2bbhFd8wHeNd4V8NXrw0zJRPiexsLBmPlsHa/GTmUxEC0CWFHaN2C5l
 4=
X-Received: by 2002:a17:907:d1d:b0:96a:ec5c:685b with SMTP id
 gn29-20020a1709070d1d00b0096aec5c685bmr7806141ejc.29.1685620296061; 
 Thu, 01 Jun 2023 04:51:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6aClUuurx2rNZetou/Ey1r5BgQT95HtRcYNSJQdyhhY1zNWnKblw1oxtlgabqBK6Obj1zbpg==
X-Received: by 2002:a17:907:d1d:b0:96a:ec5c:685b with SMTP id
 gn29-20020a1709070d1d00b0096aec5c685bmr7806095ejc.29.1685620295672; 
 Thu, 01 Jun 2023 04:51:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a170906488a00b0096f6a910ab7sm10455046ejq.190.2023.06.01.04.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 2/4] block: complete public block status API
Date: Thu,  1 Jun 2023 13:51:29 +0200
Message-Id: <20230601115131.196234-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115131.196234-1-pbonzini@redhat.com>
References: <20230601115131.196234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Include both coroutine and non-coroutine versions, the latter being
co_wrapper_mixed_bdrv_rdlock of the former.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c               | 18 +++++-------------
 include/block/block-io.h | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/block/io.c b/block/io.c
index 2c2c9656853c..806715a5bbe3 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2575,21 +2575,13 @@ int coroutine_fn bdrv_co_block_status_above(BlockDriverState *bs,
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
index a27e471a87b6..ce75ff5ddde8 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -128,17 +128,23 @@ int coroutine_fn GRAPH_RDLOCK bdrv_co_zone_append(BlockDriverState *bs,
                                                   BdrvRequestFlags flags);
 
 bool bdrv_can_write_zeroes_with_unmap(BlockDriverState *bs);
-int bdrv_block_status(BlockDriverState *bs, int64_t offset,
-                      int64_t bytes, int64_t *pnum, int64_t *map,
-                      BlockDriverState **file);
+
+int coroutine_fn GRAPH_RDLOCK
+bdrv_co_block_status(BlockDriverState *bs, int64_t offset,
+                     int64_t bytes, int64_t *pnum,
+                     int64_t *map, BlockDriverState **file);
+int co_wrapper_mixed_bdrv_rdlock bdrv_block_status(BlockDriverState *bs, int64_t offset,
+                                                   int64_t bytes, int64_t *pnum,
+                                                   int64_t *map, BlockDriverState **file);
 
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
2.40.1


