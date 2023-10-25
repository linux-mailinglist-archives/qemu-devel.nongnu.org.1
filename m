Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4037D7896
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:31:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHr-0001Ww-Qq; Wed, 25 Oct 2023 19:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHo-0001Vj-Io
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHn-0004v8-3k
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G3e9uvV4JGS/OhL7G758eusTQY0UiPA4wc0ufl5khLY=;
 b=JZ/HwkABLnp6HkR89qlYcHNwOH/uIE4seRhCvlFAb7sTXjuZHZTexkZh/tp0i2w0I1jo2q
 dpWPrzSztyw6B4e/zBVGJ0tKR4Dc1aJHXufjAJfmcnX7cUferVLvZ7I4W54TUzpvkLGlo0
 vAEy/whoqeHFhr9+7yoZccdMQSdnSRw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-uGiDcwoKObOKoczrmumBsg-1; Wed, 25 Oct 2023 19:27:27 -0400
X-MC-Unique: uGiDcwoKObOKoczrmumBsg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7788fb069abso42450585a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276446; x=1698881246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G3e9uvV4JGS/OhL7G758eusTQY0UiPA4wc0ufl5khLY=;
 b=PHmwPsBwG56Ovez/lXIahWrtIIpvLdU8V07FFN7obT4xYLbIPSL4fMBdi6dPGQnrZA
 KoXROyo2VCh7f9m2VivgiK4BI1n+o5N9Q0nocswefO97Dzz8mHrA9aFiwFUiYkPVqUIw
 kT2IdYlqPnm3H+lg+vhHKzY6G8WQgbdUK4CIu2In1SzDSTlALUb2CGY58D7QSoVD4+AB
 afc3PHdj/9s++80ztE7mmbCkTZ6lo8c1Vjfcl6Q8bjAj7ro+cUKWsEWF8NzWQlKSQE9i
 N/fTgY4/4sC2NL1tDYspfr/gGdt8SKGxZnsFTGYOXfDp5cbzsasCnkZS8qVOxpOJxIwQ
 DIKg==
X-Gm-Message-State: AOJu0Yxuzb+4dTJzhHVuBJNK9fgqDSYyP2gUn/FfMyXq3q7GEg/nb4vv
 a73IaVJY/kfMI5dTqBhPaCyVE8YchTsAnuils8dW8sJaKrxUI8r4TF4TswzD4uK8I7CT8c3mhnx
 EZd09VBwwl/Tsze+BgUk0L9EbIBFMqfMLAur33TSDHW8Iu4aNa/cq+a3pu7NodQG26fm+AfuWYK
 I=
X-Received: by 2002:a05:620a:198f:b0:76d:a784:9685 with SMTP id
 bm15-20020a05620a198f00b0076da7849685mr1616617qkb.28.1698276445925; 
 Wed, 25 Oct 2023 16:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp409aJB8b0kFu1f9+Nzm6URtzF4yCzq07bnf6al1R/TGisdd6AOu2teX1wsQn1ZKiO1OsEA==
X-Received: by 2002:a05:620a:198f:b0:76d:a784:9685 with SMTP id
 bm15-20020a05620a198f00b0076da7849685mr1616602qkb.28.1698276445611; 
 Wed, 25 Oct 2023 16:27:25 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a05620a208b00b00777063b89casm4554256qka.5.2023.10.25.16.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/24] tests/tcg/i386: initialize more registers in test-avx
Date: Thu, 26 Oct 2023 01:26:56 +0200
Message-ID: <20231025232718.89428-4-pbonzini@redhat.com>
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

Some instructions use YMM0 implicitly, or use YMM9 as a read-modify-write
register destination.  Initialize those registers as well.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index 910b0673535..230e6d84b84 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -319,6 +319,8 @@ int main(int argc, char *argv[])
     int i;
 
     init_all(&initI);
+    init_intreg(&initI.ymm[0]);
+    init_intreg(&initI.ymm[9]);
     init_intreg(&initI.ymm[10]);
     init_intreg(&initI.ymm[11]);
     init_intreg(&initI.ymm[12]);
@@ -327,6 +329,8 @@ int main(int argc, char *argv[])
     dump_regs(&initI);
 
     init_all(&initF16);
+    init_f16reg(&initF16.ymm[0]);
+    init_f16reg(&initF16.ymm[9]);
     init_f16reg(&initF16.ymm[10]);
     init_f16reg(&initF16.ymm[11]);
     init_f16reg(&initF16.ymm[12]);
@@ -336,6 +340,8 @@ int main(int argc, char *argv[])
     dump_regs(&initF16);
 
     init_all(&initF32);
+    init_f32reg(&initF32.ymm[0]);
+    init_f32reg(&initF32.ymm[9]);
     init_f32reg(&initF32.ymm[10]);
     init_f32reg(&initF32.ymm[11]);
     init_f32reg(&initF32.ymm[12]);
@@ -345,6 +351,8 @@ int main(int argc, char *argv[])
     dump_regs(&initF32);
 
     init_all(&initF64);
+    init_f64reg(&initF64.ymm[0]);
+    init_f64reg(&initF64.ymm[9]);
     init_f64reg(&initF64.ymm[10]);
     init_f64reg(&initF64.ymm[11]);
     init_f64reg(&initF64.ymm[12]);
-- 
2.41.0


