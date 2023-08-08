Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B77773AAB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:20:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYU-0001Dc-V4; Tue, 08 Aug 2023 10:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYH-0001Cs-G9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:15 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYF-0000E0-N9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc02bd4eafso48750995ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504349; x=1692109149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dk/DO9DbVQteeuSu76KVEhnNigAZjlVyLgHlftMISps=;
 b=gpVj7T45dZ/RNqU7fu1jts6tqsosNDl7hCXRBtGeDxIGRt2w360gDCgOaymtXv0+tz
 vc8FFnZPb3nNsQNCjY2FlYFQ2lzgDmY38alz8AaTdlXiNOjGYYfOTWi+Ac1BKIL21Iwq
 p1P4FQJXoAugZvgkOhsuTMo3C0WuimxYha6t8XtQXTm+sMGnyCtO/mY5o6ZinvFx57RD
 rk0b/fxJ4bnXUf0ShMh9IKwB+kwUXkX8x9AJtFxzhg5cRCPSzopzI9tv6jmPRTXLzeje
 kAGkx/EzqdSDMJoDoU/mmggeC458Js0t/rHUi280O3iBj43TISyProkkFBFV6wO8lWo3
 CWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504349; x=1692109149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dk/DO9DbVQteeuSu76KVEhnNigAZjlVyLgHlftMISps=;
 b=Y+2rYuduZONkMdwWcBwWgZKx75Dhh2W4o8fxppulQUDo5AX1INCrR+fIlckKhep1Gd
 0rv3XIGsvdk3Dz0Le6gvKQ6txhYHj0KMUGZWfZwIzU2o/JQfWmlL2aidvi18GjztVZD/
 AyeYnlb7T+SepFgOiP8amv1nltLGm21lkbEbG8zKoIlBVq321PY5LgYkCP1VN8QcluUN
 iKNBFrrqTv7OUYA9FwrVqvGAR+Xw+G5jO20q+LwPZrtcyO5r+TELS87lVL7NHIuNvwQL
 M4XId3l1XI65cUm/XcoH5O5fsy0hwI2nUd3GWGEIO7iq4kdn1X9Wr/Mj7T+9y+NKo8oc
 yrEA==
X-Gm-Message-State: AOJu0YwojfNhK5MC9hALgaRMfQbIgjCh1NhHz9JuUSBk5pez5l6PvLxa
 RKER5YtSgs9xdaHbPdUnjc6tlFm+TVhwZscM
X-Google-Smtp-Source: AGHT+IH3NeW45usox02RX6NALdReV4asCC6cX7VcubVLYtzDrMGT0LsXI3RyJyfKWK2t2VeufCiF0Q==
X-Received: by 2002:a17:902:76c8:b0:1b8:6cae:3570 with SMTP id
 j8-20020a17090276c800b001b86cae3570mr12572802plt.11.1691504348735; 
 Tue, 08 Aug 2023 07:19:08 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:08 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: [RFC v4 02/11] build: Implement libnative library and the build
 machinery for libnative
Date: Tue,  8 Aug 2023 22:17:30 +0800
Message-Id: <20230808141739.3110740-3-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit implements a shared library, where native functions are
rewritten as special instructions. At runtime, user programs load
the shared library, and special instructions are executed when
native functions are called.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 Makefile                            |  2 +
 common-user/native/Makefile.include |  9 ++++
 common-user/native/Makefile.target  | 22 ++++++++++
 common-user/native/libnative.c      | 67 +++++++++++++++++++++++++++++
 configure                           | 39 +++++++++++++++++
 include/native/libnative.h          |  8 ++++
 6 files changed, 147 insertions(+)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.c
 create mode 100644 include/native/libnative.h

diff --git a/Makefile b/Makefile
index 5d48dfac18..6f6147b40f 100644
--- a/Makefile
+++ b/Makefile
@@ -182,6 +182,8 @@ SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 
 include $(SRC_PATH)/tests/Makefile.include
 
+include $(SRC_PATH)/common-user/native/Makefile.include
+
 all: recurse-all
 
 ROMS_RULES=$(foreach t, all clean distclean, $(addsuffix /$(t), $(ROMS)))
diff --git a/common-user/native/Makefile.include b/common-user/native/Makefile.include
new file mode 100644
index 0000000000..40d20bcd4c
--- /dev/null
+++ b/common-user/native/Makefile.include
@@ -0,0 +1,9 @@
+.PHONY: build-native
+build-native: $(NATIVE_TARGETS:%=build-native-library-%)
+$(NATIVE_TARGETS:%=build-native-library-%): build-native-library-%:
+	$(call quiet-command, \
+	    $(MAKE) -C common-user/native/$* $(SUBDIR_MAKEFLAGS), \
+	"BUILD","$* native library")
+# endif
+
+all: build-native
diff --git a/common-user/native/Makefile.target b/common-user/native/Makefile.target
new file mode 100644
index 0000000000..0c1241b368
--- /dev/null
+++ b/common-user/native/Makefile.target
@@ -0,0 +1,22 @@
+# -*- Mode: makefile -*-
+#
+# Library for native calls
+#
+
+all:
+-include ../../config-host.mak
+-include config-target.mak
+
+CFLAGS+=-O1 -fPIC -shared -fno-stack-protector -I$(SRC_PATH)/include -D$(TARGET_NAME)
+LDFLAGS+=
+
+SRC = $(SRC_PATH)/common-user/native/libnative.c
+LIBNATIVE = libnative.so
+
+all: $(LIBNATIVE)
+
+$(LIBNATIVE): $(SRC)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(EXTRA_NATIVE_CALL_FLAGS) $< -o $@ $(LDFLAGS)
+
+clean:
+	rm -f $(LIBNATIVE)
diff --git a/common-user/native/libnative.c b/common-user/native/libnative.c
new file mode 100644
index 0000000000..662ae6fbfe
--- /dev/null
+++ b/common-user/native/libnative.c
@@ -0,0 +1,67 @@
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "native/libnative.h"
+
+#define WRAP_NATIVE()                                 \
+    do {                                              \
+        __asm__ volatile(__CALL_EXPR : : : "memory"); \
+    } while (0)
+
+#if defined(i386) || defined(x86_64)
+/*
+ * An unused instruction is utilized to mark a native call.
+ */
+#define __CALL_EXPR ".byte 0x0f, 0xff;"
+#endif
+
+#if defined(arm) || defined(aarch64)
+/*
+ * HLT is an invalid instruction for userspace and usefully has 16
+ * bits of spare immeadiate data which we can stuff data in.
+ */
+#define __CALL_EXPR "hlt 0xffff;"
+#endif
+
+#if defined(mips) || defined(mips64)
+/*
+ * The syscall instruction contains 20 unused bits, which are typically
+ * set to 0. These bits can be used to store non-zero data,
+ * distinguishing them from a regular syscall instruction.
+ */
+#define __CALL_EXPR "syscall 0xffff;"
+#endif
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+    WRAP_NATIVE();
+}
+int memcmp(const void *s1, const void *s2, size_t n)
+{
+    WRAP_NATIVE();
+}
+void *memset(void *s, int c, size_t n)
+{
+    WRAP_NATIVE();
+}
+char *strncpy(char *dest, const char *src, size_t n)
+{
+    WRAP_NATIVE();
+}
+int strncmp(const char *s1, const char *s2, size_t n)
+{
+    WRAP_NATIVE();
+}
+char *strcpy(char *dest, const char *src)
+{
+    WRAP_NATIVE();
+}
+char *strcat(char *dest, const char *src)
+{
+    WRAP_NATIVE();
+}
+int strcmp(const char *s1, const char *s2)
+{
+    WRAP_NATIVE();
+}
diff --git a/configure b/configure
index a076583141..e02fc2c5c0 100755
--- a/configure
+++ b/configure
@@ -1822,6 +1822,45 @@ if test "$tcg" = "enabled"; then
 fi
 )
 
+# common-user/native configuration
+(mkdir -p common-user/native
+
+native_targets=
+for target in $target_list; do
+  case $target in
+    *-softmmu)
+    continue
+    ;;
+  esac
+
+  # native call is only supported on these architectures
+  arch=${target%%-*}
+  config_target_mak=common-user/native/$target/config-target.mak
+  case $arch in
+    i386|x86_64|arm|aarch64|mips|mips64)
+      if test -f cross-build/$target/config-target.mak; then
+        mkdir -p "common-user/native/$target"
+        ln -srf cross-build/$target/config-target.mak "$config_target_mak"
+        if test $arch = arm; then
+          echo "EXTRA_NATIVE_CALL_FLAGS=-marm" >> "$config_target_mak"
+        fi
+        if test $arch = $cpu || \
+          { test $arch = i386 && test $cpu = x86_64; } || \
+          { test $arch = arm && test $cpu = aarch64; } || \
+          { test $arch = mips && test $cpu = mips64; }; then
+          echo "LD_PREFIX=/" >> "$config_target_mak"
+        fi
+        echo "LIBNATIVE=$PWD/common-user/native/$target/libnative.so" >> "$config_target_mak"
+        ln -sf $source_path/common-user/native/Makefile.target common-user/native/$target/Makefile
+        native_targets="$native_targets $target"
+      fi
+    ;;
+  esac
+done
+
+echo "NATIVE_TARGETS=$native_targets" >> config-host.mak
+)
+
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
   meson_quote() {
diff --git a/include/native/libnative.h b/include/native/libnative.h
new file mode 100644
index 0000000000..ec990d8e5f
--- /dev/null
+++ b/include/native/libnative.h
@@ -0,0 +1,8 @@
+void *memset(void *s, int c, size_t n);
+void *memcpy(void *dest, const void *src, size_t n);
+char *strncpy(char *dest, const char *src, size_t n);
+int memcmp(const void *s1, const void *s2, size_t n);
+int strncmp(const char *s1, const char *s2, size_t n);
+char *strcpy(char *dest, const char *src);
+char *strcat(char *dest, const char *src);
+int strcmp(const char *s1, const char *s2);
-- 
2.34.1


