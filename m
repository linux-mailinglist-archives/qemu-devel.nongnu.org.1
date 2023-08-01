Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BDE76A62F
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:19:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQe1C-0001bc-Ls; Mon, 31 Jul 2023 21:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe1A-0001bD-T3
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:44 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe18-0003Im-Ng
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:44 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-267fc1d776eso2973213a91.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690852661; x=1691457461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YuEb+6f7FmoR6RBCOdj2GRfaU1b++dbBjgDXqKfp+V4=;
 b=PYpd0ToJ7PZRyEQHZu53NTJDMwJl1rCFx+Ssob07QrMh62Tm9ql6ikRAy9P0JKrZpE
 e+jDBxRPUfgfIrMZj0zT0ACHp3E107/xXe5J99L8J+pav/mJkKxlcZ3f2rd36wq0DG5J
 ZPqlQAWEImK5nRnsFvgCREB49uPf6aqLCs1gI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690852661; x=1691457461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YuEb+6f7FmoR6RBCOdj2GRfaU1b++dbBjgDXqKfp+V4=;
 b=Fk168lMPXBSqcu+elyosbhtWOPy0tttL/y2MGRoY5n6W877Dp1QV2oFDxGw1UJFTYm
 nesyX09HEs6jQOSY1mxmbSPGN/CwAWgRGpY0FcjoIpfOq3YRsM4vTv8W2M13Ehn9BRg+
 3i6zDpcHRCeCHSWxSqpgiksRqnI8dLDkF4QXdQLftfoiRSYI76ZUgjmzTlYOdWZ9+cEk
 8EQxw3Y6PPfd13wkl1fvPYfGkHiAEy7yWWM/jTFqwxvjtt0OoVwAbcHY0DjhtRCIvmav
 js11rI3GTr0VbNe7lOHspJAhTobAN6A9itg4em5A+083osbcxOECSUPjVQwpCdoIvKv4
 jq0Q==
X-Gm-Message-State: ABy/qLZ/HsJFhPr7oaVlqBtKcFMRW2UrI8JhoukVm5Wf/OhXhCcLnTME
 5bErw64qvECHc+agj4iQmTGdrnbC9hYHzU1XdfA=
X-Google-Smtp-Source: APBJJlHJlPZdNEgkeu5/0e/Ut1JnYz8wQ3ft/SeT3um1hRCCE1T/E6zWLLr9cESq/WpvkyBu91vZJw==
X-Received: by 2002:a17:90a:8905:b0:268:6e77:2024 with SMTP id
 u5-20020a17090a890500b002686e772024mr9318914pjn.22.1690852660825; 
 Mon, 31 Jul 2023 18:17:40 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:cb47:8a0d:6476:3e7b])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a17090a899400b00260a5ecd273sm6657722pjn.1.2023.07.31.18.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 18:17:40 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v2 7/9] gfxstream + rutabaga: meson support
Date: Mon, 31 Jul 2023 18:17:21 -0700
Message-Id: <20230801011723.627-8-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230801011723.627-1-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pj1-x1031.google.com
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
index 98e68ef0b1..293f388e53 100644
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
index aaea5ddd77..dea3bf7d9c 100644
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
index 9da3fe299b..9a95b4f782 100644
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
2.41.0.585.gd2178a4bd4-goog


