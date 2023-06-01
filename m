Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31352719B35
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqp-0001Tk-OJ; Thu, 01 Jun 2023 07:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqe-0001L0-Dh
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqb-0000Ns-RA
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+OV1Wjlf5YFldxkwSVEmSX2qCVj1nsZjcStFqGwzolQ=;
 b=BvSZZMtTQ1iZBnHICikeIk8Y7THykGFFAcEvm9MxgzVcWOoV7Oz71zoNknEOR0u7NSWcRu
 dOevel/ClgyH5UECZHCe3tZZok2o7FcCfo4VgEXDGeXcjhre7SDXVsq+zPLpG/8ZqJaJdq
 93LnBG7lXQIbEcqcuod3aoFLa+hno/U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-x03aBadfPEGQPwq_LIOp0A-1; Thu, 01 Jun 2023 07:51:59 -0400
X-MC-Unique: x03aBadfPEGQPwq_LIOp0A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-506beab6a73so693121a12.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620318; x=1688212318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+OV1Wjlf5YFldxkwSVEmSX2qCVj1nsZjcStFqGwzolQ=;
 b=LdNeplctlQVyfFwqgv1Fth7utt6SeSeSnU71rwaL40mY5MnujvdVPA20ix8FBOnc+b
 d2JKlLiayMRV99Be1YOFS+G9lGoIMTikglB+UZs5FJ3fig4n9FyYLMjAHFT46/3OqkwH
 EV4Q1zxznOE8kkkeWi49p4sVqzyPrLsev3LyWCq3J7TD2g8YN99JLc4iibSfQL//842R
 qxDcDb5rNb8zMYxvux5HgG3Og86tvg8pl0lluF6rkilS4EMynGB7VnnQ8PJWfeZ5TnMY
 QERn2n3WTajWV4b9mF6sOyBGFGfXJeWOQbIWuXlkj7qRTusF5ja6a4yXzuc36QhQtpJJ
 87tA==
X-Gm-Message-State: AC+VfDx6TX9tBnr4vyhjmmpMZRMpTJ70BFWue9WkN9VhytdtBD3f1T7l
 8fU6ENH4ByknDjHa3yn8ZJj/RKGWU3iWDmiEBabgKOoPpXxwZ3F4eRNJ1ZB5XanrGe46Oiuk60n
 TKy+rR5aad8oiJqPu7xEHzSR4Y1+0PxMkF29P0LdOP0E3A5r1Np+/m4jPsAWMZLu5HFJMD8jfNi
 8=
X-Received: by 2002:aa7:d594:0:b0:514:80d1:2790 with SMTP id
 r20-20020aa7d594000000b0051480d12790mr5508291edq.35.1685620317927; 
 Thu, 01 Jun 2023 04:51:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5U9q/rOclgfZ4AjrmqK21hiDzbxo/NPkb8peqWRFtyf3E25aGATzyIH0nY4oZm4L/aA600GA==
X-Received: by 2002:aa7:d594:0:b0:514:80d1:2790 with SMTP id
 r20-20020aa7d594000000b0051480d12790mr5508283edq.35.1685620317701; 
 Thu, 01 Jun 2023 04:51:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a05640206cf00b004fbdfbb5acesm7071254edy.89.2023.06.01.04.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 07/12] dmg: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Thu,  1 Jun 2023 13:51:40 +0200
Message-Id: <20230601115145.196465-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/dmg.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 2769900359f8..06a0244a9c16 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -616,7 +616,8 @@ err:
     return s->n_chunks; /* error */
 }
 
-static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
+static int coroutine_fn GRAPH_RDLOCK
+dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
 {
     BDRVDMGState *s = bs->opaque;
 
@@ -633,8 +634,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
         case UDZO: { /* zlib compressed */
             /* we need to buffer, because only the chunk as whole can be
              * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->compressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->compressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -659,8 +660,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             }
             /* we need to buffer, because only the chunk as whole can be
              * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->compressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->compressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -680,8 +681,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             }
             /* we need to buffer, because only the chunk as whole can be
              * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->compressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->compressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -696,8 +697,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             }
             break;
         case UDRW: /* copy */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->uncompressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->uncompressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -713,7 +714,7 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
     return 0;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 dmg_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
-- 
2.40.1


