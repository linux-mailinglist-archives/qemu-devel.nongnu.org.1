Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3981BCF6
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMit-0007dZ-NK; Thu, 21 Dec 2023 12:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMir-0007d7-0N
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMip-0004Yr-Ap
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sD8zQ2qb3Nom9XRhoC85XFShfiOQE1gFLBrQwUhPrTc=;
 b=deOFytHk+VR+CF1epwZTuSxVEfllgufWtUoTyBuLvooQcQarpxTrzjrwz3J5keOfMvzrxf
 /vyHLvxUPBva0+x4yRfRKJkBX5+tgX4hs3cQ21RAfT2LeYYTlJ4/45E/64kijIu9Q2NAyX
 ikroUGSizl25Z11+9nbPVqo6zelcg9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-MLLCW4BGNt2Z9rfWW3WFag-1; Thu, 21 Dec 2023 12:20:32 -0500
X-MC-Unique: MLLCW4BGNt2Z9rfWW3WFag-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3368abe10c5so474720f8f.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179231; x=1703784031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sD8zQ2qb3Nom9XRhoC85XFShfiOQE1gFLBrQwUhPrTc=;
 b=QYa6//vyGvhrmSDQOD+XhVSVxDmMzYyJdEXTXt+bBbvQy2BCKCJRH4HO6GJEoIsHzb
 TX4z9hzU/JKYBnEdyPtcOd6r0YaU+jYwmtW2A3U3Fq6GHfipUpmJJ9XBTbcgvZGjR2Vn
 rEAFHlXTSFA3qsTfHLDMy7SXzsiFyPWTqJiOTaWBMDeRKG0FeJpjeo1TadxJseKPYY1k
 dLl9i51voZim0I7snsu+6EjH9kX0UdKreot+8ro6JypGBEzVgmhmIMaWdPC+cfq9zY6W
 YDHN+IF4bsmtSaL+RC1FOTgI3mVTFjqzfZIqlKIEj/vsJ4yPYnB1VoGBomgc53j284lZ
 x3mw==
X-Gm-Message-State: AOJu0YydnShmvPVXDakoiCsqVC2QmE6CyBgA6Qij4+eQpI6JDKEOceA8
 f1BDfsGqQe9z08wrdkKXpCo2lKNSVLAuUrxg9eIYxk9esKHEeikqHnOzCbjVx02Xk8D14uN8VPy
 CXx2l/CnW6pMLgg9KV8y1qNcEMz37iuXcvh/sDoYF0jtcVj2KDKabzi/4zE15p7VWWUXry+eKY+
 z1yPlQT6k=
X-Received: by 2002:a5d:5089:0:b0:336:6e12:7c5f with SMTP id
 a9-20020a5d5089000000b003366e127c5fmr56559wrt.2.1703179230887; 
 Thu, 21 Dec 2023 09:20:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwaQTjWh2xejvEFLV8qW4v3JJem4Pa5RUPQ/sN3+qn05rPuSiPC8rYUeGw4fOvBWV9a4P+zA==
X-Received: by 2002:a5d:5089:0:b0:336:6e12:7c5f with SMTP id
 a9-20020a5d5089000000b003366e127c5fmr56555wrt.2.1703179230518; 
 Thu, 21 Dec 2023 09:20:30 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 w11-20020adfcd0b000000b003367e35abd4sm2463078wrm.71.2023.12.21.09.20.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/21] meson: separate host-specific checks from option
 validation
Date: Thu, 21 Dec 2023 18:19:53 +0100
Message-ID: <20231221171958.59350-17-pbonzini@redhat.com>
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
 meson.build | 97 +++++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/meson.build b/meson.build
index f7e7deeabdc..e777f507ce3 100644
--- a/meson.build
+++ b/meson.build
@@ -602,53 +602,6 @@ have_vhost_net_vdpa = have_vhost_vdpa and get_option('vhost_net').allowed()
 have_vhost_net_kernel = have_vhost_kernel and get_option('vhost_net').allowed()
 have_vhost_net = have_vhost_net_kernel or have_vhost_net_user or have_vhost_net_vdpa
 
-# Target-specific libraries and flags
-libm = cc.find_library('m', required: false)
-threads = dependency('threads')
-util = cc.find_library('util', required: false)
-winmm = []
-socket = []
-version_res = []
-coref = []
-iokit = []
-emulator_link_args = []
-nvmm =not_found
-hvf = not_found
-midl = not_found
-widl = not_found
-pathcch = not_found
-host_dsosuf = '.so'
-if targetos == 'windows'
-  midl = find_program('midl', required: false)
-  widl = find_program('widl', required: false)
-  pathcch = cc.find_library('pathcch')
-  socket = cc.find_library('ws2_32')
-  winmm = cc.find_library('winmm')
-
-  win = import('windows')
-  version_res = win.compile_resources('version.rc',
-                                      depend_files: files('pc-bios/qemu-nsis.ico'),
-                                      include_directories: include_directories('.'))
-  host_dsosuf = '.dll'
-elif targetos == 'darwin'
-  coref = dependency('appleframeworks', modules: 'CoreFoundation')
-  iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
-  host_dsosuf = '.dylib'
-elif targetos == 'sunos'
-  socket = [cc.find_library('socket'),
-            cc.find_library('nsl'),
-            cc.find_library('resolv')]
-elif targetos == 'haiku'
-  socket = [cc.find_library('posix_error_mapper'),
-            cc.find_library('network'),
-            cc.find_library('bsd')]
-elif targetos == 'openbsd'
-  if get_option('tcg').allowed() and target_dirs.length() > 0
-    # Disable OpenBSD W^X if available
-    emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
-  endif
-endif
-
 # Target-specific configuration of accelerators
 accelerators = []
 if get_option('kvm').allowed() and targetos == 'linux'
@@ -716,6 +669,56 @@ if 'CONFIG_WHPX' not in accelerators and get_option('whpx').enabled()
   error('WHPX not available on this platform')
 endif
 
+#####################################
+# Host-specific libraries and flags #
+#####################################
+
+libm = cc.find_library('m', required: false)
+threads = dependency('threads')
+util = cc.find_library('util', required: false)
+winmm = []
+socket = []
+version_res = []
+coref = []
+iokit = []
+emulator_link_args = []
+nvmm =not_found
+hvf = not_found
+midl = not_found
+widl = not_found
+pathcch = not_found
+host_dsosuf = '.so'
+if targetos == 'windows'
+  midl = find_program('midl', required: false)
+  widl = find_program('widl', required: false)
+  pathcch = cc.find_library('pathcch')
+  socket = cc.find_library('ws2_32')
+  winmm = cc.find_library('winmm')
+
+  win = import('windows')
+  version_res = win.compile_resources('version.rc',
+                                      depend_files: files('pc-bios/qemu-nsis.ico'),
+                                      include_directories: include_directories('.'))
+  host_dsosuf = '.dll'
+elif targetos == 'darwin'
+  coref = dependency('appleframeworks', modules: 'CoreFoundation')
+  iokit = dependency('appleframeworks', modules: 'IOKit', required: false)
+  host_dsosuf = '.dylib'
+elif targetos == 'sunos'
+  socket = [cc.find_library('socket'),
+            cc.find_library('nsl'),
+            cc.find_library('resolv')]
+elif targetos == 'haiku'
+  socket = [cc.find_library('posix_error_mapper'),
+            cc.find_library('network'),
+            cc.find_library('bsd')]
+elif targetos == 'openbsd'
+  if get_option('tcg').allowed() and target_dirs.length() > 0
+    # Disable OpenBSD W^X if available
+    emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
+  endif
+endif
+
 ################
 # Dependencies #
 ################
-- 
2.43.0


