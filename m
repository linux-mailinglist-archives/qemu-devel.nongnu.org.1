Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9DB707027
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH6-0005My-HU; Wed, 17 May 2023 13:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEr-0001x4-1f
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEn-0004S2-H9
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9n4Ed9dRUkK2DxQPd4mYkI+hgP4LpPaX90+8tZBLRiY=;
 b=Fo/aQLFTw8i65CoT4/ltxuLl5bKYvHxecZHJMcPy/C5P4T3EAec3Uic7N8EovfO5u703Ly
 xjEDwwSpWqaSB2BIvsEOhofCYmmtF8ZT2p96wFQht5GyGrsAVhvaOjN5XyWlxrXFc/j1Yc
 f0CkCBGFKk0PYCrdDQotRLfsC9i+DlM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-gdmVVqa0OXqcWHI59Q0gFA-1; Wed, 17 May 2023 13:46:55 -0400
X-MC-Unique: gdmVVqa0OXqcWHI59Q0gFA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f423d47945so4494465e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345613; x=1686937613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9n4Ed9dRUkK2DxQPd4mYkI+hgP4LpPaX90+8tZBLRiY=;
 b=DGs8BYsf4lEfwE6k9Zfef6w/eo8q1877IiAzx07ylHe0H5+C0wyLiMGnSsKeFQqf73
 UjMb75T7yJwwkTajyHrPE9yMEInrSMSNRp2t/cZ8LRhhqz0WS5y6IOYlkDZQe7RVW54r
 P4onKqJvFcaUk80TPedb+DzC3edyN1ya763sdPzBZuXCRnOSA7M2a89GIk/eXrypwFUG
 PS1uSoDAyks5QbGJy21kocr2CGTbWfcCOUhOAMiIFjdUKv2gLnLlG1MM1UhIA1t0B2Z4
 J8ZjrgNh6IduQvWoT3rFSWWaWRA1ad3UoiQrO5PTMWvZBT0OD/L603J82IA1grSMcQ8G
 6YhQ==
X-Gm-Message-State: AC+VfDyvgarzfxD6Vzv8qYurSBM0/8Y3A9DmBxdM8iwxD/K/YowERE05
 p7eldi6DMYIVGlWCLoZQGKqKKH0oe/dFOHHFR5IYlO6WRJIx4oCTKDm1PfuuVZHaCv3B2GmdEVm
 JztMYhyQyuKZp/p7596u7GZHDjqxY4RW0MwKPkHSjj7SPI503aS3tDStJWvqIafbJcOykdETFfK
 Y=
X-Received: by 2002:a05:600c:b4d:b0:3f4:253b:92a7 with SMTP id
 k13-20020a05600c0b4d00b003f4253b92a7mr23666818wmr.30.1684345613505; 
 Wed, 17 May 2023 10:46:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xiuBVvoajB1NDMqWYWcUVQuArM+vFtDo2g61w9ZKZspn1burIDeAyJfCLLQwks6jFrrHZGQ==
X-Received: by 2002:a05:600c:b4d:b0:3f4:253b:92a7 with SMTP id
 k13-20020a05600c0b4d00b003f4253b92a7mr23666794wmr.30.1684345612862; 
 Wed, 17 May 2023 10:46:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d4e82000000b00309257ad16csm3383628wru.29.2023.05.17.10.46.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 55/68] build: move sanitizer tests to meson
Date: Wed, 17 May 2023 19:45:07 +0200
Message-Id: <20230517174520.887405-56-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                      | 147 ---------------------------------
 docs/devel/build-system.rst    |   4 -
 meson.build                    |  56 ++++++++++++-
 meson_options.txt              |   4 +
 scripts/meson-buildoptions.sh  |   6 ++
 tests/qemu-iotests/meson.build |   2 +-
 tests/unit/meson.build         |   2 +-
 7 files changed, 66 insertions(+), 155 deletions(-)

diff --git a/configure b/configure
index 5edd3765cd4e..34b26c45cf39 100755
--- a/configure
+++ b/configure
@@ -275,9 +275,6 @@ EXTRA_OBJCFLAGS=""
 EXTRA_LDFLAGS=""
 
 debug_tcg="no"
-sanitizers="no"
-tsan="no"
-fortify_source="yes"
 docs="auto"
 EXESUF=""
 prefix="/usr/local"
@@ -416,14 +413,6 @@ EOF
   compile_object
 }
 
-check_include() {
-cat > $TMPC <<EOF
-#include <$1>
-int main(void) { return 0; }
-EOF
-  compile_object
-}
-
 write_c_skeleton() {
     cat > $TMPC <<EOF
 int main(void) { return 0; }
@@ -806,15 +795,6 @@ for opt do
       meson_option_parse --enable-debug-graph-lock ""
       meson_option_parse --enable-debug-mutex ""
       meson_option_add -Doptimization=0
-      fortify_source="no"
-  ;;
-  --enable-sanitizers) sanitizers="yes"
-  ;;
-  --disable-sanitizers) sanitizers="no"
-  ;;
-  --enable-tsan) tsan="yes"
-  ;;
-  --disable-tsan) tsan="no"
   ;;
   --disable-tcg) tcg="disabled"
                  plugins="no"
@@ -1025,8 +1005,6 @@ Advanced options (experts only):
                            desired devices in configs/devices/)
   --with-devices-ARCH=NAME override default configs/devices
   --enable-debug           enable common debug build options
-  --enable-sanitizers      enable default sanitizers
-  --enable-tsan            enable thread sanitizer
   --disable-werror         disable compilation abort on warning
   --disable-stack-protector disable compiler-provided stack protection
   --cpu=CPU                Build for host CPU [$cpu]
@@ -1633,87 +1611,6 @@ if ! compile_object "-Werror"; then
     ccache_cpp2=yes
 fi
 
-#################################################
-# clang does not support glibc + FORTIFY_SOURCE.
-
-if test "$fortify_source" != "no"; then
-  if echo | $cc -dM -E - | grep __clang__ > /dev/null 2>&1 ; then
-    fortify_source="no";
-  elif test -n "$cxx" && has $cxx &&
-       echo | $cxx -dM -E - | grep __clang__ >/dev/null 2>&1 ; then
-    fortify_source="no";
-  else
-    fortify_source="yes"
-  fi
-fi
-
-##########################################
-# checks for sanitizers
-
-have_asan=no
-have_ubsan=no
-have_asan_iface_h=no
-have_asan_iface_fiber=no
-
-if test "$sanitizers" = "yes" ; then
-  write_c_skeleton
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address" ""; then
-      have_asan=yes
-  fi
-
-  # we could use a simple skeleton for flags checks, but this also
-  # detect the static linking issue of ubsan, see also:
-  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
-  cat > $TMPC << EOF
-int main(int argc, char **argv)
-{
-    return argc + 1;
-}
-EOF
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=undefined" ""; then
-      have_ubsan=yes
-  fi
-
-  if check_include "sanitizer/asan_interface.h" ; then
-      have_asan_iface_h=yes
-  fi
-
-  cat > $TMPC << EOF
-#include <sanitizer/asan_interface.h>
-int main(void) {
-  __sanitizer_start_switch_fiber(0, 0, 0);
-  return 0;
-}
-EOF
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=address" "" ; then
-      have_asan_iface_fiber=yes
-  fi
-fi
-
-# Thread sanitizer is, for now, much noisier than the other sanitizers;
-# keep it separate until that is not the case.
-if test "$tsan" = "yes" && test "$sanitizers" = "yes"; then
-  error_exit "TSAN is not supported with other sanitiziers."
-fi
-have_tsan=no
-have_tsan_iface_fiber=no
-if test "$tsan" = "yes" ; then
-  write_c_skeleton
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
-      have_tsan=yes
-  fi
-  cat > $TMPC << EOF
-#include <sanitizer/tsan_interface.h>
-int main(void) {
-  __tsan_create_fiber(0);
-  return 0;
-}
-EOF
-  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=thread" "" ; then
-      have_tsan_iface_fiber=yes
-  fi
-fi
-
 ##########################################
 # functions to probe cross compilers
 
@@ -2139,42 +2036,6 @@ case "$vfio_user_server" in
     ;;
 esac
 
-##########################################
-# End of CC checks
-# After here, no more $cc or $ld runs
-
-write_c_skeleton
-
-if test "$fortify_source" = "yes" ; then
-  QEMU_CFLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 $QEMU_CFLAGS"
-fi
-
-if test "$have_asan" = "yes"; then
-  QEMU_CFLAGS="-fsanitize=address $QEMU_CFLAGS"
-  QEMU_LDFLAGS="-fsanitize=address $QEMU_LDFLAGS"
-  if test "$have_asan_iface_h" = "no" ; then
-      echo "ASAN build enabled, but ASAN header missing." \
-           "Without code annotation, the report may be inferior."
-  elif test "$have_asan_iface_fiber" = "no" ; then
-      echo "ASAN build enabled, but ASAN header is too old." \
-           "Without code annotation, the report may be inferior."
-  fi
-fi
-if test "$have_tsan" = "yes" ; then
-  if test "$have_tsan_iface_fiber" = "yes" ; then
-    QEMU_CFLAGS="-fsanitize=thread $QEMU_CFLAGS"
-    QEMU_LDFLAGS="-fsanitize=thread $QEMU_LDFLAGS"
-  else
-    error_exit "Cannot enable TSAN due to missing fiber annotation interface."
-  fi
-elif test "$tsan" = "yes" ; then
-  error_exit "Cannot enable TSAN due to missing sanitize thread interface."
-fi
-if test "$have_ubsan" = "yes"; then
-  QEMU_CFLAGS="-fsanitize=undefined $QEMU_CFLAGS"
-  QEMU_LDFLAGS="-fsanitize=undefined $QEMU_LDFLAGS"
-fi
-
 #######################################
 # cross-compiled firmware targets
 
@@ -2299,14 +2160,6 @@ fi
 
 echo "CONFIG_COROUTINE_BACKEND=$coroutine" >> $config_host_mak
 
-if test "$have_asan_iface_fiber" = "yes" ; then
-    echo "CONFIG_ASAN_IFACE_FIBER=y" >> $config_host_mak
-fi
-
-if test "$have_tsan" = "yes" && test "$have_tsan_iface_fiber" = "yes" ; then
-    echo "CONFIG_TSAN=y" >> $config_host_mak
-fi
-
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
 fi
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 66cfe7b8bdc8..4a733fc0a747 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -91,10 +91,6 @@ developers in checking for system features:
 ``check_define $NAME``
    Determine if the macro $NAME is defined by the system C compiler
 
-``check_include $NAME``
-   Determine if the include $NAME file is available to the system C
-   compiler.  The replacement in Meson is ``cc.has_header()``.
-
 ``write_c_skeleton``
    Write a minimal C program main() function to the temporary file
    indicated by $TMPC
diff --git a/meson.build b/meson.build
index f162ed4e335f..b4d2a53b6c36 100644
--- a/meson.build
+++ b/meson.build
@@ -211,6 +211,35 @@ if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
 
+if get_option('sanitizers')
+  if cc.has_argument('-fsanitize=address')
+    qemu_cflags = ['-fsanitize=address'] + qemu_cflags
+    qemu_ldflags = ['-fsanitize=address'] + qemu_ldflags
+  endif
+
+  # Detect static linking issue with ubsan - https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84285
+  if cc.links('int main(int argc, char **argv) { return argc + 1; }',
+              args: [qemu_ldflags, '-fsanitize=undefined'])
+    qemu_cflags = ['-fsanitize=undefined'] + qemu_cflags
+    qemu_ldflags = ['-fsanitize=undefined'] + qemu_ldflags
+  endif
+endif
+
+# Thread sanitizer is, for now, much noisier than the other sanitizers;
+# keep it separate until that is not the case.
+if get_option('tsan')
+  if get_option('sanitizers')
+    error('TSAN is not supported with other sanitizers')
+  endif
+  if not cc.has_function('__tsan_create_fiber',
+                         args: '-fsanitize=thread',
+                         prefix: '#include <sanitizer/tsan_interface.h>')
+    error('Cannot enable TSAN due to missing fiber annotation interface')
+  endif
+  qemu_cflags = ['-fsanitize=thread'] + qemu_cflags
+  qemu_ldflags = ['-fsanitize=thread'] + qemu_ldflags
+endif
+
 # Detect support for PT_GNU_RELRO + DT_BIND_NOW.
 # The combination is known as "full relro", because .got.plt is read-only too.
 qemu_ldflags += cc.get_supported_link_arguments('-Wl,-z,relro', '-Wl,-z,now')
@@ -221,7 +250,7 @@ if targetos == 'windows'
 endif
 
 # Exclude --warn-common with TSan to suppress warnings from the TSan libraries.
-if targetos != 'sunos' and not config_host.has_key('CONFIG_TSAN')
+if targetos != 'sunos' and not get_option('tsan')
   qemu_ldflags += cc.get_supported_link_arguments('-Wl,--warn-common')
 endif
 
@@ -284,6 +313,16 @@ if 'cpp' in all_languages
   endif
 endif
 
+# clang does not support glibc + FORTIFY_SOURCE (is it still true?)
+if get_option('optimization') != '0' and targetos == 'linux'
+  if cc.get_id() == 'gcc'
+    qemu_cflags += ['-U_FORTIFY_SOURCE', '-D_FORTIFY_SOURCE=2']
+  endif
+  if 'cpp' in all_languages and cxx.get_id() == 'gcc'
+    qemu_cxxflags += ['-U_FORTIFY_SOURCE', '-D_FORTIFY_SOURCE=2']
+  endif
+endif
+
 add_project_arguments(qemu_cflags, native: false, language: 'c')
 add_project_arguments(qemu_cxxflags, native: false, language: 'cpp')
 add_project_arguments(qemu_objcflags, native: false, language: 'objc')
@@ -1915,6 +1954,7 @@ if seccomp.found()
 endif
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_TPM', have_tpm)
+config_host_data.set('CONFIG_TSAN', get_option('tsan'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
 config_host_data.set('CONFIG_VDE', vde.found())
 config_host_data.set('CONFIG_VHOST_NET', have_vhost_net)
@@ -2046,6 +2086,18 @@ if rdma.found()
                                        prefix: '#include <infiniband/verbs.h>'))
 endif
 
+have_asan_fiber = false
+if get_option('sanitizers') and \
+   not cc.has_function('__sanitizer_start_switch_fiber',
+                         args: '-fsanitize=address',
+                         prefix: '#include <sanitizer/asan_interface.h>')
+  warning('Missing ASAN due to missing fiber annotation interface')
+  warning('Without code annotation, the report may be inferior.')
+else
+  have_asan_fiber = true
+endif
+config_host_data.set('CONFIG_ASAN_IFACE_FIBER', have_asan_fiber)
+
 # has_header_symbol
 config_host_data.set('CONFIG_BLKZONED',
                      cc.has_header_symbol('linux/blkzoned.h', 'BLKOPENZONE'))
@@ -3877,7 +3929,7 @@ else
 endif
 summary_info += {'gprof':             gprof_info}
 summary_info += {'gcov':              get_option('b_coverage')}
-summary_info += {'thread sanitizer':  config_host.has_key('CONFIG_TSAN')}
+summary_info += {'thread sanitizer':  get_option('tsan')}
 summary_info += {'CFI support':       get_option('cfi')}
 if get_option('cfi')
   summary_info += {'CFI debug support': get_option('cfi_debug')}
diff --git a/meson_options.txt b/meson_options.txt
index a1240e0b2a59..a15d434267f9 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -82,6 +82,10 @@ option('tcg', type: 'feature', value: 'enabled',
        description: 'TCG support')
 option('tcg_interpreter', type: 'boolean', value: false,
        description: 'TCG with bytecode interpreter (slow)')
+option('sanitizers', type: 'boolean', value: false,
+       description: 'enable default sanitizers')
+option('tsan', type: 'boolean', value: false,
+       description: 'enable thread sanitizer')
 option('cfi', type: 'boolean', value: false,
        description: 'Control-Flow Integrity (CFI)')
 option('cfi_debug', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 43301864e395..b79a14b6948c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -41,11 +41,13 @@ meson_options_help() {
   printf "%s\n" '  --enable-profiler        profiler support'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
   printf "%s\n" '                           getrandom()'
+  printf "%s\n" '  --enable-sanitizers      enable default sanitizers'
   printf "%s\n" '  --enable-strip           Strip targets on install'
   printf "%s\n" '  --enable-tcg-interpreter TCG with bytecode interpreter (slow)'
   printf "%s\n" '  --enable-trace-backends=CHOICES'
   printf "%s\n" '                           Set available tracing backends [log] (choices:'
   printf "%s\n" '                           dtrace/ftrace/log/nop/simple/syslog/ust)'
+  printf "%s\n" '  --enable-tsan            enable thread sanitizer'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
   printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
@@ -406,6 +408,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-sanitizers) printf "%s" -Dsanitizers=true ;;
+    --disable-sanitizers) printf "%s" -Dsanitizers=false ;;
     --enable-sdl) printf "%s" -Dsdl=enabled ;;
     --disable-sdl) printf "%s" -Dsdl=disabled ;;
     --enable-sdl-image) printf "%s" -Dsdl_image=enabled ;;
@@ -444,6 +448,8 @@ _meson_option_parse() {
     --disable-tpm) printf "%s" -Dtpm=disabled ;;
     --enable-trace-backends=*) quote_sh "-Dtrace_backends=$2" ;;
     --with-trace-file=*) quote_sh "-Dtrace_file=$2" ;;
+    --enable-tsan) printf "%s" -Dtsan=true ;;
+    --disable-tsan) printf "%s" -Dtsan=false ;;
     --enable-u2f) printf "%s" -Du2f=enabled ;;
     --disable-u2f) printf "%s" -Du2f=disabled ;;
     --enable-usb-redir) printf "%s" -Dusb_redir=enabled ;;
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 9735071a295b..44761e1e4d3e 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -2,7 +2,7 @@ if not have_tools or targetos == 'windows' or get_option('gprof')
   subdir_done()
 endif
 
-foreach cflag: config_host['QEMU_CFLAGS'].split()
+foreach cflag: qemu_ldflags
   if cflag.startswith('-fsanitize') and \
      not cflag.contains('safe-stack') and not cflag.contains('cfi-icall')
     message('Sanitizers are enabled ==> Disabled the qemu-iotests.')
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 3bc78d8660a4..48ae66011b17 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -147,7 +147,7 @@ if have_system
   # Some tests: test-char, test-qdev-global-props, and test-qga,
   # are not runnable under TSan due to a known issue.
   # https://github.com/google/sanitizers/issues/1116
-  if 'CONFIG_TSAN' not in config_host
+  if not get_option('tsan')
     if 'CONFIG_POSIX' in config_host
         tests += {
           'test-char': ['socket-helpers.c', qom, io, chardev]
-- 
2.40.1


