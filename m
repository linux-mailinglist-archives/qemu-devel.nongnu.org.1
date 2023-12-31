Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A6C820A8E
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:51:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUz-0008FZ-0j; Sun, 31 Dec 2023 03:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTN-0005XC-4M
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTG-0000z2-EO
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAOJp7xt3DdPjJzf26gwCcXBP8s3bHkzvNh9a0TuWkI=;
 b=XHIvcA34w5FxUTOyUraXONClE3croelbWKZFGLc1pUjxO7RqEBIYdEU27vkhMRPeXFPnvw
 9D0IEAGC/f78VGdGd6MDAzdVEPnqym1sAovMQKFyug5PM7SWPR+4rBDeZEQncNynWUYByP
 r9232gx6LhpMEsROtIwIAJR53DYxbf4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-tb8uKTISMyakcBMdy4oDIA-1; Sun, 31 Dec 2023 03:46:51 -0500
X-MC-Unique: tb8uKTISMyakcBMdy4oDIA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d5ab2fbc9so36806085e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012409; x=1704617209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rAOJp7xt3DdPjJzf26gwCcXBP8s3bHkzvNh9a0TuWkI=;
 b=VQVq+IKzL2hqglI3gweZhsZHKy/AtuE2G7kOIxwWiheVpSo2la0xXl7NxJXhQC+Lf4
 jbssxS+/SgTJ9hO8zRRMNHH6NiavkyHlB8g8+KzcF5UY90FwthTR84nlJ1YY+VK8E/hx
 bbMZw1xp0ATpsc88FYYiwsQ235/lcM7IbOsiJZ/XFuGis/jqevBIjFsx/3cOiCn7tXUO
 2RnAm/nc1U8X3s/mXeyC5zIXXrDNAxbTrluX5NNOgyG/tdXmb0s89pj93eOolZc/piyV
 8fyqa8VH72L14j5XKhYQT+KHHbLNQizoRTjY46WTH58rHK8QB/OzaAoeQbWBlNfQJmee
 P6pQ==
X-Gm-Message-State: AOJu0Yx6pqG62Lr22SBoWMM0+Tvi/UioMgQy+yFNMuSapEyNNwxPzN1E
 O+iOKOuceXc9RQYz+OEyPBVMk8aQ5KFauZjOZWZDpo0idBN7rA69W8xrrDJsf7pHn/01tQCfjlg
 Vb6VGHnKvHeY7Zx29cS182G/tcwp4MZqV5I0obzDVQIqLpRbiA077vUyEmyE2AzZpgp2aRFioKh
 1tY825d1Y=
X-Received: by 2002:a05:600c:705:b0:40d:47b5:8e3 with SMTP id
 i5-20020a05600c070500b0040d47b508e3mr6841861wmn.31.1704012409170; 
 Sun, 31 Dec 2023 00:46:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN0HmZ1IPJRYkM+EaGphJMQPx/JR7av4TNzHuJ4dQiUapZw7VEs9Ds4QeFXUbQMzujEKmbOg==
X-Received: by 2002:a05:600c:705:b0:40d:47b5:8e3 with SMTP id
 i5-20020a05600c070500b0040d47b508e3mr6841856wmn.31.1704012408837; 
 Sun, 31 Dec 2023 00:46:48 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b004094d4292aesm36571259wmq.18.2023.12.31.00.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 42/46] meson: remove config_targetos
Date: Sun, 31 Dec 2023 09:44:58 +0100
Message-ID: <20231231084502.235366-43-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

config_targetos is now empty and can be removed; its use in sourcesets
that do not involve target-specific files can be replaced with an empty
dictionary.

In fact, at this point *all* sourcesets that do not involve
target-specific files are just glorified mutable arrays.  Enforce that
they never test for symbols in "when:" by computing the set of files
without "strict: false".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 chardev/meson.build        |  2 +-
 gdbstub/meson.build        |  4 ++--
 meson.build                | 24 ++++++++++--------------
 qga/meson.build            |  2 +-
 storage-daemon/meson.build |  2 +-
 tcg/meson.build            |  2 +-
 tests/qtest/meson.build    |  2 +-
 7 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/chardev/meson.build b/chardev/meson.build
index 9564ace868b..db6840b71af 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -28,7 +28,7 @@ else
   endif
 endif
 
-chardev_ss = chardev_ss.apply(config_targetos, strict: false)
+chardev_ss = chardev_ss.apply({})
 
 system_ss.add(files(
     'char-hmp-cmds.c',
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index e5bccba34e5..da5721d8452 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -14,8 +14,8 @@ gdb_system_ss = ss.source_set()
 gdb_user_ss.add(files('gdbstub.c', 'user.c'))
 gdb_system_ss.add(files('gdbstub.c', 'system.c'))
 
-gdb_user_ss = gdb_user_ss.apply(config_targetos, strict: false)
-gdb_system_ss = gdb_system_ss.apply(config_targetos, strict: false)
+gdb_user_ss = gdb_user_ss.apply({})
+gdb_system_ss = gdb_system_ss.apply({})
 
 libgdb_user = static_library('gdb_user',
                              gdb_user_ss.sources() + genh,
diff --git a/meson.build b/meson.build
index e37ab286c23..7aa06dc7c1b 100644
--- a/meson.build
+++ b/meson.build
@@ -2885,7 +2885,6 @@ endif
 ########################
 
 minikconf = find_program('scripts/minikconf.py')
-config_targetos = {}
 
 config_all = {}
 config_all_devices = {}
@@ -3084,7 +3083,6 @@ target_dirs = actual_target_dirs
 # pseudo symbol replaces it.
 
 config_all += config_all_devices
-config_all += config_targetos
 config_all += config_all_disas
 config_all += {
   'CONFIG_XEN': xen.found(),
@@ -3413,7 +3411,7 @@ if enable_modules
   modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
 endif
 
-qom_ss = qom_ss.apply(config_targetos, strict: false)
+qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
                         name_suffix: 'fa',
@@ -3428,10 +3426,10 @@ event_loop_base = static_library('event-loop-base',
 event_loop_base = declare_dependency(link_whole: event_loop_base,
                                      dependencies: [qom])
 
-stub_ss = stub_ss.apply(config_all, strict: false)
+stub_ss = stub_ss.apply({})
 
 util_ss.add_all(trace_ss)
-util_ss = util_ss.apply(config_all, strict: false)
+util_ss = util_ss.apply({})
 libqemuutil = static_library('qemuutil',
                              build_by_default: false,
                              sources: util_ss.sources() + stub_ss.sources() + genh,
@@ -3594,7 +3592,6 @@ foreach d, list : target_modules
       foreach target : target_dirs
         if target.endswith('-softmmu')
           config_target = config_target_mak[target]
-          config_target += config_targetos
           target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
           c_args = ['-DNEED_CPU_H',
                     '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
@@ -3655,7 +3652,7 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
-authz_ss = authz_ss.apply(config_targetos, strict: false)
+authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
                           name_suffix: 'fa',
@@ -3664,7 +3661,7 @@ libauthz = static_library('authz', authz_ss.sources() + genh,
 authz = declare_dependency(link_whole: libauthz,
                            dependencies: qom)
 
-crypto_ss = crypto_ss.apply(config_targetos, strict: false)
+crypto_ss = crypto_ss.apply({})
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
                            name_suffix: 'fa',
@@ -3673,7 +3670,7 @@ libcrypto = static_library('crypto', crypto_ss.sources() + genh,
 crypto = declare_dependency(link_whole: libcrypto,
                             dependencies: [authz, qom])
 
-io_ss = io_ss.apply(config_targetos, strict: false)
+io_ss = io_ss.apply({})
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
                        link_with: libqemuutil,
@@ -3689,7 +3686,7 @@ migration = declare_dependency(link_with: libmigration,
                                dependencies: [zlib, qom, io])
 system_ss.add(migration)
 
-block_ss = block_ss.apply(config_targetos, strict: false)
+block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
                           link_depends: block_syms,
@@ -3700,7 +3697,7 @@ block = declare_dependency(link_whole: [libblock],
                            link_args: '@block.syms',
                            dependencies: [crypto, io])
 
-blockdev_ss = blockdev_ss.apply(config_targetos, strict: false)
+blockdev_ss = blockdev_ss.apply({})
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
                              name_suffix: 'fa',
@@ -3709,7 +3706,7 @@ libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
 blockdev = declare_dependency(link_whole: [libblockdev],
                               dependencies: [block, event_loop_base])
 
-qmp_ss = qmp_ss.apply(config_targetos, strict: false)
+qmp_ss = qmp_ss.apply({})
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
                         name_suffix: 'fa',
@@ -3724,7 +3721,7 @@ libchardev = static_library('chardev', chardev_ss.sources() + genh,
 
 chardev = declare_dependency(link_whole: libchardev)
 
-hwcore_ss = hwcore_ss.apply(config_targetos, strict: false)
+hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
                            name_suffix: 'fa',
                            build_by_default: false)
@@ -3781,7 +3778,6 @@ foreach target : target_dirs
             '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
   link_args = emulator_link_args
 
-  config_target += config_targetos
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
   if targetos == 'linux'
     target_inc += include_directories('linux-headers', is_system: true)
diff --git a/qga/meson.build b/qga/meson.build
index 1113e7c7fae..66c0f1e56f8 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -87,7 +87,7 @@ else
   endif
 endif
 
-qga_ss = qga_ss.apply(config_targetos, strict: false)
+qga_ss = qga_ss.apply({})
 
 gen_tlb = []
 qga_libs = []
diff --git a/storage-daemon/meson.build b/storage-daemon/meson.build
index 5e90cd32b40..46267b63e72 100644
--- a/storage-daemon/meson.build
+++ b/storage-daemon/meson.build
@@ -5,7 +5,7 @@ qsd_ss.add(blockdev, chardev, qmp, qom, qemuutil, gnutls)
 subdir('qapi')
 
 if have_tools
-  qsd_ss = qsd_ss.apply(config_targetos, strict: false)
+  qsd_ss = qsd_ss.apply({})
   qsd = executable('qemu-storage-daemon',
                    qsd_ss.sources(),
                    dependencies: qsd_ss.dependencies(),
diff --git a/tcg/meson.build b/tcg/meson.build
index 895a11d3fa2..5afdec1e1ae 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -22,7 +22,7 @@ if get_option('tcg_interpreter')
   tcg_ss.add(files('tci.c'))
 endif
 
-tcg_ss = tcg_ss.apply(config_targetos, strict: false)
+tcg_ss = tcg_ss.apply({})
 
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 47dabf91d04..40a8bb043e4 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -310,7 +310,7 @@ qtests = {
   'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
   'migration-test': migration_files,
   'pxe-test': files('boot-sector.c'),
-  'qos-test': [chardev, io, qos_test_ss.apply(config_targetos, strict: false).sources()],
+  'qos-test': [chardev, io, qos_test_ss.apply({}).sources()],
   'tpm-crb-swtpm-test': [io, tpmemu_files],
   'tpm-crb-test': [io, tpmemu_files],
   'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
-- 
2.43.0


