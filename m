Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4110173D481
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGc-0005WW-LI; Sun, 25 Jun 2023 17:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGa-0005W1-H6
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:28 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGY-0003Qg-3s
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:28 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1b8054180acso2652765ad.1
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728445; x=1690320445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J2/dMof0jXsU0JLgvBiQehLkj/Yhzgw0HXojyG6vukg=;
 b=VYiY89pg0jzKmVzqyStGcKxrTN9WEDhlXot66MksE4HjbC3V4iK3QRIip5w9vDOrFd
 590ndHD+GWHe+kJDIG/hcptdfJFoxrb848mkTkSkE8ohkn8XOeb9ak9t1nz3lW2d/q9i
 xN0l7pdW21Wv44RiReyFH/7CFD4KhzfhonqeXCJBtDJdfBkOLLU/85vG++VqB/6ipJjO
 aiehzYHlPe7mfO+Nec1OgkSv2KbDf5DmQeNhNxfieLyDonEc3FzENNvDh55WThWGh8CL
 1ErJc3C3oYSm6QQtmH0xPC6p2Ap5/P+8MMALoEhHtvOiv6QzNRtvYheFV2+qEjN6RfFR
 70QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728445; x=1690320445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2/dMof0jXsU0JLgvBiQehLkj/Yhzgw0HXojyG6vukg=;
 b=VbAreOtDCKo0v6ZuK6G9+YRRxYieSLaK7+hDZvWBUJuOqMRTnc/TACEALkm7AY3+Qv
 nKq9jayZoXvM51BOoe8TWdXhIk9fduJqzGNC/BSCmxtmfbq4BWddzcm1hCRKuN2fb9ut
 h4QvAoHTpBLVr0FgTQu/sQlIiu603iXCW9osOHhfN7rdBKkuSGfWKMBbmRQrdGvlOlG7
 QZ34wJjD+7r4ppOEJkF7JXpKLKCADjmfpIiMhsVKIcShY6raeJCAjBQ1+G9Gvxu+gacY
 zbRe5AvHO1j3zSw2x4s17o0nZSaIQ88OjhqPJMVQqdxnlE1Oxyu4o/+uijliPBR5jNGK
 st/A==
X-Gm-Message-State: AC+VfDyxvgLcKO+AODobkhRE1ou8ajnWePV7B0gtDmETLNYC+zVMJHDb
 z9J5hylMa/ZhCnwuat/D+vM=
X-Google-Smtp-Source: ACHHUZ5dI1T6NykPlPkgO5aMWRmj9lQrSc7Jm1CNoA8dwLmY8E0LvO9EUQbpv19UCeMzLQqCpd3ZeA==
X-Received: by 2002:a17:902:da8c:b0:1af:981b:eeff with SMTP id
 j12-20020a170902da8c00b001af981beeffmr6346700plx.64.1687728444696; 
 Sun, 25 Jun 2023 14:27:24 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:24 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: [RFC v3 03/10] build: Implement libnative library and configure
 options
Date: Mon, 26 Jun 2023 05:27:00 +0800
Message-Id: <20230625212707.1078951-4-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This commit implements a shared library, where native functions are
rewritten as specialized instructions. At runtime, user programs load
the shared library, and specialized instructions are executed when
native functions are called.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 Makefile                            |   2 +
 common-user/native/Makefile.include |   9 +++
 common-user/native/Makefile.target  |  26 +++++++
 common-user/native/libnative.c      | 112 ++++++++++++++++++++++++++++
 configure                           |  84 ++++++++++++++++-----
 include/native/libnative.h          |  12 +++
 include/native/native-defs.h        |  65 ++++++++++++++++
 7 files changed, 293 insertions(+), 17 deletions(-)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.c
 create mode 100644 include/native/libnative.h
 create mode 100644 include/native/native-defs.h

diff --git a/Makefile b/Makefile
index 3c7d67142f..787b8954a6 100644
--- a/Makefile
+++ b/Makefile
@@ -185,6 +185,8 @@ SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 
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
index 0000000000..1bb468a2ec
--- /dev/null
+++ b/common-user/native/Makefile.target
@@ -0,0 +1,26 @@
+# -*- Mode: makefile -*-
+#
+# Library for native calls 
+#
+
+all:
+-include ../config-host.mak
+-include config-target.mak
+
+CFLAGS+=-O1 -fPIC -shared -fno-stack-protector -I$(SRC_PATH)/include -D$(TARGET_NAME) 
+LDFLAGS+=
+
+ifeq ($(TARGET_NAME),arm)
+EXTRA_CFLAGS+=-marm
+endif
+
+SRC = $(SRC_PATH)/common-user/native/libnative.c
+LIBNATIVE = libnative.so
+
+all: $(LIBNATIVE)
+
+$(LIBNATIVE): $(SRC)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+clean:
+	rm -f $(LIBNATIVE)
diff --git a/common-user/native/libnative.c b/common-user/native/libnative.c
new file mode 100644
index 0000000000..26a004e3b4
--- /dev/null
+++ b/common-user/native/libnative.c
@@ -0,0 +1,112 @@
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "native/libnative.h"
+#include "native/native-defs.h"
+
+#if defined(i386) || defined(x86_64)
+/* unused opcode */
+#define WRAP_NATIVE_CALL(func_id, abi_map)                          \
+    do {                                                            \
+        __asm__ volatile(".byte 0x0f,0xff\n\t"                      \
+                         ".word %c[imm1],%c[imm2]\n\t"              \
+                         : /* no outputs */                         \
+                         : [imm1] "i"(func_id), [imm2] "i"(abi_map) \
+                         :);                                        \
+    } while (0)
+
+#endif
+
+#if defined(arm) || defined(aarch64)
+/*
+ * HLT is an invalid instruction for userspace and usefully has 16
+ * bits of spare immeadiate data which we can stuff data in.
+ */
+#define WRAP_NATIVE_CALL(func_id, abi_map)            \
+    do {                                              \
+        __asm__ volatile("hlt  %c0\n\t"               \
+                         "hlt  %c1\n\t"               \
+                         : /* no outputs */           \
+                         : "i"(func_id), "i"(abi_map) \
+                         : "memory");                 \
+    } while (0)
+
+#endif
+
+#if defined(mips) || defined(mips64)
+/*
+ * There are some unused bytes in the syscall instruction
+ */
+#define WRAP_NATIVE_CALL(func_id, abi_map)            \
+    do {                                              \
+        __asm__ volatile("syscall  %c0\n\t"           \
+                         "syscall  %c1\n\t"           \
+                         : /* no outputs */           \
+                         : "i"(func_id), "i"(abi_map) \
+                         : "memory");                 \
+    } while (0)
+
+#endif
+
+static inline const uint32_t encode_1out_3in(int rtype, int arg1, int arg2,
+                                             int arg3)
+{
+    return (rtype & 0xf) | ((arg1 & 0xf) << 4) | ((arg2 & 0xf) << 8) |
+           ((arg3 & 0xf) << 12);
+}
+
+static inline const uint32_t encode_0out_3in(int arg1, int arg2, int arg3)
+{
+    return encode_1out_3in(TYPE_NO_ARG, arg1, arg2, arg3);
+}
+
+static inline const uint32_t encode_1out_2in(int rtype, int arg1, int arg2)
+{
+    return encode_1out_3in(rtype, arg1, arg2, TYPE_NO_ARG);
+}
+
+void *memcpy(void *dest, const void *src, size_t n)
+{
+    const uint32_t args = encode_1out_3in(TYPE_PTR_ARG, TYPE_PTR_ARG_W,
+                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_MEMCPY, args);
+}
+
+int memcmp(const void *s1, const void *s2, size_t n)
+{
+    const uint32_t args = encode_1out_3in(TYPE_INT_ARG, TYPE_PTR_ARG_R,
+                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_MEMCMP, args);
+}
+
+void *memset(void *s, int c, size_t n)
+{
+    const uint32_t args = encode_1out_3in(TYPE_PTR_ARG, TYPE_PTR_ARG_W,
+                                          TYPE_INT_ARG, TYPE_IPTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_MEMSET, args);
+}
+char *strncpy(char *dest, const char *src, size_t n)
+{
+    const uint32_t args = encode_1out_3in(TYPE_PTR_ARG, TYPE_PTR_ARG_W,
+                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_STRNCPY, args);
+}
+int strncmp(const char *s1, const char *s2, size_t n)
+{
+    const uint32_t args = encode_1out_3in(TYPE_INT_ARG, TYPE_PTR_ARG_R,
+                                          TYPE_PTR_ARG_R, TYPE_IPTR_ARG);
+    WRAP_NATIVE_CALL(NATIVE_STRNCMP, args);
+}
+char *strcpy(char *dest, const char *src)
+{
+    const uint32_t args =
+        encode_1out_2in(TYPE_PTR_ARG, TYPE_PTR_ARG_W, TYPE_PTR_ARG_R);
+    WRAP_NATIVE_CALL(NATIVE_STRCPY, args);
+}
+int strcmp(const char *s1, const char *s2)
+{
+    const uint32_t args =
+        encode_1out_2in(TYPE_INT_ARG, TYPE_PTR_ARG_R, TYPE_PTR_ARG_R);
+    WRAP_NATIVE_CALL(NATIVE_STRCMP, args);
+}
diff --git a/configure b/configure
index 2a556d14c9..64edbda892 100755
--- a/configure
+++ b/configure
@@ -1838,48 +1838,42 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
-# tests/tcg configuration
-(config_host_mak=tests/tcg/config-host.mak
-mkdir -p tests/tcg
-echo "# Automatically generated by configure - do not modify" > $config_host_mak
-echo "SRC_PATH=$source_path" >> $config_host_mak
-echo "HOST_CC=$host_cc" >> $config_host_mak
+# prepare config files for cross build
+config_corss_build_host_mak=cross-build/config-host.mak
+mkdir -p cross-build
+echo "# Automatically generated by configure - do not modify" > $config_corss_build_host_mak
+echo "SRC_PATH=$source_path" >> $config_corss_build_host_mak
+echo "HOST_CC=$host_cc" >> $config_corss_build_host_mak
 
 # versioned checked in the main config_host.mak above
 if test -n "$gdb_bin"; then
-    echo "HAVE_GDB_BIN=$gdb_bin" >> $config_host_mak
+    echo "HAVE_GDB_BIN=$gdb_bin" >> $config_corss_build_host_mak
 fi
 if test "$plugins" = "yes" ; then
-    echo "CONFIG_PLUGIN=y" >> $config_host_mak
+    echo "CONFIG_PLUGIN=y" >> $config_corss_build_host_mak
 fi
 
-tcg_tests_targets=
 for target in $target_list; do
   arch=${target%%-*}
-
   case $target in
     xtensa*-linux-user)
-      # the toolchain is not complete with headers, only build softmmu tests
       continue
       ;;
     *-softmmu)
-      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
       qemu="qemu-system-$arch"
       ;;
     *-linux-user|*-bsd-user)
       qemu="qemu-$arch"
       ;;
   esac
-
   if probe_target_compiler $target || test -n "$container_image"; then
       test -n "$container_image" && build_static=y
-      mkdir -p "tests/tcg/$target"
-      config_target_mak=tests/tcg/$target/config-target.mak
-      ln -sf "$source_path/tests/tcg/Makefile.target" "tests/tcg/$target/Makefile"
+      mkdir -p "cross-build/$target"
+      config_target_mak=cross-build/$target/config-target.mak
       echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
       echo "TARGET_NAME=$arch" >> "$config_target_mak"
       echo "TARGET=$target" >> "$config_target_mak"
-      write_target_makefile "build-tcg-tests-$target" >> "$config_target_mak"
+      write_target_makefile "$target" >> "$config_target_mak"
       echo "BUILD_STATIC=$build_static" >> "$config_target_mak"
       echo "QEMU=$PWD/$qemu" >> "$config_target_mak"
 
@@ -1887,7 +1881,34 @@ for target in $target_list; do
       if test "${gdb_arches#*$arch}" != "$gdb_arches"; then
           echo "HOST_GDB_SUPPORTS_ARCH=y" >> "$config_target_mak"
       fi
+  fi
+done
+
+
+# tests/tcg configuration
+(mkdir -p tests/tcg
+ln -srf $config_corss_build_host_mak tests/tcg/config-host.mak
+
+tcg_tests_targets=
+for target in $target_list; do
+  arch=${target%%-*}
+
+  case $target in
+    xtensa*-linux-user)
+      # the toolchain is not complete with headers, only build softmmu tests
+      continue
+      ;;
+    *-softmmu)
+      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
+      ;;
+    *-linux-user|*-bsd-user)
+      ;;
+  esac
 
+  if probe_target_compiler $target || test -n "$container_image"; then
+      mkdir -p "tests/tcg/$target"
+      ln -srf cross-build/$target/config-target.mak tests/tcg/$target/config-target.mak
+      ln -sf $source_path/tests/tcg/Makefile.target tests/tcg/$target/Makefile
       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
       tcg_tests_targets="$tcg_tests_targets $target"
   fi
@@ -1898,6 +1919,35 @@ if test "$tcg" = "enabled"; then
 fi
 )
 
+# common-user/native configuration
+(mkdir -p common-user/native
+# reuse the same config-host.mak as tests/tcg
+ln -srf $config_corss_build_host_mak common-user/native/config-host.mak
+
+native_targets=
+for target in $target_list; do
+  arch=${target%%-*}
+  # Skip targets that are not supported
+  case "$arch" in
+    i386|x86_64|arm|aarch64|mips|mips64)
+      case $target in
+        *-linux-user|*-bsd-user)
+          if probe_target_compiler $target || test -n "$container_image"; then
+            mkdir -p "common-user/native/$target"
+            # reuse the same config-target.mak as tests/tcg
+            ln -srf cross-build/$target/config-target.mak common-user/native/$target/config-target.mak
+            ln -sf $source_path/common-user/native/Makefile.target common-user/native/$target/Makefile
+            native_targets="$native_targets $target"
+          fi
+        ;;
+      esac
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
index 0000000000..25a59833db
--- /dev/null
+++ b/include/native/libnative.h
@@ -0,0 +1,12 @@
+#ifndef __LIBNATIVE_H__
+#define __LIBNATIVE_H__
+
+void *memcpy(void *dest, const void *src, size_t n);
+int memcmp(const void *s1, const void *s2, size_t n);
+void *memset(void *s, int c, size_t n);
+char *strncpy(char *dest, const char *src, size_t n);
+int strncmp(const char *s1, const char *s2, size_t n);
+char *strcpy(char *dest, const char *src);
+int strcmp(const char *s1, const char *s2);
+
+#endif /* __LIBNATIVE_H__ */
diff --git a/include/native/native-defs.h b/include/native/native-defs.h
new file mode 100644
index 0000000000..37ed479408
--- /dev/null
+++ b/include/native/native-defs.h
@@ -0,0 +1,65 @@
+#ifndef __NATIVE_FUNC_H__
+#define __NATIVE_FUNC_H__
+
+/*
+ * Native function IDs. These are used to identify the native function
+ */
+#define NATIVE_MEMCPY 0x1001
+#define NATIVE_MEMCMP 0x1002
+#define NATIVE_MEMSET 0x1003
+#define NATIVE_STRNCPY 0x1004
+#define NATIVE_STRNCMP 0x1005
+#define NATIVE_STRCPY 0x2001
+#define NATIVE_STRCMP 0x2002
+
+/*
+ * Argument encoding. We only really care about 3 types. The two base
+ * register sizes (32 and 64) and if the value is a pointer (in which
+ * case we need to adjust it g2h before passing to the native
+ * function).
+ */
+#define TYPE_NO_ARG 0x0
+#define TYPE_I32_ARG 0x1 /* uint32_t */
+#define TYPE_I64_ARG 0x2 /* uint64_t */
+#define TYPE_INT_ARG 0x3 /* int */
+#define TYPE_PTR_ARG 0x4 /* void* */
+#define TYPE_PTR_ARG_R 0x5
+#define TYPE_PTR_ARG_W 0x6
+
+/*
+ * Add an alias for the natural register size, it might be easier to
+ * pass this in.
+ */
+#if UINTPTR_MAX == 0xFFFFFFFF
+#define TYPE_IPTR_ARG TYPE_I32_ARG
+#elif UINTPTR_MAX == 0xFFFFFFFFFFFFFFFFu
+#define TYPE_IPTR_ARG TYPE_I64_ARG
+#else
+#error TBD pointer size
+#endif
+
+#define GET_RVALUE(types) ((types)&0xf)
+#define GET_ARG1(types) (((types) >> 4) & 0xf)
+#define GET_ARG2(types) (((types) >> 8) & 0xf)
+#define GET_ARG3(types) (((types) >> 12) & 0xf)
+
+#define IS_PTR_RVALUE(types) (GET_RVALUE(types) >= TYPE_PTR_ARG)
+#define IS_PTR_ARG1(types) (GET_ARG1(types) >= TYPE_PTR_ARG)
+#define IS_PTR_ARG2(types) (GET_ARG2(types) >= TYPE_PTR_ARG)
+#define IS_PTR_ARG3(types) (GET_ARG3(types) >= TYPE_PTR_ARG)
+
+#define IS_ARG_PTR(type) (type >= TYPE_PTR_ARG)
+#define IS_ARG_READ(type) (type == TYPE_PTR_ARG_R)
+#define IS_ARG_WRITE(type) (type == TYPE_PTR_ARG_W)
+
+/*
+ * Check if the native bypass feature is enabled.
+ */
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_NATIVE_CALL)
+extern bool native_bypass_enabled;
+#define native_call_enabled() (native_bypass_enabled)
+#else
+#define native_call_enabled() 0
+#endif
+
+#endif /* __NATIVE_FUNC_H__ */
-- 
2.34.1


