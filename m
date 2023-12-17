Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB3C815DB6
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEkIO-0007b7-4Y; Sun, 17 Dec 2023 01:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkIK-0007ac-0R
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:06:32 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkIH-0004WJ-S5
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:06:31 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6da3659535fso1898985a34.3
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702793187; x=1703397987;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ROb0jQSi4DUO3b/Z1wZaFg6Gw7cjOddkgnBDUPxnw8s=;
 b=oJuIDi2/xwswS90iqN6GM3mtzvf82hIAHRnb7xQOsYg5NVYyeDW1+jcEMEpLdlBPDl
 /egUpob39Te5ENPF/qjDSrxwbdB9zhX5RMEkDsjFSWJJkFiGzhb3nvv99lqhKEUdGRR7
 1UfA3S4sh24HIbmrcxYhMjtHKvlnl2+YxqOZQDHcMG+xWYYi1EmCZWEodYjGw6Nn0KGs
 srmSviOtywx2RdE8wR4uh7GxFayi21LdafN70ymzyvoAzT3BtT6u872R84E0WIU7eM9K
 Y9PueOgGTUx/gbVEBqqO6d6oSqxgoYxww/55V3BraVK9d7vlAruNLHUezW3FG6a+BYDI
 2+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702793187; x=1703397987;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ROb0jQSi4DUO3b/Z1wZaFg6Gw7cjOddkgnBDUPxnw8s=;
 b=KqQIwBG/zaYt2cY5LFGa+kuEOVvXbhGbpwdL63M2dYunIE9sgvIhtaa3byaWqeVw8H
 Ki3XS/5/rIihvLm1MBZRmuAfpy2UBh5evP9bS6SQVY2MCdxt1FmoPdPCFWurvT/Mq20C
 gZ9mjzILzkCBCfokkFdGzv0QiwOhyCek3C9ebD/ZLDBYcmEotWhVYLL1QfqFpfvirXTK
 FS2MpVzih93NRundD7ui90he0qpLWE21+POMD5e54xCPSzIJ8+/BgtS4xMjAH2A6lI0V
 F0luW/q4vfcc4y0gcsFxXo47Nttl3xab5Na3XpyhSP9FpwdoIegUUNuJaQAuEjHH8Jpe
 fHTg==
X-Gm-Message-State: AOJu0YzYHcYBsjMwica7FEFwHMJPn75yoTFEE/YhSTA8rPZVj22CWhPR
 09nUU5YH3rpOub86yzKUK0Wt2w==
X-Google-Smtp-Source: AGHT+IHIcG6v7MJOSm5A0SvKdHGJUlxlLDi2ZEXjqfLrtA5sloy5LYwf6s8L6Txwce2nMRiQ0E6OAw==
X-Received: by 2002:a05:6830:2012:b0:6d9:f4fc:b86 with SMTP id
 e18-20020a056830201200b006d9f4fc0b86mr14217559otp.25.1702793187615; 
 Sat, 16 Dec 2023 22:06:27 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 g16-20020aa78750000000b006c4d47a7668sm15989126pfo.127.2023.12.16.22.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:06:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 17 Dec 2023 15:06:16 +0900
Subject: [PATCH v4 2/2] audio: Do not include ui/dbus.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-dbus-v4-2-4fd5410bf04f@daynix.com>
References: <20231217-dbus-v4-0-4fd5410bf04f@daynix.com>
In-Reply-To: <20231217-dbus-v4-0-4fd5410bf04f@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::334;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x334.google.com
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


