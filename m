Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3F81BCF3
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMiu-0007dm-O4; Thu, 21 Dec 2023 12:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMis-0007dI-9W
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiq-0004Z1-KJ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XGKSDQRWT3Y8gs5FUjlvUHuPqorGos1W4QnqrsXKm88=;
 b=BJmDaFtHkfpFBXVOLC4PFnqI7OA2P/1K823y2pV6uCXUpBz5z8yYSp5oyxNcvW+Pwbpa5U
 jm2P0Omm/35kNNf2Tlm+7F4OpyrNJH5PhsMSpkFHuKfWd9kLAusqwajFTeZagV0/fVJIv9
 3DAPHF9PNy88r5UZgbN8Q4fykcPcDss=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-sz5ScC4tPBqQhVAOkPEb8g-1; Thu, 21 Dec 2023 12:20:34 -0500
X-MC-Unique: sz5ScC4tPBqQhVAOkPEb8g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40c22bc1ebdso4794175e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179233; x=1703784033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XGKSDQRWT3Y8gs5FUjlvUHuPqorGos1W4QnqrsXKm88=;
 b=hb3mqtW9dBiJYADu/fAHOx9zPBFfxnUI4G8c9THwsTAUIe9TS3EdZbiPm5lv+BSYTu
 4FmBIVJi2d3JC4UoBzX/bDx1uIjc+JznddsMBTPUzIOrLRoNUZuSvEvONXjyCantWehS
 GkYCaWifVEvhl1d9dVbbeSigTf7AuLLkvu31HE6KmXT1mxKEFcu4mkCiBeYgC2D74o4Z
 R41m38ruy9ACeUcoAMCOO4+7fjdWHUiA7a8JJUMo2pzsN4sgBtmye6xc+iGGoMkLVykt
 WhPv/X/b5VZRg99vNf/1H0RNZ3aIwGM9KdViWkIFnSwm3DzxEewaXHHOnG+4UGsV/180
 xVag==
X-Gm-Message-State: AOJu0YwTwDZMxzv8NwfsxBHmDOlN/wln6MQsAmWCn+zBTulzE2eKu+lv
 HAz5X75oB/vFvYsX2h+iIN67ZkAi/9CznJG1m8hUsYL/J05m9pcD3WVvGCnJmZDM0tk1jKFQx/w
 1VDCvhsHaWS/pjSsw03EWbFFROpGOdnJJSEdmDyykUbUTwzGorbRZWwnRjrhOiKtBqqPD2bvV8X
 bINRzO3OY=
X-Received: by 2002:a05:600c:3b19:b0:40c:415f:cc48 with SMTP id
 m25-20020a05600c3b1900b0040c415fcc48mr16435wms.40.1703179232943; 
 Thu, 21 Dec 2023 09:20:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnEaYotkAQyqBg+1vK4BYOWCZrglsMyQD0BrE+8s45hKJVZruaAA8vSH/yufNtaDqphmOVoQ==
X-Received: by 2002:a05:600c:3b19:b0:40c:415f:cc48 with SMTP id
 m25-20020a05600c3b1900b0040c415fcc48mr16424wms.40.1703179232616; 
 Thu, 21 Dec 2023 09:20:32 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a05600c4fd400b004094d4292aesm4014821wmq.18.2023.12.21.09.20.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/21] meson: keep subprojects together
Date: Thu, 21 Dec 2023 18:19:54 +0100
Message-ID: <20231221171958.59350-18-pbonzini@redhat.com>
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

And move away dependencies that are not subprojects anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 72 ++++++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/meson.build b/meson.build
index e777f507ce3..f8d61a46ad1 100644
--- a/meson.build
+++ b/meson.build
@@ -1538,6 +1538,25 @@ if not gnutls_crypto.found()
   endif
 endif
 
+capstone = not_found
+if not get_option('capstone').auto() or have_system or have_user
+  capstone = dependency('capstone', version: '>=3.0.5',
+                        method: 'pkg-config',
+                        required: get_option('capstone'))
+
+  # Some versions of capstone have broken pkg-config file
+  # that reports a wrong -I path, causing the #include to
+  # fail later. If the system has such a broken version
+  # do not use it.
+  if capstone.found() and not cc.compiles('#include <capstone.h>',
+                                          dependencies: [capstone])
+    capstone = not_found
+    if get_option('capstone').enabled()
+      error('capstone requested, but it does not appear to work')
+    endif
+  endif
+endif
+
 gmp = dependency('gmp', required: false, method: 'pkg-config')
 if nettle.found() and gmp.found()
   hogweed = dependency('hogweed', version: '>=3.4',
@@ -2123,6 +2142,7 @@ config_host_data.set('CONFIG_ATTR', libattr.found())
 config_host_data.set('CONFIG_BDRV_WHITELIST_TOOLS', get_option('block_drv_whitelist_in_tools'))
 config_host_data.set('CONFIG_BRLAPI', brlapi.found())
 config_host_data.set('CONFIG_BSD', targetos in bsd_oses)
+config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_DARWIN', targetos == 'darwin')
 config_host_data.set('CONFIG_FUZZ', get_option('fuzzing'))
@@ -2186,6 +2206,7 @@ if seccomp.found()
   config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
 endif
 config_host_data.set('CONFIG_PIXMAN', pixman.found())
+config_host_data.set('CONFIG_SLIRP', slirp.found())
 config_host_data.set('CONFIG_SNAPPY', snappy.found())
 config_host_data.set('CONFIG_SOLARIS', targetos == 'sunos')
 if get_option('tcg').allowed()
@@ -3057,28 +3078,9 @@ genh += custom_target('config-poison.h',
                       command: [find_program('scripts/make-config-poison.sh'),
                                 target_configs_h])
 
-##############
-# Submodules #
-##############
-
-capstone = not_found
-if not get_option('capstone').auto() or have_system or have_user
-  capstone = dependency('capstone', version: '>=3.0.5',
-                        method: 'pkg-config',
-                        required: get_option('capstone'))
-
-  # Some versions of capstone have broken pkg-config file
-  # that reports a wrong -I path, causing the #include to
-  # fail later. If the system has such a broken version
-  # do not use it.
-  if capstone.found() and not cc.compiles('#include <capstone.h>',
-                                          dependencies: [capstone])
-    capstone = not_found
-    if get_option('capstone').enabled()
-      error('capstone requested, but it does not appear to work')
-    endif
-  endif
-endif
+###############
+# Subprojects #
+###############
 
 libvfio_user_dep = not_found
 if have_system and vfio_user_server_allowed
@@ -3122,9 +3124,19 @@ else
   fdt_opt = 'disabled'
 endif
 
-config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_FDT', fdt.found())
-config_host_data.set('CONFIG_SLIRP', slirp.found())
+
+vhost_user = not_found
+if targetos == 'linux' and have_vhost_user
+  libvhost_user = subproject('libvhost-user')
+  vhost_user = libvhost_user.get_variable('vhost_user_dep')
+endif
+
+libvduse = not_found
+if have_libvduse
+  libvduse_proj = subproject('libvduse')
+  libvduse = libvduse_proj.get_variable('libvduse_dep')
+endif
 
 #####################
 # Generated sources #
@@ -3355,18 +3367,6 @@ if have_system or have_user
   ]
 endif
 
-vhost_user = not_found
-if targetos == 'linux' and have_vhost_user
-  libvhost_user = subproject('libvhost-user')
-  vhost_user = libvhost_user.get_variable('vhost_user_dep')
-endif
-
-libvduse = not_found
-if have_libvduse
-  libvduse_proj = subproject('libvduse')
-  libvduse = libvduse_proj.get_variable('libvduse_dep')
-endif
-
 # NOTE: the trace/ subdirectory needs the qapi_trace_events variable
 # that is filled in by qapi/.
 subdir('qapi')
-- 
2.43.0


