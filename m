Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA479DAF5
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAwd-0000IH-Az; Tue, 12 Sep 2023 17:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwX-0000Fl-Gn
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:09 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwU-0007Tt-Me
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:09 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so2159467b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554145; x=1695158945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XuQ/6SpgQeQrGx0ORa1QWKQvqB4TSbMF35PDAL+KcfM=;
 b=Y/GGJgalYnevYIvCU5XcG4yHaCAWgpqpUMymsG6xCg4aNSWl8mQ28KrF3o4MVyH7+K
 j5+Vh2fAzRuMvYkabze7JFxpyCAfJ4HcS+0QpqU0SVz37OFh6KJG67UZsRCdQhdatza8
 ZiIA/tedHGiaA4Jc808NhudAYwM92FmfU3uSwyNAbkUW8CUl6LpwGz83hw2jjmevmInj
 LqTXLFOyoZA7AxslvTCewpF0KRj96IZzlK44yeIp/FcFgvZJ5PZTfZUpGVZ+X5aff4YD
 4mloA9ZzGiWcxYqHHz2F+76Al3dDSdiaUxpkP9WrI6UE2qIJL69+zB8r2cWuDBVXorYp
 0JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554145; x=1695158945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XuQ/6SpgQeQrGx0ORa1QWKQvqB4TSbMF35PDAL+KcfM=;
 b=psWZNC2ZoFJDa1DLChSCJC3IsxVLA3ihgScB5YwzSYOoEH3YPix4ZpS/UK2XVEK2WC
 jatr5YFbWPCk/AOmUu3YeVDUAY/ZI5ISt/2WfolpNdaY5TuBrBmmSvuR/qims5hFstNp
 wKRZHm6kWA6R20h605oibwsQL8ZUVZ8U/uw93HZloLAuxL7uiZMi1Yg2Nozg9hfSY0lt
 pGIXRLQ2GlMDCfVoLJOWxLVtGRXQ8i7/jlEoGAthdHeeKYIs9D5jXqsxTX9xzvuBbM3K
 G0UATkjp2aoFR3jeW5/VAROucuFAyoyz2FEMzcehGPnkgjrAH/zTJ995lVWqc9l84dsc
 +uuA==
X-Gm-Message-State: AOJu0Yx7bJ2/TYk9z97ripvskyGuAmmNzL2l53WQjnB+QfTHckBBKsdV
 DGbBQVHpFnCF/Y/VmgNjbzs=
X-Google-Smtp-Source: AGHT+IEX1hu977lh0KV6dgiNJQfo9M5sYCkVeJv8HnJWO/FFl9jBqwpy0n+n9milPOwwQqO6ZMspbg==
X-Received: by 2002:a05:6a00:39a5:b0:68f:cd32:c52d with SMTP id
 fi37-20020a056a0039a500b0068fcd32c52dmr1097436pfb.14.1694554145329; 
 Tue, 12 Sep 2023 14:29:05 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:05 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
Subject: [RFC v6 2/9] build: Implement libnative library and the build
 machinery for libnative
Date: Wed, 13 Sep 2023 05:28:35 +0800
Message-Id: <20230912212842.658374-3-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x42c.google.com
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
 Makefile                            |  2 ++
 common-user/native/Makefile.include |  8 +++++
 common-user/native/Makefile.target  | 22 +++++++++++++
 common-user/native/libnative.S      | 51 +++++++++++++++++++++++++++++
 configure                           | 39 ++++++++++++++++++++++
 5 files changed, 122 insertions(+)
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
index 0000000000..65b10fddac
--- /dev/null
+++ b/common-user/native/Makefile.include
@@ -0,0 +1,8 @@
+.PHONY: build-native
+build-native: $(NATIVE_TARGETS:%=build-native-library-%)
+$(NATIVE_TARGETS:%=build-native-library-%): build-native-library-%:
+	$(call quiet-command, \
+	    $(MAKE) -C common-user/native/$* $(SUBDIR_MAKEFLAGS), \
+	"BUILD","$* native library")
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
index 0000000000..bc51dabedf
--- /dev/null
+++ b/common-user/native/libnative.S
@@ -0,0 +1,51 @@
+.macro special_instr sym
+#if defined(__i386__)
+         ud0     \sym-1f, %eax; 1:
+#elif defined(__x86_64__)
+         ud0     \sym(%rip), %eax
+#elif defined(__arm__) || defined(__aarch64__)
+         hlt     0xffff
+1:      .word   \sym - 1b
+#elif defined(__mips__)
+         syscall 0xffff
+1:      .word   \sym - 1b
+#else
+# error
+#endif
+.endm
+
+.macro ret_instr
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+         ret
+#elif defined(__arm__)
+         bx     lr
+#elif defined(__mips__)
+         jr     $ra
+#else
+# error
+#endif
+.endm
+
+/* Symbols of native functions */
+
+.macro define_function name
+         .text
+\name:
+         special_instr 9f
+         ret_instr
+         .globl \name
+         .type \name, %function
+         .size \name, . - \name
+
+         .section .rodata
+9:      .asciz  "\name"
+.endm
+
+define_function memcmp
+define_function memcpy
+define_function memset
+define_function strcat
+define_function strcmp
+define_function strcpy
+define_function strncmp
+define_function strncpy
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


