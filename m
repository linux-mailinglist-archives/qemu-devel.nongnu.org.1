Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4402F773B92
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:52:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOzy-0000aH-J5; Tue, 08 Aug 2023 11:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTOzw-0000Yp-7P
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:51:52 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qTOzu-00031W-9T
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:51:51 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-44781abd5a8so2416585137.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691509909; x=1692114709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n85+WWn6N/DQqkhGtTt5J0iGlzkbg6asFfed0O2vNbo=;
 b=jOBt0tA4m/c2QYQeZoIPM8rCwku81556Jb41Eael976UcSyE2wJtmtJU5p/DcUg4X2
 B2ZeBzz28R+9jphfyRKY8/t185l48KGC8MQ0ZQwY5sPRErocidboSQt2EhgMAbFsQ3mR
 lNIuPJc6VHjiIZ4sSemsTXRHsBoXV02QnvXE4ldM/y3uonOx2ibZ48vFlAfdotVVEgte
 o7ix0QvZ+ZW7IzqT3vSxba11qM2ViTL8RlGXmFtDE7wP+9Bb1rChX214+a/0TkDKGn04
 VXrop9z2Qca5aGhcaCsxwzsznKmkEpYuEgqBsEdGyz7/4SJaJnwaxK2sn8Ft18ft3jIQ
 xewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691509909; x=1692114709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n85+WWn6N/DQqkhGtTt5J0iGlzkbg6asFfed0O2vNbo=;
 b=kzNeVNjzR6+LmMKweahZpCSdFXVGO0pA0UI6Wjr8yDWJCIigyg1pJSwcSduyacE15D
 uBL11sXyCUlBTNciO9dVwF1pdm8ZOX+T2fh0oVTlWWTTkfW/ZoWC+3KoKkdX5+5+pcgL
 8F6WaEI53JIvpTdNAoJPU0mwVUvHQuOUqjiS0j4C0LmObIez34Kdw5Z7TY9i71pv4PTd
 bKAJmabOxYO7XCA9jNgEnJYl6MSViGH2yxUcS0uw5qh+26KjH3K7tbUr7jEEwXrYYe8W
 P6aZ7UQ1GL93+WLj6sV/utacjHGNOIlr52kveAiytcCxDdGNUhqZT0UIdrxXPNRqQyGE
 xbUA==
X-Gm-Message-State: AOJu0Yx1RdouKwD6ALyGiBx2ikqrARVtPR1kcAugPHID85sgCzS2kO6o
 kcQV3bNkcyVaxV8r1FD57AapqrJWrmt53XpiSdgPdg==
X-Google-Smtp-Source: AGHT+IHoAKbuyU9dWLTiDvhIadWWgv3d1N1QxYhtgVTwQV6A6+M2uES4Futb76LUWtoi8g/gX9IHPQ==
X-Received: by 2002:a67:f598:0:b0:444:ca59:57a6 with SMTP id
 i24-20020a67f598000000b00444ca5957a6mr230281vso.8.1691509908978; 
 Tue, 08 Aug 2023 08:51:48 -0700 (PDT)
Received: from localhost.localdomain ([146.70.187.10])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a67ca11000000b004409e21cf23sm2013324vsk.6.2023.08.08.08.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 08:51:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org, hchkuo@avery-design.com.tw, cbrowy@avery-design.com
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, alistair23@gmail.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [RFC v1 1/3] subprojects: libspdm: Initial support
Date: Tue,  8 Aug 2023 11:51:22 -0400
Message-ID: <040d4d4246a78bc2025a0309187990f87d6a5959.1691509717.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691509717.git.alistair.francis@wdc.com>
References: <cover.1691509717.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 meson.build                   | 78 +++++++++++++++++++++++++++++++++++
 .gitmodules                   |  3 ++
 meson_options.txt             |  3 ++
 scripts/meson-buildoptions.sh |  3 ++
 subprojects/.gitignore        |  1 +
 subprojects/libspdm.wrap      |  5 +++
 6 files changed, 93 insertions(+)
 create mode 100644 subprojects/libspdm.wrap

diff --git a/meson.build b/meson.build
index 98e68ef0b1..3ac91defbc 100644
--- a/meson.build
+++ b/meson.build
@@ -1864,6 +1864,15 @@ elif get_option('vduse_blk_export').disabled()
     have_vduse_blk_export = false
 endif
 
+have_libspdm = (targetos == 'linux')
+if get_option('libspdm').enabled()
+    if targetos != 'linux'
+        error('libspdm requires linux')
+    endif
+elif get_option('libspdm').disabled()
+    have_libspdm = false
+endif
+
 # libbpf
 libbpf = dependency('libbpf', required: get_option('bpf'), method: 'pkg-config')
 if libbpf.found() and not cc.links('''
@@ -2141,6 +2150,7 @@ config_host_data.set('CONFIG_VHOST_VDPA', have_vhost_vdpa)
 config_host_data.set('CONFIG_VMNET', vmnet.found())
 config_host_data.set('CONFIG_VHOST_USER_BLK_SERVER', have_vhost_user_blk_server)
 config_host_data.set('CONFIG_VDUSE_BLK_EXPORT', have_vduse_blk_export)
+config_host_data.set('CONFIG_LIBSPDM', have_libspdm)
 config_host_data.set('CONFIG_PNG', png.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
@@ -3172,6 +3182,7 @@ blockdev_ss = ss.source_set()
 block_ss = ss.source_set()
 chardev_ss = ss.source_set()
 common_ss = ss.source_set()
+libspdm_ss = ss.source_set()
 crypto_ss = ss.source_set()
 hwcore_ss = ss.source_set()
 io_ss = ss.source_set()
@@ -3321,6 +3332,56 @@ if have_libvduse
   libvduse = libvduse_proj.get_variable('libvduse_dep')
 endif
 
+libspdm = not_found
+if have_libspdm
+  cmake = import('cmake')
+  libspdm_opt_var = cmake.subproject_options()
+
+  libspdm_opt_var.add_cmake_defines({'ARCH': 'x64'})
+  libspdm_opt_var.add_cmake_defines({'TOOLCHAIN': 'NONE'})
+  libspdm_opt_var.add_cmake_defines({'TARGET': 'Release'})
+  libspdm_opt_var.add_cmake_defines({'CRYPTO': 'openssl'})
+  libspdm_opt_var.add_cmake_defines({'ENABLE_BINARY_BUILD': '1'})
+  libspdm_opt_var.add_cmake_defines({'COMPILED_LIBCRYPTO_PATH': '/usr/lib'})
+  libspdm_opt_var.add_cmake_defines({'COMPILED_LIBSSL_PATH': '/usr/lib'})
+  libspdm_opt_var.add_cmake_defines({'DISABLE_TESTS': '1'})
+
+  libspdm_proj = cmake.subproject('libspdm', options: libspdm_opt_var)
+
+  libspdm_lib = libspdm_proj.dependency('spdm_common_lib')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('memlib')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('malloclib')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('spdm_crypt_lib')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('spdm_responder_lib')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('cryptlib_openssl')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('spdm_device_secret_lib_null')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('platform_lib_null')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('spdm_secured_message_lib')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('spdm_crypt_lib')
+  libspdm_ss.add(libspdm_lib)
+
+  libspdm_lib = libspdm_proj.dependency('spdm_crypt_ext_lib')
+  libspdm_ss.add(libspdm_lib)
+endif
+
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
 subdir('qapi')
@@ -3593,6 +3654,19 @@ libcrypto = static_library('crypto', crypto_ss.sources() + genh,
 crypto = declare_dependency(link_whole: libcrypto,
                             dependencies: [authz, qom])
 
+if have_libspdm
+  libspdm_ss = libspdm_ss.apply(config_host, strict: false)
+  libspdm = static_library('libspdm', libspdm_ss.sources() + genh,
+                             dependencies: [libspdm_ss.dependencies()],
+                             name_suffix: 'fa',
+                             build_by_default: false)
+
+  openssl = dependency('openssl', version : '>=3.0.9')
+  libspdm = declare_dependency(link_whole: libspdm, dependencies: [openssl])
+
+  common_user_inc += 'subprojects/libspdm/include'
+endif
+
 io_ss = io_ss.apply(config_host, strict: false)
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
@@ -3668,6 +3742,10 @@ if emulator_modules.length() > 0
   alias_target('modules', emulator_modules)
 endif
 
+if have_libspdm
+  system_ss.add(libspdm)
+endif
+
 system_ss.add(authz, blockdev, chardev, crypto, io, qmp)
 common_ss.add(qom, qemuutil)
 
diff --git a/.gitmodules b/.gitmodules
index 73cae4cd4d..1bf93427ad 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -43,3 +43,6 @@
 [submodule "tests/lcitool/libvirt-ci"]
 	path = tests/lcitool/libvirt-ci
 	url = https://gitlab.com/libvirt/libvirt-ci.git
+[submodule "subprojects/libspdm"]
+	path = subprojects/libspdm
+	url = https://github.com/DMTF/libspdm.git
diff --git a/meson_options.txt b/meson_options.txt
index aaea5ddd77..b61a1f4515 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -292,6 +292,9 @@ option('libvduse', type: 'feature', value: 'auto',
 option('vduse_blk_export', type: 'feature', value: 'auto',
        description: 'VDUSE block export support')
 
+option('libspdm', type: 'feature', value: 'auto',
+       description: 'build libspdm Library')
+
 option('capstone', type: 'feature', value: 'auto',
        description: 'Whether and how to find the capstone library')
 option('fdt', type: 'combo', value: 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 9da3fe299b..8a9d3ad01d 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -126,6 +126,7 @@ meson_options_help() {
   printf "%s\n" '  libudev         Use libudev to enumerate host devices'
   printf "%s\n" '  libusb          libusb support for USB passthrough'
   printf "%s\n" '  libvduse        build VDUSE Library'
+  printf "%s\n" '  libspdm         build libspdm Library'
   printf "%s\n" '  linux-aio       Linux AIO support'
   printf "%s\n" '  linux-io-uring  Linux io_uring support'
   printf "%s\n" '  live-block-migration'
@@ -353,6 +354,8 @@ _meson_option_parse() {
     --disable-libusb) printf "%s" -Dlibusb=disabled ;;
     --enable-libvduse) printf "%s" -Dlibvduse=enabled ;;
     --disable-libvduse) printf "%s" -Dlibvduse=disabled ;;
+    --enable-libspdm) printf "%s" -Dlibspdm=enabled ;;
+    --disable-libspdm) printf "%s" -Dlibspdm=disabled ;;
     --enable-linux-aio) printf "%s" -Dlinux_aio=enabled ;;
     --disable-linux-aio) printf "%s" -Dlinux_aio=disabled ;;
     --enable-linux-io-uring) printf "%s" -Dlinux_io_uring=enabled ;;
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index adca0266be..5d0ac1be1a 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -5,4 +5,5 @@
 /dtc
 /keycodemapdb
 /libvfio-user
+/libspdm
 /slirp
diff --git a/subprojects/libspdm.wrap b/subprojects/libspdm.wrap
new file mode 100644
index 0000000000..ca3607fbaa
--- /dev/null
+++ b/subprojects/libspdm.wrap
@@ -0,0 +1,5 @@
+[wrap-git]
+url = https://github.com/DMTF/libspdm.git
+revision = 55f5141436d2f6debf4b7cd57641cc78d8e4c6fc
+depth = 1
+clone-recursive = true
-- 
2.41.0


