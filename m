Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0E3815DBD
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:13:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEkOg-0001er-VP; Sun, 17 Dec 2023 01:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkOe-0001eZ-KK
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:13:04 -0500
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkOc-0005Ql-Nf
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:13:04 -0500
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-35f71436397so17196955ab.3
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702793581; x=1703398381;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bMK8LNf8Y4yti6hoJn4sopJzJ3mO1Oem9wv1FUSM8ec=;
 b=pqt42VnOg28L5tdDpaZHgth94mMbWZH0hq4dsqfxihvsCAUzt2E0LkJqUnKmpVBpon
 Bnu+vwyd80aENnBaC1m89p59pd2Jdo5XjV5HEG8EkM1jUR84/HvaNATj9C/OKs7x8S58
 PIYYTfEA8I3pWSqWISMCudJNIlxdukQ7dvg5u6LUgmFPlJwZnioy0KFNDL5Gk3eYb3ag
 UWjZ1jnDbsG92JN2t2nwFV06ewkHLdbwPQwxOEtaaXnFUGXfThf1O3irGH5aKo65JeXd
 olqt/nzamxzTE87dXeSJ7bmLqhuEn7m6Hk+J4TKyzp/B94Oz0jxpIj+xXnjtutgW2LDs
 KMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702793581; x=1703398381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bMK8LNf8Y4yti6hoJn4sopJzJ3mO1Oem9wv1FUSM8ec=;
 b=ECbzEN5D9wNuoE+BT2K+isBtFWhaVwtytTmby0gG1G6p1293sfQykiQ1ggNbMPZdD1
 p9eSnNBH7lQ0BpzXU2+rCOr/l1QnpTcw6lrIB7L3uVUVBMMUnGZNHpTK3RtmzYND7aEs
 89cPRphvLh//U7lpNe9TvvgvXod9v00eJHqHTZ3DJ7qnYGTJ2QsMkqZhe2OLDIfOHBUc
 7qz1Kj7Tk1lK4HScXroTYfWF8iwulYDEsO7O5cwkdVCncVZCbtPx6ipXzj/2o/V6cnoL
 ianaq7z3NjBg60SdrFTCd5UTwACb4o0VtZq2Ci5BH/tLuMth3sTfuF3lI8Q9pVOSHF3k
 5hZA==
X-Gm-Message-State: AOJu0YybJzPIWzbD/CKJ+m2g6h+F4T9FOG6/1utG/AutPM4I9RKQMB91
 2UHKLrbR5Rg8D94v32Y7UOrjxg==
X-Google-Smtp-Source: AGHT+IGn6owY2uef6zGYske76fXKYVHJFIfRVtyhB/Obw0QCuVqT35gfMg+WUxAlkkCJhVIHr4jkSg==
X-Received: by 2002:a05:6e02:20e8:b0:35d:7946:bec6 with SMTP id
 q8-20020a056e0220e800b0035d7946bec6mr20054357ilv.112.1702793581576; 
 Sat, 16 Dec 2023 22:13:01 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 z7-20020a170902708700b001ab39cd875csm16671120plk.133.2023.12.16.22.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:13:01 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 17 Dec 2023 15:12:52 +0900
Subject: [PATCH v5 1/2] util: Move dbus_display1 to util
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-dbus-v5-1-8122e822a392@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::12a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x12a.google.com
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

Move dbus_display1 from ui to util as it's used not only by ui/dbus but
also dbus-display-test.

dbus_display1 is now added to util_ss accordingly. It ensures that the
source will be linked with audio/dbus, and also avoids recompilation
when linking with dbus-display-test.

dbus-display.h is also added to genh to ensure it is generated before
compiling ui/dbus, audio/dbus, and dbus-display-test.

Both changes combined, it is no longer necessary for ui/dbus,
audio/dbus, and dbus-display-test to explicitly state the dependency on
dbus_display1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 MAINTAINERS                     |  2 +-
 docs/interop/dbus-display.rst   |  6 +++---
 ui/dbus.h                       |  2 +-
 audio/dbusaudio.c               |  2 +-
 tests/qtest/dbus-display-test.c |  2 +-
 tests/qtest/meson.build         |  2 +-
 ui/meson.build                  | 20 +-------------------
 {ui => util}/dbus-display1.xml  |  0
 util/meson.build                | 21 +++++++++++++++++++++
 9 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34fbb..aefc2b62d9f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3381,7 +3381,7 @@ S: Maintained
 F: backends/dbus-vmstate.c
 F: ui/dbus*
 F: audio/dbus*
-F: util/dbus.c
+F: util/dbus*
 F: include/ui/dbus*
 F: include/qemu/dbus.h
 F: docs/interop/dbus*
diff --git a/docs/interop/dbus-display.rst b/docs/interop/dbus-display.rst
index 8c6e8e0f5a82..efec89723a34 100644
--- a/docs/interop/dbus-display.rst
+++ b/docs/interop/dbus-display.rst
@@ -18,14 +18,14 @@ QEMU also implements the standard interfaces, such as
 
 .. only:: sphinx4
 
-   .. dbus-doc:: ui/dbus-display1.xml
+   .. dbus-doc:: util/dbus-display1.xml
 
 .. only:: not sphinx4
 
    .. warning::
       Sphinx 4 is required to build D-Bus documentation.
 
-      This is the content of ``ui/dbus-display1.xml``:
+      This is the content of ``util/dbus-display1.xml``:
 
-   .. literalinclude:: ../../ui/dbus-display1.xml
+   .. literalinclude:: ../../util/dbus-display1.xml
       :language: xml
diff --git a/ui/dbus.h b/ui/dbus.h
index 1e8c24a48e32..a847bee98876 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -31,7 +31,7 @@
 #include "ui/console.h"
 #include "ui/clipboard.h"
 
-#include "ui/dbus-display1.h"
+#include "util/dbus-display1.h"
 
 typedef struct DBusClipboardRequest {
     GDBusMethodInvocation *invocation;
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 60fcf643ecf8..2aacdac6715b 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -34,7 +34,7 @@
 #endif
 
 #include "ui/dbus.h"
-#include "ui/dbus-display1.h"
+#include "util/dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
 #include "audio.h"
diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index 21edaa1e321f..d4871e2fd80f 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -5,7 +5,7 @@
 #include <gio/gio.h>
 #include <gio/gunixfdlist.h>
 #include "libqtest.h"
-#include "ui/dbus-display1.h"
+#include "util/dbus-display1.h"
 
 static GDBusConnection*
 test_dbus_p2p_from_fd(int fd)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d048..225cd35e4664 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -332,7 +332,7 @@ if vnc.found()
 endif
 
 if dbus_display
-  qtests += {'dbus-display-test': [dbus_display1, gio]}
+  qtests += {'dbus-display-test': [gio]}
 endif
 
 qtest_executables = {}
diff --git a/ui/meson.build b/ui/meson.build
index 0ccb3387ee6a..21d1d3b27f29 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -75,25 +75,7 @@ endif
 
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
-  dbus_ss.add(when: [gio, dbus_display1_dep],
+  dbus_ss.add(when: [gio],
               if_true: [files(
                 'dbus-chardev.c',
                 'dbus-clipboard.c',
diff --git a/ui/dbus-display1.xml b/util/dbus-display1.xml
similarity index 100%
rename from ui/dbus-display1.xml
rename to util/dbus-display1.xml
diff --git a/util/meson.build b/util/meson.build
index c2322ef6e71a..268a8ab03671 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -119,3 +119,24 @@ elif cpu == 'loongarch64'
 elif cpu in ['ppc', 'ppc64']
   util_ss.add(files('cpuinfo-ppc.c'))
 endif
+
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
+  util_ss.add(dbus_display1)
+  genh += dbus_display1[0]
+endif

-- 
2.43.0


