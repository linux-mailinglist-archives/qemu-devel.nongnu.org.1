Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB15784E28
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 03:27:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYcdE-0006xo-52; Tue, 22 Aug 2023 21:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcdC-0006xI-B4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:58 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcdA-0002CJ-0d
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:58 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1c4dda61eb0so3170424fac.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 18:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692753954; x=1693358754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1rC7ovc7Sppu/ATz5BWmsBfBp0niYqXXtnHHGa93VV4=;
 b=apOAtjHNFmpsEpff5On/L+tmIfN9YixKfYmpI1mQMqxCskX4Dm34tDmyJNRVemGQZT
 /94jT8VSAi7mcgXF5dTfTRsY+u43u+Hz9xEFpaRGMgJZhO5q6kH6vmS4yCKOc7vxX7tT
 2bOQdG8pFAyzfStZhnSDSwJPwvTNolTYQcrRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692753954; x=1693358754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1rC7ovc7Sppu/ATz5BWmsBfBp0niYqXXtnHHGa93VV4=;
 b=QnOCpBg26xOhJWO+Hd7AaFu4Pe31Dl+ACk4h8Z8NDo681y+dlxowU9AjGHqzTratF1
 6Li4WIkTLAdZTjg+xNIgoFp1LaDEXfz2hhkqkt6XPJdBLvux0u9wLikzQp26OjK/2Gfm
 geStxQ1sMSSfByWgNwl4QChOIOLIgFm+wo3rpLpLYn3/ybC/vzL7wSDGZsf2x+geOf3u
 J/m0b+QIRjfXdihk1O6l3QtkA2SzM5WqKkj3fxNuQ3tX7O+gYg/vpCCshLv2iRoA+Sxs
 lMXiH6zXDMIZcY8LESl/SzjGQQOFsB/mtJpT1BIAkXMZgubmcAS7n9TPa1ELXRApaMgx
 3+xA==
X-Gm-Message-State: AOJu0YzEpf58QeO7cvhe2MGC88+Q0YcrqU3z/GsI8dPdiFxd4HvqJtbS
 PASEVEC6YJvz2nJ1wYqo+EO+0FX90X7HSTN0u64=
X-Google-Smtp-Source: AGHT+IHm/OpcU3w5jcYDudPbdVm5MX8so7bxX7sbA5SF1uDkhmaGHch9ftM7Zhlld8XhX1mUjph6ag==
X-Received: by 2002:a05:6870:b48a:b0:1c1:11d:8dfb with SMTP id
 y10-20020a056870b48a00b001c1011d8dfbmr13918276oap.32.1692753954462; 
 Tue, 22 Aug 2023 18:25:54 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a483:9c7e:d68:4057])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a17090af0ce00b00263ba6a248bsm10291409pjb.1.2023.08.22.18.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 18:25:54 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: [PATCH v11 8/9] gfxstream + rutabaga: enable rutabaga
Date: Tue, 22 Aug 2023 18:25:40 -0700
Message-Id: <20230823012541.485-9-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230823012541.485-1-gurchetansingh@chromium.org>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oa1-x34.google.com
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
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
v3: Whitespace fix (Akihiko)
v9: reorder virtio_gpu_have_udmabuf() after checking if rutabaga
    is enabled to avoid spurious warnings (Akihiko)

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
index 3e658f1fef..fe094addef 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1361,8 +1361,9 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
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
2.42.0.rc1.204.g551eb34607-goog


