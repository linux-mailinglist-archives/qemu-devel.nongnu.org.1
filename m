Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FB707012
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH8-0005TA-HS; Wed, 17 May 2023 13:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEg-0001cc-4B
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEc-0004PL-SE
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6kbBe+bveL6T0RzMAZoDW/nord6nL/So0Jk3UEjD+I=;
 b=T5+Mx4hmI6SXyKOT5Fm8gHo14aC2SxilPbFzgjF3E4tG40hrRaqwl/wBssV9DiwAW4vs3p
 lGkX6ZAjQIHA77p4SojiQvMkppZbGs6X3dhsxr2jD8KcP55HETyTa4qaJ8TUmgIJ5Y8HMX
 olM3OBBmhOpkezdmXPevx0/R9El7B34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-aMwPXeSrPT6CyYNsUTkejg-1; Wed, 17 May 2023 13:46:44 -0400
X-MC-Unique: aMwPXeSrPT6CyYNsUTkejg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f4ef4bf00dso6600565e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345602; x=1686937602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6kbBe+bveL6T0RzMAZoDW/nord6nL/So0Jk3UEjD+I=;
 b=gX0EMEbdDn1hEbDXyqc0dj7urD6QZyVSx4IP/31lp2wLIRUDxwv2xzfdFAhGZSnDYP
 oXcvGaIj6EcIYfiEAERi7tfzqM0BJO9xFUrinY1i+t1kCFGv9szmskF06meNfd2OikLk
 2OUlUm/zPH55RKt0xQxmxZUdUl5QfDLc/2JBS1sXfZM7L9qglTmwyWmIH6i6D3jkidnK
 LhAJC2nkxkv/Zpf8znncE3jvyWZj7IaKX3GQ82VK58CV9C7xfVclLq7KlVIXE5CYf0bk
 TFxDmNUH1qQtbcwfu1aLdDXLs8GbUWyocNfUKcPyB78vhBBF13ueFPEaOY4m9A5dWC8a
 9mIg==
X-Gm-Message-State: AC+VfDwIyHvtYjSHuxLX3IUE/DQhwQ8Rv8Qh2/sbA8jLMoTeVSCbJpP0
 J7Ppl/4pe4lBw/q5CJqEwoN6nDomPIEnV6CtVWY4yq+2+HBBVGNnTAS53kRUk+AZnjiOiKrCWRQ
 rWMiIxdGlLvze+itQs1PMmNxWU5B1Yel5OWjtsp9XOcrqwvK1/aMO0mfU/pTdDJURbmKx44jGQD
 E=
X-Received: by 2002:a7b:cc13:0:b0:3f3:468d:d017 with SMTP id
 f19-20020a7bcc13000000b003f3468dd017mr32474314wmh.6.1684345602319; 
 Wed, 17 May 2023 10:46:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6RVTbLOCOEFttyRA9a3uecsVTYnmbLXc5TZOCfb3ED6Tg1g2OEIl4YGyCd7GE1IwYKmGkMMQ==
X-Received: by 2002:a7b:cc13:0:b0:3f3:468d:d017 with SMTP id
 f19-20020a7bcc13000000b003f3468dd017mr32474304wmh.6.1684345601749; 
 Wed, 17 May 2023 10:46:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a7bcc15000000b003f31d44f0cbsm2878899wmh.29.2023.05.17.10.46.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 48/68] meson: remove static_kwargs
Date: Wed, 17 May 2023 19:45:00 +0200
Message-Id: <20230517174520.887405-49-pbonzini@redhat.com>
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

After static_kwargs has been changed to an empty dictionary, it has
no functional effect and can be removed.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build     | 215 +++++++++++++++++++-----------------------------
 tcg/meson.build |   2 +-
 2 files changed, 85 insertions(+), 132 deletions(-)

diff --git a/meson.build b/meson.build
index ac5bb903d2c6..132f309bdab2 100644
--- a/meson.build
+++ b/meson.build
@@ -18,7 +18,6 @@ targetos = host_machine.system()
 sh = find_program('sh')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 enable_modules = 'CONFIG_MODULES' in config_host
-static_kwargs = {}
 
 cc = meson.get_compiler('c')
 all_languages = ['c']
@@ -515,7 +514,7 @@ gdbus_codegen = not_found
 gdbus_codegen_error = '@0@ requires gdbus-codegen, please install libgio'
 if not get_option('gio').auto() or have_system
   gio = dependency('gio-2.0', required: get_option('gio'),
-                   method: 'pkg-config', kwargs: static_kwargs)
+                   method: 'pkg-config')
   if gio.found() and not cc.links('''
     #include <gio/gio.h>
     int main(void)
@@ -532,7 +531,7 @@ if not get_option('gio').auto() or have_system
     gdbus_codegen = find_program(gio.get_variable('gdbus_codegen'),
                                  required: get_option('gio'))
     gio_unix = dependency('gio-unix-2.0', required: get_option('gio'),
-                          method: 'pkg-config', kwargs: static_kwargs)
+                          method: 'pkg-config')
     gio = declare_dependency(dependencies: [gio, gio_unix],
                              version: gio.version())
   endif
@@ -545,20 +544,19 @@ endif
 lttng = not_found
 if 'ust' in get_option('trace_backends')
   lttng = dependency('lttng-ust', required: true, version: '>= 2.1',
-                     method: 'pkg-config', kwargs: static_kwargs)
+                     method: 'pkg-config')
 endif
 pixman = not_found
 if have_system or have_tools
   pixman = dependency('pixman-1', required: have_system, version:'>=0.21.8',
-                      method: 'pkg-config', kwargs: static_kwargs)
+                      method: 'pkg-config')
 endif
-zlib = dependency('zlib', required: true, kwargs: static_kwargs)
+zlib = dependency('zlib', required: true)
 
 libaio = not_found
 if not get_option('linux_aio').auto() or have_block
   libaio = cc.find_library('aio', has_headers: ['libaio.h'],
-                           required: get_option('linux_aio'),
-                           kwargs: static_kwargs)
+                           required: get_option('linux_aio'))
 endif
 
 linux_io_uring_test = '''
@@ -571,7 +569,7 @@ linux_io_uring = not_found
 if not get_option('linux_io_uring').auto() or have_block
   linux_io_uring = dependency('liburing', version: '>=0.3',
                               required: get_option('linux_io_uring'),
-                              method: 'pkg-config', kwargs: static_kwargs)
+                              method: 'pkg-config')
   if not cc.links(linux_io_uring_test)
     linux_io_uring = not_found
   endif
@@ -581,7 +579,7 @@ libnfs = not_found
 if not get_option('libnfs').auto() or have_block
   libnfs = dependency('libnfs', version: '>=1.9.3',
                       required: get_option('libnfs'),
-                      method: 'pkg-config', kwargs: static_kwargs)
+                      method: 'pkg-config')
 endif
 
 libattr_test = '''
@@ -601,8 +599,7 @@ if get_option('attr').allowed()
     libattr = declare_dependency()
   else
     libattr = cc.find_library('attr', has_headers: ['attr/xattr.h'],
-                              required: get_option('attr'),
-                              kwargs: static_kwargs)
+                              required: get_option('attr'))
     if libattr.found() and not \
       cc.links(libattr_test, dependencies: libattr, args: '-DCONFIG_LIBATTR')
       libattr = not_found
@@ -637,7 +634,7 @@ seccomp_has_sysrawrc = false
 if not get_option('seccomp').auto() or have_system or have_tools
   seccomp = dependency('libseccomp', version: '>=2.3.0',
                        required: get_option('seccomp'),
-                       method: 'pkg-config', kwargs: static_kwargs)
+                       method: 'pkg-config')
   if seccomp.found()
     seccomp_has_sysrawrc = cc.has_header_symbol('seccomp.h',
                                                 'SCMP_FLTATR_API_SYSRAWRC',
@@ -648,8 +645,7 @@ endif
 libcap_ng = not_found
 if not get_option('cap_ng').auto() or have_system or have_tools
   libcap_ng = cc.find_library('cap-ng', has_headers: ['cap-ng.h'],
-                              required: get_option('cap_ng'),
-                              kwargs: static_kwargs)
+                              required: get_option('cap_ng'))
 endif
 if libcap_ng.found() and not cc.links('''
    #include <cap-ng.h>
@@ -670,13 +666,13 @@ if get_option('xkbcommon').auto() and not have_system and not have_tools
   xkbcommon = not_found
 else
   xkbcommon = dependency('xkbcommon', required: get_option('xkbcommon'),
-                         method: 'pkg-config', kwargs: static_kwargs)
+                         method: 'pkg-config')
 endif
 
 slirp = not_found
 if not get_option('slirp').auto() or have_system
   slirp = dependency('slirp', required: get_option('slirp'),
-                     method: 'pkg-config', kwargs: static_kwargs)
+                     method: 'pkg-config')
   # slirp < 4.7 is incompatible with CFI support in QEMU.  This is because
   # it passes function pointers within libslirp as callbacks for timers.
   # When using a system-wide shared libslirp, the type information for the
@@ -696,8 +692,7 @@ endif
 vde = not_found
 if not get_option('vde').auto() or have_system or have_tools
   vde = cc.find_library('vdeplug', has_headers: ['libvdeplug.h'],
-                           required: get_option('vde'),
-                           kwargs: static_kwargs)
+                           required: get_option('vde'))
 endif
 if vde.found() and not cc.links('''
    #include <libvdeplug.h>
@@ -719,41 +714,41 @@ endif
 pulse = not_found
 if not get_option('pa').auto() or (targetos == 'linux' and have_system)
   pulse = dependency('libpulse', required: get_option('pa'),
-                     method: 'pkg-config', kwargs: static_kwargs)
+                     method: 'pkg-config')
 endif
 alsa = not_found
 if not get_option('alsa').auto() or (targetos == 'linux' and have_system)
   alsa = dependency('alsa', required: get_option('alsa'),
-                    method: 'pkg-config', kwargs: static_kwargs)
+                    method: 'pkg-config')
 endif
 jack = not_found
 if not get_option('jack').auto() or have_system
   jack = dependency('jack', required: get_option('jack'),
-                    method: 'pkg-config', kwargs: static_kwargs)
+                    method: 'pkg-config')
 endif
 pipewire = not_found
 if not get_option('pipewire').auto() or (targetos == 'linux' and have_system)
   pipewire = dependency('libpipewire-0.3', version: '>=0.3.60',
                     required: get_option('pipewire'),
-                    method: 'pkg-config', kwargs: static_kwargs)
+                    method: 'pkg-config')
 endif
 sndio = not_found
 if not get_option('sndio').auto() or have_system
   sndio = dependency('sndio', required: get_option('sndio'),
-                    method: 'pkg-config', kwargs: static_kwargs)
+                    method: 'pkg-config')
 endif
 
 spice_protocol = not_found
 if not get_option('spice_protocol').auto() or have_system
   spice_protocol = dependency('spice-protocol', version: '>=0.14.0',
                               required: get_option('spice_protocol'),
-                              method: 'pkg-config', kwargs: static_kwargs)
+                              method: 'pkg-config')
 endif
 spice = not_found
 if not get_option('spice').auto() or have_system
   spice = dependency('spice-server', version: '>=0.14.0',
                      required: get_option('spice'),
-                     method: 'pkg-config', kwargs: static_kwargs)
+                     method: 'pkg-config')
 endif
 spice_headers = spice.partial_dependency(compile_args: true, includes: true)
 
@@ -763,13 +758,13 @@ libiscsi = not_found
 if not get_option('libiscsi').auto() or have_block
   libiscsi = dependency('libiscsi', version: '>=1.9.0',
                          required: get_option('libiscsi'),
-                         method: 'pkg-config', kwargs: static_kwargs)
+                         method: 'pkg-config')
 endif
 zstd = not_found
 if not get_option('zstd').auto() or have_block
   zstd = dependency('libzstd', version: '>=1.4.0',
                     required: get_option('zstd'),
-                    method: 'pkg-config', kwargs: static_kwargs)
+                    method: 'pkg-config')
 endif
 virgl = not_found
 
@@ -777,29 +772,25 @@ have_vhost_user_gpu = have_tools and targetos == 'linux' and pixman.found()
 if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
                      method: 'pkg-config',
-                     required: get_option('virglrenderer'),
-                     kwargs: static_kwargs)
+                     required: get_option('virglrenderer'))
 endif
 blkio = not_found
 if not get_option('blkio').auto() or have_block
   blkio = dependency('blkio',
                      method: 'pkg-config',
-                     required: get_option('blkio'),
-                     kwargs: static_kwargs)
+                     required: get_option('blkio'))
 endif
 curl = not_found
 if not get_option('curl').auto() or have_block
   curl = dependency('libcurl', version: '>=7.29.0',
                     method: 'pkg-config',
-                    required: get_option('curl'),
-                    kwargs: static_kwargs)
+                    required: get_option('curl'))
 endif
 libudev = not_found
 if targetos == 'linux' and (have_system or have_tools)
   libudev = dependency('libudev',
                        method: 'pkg-config',
-                       required: get_option('libudev'),
-                       kwargs: static_kwargs)
+                       required: get_option('libudev'))
 endif
 
 mpathlibs = [libudev]
@@ -834,18 +825,15 @@ if targetos == 'linux' and have_tools and get_option('mpath').allowed()
           return 0;
       }'''
   libmpathpersist = cc.find_library('mpathpersist',
-                                    required: get_option('mpath'),
-                                    kwargs: static_kwargs)
+                                    required: get_option('mpath'))
   if libmpathpersist.found()
     mpathlibs += libmpathpersist
     if get_option('prefer_static')
       mpathlibs += cc.find_library('devmapper',
-                                     required: get_option('mpath'),
-                                     kwargs: static_kwargs)
+                                     required: get_option('mpath'))
     endif
     mpathlibs += cc.find_library('multipath',
-                                 required: get_option('mpath'),
-                                 kwargs: static_kwargs)
+                                 required: get_option('mpath'))
     foreach lib: mpathlibs
       if not lib.found()
         mpathlibs = []
@@ -895,8 +883,7 @@ if have_system and get_option('curses').allowed()
   curses_dep_list = targetos == 'windows' ? ['ncurses', 'ncursesw'] : ['ncursesw']
   curses = dependency(curses_dep_list,
                       required: false,
-                      method: 'pkg-config',
-                      kwargs: static_kwargs)
+                      method: 'pkg-config')
   msg = get_option('curses').enabled() ? 'curses library not found' : ''
   curses_compile_args = ['-DNCURSES_WIDECHAR=1']
   if curses.found()
@@ -918,8 +905,7 @@ if have_system and get_option('curses').allowed()
       curses_libname_list = (targetos == 'windows' ? ['pdcurses'] : ['ncursesw', 'cursesw'])
       foreach curses_libname : curses_libname_list
         libcurses = cc.find_library(curses_libname,
-                                    required: false,
-                                    kwargs: static_kwargs)
+                                    required: false)
         if libcurses.found()
           if cc.links(curses_test, args: curses_compile_args, dependencies: libcurses)
             curses = declare_dependency(compile_args: curses_compile_args,
@@ -969,8 +955,7 @@ endif
 brlapi = not_found
 if not get_option('brlapi').auto() or have_system
   brlapi = cc.find_library('brlapi', has_headers: ['brlapi.h'],
-                         required: get_option('brlapi'),
-                         kwargs: static_kwargs)
+                         required: get_option('brlapi'))
   if brlapi.found() and not cc.links('''
      #include <brlapi.h>
      #include <stddef.h>
@@ -986,7 +971,7 @@ endif
 
 sdl = not_found
 if not get_option('sdl').auto() or have_system
-  sdl = dependency('sdl2', required: get_option('sdl'), kwargs: static_kwargs)
+  sdl = dependency('sdl2', required: get_option('sdl'))
   sdl_image = not_found
 endif
 if sdl.found()
@@ -994,7 +979,7 @@ if sdl.found()
   sdl = declare_dependency(compile_args: '-Wno-undef',
                            dependencies: sdl)
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
-                         method: 'pkg-config', kwargs: static_kwargs)
+                         method: 'pkg-config')
 else
   if get_option('sdl_image').enabled()
     error('sdl-image required, but SDL was @0@'.format(
@@ -1005,11 +990,9 @@ endif
 
 rbd = not_found
 if not get_option('rbd').auto() or have_block
-  librados = cc.find_library('rados', required: get_option('rbd'),
-                             kwargs: static_kwargs)
+  librados = cc.find_library('rados', required: get_option('rbd'))
   librbd = cc.find_library('rbd', has_headers: ['rbd/librbd.h'],
-                           required: get_option('rbd'),
-                           kwargs: static_kwargs)
+                           required: get_option('rbd'))
   if librados.found() and librbd.found()
     if cc.links('''
       #include <stdio.h>
@@ -1037,7 +1020,7 @@ glusterfs_iocb_has_stat = false
 if not get_option('glusterfs').auto() or have_block
   glusterfs = dependency('glusterfs-api', version: '>=3',
                          required: get_option('glusterfs'),
-                         method: 'pkg-config', kwargs: static_kwargs)
+                         method: 'pkg-config')
   if glusterfs.found()
     glusterfs_ftruncate_has_stat = cc.links('''
       #include <glusterfs/api/glfs.h>
@@ -1072,15 +1055,13 @@ libssh = not_found
 if not get_option('libssh').auto() or have_block
   libssh = dependency('libssh', version: '>=0.8.7',
                     method: 'pkg-config',
-                    required: get_option('libssh'),
-                    kwargs: static_kwargs)
+                    required: get_option('libssh'))
 endif
 
 libbzip2 = not_found
 if not get_option('bzip2').auto() or have_block
   libbzip2 = cc.find_library('bz2', has_headers: ['bzlib.h'],
-                             required: get_option('bzip2'),
-                             kwargs: static_kwargs)
+                             required: get_option('bzip2'))
   if libbzip2.found() and not cc.links('''
      #include <bzlib.h>
      int main(void) { BZ2_bzlibVersion(); return 0; }''', dependencies: libbzip2)
@@ -1096,8 +1077,7 @@ endif
 liblzfse = not_found
 if not get_option('lzfse').auto() or have_block
   liblzfse = cc.find_library('lzfse', has_headers: ['lzfse.h'],
-                             required: get_option('lzfse'),
-                             kwargs: static_kwargs)
+                             required: get_option('lzfse'))
 endif
 if liblzfse.found() and not cc.links('''
    #include <lzfse.h>
@@ -1115,8 +1095,7 @@ if get_option('oss').allowed() and have_system
   if not cc.has_header('sys/soundcard.h')
     # not found
   elif targetos == 'netbsd'
-    oss = cc.find_library('ossaudio', required: get_option('oss'),
-                          kwargs: static_kwargs)
+    oss = cc.find_library('ossaudio', required: get_option('oss'))
   else
     oss = declare_dependency()
   endif
@@ -1149,7 +1128,7 @@ endif
 opengl = not_found
 if not get_option('opengl').auto() or have_system or have_vhost_user_gpu
   epoxy = dependency('epoxy', method: 'pkg-config',
-                      required: get_option('opengl'), kwargs: static_kwargs)
+                      required: get_option('opengl'))
   if cc.has_header('epoxy/egl.h', dependencies: epoxy)
     opengl = epoxy
   elif get_option('opengl').enabled()
@@ -1158,8 +1137,7 @@ if not get_option('opengl').auto() or have_system or have_vhost_user_gpu
 endif
 gbm = not_found
 if (have_system or have_tools) and (virgl.found() or opengl.found())
-  gbm = dependency('gbm', method: 'pkg-config', required: false,
-                   kwargs: static_kwargs)
+  gbm = dependency('gbm', method: 'pkg-config', required: false)
 endif
 have_vhost_user_gpu = have_vhost_user_gpu and virgl.found() and opengl.found() and gbm.found()
 
@@ -1181,16 +1159,14 @@ if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_syste
   # the platform support requirements
   gnutls_crypto = dependency('gnutls', version: '>=3.6.14',
                              method: 'pkg-config',
-                             required: false,
-                             kwargs: static_kwargs)
+                             required: false)
   if gnutls_crypto.found()
     gnutls = gnutls_crypto
   else
     # Our min version if all we need is TLS
     gnutls = dependency('gnutls', version: '>=3.5.18',
                         method: 'pkg-config',
-                        required: get_option('gnutls'),
-                        kwargs: static_kwargs)
+                        required: get_option('gnutls'))
   endif
 endif
 
@@ -1217,34 +1193,31 @@ if not gnutls_crypto.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.8',
                         method: 'config-tool',
-                        required: get_option('gcrypt'),
-                        kwargs: static_kwargs)
+                        required: get_option('gcrypt'))
     # Debian has removed -lgpg-error from libgcrypt-config
     # as it "spreads unnecessary dependencies" which in
     # turn breaks static builds...
     if gcrypt.found() and get_option('prefer_static')
       gcrypt = declare_dependency(dependencies: [
         gcrypt,
-        cc.find_library('gpg-error', required: true, kwargs: static_kwargs)])
+        cc.find_library('gpg-error', required: true)])
     endif
   endif
   if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
     nettle = dependency('nettle', version: '>=3.4',
                         method: 'pkg-config',
-                        required: get_option('nettle'),
-                        kwargs: static_kwargs)
+                        required: get_option('nettle'))
     if nettle.found() and not cc.has_header('nettle/xts.h', dependencies: nettle)
       xts = 'private'
     endif
   endif
 endif
 
-gmp = dependency('gmp', required: false, method: 'pkg-config', kwargs: static_kwargs)
+gmp = dependency('gmp', required: false, method: 'pkg-config')
 if nettle.found() and gmp.found()
   hogweed = dependency('hogweed', version: '>=3.4',
                        method: 'pkg-config',
-                       required: get_option('nettle'),
-                       kwargs: static_kwargs)
+                       required: get_option('nettle'))
 endif
 
 
@@ -1256,20 +1229,17 @@ have_gtk_clipboard = get_option('gtk_clipboard').enabled()
 if not get_option('gtk').auto() or have_system
   gtk = dependency('gtk+-3.0', version: '>=3.22.0',
                    method: 'pkg-config',
-                   required: get_option('gtk'),
-                   kwargs: static_kwargs)
+                   required: get_option('gtk'))
   if gtk.found()
     gtkx11 = dependency('gtk+-x11-3.0', version: '>=3.22.0',
                         method: 'pkg-config',
-                        required: false,
-                        kwargs: static_kwargs)
+                        required: false)
     gtk = declare_dependency(dependencies: [gtk, gtkx11])
 
     if not get_option('vte').auto() or have_system
       vte = dependency('vte-2.91',
                        method: 'pkg-config',
-                       required: get_option('vte'),
-                       kwargs: static_kwargs)
+                       required: get_option('vte'))
     endif
   elif have_gtk_clipboard
     error('GTK clipboard requested, but GTK not found')
@@ -1278,13 +1248,12 @@ endif
 
 x11 = not_found
 if gtkx11.found()
-  x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found(),
-                   kwargs: static_kwargs)
+  x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
 endif
 png = not_found
 if get_option('png').allowed() and have_system
    png = dependency('libpng', version: '>=1.6.34', required: get_option('png'),
-                    method: 'pkg-config', kwargs: static_kwargs)
+                    method: 'pkg-config')
 endif
 vnc = not_found
 jpeg = not_found
@@ -1292,10 +1261,9 @@ sasl = not_found
 if get_option('vnc').allowed() and have_system
   vnc = declare_dependency() # dummy dependency
   jpeg = dependency('libjpeg', required: get_option('vnc_jpeg'),
-                    method: 'pkg-config', kwargs: static_kwargs)
+                    method: 'pkg-config')
   sasl = cc.find_library('sasl2', has_headers: ['sasl/sasl.h'],
-                         required: get_option('vnc_sasl'),
-                         kwargs: static_kwargs)
+                         required: get_option('vnc_sasl'))
   if sasl.found()
     sasl = declare_dependency(dependencies: sasl,
                               compile_args: '-DSTRUCT_IOVEC_DEFINED')
@@ -1305,8 +1273,7 @@ endif
 pam = not_found
 if not get_option('auth_pam').auto() or have_system
   pam = cc.find_library('pam', has_headers: ['security/pam_appl.h'],
-                        required: get_option('auth_pam'),
-                        kwargs: static_kwargs)
+                        required: get_option('auth_pam'))
 endif
 if pam.found() and not cc.links('''
    #include <stddef.h>
@@ -1330,8 +1297,7 @@ endif
 snappy = not_found
 if not get_option('snappy').auto() or have_system
   snappy = cc.find_library('snappy', has_headers: ['snappy-c.h'],
-                           required: get_option('snappy'),
-                           kwargs: static_kwargs)
+                           required: get_option('snappy'))
 endif
 if snappy.found() and not linker.links('''
    #include <snappy-c.h>
@@ -1347,8 +1313,7 @@ endif
 lzo = not_found
 if not get_option('lzo').auto() or have_system
   lzo = cc.find_library('lzo2', has_headers: ['lzo/lzo1x.h'],
-                        required: get_option('lzo'),
-                        kwargs: static_kwargs)
+                        required: get_option('lzo'))
 endif
 if lzo.found() and not cc.links('''
    #include <lzo/lzo1x.h>
@@ -1364,8 +1329,7 @@ endif
 numa = not_found
 if not get_option('numa').auto() or have_system or have_tools
   numa = cc.find_library('numa', has_headers: ['numa.h'],
-                              required: get_option('numa'),
-                              kwargs: static_kwargs)
+                              required: get_option('numa'))
 endif
 if numa.found() and not cc.links('''
    #include <numa.h>
@@ -1383,10 +1347,8 @@ rdma = not_found
 if not get_option('rdma').auto() or have_system
   libumad = cc.find_library('ibumad', required: get_option('rdma'))
   rdma_libs = [cc.find_library('rdmacm', has_headers: ['rdma/rdma_cma.h'],
-                               required: get_option('rdma'),
-                               kwargs: static_kwargs),
-               cc.find_library('ibverbs', required: get_option('rdma'),
-                               kwargs: static_kwargs),
+                               required: get_option('rdma')),
+               cc.find_library('ibverbs', required: get_option('rdma')),
                libumad]
   rdma = declare_dependency(dependencies: rdma_libs)
   foreach lib: rdma_libs
@@ -1399,30 +1361,30 @@ endif
 xen = not_found
 if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
   xencontrol = dependency('xencontrol', required: false,
-                          method: 'pkg-config', kwargs: static_kwargs)
+                          method: 'pkg-config')
   if xencontrol.found()
     xen_pc = declare_dependency(version: xencontrol.version(),
       dependencies: [
         xencontrol,
         # disabler: true makes xen_pc.found() return false if any is not found
         dependency('xenstore', required: false,
-                   method: 'pkg-config', kwargs: static_kwargs,
+                   method: 'pkg-config',
                    disabler: true),
         dependency('xenforeignmemory', required: false,
-                   method: 'pkg-config', kwargs: static_kwargs,
+                   method: 'pkg-config',
                    disabler: true),
         dependency('xengnttab', required: false,
-                   method: 'pkg-config', kwargs: static_kwargs,
+                   method: 'pkg-config',
                    disabler: true),
         dependency('xenevtchn', required: false,
-                   method: 'pkg-config', kwargs: static_kwargs,
+                   method: 'pkg-config',
                    disabler: true),
         dependency('xendevicemodel', required: false,
-                   method: 'pkg-config', kwargs: static_kwargs,
+                   method: 'pkg-config',
                    disabler: true),
         # optional, no "disabler: true"
         dependency('xentoolcore', required: false,
-                   method: 'pkg-config', kwargs: static_kwargs)])
+                   method: 'pkg-config')])
     if xen_pc.found()
       xen = xen_pc
     endif
@@ -1480,60 +1442,53 @@ have_xen_pci_passthrough = get_option('xen_pci_passthrough') \
 cacard = not_found
 if not get_option('smartcard').auto() or have_system
   cacard = dependency('libcacard', required: get_option('smartcard'),
-                      version: '>=2.5.1', method: 'pkg-config',
-                      kwargs: static_kwargs)
+                      version: '>=2.5.1', method: 'pkg-config')
 endif
 u2f = not_found
 if have_system
   u2f = dependency('u2f-emu', required: get_option('u2f'),
-                   method: 'pkg-config',
-                   kwargs: static_kwargs)
+                   method: 'pkg-config')
 endif
 canokey = not_found
 if have_system
   canokey = dependency('canokey-qemu', required: get_option('canokey'),
-                   method: 'pkg-config',
-                   kwargs: static_kwargs)
+                   method: 'pkg-config')
 endif
 usbredir = not_found
 if not get_option('usb_redir').auto() or have_system
   usbredir = dependency('libusbredirparser-0.5', required: get_option('usb_redir'),
-                        version: '>=0.6', method: 'pkg-config',
-                        kwargs: static_kwargs)
+                        version: '>=0.6', method: 'pkg-config')
 endif
 libusb = not_found
 if not get_option('libusb').auto() or have_system
   libusb = dependency('libusb-1.0', required: get_option('libusb'),
-                      version: '>=1.0.13', method: 'pkg-config',
-                      kwargs: static_kwargs)
+                      version: '>=1.0.13', method: 'pkg-config')
 endif
 
 libpmem = not_found
 if not get_option('libpmem').auto() or have_system
   libpmem = dependency('libpmem', required: get_option('libpmem'),
-                       method: 'pkg-config', kwargs: static_kwargs)
+                       method: 'pkg-config')
 endif
 libdaxctl = not_found
 if not get_option('libdaxctl').auto() or have_system
   libdaxctl = dependency('libdaxctl', required: get_option('libdaxctl'),
-                         version: '>=57', method: 'pkg-config',
-                         kwargs: static_kwargs)
+                         version: '>=57', method: 'pkg-config')
 endif
 tasn1 = not_found
 if gnutls.found()
   tasn1 = dependency('libtasn1',
-                     method: 'pkg-config',
-                     kwargs: static_kwargs)
+                     method: 'pkg-config')
 endif
 keyutils = dependency('libkeyutils', required: false,
-                      method: 'pkg-config', kwargs: static_kwargs)
+                      method: 'pkg-config')
 
 has_gettid = cc.has_function('gettid')
 
 # libselinux
 selinux = dependency('libselinux',
                      required: get_option('selinux'),
-                     method: 'pkg-config', kwargs: static_kwargs)
+                     method: 'pkg-config')
 
 # Malloc tests
 
@@ -1597,8 +1552,7 @@ if get_option('fuse').disabled() and get_option('fuse_lseek').enabled()
 endif
 
 fuse = dependency('fuse3', required: get_option('fuse'),
-                  version: '>=3.1', method: 'pkg-config',
-                  kwargs: static_kwargs)
+                  version: '>=3.1', method: 'pkg-config')
 
 fuse_lseek = not_found
 if get_option('fuse_lseek').allowed()
@@ -1657,7 +1611,6 @@ if not get_option('libdw').auto() or \
         (not get_option('prefer_static') and (have_system or have_user))
     libdw = dependency('libdw',
                        method: 'pkg-config',
-                       kwargs: static_kwargs,
                        required: get_option('libdw'))
 endif
 
@@ -2737,7 +2690,7 @@ genh += custom_target('config-poison.h',
 capstone = not_found
 if not get_option('capstone').auto() or have_system or have_user
   capstone = dependency('capstone', version: '>=3.0.5',
-                        kwargs: static_kwargs, method: 'pkg-config',
+                        method: 'pkg-config',
                         required: get_option('capstone'))
 
   # Some versions of capstone have broken pkg-config file
@@ -2773,7 +2726,7 @@ if have_system
   fdt_opt = get_option('fdt')
   if fdt_opt in ['enabled', 'auto', 'system']
     have_internal = fs.exists(meson.current_source_dir() / 'dtc/libfdt/Makefile.libfdt')
-    fdt = cc.find_library('fdt', kwargs: static_kwargs,
+    fdt = cc.find_library('fdt',
                           required: fdt_opt == 'system' or
                                     fdt_opt == 'enabled' and not have_internal)
     if fdt.found() and cc.links('''
diff --git a/tcg/meson.build b/tcg/meson.build
index c4c63b19d4ed..3db551bb3485 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -12,7 +12,7 @@ tcg_ss.add(files(
 
 if get_option('tcg_interpreter')
   libffi = dependency('libffi', version: '>=3.0', required: true,
-                      method: 'pkg-config', kwargs: static_kwargs)
+                      method: 'pkg-config')
   specific_ss.add(libffi)
   specific_ss.add(files('tci.c'))
 endif
-- 
2.40.1


