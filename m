Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F328D77CEA9
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 17:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvbb-0002lB-Su; Tue, 15 Aug 2023 11:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVvbQ-0002jj-Rh
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:05:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVvbM-0000fN-5z
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:04:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fe8a158fcbso36655365e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111894; x=1692716694;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tvZgowsaa/1Kkm5wjVw/FgPCPEFVvPn0xYTShBZj4aU=;
 b=HC8Ig0uLmwypyxSXT6a9g6suA8JAzdfM6fNXKGCRf2vTdlMpLC2tH4o0OzfWYMFb8C
 W/hWAgM1elmpTr0yFyY7pNR6JcEbPkPISVc6p3GdWXVZGVk8LhAX+emoP3AKGFHOz9pr
 PeFBkqQ10vFBurhiuck68FJLTZ7zoWrhwMrPv3nrt3+PTtaSePdjebsiup4BsiDTpgy/
 pwNZB/Kmv4DtHgzjDL4L27PFArpMD4aNaaZydK/baXSoNupsUfFoa2UqOU5WfZhq+lEf
 1AiYd2LG0aHFTszUY8jVi5M1I4naym8Zs6/mlG9/+xP4oRHgaey30+SbvpQgJdmvVyDl
 4lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111894; x=1692716694;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tvZgowsaa/1Kkm5wjVw/FgPCPEFVvPn0xYTShBZj4aU=;
 b=RhYA7mnK7KC6xAUquUVUsCDc7Q1Yvf48dLbdErC69eXK4Qo6/ajMM+QwU6l9NzyARq
 sFdLeGCQccSl0s443FkmomYzUAMdlsXEBDq34Z9PI1/ECSWaz587VXz5vBcId4SIRaA9
 bO3KaZOzXD6ayNatxjtbYQAa66vbJrOXGp/TzCbVpjnKakkDU8k0e8o+8k+yJnIc5SBi
 qpDVXVstgP2Gg9waJ95LyJmY5AvWzBRo/69zpTwgYkRhIbFHBvDHCk2gnLrkwkLXTJvJ
 NNszH6Y1Vaq/gwqIxCnMaY0uyj5KDCTSxY3UTqe48tGwALg9RBRM168quEomolO8DE2e
 w4cg==
X-Gm-Message-State: AOJu0YxVGXLOEBWqMkPhfeQWn+3WQq0YBHHScoIJ6m/8YwpsmwOhiufa
 C5dZRW2zLT/jB3hcno1mNHFJ8c4eFt7CjoNy6RE=
X-Google-Smtp-Source: AGHT+IHbb4U7ARsjistlgY3Q8taH4uLNwAEsqlxBBR3YyhAsXlmrVVfe4iqfzzFui37QZ4yNm3wQaA==
X-Received: by 2002:adf:e74f:0:b0:317:6314:96e2 with SMTP id
 c15-20020adfe74f000000b00317631496e2mr9246321wrn.14.1692111893703; 
 Tue, 15 Aug 2023 08:04:53 -0700 (PDT)
Received: from meli.delivery (adsl-104.37.6.161.tellas.gr. [37.6.161.104])
 by smtp.gmail.com with ESMTPSA id
 i5-20020adff305000000b0031980294e9fsm4578639wro.116.2023.08.15.08.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 08:04:53 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:03:13 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: Re: [PATCH v5 7/9] gfxstream + rutabaga: meson support
User-Agent: meli 0.7.3
References: <20230815003526.631-1-gurchetansingh@chromium.org>
 <20230815003526.631-8-gurchetansingh@chromium.org>
In-Reply-To: <20230815003526.631-8-gurchetansingh@chromium.org>
Message-ID: <zftw3.2nufh1qqd8m@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

On Tue, 15 Aug 2023 03:35, Gurchetan Singh <gurchetansingh@chromium.org> wrote:
>- Add meson detection of rutabaga_gfx
>- Build virtio-gpu-rutabaga.c + associated vga/pci files when
>  present
>
>Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>Tested-by: Alyssa Ross <hi@alyssa.is>
>---
>v3: Fix alignment issues (Akihiko)
>
> hw/display/meson.build        | 22 ++++++++++++++++++++++
> meson.build                   |  7 +++++++
> meson_options.txt             |  2 ++
> scripts/meson-buildoptions.sh |  3 +++
> 4 files changed, 34 insertions(+)
>
>diff --git a/hw/display/meson.build b/hw/display/meson.build
>index 413ba4ab24..e362d625dd 100644
>--- a/hw/display/meson.build
>+++ b/hw/display/meson.build
>@@ -79,6 +79,13 @@ if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
>                          if_true: [files('virtio-gpu-gl.c', 'virtio-gpu-virgl.c'), pixman, virgl])
>     hw_display_modules += {'virtio-gpu-gl': virtio_gpu_gl_ss}
>   endif
>+
>+  if rutabaga.found()
>+    virtio_gpu_rutabaga_ss = ss.source_set()
>+    virtio_gpu_rutabaga_ss.add(when: ['CONFIG_VIRTIO_GPU', rutabaga],
>+                               if_true: [files('virtio-gpu-rutabaga.c'), pixman])
>+    hw_display_modules += {'virtio-gpu-rutabaga': virtio_gpu_rutabaga_ss}
>+  endif
> endif
> 
> if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
>@@ -95,6 +102,12 @@ if config_all_devices.has_key('CONFIG_VIRTIO_PCI')
>                              if_true: [files('virtio-gpu-pci-gl.c'), pixman])
>     hw_display_modules += {'virtio-gpu-pci-gl': virtio_gpu_pci_gl_ss}
>   endif
>+  if rutabaga.found()
>+    virtio_gpu_pci_rutabaga_ss = ss.source_set()
>+    virtio_gpu_pci_rutabaga_ss.add(when: ['CONFIG_VIRTIO_GPU', 'CONFIG_VIRTIO_PCI', rutabaga],
>+                                   if_true: [files('virtio-gpu-pci-rutabaga.c'), pixman])
>+    hw_display_modules += {'virtio-gpu-pci-rutabaga': virtio_gpu_pci_rutabaga_ss}
>+  endif
> endif
> 
> if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
>@@ -113,6 +126,15 @@ if config_all_devices.has_key('CONFIG_VIRTIO_VGA')
>   virtio_vga_gl_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
>                                             if_false: files('acpi-vga-stub.c'))
>   hw_display_modules += {'virtio-vga-gl': virtio_vga_gl_ss}
>+
>+  if rutabaga.found()
>+    virtio_vga_rutabaga_ss = ss.source_set()
>+    virtio_vga_rutabaga_ss.add(when: ['CONFIG_VIRTIO_VGA', rutabaga],
>+                               if_true: [files('virtio-vga-rutabaga.c'), pixman])
>+    virtio_vga_rutabaga_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-vga.c'),
>+                                                    if_false: files('acpi-vga-stub.c'))
>+    hw_display_modules += {'virtio-vga-rutabaga': virtio_vga_rutabaga_ss}
>+  endif
> endif
> 
> system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_lcdc.c'))
>diff --git a/meson.build b/meson.build
>index 98e68ef0b1..293f388e53 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -1069,6 +1069,12 @@ if not get_option('virglrenderer').auto() or have_system or have_vhost_user_gpu
>                                        dependencies: virgl))
>   endif
> endif
>+rutabaga = not_found
>+if not get_option('rutabaga_gfx').auto() or have_system or have_vhost_user_gpu
>+  rutabaga = dependency('rutabaga_gfx_ffi',
>+                         method: 'pkg-config',
>+                         required: get_option('rutabaga_gfx'))
>+endif
> blkio = not_found
> if not get_option('blkio').auto() or have_block
>   blkio = dependency('blkio',
>@@ -4272,6 +4278,7 @@ summary_info += {'libtasn1':          tasn1}
> summary_info += {'PAM':               pam}
> summary_info += {'iconv support':     iconv}
> summary_info += {'virgl support':     virgl}
>+summary_info += {'rutabaga support':  rutabaga}
> summary_info += {'blkio support':     blkio}
> summary_info += {'curl support':      curl}
> summary_info += {'Multipath support': mpathpersist}
>diff --git a/meson_options.txt b/meson_options.txt
>index aaea5ddd77..dea3bf7d9c 100644
>--- a/meson_options.txt
>+++ b/meson_options.txt
>@@ -224,6 +224,8 @@ option('vmnet', type : 'feature', value : 'auto',
>        description: 'vmnet.framework network backend support')
> option('virglrenderer', type : 'feature', value : 'auto',
>        description: 'virgl rendering support')
>+option('rutabaga_gfx', type : 'feature', value : 'auto',
>+       description: 'rutabaga_gfx support')
> option('png', type : 'feature', value : 'auto',
>        description: 'PNG support with libpng')
> option('vnc', type : 'feature', value : 'auto',
>diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
>index 9da3fe299b..9a95b4f782 100644
>--- a/scripts/meson-buildoptions.sh
>+++ b/scripts/meson-buildoptions.sh
>@@ -154,6 +154,7 @@ meson_options_help() {
>   printf "%s\n" '  rbd             Ceph block device driver'
>   printf "%s\n" '  rdma            Enable RDMA-based migration'
>   printf "%s\n" '  replication     replication support'
>+  printf "%s\n" '  rutabaga-gfx    rutabaga_gfx support'
>   printf "%s\n" '  sdl             SDL user interface'
>   printf "%s\n" '  sdl-image       SDL Image support for icons'
>   printf "%s\n" '  seccomp         seccomp support'
>@@ -419,6 +420,8 @@ _meson_option_parse() {
>     --disable-replication) printf "%s" -Dreplication=disabled ;;
>     --enable-rng-none) printf "%s" -Drng_none=true ;;
>     --disable-rng-none) printf "%s" -Drng_none=false ;;
>+    --enable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=enabled ;;
>+    --disable-rutabaga-gfx) printf "%s" -Drutabaga_gfx=disabled ;;
>     --enable-safe-stack) printf "%s" -Dsafe_stack=true ;;
>     --disable-safe-stack) printf "%s" -Dsafe_stack=false ;;
>     --enable-sanitizers) printf "%s" -Dsanitizers=true ;;
>-- 
>2.41.0.694.ge786442a9b-goog
>
>

