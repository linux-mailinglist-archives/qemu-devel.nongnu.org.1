Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECC47D7882
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHi-0001T7-Jk; Wed, 25 Oct 2023 19:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHa-0001SX-Oz
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHZ-0004Yg-2b
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x2D5Lo9YsBqjEHAHqJRyKlld+oGVsMJ1cZh4X4sFpSc=;
 b=EycJvxtVBFdnkqvFRoGHhnKfQMHLkFU1OOnBRlOpOb4IEUO3MJIV38V+ZgRd6obnTL1aLw
 A8T4y9fYSezMF6HojWo9THX01FWML17JJ/s9/xZA8nFu1rnEZ/m+Y4OnoHrbhciTtL6ilc
 rRrJ/ZP/WrIUqnAkiRl/WUlSxPMVSow=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-ASF8Io-uMaukKD7RCqIElQ-1; Wed, 25 Oct 2023 19:27:22 -0400
X-MC-Unique: ASF8Io-uMaukKD7RCqIElQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d87503d24so3984566d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276442; x=1698881242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x2D5Lo9YsBqjEHAHqJRyKlld+oGVsMJ1cZh4X4sFpSc=;
 b=vovvKv2ou5nTP1hP9mVOksfK/ypPkeGK+jbyh1wSiyFw1kdcfF+m+2UueHFiau8J2n
 tsu7E0fDNabfWNrqUsAWAKV/7n9dq7WvjAsplETBApH9818sWaumNUkoBqUHvg3ma2ut
 ceycE+KzRvrIiZ87ix1dgdd4D0tpt0rUAUtG0y5xO2WkdPdTiIhjEcc7rYkSmb6AbNgt
 LAFHKReU78rSWLio7XbPlJTbAh0LJoLUxTEr9gUdRft3ZokWN1akvJXevr2JgPw5p+UU
 d5VjMlfUwIKNnmKIfRPzZ29oSA98GUT7rsOdaWdFxtOLgwZONYU8bwbWd+gjhBKeBaIa
 dCLQ==
X-Gm-Message-State: AOJu0YwK1IWR7YFwDHHwJHoNcvc8ozYbLocUVMx0c1YJKg1EmfZmFSwD
 NkvoranHW82CZLOuLBejJa2OCdf2DApvFpPVM6Ztxr37WJov/wA+gPpCdLCssMpWZC1iCmGy6+i
 jeF4T5m0WhLUHcw5vfJj2YQCjdHIlpanoyiI+Si3vk+qx92rOnYAYxd+Eeol8leoMqcnEV2YLk4
 0=
X-Received: by 2002:a05:6214:3005:b0:658:8f94:5e61 with SMTP id
 ke5-20020a056214300500b006588f945e61mr19348707qvb.43.1698276441779; 
 Wed, 25 Oct 2023 16:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHX3ekVKIGkguq6xLq0KX5iRjlIsRHMBD8xH2OtuAEn8NqwBjCNQbiJMgq2o4qzDYKlI833tg==
X-Received: by 2002:a05:6214:3005:b0:658:8f94:5e61 with SMTP id
 ke5-20020a056214300500b006588f945e61mr19348693qvb.43.1698276441433; 
 Wed, 25 Oct 2023 16:27:21 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 b5-20020ad45185000000b0063d5d173a51sm4795890qvp.50.2023.10.25.16.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/24] tests/tcg: fix out-of-bounds access in test-avx
Date: Thu, 26 Oct 2023 01:26:54 +0200
Message-ID: <20231025232718.89428-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This can cause differences between native and QEMU execution, due
to ASLR.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index c39c0e5bce8..910b0673535 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -236,12 +236,15 @@ v4di val_i64[] = {
 
 v4di deadbeef = {0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull,
                  0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull};
-v4di indexq = {0x000000000000001full, 0x000000000000008full,
-               0xffffffffffffffffull, 0xffffffffffffff5full};
-v4di indexd = {0x00000002000000efull, 0xfffffff500000010ull,
-               0x0000000afffffff0ull, 0x000000000000000eull};
+/* &gather_mem[0x10] is 512 bytes from the base; indices must be >=-64, <64
+ * to account for scaling by 8 */
+v4di indexq = {0x000000000000001full, 0x000000000000003dull,
+               0xffffffffffffffffull, 0xffffffffffffffdfull};
+v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
+               0x0000003afffffff0ull, 0x000000000000000eull};
 
 v4di gather_mem[0x20];
+_Static_assert(sizeof(gather_mem) == 1024);
 
 void init_f16reg(v4di *r)
 {
-- 
2.41.0


