Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A5707064
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH1-0004xb-Dv; Wed, 17 May 2023 13:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEm-0001qX-Do
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEk-0004RJ-En
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Z22DnnWCfFDBaUJH5DlfNaapeEc3FSg7euNvn0EgDY=;
 b=J8Q/DodqT5NBFctgujHB7UaQJe0YsCTeUQ6c/4BhPNXoUW+GlamuXbBwIj/Jfoor9btOj0
 lkOgSul3e+fNKRWxp9A7H9gCTdFiP1tYxsCwnYBx3Ny+fPMRSiQF3eAY0btHkBfEDN1JKc
 ylEXHsXHNtD/xZwGWv0mjFAJxDHExng=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-tTOj0D6UO3GXJvYigjChSA-1; Wed, 17 May 2023 13:46:51 -0400
X-MC-Unique: tTOj0D6UO3GXJvYigjChSA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3079d15b51dso166092f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345609; x=1686937609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Z22DnnWCfFDBaUJH5DlfNaapeEc3FSg7euNvn0EgDY=;
 b=Hx3XfXncFQRgeOyuK3CLqmgwlRTm6CWOTNhVk7lgkIN2YMc0vef9DLHfqUALis2MC1
 5HHpR88aVs7/w19B2aVPUCOMXel0tT/uwvAUvuOVQ6KqVvIABD7dJSqGzmMJQICNtia2
 hkOgFWJG4xzKyI6bnklblJOvqMWC7SyFw5yrSvhzmpxT9a8lft3roY6/zS1iCsu1cpGr
 /KuYPQmktz+o7Qn4EB/FI+v3rPn5qn3N2IDrxn7Y9DPX7NZvVa88FQUI+isjOlUnlaRe
 IN3URieT65sElTgQSQZrZtuaQsc+vtOhEG7QLcFaYTxs001RJgM/OrY5Bi+Z77mjRniG
 VnHg==
X-Gm-Message-State: AC+VfDxPRg1S2llS1eSCehibf8DHqil08bSgTIm7//wW13ElmlJ3ec9y
 3hpu3ZCl/niqT7oX9f/TM25chbjdYdShyWcJRH4MDvHmeI15RQvx75UeUgisVg3e77yoHd8+wDd
 /IxtpQ70N6mCwRbR6WMJyt5chfgDj8qh/Y48SM9MJ55AVpAabM8uASUmZU0bwAvN1OTJ8nybdJD
 w=
X-Received: by 2002:a5d:4212:0:b0:306:45ef:9935 with SMTP id
 n18-20020a5d4212000000b0030645ef9935mr1479148wrq.13.1684345609444; 
 Wed, 17 May 2023 10:46:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mA961CiSG6DeCgBMYWe8+ggHZOY2YcoNrntrlh9iP8yTI1l27hGORroY0dMGIbsNdJwMqFA==
X-Received: by 2002:a5d:4212:0:b0:306:45ef:9935 with SMTP id
 n18-20020a5d4212000000b0030645ef9935mr1479136wrq.13.1684345609027; 
 Wed, 17 May 2023 10:46:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 s2-20020a1cf202000000b003f50876905dsm2876986wmc.6.2023.05.17.10.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 53/68] configure, meson: move --enable-modules to Meson
Date: Wed, 17 May 2023 19:45:05 +0200
Message-Id: <20230517174520.887405-54-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 20 --------------------
 meson.build                   | 22 ++++++++++++++--------
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 tests/qtest/meson.build       |  2 +-
 5 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/configure b/configure
index 3267b1027970..5edd3765cd4e 100755
--- a/configure
+++ b/configure
@@ -280,7 +280,6 @@ tsan="no"
 fortify_source="yes"
 docs="auto"
 EXESUF=""
-modules="no"
 prefix="/usr/local"
 qemu_suffix="qemu"
 softmmu="yes"
@@ -751,12 +750,6 @@ for opt do
   ;;
   --disable-docs) docs=disabled
   ;;
-  --enable-modules)
-      modules="yes"
-  ;;
-  --disable-modules)
-      modules="no"
-  ;;
   --cpu=*)
   ;;
   --target-list=*) target_list="$optarg"
@@ -1051,7 +1044,6 @@ cat << EOF
   linux-user      all linux usermode emulation targets
   bsd-user        all BSD usermode emulation targets
   pie             Position Independent Executables
-  modules         modules support (non-Windows)
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
   safe-stack      SafeStack Stack Smash Protection. Depends on
@@ -1342,16 +1334,7 @@ EOF
   fi
 fi
 
-# Our module code doesn't support Windows
-if test "$modules" = "yes" && test "$mingw32" = "yes" ; then
-  error_exit "Modules are not available for Windows"
-fi
-
-# Static linking is not possible with plugins, modules or PIE
 if test "$static" = "yes" ; then
-  if test "$modules" = "yes" ; then
-    error_exit "static and modules are mutually incompatible"
-  fi
   if test "$plugins" = "yes"; then
     error_exit "static and plugins are mutually incompatible"
   else
@@ -2308,9 +2291,6 @@ if test "$solaris" = "yes" ; then
 fi
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
-if test "$modules" = "yes"; then
-  echo "CONFIG_MODULES=y" >> $config_host_mak
-fi
 
 # XXX: suppress that
 if [ "$bsd" = "yes" ] ; then
diff --git a/meson.build b/meson.build
index 50e36729eb67..531f7a84c9aa 100644
--- a/meson.build
+++ b/meson.build
@@ -17,7 +17,6 @@ fs = import('fs')
 targetos = host_machine.system()
 sh = find_program('sh')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
-enable_modules = 'CONFIG_MODULES' in config_host
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
@@ -84,6 +83,12 @@ have_ga = get_option('guest_agent') \
   .require(targetos in ['sunos', 'linux', 'windows', 'freebsd', 'netbsd', 'openbsd'],
            error_message: 'unsupported OS for QEMU guest agent') \
   .allowed()
+enable_modules = get_option('modules') \
+  .require(targetos != 'windows',
+           error_message: 'Modules are not available for Windows') \
+  .require(not get_option('prefer_static'),
+           error_message: 'Modules are incompatible with static linking') \
+  .allowed()
 have_block = have_system or have_tools
 
 python = import('python').find_installation()
@@ -498,7 +503,7 @@ glib_req_ver = '>=2.56.0'
 glib_pc = dependency('glib-2.0', version: glib_req_ver, required: true,
                     method: 'pkg-config')
 glib_cflags = []
-if config_host.has_key('CONFIG_MODULES')
+if enable_modules
   gmodule = dependency('gmodule-export-2.0', version: glib_req_ver, required: true,
                        method: 'pkg-config')
 elif config_host.has_key('CONFIG_PLUGIN')
@@ -1725,7 +1730,7 @@ if get_option('cfi')
   if not get_option('b_lto')
     error('Selected Control-Flow Integrity but LTO is disabled')
   endif
-  if config_host.has_key('CONFIG_MODULES')
+  if enable_modules
     error('Selected Control-Flow Integrity is not compatible with modules')
   endif
   # Check for cfi flags. CFI requires LTO so we can't use
@@ -1823,7 +1828,7 @@ config_host_data.set_quoted('CONFIG_QEMU_LOCALSTATEDIR', get_option('prefix') /
 config_host_data.set_quoted('CONFIG_QEMU_MODDIR', get_option('prefix') / qemu_moddir)
 config_host_data.set_quoted('CONFIG_SYSCONFDIR', get_option('prefix') / get_option('sysconfdir'))
 
-if config_host.has_key('CONFIG_MODULES')
+if enable_modules
   config_host_data.set('CONFIG_STAMP', run_command(
       meson.current_source_dir() / 'scripts/qemu-stamp.py',
       meson.project_version(), get_option('pkgversion'), '--',
@@ -1886,6 +1891,7 @@ config_host_data.set('CONFIG_LIBSSH', libssh.found())
 config_host_data.set('CONFIG_LINUX_AIO', libaio.found())
 config_host_data.set('CONFIG_LINUX_IO_URING', linux_io_uring.found())
 config_host_data.set('CONFIG_LIBPMEM', libpmem.found())
+config_host_data.set('CONFIG_MODULES', enable_modules)
 config_host_data.set('CONFIG_NUMA', numa.found())
 if numa.found()
   config_host_data.set('HAVE_NUMA_HAS_PREFERRED_MANY',
@@ -3233,7 +3239,7 @@ foreach d, list : modules
   endif
 
   foreach m, module_ss : list
-    if enable_modules and targetos != 'windows'
+    if enable_modules
       module_ss = module_ss.apply(config_all, strict: false)
       sl = static_library(d + '-' + m, [genh, module_ss.sources()],
                           dependencies: [modulecommon, module_ss.dependencies()], pic: true)
@@ -3266,7 +3272,7 @@ endforeach
 
 foreach d, list : target_modules
   foreach m, module_ss : list
-    if enable_modules and targetos != 'windows'
+    if enable_modules
       foreach target : target_dirs
         if target.endswith('-softmmu')
           config_target = config_target_mak[target]
@@ -3786,8 +3792,8 @@ summary_info += {'system-mode emulation': have_system}
 summary_info += {'user-mode emulation': have_user}
 summary_info += {'block layer':       have_block}
 summary_info += {'Install blobs':     get_option('install_blobs')}
-summary_info += {'module support':    config_host.has_key('CONFIG_MODULES')}
-if config_host.has_key('CONFIG_MODULES')
+summary_info += {'module support':    enable_modules}
+if enable_modules
   summary_info += {'alternative module path': get_option('module_upgrades')}
 endif
 summary_info += {'fuzzing support':   get_option('fuzzing')}
diff --git a/meson_options.txt b/meson_options.txt
index a350520f6abf..a1240e0b2a59 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -42,6 +42,8 @@ option('fuzzing', type : 'boolean', value: false,
        description: 'build fuzzing targets')
 option('gettext', type : 'feature', value : 'auto',
        description: 'Localization of the GTK+ user interface')
+option('modules', type : 'feature', value : 'disabled',
+       description: 'modules support (non Windows)')
 option('module_upgrades', type : 'boolean', value : false,
        description: 'try to load modules from alternate paths for upgrades')
 option('install_blobs', type : 'boolean', value : true,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 10c4969a013e..43301864e395 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -127,6 +127,7 @@ meson_options_help() {
   printf "%s\n" '  lzo             lzo compression support'
   printf "%s\n" '  malloc-trim     enable libc malloc_trim() for memory optimization'
   printf "%s\n" '  membarrier      membarrier system call (for Linux 4.14+ or Windows'
+  printf "%s\n" '  modules         modules support (non Windows)'
   printf "%s\n" '  mpath           Multipath persistent reservation passthrough'
   printf "%s\n" '  multiprocess    Out of process device emulation support'
   printf "%s\n" '  netmap          netmap network backend support'
@@ -357,6 +358,8 @@ _meson_option_parse() {
     --disable-membarrier) printf "%s" -Dmembarrier=disabled ;;
     --enable-module-upgrades) printf "%s" -Dmodule_upgrades=true ;;
     --disable-module-upgrades) printf "%s" -Dmodule_upgrades=false ;;
+    --enable-modules) printf "%s" -Dmodules=enabled ;;
+    --disable-modules) printf "%s" -Dmodules=disabled ;;
     --enable-mpath) printf "%s" -Dmpath=enabled ;;
     --disable-mpath) printf "%s" -Dmpath=disabled ;;
     --enable-multiprocess) printf "%s" -Dmultiprocess=enabled ;;
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 48cd35b5b203..ab422772d310 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -23,7 +23,7 @@ qtests_generic = [
   'readconfig-test',
   'netdev-socket',
 ]
-if config_host.has_key('CONFIG_MODULES')
+if enable_modules
   qtests_generic += [ 'modules-test' ]
 endif
 
-- 
2.40.1


