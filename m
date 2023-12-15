Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF05B8146E7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:29:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6NI-0002mS-9b; Fri, 15 Dec 2023 06:29:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6N2-0002kv-Uk
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:46 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6N1-0007tx-6N
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:28:44 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c68b5cf14bso249576a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639721; x=1703244521;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0i5r57sAw8QjB30mHV+P8fvG850MAvHAx4phnQ8ja8M=;
 b=LBFFsdqeOYc+CEQjoOmFJ1A2kfeHBWvafONMlp8Q+bVV1ipxqq28rkBAll9micvEV8
 FLIGUi7rqSw82jwzQ3LYFEDdwOHF1O3QbFzyKJSeOQV2ZB/APXtGNTHxQ3//lh3O7BQE
 1PEdLWwyjearujAaSSswuZ3/luZY7lveDE1W9clXcmK2iN2N7DZ4JyyPYcmii+rIq8NS
 ASJxdcM6YxgHyQ+Z6iVwbdMRkOJ1KvfYwR9RtSrBxjLRd/49pRmEhg5OUL6yz19HLjsM
 6K2Fqljvl9uICW0cHGQho9LEPEhzKTurBuUSgT/nt8HeuY0gtbwXS6q65Bbex5zy+t79
 yM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639721; x=1703244521;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0i5r57sAw8QjB30mHV+P8fvG850MAvHAx4phnQ8ja8M=;
 b=WoQ7dVo2xr9YygIGAPtT0updVux9aMxaGXosCAOEziEbP/jJoU26ajmsMLn0X9Yjqt
 SSWGYEHH3FvCi8rOeIEscfoPhJ+PT5qLKnmBtCN+OoiEqUna5jm4bvU852yPtQZUWMOg
 ngN5bdbSSynTS47mzP6rqUMPAjS+uH9HxVLGqaZlClytV2ctx0SkBpInA++edpQk2JNl
 CPHRoKx9yWPcgTfsDI8syPX3w1jsLzMqN+YyWslse/wYTWfVRXzTgSdgZ8Qgm6edt85Q
 qhuiBFLXYUMaLgTf4WIPdrPSSuX2zoTWn1QFKR2CoXuQ4ozLS+OQV8g0/0KOImmRf456
 ptZA==
X-Gm-Message-State: AOJu0YzOTTJ2KNgAY+tGHPDfZWzcGnqm7VoalK+8uYy3mjLmTCFxCQuR
 wApmdy+Vrszz4IV77wYhwIaU9Q==
X-Google-Smtp-Source: AGHT+IGcmuqa37VajnEK0afUzLDz5pNgqpmpP4DYBnf7Ql4ajhLd54CIWxYwJQ/U6ojN4s2VJdic3A==
X-Received: by 2002:a05:6a20:e128:b0:18f:97c:9285 with SMTP id
 kr40-20020a056a20e12800b0018f097c9285mr8038116pzb.106.1702639721197; 
 Fri, 15 Dec 2023 03:28:41 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 w2-20020a1709029a8200b001cfca7b8ee7sm14044087plp.99.2023.12.15.03.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:28:40 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:28:33 +0900
Subject: [PATCH v2 1/4] Move dbus-display1 out of ui
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-dbus-v2-1-1e2e6aa02115@daynix.com>
References: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
In-Reply-To: <20231215-dbus-v2-0-1e2e6aa02115@daynix.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52e.google.com
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
 MAINTAINERS                               |  1 +
 meson.build                               | 21 +++++++++++++++++++++
 ui/dbus.h                                 |  2 +-
 audio/dbusaudio.c                         |  2 +-
 tests/qtest/dbus-display-test.c           |  2 +-
 ui/dbus-display1.xml => dbus-display1.xml |  0
 ui/meson.build                            | 18 ------------------
 7 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34fbb..0c2630d0e264 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3389,6 +3389,7 @@ F: docs/sphinx/dbus*
 F: docs/sphinx/fakedbusdoc.py
 F: tests/qtest/dbus*
 F: scripts/xml-preprocess*
+F: dbus-display.xml
 
 Seccomp
 M: Daniel P. Berrange <berrange@redhat.com>
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


