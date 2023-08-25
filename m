Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAAD7884DA
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTxr-00076P-Ge; Fri, 25 Aug 2023 06:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxq-000769-6z
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZTxm-0004kT-7z
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:22:49 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so652281b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692958965; x=1693563765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XKF8yloHlp3OItWzVeWkoBwxtc6EI5o63l2lDH6G7s=;
 b=X2rwomXoy1NnARDSUMbGjqO8UdHxRAE+3N2J3prmgrt+X1ivOYTT0fv/3NaWRS81uG
 LJvRwAW5citblQSoj0wrWCc7K6AoZ4ZdVpjlLPMNGMk+UC6BR2jT0Q9tRDmfR8R7SCDy
 BkHpEhasgkrwtlSv9QkJEdrQ/IMiKg8MDMmK/jxRcO4LT/pHTZMkIEZAoCx5d48TlzJs
 C17MPXLFCJd7PvRdmyA66V65sxjHt4egzB/kd4QOgFFY9rFcBycVLV8lyHkl+sqX/R1g
 2ZZJAnRD4h1CX+2JiqEDrZMuNn3XmOUyW4+StnEMULkcmSx6sxX1PCrpPkxaDkfpSQ9t
 DnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692958965; x=1693563765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XKF8yloHlp3OItWzVeWkoBwxtc6EI5o63l2lDH6G7s=;
 b=UDRvY0FnwuRgEu8F18+rS3kaLd9V6dRUNB7AjiOuDiW3TBxM+8vywav3jdIpzOjTaN
 h0on0JVwuriDuEJAGkxo2hIT0rbwjMCqcu4qpOnUWSH6sx9E3PUXnYE/c4NQXNesbGO5
 LDkVqr+P1XUYebM+YeZPCpnxMEgdtb8TfoKr7+HuJPdLVqc9Fi7HCdg3nK1YArXElBY+
 NbvIJBHe4L1BIY+e9wKqaF8XV/0t/sXD0ZSVWJR4uYMaCJtWcqiurfWpHghjZfud82NU
 aHchyBZO6QxexiOJzAs/C5EwU2ffCVK2eJpY82FeBrZXaI2nfYmhBIYz1mFEbIGzgDoq
 al4Q==
X-Gm-Message-State: AOJu0YwAh5QnWF6ZX5RZ5VuWsRlE4lXZtiWImdag6MBy+yK5+lrNxJOu
 qhsU9PN0+41UjlueNoRdRwo=
X-Google-Smtp-Source: AGHT+IH5m/D4OrRR+0CWRqrPib+kmaG33rkS2G4XQRnjkBxYoKuEq8pYFD+zREkhQhfgL3Rg4owneQ==
X-Received: by 2002:aa7:8881:0:b0:68b:dbad:7ae0 with SMTP id
 z1-20020aa78881000000b0068bdbad7ae0mr7919717pfe.21.1692958964764; 
 Fri, 25 Aug 2023 03:22:44 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa781c5000000b0068a077847c7sm1220954pfn.135.2023.08.25.03.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:22:44 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: [RFC v5 02/10] build: Implement libnative library and the build
 machinery for libnative
Date: Fri, 25 Aug 2023 18:20:00 +0800
Message-Id: <20230825102009.1754699-3-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
References: <20230825102009.1754699-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x431.google.com
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
 common-user/native/Makefile.target  | 22 +++++++++
 common-user/native/libnative.S      | 69 +++++++++++++++++++++++++++++
 configure                           | 39 ++++++++++++++++
 5 files changed, 141 insertions(+)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target
 create mode 100644 common-user/native/libnative.S

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
index 0000000000..65d90102e2
--- /dev/null
+++ b/common-user/native/Makefile.target
@@ -0,0 +1,22 @@
+# -*- Mode: makefile -*-
+#
+# Library for native calls
+#
+
+all:
+-include ../../../config-host.mak
+-include config-target.mak
+
+CFLAGS+=-shared -D $(TARGET_NAME)
+LDFLAGS+=
+
+SRC = $(SRC_PATH)/common-user/native/libnative.S
+LIBNATIVE = libnative.so
+
+all: $(LIBNATIVE)
+
+$(LIBNATIVE): $(SRC)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $(EXTRA_NATIVE_CALL_FLAGS) $< -o $@ $(LDFLAGS)
+
+clean:
+	rm -f $(LIBNATIVE)
diff --git a/common-user/native/libnative.S b/common-user/native/libnative.S
new file mode 100644
index 0000000000..3692eaa3cf
--- /dev/null
+++ b/common-user/native/libnative.S
@@ -0,0 +1,69 @@
+#if defined(i386) || defined(x86_64)
+/*
+ * An unused instruction is utilized to mark a native call.
+ */
+#define __SPECIAL_INSTR .byte 0x0f, 0xff;
+#define __RET_INSTR ret;
+#endif
+
+#if defined(arm) || defined(aarch64)
+/*
+ * HLT is an invalid instruction for userspace programs,
+ * and is used to mark a native call.
+ */
+#define __SPECIAL_INSTR hlt 0xffff;
+#if defined(aarch64)
+#define __RET_INSTR ret;
+#else
+#define __RET_INSTR bx lr;
+#endif
+#endif
+
+
+#if defined(mips) || defined(mips64)
+/*
+ * The syscall instruction contains 20 unused bits, which are typically
+ * set to 0. These bits can be used to store non-zero data,
+ * distinguishing them from a regular syscall instruction.
+ */
+#define __SPECIAL_INSTR syscall 0xffff;
+#define __RET_INSTR jr $ra;
+#endif
+
+/* Symbols of native functions */
+.section .data
+sym_memset:  .asciz "memset"
+sym_memcpy:  .asciz "memcpy"
+sym_strncpy:  .asciz "strncpy"
+sym_memcmp:  .asciz "memcmp"
+sym_strncmp:  .asciz "strncmp"
+sym_strcpy:  .asciz "strcpy"
+sym_strcat:  .asciz "strcat"
+sym_strcmp:  .asciz "strcmp"
+
+.macro define_function name
+\name:
+#if defined(x86_64) || defined(aarch64)
+    __SPECIAL_INSTR
+    .quad sym_\name
+    __RET_INSTR
+#elif defined(mips64)
+.align 4
+    __SPECIAL_INSTR
+    .quad sym_\name
+    __RET_INSTR
+#elif defined(i386) || defined(mips) || defined(arm)
+    __SPECIAL_INSTR
+    .long sym_\name
+    __RET_INSTR
+#endif
+.endm
+
+define_function memcpy
+define_function strncpy
+define_function memset
+define_function memcmp
+define_function strncmp
+define_function strcpy
+define_function strcat
+define_function strcmp
diff --git a/configure b/configure
index 7a1e463d9c..de533b27a2 100755
--- a/configure
+++ b/configure
@@ -1826,6 +1826,45 @@ if test "$tcg" = "enabled"; then
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
+  config_target_mak=common-user/native/${target}/config-target.mak
+  case $arch in
+    i386|x86_64|arm|aarch64|mips|mips64)
+      if test -f cross-build/${target}/config-target.mak; then
+        mkdir -p "common-user/native/${target}"
+        ln -srf cross-build/${target}/config-target.mak "$config_target_mak"
+        if test $arch = arm; then
+          echo "EXTRA_NATIVE_CALL_FLAGS=-marm" >> "$config_target_mak"
+        fi
+        if test $arch = $cpu || \
+          { test $arch = i386 && test $cpu = x86_64; } || \
+          { test $arch = arm && test $cpu = aarch64; } || \
+          { test $arch = mips && test $cpu = mips64; }; then
+          echo "LD_PREFIX=/" >> "$config_target_mak"
+        fi
+        echo "LIBNATIVE=$PWD/common-user/native/${target}/libnative.so" >> "$config_target_mak"
+        ln -sf ${source_path}/common-user/native/Makefile.target common-user/native/${target}/Makefile
+        native_targets="$native_targets ${target}"
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
-- 
2.34.1


