Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72D790ADB
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfI5-00033u-9X; Sun, 03 Sep 2023 01:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHu-00033O-Ks
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHp-0001pc-S2
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:42 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf1935f6c2so2105335ad.1
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717476; x=1694322276;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2bscsJzpeRHxPoEuFVzdoUPIwbXoKcsg2VXxI81RBc=;
 b=O8rvQtANgoGnHsBmTGlXFVbsSHfnqHlrzOnFzz+GxvaFnRSqkbbu3xSyZgdVAJamQR
 U54uc/4eYoBlxeF4ITYQ3WlI1zszYUHcyaGwgiZqy+fhEzDznYVJenJwl2Rrq7Velg5k
 RQDOO3uDFiJOiPH5656nrKca5ekkozz+cP6Bh3obkEb3azrl0jx380aY0NY4ZT0wTSSe
 MSu+giIu8fM6cXaevuCzztg2oMpk9glqCKh4uenpPzI1aAEbV13h4ohMuaoij1fdAvg0
 NPfw7mvDpfEAm7WRIqB0QxkwKkzG2FiiQV2LTDOhnfGAj3PRAdodReHSonwpUNbYQ+OK
 p2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717476; x=1694322276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c2bscsJzpeRHxPoEuFVzdoUPIwbXoKcsg2VXxI81RBc=;
 b=RcUmd/elL/O3ogB41oNiftv/1fkMIj9n9sXcge3KffFFys973/c1uhPCGHoajqlV+s
 Dc0YgJdvhDt96j8vVzWRNnQx06Nnbz3fuBHdLvDN9a0FG+PaylLe/d5UsxeYVLFibRYO
 bjJ+6zvVDRV2tYhrXzWc6keBIg2OWTZKg2N9AyA2UCf3TG6Iv1/ZGwVyTq08C3Fyk2ZZ
 8NtP4P8/XBjVC6SS1+DcU4vi/Ktu5go0Hv4RdoJRqukvCyecaJwZ3DVNYNJlUrIsPN9H
 HpiQUfFztGEqnhoUAEUUFNDHbrfhBrHy+daBFpH9JPmdV2acQ3u5r3xttUoWUEC7wsTQ
 c38Q==
X-Gm-Message-State: AOJu0YzrrT+xgXP95Fho969kGNEuT8k5GH7rNVscCHD53AWYjc7+nXby
 9Bdo8+XQ/5cUgsCzA1IUps1ObA==
X-Google-Smtp-Source: AGHT+IEq6C8xetVFp+xRYS7OhzV5NnK2LFZc+OVbt5e8hLUmj2ZUMJnos1EO+ZgY1nqFzsFtHhi/RA==
X-Received: by 2002:a17:902:a386:b0:1bd:9498:f15d with SMTP id
 x6-20020a170902a38600b001bd9498f15dmr8150261pla.24.1693717476610; 
 Sat, 02 Sep 2023 22:04:36 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:04:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 18/18] contrib/plugins: Add cc plugin
Date: Sun,  3 Sep 2023 14:03:26 +0900
Message-ID: <20230903050338.35256-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
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

This demonstrates how to write a plugin in C++.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/devel/tcg-plugins.rst |  8 ++++++++
 configure                  | 15 ++++++++++++---
 contrib/plugins/Makefile   |  5 +++++
 contrib/plugins/cc.cc      | 17 +++++++++++++++++
 tests/tcg/Makefile.target  |  3 +++
 5 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 contrib/plugins/cc.cc

diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
index c9f8b27590..0a11f8036c 100644
--- a/docs/devel/tcg-plugins.rst
+++ b/docs/devel/tcg-plugins.rst
@@ -584,6 +584,14 @@ The plugin has a number of arguments, all of them are optional:
   configuration arguments implies ``l2=on``.
   (default: N = 2097152 (2MB), B = 64, A = 16)
 
+- contrib/plugins/cc.cc
+
+cc plugin demonstrates how to write a plugin in C++. It simply outputs
+"hello, world" to the plugin log::
+
+  $ qemu-system-arm $(QEMU_ARGS) \
+    -plugin ./contrib/plugins/libcc.so -d plugin
+
 API
 ---
 
diff --git a/configure b/configure
index 26ec5e4f54..0065b0dfe0 100755
--- a/configure
+++ b/configure
@@ -293,10 +293,18 @@ else
   cc="${CC-${cross_prefix}gcc}"
 fi
 
-if test -z "${CXX}${cross_prefix}"; then
-  cxx="c++"
+if test -n "${CXX+x}"; then
+  cxx="$CXX"
 else
-  cxx="${CXX-${cross_prefix}g++}"
+  if test -n "${cross_prefix}"; then
+    cxx="${cross_prefix}g++"
+  else
+    cxx="c++"
+  fi
+
+  if ! has "$cxx"; then
+    cxx=
+  fi
 fi
 
 # Preferred ObjC compiler:
@@ -1702,6 +1710,7 @@ echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
+echo "CXX=$cxx" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index b2b9db9f51..93d86b3d07 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -21,6 +21,9 @@ NAMES += lockstep
 NAMES += hwprofile
 NAMES += cache
 NAMES += drcov
+ifneq ($(CXX),)
+NAMES += cc
+endif
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
@@ -31,6 +34,8 @@ CFLAGS += -fPIC -Wall
 CFLAGS += $(if $(CONFIG_DEBUG_TCG), -ggdb -O0)
 CFLAGS += -I$(SRC_PATH)/include/qemu
 
+CXXFLAGS := $(CFLAGS)
+
 all: $(SONAMES)
 
 %.o: %.c
diff --git a/contrib/plugins/cc.cc b/contrib/plugins/cc.cc
new file mode 100644
index 0000000000..83a5528db0
--- /dev/null
+++ b/contrib/plugins/cc.cc
@@ -0,0 +1,17 @@
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
+    qemu_plugin_outs("hello, world\n");
+    return 0;
+}
+
+};
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 462289f47c..3d7837d3b8 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -149,6 +149,9 @@ PLUGIN_SRC=$(SRC_PATH)/tests/plugin
 PLUGIN_LIB=../../plugin
 VPATH+=$(PLUGIN_LIB)
 PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
+ifneq ($(CXX),)
+PLUGINS+=$(patsubst %.cc, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.cc)))
+endif
 
 # We need to ensure expand the run-plugin-TEST-with-PLUGIN
 # pre-requistes manually here as we can't use stems to handle it. We
-- 
2.42.0


