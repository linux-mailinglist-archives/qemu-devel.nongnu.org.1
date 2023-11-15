Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D05767ED49B
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:58:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3MvX-0004p0-Au; Wed, 15 Nov 2023 15:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvT-0004mL-MW
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r3MvQ-00089d-CD
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:55:55 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-33139ecdca7so73634f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700081747; x=1700686547; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r13y4mFZjL5YxuFf8Jb2e5kHdn8MHdL63WduZWtvH6Q=;
 b=IUFTguL+nP2xdPRP2OflRt+iPwAZwjvW/txpYCGKUsKoGakgAYV7DfyyiCR+zjSfDI
 k0LwdYzJM8Lq+W7ZnWk8YuKBhmRNOlJngmhxf0pYr7RWy+caoFPMmiOgYFe8DCFvyCIO
 LpySKtBR8VVnau+Fu8Tijp1ku31xW6faBjrDK1p17qGi5ujQipfGOaXLP7L3edKBK04C
 Pmao0qsVg7UA6gq27sNceQJuGOGlRO1ev8G4LgBOjCusOraHNk90O/GQMArBNS0SKS2g
 IuZ97JeuhPIBMDWVVqZoz6Kvut7Xs5EVJ1lJOI7CaRIH1FIBW6SetKoXuxUcAiTXMoJA
 AjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081747; x=1700686547;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r13y4mFZjL5YxuFf8Jb2e5kHdn8MHdL63WduZWtvH6Q=;
 b=jGr0YZ4aGuczHwFA59ZLzHPfbBYtB6k4QnJiEdaLdRzu4RFgT93r9/nRLFndvt47wO
 aK2LwLHSukG0uSQU6IQF8UmpQPbEDpqg0tWfVb2yio/wJ5yR9dNtNqmH16QXWFjplgHa
 PR4QM+6FwqgyevySl49bL1iIM44KTCxB7XZ/5HyCffEfQtbDtmF1gvJOvsNZDyt3E1vq
 xFAgeEurJurMUaG7xi9l+G11ZBtbl8TDUnT91NPjJvbLu8gNwTtF1tU/eHH8Ta7G4nKH
 1u0CW0qwE0eiIz3q5SFnSLXkC/Kvlx9CZ+4M0h6bwcHPVPyz9bUT++qchPlZH7REYHsB
 0t4w==
X-Gm-Message-State: AOJu0Yy4Zf9DX8DkTPyYyMJ9EvrFWAV5or58FcQy+C+kTzydU+Flw1BW
 GpRi04hh6Pt26sT2VXTDw41/pQ==
X-Google-Smtp-Source: AGHT+IGDAgY1VMAlf+RPnWBn78RtavJI6o4qcU29ieksvxsVkAMdW6WbcFQ84Ci/77g32nU4oL2dNg==
X-Received: by 2002:adf:e6d1:0:b0:32d:8cfd:5780 with SMTP id
 y17-20020adfe6d1000000b0032d8cfd5780mr8055379wrm.27.1700081746832; 
 Wed, 15 Nov 2023 12:55:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d67d0000000b0032da49e18fasm11432278wrw.23.2023.11.15.12.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 12:55:46 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 23FB05F7B4;
 Wed, 15 Nov 2023 20:55:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH 04/10] plugins: fix win plugin tests on cross compile
Date: Wed, 15 Nov 2023 20:55:36 +0000
Message-Id: <20231115205542.3092038-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231115205542.3092038-1-alex.bennee@linaro.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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


