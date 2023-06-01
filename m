Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18157719B32
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqW-0000lW-0m; Thu, 01 Jun 2023 07:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqS-0000jI-75
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqP-0000Jl-Ce
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTnSEqDBVt1yhSZOW2KDdJhR08dElUQEsWstYjHBXcc=;
 b=Vf9HGbsv6/PxyrP5Xf4fA3il1U3yQ8fjETDm7iAII2+4m+DnzZdzpiKPcIrATGUzCBe7jT
 6C2PAPDCdlnhdxEf5/1sj0AphLGgfEUw/ZiL7410Q9Ool5qDB9XP/R+C1vGa4sLh++2Dzu
 WjAHzqgSvfw6V4kIHgTdg3NDpPRCAlY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-MqUi__lGPTe0MTs50xm1tg-1; Thu, 01 Jun 2023 07:51:51 -0400
X-MC-Unique: MqUi__lGPTe0MTs50xm1tg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96f4d917e06so249383266b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620310; x=1688212310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTnSEqDBVt1yhSZOW2KDdJhR08dElUQEsWstYjHBXcc=;
 b=kYMJ8rlWUEToVY1P0muSzAzofSU2S5uXdB2Ha83WlWx/wW45m1nuptPDUGMLrU2jHL
 jZ9OdMpPAQ2xhKaSqK7JNbNs069soT+AulbL1cIJPE2Csa0cYmut0vOiTBykiuyqcPHV
 ynUxZjjonw9S9YwyArdfclnhTwF6S1EBwmXKSuFUUYRi7IXlSBP7e5kvcBminTfEX92L
 wWT8/Mtq16rAZgzT9b3rQ3axt1rj/3jfjojiDtKO6f5sFoUCDKrqDbWXJEFYjvEpPrM/
 xSSfMTTZVcbw+4GFDBVdIfI9a2hQspyWYI2OSCib5u20OKLFXDqmPBSEsls4Wjq/MbK0
 qQ3Q==
X-Gm-Message-State: AC+VfDzW0KHey4vxRD/1wgpXZl07QqwTZjGgK9aX8SEEDVsE8K6PEiCu
 RIkjHHnEMor1/GbT26NibtVUh11I3kGE0K5t5R4FeTXXLPzDNwEREJQLpHeG6vcQ7WFeDHYZ9ng
 xgjEZyWJsHrNDV/smxUQ/LxXZHDT5wkO/jXUtqWhRoFXJW3i8X6JHoLJMykf1Q4ylrOK3Q88Oj2
 w=
X-Received: by 2002:a17:907:7ea4:b0:96f:d04c:1d84 with SMTP id
 qb36-20020a1709077ea400b0096fd04c1d84mr1458996ejc.12.1685620310228; 
 Thu, 01 Jun 2023 04:51:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4zlD1h9jOAz6d1mvQR9rSI7v/x2xw8ooXL4LrAPorgye4C9ccuF0taDPmvmaWpMHb3sovn1w==
X-Received: by 2002:a17:907:7ea4:b0:96f:d04c:1d84 with SMTP id
 qb36-20020a1709077ea400b0096fd04c1d84mr1458977ejc.12.1685620309978; 
 Thu, 01 Jun 2023 04:51:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 lt16-20020a170906fa9000b00973f1cd586fsm6747865ejb.1.2023.06.01.04.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 02/12] qed: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Thu,  1 Jun 2023 13:51:35 +0200
Message-Id: <20230601115145.196465-3-pbonzini@redhat.com>
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
 block/qed-check.c | 5 +++--
 block/qed.c       | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/qed-check.c b/block/qed-check.c
index 8fd94f405ed7..6a01b94f9c9c 100644
--- a/block/qed-check.c
+++ b/block/qed-check.c
@@ -200,7 +200,8 @@ static void qed_check_for_leaks(QEDCheck *check)
 /**
  * Mark an image clean once it passes check or has been repaired
  */
-static void qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
+static void coroutine_fn GRAPH_RDLOCK
+qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
 {
     /* Skip if there were unfixable corruptions or I/O errors */
     if (result->corruptions > 0 || result->check_errors > 0) {
@@ -213,7 +214,7 @@ static void qed_check_mark_clean(BDRVQEDState *s, BdrvCheckResult *result)
     }
 
     /* Ensure fixes reach storage before clearing check bit */
-    bdrv_flush(s->bs);
+    bdrv_co_flush(s->bs);
 
     s->header.features &= ~QED_F_NEED_CHECK;
     qed_write_header_sync(s);
diff --git a/block/qed.c b/block/qed.c
index 8e08f89bbd01..382c05c83fef 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -195,14 +195,15 @@ static bool qed_is_image_size_valid(uint64_t image_size, uint32_t cluster_size,
  *
  * The string is NUL-terminated.
  */
-static int qed_read_string(BdrvChild *file, uint64_t offset, size_t n,
-                           char *buf, size_t buflen)
+static int coroutine_fn GRAPH_RDLOCK
+qed_read_string(BdrvChild *file, uint64_t offset,
+                size_t n, char *buf, size_t buflen)
 {
     int ret;
     if (n >= buflen) {
         return -EINVAL;
     }
-    ret = bdrv_pread(file, offset, n, buf, 0);
+    ret = bdrv_co_pread(file, offset, n, buf, 0);
     if (ret < 0) {
         return ret;
     }
-- 
2.40.1


