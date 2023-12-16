Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9C6815851
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 08:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEPUZ-0003Bq-TL; Sat, 16 Dec 2023 02:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUX-0003BS-7D
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:53:45 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUV-0000kK-L7
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:53:44 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7b7ab52afcdso49278739f.3
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 23:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702713222; x=1703318022;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0i5r57sAw8QjB30mHV+P8fvG850MAvHAx4phnQ8ja8M=;
 b=Kpu43phfH+Nv6ekIiAIVhITYgzVjaR27Z/64gsTJ36wlRAUvGClbZM0az8dQ51+gxu
 G9g0lR4milsOXNoMFr+uTDVhCsUzXy9VHIGLFuuOng24/7gyNLvKR+f46KOqPKCTH38I
 FBPhygCCUoam7/KJOnaBC8NX9ZWxb3ndAwRKGnH2pza0gH/4nwihP/YmgPNJntXticbz
 MXQspIVpQkr6pgUEJHg8Uh9sjOwQfS5tVe6eVEkNC6CuMn2QUqRi1hBT48Py6hjxLNxh
 RBdkW+IgaCNgWOuHSf30JPKnjtLCNb+RCxNpDLs7yLZB/0aidYvWOEq403zoLNrhM6Ms
 QLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702713222; x=1703318022;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0i5r57sAw8QjB30mHV+P8fvG850MAvHAx4phnQ8ja8M=;
 b=G9CpCzMWjbtfa7faHcG7I5KsQjZQeEZVwtDYGthz249oi1T/ITMfzAYqOso7wStaKb
 0fKLpwioWOquveGznuPWNbHKn6Yc4s2WiWp2kzjmJa3f34dwtqnitBL6ZzvNM3uQSjCx
 HXDGiIA4GR/6PE32i+XJfmHjVdGBd+ScapM8ZYaPwqmaKfAamzaaxQXIBU0a7n4n8npC
 Ok8eyxvenim+PEQ4CkQacB9ZJAucEKuwordoomnh9jqhyN1qP2F9/yubtkJ0SfXevuKO
 YudkEvc7ERbNADaxSkCwxq2waBQjEnbjlbPdfcBe62AQvY6IOAsLbBt7tbY+Q8A9FlPO
 74xg==
X-Gm-Message-State: AOJu0YznXEMtAEeyrmvu/Cj7bllg6mUOskHH7v4Z/aZ2Vo0PQ11meFSu
 OGobuuguMixZoeDGeU/wZ1+jcg==
X-Google-Smtp-Source: AGHT+IEFkaphxKsZoCUIujHttE2wD2hSe+a7DUe9kOo1QGIK8s55WyyuBFHNqWYxwDFtgxNM9lL9Qg==
X-Received: by 2002:a05:6e02:214b:b0:35d:59a2:127f with SMTP id
 d11-20020a056e02214b00b0035d59a2127fmr18462113ilv.43.1702713222304; 
 Fri, 15 Dec 2023 23:53:42 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 x4-20020a170902ec8400b001d05456394csm15315443plg.28.2023.12.15.23.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 23:53:42 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 16 Dec 2023 16:53:30 +0900
Subject: [PATCH v3 1/3] Move dbus-display1 out of ui
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231216-dbus-v3-1-b4bcbed7374a@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd30.google.com
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


