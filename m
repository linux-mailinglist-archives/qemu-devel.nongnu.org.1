Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F97495EA
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 08:48:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHImV-0002wk-6t; Thu, 06 Jul 2023 02:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHImS-0002vS-FG
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHImI-0006Iu-HA
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 02:47:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688626064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=knR2Zl7sNk3VPK6kUw94mrtfkTKD67SHQgHrF5OeY7I=;
 b=YISyqTyHExlkKitvppgP/ki+HFtDvsNTQybWWIhL/surHNezP/wyeTkexihrrGhJcgMVjx
 qdLI+tTML7H73wYLc3gpRI2cJd18sdSK0E1HDLN1b9haKoiYkME62RTZB4pCqkvBMN+FB6
 9/mMQLYLWddDRSPE5sd7gfMhaVoYHNc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-xoceFd25MwyN8ct98EIzuQ-1; Thu, 06 Jul 2023 02:47:41 -0400
X-MC-Unique: xoceFd25MwyN8ct98EIzuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA6963814956;
 Thu,  6 Jul 2023 06:47:40 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.34])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B24C02166B25;
 Thu,  6 Jul 2023 06:47:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] meson.build: Remove the logic to link C code with the C++
 linker
Date: Thu,  6 Jul 2023 08:47:36 +0200
Message-Id: <20230706064736.178962-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We are not mixing C++ with C code anymore, the only remaining
C++ code in qga/vss-win32/ is used for a plain C++ executable.
Thus we can remove the hacks for linking C code with the C++ linker
now to simplify meson.build a little bit, and also to avoid that
some C++ code sneaks in by accident again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build     | 24 ++++++------------------
 scripts/main.c  |  1 -
 qga/meson.build |  2 +-
 3 files changed, 7 insertions(+), 20 deletions(-)
 delete mode 100644 scripts/main.c

diff --git a/meson.build b/meson.build
index 5559b36859..620457bb95 100644
--- a/meson.build
+++ b/meson.build
@@ -473,19 +473,10 @@ if targetos != 'darwin'
   warn_flags += ['-Wthread-safety']
 endif
 
-# Check that the C++ compiler exists and works with the C compiler.
-link_language = 'c'
-linker = cc
+# Set up C++ compiler flags
 qemu_cxxflags = []
 if 'cpp' in all_languages
   qemu_cxxflags = ['-D__STDC_LIMIT_MACROS', '-D__STDC_CONSTANT_MACROS', '-D__STDC_FORMAT_MACROS'] + qemu_cflags
-  if cxx.links(files('scripts/main.c'), args: qemu_cflags)
-    link_language = 'cpp'
-    linker = cxx
-  else
-    message('C++ compiler does not work with C compiler')
-    message('Disabling C++-specific optional code')
-  endif
 endif
 
 # clang does not support glibc + FORTIFY_SOURCE (is it still true?)
@@ -1600,7 +1591,7 @@ if not get_option('snappy').auto() or have_system
   snappy = cc.find_library('snappy', has_headers: ['snappy-c.h'],
                            required: get_option('snappy'))
 endif
-if snappy.found() and not linker.links('''
+if snappy.found() and not cc.links('''
    #include <snappy-c.h>
    int main(void) { snappy_max_compressed_length(4096); return 0; }''', dependencies: snappy)
   snappy = not_found
@@ -2746,7 +2737,7 @@ config_host_data.set('CONFIG_AF_VSOCK', cc.has_header_symbol(
 
 have_vss = false
 have_vss_sdk = false # old xp/2003 SDK
-if targetos == 'windows' and link_language == 'cpp'
+if targetos == 'windows' and 'cpp' in all_languages
   have_vss = cxx.compiles('''
     #define __MIDL_user_allocate_free_DEFINED__
     #include <vss.h>
@@ -3827,7 +3818,6 @@ foreach target : target_dirs
                c_args: c_args,
                dependencies: arch_deps + deps + exe['dependencies'],
                objects: lib.extract_all_objects(recursive: true),
-               link_language: link_language,
                link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
                link_args: link_args,
                win_subsystem: exe['win_subsystem'])
@@ -4061,10 +4051,8 @@ summary_info += {'host CPU':          cpu}
 summary_info += {'host endianness':   build_machine.endian()}
 summary_info += {'C compiler':        ' '.join(meson.get_compiler('c').cmd_array())}
 summary_info += {'Host C compiler':   ' '.join(meson.get_compiler('c', native: true).cmd_array())}
-if link_language == 'cpp'
+if 'cpp' in all_languages
   summary_info += {'C++ compiler':    ' '.join(meson.get_compiler('cpp').cmd_array())}
-else
-  summary_info += {'C++ compiler':      false}
 endif
 if targetos == 'darwin'
   summary_info += {'Objective-C compiler': ' '.join(meson.get_compiler('objc').cmd_array())}
@@ -4074,13 +4062,13 @@ if get_option('optimization') != 'plain'
   option_cflags += ['-O' + get_option('optimization')]
 endif
 summary_info += {'CFLAGS':            ' '.join(get_option('c_args') + option_cflags)}
-if link_language == 'cpp'
+if 'cpp' in all_languages
   summary_info += {'CXXFLAGS':        ' '.join(get_option('cpp_args') + option_cflags)}
 endif
 if targetos == 'darwin'
   summary_info += {'OBJCFLAGS':       ' '.join(get_option('objc_args') + option_cflags)}
 endif
-link_args = get_option(link_language + '_link_args')
+link_args = get_option('c_link_args')
 if link_args.length() > 0
   summary_info += {'LDFLAGS':         ' '.join(link_args)}
 endif
diff --git a/scripts/main.c b/scripts/main.c
deleted file mode 100644
index b552c8e4ed..0000000000
--- a/scripts/main.c
+++ /dev/null
@@ -1 +0,0 @@
-int main(void) {}
diff --git a/qga/meson.build b/qga/meson.build
index d3291b4376..dd18092f56 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -9,7 +9,7 @@ endif
 have_qga_vss = get_option('qga_vss') \
   .require(targetos == 'windows',
            error_message: 'VSS support requires Windows') \
-  .require(link_language == 'cpp',
+  .require('cpp' in all_languages,
            error_message: 'VSS support requires a C++ compiler') \
   .require(have_vss, error_message: '''VSS support requires VSS headers.
     If your Visual Studio installation doesn't have the VSS headers,
-- 
2.39.3


