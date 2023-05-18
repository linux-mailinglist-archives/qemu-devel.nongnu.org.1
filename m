Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 022187081B5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd1z-0000Oe-RE; Thu, 18 May 2023 08:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzd1y-0000Mg-Hn
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzd1w-00072c-OZ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684414012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJcJKyOnYM4Qh3B5SKwE+AzQB6XGKRVMOYp+JdJJUV8=;
 b=cWy4clKmE5WhE5IBfaV7qCJ1oAckQukHo5vpchcRAZDGz3ztoE8evBv3KYL15ArYOC9AVv
 rCTtPKXkDoTiJB5VAGb4Xy/7ZWVQoydzxwFX5HiSUQxx+3ZBmRmg+C7g6u6rYy740vYLC0
 7M+S7qOyvfuggVGLgL7IgcsKJQrfA6s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-nCa6etgINX-9jZ54aGEbhA-1; Thu, 18 May 2023 08:46:50 -0400
X-MC-Unique: nCa6etgINX-9jZ54aGEbhA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-969f24626fbso177505666b.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414009; x=1687006009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJcJKyOnYM4Qh3B5SKwE+AzQB6XGKRVMOYp+JdJJUV8=;
 b=Ti5NKkOMU3mjVo7IsLME3250c5omjlUvwkingbEntT21ZOKrZYfSIadTJUBa6d0IH1
 JJvQ6kEpn/4OVXuhHB7cVhR5qWJ55CDsTmPra9SAVjHmuXhSG9XB5YQkSWIBhlPI2hSF
 bV1qnv5RZUcYmWPjL89YqMDGWIKYSeFPL97AGIOWBSYxKCZcSVL/DkE8pSPU5ZeD2uwp
 e2wLhIZIcbkiVKA/AuRnWvCGhzI4eq2dxTFw4CHfUGcEUga47rCOwF7szxqAUH7ATqk7
 P7bpSXMJ/MfhYn+RQ6FVJ2/vvVfIJJUNllcF8fR5cbGiKSkzmkORyeKdUK/JFenT3D2H
 edHw==
X-Gm-Message-State: AC+VfDw3aO47obQU2HESXhoYMzBOU6jKbods0zQyhmr/Bn07DJrNiaVA
 CDYjDcHm8o9Tzpv3cqKp+0wTSICCpUYDRDfZluTgbUnjiuxA8thGNFRUqIAzDatpntrWhKq2FX4
 LnWqvuehQnuueQ7Nvg3aYcgTFBKlpz1A3uGERZPc5Q8nDg1mctzSudeeF7m/jbQiUTLs31lIU7G
 M=
X-Received: by 2002:a17:907:1c0e:b0:966:4d11:7887 with SMTP id
 nc14-20020a1709071c0e00b009664d117887mr6032961ejc.4.1684414009092; 
 Thu, 18 May 2023 05:46:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dSi9E5UvCccVkabvR9w26gP6evYeJbpQH+C0PyQQvQaidFA0c65YjGT5pjirpg+fcuP24aQ==
X-Received: by 2002:a17:907:1c0e:b0:966:4d11:7887 with SMTP id
 nc14-20020a1709071c0e00b009664d117887mr6032926ejc.4.1684414008600; 
 Thu, 18 May 2023 05:46:48 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 e14-20020a056402148e00b0050bc7c882bfsm547309edv.65.2023.05.18.05.46.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:46:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 1/2] meson: use subproject for internal libfdt
Date: Thu, 18 May 2023 14:46:44 +0200
Message-Id: <20230518124645.1011316-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518124645.1011316-1-pbonzini@redhat.com>
References: <20230518124645.1011316-1-pbonzini@redhat.com>
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

Recent dtc/libfdt can use both Make and meson as the build system.
By using a subproject, our own meson.build can remove the hard
coded list of source files.

In the future, it may also be possible to use wrap to download
the submodule.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules               |  4 ++--
 configure                 |  2 +-
 meson.build               | 44 +++++++++++++--------------------------
 scripts/archive-source.sh |  2 +-
 dtc => subprojects/dtc    |  0
 5 files changed, 19 insertions(+), 33 deletions(-)
 rename dtc => subprojects/dtc (100%)

diff --git a/.gitmodules b/.gitmodules
index 2a3a12033c4b..3ed5d073d630 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -13,8 +13,8 @@
 [submodule "roms/qemu-palcode"]
 	path = roms/qemu-palcode
 	url = https://gitlab.com/qemu-project/qemu-palcode.git
-[submodule "dtc"]
-	path = dtc
+[submodule "subprojects/dtc"]
+	path = subprojects/dtc
 	url = https://gitlab.com/qemu-project/dtc.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
diff --git a/configure b/configure
index 31a787153e38..5bbca83d9a31 100755
--- a/configure
+++ b/configure
@@ -1188,7 +1188,7 @@ fi
 case "$fdt" in
   auto | enabled | internal)
     # Simpler to always update submodule, even if not needed.
-    git_submodules="${git_submodules} dtc"
+    git_submodules="${git_submodules} subprojects/dtc"
     ;;
 esac
 
diff --git a/meson.build b/meson.build
index 41c87c441f8e..1e75afdc6844 100644
--- a/meson.build
+++ b/meson.build
@@ -3041,10 +3041,10 @@ if have_system and vfio_user_server_allowed
 endif
 
 fdt = not_found
-if have_system
-  fdt_opt = get_option('fdt')
+fdt_opt = get_option('fdt')
+if fdt_required.length() > 0 or fdt_opt == 'enabled'
+  have_internal = fs.exists(meson.current_source_dir() / 'subprojects/dtc/meson.build')
   if fdt_opt in ['enabled', 'auto', 'system']
-    have_internal = fs.exists(meson.current_source_dir() / 'dtc/libfdt/Makefile.libfdt')
     fdt = cc.find_library('fdt',
                           required: fdt_opt == 'system' or
                                     fdt_opt == 'enabled' and not have_internal)
@@ -3056,41 +3056,27 @@ if have_system
       fdt_opt = 'system'
     elif fdt_opt == 'system'
        error('system libfdt requested, but it is too old (1.5.1 or newer required)')
-    elif have_internal
-      fdt_opt = 'internal'
     else
-      fdt_opt = 'disabled'
+      fdt_opt = 'internal'
       fdt = not_found
     endif
   endif
-  if fdt_opt == 'internal'
-    fdt_files = files(
-      'dtc/libfdt/fdt.c',
-      'dtc/libfdt/fdt_ro.c',
-      'dtc/libfdt/fdt_wip.c',
-      'dtc/libfdt/fdt_sw.c',
-      'dtc/libfdt/fdt_rw.c',
-      'dtc/libfdt/fdt_strerror.c',
-      'dtc/libfdt/fdt_empty_tree.c',
-      'dtc/libfdt/fdt_addresses.c',
-      'dtc/libfdt/fdt_overlay.c',
-      'dtc/libfdt/fdt_check.c',
-    )
 
-    fdt_inc = include_directories('dtc/libfdt')
-    libfdt = static_library('fdt',
-                            build_by_default: false,
-                            sources: fdt_files,
-                            include_directories: fdt_inc)
-    fdt = declare_dependency(link_with: libfdt,
-                             include_directories: fdt_inc)
+  if fdt_opt == 'system'
+    # verified above
+  elif fdt_opt == 'disabled'
+    error('fdt disabled but required by targets ' + ', '.join(fdt_required))
+  elif not have_internal
+    error('libfdt source not found - please pull git submodule')
+  else
+    libfdt_proj = subproject('dtc', required: true,
+                             default_options: ['tools=false',  'yaml=disabled',
+                                               'python=disabled', 'default_library=static'])
+    fdt = libfdt_proj.get_variable('libfdt_dep')
   endif
 else
   fdt_opt = 'disabled'
 endif
-if not fdt.found() and fdt_required.length() > 0
-  error('fdt not available but required by targets ' + ', '.join(fdt_required))
-endif
 
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_FDT', fdt.found())
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index 23e042dacdb3..b15f6fe6b8fe 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,7 +26,7 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="dtc meson ui/keycodemapdb"
+submodules="subprojects/dtc meson ui/keycodemapdb"
 submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
diff --git a/dtc b/subprojects/dtc
similarity index 100%
rename from dtc
rename to subprojects/dtc
-- 
2.40.1


