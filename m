Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1197F6369
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 16:57:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6C4A-0005zQ-G8; Thu, 23 Nov 2023 10:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C45-0005xQ-Bs
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:29 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r6C3z-0002Jv-SF
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 10:56:29 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332ddd8e0bdso475993f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 07:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700754982; x=1701359782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7M+oTcAeMXRnbjDiygDHIJbp/3rbPEBUV8gBwI47k78=;
 b=McGWPbEbQ1CBYMNAxTKREq3viitX4CVeDHR/psDZoL6TP8RX6+llmW2h7eOQaAsw4S
 Dg5HEO9ZTcYAPY2b5XfgyHWbTli1BO0XuDc5fTRuNJ6cH/tqCQ1XtqNzQfccR25SpI2n
 b6faUqV8EFLrPWW8GVXVQv3RDb2SxGRKfMJHZqOJJMu3qQrb3ej9LY9Jm3zJqZkeSLFI
 gzUhuzKu4AlhO7ppHmgtv2c95HZdpl7V7kAi2pY/3Kgx0SYDP3FA2A+3auXuNBNlxein
 pxR6TcyJz9Xla1JLF2hsI391xvdvnbHw1dd8/DPgyn5xLkdGmGLlKGhkLEZ3YGrMJrau
 RPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700754982; x=1701359782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7M+oTcAeMXRnbjDiygDHIJbp/3rbPEBUV8gBwI47k78=;
 b=elkQl1uprl8w18E2eIbJeX894SggViY5BAgQJfj7sXCI6WS4dmaAouBLO2WWr7e3nX
 NpZYM8Xd8JGXEygCpEifj/ibOeL+hacM28mQIDAgP7tICi3gwDO1ffZDlXF64h2j13/U
 7CoTcr5BpX4ZOgVDbvOaP0onTyIhcDkO7yyajTcpFpf5kzGVt+u51vlEyhwX/wjgKePP
 wr5RTSpsW6dAgi7Prb69OunAki8qAUljSZNcyB729aPiRZ+fJH5It9uka2QJ7YIpUk6C
 X6bN+2YwzuQJjN7/Ukv8DV2wJ6asSxLC5ATMi0nQhtzK2NiRiXJqUjtEzUuHzISs/68l
 2oGg==
X-Gm-Message-State: AOJu0Yy7vHFDVqwztBVgYuwq/ki29AjtFbewCH6ERbBgP0s8AApY6g1x
 5FX0tdEv/KXUZ2RZGxQtuV0Z0A==
X-Google-Smtp-Source: AGHT+IFnzVLwVIhv9Qyw7TI6rhHHjwCx/J7Q1R48oiEGdt94LKebRMhcv2iOO1wz8aNksGRjceA3Hw==
X-Received: by 2002:a5d:67c5:0:b0:331:34b0:d7b3 with SMTP id
 n5-20020a5d67c5000000b0033134b0d7b3mr2702062wrw.15.1700754981921; 
 Thu, 23 Nov 2023 07:56:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 x13-20020a5d60cd000000b00332d2a9541esm1955409wrt.71.2023.11.23.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Nov 2023 07:56:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 24365645F9;
 Thu, 23 Nov 2023 15:56:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Manning <gmanning@rapitasystems.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 04/14] plugins: fix win plugin tests on cross compile
Date: Thu, 23 Nov 2023 15:56:10 +0000
Message-Id: <20231123155620.3042891-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123155620.3042891-1-alex.bennee@linaro.org>
References: <20231123155620.3042891-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1972

Cross compile gcc is more picky about argument order than msys. Changed
the meson command to take the (now renamed) libqemu_plugin_api.a as a
lib, rather than an object. This puts it in the right place on both
native and cross compile gcc commands

Reenable plugins on crossbuilds

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231109124326.21106-2-gmanning@rapitasystems.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231120150833.2552739-5-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index c2af6c7f44..d19d98cde0 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -165,7 +165,7 @@ cross-win32-system:
     job: win32-fedora-cross-container
   variables:
     IMAGE: fedora-win32-cross
-    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal --disable-plugins
+    EXTRA_CONFIGURE_OPTS: --enable-fdt=internal
     CROSS_SKIP_TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
                         microblazeel-softmmu mips64el-softmmu nios2-softmmu
   artifacts:
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index 1783750cf6..0b64d2c1e3 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -49,7 +49,7 @@ all: $(SONAMES)
 	$(CC) $(CFLAGS) $(PLUGIN_CFLAGS) -c -o $@ $<
 
 ifeq ($(CONFIG_WIN32),y)
-lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/qemu_plugin_api.lib
+lib%$(SO_SUFFIX): %.o win32_linker.o ../../plugins/libqemu_plugin_api.a
 	$(CC) -shared -o $@ $^ $(LDLIBS)
 else ifeq ($(CONFIG_DARWIN),y)
 lib%$(SO_SUFFIX): %.o
diff --git a/plugins/meson.build b/plugins/meson.build
index 40d24529c0..6b2d7a9292 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -28,7 +28,7 @@ if get_option('plugins')
     # then use dlltool to assemble a delaylib.
     win32_qemu_plugin_api_lib = configure_file(
       input: win32_plugin_def,
-      output: 'qemu_plugin_api.lib',
+      output: 'libqemu_plugin_api.a',
       command: [dlltool, '--input-def', '@INPUT@',
                 '--output-delaylib', '@OUTPUT@', '--dllname', 'qemu.exe']
     )
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index 528bb9d86c..28a929dbcc 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -4,7 +4,8 @@ if get_option('plugins')
     if targetos == 'windows'
       t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
-                        objects: [win32_qemu_plugin_api_lib],
+                        link_depends: [win32_qemu_plugin_api_lib],
+                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
                         dependencies: glib)
 
     else
-- 
2.39.2


