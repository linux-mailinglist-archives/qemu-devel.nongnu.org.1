Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC00719B3F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqi-0001Hi-72; Thu, 01 Jun 2023 07:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqX-0000st-9Z
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqU-0000LU-3s
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9njw4Wxx0XeRAgmG7XlsOr0DLciSKleqOdESpyjG1rU=;
 b=PNcjjBAj7xL/8soQW+qz6yVj6+4BhZGU8zfaS4n07ENYlHY0i6iV5kdZ7H3WKhhKtypZLh
 ebcyCmq+GAsdEDF+04kTExZyQhh2QjDTC3hsaHDDu2z2K9ffwSR0mGz1EFSBtRqrKl3HeF
 tLHMPrVNTdAJjy9Aozv0+hcL+dT90Ng=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-sr1Het0NPgCFYN33XbvQ_Q-1; Thu, 01 Jun 2023 07:51:56 -0400
X-MC-Unique: sr1Het0NPgCFYN33XbvQ_Q-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96fe843f61eso55370466b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620315; x=1688212315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9njw4Wxx0XeRAgmG7XlsOr0DLciSKleqOdESpyjG1rU=;
 b=AlOa9lbP/IAZAm1vPHwlzCxjMNPtGzzjxYt+zmvgSkx2dlbcOaDYWOkuy+AxFIb+U0
 oXsZLZ42klb2owhHO8wS0x+VeKlU0m2Uep1gQ3dLs5DsZTv8TLwOqKllYRdTJczNOvQy
 /i/ZLbUX2mKaYtXYvmaR0xLJ0obKjHV1tYWhSK9nAG8cD9B4pNdQyJmTJprZmf4vyzm5
 tUmEyqJ44M4F/kf+ZU8WP08EZKAWaz2DHuw5mjfYaarBrDDj/taJSWetRTsbZeVu90hh
 VFg3q8iGvt0UMPQBCwCYaclNP8IkuTCg3A8SyG+hXbBk+X4YQ1XjQr1HpDaA1+c3Qrs9
 nWFA==
X-Gm-Message-State: AC+VfDzvJh/HkC3alSdAtwq+Cuatr7+ID96Sq1oTwDcVBI3gqzIDW9t0
 tESr++LdFkWGKWj0ouuDO4BsVPBJrL4Tqh6Q7IjPGvKlkz/pJaVO3ZDUIclEbibe+3m8XZPqIaU
 KRusHn4CgDdpyB8vjgMY+XXwikaEzP7TH8mSSc/wHQkYU0fsOFCSNOaYDM/rqfZq9dQLYB9rv8v
 k=
X-Received: by 2002:aa7:ccd1:0:b0:514:75c3:269b with SMTP id
 y17-20020aa7ccd1000000b0051475c3269bmr5159105edt.41.1685620314852; 
 Thu, 01 Jun 2023 04:51:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41w+Nr7HmXymW5WeHUQVtpndmgok1IQVhAqFhS4MOlmP+eb9WuK9cXV3LSmQQb3ghm1TxbrQ==
X-Received: by 2002:aa7:ccd1:0:b0:514:75c3:269b with SMTP id
 y17-20020aa7ccd1000000b0051475c3269bmr5159095edt.41.1685620314650; 
 Thu, 01 Jun 2023 04:51:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a056402345300b00504ecc4fa96sm7043082edc.95.2023.06.01.04.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 05/12] block: mark another function as coroutine_fns and
 GRAPH_UNLOCKED
Date: Thu,  1 Jun 2023 13:51:38 +0200
Message-Id: <20230601115145.196465-6-pbonzini@redhat.com>
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
and they can suspend.  Because this function operates on a BlockBackend, mark it
GRAPH_UNLOCKED.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 113e3d90fd52..98cba7d11a56 100644
--- a/block.c
+++ b/block.c
@@ -555,8 +555,9 @@ int coroutine_fn bdrv_co_create(BlockDriver *drv, const char *filename,
  * On success, return @blk's actual length.
  * Otherwise, return -errno.
  */
-static int64_t create_file_fallback_truncate(BlockBackend *blk,
-                                             int64_t minimum_size, Error **errp)
+static int64_t coroutine_fn GRAPH_UNLOCKED
+create_file_fallback_truncate(BlockBackend *blk, int64_t minimum_size,
+                              Error **errp)
 {
     Error *local_err = NULL;
     int64_t size;
@@ -564,14 +565,14 @@ static int64_t create_file_fallback_truncate(BlockBackend *blk,
 
     GLOBAL_STATE_CODE();
 
-    ret = blk_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, 0,
-                       &local_err);
+    ret = blk_co_truncate(blk, minimum_size, false, PREALLOC_MODE_OFF, 0,
+                          &local_err);
     if (ret < 0 && ret != -ENOTSUP) {
         error_propagate(errp, local_err);
         return ret;
     }
 
-    size = blk_getlength(blk);
+    size = blk_co_getlength(blk);
     if (size < 0) {
         error_free(local_err);
         error_setg_errno(errp, -size,
-- 
2.40.1


