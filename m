Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5747907FF
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 15:01:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcQEm-0001Nr-Qd; Sat, 02 Sep 2023 09:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQER-0001Df-1R
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qcQEN-0001lk-3x
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 09:00:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693659602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WOrwIy0yVkkVCMdsR7pcN1939wIUsA1rDIy2bZn4zKg=;
 b=XjJw7lyl11L8uK/FeqxXFatuzEif3vKiorybcsFDXGPlyuivJzFTe2h+ZNN1b/09edF/WD
 1OW0e9LrVceMMmNRaunCKjAuscJeCg0wy7olO5gqLlVURNCATDQTJmZu3RzG0nSkiZuqz5
 4jUMXtpMpCHZjEtfAfrYMhrVc7QGGwc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-BUvs0fN8OD2tFFx4hQ3Z9w-1; Sat, 02 Sep 2023 08:59:58 -0400
X-MC-Unique: BUvs0fN8OD2tFFx4hQ3Z9w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fefea09bd0so18161605e9.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693659597; x=1694264397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WOrwIy0yVkkVCMdsR7pcN1939wIUsA1rDIy2bZn4zKg=;
 b=cOV5KELAz1/4H8pkzm51oC9LvY4rPkqnMXRFWmR21ajOOtQxNVbF8LsFxseLzC+K8J
 V3tFNGHV9qZblJ7IG5/AUXT0TeD+uZ8sflk7UfvtCpb9NTcJ3/E/onNr9nXMVdVnL4Le
 UbW8XCkHNu+4g7Az1ZvCnSxfhmfzbTHSBUbHAHZ4K+ko4kW/02RCWOu6EI7e5hq+fT9i
 5G0oRCOP8JaHEqggxngOGOltX3eRX+AX3TZbK2j1A4SgJcTS51EZELKAcvia7fctzdAB
 ZhJ5UWcZ+lDyWrl3i8oz77RKPDvi4jxzQckaDb4Sz8N/zFkio2rGDIUFtAu3C2b8YAov
 9G+w==
X-Gm-Message-State: AOJu0YzM9u+b3ZyD3Bz+RZxIHn6yeNfex5WXAdIKY33uJYnJLUMZSuG6
 IwcnmqpW4tf93liOAEysgkhPRdRHVcJNuyAR6EjSrO0G6G+l95+UZY0CnLu4LSdUB5wwfgSnHyf
 y9izeUjG8zz9WkPkgsNwHJD/CygO2zpG3rVXls22RGBAc+HAevFZW5rU9YJoiVfR7chcfbaTsif
 4=
X-Received: by 2002:a5d:68d2:0:b0:319:841c:ae7a with SMTP id
 p18-20020a5d68d2000000b00319841cae7amr4089169wrw.41.1693659596946; 
 Sat, 02 Sep 2023 05:59:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIfKl6kw7XjonnU7JsG21Q5U1zFWyFD+lQJlwGbAn5C4tz+uZ1wmdeUsdg3qdeJmpymPCg2g==
X-Received: by 2002:a5d:68d2:0:b0:319:841c:ae7a with SMTP id
 p18-20020a5d68d2000000b00319841cae7amr4089159wrw.41.1693659596560; 
 Sat, 02 Sep 2023 05:59:56 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 d4-20020adfe884000000b0030ae53550f5sm8447134wrm.51.2023.09.02.05.59.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 05:59:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/15] configure, meson: move --enable-plugins to meson
Date: Sat,  2 Sep 2023 14:59:30 +0200
Message-ID: <20230902125934.113017-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230902125934.113017-1-pbonzini@redhat.com>
References: <20230902125934.113017-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

While the option still needs to be parsed in the configure script
(it's needed by tests/tcg, and also to decide about recursing
into contrib/plugins), passing it to Meson can be done with -D
instead of using config-host.mak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/meson.build         |  4 +++-
 configure                     |  5 +----
 meson.build                   |  7 ++++---
 meson_options.txt             |  2 ++
 plugins/meson.build           | 12 +++++++-----
 scripts/meson-buildoptions.sh |  3 +++
 tests/Makefile.include        |  2 +-
 tests/meson.build             |  6 ++----
 8 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 166bef173b8..8ace7837079 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -11,7 +11,9 @@ tcg_ss.add(files(
 ))
 tcg_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
 tcg_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
-tcg_ss.add(when: 'CONFIG_PLUGIN', if_true: [files('plugin-gen.c')])
+if get_option('plugins')
+  tcg_ss.add(files('plugin-gen.c'))
+endif
 tcg_ss.add(when: libdw, if_true: files('debuginfo.c'))
 tcg_ss.add(when: 'CONFIG_LINUX', if_true: files('perf.c'))
 specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_ss)
diff --git a/configure b/configure
index 9980eaeef57..017977f72b3 100755
--- a/configure
+++ b/configure
@@ -1712,10 +1712,6 @@ case $targetos in
     ;;
 esac
 
-if test "$plugins" = "yes" ; then
-    echo "CONFIG_PLUGIN=y" >> $config_host_mak
-fi
-
 if test -n "$gdb_bin"; then
     gdb_version=$($gdb_bin --version | head -n 1)
     if version_ge ${gdb_version##* } 9.1; then
@@ -1906,6 +1902,7 @@ if test "$skip_meson" = no; then
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
+  test "$plugins" = yes && meson_option_add "-Dplugins=true"
   test "$qemu_suffix" != qemu && meson_option_add "-Dqemu_suffix=$qemu_suffix"
   test "$smbd" != '' && meson_option_add "-Dsmbd=$smbd"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
diff --git a/meson.build b/meson.build
index baf47613650..9100e2a9794 100644
--- a/meson.build
+++ b/meson.build
@@ -730,7 +730,7 @@ glib_cflags = []
 if enable_modules
   gmodule = dependency('gmodule-export-2.0', version: glib_req_ver, required: true,
                        method: 'pkg-config')
-elif config_host.has_key('CONFIG_PLUGIN')
+elif get_option('plugins')
   gmodule = dependency('gmodule-no-export-2.0', version: glib_req_ver, required: true,
                        method: 'pkg-config')
 else
@@ -2115,6 +2115,7 @@ if numa.found()
                                        dependencies: numa))
 endif
 config_host_data.set('CONFIG_OPENGL', opengl.found())
+config_host_data.set('CONFIG_PLUGIN', get_option('plugins'))
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
 config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
@@ -3883,7 +3884,7 @@ endforeach
 
 # Other build targets
 
-if 'CONFIG_PLUGIN' in config_host
+if get_option('plugins')
   install_headers('include/qemu/qemu-plugin.h')
 endif
 
@@ -4156,7 +4157,7 @@ if config_all.has_key('CONFIG_TCG')
   else
     summary_info += {'TCG backend':   'native (@0@)'.format(cpu)}
   endif
-  summary_info += {'TCG plugins': config_host.has_key('CONFIG_PLUGIN')}
+  summary_info += {'TCG plugins':       get_option('plugins')}
   summary_info += {'TCG debug enabled': get_option('debug_tcg')}
 endif
 summary_info += {'target list':       ' '.join(target_dirs)}
diff --git a/meson_options.txt b/meson_options.txt
index 5d6b889554c..e48086e2562 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -83,6 +83,8 @@ option('xen_pci_passthrough', type: 'feature', value: 'auto',
        description: 'Xen PCI passthrough support')
 option('tcg', type: 'feature', value: 'enabled',
        description: 'TCG support')
+option('plugins', type: 'boolean', value: false,
+       description: 'TCG plugins via shared library loading')
 option('debug_tcg', type: 'boolean', value: false,
        description: 'TCG debugging')
 option('tcg_interpreter', type: 'boolean', value: false,
diff --git a/plugins/meson.build b/plugins/meson.build
index 752377c66d3..71ed996ed31 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -13,8 +13,10 @@ if not enable_modules
   endif
 endif
 
-specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
-  'loader.c',
-  'core.c',
-  'api.c',
-), declare_dependency(link_args: plugin_ldflags)])
+if get_option('plugins')
+  specific_ss.add(files(
+    'loader.c',
+    'core.c',
+    'api.c',
+  ), declare_dependency(link_args: plugin_ldflags))
+endif
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 5567fd29985..6b16ad94f4b 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -40,6 +40,7 @@ meson_options_help() {
   printf "%s\n" '                           jemalloc/system/tcmalloc)'
   printf "%s\n" '  --enable-module-upgrades try to load modules from alternate paths for'
   printf "%s\n" '                           upgrades'
+  printf "%s\n" '  --enable-plugins         TCG plugins via shared library loading'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
   printf "%s\n" '                           getrandom()'
   printf "%s\n" '  --enable-safe-stack      SafeStack Stack Smash Protection (requires'
@@ -401,6 +402,8 @@ _meson_option_parse() {
     --enable-pipewire) printf "%s" -Dpipewire=enabled ;;
     --disable-pipewire) printf "%s" -Dpipewire=disabled ;;
     --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
+    --enable-plugins) printf "%s" -Dplugins=true ;;
+    --disable-plugins) printf "%s" -Dplugins=false ;;
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
     --enable-pvrdma) printf "%s" -Dpvrdma=enabled ;;
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 985cda7a945..38987426594 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -73,7 +73,7 @@ $(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%): distclean-tcg-tests-%:
 build-tcg: $(BUILD_TCG_TARGET_RULES)
 
 .PHONY: check-tcg
-.ninja-goals.check-tcg = all $(if $(CONFIG_PLUGIN),test-plugins)
+.ninja-goals.check-tcg = all
 check-tcg: $(RUN_TCG_TARGET_RULES)
 
 .PHONY: clean-tcg
diff --git a/tests/meson.build b/tests/meson.build
index 083f2990bde..c2528a88f99 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -80,10 +80,8 @@ if 'CONFIG_TCG' in config_all
   subdir('fp')
 endif
 
-if get_option('tcg').allowed()
-  if 'CONFIG_PLUGIN' in config_host
-    subdir('plugin')
-  endif
+if get_option('plugins')
+  subdir('plugin')
 endif
 
 subdir('unit')
-- 
2.41.0


