Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409A719B48
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:55:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqe-0001IL-4r; Thu, 01 Jun 2023 07:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqZ-00014D-L3
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqX-0000M0-1m
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9kOsnTIfr8LoecIGmkq1o/fbSu4HEOyb00hkoyFBiI=;
 b=W1P8ve4Z2quHoYPn57adH3eUGB56qxq7bnF/3hVzp9rgEFSB8rMShVloCw3tPHVzSyIxER
 Y5wFtntExFtGF8L6oJwZtLbOyCSKnifGEuozx/cEPfOLBz1OfrQ+fInfQiqTFbtEfjt98J
 7NyQwjYea0+Sqd+xOcexO0i2HFWIrqo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-kVlOH6zfNJWXhbE5GmXY3g-1; Thu, 01 Jun 2023 07:51:58 -0400
X-MC-Unique: kVlOH6zfNJWXhbE5GmXY3g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f9aa23593so52997466b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620316; x=1688212316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9kOsnTIfr8LoecIGmkq1o/fbSu4HEOyb00hkoyFBiI=;
 b=lENSjqHpbXhBievVk5JcYbguhz3YAJO4hdRsOx8gt8iPlvxwAihs8vTPmqUfYqG0+r
 LMnV/8SAXbTlNYcaEJyP5kK4eGLtQSBCYowgDXfyWZtLwnvC+peDtqzHiTkVAAS4TuvC
 M7sFGmQY94usX6WCGrMkDzeJrmrVJPiVfujCOt8MWvCWYf3LlF/iVJfJjVRMHUAVRxlM
 O4Sq7vuJPLwbhs4AYvoggC73fLlKYDFW3Ci0mwJS1JxG9CW5Lw7J/Ly62MmaBhyYd2sG
 XXaiQnGYGrr3Z3MtN9dZ1Ho0O1HPv8Kzk+37v3FHxzfHBwQ7xBPNtXAzQehyXFf+cxSs
 afqA==
X-Gm-Message-State: AC+VfDwIGiTuv+2AeYWba/oMXEtOworjaqZcCQwh7lrWvy3iU1c3IAQu
 HvdwQj2sx6F84T9+dPeFhyNKME4+z/llOqCahaqdsuc7+eHMLnt6v0+SRgN1pPaRvV6fqRqukt8
 zUw+up6iFy+cx6JeAIGYxwuYshF2C97ATV4nsxMoJpstFfe94K+ryr5xYwVRI+gWbYVehsWovoB
 o=
X-Received: by 2002:a17:907:a426:b0:96f:c988:93b with SMTP id
 sg38-20020a170907a42600b0096fc988093bmr8487682ejc.35.1685620316436; 
 Thu, 01 Jun 2023 04:51:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4P2xh7UnML4pw2fmW4w4oc8vwIV//SO3pXMkNNQ5danwkusOKFGdBZ/NzRDEsxzy7OUhAZOA==
X-Received: by 2002:a17:907:a426:b0:96f:c988:93b with SMTP id
 sg38-20020a170907a42600b0096fc988093bmr8487672ejc.35.1685620316133; 
 Thu, 01 Jun 2023 04:51:56 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 jx10-20020a170906ca4a00b00966293c06e9sm10405407ejb.126.2023.06.01.04.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 06/12] cloop: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Thu,  1 Jun 2023 13:51:39 +0200
Message-Id: <20230601115145.196465-7-pbonzini@redhat.com>
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

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/cloop.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/cloop.c b/block/cloop.c
index 1e5a52d6b2dc..835a0fe3da0a 100644
--- a/block/cloop.c
+++ b/block/cloop.c
@@ -212,7 +212,8 @@ static void cloop_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
 }
 
-static inline int cloop_read_block(BlockDriverState *bs, int block_num)
+static int coroutine_fn GRAPH_RDLOCK
+cloop_read_block(BlockDriverState *bs, int block_num)
 {
     BDRVCloopState *s = bs->opaque;
 
@@ -220,8 +221,8 @@ static inline int cloop_read_block(BlockDriverState *bs, int block_num)
         int ret;
         uint32_t bytes = s->offsets[block_num + 1] - s->offsets[block_num];
 
-        ret = bdrv_pread(bs->file, s->offsets[block_num], bytes,
-                         s->compressed_block, 0);
+        ret = bdrv_co_pread(bs->file, s->offsets[block_num], bytes,
+                            s->compressed_block, 0);
         if (ret < 0) {
             return -1;
         }
@@ -244,7 +245,7 @@ static inline int cloop_read_block(BlockDriverState *bs, int block_num)
     return 0;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 cloop_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
                 QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
-- 
2.40.1


