Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FD2726691
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wSr-0008Ci-JT; Wed, 07 Jun 2023 12:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wSp-0008CL-I2
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:56:51 -0400
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wSj-0001k1-J4
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:56:51 -0400
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-62884fa0e53so46043816d6.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686157004; x=1688749004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HWq+po+SDANNoW47p4QL7IvACAQogmmtb9TL/tLcPBU=;
 b=aRuXFbH2BdDozt/mll+og22h3lnOt6mo6YSk37w83d+wBqhcaGXxi2+2vyShnDYmOb
 WEB6N4q001Qk4lEMZWhClNB7nxEkobTbL14mo+IipkZpiUvvLaH4vOWT6UXI1eQGCH3S
 SGlCA7clQARh5aU/kPPXrUhZ8W8OxaUVSNb1vZNOvsdoSbi0WybfW87g6FaZWtMCI8pG
 jZDvQl+p0Fq5oDNJSTqB9UCnAEyus61RT6IqIfdofQsNNLx9ErcGp53STBISJVnPsmKm
 BHDtOTjkLLEC8FkBYdrB8yDwV81XaPqHlUpy5nB55Bawz7II3gp4N6mbHrbVUQ+MMtGu
 YRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686157004; x=1688749004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HWq+po+SDANNoW47p4QL7IvACAQogmmtb9TL/tLcPBU=;
 b=JBNwP48H6SiN7b1vgcc9FJTeyF0bjwqSoc75XykP6dSb7kd5q7GTpFieL/8ZVVVY4d
 XgIYKPLQNuSQ0a+Oe687Xnufk+RLQD1cJdSb+fVxxs8A5IRA4PkjXf7u/0qG3TFex9eC
 tgrxleeXFL99jRlu5y5VCWN9AjZNDvuC18ALOkYZuhD36WGDNkJxnJu1kdcFCBa7m3Mi
 ukNB2mJW7KlnjgQOu5eiEgiDiaR/l5gbPrBEZfFUxU0XXL5OuhKQtIUHEsC1sJn+BCTH
 Edh4H4igON3iDZ4HEZfuxaDL7mn3bGzYDagliIEJGgI8GcmF2ZQp8+iJOmWx2uyoU+CS
 pcCQ==
X-Gm-Message-State: AC+VfDytwrffccfGpdwAjg1GDpe30OX+yQZhcSoGm++AFb5SXZDZenSg
 j53eUvmqhSjq1SP4DeWZ2pL3HGAHlNLen1OG+PY=
X-Google-Smtp-Source: ACHHUZ7ioIFEGFtetFPNwci8sUmDsD7HPjZF2OWqZe0XecHOiip7QbddPmLFrg34pUFo0KcBYpNZXw==
X-Received: by 2002:a17:90b:e15:b0:256:bc6c:cb5b with SMTP id
 ge21-20020a17090b0e1500b00256bc6ccb5bmr1874346pjb.33.1686156551355; 
 Wed, 07 Jun 2023 09:49:11 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.226])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b00250bf8495b3sm1671808pja.39.2023.06.07.09.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:49:11 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC v2 1/6] build: Add configure options for native calls
Date: Thu,  8 Jun 2023 00:47:45 +0800
Message-Id: <20230607164750.829586-2-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-qv1-xf29.google.com
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 Makefile                            |  4 +++
 common-user/native/Makefile.include |  9 ++++++
 common-user/native/Makefile.target  | 22 +++++++++++++
 configure                           | 50 +++++++++++++++++++++++++++++
 docs/devel/build-system.rst         |  4 +++
 meson.build                         |  8 +++++
 meson_options.txt                   |  2 ++
 scripts/meson-buildoptions.sh       |  4 +++
 8 files changed, 103 insertions(+)
 create mode 100644 common-user/native/Makefile.include
 create mode 100644 common-user/native/Makefile.target

diff --git a/Makefile b/Makefile
index 3c7d67142f..923da109bf 100644
--- a/Makefile
+++ b/Makefile
@@ -185,6 +185,10 @@ SUBDIR_MAKEFLAGS=$(if $(V),,--no-print-directory --quiet)
 
 include $(SRC_PATH)/tests/Makefile.include
 
+ifeq ($(CONFIG_USER_NATIVE),y)
+	include $(SRC_PATH)/common-user/native/Makefile.include
+endif
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
index 0000000000..1038367b37
--- /dev/null
+++ b/common-user/native/Makefile.target
@@ -0,0 +1,22 @@
+# -*- Mode: makefile -*-
+#
+# Library for native calls 
+#
+
+all:
+-include ../config-host.mak
+-include config-target.mak
+
+CFLAGS+=-I$(SRC_PATH)/include -O1 -fPIC -shared -fno-stack-protector
+LDFLAGS+=
+
+SRC = $(SRC_PATH)/common-user/native/libnative.c
+TARGET = libnative.so
+
+all: $(TARGET)
+
+$(TARGET): $(SRC)
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
+
+clean:
+	rm -f $(TARGET)
diff --git a/configure b/configure
index 2a556d14c9..cc94d10c98 100755
--- a/configure
+++ b/configure
@@ -275,6 +275,7 @@ use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
 werror=""
+user_native_call="disabled"
 
 # Don't accept a target_list environment variable.
 unset target_list
@@ -787,6 +788,10 @@ for opt do
   ;;
   --disable-vfio-user-server) vfio_user_server="disabled"
   ;;
+  --enable-user-native-call) user_native_call="enabled"
+  ;;
+  --disable-user-native-call) user_native_call="disabled"
+  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -1898,6 +1903,50 @@ if test "$tcg" = "enabled"; then
 fi
 )
 
+# common-user/native configuration
+native_flag_i386="-DTARGET_I386"
+native_flag_x86_64="-DTARGET_X86_64"
+native_flag_mips="-DTARGET_MIPS"
+native_flag_mips64="-DTARGET_MIPS64"
+native_flag_arm="-DTARGET_ARM"
+native_flag_aarch64="-DTARGET_AARCH64"
+
+(config_host_mak=common-user/native/config-host.mak
+mkdir -p common-user/native
+echo "# Automatically generated by configure - do not modify" > $config_host_mak
+echo "SRC_PATH=$source_path" >> $config_host_mak
+echo "HOST_CC=$host_cc" >> $config_host_mak
+
+native_targets=
+for target in $target_list; do
+  arch=${target%%-*}
+
+  case $target in
+    *-linux-user|*-bsd-user)
+    if probe_target_compiler $target || test -n "$container_image"; then
+        mkdir -p "common-user/native/$target"
+        config_target_mak=common-user/native/$target/config-target.mak
+        ln -sf "$source_path/common-user/native/Makefile.target" "common-user/native/$target/Makefile"
+        echo "# Automatically generated by configure - do not modify" > "$config_target_mak"
+        echo "TARGET_NAME=$arch" >> "$config_target_mak"
+        echo "TARGET=$target" >> "$config_target_mak"
+        eval "target_native_flag=\${native_flag_$target_arch}"
+        target_cflags="$target_cflags $target_native_flag"
+        write_target_makefile "build-native-library-$target" >> "$config_target_mak"
+        native_targets="$native_targets $target"
+    fi
+  ;;
+  esac
+done
+
+# if native enabled
+if test "$user_native_call" = "enabled"; then
+    echo "CONFIG_USER_NATIVE=y" >> config-host.mak
+    echo "NATIVE_TARGETS=$native_targets" >> config-host.mak
+    
+fi
+)
+
 if test "$skip_meson" = no; then
   cross="config-meson.cross.new"
   meson_quote() {
@@ -1980,6 +2029,7 @@ if test "$skip_meson" = no; then
   test "$smbd" != '' && meson_option_add "-Dsmbd=$smbd"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
   test "$vfio_user_server" != auto && meson_option_add "-Dvfio_user_server=$vfio_user_server"
+  test "$user_native_call" != auto && meson_option_add "-Duser_native_call=$user_native_call"
   run_meson() {
     NINJA=$ninja $meson setup --prefix "$prefix" "$@" $cross_arg "$PWD" "$source_path"
   }
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 551c5a5ac0..05cfa8a21a 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -494,6 +494,10 @@ Built by configure:
   Configuration variables used to build the firmware and TCG tests,
   including paths to cross compilation toolchains.
 
+``common-user/native/config-host.mak``, ``common-user/native/*/config-target.mak``
+  Configuration variables used to build the native call libraries
+  including paths to cross compilation toolchains.
+
 ``pyvenv``
 
   A Python virtual environment that is used for all Python code running
diff --git a/meson.build b/meson.build
index 0a5cdefd4d..04e99a4f25 100644
--- a/meson.build
+++ b/meson.build
@@ -2012,6 +2012,11 @@ have_virtfs_proxy_helper = get_option('virtfs_proxy_helper') \
     .require(libcap_ng.found(), error_message: 'the virtfs proxy helper requires libcap-ng') \
     .allowed()
 
+have_user_native_call = get_option('user_native_call') \
+    .require(have_user, error_message: 'user_native_call requires user') \
+    .require(targetos == 'linux', error_message: 'user_native_call requires Linux') \
+    .allowed()
+
 if get_option('block_drv_ro_whitelist') == ''
   config_host_data.set('CONFIG_BDRV_RO_WHITELIST', '')
 else
@@ -2853,6 +2858,9 @@ foreach target : target_dirs
       error('Target @0@ is only available on a Linux host'.format(target))
     endif
     config_target += { 'CONFIG_LINUX_USER': 'y' }
+    if have_user_native_call
+      config_target += { 'CONFIG_USER_NATIVE_CALL': 'y' }
+    endif
   elif target.endswith('bsd-user')
     if 'CONFIG_BSD' not in config_host
       if default_targets
diff --git a/meson_options.txt b/meson_options.txt
index 90237389e2..57035e02f5 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -352,3 +352,5 @@ option('slirp_smbd', type : 'feature', value : 'auto',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+option('user_native_call', type : 'feature', value : 'disabled',
+       description: 'native bypass for library calls in user mode only')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5714fd93d9..9eda1898d6 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -173,6 +173,8 @@ meson_options_help() {
   printf "%s\n" '  tpm             TPM support'
   printf "%s\n" '  u2f             U2F emulation support'
   printf "%s\n" '  usb-redir       libusbredir support'
+  printf "%s\n" '  user-native-call'
+  printf "%s\n" '                  native bypass for library calls in user mode only'
   printf "%s\n" '  vde             vde network backend support'
   printf "%s\n" '  vdi             vdi image format support'
   printf "%s\n" '  vduse-blk-export'
@@ -472,6 +474,8 @@ _meson_option_parse() {
     --disable-u2f) printf "%s" -Du2f=disabled ;;
     --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
     --disable-usb-redir) printf "%s" -Dusb_redir=disabled ;;
+    --enable-user-native-call) printf "%s" -Duser_native_call=enabled ;;
+    --disable-user-native-call) printf "%s" -Duser_native_call=disabled ;;
     --enable-vde) printf "%s" -Dvde=enabled ;;
     --disable-vde) printf "%s" -Dvde=disabled ;;
     --enable-vdi) printf "%s" -Dvdi=enabled ;;
-- 
2.34.1


