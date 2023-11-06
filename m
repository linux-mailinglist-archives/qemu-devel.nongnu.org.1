Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C47E2C6E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:54:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04hA-0006Ao-9S; Mon, 06 Nov 2023 13:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h6-00065I-3Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:28 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h2-0000zu-90
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:27 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso37012755e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296683; x=1699901483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7xEhMFJbQQc5hUVTAQGpBHacYlUgRxw6wSpjBTQ+xA=;
 b=HTloqDEM2HMHSIAQbN06G0elfzv4XCJOm3ShZRYfvBo/5Ov9Ram34IPSE3TwMM7B5U
 dNoxnr1TBnl6nZwzMSPKMd+3rtCkb32LE20OSSiW2OMwk8cJR2vNsclEYdUte9RshmpB
 5JlDAtfe8NB0UUGG0ynuG1lJd2lm5D6F0u+Z+5JCQqBYjcTkotdrnDLLCO3Ccbr4QP/B
 2sSA312cKbQ13TlsLMNQtxXVU3mdtNPUuO2skLRL/BWM9n+9Q8r2Bl0HCilfWrKSUrXD
 Le6EvCSwNDE+Dp5+8yNLOa30RTQTEHBgpPpyr8CawIec58v7MqnpcJAn7WAP5pbOjRi5
 WnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296683; x=1699901483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7xEhMFJbQQc5hUVTAQGpBHacYlUgRxw6wSpjBTQ+xA=;
 b=thLymzTxg7PFri38AjLRANoXhjWptq0KoFhoM0ev2Dkrq79KIrwmYoDpUzi8AxHddt
 tkwBXyQ3SqRy9AGqUTuXSeCDHpZWrgJsgTmrEc6Lxm+fJVKmivkfy4YECwYEumtMNOox
 ykla/Lgn2nMcvBUr4qqJztWVoyLYLn4iPzFcYVQaSybXSWittwCoTmAi+AL2jG14iOSS
 SPW9239DvC0tdk4yD/pcpEybSnDx0XQ8peyNldvVcZdUDKDHmrX+ECrv3Br6ivbBMIym
 8QcF1ooHEtnKcby7wYpHg40kuW/CX/zTXt1IIdaGvPUO0neeJU/qWMHzoDElHsQxOLCP
 x9Fw==
X-Gm-Message-State: AOJu0YzxJfjAlqcfa5p867aI7+kf2Y+FymNTbxJH3ywvLvTA9QsfAYQc
 Rs0Nmf/fE2LkcJ/wm7S8GO+ASg==
X-Google-Smtp-Source: AGHT+IEpw3EWiK8sW9fErNZXGj1XrZXl0rpH18rjUHe5lMUzqmYsvLaNjgFzY9Cwk2WjUao697sNHg==
X-Received: by 2002:a05:600c:4686:b0:409:637b:88e8 with SMTP id
 p6-20020a05600c468600b00409637b88e8mr573225wmo.2.1699296682836; 
 Mon, 06 Nov 2023 10:51:22 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g23-20020a7bc4d7000000b004063cd8105csm12699683wmk.22.2023.11.06.10.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC756656D9;
 Mon,  6 Nov 2023 18:51:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH 14/22] plugins: make test/example plugins work on windows
Date: Mon,  6 Nov 2023 18:51:04 +0000
Message-Id: <20231106185112.2755262-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Greg Manning <gmanning@rapitasystems.com>

Generate a qemu_plugin_api.lib delay import lib on windows, for
windows qemu plugins to link against.

Implement an example dll load fail hook to link up the API functions
correctly when a plugin is loaded on windows.

Update the build scripts for the test and example plugins to use these
things.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231102172053.17692-3-gmanning@rapitasystems.com>
[AJB: use find_program for dlltool]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231103195956.1998255-28-alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                      |  3 +++
 contrib/plugins/win32_linker.c | 34 ++++++++++++++++++++++++++++++++++
 contrib/plugins/Makefile       | 20 ++++++++++++++++----
 plugins/meson.build            | 19 +++++++++++++++++++
 tests/plugin/meson.build       | 14 +++++++++++---
 5 files changed, 83 insertions(+), 7 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c

diff --git a/configure b/configure
index cd6c521bd8..e50ec99fe2 100755
--- a/configure
+++ b/configure
@@ -1666,6 +1666,9 @@ fi
 if test "$targetos" = darwin; then
   echo "CONFIG_DARWIN=y" >> contrib/plugins/$config_host_mak
 fi
+if test "$targetos" = windows; then
+  echo "CONFIG_WIN32=y" >> contrib/plugins/$config_host_mak
+fi
 
 # tests/tcg configuration
 (config_host_mak=tests/tcg/config-host.mak
diff --git a/contrib/plugins/win32_linker.c b/contrib/plugins/win32_linker.c
new file mode 100644
index 0000000000..50797d616e
--- /dev/null
+++ b/contrib/plugins/win32_linker.c
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2023, Greg Manning <gmanning@rapitasystems.com>
+ *
+ * This hook, __pfnDliFailureHook2, is documented in the microsoft documentation here:
+ * https://learn.microsoft.com/en-us/cpp/build/reference/error-handling-and-notification
+ * It gets called when a delay-loaded DLL encounters various errors.
+ * We handle the specific case of a DLL looking for a "qemu.exe",
+ * and give it the running executable (regardless of what it is named).
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#include <Windows.h>
+#include <delayimp.h>
+
+FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli);
+
+
+PfnDliHook __pfnDliFailureHook2 = dll_failure_hook;
+
+FARPROC WINAPI dll_failure_hook(unsigned dliNotify, PDelayLoadInfo pdli) {
+    if (dliNotify == dliFailLoadLib) {
+        /* If the failing request was for qemu.exe, ... */
+        if (strcmp(pdli->szDll, "qemu.exe") == 0) {
+            /* Then pass back a pointer to the top level module. */
+            HMODULE top = GetModuleHandle(NULL);
+            return (FARPROC) top;
+        }
+    }
+    /* Otherwise we can't do anything special. */
+    return 0;
+}
+
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 8ba78c7a32..751fa38619 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -22,7 +22,14 @@ NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
 
-SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
+ifeq ($(CONFIG_WIN32),y)
+SO_SUFFIX := .dll
+LDLIBS += $(shell $(PKG_CONFIG) --libs glib-2.0)
+else
+SO_SUFFIX := .so
+endif
+
+SONAMES := $(addsuffix $(SO_SUFFIX),$(addprefix lib,$(NAMES)))
 
 # The main QEMU uses Glib extensively so it's perfectly fine to use it
 # in plugins (which many example do).
@@ -35,15 +42,20 @@ all: $(SONAMES)
 %.o: %.c
 	$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
 
-lib%.so: %.o
-ifeq ($(CONFIG_DARWIN),y)
+ifeq ($(CONFIG_WIN32),y)
+lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/qemu_plugin_api.lib
+	$(CC) -shared -o $@ $^ $(LDLIBS)
+else ifeq ($(CONFIG_DARWIN),y)
+lib%$(SO_SUFFIX): %.o
 	$(CC) -bundle -Wl,-undefined,dynamic_lookup -o $@ $^ $(LDLIBS)
 else
+lib%$(SO_SUFFIX): %.o
 	$(CC) -shared -o $@ $^ $(LDLIBS)
 endif
 
+
 clean:
-	rm -f *.o *.so *.d
+	rm -f *.o *$(SO_SUFFIX) *.d
 	rm -Rf .libs
 
 .PHONY: all clean
diff --git a/plugins/meson.build b/plugins/meson.build
index 71ed996ed3..40d24529c0 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -14,6 +14,25 @@ if not enable_modules
 endif
 
 if get_option('plugins')
+  if targetos == 'windows'
+    dlltool = find_program('dlltool', required: true)
+
+    # Generate a .lib file for plugins to link against.
+    # First, create a .def file listing all the symbols a plugin should expect to have
+    # available in qemu
+    win32_plugin_def = configure_file(
+      input: files('qemu-plugins.symbols'),
+      output: 'qemu_plugin_api.def',
+      capture: true,
+      command: ['sed', '-e', '0,/^/s//EXPORTS/; s/[{};]//g', '@INPUT@'])
+    # then use dlltool to assemble a delaylib.
+    win32_qemu_plugin_api_lib = configure_file(
+      input: win32_plugin_def,
+      output: 'qemu_plugin_api.lib',
+      command: [dlltool, '--input-def', '@INPUT@',
+                '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
+    )
+  endif
   specific_ss.add(files(
     'loader.c',
     'core.c',
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index 322cafcdf6..528bb9d86c 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,9 +1,17 @@
 t = []
 if get_option('plugins')
   foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
-    t += shared_module(i, files(i + '.c'),
-                       include_directories: '../../include/qemu',
-                       dependencies: glib)
+    if targetos == 'windows'
+      t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
+                        include_directories: '../../include/qemu',
+                        objects: [win32_qemu_plugin_api_lib],
+                        dependencies: glib)
+
+    else
+      t += shared_module(i, files(i + '.c'),
+                        include_directories: '../../include/qemu',
+                        dependencies: glib)
+    endif
   endforeach
 endif
 if t.length() > 0
-- 
2.39.2


