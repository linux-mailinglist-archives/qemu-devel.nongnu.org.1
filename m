Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC89707021
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLFj-0002st-Vo; Wed, 17 May 2023 13:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEq-0001x3-S7
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEn-0004SF-UP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vWsBITqXH0Hf/HJAkrmR2QoEA1Mw0DfApnEDWhv8x/I=;
 b=emB90You2k2oLfMzr48EOHthbHuxedZ13YRNkWBPqODt3jlrhWQLPkxBnosE7uxh075eik
 YALPZQ6SG5BM1G8YiG4JGtI/dfx+uaPj5wXEvXdS2FXse40FlFfmeGEsbsr6w4ltBRNXUB
 g/qza3xQWjxkMmYwxicf7CtQHyTsdOk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-39GbaHIPM1uqaFnmiEgVdQ-1; Wed, 17 May 2023 13:46:56 -0400
X-MC-Unique: 39GbaHIPM1uqaFnmiEgVdQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30479b764f9so451648f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345614; x=1686937614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vWsBITqXH0Hf/HJAkrmR2QoEA1Mw0DfApnEDWhv8x/I=;
 b=AoScm6U+rD45OMx5Q68NZmm6kQT8UcJU6VukRmEla0XHfamEaswlKTW6O3kl8heCRY
 7SfTUyq6Dd8XoyXMlNZFV4ljJAR39DnIAnDAKci3owlqEPOD6IS4UDTjaOa6928esnmr
 XcqQseffecUOoFn2Soe5axyoGWZ+SRPo0M1XkkvUeSCBWaW+Np37uQd5BW6J7boTyqHo
 3YB6kO0N7WAd6jfdrOKtZPO57YGgjJMBw8eTv5aeR0GgEYIrpsZ4mIWOFBVkZaL3jNOS
 a9k/NetKQSwE5+f/3WM2s0PkGJv7DBw8dByVYE6RSmjTubKb/KC1U0+VqSnbz3ucQu1g
 N1IA==
X-Gm-Message-State: AC+VfDwToA8G0STha85I4iYh8WggUlOTGNzeivicNTODcetrtk874GCO
 BKPx33xZgwmYK5eU/jEGx6dQhsfD+UHOUzrJQGg+0BtVNdR+vqM4MShvkhgFmHzE0of+mnXNj1V
 hU3B0g3z6rVuF6/3CoI9v9+RS38a8z9xlCnEIDMA9mydVE9+ac6MP6RUHs5XtnIXq5SiA82O45O
 U=
X-Received: by 2002:a5d:65c5:0:b0:306:35fa:202b with SMTP id
 e5-20020a5d65c5000000b0030635fa202bmr1223286wrw.6.1684345614366; 
 Wed, 17 May 2023 10:46:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ61F4NqQdExSbhV8yewi5q1b4pYc2g/fPwRFTE4DQxQe9veXOXQcb6QWpzVHmgLcY0xgLjQSQ==
X-Received: by 2002:a5d:65c5:0:b0:306:35fa:202b with SMTP id
 e5-20020a5d65c5000000b0030635fa202bmr1223276wrw.6.1684345614036; 
 Wed, 17 May 2023 10:46:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 q7-20020adfcd87000000b003062b2c5255sm3400498wrj.40.2023.05.17.10.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 56/68] build: move SafeStack tests to meson
Date: Wed, 17 May 2023 19:45:08 +0200
Message-Id: <20230517174520.887405-57-pbonzini@redhat.com>
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

This disables the old behavior of detecting SafeStack from environment
CFLAGS.  SafeStack is now enabled purely based on the configure arguments.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 73 -----------------------------------
 meson.build                   | 26 +++++++++++++
 meson_options.txt             |  2 +
 scripts/meson-buildoptions.sh |  4 ++
 4 files changed, 32 insertions(+), 73 deletions(-)

diff --git a/configure b/configure
index 34b26c45cf39..1cde6f698161 100755
--- a/configure
+++ b/configure
@@ -227,7 +227,6 @@ cross_compile="no"
 cross_prefix=""
 host_cc="cc"
 stack_protector=""
-safe_stack=""
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
@@ -830,10 +829,6 @@ for opt do
   ;;
   --disable-stack-protector) stack_protector="no"
   ;;
-  --enable-safe-stack) safe_stack="yes"
-  ;;
-  --disable-safe-stack) safe_stack="no"
-  ;;
   --enable-cfi)
       cfi="true";
       meson_option_add -Db_lto=true
@@ -1024,8 +1019,6 @@ cat << EOF
   pie             Position Independent Executables
   debug-tcg       TCG debugging (default is disabled)
   debug-info      debugging information
-  safe-stack      SafeStack Stack Smash Protection. Depends on
-                  clang/llvm and requires coroutine backend ucontext.
 
 NOTE: The object files are built at the place where configure is launched
 EOF
@@ -1521,68 +1514,6 @@ else
   esac
 fi
 
-##################################################
-# SafeStack
-
-
-if test "$safe_stack" = "yes"; then
-cat > $TMPC << EOF
-int main(void)
-{
-#if ! __has_feature(safe_stack)
-#error SafeStack Disabled
-#endif
-    return 0;
-}
-EOF
-  flag="-fsanitize=safe-stack"
-  # Check that safe-stack is supported and enabled.
-  if compile_prog "-Werror $flag" "$flag"; then
-    # Flag needed both at compilation and at linking
-    QEMU_CFLAGS="$QEMU_CFLAGS $flag"
-    QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
-  else
-    error_exit "SafeStack not supported by your compiler"
-  fi
-  if test "$coroutine" != "ucontext"; then
-    error_exit "SafeStack is only supported by the coroutine backend ucontext"
-  fi
-else
-cat > $TMPC << EOF
-int main(void)
-{
-#if defined(__has_feature)
-#if __has_feature(safe_stack)
-#error SafeStack Enabled
-#endif
-#endif
-    return 0;
-}
-EOF
-if test "$safe_stack" = "no"; then
-  # Make sure that safe-stack is disabled
-  if ! compile_prog "-Werror" ""; then
-    # SafeStack was already enabled, try to explicitly remove the feature
-    flag="-fno-sanitize=safe-stack"
-    if ! compile_prog "-Werror $flag" "$flag"; then
-      error_exit "Configure cannot disable SafeStack"
-    fi
-    QEMU_CFLAGS="$QEMU_CFLAGS $flag"
-    QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
-  fi
-else # "$safe_stack" = ""
-  # Set safe_stack to yes or no based on pre-existing flags
-  if compile_prog "-Werror" ""; then
-    safe_stack="no"
-  else
-    safe_stack="yes"
-    if test "$coroutine" != "ucontext"; then
-      error_exit "SafeStack is only supported by the coroutine backend ucontext"
-    fi
-  fi
-fi
-fi
-
 ########################################
 # check if ccache is interfering with
 # semantic analysis of macros
@@ -2242,10 +2173,6 @@ if test "$ccache_cpp2" = "yes"; then
   echo "export CCACHE_CPP2=y" >> $config_host_mak
 fi
 
-if test "$safe_stack" = "yes"; then
-  echo "CONFIG_SAFESTACK=y" >> $config_host_mak
-fi
-
 # tests/tcg configuration
 (config_host_mak=tests/tcg/config-host.mak
 mkdir -p tests/tcg
diff --git a/meson.build b/meson.build
index b4d2a53b6c36..b83b3c937d8f 100644
--- a/meson.build
+++ b/meson.build
@@ -211,6 +211,31 @@ if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
 
+# Compiles if SafeStack *not* enabled
+safe_stack_probe = '''
+  int main(void)
+  {
+  #if defined(__has_feature)
+  #if __has_feature(safe_stack)
+  #error SafeStack Enabled
+  #endif
+  #endif
+      return 0;
+  }'''
+if get_option('safe_stack') != not cc.compiles(safe_stack_probe)
+  safe_stack_arg = get_option('safe_stack') ? '-fsanitize=safe-stack' : '-fno-sanitize=safe-stack'
+  if get_option('safe_stack') != not cc.compiles(safe_stack_probe, args: safe_stack_arg)
+    error(get_option('safe_stack') \
+          ? 'SafeStack not supported by your compiler' \
+          : 'Cannot disable SafeStack')
+  endif
+  qemu_cflags += safe_stack_arg
+  qemu_ldflags += safe_stack_arg
+endif
+if get_option('safe_stack') and config_host['CONFIG_COROUTINE_BACKEND'] != 'ucontext'
+  error('SafeStack is only supported with the ucontext coroutine backend')
+endif
+
 if get_option('sanitizers')
   if cc.has_argument('-fsanitize=address')
     qemu_cflags = ['-fsanitize=address'] + qemu_cflags
@@ -1946,6 +1971,7 @@ config_host_data.set('CONFIG_OPENGL', opengl.found())
 config_host_data.set('CONFIG_PROFILER', get_option('profiler'))
 config_host_data.set('CONFIG_RBD', rbd.found())
 config_host_data.set('CONFIG_RDMA', rdma.found())
+config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
 config_host_data.set('CONFIG_SDL', sdl.found())
 config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 config_host_data.set('CONFIG_SECCOMP', seccomp.found())
diff --git a/meson_options.txt b/meson_options.txt
index a15d434267f9..89bc06b561e6 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -82,6 +82,8 @@ option('tcg', type: 'feature', value: 'enabled',
        description: 'TCG support')
 option('tcg_interpreter', type: 'boolean', value: false,
        description: 'TCG with bytecode interpreter (slow)')
+option('safe_stack', type: 'boolean', value: false,
+       description: 'SafeStack Stack Smash Protection (requires clang/llvm and coroutine backend ucontext)')
 option('sanitizers', type: 'boolean', value: false,
        description: 'enable default sanitizers')
 option('tsan', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index b79a14b6948c..35dbfff2387a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -41,6 +41,8 @@ meson_options_help() {
   printf "%s\n" '  --enable-profiler        profiler support'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
   printf "%s\n" '                           getrandom()'
+  printf "%s\n" '  --enable-safe-stack      SafeStack Stack Smash Protection (requires'
+  printf "%s\n" '                           clang/llvm and coroutine backend ucontext)'
   printf "%s\n" '  --enable-sanitizers      enable default sanitizers'
   printf "%s\n" '  --enable-strip           Strip targets on install'
   printf "%s\n" '  --enable-tcg-interpreter TCG with bytecode interpreter (slow)'
@@ -408,6 +410,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
+    --disable-safe-stack) printf "%s" -Dsafe_stack=false ;;
     --enable-sanitizers) printf "%s" -Dsanitizers=true ;;
     --disable-sanitizers) printf "%s" -Dsanitizers=false ;;
     --enable-sdl) printf "%s" -Dsdl=enabled ;;
-- 
2.40.1


