Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CDB719B3E
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqk-0001IO-2j; Thu, 01 Jun 2023 07:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqW-0000nG-3I
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqS-0000Kv-Hs
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yLwJ0tgwKXkMFjE8GLsGzdve4xY6BIM2K13yGYNufvU=;
 b=hhBXKDn0Y+4vj6RRoVmN4zcG4+YR6sjGNeMc7MXMpYa+/19BxT8f9fEVYUdz9H19mVxL2Z
 KErIKhxV4jHPSt5FExypFt11scorJy4RsiWaEJJcq1TLrTQSrEF4w8eYWgQsbvIaW9oqiV
 yINmWmKFky2+EOOOIoxXaJJscYfSYEs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-7XhHNZNePOyYWv92jLybIA-1; Thu, 01 Jun 2023 07:51:54 -0400
X-MC-Unique: 7XhHNZNePOyYWv92jLybIA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9744659b7b5so55308566b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620313; x=1688212313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLwJ0tgwKXkMFjE8GLsGzdve4xY6BIM2K13yGYNufvU=;
 b=J7t2CYng8gS5K1ORmBa1tXfHJFa8R6chq/0BjEnLpKZduZMAVhYYNksjSWCDiYZRGc
 hiFzl8eLutPGjCkDOTN9sMqLcl1GDBWK53NmgASor60lfcTB5CfRMTPRtvz7mtSEE0HB
 N+u8rwg/YVHoHzJA2z8SGVnelCZCSPt0u1o7rRlJmBhDHkJyEjH4CAfxJYn6c/lZwZdt
 xrrz/2t9TmFQ16W+elFeJiwMvDyQEyFonfU/e6xmsOlZccDjbcXqhnriJVlF4jPbMkAY
 qGgmiIksVBQeeBd3prz9oXYZXsPFoE6M0xwXkyWhB9a4rJnr40l0YFpAFWv0VvUILcta
 xs4w==
X-Gm-Message-State: AC+VfDy3HlZiS/7OPpoo2EAS0toaRzFZcd/HWiomnBPX2oHYH8NGo8G8
 Q7av6DMWv528iLbRccGqAU8asX/U8uu/1IGJXhQIVdmKg+Rir3ku7RHJX7UFDTswDQRy3DnVmJs
 tXA8dZjO7T1zBpWQgAc3d+DbRbyo3d5voGu1wbWqpUsrAOgGjBuEryCQdce/LoR+H6A+9pMzoDx
 c=
X-Received: by 2002:a17:906:dac1:b0:973:cb21:8479 with SMTP id
 xi1-20020a170906dac100b00973cb218479mr4557886ejb.70.1685620313323; 
 Thu, 01 Jun 2023 04:51:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BYuwwWOJV+aQscEPvfyPiLiMVzgQEct88iBX4grd1K2KGQ20uk8dhMMSOkIci4ax66u9u6Q==
X-Received: by 2002:a17:906:dac1:b0:973:cb21:8479 with SMTP id
 xi1-20020a170906dac100b00973cb218479mr4557875ejb.70.1685620313109; 
 Thu, 01 Jun 2023 04:51:53 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a1709062a1600b0096b1206aa3fsm10532251eje.89.2023.06.01.04.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 04/12] bochs: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Thu,  1 Jun 2023 13:51:37 +0200
Message-Id: <20230601115145.196465-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
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
 block/bochs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bochs.c b/block/bochs.c
index 2f5ae52c908d..66e7a58e5e31 100644
--- a/block/bochs.c
+++ b/block/bochs.c
@@ -203,7 +203,8 @@ static void bochs_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.request_alignment = BDRV_SECTOR_SIZE; /* No sub-sector I/O */
 }
 
-static int64_t seek_to_sector(BlockDriverState *bs, int64_t sector_num)
+static int64_t coroutine_fn GRAPH_RDLOCK
+seek_to_sector(BlockDriverState *bs, int64_t sector_num)
 {
     BDRVBochsState *s = bs->opaque;
     uint64_t offset = sector_num * 512;
@@ -224,8 +225,8 @@ static int64_t seek_to_sector(BlockDriverState *bs, int64_t sector_num)
         (s->extent_blocks + s->bitmap_blocks));
 
     /* read in bitmap for current extent */
-    ret = bdrv_pread(bs->file, bitmap_offset + (extent_offset / 8), 1,
-                     &bitmap_entry, 0);
+    ret = bdrv_co_pread(bs->file, bitmap_offset + (extent_offset / 8), 1,
+                        &bitmap_entry, 0);
     if (ret < 0) {
         return ret;
     }
-- 
2.40.1


