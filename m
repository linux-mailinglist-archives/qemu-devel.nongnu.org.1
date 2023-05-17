Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A274707044
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFx-0003Fy-Nv; Wed, 17 May 2023 13:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEs-0001xF-R7
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEq-0004UA-QO
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0G45ZYVI2xWZEBapYoD8PtloM4cggEZlrWBmcULTD2Q=;
 b=bIWHmLZjYZLNY8ur6b+dDtD5ruGMM7RSvk3cM0GQTM8eWm/7/HPcZ65Lt1VH45Ub+X6Tal
 iFfofJCC2xcW5Jj5QXCWvTIhpDFAv/KtKpempBeq/59e4aeG91tEMD+hEDdn+u83eFEeGu
 QHm31fvSWgr0+WroRRNNzr6t7Au2qds=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-oq0pulJdPnOj9xnBV8mHAQ-1; Wed, 17 May 2023 13:46:58 -0400
X-MC-Unique: oq0pulJdPnOj9xnBV8mHAQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42b36733aso4441145e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345616; x=1686937616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0G45ZYVI2xWZEBapYoD8PtloM4cggEZlrWBmcULTD2Q=;
 b=jnrOTP4Yr08qBUmVgOuA+LykWgeeJRy+11A08/bLLrGlXw1L/OxWdORq8pq5BrdU6g
 G53vyzrkZTX4eI5KRc9J02De/SWvoxT/oFEkQLeD0vCz4hQMHsKYoQl2KNPfB6ozmov7
 AdzoYeJFVQakGXlNZDHdES3IXZTNE/WMJMDYwVgeYUSwfBpxQYsCfafpndEmabP1XlDp
 Ixa1K5WGBhKg5gToURPzONvHWOwfrPAECzt5idSyOho1NKt38aOMKg+TEuw9dJUgnIIR
 /3gOLJ+Er/HmYh9LaU6EWs+8+vl/iyeyELCgTBm8KtWuBHbSHlf6DrRHQl1WgyPXfAl8
 K+Mg==
X-Gm-Message-State: AC+VfDxF1daGoy8fLiFo+2fo0slHZ2CFdDcLCfe3Qqe1aeQBqM+bNqvB
 +eOV74DlXfo/i3wtjDfht0jM1y9Y4u4hN39tnKGl290srAQLQCTc5PL8xJPx/Cz0k+lq4/vqB2h
 RYH8TXMItSpZb6UpFdRBpKbQQN+Psf+eXJViY8+ryAHdEiVq24eET2PUYUDdd2KeSClv4UE8fIy
 w=
X-Received: by 2002:a7b:c4c3:0:b0:3f1:8085:910e with SMTP id
 g3-20020a7bc4c3000000b003f18085910emr29122415wmk.9.1684345616220; 
 Wed, 17 May 2023 10:46:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4i5WLusndBoffSHjsNVt4CkV2NGDdsyjKILJ+F2MQ5+DzRt6VjBLxCJUapkRGz3JrEhpb9ng==
X-Received: by 2002:a7b:c4c3:0:b0:3f1:8085:910e with SMTP id
 g3-20020a7bc4c3000000b003f18085910emr29122404wmk.9.1684345615890; 
 Wed, 17 May 2023 10:46:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 r4-20020a056000014400b002f103ca90cdsm3384327wrx.101.2023.05.17.10.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 57/68] build: move coroutine backend selection to meson
Date: Wed, 17 May 2023 19:45:09 +0200
Message-Id: <20230517174520.887405-58-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

To simplify the code, rename coroutine-win32.c to match the option
passed to configure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                     | 62 -------------------
 meson.build                                   | 32 +++++++++-
 meson_options.txt                             |  3 +
 scripts/meson-buildoptions.py                 |  1 +
 scripts/meson-buildoptions.sh                 |  3 +
 ...{coroutine-win32.c => coroutine-windows.c} |  0
 util/meson.build                              |  2 +-
 7 files changed, 38 insertions(+), 65 deletions(-)
 rename util/{coroutine-win32.c => coroutine-windows.c} (100%)

diff --git a/configure b/configure
index 1cde6f698161..470ed9f8c201 100755
--- a/configure
+++ b/configure
@@ -282,7 +282,6 @@ softmmu="yes"
 linux_user=""
 bsd_user=""
 pie=""
-coroutine=""
 plugins="$default_feature"
 ninja=""
 bindir="bin"
@@ -843,8 +842,6 @@ for opt do
   ;;
   --enable-fdt=*) fdt="$optarg"
   ;;
-  --with-coroutine=*) coroutine="$optarg"
-  ;;
   --with-git=*) git="$optarg"
   ;;
   --with-git-submodules=*)
@@ -1003,8 +1000,6 @@ Advanced options (experts only):
   --disable-werror         disable compilation abort on warning
   --disable-stack-protector disable compiler-provided stack protection
   --cpu=CPU                Build for host CPU [$cpu]
-  --with-coroutine=BACKEND coroutine backend. Supported options:
-                           ucontext, sigaltstack, windows
   --enable-plugins
                            enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
@@ -1459,61 +1454,6 @@ case "$fdt" in
     ;;
 esac
 
-##########################################
-# check and set a backend for coroutine
-
-# We prefer ucontext, but it's not always possible. The fallback
-# is sigcontext. On Windows the only valid backend is the Windows
-# specific one.
-
-ucontext_works=no
-if test "$darwin" != "yes"; then
-  cat > $TMPC << EOF
-#include <ucontext.h>
-#ifdef __stub_makecontext
-#error Ignoring glibc stub makecontext which will always fail
-#endif
-int main(void) { makecontext(0, 0, 0); return 0; }
-EOF
-  if compile_prog "" "" ; then
-    ucontext_works=yes
-  fi
-fi
-
-if test "$coroutine" = ""; then
-  if test "$mingw32" = "yes"; then
-    coroutine=win32
-  elif test "$ucontext_works" = "yes"; then
-    coroutine=ucontext
-  else
-    coroutine=sigaltstack
-  fi
-else
-  case $coroutine in
-  windows)
-    if test "$mingw32" != "yes"; then
-      error_exit "'windows' coroutine backend only valid for Windows"
-    fi
-    # Unfortunately the user visible backend name doesn't match the
-    # coroutine-*.c filename for this case, so we have to adjust it here.
-    coroutine=win32
-    ;;
-  ucontext)
-    if test "$ucontext_works" != "yes"; then
-      error_exit "'ucontext' backend requested but makecontext not available"
-    fi
-    ;;
-  sigaltstack)
-    if test "$mingw32" = "yes"; then
-      error_exit "only the 'windows' coroutine backend is valid for Windows"
-    fi
-    ;;
-  *)
-    error_exit "unknown coroutine backend $coroutine"
-    ;;
-  esac
-fi
-
 ########################################
 # check if ccache is interfering with
 # semantic analysis of macros
@@ -2089,8 +2029,6 @@ if [ "$bsd" = "yes" ] ; then
   echo "CONFIG_BSD=y" >> $config_host_mak
 fi
 
-echo "CONFIG_COROUTINE_BACKEND=$coroutine" >> $config_host_mak
-
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
 fi
diff --git a/meson.build b/meson.build
index b83b3c937d8f..f410afe8b044 100644
--- a/meson.build
+++ b/meson.build
@@ -211,6 +211,34 @@ if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
 
+coroutine_backend = get_option('coroutine_backend')
+ucontext_probe = '''
+  #include <ucontext.h>
+  #ifdef __stub_makecontext
+  #error Ignoring glibc stub makecontext which will always fail
+  #endif
+  int main(void) { makecontext(0, 0, 0); return 0; }'''
+
+# On Windows the only valid backend is the Windows specific one.
+# For POSIX prefer ucontext, but it's not always possible. The fallback
+# is sigcontext.
+supported_backends = []
+if targetos == 'windows'
+  supported_backends += ['windows']
+else
+  if targetos != 'darwin' and cc.links(ucontext_probe)
+    supported_backends += ['ucontext']
+  endif
+  supported_backends += ['sigaltstack']
+endif
+
+if coroutine_backend == 'auto'
+  coroutine_backend = supported_backends[0]
+elif coroutine_backend not in supported_backends
+  error('"@0@" backend requested but not available.  Available backends: @1@' \
+        .format(coroutine_backend, ', '.join(supported_backends)))
+endif
+
 # Compiles if SafeStack *not* enabled
 safe_stack_probe = '''
   int main(void)
@@ -232,7 +260,7 @@ if get_option('safe_stack') != not cc.compiles(safe_stack_probe)
   qemu_cflags += safe_stack_arg
   qemu_ldflags += safe_stack_arg
 endif
-if get_option('safe_stack') and config_host['CONFIG_COROUTINE_BACKEND'] != 'ucontext'
+if get_option('safe_stack') and coroutine_backend != 'ucontext'
   error('SafeStack is only supported with the ucontext coroutine backend')
 endif
 
@@ -4016,7 +4044,7 @@ summary(summary_info, bool_yn: true, section: 'Targets and accelerators')
 
 # Block layer
 summary_info = {}
-summary_info += {'coroutine backend': config_host['CONFIG_COROUTINE_BACKEND']}
+summary_info += {'coroutine backend': coroutine_backend}
 summary_info += {'coroutine pool':    have_coroutine_pool}
 if have_block
   summary_info += {'Block whitelist (rw)': get_option('block_drv_rw_whitelist')}
diff --git a/meson_options.txt b/meson_options.txt
index 89bc06b561e6..69de30c83db0 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -31,6 +31,9 @@ option('fuzzing_engine', type : 'string', value : '',
        description: 'fuzzing engine library for OSS-Fuzz')
 option('trace_file', type: 'string', value: 'trace',
        description: 'Trace file prefix for simple backend')
+option('coroutine_backend', type: 'combo',
+       choices: ['ucontext', 'sigaltstack', 'windows', 'auto'],
+       value: 'auto', description: 'coroutine backend to use')
 
 # Everything else can be set via --enable/--disable-* option
 # on the configure script command line.  After adding an option
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index a04dcc70a5b7..4c7f13fdfc40 100755
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -35,6 +35,7 @@
 OPTION_NAMES = {
     "b_coverage": "gcov",
     "b_lto": "lto",
+    "coroutine_backend": "with-coroutine",
     "malloc": "enable-malloc",
     "pkgversion": "with-pkgversion",
     "qemu_firmwarepath": "firmwarepath",
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 35dbfff2387a..032fcea948d4 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -64,6 +64,8 @@ meson_options_help() {
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
+  printf "%s\n" '  --with-coroutine=CHOICE  coroutine backend to use (choices:'
+  printf "%s\n" '                           auto/sigaltstack/ucontext/windows)'
   printf "%s\n" '  --with-pkgversion=VALUE  use specified string as sub-version of the'
   printf "%s\n" '                           package'
   printf "%s\n" '  --with-trace-file=VALUE  Trace file prefix for simple backend [trace]'
@@ -248,6 +250,7 @@ _meson_option_parse() {
     --disable-cocoa) printf "%s" -Dcocoa=disabled ;;
     --enable-coreaudio) printf "%s" -Dcoreaudio=enabled ;;
     --disable-coreaudio) printf "%s" -Dcoreaudio=disabled ;;
+    --with-coroutine=*) quote_sh "-Dcoroutine_backend=$2" ;;
     --enable-coroutine-pool) printf "%s" -Dcoroutine_pool=true ;;
     --disable-coroutine-pool) printf "%s" -Dcoroutine_pool=false ;;
     --enable-crypto-afalg) printf "%s" -Dcrypto_afalg=enabled ;;
diff --git a/util/coroutine-win32.c b/util/coroutine-windows.c
similarity index 100%
rename from util/coroutine-win32.c
rename to util/coroutine-windows.c
diff --git a/util/meson.build b/util/meson.build
index 2cb103fc727e..e1f1c39e1081 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -78,7 +78,7 @@ if have_block or have_ga
   util_ss.add(files('base64.c'))
   util_ss.add(files('main-loop.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
-  util_ss.add(files('coroutine-@0@.c'.format(config_host['CONFIG_COROUTINE_BACKEND'])))
+  util_ss.add(files(f'coroutine-@coroutine_backend@.c'))
   util_ss.add(files('thread-pool.c', 'qemu-timer.c'))
   util_ss.add(files('qemu-sockets.c'))
 endif
-- 
2.40.1


