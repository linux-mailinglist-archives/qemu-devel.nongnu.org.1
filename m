Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC378EE34
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLU-0008BO-Js; Thu, 31 Aug 2023 09:04:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhI8-0000cB-8i
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhI3-0006sf-A1
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:00:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401d6f6b2e0so12599255e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486849; x=1694091649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3i3x9Dz9RPQMfZg42SaVktArQRa8La0Ylbd8e6a9o0U=;
 b=zEH0iJL+V+rjDrfQxhE5J2nzbDpkMrjFG3D0pu7MwPtKl6ZYCFrmVBc64exOSzoluB
 yfMsgWGOpMLdkQEkrrA9Oce8Ohn9eWbOt+Dhpn1DrYVdAuuAZ0h22ZgXHtTWsKDhwCHC
 OLZ9EK520G953eDL0NPCYG0JApVmtXqA7bElZj6GE/0kZIX8y/il0qr9t3pHmFiIVfuO
 jKFh+s/+pUvBVK9LpTamlM2lJeIa/GQAD3F9zHuiQd35hRl4Maml+ioZ0WotHZG4pkrQ
 j2DiEpjgiOM1kC/HBo9VuwFTFPq6yxvlsi7o6hrXx93z3m1ab3fmNqt1s76P/5LcGumR
 hC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486849; x=1694091649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3i3x9Dz9RPQMfZg42SaVktArQRa8La0Ylbd8e6a9o0U=;
 b=Kro5ZlXuvsOHVjlzAMM3RgybDmUEBVTD0iGlnL8XeJiT+jFlsPAKAsP7XjoLcl+F0j
 jj4zfyaPV8LYCFKLKjuNo/vgYqMwfpzWe0T4eLFknkpETYv1wfLgnMmL4ilv6gTIqPgS
 g08m5xZIW4J4dNLcdNZK+KF5IosWRQmBE03jVxaf5ZLPbrS2BGFPkolnq7Z/up74H4z2
 T4X6qo+SIH9zowgOHwGmPf7vtaIydo7cIQInDRE7pbTtyjUDikl6PpyrzcLA2/hXkQav
 gc/39QI2Qpq6L2yj2F2bgt4kg7tUc4rFDMgK2eMFf5rin28Ga9vyLXHtbbsAMCv3VzFt
 3XFg==
X-Gm-Message-State: AOJu0YyHvzbXjC62+3MJKJqlzZ9oAtDvWJU2zi02q6LHYS4k4qt0oVZK
 wg8JQQC4EJvHCSQvDEHmeLczaRSTClw6q8Kb7os=
X-Google-Smtp-Source: AGHT+IG63RqkQQLx6ClVdxVWGMzticufPFEl54JhCs9R/skP/hLCJLgkikmjQqaryDzkkLzCezMlaQ==
X-Received: by 2002:a1c:720e:0:b0:400:5962:6aa9 with SMTP id
 n14-20020a1c720e000000b0040059626aa9mr2085595wmc.11.1693486848995; 
 Thu, 31 Aug 2023 06:00:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 q12-20020adffecc000000b00316eb7770b8sm2197901wrs.5.2023.08.31.06.00.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 06:00:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Alexander Graf <graf@amazon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 40/41] build: Only define OS_OBJECT_USE_OBJC with gcc
Date: Thu, 31 Aug 2023 14:56:42 +0200
Message-ID: <20230831125646.67855-41-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Recent versions of macOS use clang instead of gcc. The OS_OBJECT_USE_OBJC
define is only necessary when building with gcc. Let's not define it when
building with clang.

With this patch, I can successfully include GCD headers in QEMU when
building with clang.

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20230830161425.91946-2-graf@amazon.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ec14079c67..296f6ef1d2 100644
--- a/meson.build
+++ b/meson.build
@@ -223,7 +223,9 @@ qemu_ldflags = []
 if targetos == 'darwin'
   # Disable attempts to use ObjectiveC features in os/object.h since they
   # won't work when we're compiling with gcc as a C compiler.
-  qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
+  if compiler.get_id() == 'gcc'
+    qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
+  endif
 elif targetos == 'solaris'
   # needed for CMSG_ macros in sys/socket.h
   qemu_common_flags += '-D_XOPEN_SOURCE=600'
-- 
2.41.0


