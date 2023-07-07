Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7EA74B2A8
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4n-0007By-Be; Fri, 07 Jul 2023 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4h-0007Az-HB
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4f-0006MT-QH
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0z06+ySLDI//4HgzANh/bhuBzMpaxFijzGez2Mql6tw=;
 b=fgEPqIImkghvwu3kNeTZiXM2VXGYOUGGkZ+uxEB2o0loF0Vloat8s9sgLeXI9Ggw3k019j
 FhiUBiGV7is7p5T4OkJGinRCYnVEAGd5aIxdFsmq/4lvyFcycxXqbciZbQmrWwi+pVKhCK
 yYjl/ZsZGUM3Llq6cqe8D5UZj1WQ7Mk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-1halClEQN1i77WvsJftSNQ-1; Fri, 07 Jul 2023 10:04:39 -0400
X-MC-Unique: 1halClEQN1i77WvsJftSNQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9879d2fc970so134962166b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738677; x=1691330677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0z06+ySLDI//4HgzANh/bhuBzMpaxFijzGez2Mql6tw=;
 b=CtW+noTkM5MhZdCfV/5zOkG8AierA/moyTfy/vmhng5VmSNC1vmEf0OogH5KpwSGMH
 CFQiudfSeW/nC2MK4aKKsptfu1crYls6oWAPVKRvUegh/iYIkvDAKRI+UmPr6eGNANz1
 hlAx9/NLSWaEhiZ7dWwvJHoz63DN+joUsy5cJamwKWX1uvm/onxUkDCgk7/V+qEvw1rO
 TIQ8e2nHUtnRfkIn43ZL0hA6vZl7r4GcNZTA/a05hJT51XfEB8x5H+oHZoixD3R6aAMj
 OGZdVhzjFIRhNyXxr4KaTaqo/wC6xuN4HuAJBFQKiN881Dv2W7ISUjRy+JUCqnZiOyUk
 6bgQ==
X-Gm-Message-State: ABy/qLbCT536Fm8Iml4dXAF2vfoaNavniDAQBqCORtmasgG4K/QYd5rQ
 8zEpRd9/FqPTKyR/NIcNowsgrxZcilfPC9QsPF7AZhAWcv44JCHBNsn+7nF7M5TxsJ9p85YsRCP
 3G142NmcIwZMPaMGMo4FMupNT13Au886ecIVn5tON6QmTz2aE1YxAaqHobNhFTZyLOFs3A+0VIB
 k=
X-Received: by 2002:a17:906:72d9:b0:978:6e73:e837 with SMTP id
 m25-20020a17090672d900b009786e73e837mr4240538ejl.4.1688738677635; 
 Fri, 07 Jul 2023 07:04:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxogkQhm9tY2fwdcLLAnlh0YpZzg1kOwC5pfhkyyguwwPeNNK+q3xV3ejkXoDHMASSk4vyxg==
X-Received: by 2002:a17:906:72d9:b0:978:6e73:e837 with SMTP id
 m25-20020a17090672d900b009786e73e837mr4240515ejl.4.1688738677167; 
 Fri, 07 Jul 2023 07:04:37 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v1-20020a170906b00100b00993a9a951fasm2283403ejy.11.2023.07.07.07.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 2/9] meson.build: Remove the logic to link C code with the C++
 linker
Date: Fri,  7 Jul 2023 16:04:25 +0200
Message-ID: <20230707140432.88073-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707140432.88073-1-pbonzini@redhat.com>
References: <20230707140432.88073-1-pbonzini@redhat.com>
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

From: Thomas Huth <thuth@redhat.com>

We are not mixing C++ with C code anymore, the only remaining
C++ code in qga/vss-win32/ is used for a plain C++ executable.
Thus we can remove the hacks for linking C code with the C++ linker
now to simplify meson.build a little bit, and also to avoid that
some C++ code sneaks in by accident again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230706064736.178962-1-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build     | 22 ++++++----------------
 qga/meson.build |  2 +-
 scripts/main.c  |  1 -
 3 files changed, 7 insertions(+), 18 deletions(-)
 delete mode 100644 scripts/main.c

diff --git a/meson.build b/meson.build
index b82d5b7cd07..c77faa0b6e5 100644
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
@@ -4061,7 +4051,7 @@ summary_info += {'host CPU':          cpu}
 summary_info += {'host endianness':   build_machine.endian()}
 summary_info += {'C compiler':        ' '.join(meson.get_compiler('c').cmd_array())}
 summary_info += {'Host C compiler':   ' '.join(meson.get_compiler('c', native: true).cmd_array())}
-if link_language == 'cpp'
+if 'cpp' in all_languages
   summary_info += {'C++ compiler':    ' '.join(meson.get_compiler('cpp').cmd_array())}
 else
   summary_info += {'C++ compiler':      false}
@@ -4074,13 +4064,13 @@ if get_option('optimization') != 'plain'
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
diff --git a/qga/meson.build b/qga/meson.build
index d3291b4376c..dd18092f561 100644
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
diff --git a/scripts/main.c b/scripts/main.c
deleted file mode 100644
index b552c8e4ed7..00000000000
--- a/scripts/main.c
+++ /dev/null
@@ -1 +0,0 @@
-int main(void) {}
-- 
2.41.0


