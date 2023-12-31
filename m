Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34327820A9C
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:53:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUq-0007zz-Rw; Sun, 31 Dec 2023 03:48:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT3-0005Bt-3Z
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSu-0000r1-TM
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGf1GkocofnlPz6qLQNH98ZD2mT7bfGgfy/DraUpGVg=;
 b=ZyYV0Z03O5N782qohnAIaVc8c2r++Oa1PUIPZ6iCYkTD9+MD5WKv2t7OGZ2GuUlbnuDUro
 NwqCr0ffxaUgXkbHcd2tLmbOnu9IaHH7H6wlypGxZlIJWwo8C2gGFugx7UntSa3kIFTBbf
 r7b9UPnB8l1hQsngvVU44zc5B2jAZSw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-Uchx9IeqO0mUFxqmXw8jcQ-1; Sun, 31 Dec 2023 03:46:31 -0500
X-MC-Unique: Uchx9IeqO0mUFxqmXw8jcQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d589908f7so36583915e9.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012390; x=1704617190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qGf1GkocofnlPz6qLQNH98ZD2mT7bfGgfy/DraUpGVg=;
 b=P6GzHv3SV2OFavRBtnby9Mn50lYmz6HDU/w96ML8ClPzJOeSIEPR4RoqkSeZ3ZqTjw
 c5DHT9ruZ3LQaEMTIxzb7iucEuaCo2WW5Tb97mnC34DjWJtm1iAqgdec3MVdmB72WPg8
 iPox/vs919+GqlSoEt5P55W9R39tiIOsuwdQoKkDgV57uLaIbBy4rnkUFzJt+VwdcKw7
 d0SmSXhA6sgSFVhl5Uc4mApixbAbghSIc7JyMu00BgY5VHpzFYpRNLmg6+9xsxO4qsyM
 Gm+bS98/pZ0gZVOMkU8yK/vlfI0P0TYxbpxX/u/YnvSkt6XpPQghYUI/pNVdnwICDJeW
 Lz+w==
X-Gm-Message-State: AOJu0YxdopN58oorAHZkKRc9IKu3jIO0GIn81p5NE9Am2SVVL9Zx2g4w
 IWDtSDL9RvxiNP8Tug7PyutW9T3aQHoFcaw1wQDrc3dqbCZYiaaKIb3WPAAggrmP6OQguQklz0f
 xETDZfa1SBNFsW9+vzPFuJoEVQ5ybRxEi7NBlbn8sCJBcv4u8SLhfj9mAiSRDhtGhnc3PuUwxvu
 kx0fpHI7o=
X-Received: by 2002:a05:600c:378a:b0:40c:4904:bb72 with SMTP id
 o10-20020a05600c378a00b0040c4904bb72mr8231211wmr.18.1704012389886; 
 Sun, 31 Dec 2023 00:46:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMlvak7Vrr07vmelEskJ7T8TecQMvq4GNzpqB1b7y5Ge+7oDhNFxhnO+HMo5UjETa1JxrQmQ==
X-Received: by 2002:a05:600c:378a:b0:40c:4904:bb72 with SMTP id
 o10-20020a05600c378a00b0040c4904bb72mr8231201wmr.18.1704012389587; 
 Sun, 31 Dec 2023 00:46:29 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a5d5652000000b00336ca349bdesm13918817wrw.47.2023.12.31.00.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/46] meson: move program checks together
Date: Sun, 31 Dec 2023 09:44:48 +0100
Message-ID: <20231231084502.235366-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 107 +++++++++++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/meson.build b/meson.build
index c437e9f55e6..3a1f4cbb90f 100644
--- a/meson.build
+++ b/meson.build
@@ -19,21 +19,8 @@ ss = import('sourceset')
 fs = import('fs')
 
 targetos = host_machine.system()
-sh = find_program('sh')
 config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
 
-cc = meson.get_compiler('c')
-all_languages = ['c']
-if targetos == 'windows' and add_languages('cpp', required: false, native: false)
-  all_languages += ['cpp']
-  cxx = meson.get_compiler('cpp')
-endif
-if targetos == 'darwin' and \
-   add_languages('objc', required: get_option('cocoa'), native: false)
-  all_languages += ['objc']
-  objc = meson.get_compiler('objc')
-endif
-
 # Temporary directory used for files created while
 # configure runs. Since it is in the build directory
 # we can safely blow away any previous version of it
@@ -65,6 +52,62 @@ supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64'
 cpu = host_machine.cpu_family()
 
 target_dirs = config_host['TARGET_DIRS'].split()
+
+############
+# Programs #
+############
+
+sh = find_program('sh')
+python = import('python').find_installation()
+
+cc = meson.get_compiler('c')
+all_languages = ['c']
+if targetos == 'windows' and add_languages('cpp', required: false, native: false)
+  all_languages += ['cpp']
+  cxx = meson.get_compiler('cpp')
+endif
+if targetos == 'darwin' and \
+   add_languages('objc', required: get_option('cocoa'), native: false)
+  all_languages += ['objc']
+  objc = meson.get_compiler('objc')
+endif
+
+dtrace = not_found
+stap = not_found
+if 'dtrace' in get_option('trace_backends')
+  dtrace = find_program('dtrace', required: true)
+  stap = find_program('stap', required: false)
+  if stap.found()
+    # Workaround to avoid dtrace(1) producing a file with 'hidden' symbol
+    # visibility. Define STAP_SDT_V2 to produce 'default' symbol visibility
+    # instead. QEMU --enable-modules depends on this because the SystemTap
+    # semaphores are linked into the main binary and not the module's shared
+    # object.
+    add_global_arguments('-DSTAP_SDT_V2',
+                         native: false, language: all_languages)
+  endif
+endif
+
+if get_option('iasl') == ''
+  iasl = find_program('iasl', required: false)
+else
+  iasl = find_program(get_option('iasl'), required: true)
+endif
+
+edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
+unpack_edk2_blobs = false
+foreach target : edk2_targets
+  if target in target_dirs
+    bzip2 = find_program('bzip2', required: get_option('install_blobs'))
+    unpack_edk2_blobs = bzip2.found()
+    break
+  endif
+endforeach
+
+#####################
+# Option validation #
+#####################
+
 have_linux_user = false
 have_bsd_user = false
 have_system = false
@@ -90,12 +133,6 @@ enable_modules = get_option('modules') \
   .allowed()
 have_block = have_system or have_tools
 
-############
-# Programs #
-############
-
-python = import('python').find_installation()
-
 #######################################
 # Variables for host and accelerators #
 #######################################
@@ -167,38 +204,6 @@ if targetos != 'darwin'
   modular_tcg = ['i386-softmmu', 'x86_64-softmmu']
 endif
 
-edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
-unpack_edk2_blobs = false
-foreach target : edk2_targets
-  if target in target_dirs
-    bzip2 = find_program('bzip2', required: get_option('install_blobs'))
-    unpack_edk2_blobs = bzip2.found()
-    break
-  endif
-endforeach
-
-dtrace = not_found
-stap = not_found
-if 'dtrace' in get_option('trace_backends')
-  dtrace = find_program('dtrace', required: true)
-  stap = find_program('stap', required: false)
-  if stap.found()
-    # Workaround to avoid dtrace(1) producing a file with 'hidden' symbol
-    # visibility. Define STAP_SDT_V2 to produce 'default' symbol visibility
-    # instead. QEMU --enable-modules depends on this because the SystemTap
-    # semaphores are linked into the main binary and not the module's shared
-    # object.
-    add_global_arguments('-DSTAP_SDT_V2',
-                         native: false, language: all_languages)
-  endif
-endif
-
-if get_option('iasl') == ''
-  iasl = find_program('iasl', required: false)
-else
-  iasl = find_program(get_option('iasl'), required: true)
-endif
-
 ##################
 # Compiler flags #
 ##################
-- 
2.43.0


