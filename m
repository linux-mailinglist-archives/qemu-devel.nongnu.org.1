Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219F74E48A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3Ys-00038H-Ly; Mon, 10 Jul 2023 22:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yp-00037i-7e
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:07 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yn-0005QL-Jk
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:07 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a1d9b64837so4295447b6e.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689044224; x=1691636224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqXouu/xuL4E/uspAEQo9q0+Yn3fADNlmZ6CeuKZvaQ=;
 b=TPg0am6dy95MzN3xReAoqTZVhwzrgnHDAfx8B2hpQwxJn7ImkLAJbNPQGGCMy7jZwF
 0XV//im/E8psEO7GtMWXppu+3NV1x/i0dYH6dxr747pe5B6n2uY1YWB6cp1E5Q5XQmbQ
 EhSx/iXzcXZ3xNvf4+3IAEHxJy/nbYkTmK824=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044224; x=1691636224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqXouu/xuL4E/uspAEQo9q0+Yn3fADNlmZ6CeuKZvaQ=;
 b=C5+Yns0czywUlh2G8sEAinvrXrkKMkfInHcdiWzz6y0J4qbD9ELofYH1EyFZma/JRA
 I0j71vDfCSQ6OOIiEkndT0E03ap7rNgaed1FongCMiax+Mst1tyXL3wP1qb8GAS2wMkw
 TbuSJxKcfQvgNYJbm51jtiOvMlgUFpyvU1RYTnCUQgz3BEFXcnSw01c/LVDDy392IKeb
 Ken8ghMAUEd/SWlxBAuRcrgxqGnRG7nLUlwWzgLLK3ts6VPOA6tcEyNwQmqezTpaRIDs
 /00MyGlVvSsMffcq0hB6EDuAtoSoF9pNOcw5mvd0mwfgOX4jZSeR1Mm2kWZ5nwxXH91m
 C2ag==
X-Gm-Message-State: ABy/qLZiSYNhPI4C0XAyHse659QMVR/47NlB/fw+p6A89rvVzEIDXEmp
 +Vk4hi87xF42lKCVYXVDaeDDBrkO94ko5cRlLRI=
X-Google-Smtp-Source: APBJJlEVr51s2DoiczYTgQTFvcRe9BUl/uWPQmbY7v0MfXDr0YRA/HznewYUNgDORyXJzwoJOiD0Vg==
X-Received: by 2002:a05:6808:14d6:b0:3a4:18ff:19a3 with SMTP id
 f22-20020a05680814d600b003a418ff19a3mr1035457oiw.47.1689044224167; 
 Mon, 10 Jul 2023 19:57:04 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9292:a9df:b174:f1eb])
 by smtp.gmail.com with ESMTPSA id
 fk13-20020a056a003a8d00b0067903510abbsm474614pfb.163.2023.07.10.19.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 19:57:02 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com
Subject: [PATCH v1 7/9] gfxstream + rutabaga: meson support
Date: Mon, 10 Jul 2023 19:56:47 -0700
Message-Id: <20230711025649.708-8-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230711025649.708-1-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

- Add meson detection of rutabaga_gfx
- Build virtio-gpu-rutabaga.c + associated vga/pci files when
  present

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 hw/display/meson.build        | 22 ++++++++++++++++++++++
 meson.build                   |  7 +++++++
 meson_options.txt             |  2 ++
 scripts/meson-buildoptions.sh |  3 +++
 4 files changed, 34 insertions(+)

diff --git a/hw/display/meson.build b/hw/display/meson.build
index 413ba4ab24..10e41e4eef 100644
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
+                         if_true: [files('virtio-gpu-rutabaga.c'), pixman])
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
+                       if_true: [files('virtio-gpu-pci-rutabaga.c'), pixman])
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
+                         if_true: [files('virtio-vga-rutabaga.c'), pixman])
+    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
+                                                   if_false: files('acpi-vga-stub.c'))
+    hw_display_modules += {'virtio-vga-rutabaga': virtio_vga_rutabaga_ss}
+  endif
 endif
 
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
diff --git a/meson.build b/meson.build
index 5fcdb37a71..c7b4811220 100644
--- a/meson.build
+++ b/meson.build
@@ -1069,6 +1069,12 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
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
@@ -4272,6 +4278,7 @@ summary_info += {'libtasn1':          tasn1}
 summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
 summary_info += {'virgl support':     virgl}
+summary_info += {'rutabaga support':  rutabaga}
 summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
diff --git a/meson_options.txt b/meson_options.txt
index bbb5c7e886..d7998655a8 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -224,6 +224,8 @@ option('vmnet', type : 'feature', value : 'auto',
        description: 'vmnet.framework network backend support')
 option('virglrenderer', type : 'feature', value : 'auto',
        description: 'virgl rendering support')
+option('rutabaga_gfx', type : 'feature', value : 'auto',
+       description: 'rutabaga_gfx support')
 option('png', type : 'feature', value : 'auto',
        description: 'PNG support with libpng')
 option('vnc', type : 'feature', value : 'auto',
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 7dd5709ef4..92af437271 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -154,6 +154,7 @@ meson_options_help() {
   printf "%s\n" '  rbd             Ceph block device driver'
   printf "%s\n" '  rdma            Enable RDMA-based migration'
   printf "%s\n" '  replication     replication support'
+  printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
   printf "%s\n" '  sdl             SDL user interface'
   printf "%s\n" '  sdl-image       SDL Image support for icons'
   printf "%s\n" '  seccomp         seccomp support'
@@ -419,6 +420,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
+    --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
     --disable-safe-stack) printf "%s" -Dsafe_stack=false ;;
     --enable-sanitizers) printf "%s" -Dsanitizers=true ;;
-- 
2.41.0.255.g8b1d071c50-goog


