Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FABC8146C2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:23:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6GZ-0005Z6-D4; Fri, 15 Dec 2023 06:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6GV-0005Yd-D8
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:21:59 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6GT-0001An-Ne
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:21:59 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6d9e0f0cba9so470883a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639316; x=1703244116;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dEK99sYBEnW4HQlj92+ukvqWSanL/wRxPsFR0z6kjUU=;
 b=wrqvUwlyQlPsiPCK/cAfZQGS1WLpfW3+SnUHPKR51mPuiDYcsn5Sbsx3YkoNw9d5yH
 tWNqY2x64AYKFb/Fx/aSu6SKkFWxQHBRXxgb9AHysks69fO3xQq15+bZMDmRXsj41YIC
 iJ9l5xMENUa6pHUnf9yadFyKDNyzdNOrBanmp4M2RCjvXiossOYnVnflakdLa5DTRTOk
 XgOplxUgngP7M47RCiD/pORU7sbGYE6CqtRO800pqp3SItyZoqDG76OH9Sw4+78RKzZw
 sa4Drn3pNf8ig/Uw/jt3DWWpy2v/Fh16lf2SHBDhVUdemF5A1mu1Tx0bMeRryEp6TAJc
 bRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639316; x=1703244116;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dEK99sYBEnW4HQlj92+ukvqWSanL/wRxPsFR0z6kjUU=;
 b=pvGYYOV74Q35UHoDzC7LNnr4M2+6Inrbqpsda+0njdPX1vEzMOM6MBQg0xeqi6XPZT
 MCjZMkPftDO3e9bvB/N7vHa6qRBer294F0mP/W+2jqKW0p5N4azttL56/TL50kt1AeSO
 YYwnnQjOF8W5UKAq2A50IMDb4m0bdGblzv7Mqj2uq8+JE9J+x+mRlum4Ptp4pwMiENZb
 yfz/WqKO2ddy1pHjl2aEjcVXDaIrxkRsF/wlnUQWPM8RocQGZmt1sIto1FQOtudj/Epi
 eZr+bYjeT4h9hIfd33pg3k0V5Ytreyx9V0Pp1oUJeBT03JbmFHFXNeYN471WRZCqpApb
 nQ7A==
X-Gm-Message-State: AOJu0YyawMEuW4bJpcPqUtW0kGxzqLCB59CwSKbAbNpin1D/AzfsuZjD
 g/SYgm1UQOT4sOtWVYuIK6mkGg==
X-Google-Smtp-Source: AGHT+IFsiPzbXay5YjveC2sY7/0fNVrTd7qCpbScq9vw1a/l6OPmnFvZYKgK9fz8cKc+xMeyedY8Mw==
X-Received: by 2002:a9d:7d89:0:b0:6d9:dcf0:ba29 with SMTP id
 j9-20020a9d7d89000000b006d9dcf0ba29mr11129167otn.76.1702639316652; 
 Fri, 15 Dec 2023 03:21:56 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 r2-20020a056a00216200b006d0d90edd2csm4006448pff.42.2023.12.15.03.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:21:56 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:21:36 +0900
Subject: [PATCH 1/4] Move dbus-display1 out of ui
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v1-1-349e059ac5b2@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::335;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x335.google.com
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

Despite its name, dbus-display1 does not only provide DBus interfaces
for the display but also for the audio.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build                               | 21 +++++++++++++++++++++
 ui/dbus.h                                 |  2 +-
 audio/dbusaudio.c                         |  2 +-
 tests/qtest/dbus-display-test.c           |  2 +-
 ui/dbus-display1.xml => dbus-display1.xml |  0
 ui/meson.build                            | 18 ------------------
 6 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index ec01f8b138aa..5e1b25a47184 100644
--- a/meson.build
+++ b/meson.build
@@ -2014,6 +2014,27 @@ dbus_display = get_option('dbus_display') \
            error_message: gdbus_codegen_error.format('-display dbus')) \
   .allowed()
 
+if dbus_display
+  env = environment()
+  env.set('TARGETOS', targetos)
+  xml = custom_target('dbus-display preprocess',
+                      input: 'dbus-display1.xml',
+                      output: 'dbus-display1.xml',
+                      env: env,
+                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
+  dbus_display1 = custom_target('dbus-display gdbus-codegen',
+                                output: ['dbus-display1.h', 'dbus-display1.c'],
+                                input: xml,
+                                command: [gdbus_codegen, '@INPUT@',
+                                          '--glib-min-required', '2.64',
+                                          '--output-directory', meson.current_build_dir(),
+                                          '--interface-prefix', 'org.qemu.',
+                                          '--c-namespace', 'QemuDBus',
+                                          '--generate-c-code', '@BASENAME@'])
+  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
+  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
+endif
+
 have_virtfs = get_option('virtfs') \
     .require(targetos == 'linux' or targetos == 'darwin',
              error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
diff --git a/ui/dbus.h b/ui/dbus.h
index 1e8c24a48e32..ba9bab9f84d9 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -31,7 +31,7 @@
 #include "ui/console.h"
 #include "ui/clipboard.h"
 
-#include "ui/dbus-display1.h"
+#include "dbus-display1.h"
 
 typedef struct DBusClipboardRequest {
     GDBusMethodInvocation *invocation;
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 60fcf643ecf8..5222b3c68804 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -34,7 +34,7 @@
 #endif
 
 #include "ui/dbus.h"
-#include "ui/dbus-display1.h"
+#include "dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
 #include "audio.h"
diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 21edaa1e321f..a15e9c377b08 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -5,7 +5,7 @@
 #include <gio/gio.h>
 #include <gio/gunixfdlist.h>
 #include "libqtest.h"
-#include "ui/dbus-display1.h"
+#include "dbus-display1.h"
 
 static GDBusConnection*
 test_dbus_p2p_from_fd(int fd)
diff --git a/ui/dbus-display1.xml b/dbus-display1.xml
similarity index 100%
rename from ui/dbus-display1.xml
rename to dbus-display1.xml
diff --git a/ui/meson.build b/ui/meson.build
index 0ccb3387ee6a..bbb7c5242d55 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -75,24 +75,6 @@ endif
 
 if dbus_display
   dbus_ss = ss.source_set()
-  env = environment()
-  env.set('TARGETOS', targetos)
-  xml = custom_target('dbus-display preprocess',
-                      input: 'dbus-display1.xml',
-                      output: 'dbus-display1.xml',
-                      env: env,
-                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
-  dbus_display1 = custom_target('dbus-display gdbus-codegen',
-                                output: ['dbus-display1.h', 'dbus-display1.c'],
-                                input: xml,
-                                command: [gdbus_codegen, '@INPUT@',
-                                          '--glib-min-required', '2.64',
-                                          '--output-directory', meson.current_build_dir(),
-                                          '--interface-prefix', 'org.qemu.',
-                                          '--c-namespace', 'QemuDBus',
-                                          '--generate-c-code', '@BASENAME@'])
-  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
   dbus_ss.add(when: [gio, dbus_display1_dep],
               if_true: [files(
                 'dbus-chardev.c',

-- 
2.43.0


