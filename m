Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6B777CEAD
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 17:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvd1-0004Gf-JF; Tue, 15 Aug 2023 11:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVvcz-0004GW-VI
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:06:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVvcy-0001Cl-8q
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:06:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fe4b45a336so49909035e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692111994; x=1692716794;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JOBUQnqibieXn/JOA7QOa3fk1mk4ZkPAqCuRktAMdM0=;
 b=BkdDYJ18ki7XoRX71pBKOBuVeCUzhZy3vskVIFSF22fyZXL4EtZfreMrMU6hEfpFT8
 K3V1GePPVjec0AfB1VKZiY0LvYxLbAuNbmT1LxGYQhnEsVwNGop7aDYNpPYYCFoTnOHa
 7BWyrofTKPK8hSTLKmLTeTGMIL5R2khq4IHNzKVUEcq55D4lg8BeglHqOTSYTimt+Pop
 paNTMmBum1r52HN4/LVZMlupL0Rytd7F+Sk5unnJ3o79TIIoOAH2pUT5aIDJkutv0x04
 Ii9UF6eGFahX0c6blpc7dAykzGNW6bbtiwE97bGYo2chFeZIywl6MspFt+bAHNBI3ch/
 +ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692111994; x=1692716794;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JOBUQnqibieXn/JOA7QOa3fk1mk4ZkPAqCuRktAMdM0=;
 b=aqOEr+MK9oNTRpFUMexXqzYNJXeKiQPAKbKEcqqSmlNvRL2fjF8utZXfLTvHM/vIHy
 ZEF1Z+BEjpGCzBVoogY1l1xYJYvHdZXK6M5qNzdLL6xjKtz8KbEkl2/xTc48L647pQiC
 NgI8fIC3uu9gwySjBxdnkkg9LVQuvsmPb0Dar4g3zOuVaCqwncDZ1meRFJmR4Lyd7bdV
 0aWDt26f5w5TGe9bDi1+cVw7ksKdP5CqVdUo3d3E5zLmkQybx7U+0jTsDwFFok64CGMD
 yV1yP0ErZkhWIZW64FGrI4L0ygKRgCSDxvoP1BAAPuI0YNkN0jCo2TTmGJVOyGem4tON
 1SfA==
X-Gm-Message-State: AOJu0Yw33rPtOrniEYZgpA2byUqZAolG+FBvJ1QCD39R+xyuNuFZSAZp
 k9Xq/IvgxvSg10X9KtGs8rbZzOYbgqcUcAHvNLw=
X-Google-Smtp-Source: AGHT+IEqSdv4qX7be++3JHshapxv8KIDp9OR13kVyJIpNPu0dAxFr2mXHwl0Lrzqdee7LZw/qNHWnA==
X-Received: by 2002:adf:ec45:0:b0:315:a34f:b520 with SMTP id
 w5-20020adfec45000000b00315a34fb520mr7956026wrn.71.1692111994235; 
 Tue, 15 Aug 2023 08:06:34 -0700 (PDT)
Received: from meli.delivery (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 m15-20020adffe4f000000b00317909f9985sm3320579wrs.113.2023.08.15.08.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 08:06:33 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:06:15 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: Re: [PATCH v5 8/9] gfxstream + rutabaga: enable rutabaga
User-Agent: meli 0.7.3
References: <20230815003526.631-1-gurchetansingh@chromium.org>
 <20230815003526.631-9-gurchetansingh@chromium.org>
In-Reply-To: <20230815003526.631-9-gurchetansingh@chromium.org>
Message-ID: <zftyv.p48gkj2x7wof@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x334.google.com
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
>This change enables rutabaga to receive virtio-gpu-3d hypercalls
>when it is active.
>
>Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>Tested-by: Alyssa Ross <hi@alyssa.is>
>---
>v3: Whitespace fix (Akihiko)
>
> hw/display/virtio-gpu-base.c | 3 ++-
> hw/display/virtio-gpu.c      | 5 +++--
> softmmu/qdev-monitor.c       | 3 +++
> softmmu/vl.c                 | 1 +
> 4 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
>index 4f2b0ba1f3..50c5373b65 100644
>--- a/hw/display/virtio-gpu-base.c
>+++ b/hw/display/virtio-gpu-base.c
>@@ -223,7 +223,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
> {
>     VirtIOGPUBase *g = VIRTIO_GPU_BASE(vdev);
> 
>-    if (virtio_gpu_virgl_enabled(g->conf)) {
>+    if (virtio_gpu_virgl_enabled(g->conf) ||
>+        virtio_gpu_rutabaga_enabled(g->conf)) {
>         features |= (1 << VIRTIO_GPU_F_VIRGL);
>     }
>     if (virtio_gpu_edid_enabled(g->conf)) {
>diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>index 3e658f1fef..08e170e029 100644
>--- a/hw/display/virtio-gpu.c
>+++ b/hw/display/virtio-gpu.c
>@@ -1361,8 +1361,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>     VirtIOGPU *g = VIRTIO_GPU(qdev);
> 
>     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
>-        if (!virtio_gpu_have_udmabuf()) {
>-            error_setg(errp, "cannot enable blob resources without udmabuf");
>+        if (!virtio_gpu_have_udmabuf() &&
>+            !virtio_gpu_rutabaga_enabled(g->parent_obj.conf)) {
>+            error_setg(errp, "need udmabuf or rutabaga for blob resources");
>             return;
>         }
> 
>diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
>index 74f4e41338..1b8005ae55 100644
>--- a/softmmu/qdev-monitor.c
>+++ b/softmmu/qdev-monitor.c
>@@ -86,6 +86,9 @@ static const QDevAlias qdev_alias_table[] = {
>     { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
>     { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
>     { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
>+    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
>+      QEMU_ARCH_VIRTIO_MMIO },
>+    { "virtio-gpu-rutabaga-pci", "virtio-gpu-rutabaga", QEMU_ARCH_VIRTIO_PCI },
>     { "virtio-input-host-device", "virtio-input-host", QEMU_ARCH_VIRTIO_MMIO },
>     { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_VIRTIO_CCW },
>     { "virtio-input-host-pci", "virtio-input-host", QEMU_ARCH_VIRTIO_PCI },
>diff --git a/softmmu/vl.c b/softmmu/vl.c
>index b0b96f67fa..2f98eefdf3 100644
>--- a/softmmu/vl.c
>+++ b/softmmu/vl.c
>@@ -216,6 +216,7 @@ static struct {
>     { .driver = "ati-vga",              .flag = &default_vga       },
>     { .driver = "vhost-user-vga",       .flag = &default_vga       },
>     { .driver = "virtio-vga-gl",        .flag = &default_vga       },
>+    { .driver = "virtio-vga-rutabaga",  .flag = &default_vga       },
> };
> 
> static QemuOptsList qemu_rtc_opts = {
>-- 
>2.41.0.694.ge786442a9b-goog
>
>

