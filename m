Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D2B77C487
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 02:37:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVi2L-0004LS-C1; Mon, 14 Aug 2023 20:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVi2C-0004JQ-CK
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 20:35:45 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVi2A-0004t4-Iw
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 20:35:44 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bdf7086ae5so3355655ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692059741; x=1692664541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BbX4SiJiD1/M04UKrFX9OEYbdFwvv/Egndjkvd4TWH0=;
 b=EdGFvlRS/5zc+2n/gq4L/JhB6GZ3Sxg7Me9lOyAX3xPjGPwGLOHhdCEeErEKONBkOJ
 9zjdkaX8yq7Qh1BmgSnpbATDFQ7SlOYVlzWGeXdMg0db05rPf2uXfGNkSvZIJ3umfeS7
 fIBglbX84tyGBbls1L0/QUtbS1aOlvBd0uJ74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692059741; x=1692664541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BbX4SiJiD1/M04UKrFX9OEYbdFwvv/Egndjkvd4TWH0=;
 b=LkdHufazQXBtRoJdhnppSSy6p82fM2khTNr1tw7l+/vNvSvwu9kdMQL8PDu4EBknVZ
 a4uD3klmglVxo4ueRFg8jMic0I9jUrlw94bEYppV1s+BxJpzhlOgadtYpXcHrLPXXTDs
 TyjDrQc9ubostfxJ+AtVSv4zZFLsbbRFz4heI0L2U6AiPwXnGtITAThz9C2zfsPVjAAo
 +xHN9coevZ/RE0KE5YKEOGR5XwYfqng13r8Epw5ieVtq4HgpIsc7BhWdMlPwxw0eer4F
 xHdLH1bHUm2SQ9BHd3Yq+IfzXeSMhChdDasGsR65U9Vr5/wXYaRUo7Wim3UPE/MQYfUh
 Xugw==
X-Gm-Message-State: AOJu0YyP2OHd6z/dBdcZw2Q8wrpn7oRzIwj/54iKCuOceEmRyESGvtHr
 ZDqZ8gIGVPTIvw3/vADfU2KHT5edj9iwa3rXau4=
X-Google-Smtp-Source: AGHT+IH8LijlKIl7HQPpwJNj9IIby5oqYIaGfSrqm/N1NGOTpivtQOzvxbWCAIsO0+rRRPZaaUBCAg==
X-Received: by 2002:a17:902:bd87:b0:1bd:e9de:ccd7 with SMTP id
 q7-20020a170902bd8700b001bde9deccd7mr3390143pls.24.1692059741086; 
 Mon, 14 Aug 2023 17:35:41 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5e8f:33b0:7163:af34])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902e98400b001bdc8a5e96csm2319612plb.169.2023.08.14.17.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 17:35:40 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: [PATCH v5 8/9] gfxstream + rutabaga: enable rutabaga
Date: Mon, 14 Aug 2023 17:35:25 -0700
Message-Id: <20230815003526.631-9-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230815003526.631-1-gurchetansingh@chromium.org>
References: <20230815003526.631-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x635.google.com
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
---
v3: Whitespace fix (Akihiko)

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
index 3e658f1fef..08e170e029 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1361,8 +1361,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
     VirtIOGPU *g = VIRTIO_GPU(qdev);
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
-        if (!virtio_gpu_have_udmabuf()) {
-            error_setg(errp, "cannot enable blob resources without udmabuf");
+        if (!virtio_gpu_have_udmabuf() &&
+            !virtio_gpu_rutabaga_enabled(g->parent_obj.conf)) {
+            error_setg(errp, "need udmabuf or rutabaga for blob resources");
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
index b0b96f67fa..2f98eefdf3 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -216,6 +216,7 @@ static struct {
     { .driver = "ati-vga",              .flag = &default_vga       },
     { .driver = "vhost-user-vga",       .flag = &default_vga       },
     { .driver = "virtio-vga-gl",        .flag = &default_vga       },
+    { .driver = "virtio-vga-rutabaga",  .flag = &default_vga       },
 };
 
 static QemuOptsList qemu_rtc_opts = {
-- 
2.41.0.694.ge786442a9b-goog


