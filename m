Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B791B7C4B30
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTI2-0002iX-1Y; Wed, 11 Oct 2023 03:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHf-0002J5-SY
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHe-00068o-7m
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so11964715ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007928; x=1697612728;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=37aJwnhJt1VvYFbtK0iqsY3biNu5Sl4hTrMC8Drv/RM=;
 b=yLlRRegiQkDXOiVXHSu+JYyCWHeSQMx2DPZZnvx2BGqvetfZuyRl4FHOZPDRR8E3GI
 kGmNFaFxsSxP8xbfEtrUqrB0WVz4pPBJ+z2+zXBCQFj2j+j09ql47M8qhxYegw3ZEQqd
 vTrCYdmW1bGRZUQRsF2SMFUNJYdV+DpzjwcNwAOJpNEZRX89C3bdtXgP9YILDWRDgkk5
 LwwutKDiSWQse28RM3BrG1J28z8ow4tRhoVZN7Z+3HRLoX0jRTQisocUJ64n3VWNfX3A
 zCvqC/6M15rUAX6/cqY6By52ROxwFA/Sg6ocgiRp1GRBYu5VywDdA55bX1Gv1JO0eH4f
 JlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007928; x=1697612728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=37aJwnhJt1VvYFbtK0iqsY3biNu5Sl4hTrMC8Drv/RM=;
 b=n6fzXO7oZbYGbbVd0V8wlF6nRyr1ht39eJhOgQGNa0IDPc/5lysUTTv4j1S+uQ55dB
 vX/x97eFrvfhosh3DbrlgnebxiTmeUcs/MyBf1YTmJwSIBuNRFGoyYQrsixlXeXOCNjR
 IWUGXdH31OFDv2mfSa64DZJjVuQ4OrhckufvXyHZ/nC9qZ0VrSV+wD6c856gfRX2gK+s
 qIs2zrXHVh6S+5ucjyBr4rIVCs4j6Q1cprKWQL/V6oG+9KVeHvHhux8oAuZX3aRxmikP
 WkjcWiwkybdjZqA3Kto0cnzRdsUsh9T6w8tv37ZFfhpXQQ38H7McMGwL1v1GScNIsdAT
 yj2g==
X-Gm-Message-State: AOJu0YwFDyrYZIx80dpkH7OBQJNG18w1xt85lcVNZkv04ZJeblGgDUv/
 +Ozm6ouov0hWMPe4WGvty7YqNQ==
X-Google-Smtp-Source: AGHT+IGfSGC+nSShvn7OtToLtc1X4EVXWWUbvSY270P3rp4Gvyo0RuxkTYJgH5YP9zStHgVpJef9Uw==
X-Received: by 2002:a17:902:e74d:b0:1c7:7c2c:f846 with SMTP id
 p13-20020a170902e74d00b001c77c2cf846mr24925841plf.67.1697007927845; 
 Wed, 11 Oct 2023 00:05:27 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 l2-20020a170903244200b001b891259eddsm13086012pls.197.2023.10.11.00.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:05:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v9 23/23] plugins: Support C++
Date: Wed, 11 Oct 2023 16:03:09 +0900
Message-ID: <20231011070335.14398-24-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Make qemu-plugin.h consumable for C++ platform.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/tcg-plugins.rst |  4 ++++
 meson.build                |  2 +-
 include/qemu/qemu-plugin.h |  4 ++++
 tests/plugin/cc.cc         | 16 ++++++++++++++++
 tests/plugin/meson.build   |  5 +++++
 tests/tcg/Makefile.target  |  3 +--
 6 files changed, 31 insertions(+), 3 deletions(-)
 create mode 100644 tests/plugin/cc.cc

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index c9f8b27590..984d8012e9 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -283,6 +283,10 @@ run::
   160          1      0
   135          1      0
 
+- contrib/plugins/cc.cc
+
+A pure test plugin to ensure that the plugin API is compatible with C++.
+
 - contrib/plugins/hotblocks.c
 
 The hotblocks plugin allows you to examine the where hot paths of
diff --git a/meson.build b/meson.build
index 9f4c4f2f1e..c289bb8948 100644
--- a/meson.build
+++ b/meson.build
@@ -20,7 +20,7 @@ config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
-if targetos == 'windows' and add_languages('cpp', required: false, native: false)
+if add_languages('cpp', required: false, native: false)
   all_languages += ['cpp']
   cxx = meson.get_compiler('cpp')
 endif
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 40aae8db68..55f514ca6c 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -16,6 +16,8 @@
 #include <stdbool.h>
 #include <stddef.h>
 
+G_BEGIN_DECLS
+
 /*
  * For best performance, build the plugin with -fvisibility=hidden so that
  * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
@@ -710,4 +712,6 @@ int qemu_plugin_find_register(unsigned int vcpu_index, int file,
  */
 int qemu_plugin_read_register(GByteArray *buf, int reg);
 
+G_END_DECLS
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/tests/plugin/cc.cc b/tests/plugin/cc.cc
new file mode 100644
index 0000000000..297a7e4f3f
--- /dev/null
+++ b/tests/plugin/cc.cc
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <qemu-plugin.h>
+
+extern "C" {
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info, int argc,
+                                           char **argv)
+{
+    return 0;
+}
+
+};
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index 322cafcdf6..fed14aa0c2 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -5,6 +5,11 @@ if get_option('plugins')
                        include_directories: '../../include/qemu',
                        dependencies: glib)
   endforeach
+  if 'cpp' in all_languages
+    t += shared_module('cc', files('cc.cc'),
+                       include_directories: '../../include/qemu',
+                       dependencies: glib)
+  endif
 endif
 if t.length() > 0
   alias_target('test-plugins', t)
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 462289f47c..66a20d0f2c 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -145,10 +145,9 @@ RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 
 # If plugins exist also include those in the tests
 ifeq ($(CONFIG_PLUGIN),y)
-PLUGIN_SRC=$(SRC_PATH)/tests/plugin
 PLUGIN_LIB=../../plugin
 VPATH+=$(PLUGIN_LIB)
-PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
+PLUGINS=$(notdir $(wildcard $(PLUGIN_LIB)/*.so))
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
-- 
2.42.0


