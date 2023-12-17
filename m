Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2C815DB8
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 07:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEkIL-0007aq-Lr; Sun, 17 Dec 2023 01:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkIJ-0007aP-7D
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:06:31 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEkID-0004Vq-0j
 for qemu-devel@nongnu.org; Sun, 17 Dec 2023 01:06:30 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6da69dd6e9fso48664a34.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 22:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702793184; x=1703397984;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yZ9VBlxS+2uSjWLCMHry1biGsSn742V3neJDz+WJfUQ=;
 b=NXUy8+t8uRKMbL8lBUxTQ9W8Naw0PYvIIBskgaziQmyvKIPMhvzTDvWbsnppVYN92A
 CikCrMUFdtIs1/mMoZRIetwVlPzdSSFgiq3044QKUEkskM+XlthISCEp20ZC+lNne/gC
 tOZyfl3cb8Z6BmZmZFms+2ZB/z7YmtJgBD7zoSI0rFH/aUhMBUxmjBFysWKWVNpjADnf
 bNmYt08xTwJgXE7OJgUQAAcuUH5sb/WEKwfczDtua70HvHdkEYDzgYZwzfmbOXT9nEK6
 ICCMUG72fawJZlritsgV46PF+YZ3qmROpPLLSBh9wsdNOS2UoTgenxRoTDJYSDGjHTvv
 rCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702793184; x=1703397984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yZ9VBlxS+2uSjWLCMHry1biGsSn742V3neJDz+WJfUQ=;
 b=ItA+msXtt3hNCzfNa+tVD3i2GuOkiODnD3kXgPp0bm8mQowJJ8gmfGlrSezz1Exx+Y
 +sZGB87toYfmINUCxiS7/hoUbck/iTS0mbW39ZEjjWW/hx9uJ0hHfY0gz+rCgMZRWFWr
 nicmPUHijVvgwM8cqhh/uZ9Mic7WN96YnoUTzLEQZGADLqyXbTl7O67piLUKT9R34ku5
 ZvDTfY4l67i2S+9+NGrNI+z5/EKVAKrl5jvPlq3aculi+xdH+8pX+dY9mhGvJrtBdk0i
 8S4uKZWgS+i3y6e0XSFiiiIGDWdmppspPvC5W9arKBwi9QyAPY3fEJvg/2cZQeT7Eitq
 hS/A==
X-Gm-Message-State: AOJu0YxeCSwAj7llFAw/ppho3pxqgnHMeUx6fDVs57aFlXNe9hiuv5ci
 KdeMIKvUk7YE/KQ49vgtfRLa6Q==
X-Google-Smtp-Source: AGHT+IG0xm9jlPhBm5uFrYqK1kmbeNOJjraAZlTJlzyuomf30cKYa7PtzUFzoWS8KTDljC+76rSHZg==
X-Received: by 2002:a05:6808:2028:b0:3b8:b063:5d6b with SMTP id
 q40-20020a056808202800b003b8b0635d6bmr17516562oiw.82.1702793183846; 
 Sat, 16 Dec 2023 22:06:23 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 y20-20020a056a00191400b006cbadbf20ddsm15871408pfi.187.2023.12.16.22.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 22:06:23 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 17 Dec 2023 15:06:15 +0900
Subject: [PATCH v4 1/2] util: Move dbus_display1 to util
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231217-dbus-v4-1-4fd5410bf04f@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
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
 ui/dbus.h                       |  2 +-
 audio/dbusaudio.c               |  2 +-
 tests/qtest/dbus-display-test.c |  2 +-
 tests/qtest/meson.build         |  2 +-
 ui/meson.build                  | 20 +-------------------
 {ui => util}/dbus-display1.xml  |  0
 util/meson.build                | 21 +++++++++++++++++++++
 8 files changed, 27 insertions(+), 24 deletions(-)

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


