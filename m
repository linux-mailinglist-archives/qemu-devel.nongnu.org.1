Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB679729B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdm-00041s-BS; Thu, 07 Sep 2023 09:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdV-0003VF-VK
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdS-0007Pu-4c
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HOpLJD4d/iFJqosaXJ0woijBr9D1R6HCS4xj7bDmWbc=;
 b=fmjgi136uXpyynnHobRuOM7DSk69V3qG+tDbEiqi6pdVvikB2dBCv9Xnl1mIEpcv8l6Tfv
 kqNL87doqwWXStcYNxyFC7x3HHiqDD4WZMi21Qqkbo1v/EKX3yfTpfJz/ceiwFgBAw5L8I
 vKsn+lEGoO6X6xThAkRnEvJcqs78JFQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-057s555rOkuN6RyPcnrBFw-1; Thu, 07 Sep 2023 09:01:23 -0400
X-MC-Unique: 057s555rOkuN6RyPcnrBFw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401e1c55ddcso7099135e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091680; x=1694696480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOpLJD4d/iFJqosaXJ0woijBr9D1R6HCS4xj7bDmWbc=;
 b=lBazux7sFPZdqI/UnSfwzvoElGupSUkF0hzWBSCJyfZ5ApLoSO3CIrzPKVfsh6MyIR
 OZrcJ/NGXC4hbM5wQNvMckf0eYsCMLv+0onEbSnXh2mreRfI6axiLcA+3bj25sokasWM
 uhGMQChBaCVgxQFG2xUIbQUE/urUiMv9XrOwhwUXsYOf1rC4MnCekJJL6BLEH7D2BoB/
 WMRzSppMazCS9Lii6apfisE3xzsTOWpYG+h/mScRbvw3ryeHgtFlXKnPUYIJza7/PpmL
 cUW04fQpj0OGedKewPvV16PeJM0nZPkS4eQoBcDLqH3wvdBhLzBWNMVHciXYDyM7aK1O
 ESIw==
X-Gm-Message-State: AOJu0Yx0PAN0p+Hm3vLciMQy8JIBza2OCehDS9Jor8uTaaBaEx0M0OuQ
 AxlzpuUmVvAGdqgbSIYNZn9um0v1xn035/Xs7HTJeje3MMEWgJLaJbaZkrA3ilfhWKNX2/SFA0U
 OKmuu4mLVPY2qp12MEa+Tgm0/Jv9HTGLAH+xYJcoTZMTMrXDE1aLW26mH+DpTt3QKNA6+FKE0Z7
 s=
X-Received: by 2002:a7b:c7c7:0:b0:3fe:1db2:5179 with SMTP id
 z7-20020a7bc7c7000000b003fe1db25179mr4618110wmk.19.1694091679682; 
 Thu, 07 Sep 2023 06:01:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbxN6fAxCVgunKwKYopNjGtqtppvzLJwway4V15hqIJe/EV9BxMXLgCRaawAtWZc21P6u1gw==
X-Received: by 2002:a7b:c7c7:0:b0:3fe:1db2:5179 with SMTP id
 z7-20020a7bc7c7000000b003fe1db25179mr4618081wmk.19.1694091679063; 
 Thu, 07 Sep 2023 06:01:19 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fbdbd0a7desm2473968wmd.27.2023.09.07.06.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 31/51] configure,
 meson: remove target OS symbols from config-host.mak
Date: Thu,  7 Sep 2023 14:59:40 +0200
Message-ID: <20230907130004.500601-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stop applying config-host.mak to the sourcesets, since it does not
have any more CONFIG_* symbols coming from the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                   |  2 +-
 chardev/meson.build        |  2 +-
 configure                  | 18 ----------------
 docs/devel/kconfig.rst     |  2 +-
 gdbstub/meson.build        |  4 ++--
 meson.build                | 43 ++++++++++++++++++++++++++------------
 qga/meson.build            |  4 ++--
 storage-daemon/meson.build |  2 +-
 tcg/meson.build            |  2 +-
 tests/meson.build          |  2 +-
 tests/qtest/meson.build    | 12 +++++------
 tests/unit/meson.build     |  6 +++---
 12 files changed, 49 insertions(+), 50 deletions(-)

diff --git a/Makefile b/Makefile
index 118c28e80d9..bfc4b2c8e92 100644
--- a/Makefile
+++ b/Makefile
@@ -313,7 +313,7 @@ endif
 	@echo  'Documentation targets:'
 	$(call print-help,html man,Build documentation in specified format)
 	@echo  ''
-ifdef CONFIG_WIN32
+ifneq ($(filter msi, $(ninja-targets)),)
 	@echo  'Windows targets:'
 	$(call print-help,installer,Build NSIS-based installer for QEMU)
 	$(call print-help,msi,Build MSI-based installer for qemu-ga)
diff --git a/chardev/meson.build b/chardev/meson.build
index fb630b429eb..6d56ad32fdb 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -26,7 +26,7 @@ chardev_ss.add(when: 'CONFIG_WIN32', if_true: files(
   'char-win.c',
 ))
 
-chardev_ss = chardev_ss.apply(config_host, strict: false)
+chardev_ss = chardev_ss.apply(config_targetos, strict: false)
 
 system_ss.add(files(
     'char-hmp-cmds.c',
diff --git a/configure b/configure
index a76bdd78623..ef085376922 100755
--- a/configure
+++ b/configure
@@ -1683,32 +1683,14 @@ echo >> $config_host_mak
 echo all: >> $config_host_mak
 
 if test "$targetos" = "windows"; then
-  echo "CONFIG_WIN32=y" >> $config_host_mak
   echo "QEMU_GA_MANUFACTURER=${QEMU_GA_MANUFACTURER-QEMU}" >> $config_host_mak
   echo "QEMU_GA_DISTRO=${QEMU_GA_DISTRO-Linux}" >> $config_host_mak
   echo "QEMU_GA_VERSION=${QEMU_GA_VERSION-$(cat "$source_path"/VERSION)}" >> $config_host_mak
-else
-  echo "CONFIG_POSIX=y" >> $config_host_mak
-fi
-
-if test "$targetos" = "linux" ; then
-  echo "CONFIG_LINUX=y" >> $config_host_mak
-fi
-
-if test "$targetos" = "darwin" ; then
-  echo "CONFIG_DARWIN=y" >> $config_host_mak
 fi
 
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 
-# XXX: suppress that
-case $targetos in
-  gnu/kfreebsd | freebsd | dragonfly | netbsd | openbsd | darwin)
-    echo "CONFIG_BSD=y" >> $config_host_mak
-    ;;
-esac
-
 if test -n "$gdb_bin"; then
     gdb_version=$($gdb_bin --version | head -n 1)
     if version_ge ${gdb_version##* } 9.1; then
diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index e3a544e463f..73f52de1067 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -316,6 +316,6 @@ variable::
 
     host_kconfig = \
       (have_tpm ? ['CONFIG_TPM=y'] : []) + \
-      ('CONFIG_LINUX' in config_host ? ['CONFIG_LINUX=y'] : []) + \
+      (targetos == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
       (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
       ...
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index 77762e0b3e1..9500b9dc4e6 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -14,8 +14,8 @@ gdb_system_ss = ss.source_set()
 gdb_user_ss.add(files('gdbstub.c', 'user.c'))
 gdb_system_ss.add(files('gdbstub.c', 'softmmu.c'))
 
-gdb_user_ss = gdb_user_ss.apply(config_host, strict: false)
-gdb_system_ss = gdb_system_ss.apply(config_host, strict: false)
+gdb_user_ss = gdb_user_ss.apply(config_targetos, strict: false)
+gdb_system_ss = gdb_system_ss.apply(config_targetos, strict: false)
 
 libgdb_user = static_library('gdb_user',
                              gdb_user_ss.sources() + genh,
diff --git a/meson.build b/meson.build
index a7470b57081..16f0475955d 100644
--- a/meson.build
+++ b/meson.build
@@ -2069,10 +2069,15 @@ config_host_data.set('CONFIG_MODULE_UPGRADES', get_option('module_upgrades'))
 config_host_data.set('CONFIG_ATTR', libattr.found())
 config_host_data.set('CONFIG_BDRV_WHITELIST_TOOLS', get_option('block_drv_whitelist_in_tools'))
 config_host_data.set('CONFIG_BRLAPI', brlapi.found())
+config_host_data.set('CONFIG_BSD', targetos in bsd_oses)
 config_host_data.set('CONFIG_COCOA', cocoa.found())
+config_host_data.set('CONFIG_DARWIN', targetos == 'darwin')
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
 config_host_data.set('CONFIG_GCOV', get_option('b_coverage'))
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
+config_host_data.set('CONFIG_LINUX', targetos == 'linux')
+config_host_data.set('CONFIG_POSIX', targetos != 'windows')
+config_host_data.set('CONFIG_WIN32', targetos == 'windows')
 config_host_data.set('CONFIG_LZO', lzo.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_BLKIO', blkio.found())
@@ -2799,6 +2804,18 @@ endif
 ########################
 
 minikconf = find_program('scripts/minikconf.py')
+config_targetos = {
+  (targetos == 'windows' ? 'CONFIG_WIN32' : 'CONFIG_POSIX'): 'y'
+}
+if targetos == 'darwin'
+  config_targetos += {'CONFIG_DARWIN': 'y'}
+elif targetos == 'linux'
+  config_targetos += {'CONFIG_LINUX': 'y'}
+endif
+if targetos in bsd_oses
+  config_targetos += {'CONFIG_BSD': 'y'}
+endif
+
 config_all = {}
 config_all_devices = {}
 config_all_disas = {}
@@ -2842,7 +2859,7 @@ host_kconfig = \
   (have_vhost_vdpa ? ['CONFIG_VHOST_VDPA=y'] : []) + \
   (have_vhost_kernel ? ['CONFIG_VHOST_KERNEL=y'] : []) + \
   (have_virtfs ? ['CONFIG_VIRTFS=y'] : []) + \
-  ('CONFIG_LINUX' in config_host ? ['CONFIG_LINUX=y'] : []) + \
+  (targetos == 'linux' ? ['CONFIG_LINUX=y'] : []) + \
   (have_pvrdma ? ['CONFIG_PVRDMA=y'] : []) + \
   (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=y'] : []) + \
   (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWED=y'] : [])
@@ -2863,7 +2880,7 @@ foreach target : target_dirs
     endif
     config_target += { 'CONFIG_LINUX_USER': 'y' }
   elif target.endswith('bsd-user')
-    if 'CONFIG_BSD' not in config_host
+    if targetos not in bsd_oses
       if default_targets
         continue
       endif
@@ -2994,7 +3011,7 @@ target_dirs = actual_target_dirs
 # pseudo symbol replaces it.
 
 config_all += config_all_devices
-config_all += config_host
+config_all += config_targetos
 config_all += config_all_disas
 config_all += {
   'CONFIG_XEN': xen.found(),
@@ -3341,7 +3358,7 @@ if enable_modules
   modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
 endif
 
-qom_ss = qom_ss.apply(config_host, strict: false)
+qom_ss = qom_ss.apply(config_targetos, strict: false)
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
                         name_suffix: 'fa')
@@ -3515,7 +3532,7 @@ foreach d, list : target_modules
       foreach target : target_dirs
         if target.endswith('-softmmu')
           config_target = config_target_mak[target]
-          config_target += config_host
+          config_target += config_targetos
           target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
           c_args = ['-DNEED_CPU_H',
                     '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
@@ -3576,7 +3593,7 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
-authz_ss = authz_ss.apply(config_host, strict: false)
+authz_ss = authz_ss.apply(config_targetos, strict: false)
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
                           name_suffix: 'fa',
@@ -3585,7 +3602,7 @@ libauthz = static_library('authz', authz_ss.sources() + genh,
 authz = declare_dependency(link_whole: libauthz,
                            dependencies: qom)
 
-crypto_ss = crypto_ss.apply(config_host, strict: false)
+crypto_ss = crypto_ss.apply(config_targetos, strict: false)
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
                            name_suffix: 'fa',
@@ -3594,7 +3611,7 @@ libcrypto = static_library('crypto', crypto_ss.sources() + genh,
 crypto = declare_dependency(link_whole: libcrypto,
                             dependencies: [authz, qom])
 
-io_ss = io_ss.apply(config_host, strict: false)
+io_ss = io_ss.apply(config_targetos, strict: false)
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
                        link_with: libqemuutil,
@@ -3610,7 +3627,7 @@ migration = declare_dependency(link_with: libmigration,
                                dependencies: [zlib, qom, io])
 system_ss.add(migration)
 
-block_ss = block_ss.apply(config_host, strict: false)
+block_ss = block_ss.apply(config_targetos, strict: false)
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
                           link_depends: block_syms,
@@ -3621,7 +3638,7 @@ block = declare_dependency(link_whole: [libblock],
                            link_args: '@block.syms',
                            dependencies: [crypto, io])
 
-blockdev_ss = blockdev_ss.apply(config_host, strict: false)
+blockdev_ss = blockdev_ss.apply(config_targetos, strict: false)
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
                              name_suffix: 'fa',
@@ -3630,7 +3647,7 @@ libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
 blockdev = declare_dependency(link_whole: [libblockdev],
                               dependencies: [block, event_loop_base])
 
-qmp_ss = qmp_ss.apply(config_host, strict: false)
+qmp_ss = qmp_ss.apply(config_targetos, strict: false)
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
                         name_suffix: 'fa',
@@ -3645,7 +3662,7 @@ libchardev = static_library('chardev', chardev_ss.sources() + genh,
 
 chardev = declare_dependency(link_whole: libchardev)
 
-hwcore_ss = hwcore_ss.apply(config_host, strict: false)
+hwcore_ss = hwcore_ss.apply(config_targetos, strict: false)
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
                            name_suffix: 'fa',
                            build_by_default: false)
@@ -3702,7 +3719,7 @@ foreach target : target_dirs
             '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
   link_args = emulator_link_args
 
-  config_target += config_host
+  config_target += config_targetos
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
   if targetos == 'linux'
     target_inc += include_directories('linux-headers', is_system: true)
diff --git a/qga/meson.build b/qga/meson.build
index dd18092f561..59cae0cc6ee 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -85,7 +85,7 @@ qga_ss.add(when: 'CONFIG_WIN32', if_true: files(
   'vss-win32.c'
 ))
 
-qga_ss = qga_ss.apply(config_host, strict: false)
+qga_ss = qga_ss.apply(config_targetos, strict: false)
 
 gen_tlb = []
 qga_libs = []
@@ -180,7 +180,7 @@ test_env.set('G_TEST_BUILDDIR', meson.current_build_dir())
 # the leak detector in build-oss-fuzz Gitlab CI test. we should re-enable
 # this when an alternative is implemented or when the underlying glib
 # issue is identified/fix
-#if 'CONFIG_POSIX' in config_host
+#if targetos != 'windows'
 if false
   srcs = [files('commands-posix-ssh.c')]
   i = 0
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 49c9d2eac91..5e90cd32b40 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -5,7 +5,7 @@ qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil, gnutls)
 subdir('qapi')
 
 if have_tools
-  qsd_ss = qsd_ss.apply(config_host, strict: false)
+  qsd_ss = qsd_ss.apply(config_targetos, strict: false)
   qsd = executable('qemu-storage-daemon',
                    qsd_ss.sources(),
                    dependencies: qsd_ss.dependencies(),
diff --git a/tcg/meson.build b/tcg/meson.build
index c0252c41988..0014dca7d4f 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -22,7 +22,7 @@ if get_option('tcg_interpreter')
   tcg_ss.add(files('tci.c'))
 endif
 
-tcg_ss = tcg_ss.apply(config_host, strict: false)
+tcg_ss = tcg_ss.apply(config_targetos, strict: false)
 
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
diff --git a/tests/meson.build b/tests/meson.build
index c2528a88f99..debaa4505eb 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -68,7 +68,7 @@ test_deps = {
   'test-qht-par': qht_bench,
 }
 
-if have_tools and have_vhost_user and 'CONFIG_LINUX' in config_host
+if have_tools and have_vhost_user and targetos == 'linux'
   executable('vhost-user-bridge',
              sources: files('vhost-user-bridge.c'),
              dependencies: [qemuutil, vhost_user])
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index df63909ee51..383bdfeda96 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -38,8 +38,8 @@ qtests_cxl = \
 #        for the availability of the default NICs in the tests
 qtests_filter = \
   (get_option('default_devices') and slirp.found() ? ['test-netfilter'] : []) + \
-  (get_option('default_devices') and config_host.has_key('CONFIG_POSIX') ? ['test-filter-mirror'] : []) + \
-  (get_option('default_devices') and config_host.has_key('CONFIG_POSIX') ? ['test-filter-redirector'] : [])
+  (get_option('default_devices') and targetos != 'windows' ? ['test-filter-mirror'] : []) + \
+  (get_option('default_devices') and targetos != 'windows' ? ['test-filter-redirector'] : [])
 
 qtests_i386 = \
   (slirp.found() ? ['pxe-test'] : []) + \
@@ -48,7 +48,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +           \
   (config_all_devices.has_key('CONFIG_SGA') ? ['boot-serial-test'] : []) +                  \
   (config_all_devices.has_key('CONFIG_ISA_IPMI_KCS') ? ['ipmi-kcs-test'] : []) +            \
-  (config_host.has_key('CONFIG_LINUX') and                                                  \
+  (targetos == 'linux' and                                                                  \
    config_all_devices.has_key('CONFIG_ISA_IPMI_BT') and
    config_all_devices.has_key('CONFIG_IPMI_EXTERN') ? ['ipmi-bt-test'] : []) +              \
   (config_all_devices.has_key('CONFIG_WDT_IB700') ? ['wdt_ib700-test'] : []) +              \
@@ -74,7 +74,7 @@ qtests_i386 = \
   (config_all_devices.has_key('CONFIG_SB16') ? ['fuzz-sb16-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_SDHCI_PCI') ? ['fuzz-sdcard-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_ESP_PCI') ? ['am53c974-test'] : []) +                 \
-  (config_host.has_key('CONFIG_POSIX') and                                                  \
+  (targetos != 'windows' and                                                                \
    config_all_devices.has_key('CONFIG_ACPI_ERST') ? ['erst-test'] : []) +                   \
   (config_all_devices.has_key('CONFIG_PCIE_PORT') and                                       \
    config_all_devices.has_key('CONFIG_VIRTIO_NET') and                                      \
@@ -275,7 +275,7 @@ if config_all_devices.has_key('CONFIG_VIRTIO_SERIAL')
   qos_test_ss.add(files('virtio-serial-test.c'))
 endif
 
-if config_host.has_key('CONFIG_POSIX')
+if targetos != 'windows'
   qos_test_ss.add(files('e1000e-test.c'))
 endif
 if have_virtfs
@@ -308,7 +308,7 @@ qtests = {
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
   'pxe-test': files('boot-sector.c'),
-  'qos-test': [chardev, io, qos_test_ss.apply(config_host, strict: false).sources()],
+  'qos-test': [chardev, io, qos_test_ss.apply(config_targetos, strict: false).sources()],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 93977cc32d2..0299ef6906c 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -98,7 +98,7 @@ if have_block
   }
   if gnutls.found() and \
      tasn1.found() and \
-     'CONFIG_POSIX' in config_host
+     targetos != 'windows'
     tests += {
       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
                                    tasn1, crypto, gnutls],
@@ -113,7 +113,7 @@ if have_block
   if xts == 'private'
     tests += {'test-crypto-xts': [crypto, io]}
   endif
-  if 'CONFIG_POSIX' in config_host
+  if targetos != 'windows'
     tests += {
       'test-image-locking': [testblock],
       'test-nested-aio-poll': [testblock],
@@ -148,7 +148,7 @@ if have_system
   # are not runnable under TSan due to a known issue.
   # https://github.com/google/sanitizers/issues/1116
   if not get_option('tsan')
-    if 'CONFIG_POSIX' in config_host
+    if targetos != 'windows'
         tests += {
           'test-char': ['socket-helpers.c', qom, io, chardev]
         }
-- 
2.41.0


