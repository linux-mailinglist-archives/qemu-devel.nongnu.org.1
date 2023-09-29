Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF97B3B18
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 22:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmJs9-0007bY-GT; Fri, 29 Sep 2023 16:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJs7-0007bM-DX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:59 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJs3-0004Kv-RA
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-692a885f129so10483431b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696018434; x=1696623234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=39AxELZdpnvLtvcdR+zVBAFROvLoU6Rddg7tcrNIFUk=;
 b=LXHKhNh+HVFKYNLNSFVqvoclUHzYtiwl3fKJG5yV/ldoFQ9JlLPd9Ovdvv0UzY8eJ+
 nbS6N2o85tEOnMFcatizLLnvtzgOo4NFXFmYu0r6Op8PsoOdpZlJYC+r/TpPPOTvLBeP
 p/DuxtYpoZ/b9d6CPOrmtk9sDFZi3C6K9OJqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696018434; x=1696623234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=39AxELZdpnvLtvcdR+zVBAFROvLoU6Rddg7tcrNIFUk=;
 b=mGFQhrcNKp91e23/pftLDXB6FQFGYmYVklFX10bH0AFYCQwxdTUOvqKVzyDc5gx86o
 SpEdgf/fWTrC/Lj9xX98O1HjcwREocdof6A9KzuxlGOaeH25XevVuFGMoMrmxgRt/VAZ
 nWXOI2y79ArDHnG7XI9mIbDYyV+Zrsm+Dg9iih2FEKxkiwu5bZGFLeB+jnRYTUrfEr0O
 7kdd2s6oZj160uO8ojdmrr5W/aZEmlsrnlqL0iFlf9a/0dnlCP6lOWv58yNgbiXgNbU+
 ZVDmgjz1LIYnhyGRXFewEUwd80VBIR5C1fPQw7L38zcUr2ViWUWVMWVTxdb8FLeDKYi6
 +R8Q==
X-Gm-Message-State: AOJu0YzFfx2Gwtg6Cpr0nka7MvYjP1+4OWGhLxu5sjSxyw/cOUwcwugm
 oIJEX7vHQuNMim1P7lFJ6at9AONigDyu+LuThX0=
X-Google-Smtp-Source: AGHT+IFyg6xtxX/JFsKhqmTfyy6mBtQrUbOlGwhKjLJO2CEAkscuFQaKSnLYipSJ+0f7u3eMd4QXnA==
X-Received: by 2002:a05:6a20:8f20:b0:157:54fd:5c26 with SMTP id
 b32-20020a056a208f2000b0015754fd5c26mr5796566pzk.38.1696018434226; 
 Fri, 29 Sep 2023 13:13:54 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:18fe:3fb1:d86b:1e68])
 by smtp.gmail.com with ESMTPSA id
 t12-20020aa7938c000000b00686236718d8sm15267033pfe.41.2023.09.29.13.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 13:13:53 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v14 7/9] gfxstream + rutabaga: meson support
Date: Fri, 29 Sep 2023 13:13:39 -0700
Message-Id: <20230929201341.332-8-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230929201341.332-1-gurchetansingh@chromium.org>
References: <20230929201341.332-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x436.google.com
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
index 5139db2ff7..1e12c2964d 100644
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
@@ -4293,6 +4299,7 @@ summary_info += {'libtasn1':          tasn1}
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


