Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86420815852
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 08:54:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEPUt-0003H3-A1; Sat, 16 Dec 2023 02:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUr-0003GU-0V
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:54:05 -0500
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUd-0000kx-SN
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:54:04 -0500
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35d699ec3caso5856415ab.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 23:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702713230; x=1703318030;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gq7IuwiCbAL4UxAqcWW6ByhjVTZVkTwXzK3NqvNRRfI=;
 b=FKLpakcJMoqECM2+/flpa3oE5JRqyrDtfI/eJLG6uI634Md/ayuEGJE51NLmeCVinw
 torI3TeYltdVLnAlUTilREvq5zoGlQAF5UI1c/F0xRij1qCd9pAEjgxxIosVwsXR/rC0
 0W/nZ3K9sg/du0A0GCK7Xg3Wk9t/bZvSTYa3osUzePBGeln9bh0iUnpN6XeZLJ1DCyi7
 R96KnfBtuL29wN9HGI8Hse3eUhCZuIsJ1efFB6uZyaJYVIzXf1tzXmFzkF0RoviuY6g2
 i31WF+k6ZsHN8pOlDGp+eP0r5MKBcxYu8xudAs0svWkZZ6aeNRGB2bhRkfref8YOSMdq
 elYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702713230; x=1703318030;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gq7IuwiCbAL4UxAqcWW6ByhjVTZVkTwXzK3NqvNRRfI=;
 b=BhslVWaXwC7GAJradOWprIZeSp/JfaOd98Lvk6gxidpdpYyh4UQOYcPa6aJc0jOsCR
 yN75XpYWI2VAqQFMCIYkoLSjAjWQDkrOhLFQ9vU4AW8q9qYBwj4fvVxdN5LaD79MZ9CM
 qRSARF95BBCDssV36xt2zK3hLDdHAeYGtO3EEaLnkKHHOQHZlvQypGock8Sy+z7pzQxl
 hGLCWIuvgHGBxBfcjfL/J4rJbUzYLp81ORqyJRUvpWJPB/F82QEjjThYnk6fa4F8bpKO
 DKFsX3iWiVQ6fjen/BGGvJ+Xq6xMVNbpovEshovpg5U3u+BGRAbu/DyRucKKkzFJE3qS
 leQQ==
X-Gm-Message-State: AOJu0YxuUALyzOrDpr5TWz8GoX4cz2IskgZ5v+XZaH/SMr7kAczR3NsE
 m1rp9bVxYFklZ+X0deK/QlW++S2ZuLb95GUOsbCmbw==
X-Google-Smtp-Source: AGHT+IGfAyeC2tYtM8d8sIUamsSPiad01fdOxBRI1cLfGVqLc+JzJRwyqaRpDKvAPeO8tfJr9UHD0Q==
X-Received: by 2002:a05:6e02:2194:b0:35d:7f2d:adbe with SMTP id
 j20-20020a056e02219400b0035d7f2dadbemr16305022ila.15.1702713229818; 
 Fri, 15 Dec 2023 23:53:49 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 jj18-20020a170903049200b001d3650256fdsm2323314plb.294.2023.12.15.23.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 23:53:49 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 16 Dec 2023 16:53:32 +0900
Subject: [PATCH v3 3/3] audio: Do not include ui/dbus.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231216-dbus-v3-3-b4bcbed7374a@daynix.com>
References: <20231216-dbus-v3-0-b4bcbed7374a@daynix.com>
In-Reply-To: <20231216-dbus-v3-0-b4bcbed7374a@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::12e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12e.google.com
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

ui/dbusaudio.c does not depend on ui/dbus.h

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 audio/dbusaudio.c | 1 -
 audio/meson.build | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 5222b3c68804..f6cdcec80aaa 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -33,7 +33,6 @@
 #include <gio/gunixfdlist.h>
 #endif
 
-#include "ui/dbus.h"
 #include "dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
diff --git a/audio/meson.build b/audio/meson.build
index c8f658611f42..8931c1697b4d 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -30,7 +30,7 @@ endforeach
 
 if dbus_display
     module_ss = ss.source_set()
-    module_ss.add(when: [gio, pixman], if_true: files('dbusaudio.c'))
+    module_ss.add(when: [gio], if_true: files('dbusaudio.c'))
     audio_modules += {'dbus': module_ss}
 endif
 

-- 
2.43.0


