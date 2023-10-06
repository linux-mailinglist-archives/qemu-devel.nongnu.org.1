Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518617BAFF7
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 03:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoZKv-0001Cn-85; Thu, 05 Oct 2023 21:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKl-0001Ap-5d
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:08:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKj-000814-3K
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:08:50 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-694ed847889so1396255b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 18:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696554526; x=1697159326; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWlTwR1Z1KsMAoLWx+Ca1PzeErSCERFhjaimFwaoMpw=;
 b=nAmTcRJQGjWPh3MUxYOszlc6hkywHc4wAhEk9ZPWxk22BruAeimtOrmzYa4TbXvU8S
 pxxo7MjcodL9p0FGYCdEorJ2TyAFdgr7SsAJ7XpuTafEZVCDYq+TyzJw14Jslod9jTD/
 c40gZRWtNHCsQlED8aFNmRCraFGKZjpurFACA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696554526; x=1697159326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWlTwR1Z1KsMAoLWx+Ca1PzeErSCERFhjaimFwaoMpw=;
 b=hKy4BNRtqNLwOwMB6Flbzql5pSYm+jOZQr5YUPsWVat4/C7UPLIHaRr4aslnVD4yJw
 NU7yUO6grZbi0LH93+ZqMaP10OgDAD2h7DC9tCG45UME4kWKawhZHnfKKqRuKkLSV6sX
 vefRZ+Wrjo83nxdh9hzk9AXspzuJ69UK4owilQoM5aBAyQILI/LelyH7W8STpq+4gvyr
 dvKgtgtW5VWh6F3x+7nkbGdnSHfCMJs/aPJirtYzjIQ7UJgeQ9NxUDnjaBE38bTJURPT
 rBXxBtKsee4QDQd5yjpTwUAcHkkGr7xqA3KleT4ksWDbhuCXoesF3tmkB0+Uy/wBm9iS
 C5EA==
X-Gm-Message-State: AOJu0YyglAtKE1lpZ8YFluKZGbE3jINNxnu2SbYNGZ1+YHxp1uM9aeJ3
 0kMtAZOZZWnTO3fvkmYNWtEOLj2Swosf5d4pyig=
X-Google-Smtp-Source: AGHT+IETNNzHGqhdQ0GfKIEvMydNceg1OHH+ZMpW1r4WEiZyOruEmBpQ3S1VFWfvCVsYlKOapxfF7A==
X-Received: by 2002:a05:6a00:1911:b0:68f:f650:3035 with SMTP id
 y17-20020a056a00191100b0068ff6503035mr7418612pfi.12.1696554526509; 
 Thu, 05 Oct 2023 18:08:46 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:176a:c8b6:faa3:f083])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a62ed16000000b00690fe1c928csm215079pfh.147.2023.10.05.18.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 18:08:46 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v17 7/9] gfxstream + rutabaga: meson support
Date: Thu,  5 Oct 2023 18:08:33 -0700
Message-Id: <20231006010835.444-8-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231006010835.444-1-gurchetansingh@chromium.org>
References: <20231006010835.444-1-gurchetansingh@chromium.org>
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
index 05619c6968..2b64fd9f9d 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -80,6 +80,13 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
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
@@ -96,6 +103,12 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
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
@@ -114,6 +127,15 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
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
index 3bb64b536c..65848a662a 100644
--- a/meson.build
+++ b/meson.build
@@ -1046,6 +1046,12 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
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
@@ -4277,6 +4283,7 @@ summary_info += {'libtasn1':          tasn1}
 summary_info += {'PAM':               pam}
 summary_info += {'iconv support':     iconv}
 summary_info += {'virgl support':     virgl}
+summary_info += {'rutabaga support':  rutabaga}
 summary_info += {'blkio support':     blkio}
 summary_info += {'curl support':      curl}
 summary_info += {'Multipath support': mpathpersist}
diff --git a/meson_options.txt b/meson_options.txt
index 6a17b90968..e49309dd78 100644
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
index 2a74b0275b..a28ccbcaf6 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -156,6 +156,7 @@ meson_options_help() {
   printf "%s\n" '  rbd             Ceph block device driver'
   printf "%s\n" '  rdma            Enable RDMA-based migration'
   printf "%s\n" '  replication     replication support'
+  printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
   printf "%s\n" '  sdl             SDL user interface'
   printf "%s\n" '  sdl-image       SDL Image support for icons'
   printf "%s\n" '  seccomp         seccomp support'
@@ -425,6 +426,8 @@ _meson_option_parse() {
     --disable-replication) printf "%s" -Dreplication=disabled ;;
     --enable-rng-none) printf "%s" -Drng_none=true ;;
     --disable-rng-none) printf "%s" -Drng_none=false ;;
+    --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
+    --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
     --disable-safe-stack) printf "%s" -Dsafe_stack=false ;;
     --enable-sanitizers) printf "%s" -Dsanitizers=true ;;
-- 
2.42.0.609.gbb76f46606-goog


