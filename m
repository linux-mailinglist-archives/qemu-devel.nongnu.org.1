Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3DF820A9B
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:53:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUu-00088A-2k; Sun, 31 Dec 2023 03:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrTB-0005Jj-A7
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrT8-0000sy-En
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2lG4V0Bh6WQU0au/wcKI+DOcbk1P7K4earfxHdzmzxA=;
 b=GPPvH6Fx9MThWGGEzs+xU3fgBDzhg3wa7xmyLBar79u4vq2eFgjAolMeiXsJt0eJwo6hNO
 oCrgH8vj5zE9dTQEvMJY8sAkpcTVTW2k1JoL4yXQ2esglXUHi8B2aDgTGhBLgwRvcCiKwT
 itAufYszCKUHVSEwxl2PJjJhkPRVLj0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-Bslw8WOMO1aBTKJmyBcZsg-1; Sun, 31 Dec 2023 03:46:41 -0500
X-MC-Unique: Bslw8WOMO1aBTKJmyBcZsg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-336811fc1d7so5943372f8f.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012400; x=1704617200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lG4V0Bh6WQU0au/wcKI+DOcbk1P7K4earfxHdzmzxA=;
 b=KtmXJ89dq7C0xY2+Ss+zWlQ6FEvNMkC9Xx0fyIqiNx3S/RbHV08lRBHzE0ufxjED7P
 oJjquQMNKNTuORftPCY52WQuXFJVGKodfes1We9RME89ats79Y3ni1Ypz4qrV6yt8jLf
 ON3RAG3OgjL0xDGcOulLMJqK8IIM//t8f5MhMNs/FbTlVR0InSweJFi2C8E//gZ2SKZD
 qk92XJhaiqzI9r72xzWQSCspxRhH0Zqc8ZhkdR6u9HBu2m2yqKSwYF/AF0o+g6EHcXgU
 iRJGd+i0Jlgq0YIgjHYcozQPhW5h68owsq2V5cKwYv7mKAuAeEWI3zxl+Z3o6LEZm/Q7
 9/Hg==
X-Gm-Message-State: AOJu0YzlfYi8bsl1Hn1DsCOBX28GYI7jauXDCJ5Xnf3R+K8rg4uhyIFS
 g4yf7bXxm7HJVLiyK/LipZ+4pgTvmVtcnCZhhOCJD/I9REAxgc5D0WwYpzRkweuuTM0CXrQp23Z
 BAz6R/pRtbjPOxoC87ZFIgxvKGWWJsDLmcoQgmNPRpuCW5An+FUN7KSzndC15F4cT8CZZtVXPqy
 2NQxQtz90=
X-Received: by 2002:adf:ea10:0:b0:333:2fd2:5d5d with SMTP id
 q16-20020adfea10000000b003332fd25d5dmr9611369wrm.143.1704012400395; 
 Sun, 31 Dec 2023 00:46:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgUGpsZL3TuHK0HGvBACTgNiGvfyY67ffYbCUQMd18ej5HUPBeIy97ClAaUbaB7/OfvivP8w==
X-Received: by 2002:adf:ea10:0:b0:333:2fd2:5d5d with SMTP id
 q16-20020adfea10000000b003332fd25d5dmr9611361wrm.143.1704012400017; 
 Sun, 31 Dec 2023 00:46:40 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a5d53d2000000b0033671314440sm23223742wrw.3.2023.12.31.00.46.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 37/46] meson: move config-host.h definitions together
Date: Sun, 31 Dec 2023 09:44:53 +0100
Message-ID: <20231231084502.235366-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/meson.build b/meson.build
index 5c54441a3cd..151db21c038 100644
--- a/meson.build
+++ b/meson.build
@@ -40,7 +40,6 @@ qemu_moddir = get_option('libdir') / get_option('qemu_suffix')
 qemu_desktopdir = get_option('datadir') / 'applications'
 qemu_icondir = get_option('datadir') / 'icons'
 
-config_host_data = configuration_data()
 genh = []
 qapi_trace_events = []
 
@@ -233,12 +232,6 @@ elif cpu in ['riscv64']
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
@@ -1191,12 +1184,6 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
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
@@ -2008,6 +1995,8 @@ endif
 # config-host.h #
 #################
 
+config_host_data = configuration_data()
+
 audio_drivers_selected = []
 if have_system
   audio_drivers_available = {
@@ -2137,6 +2126,12 @@ endif
 
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
@@ -2236,6 +2231,12 @@ config_host_data.set('CONFIG_PNG', png.found())
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


