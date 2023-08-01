Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F9176A62C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQe1F-0001ch-7w; Mon, 31 Jul 2023 21:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe1C-0001bj-O7
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:46 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe1B-0003JW-0O
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:46 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-56433b1b0e0so1819892a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690852663; x=1691457463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAVgWdTilquWm9lumcCgsSQ970Uhlm41t4kZLCx7xGo=;
 b=RQ6EA2FuAMr1NlYPpwfnSPcN/Y3m7jwH1TppYfjybhUhl+NvlYfmwLyPpiSO9CSfNN
 3P0150NYI+H1x6sKyIWLDzwyCso3HnxWbLp6nLgdiib+qmtxFSsq1aEPwBvQPq1aladQ
 SXFsbbWhga5r0bYpyvDKFlylCKsuZnthlNONM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690852663; x=1691457463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DAVgWdTilquWm9lumcCgsSQ970Uhlm41t4kZLCx7xGo=;
 b=QcxptoK9Ww/BxnI8WhhjLkhfjVGnIfOhEDY36y2jLkf93udP2fd6UotuawDARD8io1
 Ow/gKn+lqpjyIf+HyksLnwDEe2L9AZzkAspJEHIYj3G+j3aEwtqhCfxvF5CWn7fW9Yqn
 bSu0tXQNMk+qG29fKDZg3flqjWAfhr2IP90TAA8SlVUgxk7XuuXjY28lY/YSEPi/Nv1e
 5ImWQXp9/myllxjp5vBMaP8G2l1FdydmZg7sE4YsZw70uJbgBgE42yPYATSR8Csohrtp
 J7+JbZTtaw4oFB/Y4gXJVgQMmupwFREgQg7RlpfMnJ+3TZahz8PmwdLUf9dz3hM3g3/h
 YQTQ==
X-Gm-Message-State: ABy/qLa4Cpy23mV9fF1DmkAu9DjJF2237tB6QH7CrwogUoZw9nsHqpRv
 vryPfP/pNeFwOh/0YX4bLj6JJqGLtKaMJ/izJ/c=
X-Google-Smtp-Source: APBJJlHoF2oG7yHV7qYiPCGSnaEqIFd1RXG/OA8MQSbJdfQOL2Ggms22vPhtrwUexyFpspPCyTjqjQ==
X-Received: by 2002:a17:90b:1116:b0:25c:8b5e:814 with SMTP id
 gi22-20020a17090b111600b0025c8b5e0814mr10330315pjb.44.1690852663111; 
 Mon, 31 Jul 2023 18:17:43 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:cb47:8a0d:6476:3e7b])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a17090a899400b00260a5ecd273sm6657722pjn.1.2023.07.31.18.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 18:17:41 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v2 8/9] gfxstream + rutabaga: enable rutabaga
Date: Mon, 31 Jul 2023 18:17:22 -0700
Message-Id: <20230801011723.627-9-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230801011723.627-1-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pg1-x533.google.com
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

This change enables rutabaga to receive virtio-gpu-3d hypercalls
when it is active.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 hw/display/virtio-gpu-base.c | 3 ++-
 hw/display/virtio-gpu.c      | 5 +++--
 softmmu/qdev-monitor.c       | 3 +++
 softmmu/vl.c                 | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 9628e03f93..3e822fc514 100644
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
index 6d19205e00..138a01d00e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1358,8 +1358,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
index 74f4e41338..246f0b051d 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -86,6 +86,9 @@ static const QDevAlias qdev_alias_table[] = {
     { "virtio-gpu-pci", "virtio-gpu", QEMU_ARCH_VIRTIO_PCI },
     { "virtio-gpu-gl-device", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_MMIO },
     { "virtio-gpu-gl-pci", "virtio-gpu-gl", QEMU_ARCH_VIRTIO_PCI },
+    { "virtio-gpu-rutabaga-device", "virtio-gpu-rutabaga",
+       QEMU_ARCH_VIRTIO_MMIO },
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
2.41.0.585.gd2178a4bd4-goog


