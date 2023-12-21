Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E881BD02
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMin-0007cH-Lb; Thu, 21 Dec 2023 12:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMim-0007bu-IV
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMik-0004Y4-Tn
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cuDZZGfujoEkwBEeQaDmvaxMxn2etEI2ao+6xKMwJak=;
 b=O4d4wputKQu8yM93vqBSMDvLRLrlJEKhmeA6FjtwnHdW2k8s08MOU7jCgoemSklc9C5faE
 uZ0sxIc3yFvVm4Gg3jpcDkyj6I7rHT8SCbeUG62TJ8745EvdLMqMZnIlCMFBzgEk9ykIgV
 B5CTyseoP+iHituuTs1e8lGqbEBZx1I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-XUlRsx2OOtKmpVfs6z6OMA-1; Thu, 21 Dec 2023 12:20:28 -0500
X-MC-Unique: XUlRsx2OOtKmpVfs6z6OMA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3368c707b03so381060f8f.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179227; x=1703784027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cuDZZGfujoEkwBEeQaDmvaxMxn2etEI2ao+6xKMwJak=;
 b=NdA6NmxMjXCmZqjXYDGzPBFb27NDF/nbXFZdPmO7tQVwnuJpr92smeQUUZXWWsaE31
 LX03gTq2x826jWIe7bv4dqvzTeZy24EDKDUXG+f3SUJ0NWTA27QWLBdQabe9vXfBWqyl
 KwL/uac/9lAB/WwdmMegSo8FZIlcIPAj9f2tvr104VjbqxUF+6+iFRyJksPAgvTzgZYt
 XkGqBuJTmXOaSkdXnsmbTotl6RCDuQbSGDtbQrkFPPjwUoX4cqgyJomnyDDoqk+vc+Ob
 JW5Qu91lfNlyTEXQ4SHVfGspEk8j7id8jl6LrPBe4YI+ytjKghr+Hb4L/GH6YtIbQ6fE
 c8EQ==
X-Gm-Message-State: AOJu0YyLvw1PvdBoU1WGB/UxeUK5NCYIQkYc4xCabh785HZrtsPXNiAx
 Dt+1JkI+YV9+FHhF4wJ2yTIacl37UtmWccFyAcf7W5fJ2y/nQAckQTNxUwFWyC6qY02eWuFp+9U
 5FpMzG19maBiMfBjbXftOlGu3iKfILL0uotSGGhAYcKwuuhka+RD/VBXaB5RS61GnrCDj6xY/tb
 NTNL3drAQ=
X-Received: by 2002:a5d:4491:0:b0:336:9ec:683 with SMTP id
 j17-20020a5d4491000000b0033609ec0683mr71259wrq.24.1703179226887; 
 Thu, 21 Dec 2023 09:20:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHx2FLl27pL9WfZsCUrfXND3ftVdOSTZiYNeUNKRi9IvgN+kv3Uhzre0pI19KT3eeU51YyiNA==
X-Received: by 2002:a5d:4491:0:b0:336:9ec:683 with SMTP id
 j17-20020a5d4491000000b0033609ec0683mr71252wrq.24.1703179226469; 
 Thu, 21 Dec 2023 09:20:26 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 y17-20020adff151000000b0033664ffaf5dsm2484120wro.37.2023.12.21.09.20.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/21] meson: move program checks together
Date: Thu, 21 Dec 2023 18:19:51 +0100
Message-ID: <20231221171958.59350-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 90 ++++++++++++++++++++++++++---------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/meson.build b/meson.build
index b8c64c5ecf7..1a1e006ba13 100644
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
@@ -94,8 +81,53 @@ have_block = have_system or have_tools
 # Programs #
 ############
 
+sh = find_program('sh')
 python = import('python').find_installation()
 
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
 #######################################
 # Variables for host and accelerators #
 #######################################
@@ -167,38 +199,6 @@ if targetos != 'darwin'
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


