Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7912E815DBC
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:13:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEkOj-0001fa-OH; Sun, 17 Dec 2023 01:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkOi-0001fM-HR
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:13:08 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkOh-0005RO-1J
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:13:08 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so2254936a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702793586; x=1703398386;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ROb0jQSi4DUO3b/Z1wZaFg6Gw7cjOddkgnBDUPxnw8s=;
 b=3OYiDUIVJ5HWtixNJRBokcmZcQ4687KyMrVnjVRTuXuxlbqzmz3ltXxMRNjEqd9D4R
 HWndG1r9LYN7T/UunDO1ueLGfw37FcdqFYiW6++neHM54CcuXRY3V1fIzlafQxf97s/1
 W+67vSNCffejfEdUzxb9GIfFIm6fsW5RWjqgT05IVgcZQmetiyBf2btukeTiuWdsm4kH
 XmvBRP5yVXjpRuLvMdFllghGehW6YumV2xstvKJDHv7ncA/h9X5FJUoZoTEPjW3hLjed
 VOeZ71SjIyEKnjBK5SfGJWnIvOYfWZ2URDygPVLecaVFTJTDU+En1l+n/W4bK0KeWgGd
 Kb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702793586; x=1703398386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROb0jQSi4DUO3b/Z1wZaFg6Gw7cjOddkgnBDUPxnw8s=;
 b=g1YCMVsOoUDbsgy9TP0MheqSGVsq44NnPtSvWlMrcWKsx9OrcbKQUk0RUtx/8SoRQQ
 1Fh7CkPducQ/fITbJFybZ1j2oV0JXVvzVRUj3QaJfIBTEL5S2Z8vRx1p6KCjd2NDzAup
 qer6n6peTjRZwxwn1kGbBC+ZsN+Tzu6AxZHfA+rjlc7RdQlC+yyLT4K+JuHTsm2Y2x5M
 0/5KJNVTf/dvhlgMBtOcnxfiDPLS3VhT+Qj3vKsafkPW53ygdy7ugUvTl7gtZLSSJR1W
 cjRfeH4OPvdK9jLHciQU3/geMI6sgr8pEzdMoXEyPmkRyXUXbjo/FmVd7fiYvcyEy99g
 85eg==
X-Gm-Message-State: AOJu0Ywpcmck5cQvraH5AcrF9T2PYrBns7qzNsdMumtY2C9pZ0uWA/Gl
 o6FdSK235yKwgvcmINNR5cKH7g==
X-Google-Smtp-Source: AGHT+IGwjBhmxWrp4JHX8i/Lv2pboYlxZ7NamR/kTBQ+PqxuLuIODcI8bXJ55+rCIlcSfalECA83/w==
X-Received: by 2002:a17:90a:2a07:b0:28b:387c:1ebb with SMTP id
 i7-20020a17090a2a0700b0028b387c1ebbmr3742869pjd.2.1702793585762; 
 Sat, 16 Dec 2023 22:13:05 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 lt8-20020a17090b354800b0028b493c8c2esm2248151pjb.22.2023.12.16.22.13.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:13:05 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 17 Dec 2023 15:12:53 +0900
Subject: [PATCH v5 2/2] audio: Do not include ui/dbus.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-dbus-v5-2-8122e822a392@daynix.com>
References: <20231217-dbus-v5-0-8122e822a392@daynix.com>
In-Reply-To: <20231217-dbus-v5-0-8122e822a392@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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
index 2aacdac6715b..3cd8e294501f 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -33,7 +33,6 @@
 #include <gio/gunixfdlist.h>
 #endif
 
-#include "ui/dbus.h"
 #include "util/dbus-display1.h"
 
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


