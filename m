Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35DB707006
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGz-0004vU-EC; Wed, 17 May 2023 13:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEb-0000tD-Vc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEZ-0004OX-Rp
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6L8pigL04+7noMI87Ra9LpcpynCzBM12C1I2eXwOcmo=;
 b=QSblVqahjem5sN21SABqb97wx4NHcyowWqt3gPXmUZccwuiZgdNekA3AEXWNfVuKKJrIWQ
 NaZ4FW2DMJPmohO/I/XDyM3j6c7x5cM+vejcdJEnxZSpehbt996hVE76YwV28rQooLhWvx
 ITldHwUqc65NZaapQ9lW7+jMQ7Ggy1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-Z8GK2XaCO6mjQ9TlC9BenA-1; Wed, 17 May 2023 13:46:42 -0400
X-MC-Unique: Z8GK2XaCO6mjQ9TlC9BenA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f422dc5fafso7065695e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345600; x=1686937600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6L8pigL04+7noMI87Ra9LpcpynCzBM12C1I2eXwOcmo=;
 b=d6iIybN7GeFq2W7wpmzxhYVEGjd16cFan/P6JjTnNClT8WYlR3lEs1w97aal5Lowjl
 f4xL1TexJmW8iACu9puoqMG46ex3djZK2Rurq/avrqDt3aXGx/R7HF194BbgSgNCg5tZ
 b78VPXoiHIxWoyq9Kn/XlZ1FGbG3FvuW1NWRRgXVGlqoX5iwbEZA7Q7ESU3WW5snT3dV
 OW8b4iealuF/ow0eiGlLSPWIUhSngpFBu1v96ccjkNtvhhZC/7LUnN4kIDJLW7ZrsiXa
 eqaNAHCOhBngEOpZe/Dvapj6YmThmVatHFH+aWA0b2cY8uJs7aSKRN6HKl4sVXh2UTTE
 A8ig==
X-Gm-Message-State: AC+VfDzq95/7cf31cTrbkZxA32jNmLgXrZLwJsRW4kT9XKzJJ6BupYvq
 9YqZQBJkr3aPQW7MRygT/4URIibdO8r40OI93s/Usk0TtAOugjmF82lPPGpN4AriU0VFiT/FCLX
 DAqlLj0MB+7Qah3RxgLdagBGUXxG5kNy3pNJiK2giPdpxmeZ00G+hbQ/IVJ3OvulW/lPE2aPo68
 o=
X-Received: by 2002:a1c:4c08:0:b0:3f4:2737:a016 with SMTP id
 z8-20020a1c4c08000000b003f42737a016mr21134062wmf.29.1684345600201; 
 Wed, 17 May 2023 10:46:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tehf9GGUAcNkG65GckUySCThEB2d+jhgQR6rApYzgFsGJVZdi8JlvJfNGgbVDFlkq5r3JAA==
X-Received: by 2002:a1c:4c08:0:b0:3f4:2737:a016 with SMTP id
 z8-20020a1c4c08000000b003f42737a016mr21134050wmf.29.1684345599836; 
 Wed, 17 May 2023 10:46:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1c4c12000000b003f4f8cc4285sm2854423wmf.17.2023.05.17.10.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 47/68] meson: use prefer_static option
Date: Wed, 17 May 2023 19:44:59 +0200
Message-Id: <20230517174520.887405-48-pbonzini@redhat.com>
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

The option is new in Meson 0.63 and removes the need to pass "static:
true" to all dependency and find_library invocation.  Actually cleaning
up the invocations is left for a separate patch.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                   |  4 +---
 docs/devel/build-system.rst |  3 +--
 meson.build                 | 13 +++++--------
 qga/meson.build             |  2 +-
 4 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/configure b/configure
index dbdcf3886d56..651ada7b6bc3 100755
--- a/configure
+++ b/configure
@@ -2409,9 +2409,6 @@ fi
 if test "$solaris" = "yes" ; then
   echo "CONFIG_SOLARIS=y" >> $config_host_mak
 fi
-if test "$static" = "yes" ; then
-  echo "CONFIG_STATIC=y" >> $config_host_mak
-fi
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 if test "$modules" = "yes"; then
@@ -2654,6 +2651,7 @@ if test "$skip_meson" = no; then
   # Built-in options
   test "$bindir" != "bin" && meson_option_add "-Dbindir=$bindir"
   test "$default_feature" = no && meson_option_add -Dauto_features=disabled
+  test "$static" = yes && meson_option_add -Dprefer_static=true
   test "$pie" = no && meson_option_add -Db_pie=false
   test "$werror" = yes && meson_option_add -Dwerror=true
 
diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 189472174340..9db18aff159e 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -311,8 +311,7 @@ dependency will be used::
   sdl_image = not_found
   if not get_option('sdl_image').auto() or have_system
     sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
-                           method: 'pkg-config',
-                           static: enable_static)
+                           method: 'pkg-config')
   endif
 
 This avoids warnings on static builds of user-mode emulators, for example.
diff --git a/meson.build b/meson.build
index e3a9db20ffa7..ac5bb903d2c6 100644
--- a/meson.build
+++ b/meson.build
@@ -18,10 +18,7 @@ targetos = host_machine.system()
 sh = find_program('sh')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 enable_modules = 'CONFIG_MODULES' in config_host
-enable_static = 'CONFIG_STATIC' in config_host
-
-# Allow both shared and static libraries unless --enable-static
-static_kwargs = enable_static ? {'static': true} : {}
+static_kwargs = {}
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
@@ -193,7 +190,7 @@ qemu_cflags = config_host['QEMU_CFLAGS'].split()
 qemu_objcflags = config_host['QEMU_OBJCFLAGS'].split()
 qemu_ldflags = config_host['QEMU_LDFLAGS'].split()
 
-if enable_static
+if get_option('prefer_static')
   qemu_ldflags += get_option('b_pie') ? '-static-pie' : '-static'
 endif
 
@@ -841,7 +838,7 @@ if targetos == 'linux' and have_tools and get_option('mpath').allowed()
                                     kwargs: static_kwargs)
   if libmpathpersist.found()
     mpathlibs += libmpathpersist
-    if enable_static
+    if get_option('prefer_static')
       mpathlibs += cc.find_library('devmapper',
                                      required: get_option('mpath'),
                                      kwargs: static_kwargs)
@@ -1225,7 +1222,7 @@ if not gnutls_crypto.found()
     # Debian has removed -lgpg-error from libgcrypt-config
     # as it "spreads unnecessary dependencies" which in
     # turn breaks static builds...
-    if gcrypt.found() and enable_static
+    if gcrypt.found() and get_option('prefer_static')
       gcrypt = declare_dependency(dependencies: [
         gcrypt,
         cc.find_library('gpg-error', required: true, kwargs: static_kwargs)])
@@ -1657,7 +1654,7 @@ endif
 # libdw
 libdw = not_found
 if not get_option('libdw').auto() or \
-        (not enable_static and (have_system or have_user))
+        (not get_option('prefer_static') and (have_system or have_user))
     libdw = dependency('libdw',
                        method: 'pkg-config',
                        kwargs: static_kwargs,
diff --git a/qga/meson.build b/qga/meson.build
index ad17dc7dca13..622b5f94a232 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -22,7 +22,7 @@ have_qga_vss = get_option('qga_vss') \
     Then run configure with: --extra-cxxflags="-isystem /path/to/vss/inc/win2003"''') \
   .require(midl.found() or widl.found(),
            error_message: 'VSS support requires midl or widl') \
-  .require(not enable_static,
+  .require(not get_option('prefer_static'),
            error_message: 'VSS support requires dynamic linking with GLib') \
   .allowed()
 
-- 
2.40.1


