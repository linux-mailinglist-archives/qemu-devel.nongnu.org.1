Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A981BD0E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:22:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMiy-0007jU-Ai; Thu, 21 Dec 2023 12:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiw-0007hF-9Z
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiu-0004ZS-RM
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fAWkdbqYASXrctslh8XXfWgepJaH8Ogk55Uzv0gWBsg=;
 b=Ef+nv49hB4vykOxexDDF/8y9IkbGLDztJDXyL6APy4sYpyfkhvbSQ2MVZ3F9nfBYg1CdvU
 EbwH5yP38ejTWB4l6+LzP1oCfIlC3TZMMfrW1lBPD6skaPKVTKnEOE8+R0mSn9Hetk6pfm
 U/jghVmViOvUlJtALWvXSWTzDxKC1QY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-etNln_fAPFK9D3WrQccNHA-1; Thu, 21 Dec 2023 12:20:38 -0500
X-MC-Unique: etNln_fAPFK9D3WrQccNHA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40c691ffb32so8483065e9.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179237; x=1703784037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAWkdbqYASXrctslh8XXfWgepJaH8Ogk55Uzv0gWBsg=;
 b=Pm2VNEBuwS1n9oSYWbjIizFHBXgA6olEP4quTOmnlvKZEFLl1jD73ygi/J4TuVNdUa
 JLy+/t9sJRBUMmAi2q5j9d1jB+Zxu93L1+L+L1uO2AalvsvVI17ijoeKeyTtzQUnMFxI
 ub84l1lD+7X6grH/jgHzguX38hlPrvfATTftYpxbDAD6R00BCMX0eRUYOqm32eRDlM1X
 LmgYzbBtFYqz0r7qCquLi/ILFuKKVnJNO4ObaGxwbljzob2csEoKEcziV0Zm+3Xw1Cvr
 RPvtPC/KsuDY4q6DcEOot9TmJ4Mj/HasmZF9wHD9QmVSrzYmpgOHSU5nqJP2fV7veKoY
 0WfA==
X-Gm-Message-State: AOJu0Yyf2AGBD7EqIz0uPx9nqPE7Iey1X+JJCOcxaJ5z7UdiD0XXiael
 VK6tJpYM3i++1ecADxz0G6nxBWTyGhKRNLP6kK5rE0vcy59mvlA/ROApvAsM+uyR6527nT4cvsf
 qNOeHEK0wIMqT+Owf5fgnaF/xown07LIg76H/UKggxPA/6pr3SbVqunxx2fnR3n9un8NITTCpGr
 Id3XV9Cy4=
X-Received: by 2002:a05:600c:34c1:b0:40c:e76:16d6 with SMTP id
 d1-20020a05600c34c100b0040c0e7616d6mr23241wmq.57.1703179236906; 
 Thu, 21 Dec 2023 09:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlI5RMdr5OXBQ2qno+V/YftSAT6LbHedrzabXO4PokacRAq6Rr4V9PKxsifUKc2AIZGM5n/Q==
X-Received: by 2002:a05:600c:34c1:b0:40c:e76:16d6 with SMTP id
 d1-20020a05600c34c100b0040c0e7616d6mr23236wmq.57.1703179236649; 
 Thu, 21 Dec 2023 09:20:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 hg12-20020a05600c538c00b0040c41846923sm11569366wmb.26.2023.12.21.09.20.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/21] meson: move config-host.h definitions together
Date: Thu, 21 Dec 2023 18:19:56 +0100
Message-ID: <20231221171958.59350-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index f105462c181..57821069e91 100644
--- a/meson.build
+++ b/meson.build
@@ -40,7 +40,6 @@ qemu_moddir = get_option('libdir') / get_option('qemu_suffix')
 qemu_desktopdir = get_option('datadir') / 'applications'
 qemu_icondir = get_option('datadir') / 'icons'
 
-config_host_data = configuration_data()
 genh = []
 qapi_trace_events = []
 
@@ -137,12 +136,6 @@ elif cpu in ['riscv64']
 else
   kvm_targets = []
 endif
-
-kvm_targets_c = '""'
-if get_option('kvm').allowed() and targetos == 'linux'
-  kvm_targets_c = '"' + '" ,"'.join(kvm_targets) + '"'
-endif
-config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
 accelerator_targets = { 'CONFIG_KVM': kvm_targets }
 
 if cpu in ['x86', 'x86_64']
@@ -1107,12 +1100,6 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
   virgl = dependency('virglrenderer',
                      method: 'pkg-config',
                      required: get_option('virglrenderer'))
-  if virgl.found()
-    config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
-                         cc.has_member('struct virgl_renderer_resource_info_ext', 'd3d_tex2d',
-                                       prefix: '#include <virglrenderer.h>',
-                                       dependencies: virgl))
-  endif
 endif
 rutabaga = not_found
 if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
@@ -2004,6 +1991,8 @@ endif
 # config-host.h #
 #################
 
+config_host_data = configuration_data()
+
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
@@ -2133,6 +2122,12 @@ endif
 
 config_host_data.set('HOST_' + host_arch.to_upper(), 1)
 
+kvm_targets_c = '""'
+if get_option('kvm').allowed() and targetos == 'linux'
+  kvm_targets_c = '"' + '" ,"'.join(kvm_targets) + '"'
+endif
+config_host_data.set('CONFIG_KVM_TARGETS', kvm_targets_c)
+
 if get_option('module_upgrades') and not enable_modules
   error('Cannot enable module-upgrades as modules are not enabled')
 endif
@@ -2232,6 +2227,12 @@ config_host_data.set('CONFIG_PNG', png.found())
 config_host_data.set('CONFIG_VNC', vnc.found())
 config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
+if virgl.found()
+  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
+                       cc.has_member('struct virgl_renderer_resource_info_ext', 'd3d_tex2d',
+                                     prefix: '#include <virglrenderer.h>',
+                                     dependencies: virgl))
+endif
 config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
 config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
-- 
2.43.0


