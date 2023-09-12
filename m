Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 984AE79C7D6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxaU-0003Kp-MY; Tue, 12 Sep 2023 03:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxaG-0003Dg-A1
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:16 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxaE-0006h5-0d
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:16 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6c0bbbbad81so3241572a34.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502793; x=1695107593;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJRUv8O4TokTXkVqeubhuAV8gl+wRJjs7dLP5rlsco4=;
 b=iT9R1jY2Sm0WYzrnybPkQzUVrqwNnpQGa/ZyWEXMXoNs1qGEyPOolJbXq7lgt8zN6n
 BoNMg9pad1nGhdfGa/+vPEVsxnRlKz39iZ+3E4PvnE+1NwEnSPIOJxXnecIOc8eT18i9
 ImUj+st4ZCeGtmucZHdoRD82br5cpeGbWGlS8lHZ1VUVmgym2wI9nq6d6DUowICW+huq
 JE4AIckwmTGys1LVxMWuqplXES9mKOUt460HlPXcF7D80ldMDY7JW1Nj4FsL89/MfNrd
 T+l0Wxa1UHnc++zL5CHZDluiKZVl5LIqN0Fsi0i4ZYP/MFehdblYK6Sw0eZZjJck/6s6
 j+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502793; x=1695107593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJRUv8O4TokTXkVqeubhuAV8gl+wRJjs7dLP5rlsco4=;
 b=IssysNct7rxwNlCkDy4W7atdZb9TRaMKfSKbKC/jIDwhiT78Md2DVft3x5ro0Wmr1T
 5CV62/gh1erhglhs0FumM59qtiC8nLBpmNqo/MXDR2dX0URuANTNrcuM6VM+pbXanlHd
 lPh4CMYF0OHcP7wpuMmVn39p7gH8GyJxwOFY+FnAn8zZpqDtrX5g2mBEtWor41KnWcLB
 XcrAF+HShoOL6Y2eYXAMcwcooBTyWKsoS4q3GmNXLWPLzEmAPymCzjGEyenOaUHgtyhV
 DrZS2LmdnXRZadhlSFHGdSBRooXD54co4Y2/xi7IMOl82b8diQtlg384fuIAOcuBvBff
 Vozg==
X-Gm-Message-State: AOJu0YxKx1xW4cddoTmBaGwRdru+vTjKnE1AdcoMYCT2eV3nCqO5KuX2
 s+irxzwqTU+XqCpyj8sfwDfYpA==
X-Google-Smtp-Source: AGHT+IHItpms03KXongM82cEE9tfs/RWCPKvo6cAAnLqT5at8V7xHjpGYa8P8FiehY8pk9Gt1FaBPA==
X-Received: by 2002:a05:6358:2789:b0:134:c859:d32a with SMTP id
 l9-20020a056358278900b00134c859d32amr11061179rwb.25.1694502793054; 
 Tue, 12 Sep 2023 00:13:13 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:13:12 -0700 (PDT)
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
Subject: [PATCH v7 18/18] contrib/plugins: Add cc plugin
Date: Tue, 12 Sep 2023 16:12:04 +0900
Message-ID: <20230912071206.30751-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x330.google.com
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
index b9bd008592..c3cd5a15e7 100755
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
@@ -1765,6 +1773,7 @@ echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
+echo "CXX=$cxx" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers for KVM architectures
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


