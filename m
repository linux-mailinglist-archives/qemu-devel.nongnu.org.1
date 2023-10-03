Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1697B72B2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmGi-00088m-QQ; Tue, 03 Oct 2023 16:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGa-00082i-L9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:16 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGY-0004aK-Bc
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:16 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2773f776f49so190808a91.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696365912; x=1696970712; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gpyswv5RJxParLYALomhg7e43ObDOfT08EaHKwu0GSg=;
 b=QtdplF2WFXRkpuHypDjKrRqahbEoXBURWUqWEtSPPPTPaXb5gtBJAe57V0ohMRpTTl
 tYwFE+G6OjSJ1yuzLQUBveZEWxdM3N09VH6iUaTYEdSvlBbb7l0932A9ORz1Myo7niio
 wfoKXSSFXKK/VeZzot3Tjfdju/Id0MTBhuGrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365912; x=1696970712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gpyswv5RJxParLYALomhg7e43ObDOfT08EaHKwu0GSg=;
 b=bXKbum9U88b2z9b4JpvS1/qtxxgMWsjMISYMXznIAUu5mHc+gyskENlu+RO9dJhhxh
 W+LUZc8oBjtrwuV7d4vkgLDHrzaSgzPfJ00cVIDWyHYEj+8TYlh1ULAGJMbrSO4oollz
 wODvQ7NOeShrtkLisLc8QzkZflNZxb1EdAEaFSeoxhTuo3FE05yabWB9Cq59CwOG4BkC
 +5pYF4sOYj16yJeeQLtv4pAbjmE9BWzYn2sbZ/qvwtMOyRkIW/0h9ee1x9twab6N6eJL
 1GQq+H6fp9JdTqxXYEJoEqbAL9yqMDLfdc56iUNBZttW8nojmLZd1/kehzZaQNdNG3am
 BhcQ==
X-Gm-Message-State: AOJu0Ywf6W/2fFTctWEsU69in0UnJIr0hieJepgABvwsv3MqQ1T99nlO
 7n9Yc3NYG/wVluZJoRlyAix8FX3n1/yFskUXSUA=
X-Google-Smtp-Source: AGHT+IHSAMNl8JBfxMEF60kwFFKkrDBGjWsjCBfwpS58U9whjdwDOjhNlas69enYEwbDcfxs62XIuw==
X-Received: by 2002:a17:90b:1b46:b0:277:3569:29fb with SMTP id
 nv6-20020a17090b1b4600b00277356929fbmr547820pjb.11.1696365912282; 
 Tue, 03 Oct 2023 13:45:12 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9076:49ec:5f9a:e5ec])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a17090aec1400b002777b8fc74bsm3739pjy.21.2023.10.03.13.45.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:45:11 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v15 7/9] gfxstream + rutabaga: meson support
Date: Tue,  3 Oct 2023 13:44:58 -0700
Message-Id: <20231003204500.518-8-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231003204500.518-1-gurchetansingh@chromium.org>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- Add meson detection of rutabaga_gfx
- Build virtio-gpu-rutabaga.c + associated vga/pci files when
  present

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/display/meson.build        | 22 ++++++++++++++++++++++
 meson.build                   |  7 +++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 34 insertions(+)

diff --git a/hw/display/meson.build b/hw/display/meson.build
index 413ba4ab24..e362d625dd 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -79,6 +79,13 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
                          if_true: [files('virtio-gpu-gl.c', 'virtio-gpu-virgl.c'), pixman, virgl])
     hw_display_modules += {'virtio-gpu-gl': virtio_gpu_gl_ss}
   endif
+
+  if rutabaga.found()
+    virtio_gpu_rutabaga_ss = ss.source_set()
+    virtio_gpu_rutabaga_ss.add(when: ['CONFIG_VIRTIO_GPU', rutabaga],
+                               if_true: [files('virtio-gpu-rutabaga.c'), pixman])
+    hw_display_modules += {'virtio-gpu-rutabaga': virtio_gpu_rutabaga_ss}
+  endif
 endif
 
 if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
@@ -95,6 +102,12 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
                              if_true: [files('virtio-gpu-pci-gl.c'), pixman])
     hw_display_modules += {'virtio-gpu-pci-gl': virtio_gpu_pci_gl_ss}
   endif
+  if rutabaga.found()
+    virtio_gpu_pci_rutabaga_ss = ss.source_set()
+    virtio_gpu_pci_rutabaga_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI', rutabaga],
+                                   if_true: [files('virtio-gpu-pci-rutabaga.c'), pixman])
+    hw_display_modules += {'virtio-gpu-pci-rutabaga': virtio_gpu_pci_rutabaga_ss}
+  endif
 endif
 
 if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
@@ -113,6 +126,15 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
   virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
                                             if_false: files('acpi-vga-stub.c'))
   hw_display_modules += {'virtio-vga-gl': virtio_vga_gl_ss}
+
+  if rutabaga.found()
+    virtio_vga_rutabaga_ss = ss.source_set()
+    virtio_vga_rutabaga_ss.add(when: ['CONFIG_VIRTIO_VGA', rutabaga],
+                               if_true: [files('virtio-vga-rutabaga.c'), pixman])
+    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
+                                                    if_false: files('acpi-vga-stub.c'))
+    hw_display_modules += {'virtio-vga-rutabaga': virtio_vga_rutabaga_ss}
+  endif
 endif
 
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
diff --git a/meson.build b/meson.build
index 21a1bc03f8..1228690880 100644
--- a/meson.build
+++ b/meson.build
@@ -1061,6 +1061,12 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
                                        dependencies: virgl))
   endif
 endif
+rutabaga = not_found
+if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
+  rutabaga = dependency('rutabaga_gfx_ffi',
+                         method: 'pkg-config',
+                         required: get_option('rutabaga_gfx'))
+endif
 blkio = not_found
 if not get_option('blkio').auto() or have_block
   blkio = dependency('blkio',
@@ -4299,6 +4305,7 @@ summary_info += {'libtasn1':          tasn1}
 summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
 summary_info += {'virgl support':     virgl}
+summary_info += {'rutabaga support':  rutabaga}
 summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
diff --git a/meson_options.txt b/meson_options.txt
index 57e265c871..aabc706b6d 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -230,6 +230,8 @@ option('vmnet', type : 'feature', value : 'auto',
        description: 'vmnet.framework network backend support')
 option('virglrenderer', type : 'feature', value : 'auto',
        description: 'virgl rendering support')
+option('rutabaga_gfx', type : 'feature', value : 'auto',
+       description: 'rutabaga_gfx support')
 option('png', type : 'feature', value : 'auto',
        description: 'PNG support with libpng')
 option('vnc', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e4b46d5715..8efbc9851c 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -157,6 +157,7 @@ meson_options_help() {
   printf "%s\n" '  rbd             Ceph block device driver'
   printf "%s\n" '  rdma            Enable RDMA-based migration'
   printf "%s\n" '  replication     replication support'
+  printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
   printf "%s\n" '  sdl             SDL user interface'
   printf "%s\n" '  sdl-image       SDL Image support for icons'
   printf "%s\n" '  seccomp         seccomp support'
@@ -428,6 +429,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
+    --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
     --disable-safe-stack) printf "%s" -Dsafe_stack=false ;;
     --enable-sanitizers) printf "%s" -Dsanitizers=true ;;
-- 
2.42.0.582.g8ccd20d70d-goog


