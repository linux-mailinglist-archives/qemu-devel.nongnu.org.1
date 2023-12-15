Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAC8146C1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6Gg-0005Zl-Pt; Fri, 15 Dec 2023 06:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6Ge-0005Zd-1w
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:22:08 -0500
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6Gc-0001Cg-JO
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:22:07 -0500
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ba14203a34so503399b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639325; x=1703244125;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VZJAznuesX8ySXoW7pIxzli6WPy8swHkLJj7jCZBmjA=;
 b=FF1UwSNmxQIorLIgLbDRCpsW8bJ3UHUpkg78rAoRIjMWvCi605Nc+KSE7QadK5YMWp
 pYeIzyaVOJlWPOvbSgL71l43y8FkU/3eSAUuOdOfGfeI5OE2jDXc/0LrK2cw7MTl/F4x
 znHJxTC/eDKjw1Z2cn6AsnYGDRS0hZHn0rscf9/7qHR6Q7X1dzsh7NjJP8n3dSf8Q+kC
 Q5lSl4slSvKdD/CfnE0QvYet2vDKLeeyWfw5Iyl633BSX71Pk9XlV5tZSIi5a2a+YnxO
 JsRYmavQIk4KBSaRDD41sOiz52bdq2bpc7V1ZEs+0A7KHuE0aAUJS29JQJGUTmGbqWAO
 Ez2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639325; x=1703244125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VZJAznuesX8ySXoW7pIxzli6WPy8swHkLJj7jCZBmjA=;
 b=s63/8BI6nLOavY1HTaMWe/2l2hWh2OjEMghI55w4+IJAvP0Pal/iR9CSDe39Sn8kYo
 oIgbPR5KhKdIWwteNr8NPOw9Bqzj/xkvbQm2NpAlWh2Fa0MkJJ4tmh/pB5ThPZkWVUmX
 /KOKJjFl7Vb+2DTWhWGTLuEMcjKjaEB5baZ1HEtjxpb1Wa7oJ9gobpAzCRku64Ng9Cg0
 H9/jfek98JaQUHi1TjMFfmZ5dDWqqnRftX+NalHSkcBj/IqMTelmjfwLs0DhhYe4uT03
 10BJ2ZQHvffoM+CNTVLl0LbR8t3gRiIa3gsoq5JitodbKSKEyOIzx7dgxrD0xbH9+1tZ
 09fQ==
X-Gm-Message-State: AOJu0YxSaAIFiEQXPRJ5u4HuRQpmGFIO+XbfQDxTARBQJ8FB/IRCn/e/
 gveNo1PjPyrTzLWpgIrRVGFECw==
X-Google-Smtp-Source: AGHT+IG9P712V8Sh4aHGXFs1aFC0yCXQgvMRwrrTv97RPbOS3WB7AZVZGFIxlI1uUOMOzKm7bsW88w==
X-Received: by 2002:a05:6870:ef0e:b0:1ea:2e2c:e9e7 with SMTP id
 qq14-20020a056870ef0e00b001ea2e2ce9e7mr12860432oab.59.1702639325107; 
 Fri, 15 Dec 2023 03:22:05 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 27-20020a630f5b000000b005891f3af36asm12945681pgp.87.2023.12.15.03.22.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:22:04 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:21:38 +0900
Subject: [PATCH 3/4] meson: Explicitly specify dbus-display1.h dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v1-3-349e059ac5b2@daynix.com>
References: <20231215-dbus-v1-0-349e059ac5b2@daynix.com>
In-Reply-To: <20231215-dbus-v1-0-349e059ac5b2@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Explicitly specify dbus-display1.h as a dependency so that files
depending on it will not get compiled too early.

Fixes: 1222070e7728 ("meson: ensure dbus-display generated code is built before other units")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 5e1b25a47184..c31168e11cfb 100644
--- a/meson.build
+++ b/meson.build
@@ -2032,7 +2032,7 @@ if dbus_display
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
   dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
+  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, sources: dbus_display1[0])
 endif
 
 have_virtfs = get_option('virtfs') \

-- 
2.43.0


