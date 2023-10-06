Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 034727BAFF6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 03:10:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoZKq-0001Bt-C3; Thu, 05 Oct 2023 21:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKm-0001BB-F2
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:08:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qoZKk-00081R-6w
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 21:08:52 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so1165978a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 18:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696554528; x=1697159328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7KZ0M1sUeKlLjtjmts+CMUJNPzRr3inAZiV81XK6Fc=;
 b=Gtnbb2GpwzywL3Y1twBcpAck3+M3LCiNlaZIzWc8lPQEFayU2fOeW8wBrrd3jnd7D1
 42lamHpX1kFwWgOyDbsxvyJ/E5rspmt7GZaBB9TFPvBr/aCXR5hZU4gTEnLlfnjTizwr
 CyvBhyTi3O0X+z2uTDWzxoxZ9XXW0U0kYPut8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696554528; x=1697159328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7KZ0M1sUeKlLjtjmts+CMUJNPzRr3inAZiV81XK6Fc=;
 b=ILPXBhGV0hf1hzleRwHlWUSTIetYmmVPoi9RUzJQ1zdcog0n+UMhk5LA+UaT6BzH2P
 2v42/x9i031BLoW6nE+egLLIWzVyYLwAln0oEwERlO1mWY1I8RM3rnT7El/0iqmUQMet
 YTvlJYneSkOx13bWLfNn1pJtFpmE/vnCaqBYVn7AjXotFL3W40nFOiOm9B7i+ycvDLjD
 F61OP9Rk4YioGmQUjN6iBHvftliSAyxRC86cd+DXOges9YduYaeRyjvk67kGfN65e01r
 /oQH9eCIQF85JRsh0IhgUysNGWApdIzFYGZFYn0p6sL3KNFXNalGV9GSN1E4Omy6hjdo
 jZ7A==
X-Gm-Message-State: AOJu0YxxTJHMp/CdlTnwYxAdoXk9aPvEG27WDcP2ytVkHj+csg3GKrYy
 v9j2mHfGdxrmx+yMp8Hkwt5TpaTQ9sa90etg5EM=
X-Google-Smtp-Source: AGHT+IE0p5qnfepiHxkKUYf01RQokr/lFBLWH+xb9uET3sd2b2YBGTRk/09PkmMYG0R6A0GvWRvWmA==
X-Received: by 2002:a05:6a21:6da0:b0:14d:446f:7212 with SMTP id
 wl32-20020a056a216da000b0014d446f7212mr7846459pzb.46.1696554527694; 
 Thu, 05 Oct 2023 18:08:47 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:176a:c8b6:faa3:f083])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a62ed16000000b00690fe1c928csm215079pfh.147.2023.10.05.18.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 18:08:47 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v17 8/9] gfxstream + rutabaga: enable rutabaga
Date: Thu,  5 Oct 2023 18:08:34 -0700
Message-Id: <20231006010835.444-9-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231006010835.444-1-gurchetansingh@chromium.org>
References: <20231006010835.444-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pg1-x52f.google.com
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

This change enables rutabaga to receive virtio-gpu-3d hypercalls
when it is active.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/display/virtio-gpu-base.c | 3 ++-
 hw/display/virtio-gpu.c      | 5 +++--
 softmmu/qdev-monitor.c       | 3 +++
 softmmu/vl.c                 | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 4f2b0ba1f3..50c5373b65 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -223,7 +223,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
 {
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(vdev);
 
-    if (virtio_gpu_virgl_enabled(g->conf)) {
+    if (virtio_gpu_virgl_enabled(g->conf) ||
+        virtio_gpu_rutabaga_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_VIRGL);
     }
     if (virtio_gpu_edid_enabled(g->conf)) {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index be16efbd38..6efd15b6ae 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1363,8 +1363,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     VirtIOGPU *g = VIRTIO_GPU(qdev);
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
-        if (!virtio_gpu_have_udmabuf()) {
-            error_setg(errp, "cannot enable blob resources without udmabuf");
+        if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
+            !virtio_gpu_have_udmabuf()) {
+            error_setg(errp, "need rutabaga or udmabuf for blob resources");
             return;
         }
 
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index 74f4e41338..1b8005ae55 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -86,6 +86,9 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
+    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
+      QEMU_ARCH_VIRTIO_MMIO },
+    { "virtio-gpu-rutabaga-pci", "virtio-gpu-rutabaga", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-input-host-device", "virtio-input-host", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-input-host-ccw", "virtio-input-host", QEMU_ARCH_VIRTIO_CCW },
     { "virtio-input-host-pci", "virtio-input-host", QEMU_ARCH_VIRTIO_PCI },
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..dd82c6eb13 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -215,6 +215,7 @@ static struct {
     { .driver = "ati-vga",              .flag = &default_vga       },
     { .driver = "vhost-user-vga",       .flag = &default_vga       },
     { .driver = "virtio-vga-gl",        .flag = &default_vga       },
+    { .driver = "virtio-vga-rutabaga",  .flag = &default_vga       },
 };
 
 static QemuOptsList qemu_rtc_opts = {
-- 
2.42.0.609.gbb76f46606-goog


