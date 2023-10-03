Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F257B7566
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnov8-0003wZ-Im; Tue, 03 Oct 2023 19:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov6-0003vz-Rx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:16 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov5-0006hl-Ay
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:16 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a2a9e5451bso58458339f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376113; x=1696980913;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qAzCYw2NEfSKNP7dM+RUN8lAAw5B4Z+NHtHEbIs3+uw=;
 b=jRepES0hLoCFN5mZF/I2IM2SMeZhrG36Mh8riZA3wA8He0E/UIdRnMUrAfDc89hpV7
 u12R2BqXgSTqlTc1i0ZrHho5695MnRLnrD5OCMk6xgZcQ3LYtdv24BcCrSLgpCS04HzD
 Z6KI4NBHm9u2GNQZM1QuNobYfIRJPVOk9avC7byh32w6BdfuHgTEYFElHDvvluXOdwXx
 ni9VZctDICCdXVH5JWN/S2AOhnABAh+uHFqlrbZbN45oRY7OLSyz5rLe5lzQNbS/6yvW
 oVz+RP/9qtefLEt8FeVyJCfs5oQQxX6USbZI32fsoeI/GpQFpYPyhr0JNKjYqM3wuzH0
 2JUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376113; x=1696980913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qAzCYw2NEfSKNP7dM+RUN8lAAw5B4Z+NHtHEbIs3+uw=;
 b=WeTis2S0YUinbPNI1ZKIBYnVoUeDXWY2VTqXMYkdyLgcPgW47MB3ANsWOnyVKlKADo
 4hIx/K2oVMJKln2gXvWLEYOniPXpS1cAAriEpBXVJvyhJUC5cQu5YjPQav7tIcRWtRl5
 edmi277KDFClUSYnEwv9sPP4pRSVQNUDSmab5Vq9bplBn6Tjez1TaeAQMxzP5h1OyvL4
 w6sVffsHjq7uOXQpkO5f9ymZEeyq8OUnB22yoUCGy3XDl+IBvkVqghZnobvKXArbboDg
 IKOglrkaac3FXeBDx4/wcDpYnGuUu6aa+ChWTTmD7o0AO+g5FDss2eL+6epbQiIhK5ia
 6faQ==
X-Gm-Message-State: AOJu0YwJ+/OJiEvzvAA4ZXdmGzv6sL/9kRw5MATtJHyYlNiaXdTB1501
 bstWGF/MDgRG6dbuSqxM4FUlTWelI7xvGfZ8K1zUWw==
X-Google-Smtp-Source: AGHT+IG90aPxYsj1Nu4V14DoTqZI2eaArW07wSDQHrRombzQoAqJJ4/yW0/Mugjt+lbAUx0mpkHKcw==
X-Received: by 2002:a6b:7e05:0:b0:792:7f26:dc95 with SMTP id
 i5-20020a6b7e05000000b007927f26dc95mr863296iom.14.1696376113341; 
 Tue, 03 Oct 2023 16:35:13 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:13 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/51] bsd-user: Implement target_to_host_rlim and
 host_to_target_rlim conversion.
Date: Tue,  3 Oct 2023 17:31:31 -0600
Message-ID: <20231003233215.95557-8-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-8-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-proc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
index 68410a0aa9d..19e39a2f764 100644
--- a/bsd-user/bsd-proc.c
+++ b/bsd-user/bsd-proc.c
@@ -38,3 +38,13 @@ int target_to_host_resource(int code)
     return code;
 }
 
+rlim_t target_to_host_rlim(abi_llong target_rlim)
+{
+    return tswap64(target_rlim);
+}
+
+abi_llong host_to_target_rlim(rlim_t rlim)
+{
+    return tswap64(rlim);
+}
+
-- 
2.41.0


