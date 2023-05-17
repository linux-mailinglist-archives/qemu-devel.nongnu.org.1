Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43808707018
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGH-0003tY-IN; Wed, 17 May 2023 13:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEt-0001xH-LH
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEr-0004UX-Kj
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCgR9v3N8PSkB0t2huCh2sJiSmL5LcBYnaM/x43qXsY=;
 b=DekeseMj0nAV7+R2WhPKYHSBK52BlXyU4z4OKSCJXqSbwswlfd0v/XfimOgQa59gIuIees
 APnBU/hZcF7UkLQqS/R2aiJSZSDd0QBC4pKRkhrCZaInQGpAfgfU6uSURyj/fIzRD1WCD1
 cJ351b9/7xgWqO584ZMgXB8/9FQlny4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-62tXzSMwNXWjCR7SPsXAAA-1; Wed, 17 May 2023 13:46:59 -0400
X-MC-Unique: 62tXzSMwNXWjCR7SPsXAAA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4fa463282so7693395e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345618; x=1686937618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fCgR9v3N8PSkB0t2huCh2sJiSmL5LcBYnaM/x43qXsY=;
 b=O5bmWZpt7sTez0/GiYXXIrqqKA1Dhc1wLO2ztZK9q/SHNlIbOmPZq4vZIyT5s/fvd/
 cGBb2PqlZwa5VXBto61cb/tDWSGfnP/TaxsXDTw2TtXu6MlNvDSbhBCWqvRlrYLSQ8q1
 HUXcqZ4QBog6vIId/npkjFvonfycZlW1WmfFZiLQ1xxc97SOmFTph/zCMPlIFYEgS6FX
 qWk8Opw0K87ilZT/012m4bfenZ47CWLe6036G4RGQqlTtccHI++IJUw7YgPrigoFr1GP
 N6RmG2kVGl42YVsXymRLFDbU1xiGGkRugjZUKBMqn/gKErTWo+J6V3zeJydjCTgDuGfY
 2WdA==
X-Gm-Message-State: AC+VfDzdueSV7W+fzKkfER5iiHJTMOMeJMx1+MWXQ4H7g2JULUqGZ54h
 cYrE5D5vVRad3xmyXdV4e4xIH8Y6AbImN9ghP70XNFRCcWwn/iOzwf2UfpeVqvSxic5LizcYgFT
 j3IdZMKcXCaPTzGLcLCXVJ0cgechyGOr7sLBz1h6/3uOWpHftDXe5MEzb1WUr5+P8maCpZzVcY7
 c=
X-Received: by 2002:a1c:f304:0:b0:3f1:979f:a734 with SMTP id
 q4-20020a1cf304000000b003f1979fa734mr28757585wmq.11.1684345617858; 
 Wed, 17 May 2023 10:46:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KyGgmSShXGzqJ+BxvOeW+wCOxdVlRURVChF7M3YdPKooND2/sTrRQ6MJMiH59oVVe/PBOGA==
X-Received: by 2002:a1c:f304:0:b0:3f1:979f:a734 with SMTP id
 q4-20020a1cf304000000b003f1979fa734mr28757572wmq.11.1684345617465; 
 Wed, 17 May 2023 10:46:57 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c00c200b003f4fbd9cdb3sm2851102wmm.34.2023.05.17.10.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 58/68] build: move stack protector flag selection to meson
Date: Wed, 17 May 2023 19:45:10 +0200
Message-Id: <20230517174520.887405-59-pbonzini@redhat.com>
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 44 ++---------------------------------
 meson.build                   | 28 +++++++++++++++++++++-
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 34 insertions(+), 43 deletions(-)

diff --git a/configure b/configure
index 470ed9f8c201..44d70803f5ce 100755
--- a/configure
+++ b/configure
@@ -180,7 +180,7 @@ compile_prog() {
   local_cflags="$1"
   local_ldflags="$2"
   do_cc $CFLAGS $EXTRA_CFLAGS $CONFIGURE_CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC \
-      $LDFLAGS $EXTRA_LDFLAGS $CONFIGURE_LDFLAGS $QEMU_LDFLAGS $local_ldflags
+      $LDFLAGS $EXTRA_LDFLAGS $CONFIGURE_LDFLAGS $local_ldflags
 }
 
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -226,7 +226,6 @@ static="no"
 cross_compile="no"
 cross_prefix=""
 host_cc="cc"
-stack_protector=""
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
@@ -394,8 +393,6 @@ sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
 
-QEMU_LDFLAGS=
-
 # Flags that are needed during configure but later taken care of by Meson
 CONFIGURE_CFLAGS="-std=gnu11 -Wall"
 CONFIGURE_LDFLAGS=
@@ -824,10 +821,6 @@ for opt do
   ;;
   --disable-werror) werror="no"
   ;;
-  --enable-stack-protector) stack_protector="yes"
-  ;;
-  --disable-stack-protector) stack_protector="no"
-  ;;
   --enable-cfi)
       cfi="true";
       meson_option_add -Db_lto=true
@@ -998,7 +991,6 @@ Advanced options (experts only):
   --with-devices-ARCH=NAME override default configs/devices
   --enable-debug           enable common debug build options
   --disable-werror         disable compilation abort on warning
-  --disable-stack-protector disable compiler-provided stack protection
   --cpu=CPU                Build for host CPU [$cpu]
   --enable-plugins
                            enable plugins via shared library loading
@@ -1257,7 +1249,7 @@ EOF
     optflag="$(echo $1 | sed -e 's/^-Wno-/-W/')"
     do_objc -Werror $optflag \
       $OBJCFLAGS $EXTRA_OBJCFLAGS $CONFIGURE_OBJCFLAGS $QEMU_OBJCFLAGS \
-      -o $TMPE $TMPM $QEMU_LDFLAGS
+      -o $TMPE $TMPM
 }
 
 for flag in $gcc_flags; do
@@ -1269,37 +1261,6 @@ for flag in $gcc_flags; do
     fi
 done
 
-if test "$stack_protector" != "no"; then
-  cat > $TMPC << EOF
-int main(int argc, char *argv[])
-{
-    char arr[64], *p = arr, *c = argv[argc - 1];
-    while (*c) {
-        *p++ = *c++;
-    }
-    return 0;
-}
-EOF
-  gcc_flags="-fstack-protector-strong -fstack-protector-all"
-  sp_on=0
-  for flag in $gcc_flags; do
-    # We need to check both a compile and a link, since some compiler
-    # setups fail only on a .c->.o compile and some only at link time
-    if compile_object "-Werror $flag" &&
-       compile_prog "-Werror $flag" ""; then
-      QEMU_CFLAGS="$QEMU_CFLAGS $flag"
-      QEMU_LDFLAGS="$QEMU_LDFLAGS $flag"
-      sp_on=1
-      break
-    fi
-  done
-  if test "$stack_protector" = yes; then
-    if test $sp_on = 0; then
-      error_exit "Stack protector not supported"
-    fi
-  fi
-fi
-
 if test "$static" = "yes" ; then
   if test "$plugins" = "yes"; then
     error_exit "static and plugins are mutually incompatible"
@@ -2057,7 +2018,6 @@ echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
 echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "QEMU_OBJCFLAGS=$QEMU_OBJCFLAGS" >> $config_host_mak
-echo "QEMU_LDFLAGS=$QEMU_LDFLAGS" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers
diff --git a/meson.build b/meson.build
index f410afe8b044..fff488f63f6d 100644
--- a/meson.build
+++ b/meson.build
@@ -200,7 +200,7 @@ foreach arg : config_host['QEMU_CFLAGS'].split()
   endif
 endforeach
 qemu_objcflags = config_host['QEMU_OBJCFLAGS'].split()
-qemu_ldflags = config_host['QEMU_LDFLAGS'].split()
+qemu_ldflags = []
 
 if get_option('gprof')
   qemu_common_flags += ['-p']
@@ -211,6 +211,32 @@ if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
 
+if not get_option('stack_protector').disabled()
+  stack_protector_probe = '''
+    int main(int argc, char *argv[])
+    {
+      char arr[64], *p = arr, *c = argv[argc - 1];
+      while (*c) {
+          *p++ = *c++;
+      }
+      return 0;
+    }'''
+  have_stack_protector = false
+  foreach arg : ['-fstack-protector-strong', '-fstack-protector-all']
+    # We need to check both a compile and a link, since some compiler
+    # setups fail only on a .c->.o compile and some only at link time
+    if cc.compiles(stack_protector_probe, args: ['-Werror', arg]) and \
+       cc.links(stack_protector_probe, args: ['-Werror', arg])
+      have_stack_protector = true
+      qemu_cflags += arg
+      qemu_ldflags += arg
+      break
+    endif
+  endforeach
+  get_option('stack_protector') \
+    .require(have_stack_protector, error_message: 'Stack protector not supported')
+endif
+
 coroutine_backend = get_option('coroutine_backend')
 ucontext_probe = '''
   #include <ucontext.h>
diff --git a/meson_options.txt b/meson_options.txt
index 69de30c83db0..43c3ddfd48fc 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -91,6 +91,8 @@ option('sanitizers', type: 'boolean', value: false,
        description: 'enable default sanitizers')
 option('tsan', type: 'boolean', value: false,
        description: 'enable thread sanitizer')
+option('stack_protector', type: 'feature', value: 'auto',
+       description: 'compiler-provided stack protection')
 option('cfi', type: 'boolean', value: false,
        description: 'Control-Flow Integrity (CFI)')
 option('cfi_debug', type: 'boolean', value: false,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 032fcea948d4..28b6e8385bc1 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -165,6 +165,7 @@ meson_options_help() {
   printf "%s\n" '  sparse          sparse checker'
   printf "%s\n" '  spice           Spice server support'
   printf "%s\n" '  spice-protocol  Spice protocol support'
+  printf "%s\n" '  stack-protector compiler-provided stack protection'
   printf "%s\n" '  tcg             TCG support'
   printf "%s\n" '  tools           build support utilities that come with QEMU'
   printf "%s\n" '  tpm             TPM support'
@@ -441,6 +442,8 @@ _meson_option_parse() {
     --disable-spice) printf "%s" -Dspice=disabled ;;
     --enable-spice-protocol) printf "%s" -Dspice_protocol=enabled ;;
     --disable-spice-protocol) printf "%s" -Dspice_protocol=disabled ;;
+    --enable-stack-protector) printf "%s" -Dstack_protector=enabled ;;
+    --disable-stack-protector) printf "%s" -Dstack_protector=disabled ;;
     --enable-strip) printf "%s" -Dstrip=true ;;
     --disable-strip) printf "%s" -Dstrip=false ;;
     --sysconfdir=*) quote_sh "-Dsysconfdir=$2" ;;
-- 
2.40.1


