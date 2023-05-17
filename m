Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7648D70704B
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH7-0005Ps-El; Wed, 17 May 2023 13:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLF0-00025A-Au
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEx-0004X5-Cp
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jig9o1Y8Sz+QnnoZxr0j8M49vPjfPTSpyMINpp/zs4w=;
 b=dK1SLF4cinA6pMOybgsQEKAo7Zw6Q1e7L8Wf6q25M2LAIC9GhTFTOKNysHb/sjShQvoJM3
 +Ef0Cwb7vJjMBqXUq6sCosCtmT7yX8uu36+bPY4jlUjcJcr0RC1NCttlsf4W0snDsVEpzc
 LzyYejiPCXgeqPG7gAn6J2DsES8AgAs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-tcfj2NH7M3mSL5q0QddmFw-1; Wed, 17 May 2023 13:47:02 -0400
X-MC-Unique: tcfj2NH7M3mSL5q0QddmFw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30640be4fd0so449680f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:47:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345621; x=1686937621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jig9o1Y8Sz+QnnoZxr0j8M49vPjfPTSpyMINpp/zs4w=;
 b=Sn5tRDqQpLqABiwfhLl71jfb1Qmp29So+WYai0SlSTU1mkE2iudeUNDRNpbKSR/qHB
 Bjb2u1djC4/lnjBQTjoOyWVud/Iubq50I8miQLWvj/AqTnAsc7huHQ100fbUtNuxJ9Zh
 mF1miVPy028SG8JilY9vgakSimtXZ6tXAiCURqIiLcUBdr3K5F6t5Lv10p4Txlb+XCcp
 6Ajbh8y4PFTPVZYnUbFumIgcA0oIUnsve6E44MsAdWkeCHXYfWchTNFxMOgK+hYgw3Rc
 zIPSkN31pemNUPlvO1oFkkAgCqy3g4uefbE455TXW3FdscGkaEn8tCec+TEoBfCz9GuL
 jqDQ==
X-Gm-Message-State: AC+VfDyezzGJVFmbJsYPBtITa9rNhVkJNcLHyIbYGfO1yAZ9MSdaDZgo
 lsAls8TCegKtbsD3Og/CJ2Drq0y9ATm4CPU1Q97PYblYwd4MWOjBxhhi0JQTa/i8YQ0HJ2yxW5r
 WcszmYrkvyv0Oo1bvm07mDxKkXkgAS3Dr+JvonLFLRRFLQtoCBB15F3L01MOpvLx1iBE3sMvqod
 4=
X-Received: by 2002:adf:fd06:0:b0:309:41f7:e40e with SMTP id
 e6-20020adffd06000000b0030941f7e40emr1208247wrr.28.1684345620971; 
 Wed, 17 May 2023 10:47:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5XQB7kjPejZRpSQXAMn1UHfOqpw7Z9jT+5tCcQ3KFvBCN27C/4wUbyOyvGURSTkAGxK4w8ZQ==
X-Received: by 2002:adf:fd06:0:b0:309:41f7:e40e with SMTP id
 e6-20020adffd06000000b0030941f7e40emr1208236wrr.28.1684345620578; 
 Wed, 17 May 2023 10:47:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a5d6611000000b003079c402762sm3527532wru.19.2023.05.17.10.46.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 60/68] build: move remaining compiler flag tests to meson
Date: Wed, 17 May 2023 19:45:12 +0200
Message-Id: <20230517174520.887405-61-pbonzini@redhat.com>
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

Remove the only remaining uses of QEMU_CFLAGS.  Now that no
feature tests are done in configure, it is possible to remove
CONFIGURE_CFLAGS and CONFIGURE_LDFLAGS as well.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 79 ++++++++---------------------------------------------
 meson.build | 49 ++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 69 deletions(-)

diff --git a/configure b/configure
index eed1aec31c23..6e78f6199feb 100755
--- a/configure
+++ b/configure
@@ -163,14 +163,14 @@ do_cc() {
 
 compile_object() {
   local_cflags="$1"
-  do_cc $CFLAGS $EXTRA_CFLAGS $CONFIGURE_CFLAGS $QEMU_CFLAGS $local_cflags -c -o $TMPO $TMPC
+  do_cc $CFLAGS $EXTRA_CFLAGS $local_cflags -c -o $TMPO $TMPC
 }
 
 compile_prog() {
   local_cflags="$1"
   local_ldflags="$2"
-  do_cc $CFLAGS $EXTRA_CFLAGS $CONFIGURE_CFLAGS $QEMU_CFLAGS $local_cflags -o $TMPE $TMPC \
-      $LDFLAGS $EXTRA_LDFLAGS $CONFIGURE_LDFLAGS $local_ldflags
+  do_cc $CFLAGS $EXTRA_CFLAGS $local_cflags -o $TMPE $TMPC \
+      $LDFLAGS $EXTRA_LDFLAGS $local_ldflags
 }
 
 # symbolically link $1 to $2.  Portable version of "ln -sf".
@@ -375,19 +375,6 @@ windmc="${WINDMC-${cross_prefix}windmc}"
 pkg_config="${PKG_CONFIG-${cross_prefix}pkg-config}"
 sdl2_config="${SDL2_CONFIG-${cross_prefix}sdl2-config}"
 
-# default flags for all hosts
-# We use -fwrapv to tell the compiler that we require a C dialect where
-# left shift of signed integers is well defined and has the expected
-# 2s-complement style results. (Both clang and gcc agree that it
-# provides these semantics.)
-QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv"
-QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
-
-# Flags that are needed during configure but later taken care of by Meson
-CONFIGURE_CFLAGS="-std=gnu11 -Wall"
-CONFIGURE_LDFLAGS=
-
-
 check_define() {
 cat > $TMPC <<EOF
 #if !defined($1)
@@ -466,21 +453,13 @@ openbsd)
 darwin)
   bsd="yes"
   darwin="yes"
-  # Disable attempts to use ObjectiveC features in os/object.h since they
-  # won't work when we're compiling with gcc as a C compiler.
-  QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
 ;;
 sunos)
   solaris="yes"
   make="${MAKE-gmake}"
-# needed for CMSG_ macros in sys/socket.h
-  QEMU_CFLAGS="-D_XOPEN_SOURCE=600 $QEMU_CFLAGS"
-# needed for TIOCWIN* defines in termios.h
-  QEMU_CFLAGS="-D__EXTENSIONS__ $QEMU_CFLAGS"
 ;;
 haiku)
   pie="no"
-  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -D_BSD_SOURCE -fPIC $QEMU_CFLAGS"
 ;;
 linux)
   linux="yes"
@@ -633,8 +612,6 @@ done
 
 if test "$mingw32" = "yes" ; then
   EXESUF=".exe"
-  # MinGW needs -mthreads for TLS and macro _MT.
-  CONFIGURE_CFLAGS="-mthreads $CONFIGURE_CFLAGS"
   prefix="/qemu"
   bindir=""
   qemu_suffix=""
@@ -1196,59 +1173,26 @@ static THREAD int tls_var;
 int main(void) { return tls_var; }
 EOF
 
-# Meson currently only handles pie as a boolean for now so if we have
-# explicitly disabled PIE we need to extend our cflags because it wont.
 if test "$static" = "yes"; then
   if test "$pie" != "no" && compile_prog "-Werror -fPIE -DPIE" "-static-pie"; then
-    CONFIGURE_CFLAGS="-fPIE -DPIE $CONFIGURE_CFLAGS"
     pie="yes"
   elif test "$pie" = "yes"; then
     error_exit "-static-pie not available due to missing toolchain support"
   else
     pie="no"
-    QEMU_CFLAGS="-fno-pie $QEMU_CFLAGS"
   fi
-elif test "$pie" = "no"; then
-  if compile_prog "-Werror -fno-pie" "-no-pie"; then
-    CONFIGURE_CFLAGS="-fno-pie $CONFIGURE_CFLAGS"
-    CONFIGURE_LDFLAGS="-no-pie $CONFIGURE_LDFLAGS"
-    QEMU_CFLAGS="-fno-pie -no-pie $QEMU_CFLAGS"
+elif test "$pie" != "no"; then
+  if compile_prog "-Werror -fPIE -DPIE" "-pie"; then
+    pie="yes"
+  elif test "$pie" = "yes"; then
+    error_exit "PIE not available due to missing toolchain support"
+  else
+    echo "Disabling PIE due to missing toolchain support"
+    pie="no"
   fi
-elif compile_prog "-Werror -fPIE -DPIE" "-pie"; then
-  CONFIGURE_CFLAGS="-fPIE -DPIE $CONFIGURE_CFLAGS"
-  CONFIGURE_LDFLAGS="-pie $CONFIGURE_LDFLAGS"
-  pie="yes"
-elif test "$pie" = "yes"; then
-  error_exit "PIE not available due to missing toolchain support"
-else
-  echo "Disabling PIE due to missing toolchain support"
-  pie="no"
 fi
 
 ##########################################
-# __sync_fetch_and_and requires at least -march=i486. Many toolchains
-# use i686 as default anyway, but for those that don't, an explicit
-# specification is necessary
-
-if test "$cpu" = "i386"; then
-  cat > $TMPC << EOF
-static int sfaa(int *ptr)
-{
-  return __sync_fetch_and_and(ptr, 0);
-}
-
-int main(void)
-{
-  int val = 42;
-  val = __sync_val_compare_and_swap(&val, 0, 1);
-  sfaa(&val);
-  return val;
-}
-EOF
-  if ! compile_prog "" "" ; then
-    QEMU_CFLAGS="-march=i486 $QEMU_CFLAGS"
-  fi
-fi
 
 if test -z "${target_list+xxx}" ; then
     default_targets=yes
@@ -1931,7 +1875,6 @@ echo "MESON=$meson" >> $config_host_mak
 echo "NINJA=$ninja" >> $config_host_mak
 echo "PKG_CONFIG=${pkg_config}" >> $config_host_mak
 echo "CC=$cc" >> $config_host_mak
-echo "QEMU_CFLAGS=$QEMU_CFLAGS" >> $config_host_mak
 echo "EXESUF=$EXESUF" >> $config_host_mak
 
 # use included Linux headers
diff --git a/meson.build b/meson.build
index e7a7a1624afa..6098426e7198 100644
--- a/meson.build
+++ b/meson.build
@@ -190,10 +190,50 @@ endif
 # Compiler flags #
 ##################
 
-qemu_common_flags = config_host['QEMU_CFLAGS'].split()
+# default flags for all hosts
+# We use -fwrapv to tell the compiler that we require a C dialect where
+# left shift of signed integers is well defined and has the expected
+# 2s-complement style results. (Both clang and gcc agree that it
+# provides these semantics.)
+
+qemu_common_flags = [
+  '-D_GNU_SOURCE', '-D_FILE_OFFSET_BITS=64', '-D_LARGEFILE_SOURCE',
+  '-fno-strict-aliasing', '-fno-common', '-fwrapv' ]
 qemu_cflags = []
 qemu_ldflags = []
 
+if targetos == 'darwin'
+  # Disable attempts to use ObjectiveC features in os/object.h since they
+  # won't work when we're compiling with gcc as a C compiler.
+  qemu_common_flags += '-DOS_OBJECT_USE_OBJC=0'
+elif targetos == 'solaris'
+  # needed for CMSG_ macros in sys/socket.h
+  qemu_common_flags += '-D_XOPEN_SOURCE=600'
+  # needed for TIOCWIN* defines in termios.h
+  qemu_common_flags += '-D__EXTENSIONS__'
+elif targetos == 'haiku'
+  qemu_common_flags += ['-DB_USE_POSITIVE_POSIX_ERRORS', '-D_BSD_SOURCE', '-fPIC']
+endif
+
+# __sync_fetch_and_and requires at least -march=i486. Many toolchains
+# use i686 as default anyway, but for those that don't, an explicit
+# specification is necessary
+if host_arch == 'i386' and not cc.links('''
+  static int sfaa(int *ptr)
+  {
+    return __sync_fetch_and_and(ptr, 0);
+  }
+
+  int main(void)
+  {
+    int val = 42;
+    val = __sync_val_compare_and_swap(&val, 0, 1);
+    sfaa(&val);
+    return val;
+  }''')
+  qemu_common_flags = ['-march=i486'] + qemu_common_flags
+endif
+
 if get_option('gprof')
   qemu_common_flags += ['-p']
   qemu_ldflags += ['-p']
@@ -203,6 +243,13 @@ if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
 
+# Meson currently only handles pie as a boolean for now, so if the user
+# has explicitly disabled PIE we need to extend our cflags.
+if not get_option('b_pie')
+  qemu_cflags += cc.get_supported_arguments('-fno-pie')
+  qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
+endif
+
 if not get_option('stack_protector').disabled()
   stack_protector_probe = '''
     int main(int argc, char *argv[])
-- 
2.40.1


