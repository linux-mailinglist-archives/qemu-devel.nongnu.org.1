Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DCE74E486
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3Yt-00038h-6u; Mon, 10 Jul 2023 22:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yq-000387-Vg
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:08 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yp-0005Qd-Hu
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-666eec46206so4513527b3a.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689044225; x=1691636225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vf0ImdwmMtgLUnoYr/EABqPe55wV5iMVgQRyivtsEXI=;
 b=l0pFPxfIkzIaen0VubPvyuAWOQedif+h3vlTRK8TmsdasDoJ2luBGu9qZpo1yymELU
 j9FAvSn8TcqB3EMqI+pgZtrC/Mp4rXPjjIdBonnMQ3JLq7cH6CHOouFQJK0TwQdgCQpa
 Src6LHTynv0ZlihkXyIlsbiHNRo5btA2AHvpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044225; x=1691636225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vf0ImdwmMtgLUnoYr/EABqPe55wV5iMVgQRyivtsEXI=;
 b=ENsZyXcWCIzYYQGE7LWBfDDJerhOZ2Iu/acCXH6n6VgQjVqRiRuMqh2sbwGj4shrQp
 W2rVViP2hUPuryxT+Zv8D/kMnO1VDG0ikfsTQZUXbyemJh7sOwhBNyXkSbpei99XSBdK
 Urb/FlYbs9beM8FGKDZYFPIhz/VHvrIehxXlnUm7vUkQTMxx2v2ibzdJOein5lqcbgze
 oTMbNTgITld508EIFhVR7hiFspAWaW42MDq0qhYeJDiWU5c9ibzEeXLWAr9frL04I/gU
 0Ncz7UJT/xD0CcoQ2t+d1+JYT/fwk7KmX2g/wzU/rRNJteBt9PGIKVWeVoq3wmGekGuA
 2Q5Q==
X-Gm-Message-State: ABy/qLZUgbs8ONGmxDQMMuDrTAJh2mo2fvInpiBCCZ+YmIcEyuJl+EME
 Bq8ITY35sbuS4S+532VWJHkpCMYihug82olSMgA=
X-Google-Smtp-Source: APBJJlH6wxXYqjdz8ZVpO+V3EudH7hzP/x8bMJRfXNGMIpTvuDaOcK4Trgdm+stNzoqNHgpodQXP3Q==
X-Received: by 2002:a05:6a00:1948:b0:67a:553d:3bc3 with SMTP id
 s8-20020a056a00194800b0067a553d3bc3mr15746512pfk.6.1689044225566; 
 Mon, 10 Jul 2023 19:57:05 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9292:a9df:b174:f1eb])
 by smtp.gmail.com with ESMTPSA id
 fk13-20020a056a003a8d00b0067903510abbsm474614pfb.163.2023.07.10.19.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 19:57:04 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com
Subject: [PATCH v1 8/9] gfxstream + rutabaga: enable rutabaga
Date: Mon, 10 Jul 2023 19:56:48 -0700
Message-Id: <20230711025649.708-9-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230711025649.708-1-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x434.google.com
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
index 6c5f1f327f..7913d9b82e 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -206,7 +206,8 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
 {
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(vdev);
 
-    if (virtio_gpu_virgl_enabled(g->conf)) {
+    if (virtio_gpu_virgl_enabled(g->conf) ||
+        virtio_gpu_rutabaga_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_VIRGL);
     }
     if (virtio_gpu_edid_enabled(g->conf)) {
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 32da46fefc..068f4aeb7e 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1374,8 +1374,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
2.41.0.255.g8b1d071c50-goog


