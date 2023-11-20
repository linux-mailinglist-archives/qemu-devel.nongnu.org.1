Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA7B7F16C3
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:10:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55tb-0006AD-CT; Mon, 20 Nov 2023 10:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55tA-0005jw-Kj
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:41 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r55t7-0001Bf-16
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 10:08:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4079ed65471so18230205e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 07:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700492915; x=1701097715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r13y4mFZjL5YxuFf8Jb2e5kHdn8MHdL63WduZWtvH6Q=;
 b=OPtCdTTKWyWfsRvlja6HGNwngJ4ZBUYjHSWwixKZ25VYwPMTp8PA+jINIjg0eISMvj
 kwdsQikTN2gkV/YLikYmmd5oq88idkg98kSRaM/qWCQMkOnAbrpNQLUAuCWeQHlZ0F09
 YtF7pmO6H5Ri1K0+1pNPqAGakEsVCITdBRtyECyRRy9mMzzxaS1HWnGCwNxROK79cOHo
 72La/K+o+CzTJ3E4a9bx7qTZv439hDHzrdXKz0wgORLHMvY+dGpPFZeyRTM+5zumNWxz
 kDaWcOfVxgrj7IqK9sqmmG+iRTz+f2mkNgjFSmb6OnCFeuAOjZaM/GOLtonoTjBjRnc3
 V81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700492915; x=1701097715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r13y4mFZjL5YxuFf8Jb2e5kHdn8MHdL63WduZWtvH6Q=;
 b=sMcpp3bUh+D9plOT6hTYLW8r2cB3ddOUQU9e5O766zqhNUSxvcRzZCjNi7w4HmNjBb
 nlsKLz4rWqT0PWbDddrAxX5Q87zrJTZaayZu7vkLlkLaRRoxa7yxuc2rOX3aGmgC1W4G
 JVm3n9T3uEC0HODgtkubdfb5XouoMbpKg9cI/op/zdxCqtf2s7ucg99h+1AegfKeY+7z
 /vOU3qzRKOaZt+ZZ7OezSAarZ2F935cQdKQ0FLLfzQiCArRrCT63IgOVzHycZLfG9awb
 vzScqZw/6S8/EClNtBeMf8JYLrPNZFunoaz7gnfKAVlZhd79gA43c2ZWXp6XISyfCK70
 ueLg==
X-Gm-Message-State: AOJu0YwKCNCuRxTskWygaMiuqZ7hVVL5qVNJFVzOYIAvT4Banrq2bFwc
 nKHbLcEgne6FTdbBNroZTKov/w==
X-Google-Smtp-Source: AGHT+IGSsrKdk+nOb84gaytgqykOLTTQYx6NUzU19mp01UV48pCnbtWg5mBWAEhg/pyzARRZKv4Hfg==
X-Received: by 2002:a05:600c:450a:b0:408:2b:3ae with SMTP id
 t10-20020a05600c450a00b00408002b03aemr5446408wmo.6.1700492915281; 
 Mon, 20 Nov 2023 07:08:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm13477072wmo.11.2023.11.20.07.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 07:08:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6132B65758;
 Mon, 20 Nov 2023 15:08:34 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 04/14] plugins: fix win plugin tests on cross compile
Date: Mon, 20 Nov 2023 15:08:23 +0000
Message-Id: <20231120150833.2552739-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231120150833.2552739-1-alex.bennee@linaro.org>
References: <20231120150833.2552739-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 .gitlab-ci.d/crossbuilds.yml | 2 +-
 contrib/plugins/Makefile     | 2 +-
 plugins/meson.build          | 2 +-
 tests/plugin/meson.build     | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

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


