Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A08981BCFB
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMih-0007ac-RO; Thu, 21 Dec 2023 12:20:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMif-0007aO-EB
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMid-0004V1-HR
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gTLf0x62GiI5BxwPBdezIXmvFXtexutkeWtRBMmG4JA=;
 b=IJN4zIxeNpbyGTa3XDckYNfjBeaewjvVkmZt1YW3qRztrdZ1T11pnNs9G5PyX3vvQEBh8E
 2DlfdGb9vGELrFZ6pLNqV0ACVZmdeyXLjVqcezxEfGaN1BVXyE/UaJOSJ5jxOvlRQ4bs/K
 uUS7/XFDRjFs7O06UR9WSzt8fWUCw6U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-iZ0TaIJMPtOgwaxiEoSUNA-1; Thu, 21 Dec 2023 12:20:21 -0500
X-MC-Unique: iZ0TaIJMPtOgwaxiEoSUNA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3368abe10c5so474613f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179219; x=1703784019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTLf0x62GiI5BxwPBdezIXmvFXtexutkeWtRBMmG4JA=;
 b=BgzK33imWZ25QQHK9Sv4RUI7giQLqbdwxyk07EIURQYScAfqYGqc2cM266Aw4LANWS
 3tH2nrG4bQ57XnmaOxGmoUSEghytaVCRluDj9d/O8nmm01lqhbm0+lvd/k8GoC+xWkxT
 T3JaUQ/0i1HU5i4r50jQdMdqKoTWVDEQMRYvuKulAE0PkxUO8JYTE2nmbCgxaPUslh3h
 K1Aamgqk6UdjRwi7HavLbgAbn4VXbgwZJ6oBmnldpF7YWA2wbBAXC3zbvMSTua4SE/MC
 rmMKOf25X47gHIaMtmCHpqcGlcghPRHdULYxwGYJY7j9Ev6P436Bm8OK7a3RBfiwn+Wh
 9r1Q==
X-Gm-Message-State: AOJu0YywL+yhn5BjaMoZTfWxDnGbXIwNOr5LpSmjhtGjp14UTJBgt5kZ
 37h5+UJWfyaOGWSq8NpWiefodHA+4DREo/3lV7Fa9siRWgaMtZC0+GSnFyGYdkw2u8ZGODOLbCS
 VeW6wlPnvEnpZWtDYu09FcuX/7IcbHEvyd0K4l/PzuVpWGe3GBROw/4zC6B+SfyFBt5WGNxydLo
 WSGmV1T3M=
X-Received: by 2002:adf:ed46:0:b0:336:841c:c358 with SMTP id
 u6-20020adfed46000000b00336841cc358mr42785wro.155.1703179219535; 
 Thu, 21 Dec 2023 09:20:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE/LMW6oTzMZc1EnwJMYW/1RsxXDrQE+LEM6s4PDlQ846WtjBU2cKdo3ZW7n2HcFRQ7aJx9g==
X-Received: by 2002:adf:ed46:0:b0:336:841c:c358 with SMTP id
 u6-20020adfed46000000b00336841cc358mr42778wro.155.1703179219138; 
 Thu, 21 Dec 2023 09:20:19 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a5d6d04000000b003367433118bsm2474452wrq.78.2023.12.21.09.20.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/21] meson: remove config_targetos
Date: Thu, 21 Dec 2023 18:19:47 +0100
Message-ID: <20231221171958.59350-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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
index 0a0c68050e7..48d619e0611 100644
--- a/meson.build
+++ b/meson.build
@@ -2840,7 +2840,6 @@ endif
 ########################
 
 minikconf = find_program('scripts/minikconf.py')
-config_targetos = {}
 
 config_all = {}
 config_all_devices = {}
@@ -3039,7 +3038,6 @@ target_dirs = actual_target_dirs
 # pseudo symbol replaces it.
 
 config_all += config_all_devices
-config_all += config_targetos
 config_all += config_all_disas
 config_all += {
   'CONFIG_XEN': xen.found(),
@@ -3389,7 +3387,7 @@ if enable_modules
   modulecommon = declare_dependency(link_whole: libmodulecommon, compile_args: '-DBUILD_DSO')
 endif
 
-qom_ss = qom_ss.apply(config_targetos, strict: false)
+qom_ss = qom_ss.apply({})
 libqom = static_library('qom', qom_ss.sources() + genh,
                         dependencies: [qom_ss.dependencies()],
                         name_suffix: 'fa',
@@ -3404,10 +3402,10 @@ event_loop_base = static_library('event-loop-base',
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
@@ -3570,7 +3568,6 @@ foreach d, list : target_modules
       foreach target : target_dirs
         if target.endswith('-softmmu')
           config_target = config_target_mak[target]
-          config_target += config_targetos
           target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
           c_args = ['-DNEED_CPU_H',
                     '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
@@ -3631,7 +3628,7 @@ qemu_syms = custom_target('qemu.syms', output: 'qemu.syms',
                              capture: true,
                              command: [undefsym, nm, '@INPUT@'])
 
-authz_ss = authz_ss.apply(config_targetos, strict: false)
+authz_ss = authz_ss.apply({})
 libauthz = static_library('authz', authz_ss.sources() + genh,
                           dependencies: [authz_ss.dependencies()],
                           name_suffix: 'fa',
@@ -3640,7 +3637,7 @@ libauthz = static_library('authz', authz_ss.sources() + genh,
 authz = declare_dependency(link_whole: libauthz,
                            dependencies: qom)
 
-crypto_ss = crypto_ss.apply(config_targetos, strict: false)
+crypto_ss = crypto_ss.apply({})
 libcrypto = static_library('crypto', crypto_ss.sources() + genh,
                            dependencies: [crypto_ss.dependencies()],
                            name_suffix: 'fa',
@@ -3649,7 +3646,7 @@ libcrypto = static_library('crypto', crypto_ss.sources() + genh,
 crypto = declare_dependency(link_whole: libcrypto,
                             dependencies: [authz, qom])
 
-io_ss = io_ss.apply(config_targetos, strict: false)
+io_ss = io_ss.apply({})
 libio = static_library('io', io_ss.sources() + genh,
                        dependencies: [io_ss.dependencies()],
                        link_with: libqemuutil,
@@ -3665,7 +3662,7 @@ migration = declare_dependency(link_with: libmigration,
                                dependencies: [zlib, qom, io])
 system_ss.add(migration)
 
-block_ss = block_ss.apply(config_targetos, strict: false)
+block_ss = block_ss.apply({})
 libblock = static_library('block', block_ss.sources() + genh,
                           dependencies: block_ss.dependencies(),
                           link_depends: block_syms,
@@ -3676,7 +3673,7 @@ block = declare_dependency(link_whole: [libblock],
                            link_args: '@block.syms',
                            dependencies: [crypto, io])
 
-blockdev_ss = blockdev_ss.apply(config_targetos, strict: false)
+blockdev_ss = blockdev_ss.apply({})
 libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
                              dependencies: blockdev_ss.dependencies(),
                              name_suffix: 'fa',
@@ -3685,7 +3682,7 @@ libblockdev = static_library('blockdev', blockdev_ss.sources() + genh,
 blockdev = declare_dependency(link_whole: [libblockdev],
                               dependencies: [block, event_loop_base])
 
-qmp_ss = qmp_ss.apply(config_targetos, strict: false)
+qmp_ss = qmp_ss.apply({})
 libqmp = static_library('qmp', qmp_ss.sources() + genh,
                         dependencies: qmp_ss.dependencies(),
                         name_suffix: 'fa',
@@ -3700,7 +3697,7 @@ libchardev = static_library('chardev', chardev_ss.sources() + genh,
 
 chardev = declare_dependency(link_whole: libchardev)
 
-hwcore_ss = hwcore_ss.apply(config_targetos, strict: false)
+hwcore_ss = hwcore_ss.apply({})
 libhwcore = static_library('hwcore', sources: hwcore_ss.sources() + genh,
                            name_suffix: 'fa',
                            build_by_default: false)
@@ -3757,7 +3754,6 @@ foreach target : target_dirs
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


