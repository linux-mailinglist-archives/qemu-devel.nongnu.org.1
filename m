Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D297B815853
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 08:55:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEPUd-0003CA-E0; Sat, 16 Dec 2023 02:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUa-0003Bt-UR
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:53:48 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPUZ-0000kY-9s
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 02:53:48 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-28659348677so1025065a91.0
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 23:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702713226; x=1703318026;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LHOwd/6K8GyW2k1yyxbyqMFbMO+BDnG3SZBA/pnIlsE=;
 b=PYvu4WLWg1Sn/d8OZmcFSbl486SaUxo3oeEoZ5Hj1obL5HBouibfkZL9jOXGo0/J7S
 XsDFq7YaLy9diJPhWx2DqMGKpgtVTjIws5wHUkG7wmKWl0KIjToAByviUeJp720bQfnp
 yXWOkCxQwmIWWs4ZC99vtADFI4Bnk66f34r0VgpbeGOJqx2iRaPWOs182ltYoMVzoNC1
 borh8tkLKcfOiUMUhqYN19E2Y38RgaR1roSb0z18KJe9T132XNV//WlQ8g1MA3xwlosV
 pz+XmRrHEcRdd4tUAaGgndCs6/BuCLKFwB1FZ/mNZnHa2XROyg2e2U1Q0JYW1NH5SFCq
 FNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702713226; x=1703318026;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHOwd/6K8GyW2k1yyxbyqMFbMO+BDnG3SZBA/pnIlsE=;
 b=tQURRicWSjbXcrRx2bamPB2TsqIjXe2RKkG/ZFIkLARyWvrgbvz7EynE/RP+7BIsIx
 AdD7sw989uVZANX6DlOoO08yrYJlpu01UUetEKh23rwrSZWqBpTxkn0tOWVVxwPuFJkX
 mTMafq+RsQd+XduxuTThRfVBm4Z2nv+a7xIgeKTmvEkOAW3ikZS6aDV3f7zxaFzitcNR
 3Q61Ez8JHNuVzQeJRVgaZ4ZwGQXxj6HGvNXj7zrAUqzu/fQFR9+oYY2HsqkaSwCGXUBT
 jvXIoLTpLJ1DY0kDM3/Oq4ZoQnzjFu3Dvm5HWmcyhYqsw1UeP38xYGxAz0DxVhpG9aUa
 PeUg==
X-Gm-Message-State: AOJu0Yx/4/9y6FXJNF5BzSZ/XBMDONieHYomKEyQ3jX8tMFcPThO7G4t
 ykJCvcNUfY0luaGXcOHISOq/+g==
X-Google-Smtp-Source: AGHT+IH6CZpowqBlUh9Tyrcml4jInrshkqdG3fip/MkhJtZcufKM/QK6pGrUcG072qI2PymLL5MFiw==
X-Received: by 2002:a17:90b:892:b0:28b:3c7e:2819 with SMTP id
 bj18-20020a17090b089200b0028b3c7e2819mr2005290pjb.7.1702713226006; 
 Fri, 15 Dec 2023 23:53:46 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 pq3-20020a17090b3d8300b0028b3539cd97sm2240366pjb.20.2023.12.15.23.53.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 23:53:45 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 16 Dec 2023 16:53:31 +0900
Subject: [PATCH v3 2/3] meson: Add dbus_display1 to util_ss and genh
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231216-dbus-v3-2-b4bcbed7374a@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::1033;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1033.google.com
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

Adding dbus_display1 to util_ss ensures that the source will be linked
with audio/dbus. It also avoids recompilation when linking with
dbus-display-test.

Adding dbus_display1 to genh ensures that dbus-display1.h is generated
before compiling ui/dbus, audio/dbus, and dbus-display-test.

Both changes combined, it is no longer necessary for ui/dbus, audio/dbus,
and dbus-display-test to explicitly state the dependency on
dbus_display1.

Fixes: 142ca628a733 ("ui: add a D-Bus display backend")
Fixes: 739362d4205c ("audio: add "dbus" audio backend")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 meson.build             | 6 ++++--
 tests/qtest/meson.build | 2 +-
 ui/meson.build          | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 5e1b25a47184..c5808d410361 100644
--- a/meson.build
+++ b/meson.build
@@ -2014,6 +2014,7 @@ dbus_display = get_option('dbus_display') \
            error_message: gdbus_codegen_error.format('-display dbus')) \
   .allowed()
 
+dbus_display1_ss = ss.source_set()
 if dbus_display
   env = environment()
   env.set('TARGETOS', targetos)
@@ -2031,8 +2032,8 @@ if dbus_display
                                           '--interface-prefix', 'org.qemu.',
                                           '--c-namespace', 'QemuDBus',
                                           '--generate-c-code', '@BASENAME@'])
-  dbus_display1_lib = static_library('dbus-display1', dbus_display1, dependencies: gio)
-  dbus_display1_dep = declare_dependency(link_with: dbus_display1_lib, include_directories: include_directories('.'))
+  dbus_display1_ss.add(dbus_display1)
+  genh += dbus_display1[0]
 endif
 
 have_virtfs = get_option('virtfs') \
@@ -3433,6 +3434,7 @@ event_loop_base = declare_dependency(link_whole: event_loop_base,
 
 stub_ss = stub_ss.apply(config_all, strict: false)
 
+util_ss.add_all(dbus_display1_ss)
 util_ss.add_all(trace_ss)
 util_ss = util_ss.apply(config_all, strict: false)
 libqemuutil = static_library('qemuutil',
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
index bbb7c5242d55..21d1d3b27f29 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -75,7 +75,7 @@ endif
 
 if dbus_display
   dbus_ss = ss.source_set()
-  dbus_ss.add(when: [gio, dbus_display1_dep],
+  dbus_ss.add(when: [gio],
               if_true: [files(
                 'dbus-chardev.c',
                 'dbus-clipboard.c',

-- 
2.43.0


