Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3244678368F
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 02:01:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYEp3-0003Fl-Em; Mon, 21 Aug 2023 20:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYEp0-0003FT-Gx
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:00:34 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYEox-0001OZ-Hr
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:00:34 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-688787570ccso2615091b3a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692662430; x=1693267230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=UMqoEy7Up+v/omwdu1j0JYTC0g60nA6WKB23g3Ewm7F0N7mwIBJnqwxj7pVcKcJ8ak
 Nc8aD7ilByY4fMlGoA6dqHmNxH3gy+zPcq2MajYH33Pt09JGFm9gpSRpRpXlEjatEFol
 eT+4WjdQqQGoggn4afAkk/WgQQWiasU8/iwlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692662430; x=1693267230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=Buoj4kbIj3tosIsBb6nUNWg29+jfeVLbqE2YkSZFevrweWl2R+B/M1N9TCnbKjwQid
 b91MRJv5rQ2mSqTpZeVgq/GYAWmj+TZGsV8q3WB7GEji4jVFSy+MLy0YDdEeiRLzRl7f
 JkvJOwHTaWuFOdQFinIAdwt2B2nk/VYDPROyMRygMtyxGUxsSjvBy+VM38KsgBgrUQsw
 idBPByYLOwmBgwdjXBgi6tJCLGtuVGjDGUjRcSgiq6Tf6c/CkUyhmQZgJQedKBeENtG7
 seiHEgawgV+BS4frrTdr3rVKe25UPnnufwJlWm7oidRKa7dpkt5n75g8pYDr+CnS9HpO
 LFnQ==
X-Gm-Message-State: AOJu0YxVqjfftWrTMLCoMHnWnnI2nS3Fi6w0juR7oGgvYVpN+fsZMObB
 qVSfrR1nH52VEJID0p2jzeZwJnCUhFpvRdcICKg=
X-Google-Smtp-Source: AGHT+IHW3XJ0nXjI4IZzHpJkX3FdW2dba1QCutXPvCHohADPSR6oq6OU3EZQ/vlcgLmaBqbMmJ0bRA==
X-Received: by 2002:a05:6a20:4286:b0:11f:4707:7365 with SMTP id
 o6-20020a056a20428600b0011f47077365mr8119622pzj.38.1692662429429; 
 Mon, 21 Aug 2023 17:00:29 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:91e:34c5:6c84:1464])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a170902bd4a00b001bba669a7eesm7626277plx.52.2023.08.21.17.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 17:00:29 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v10 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Mon, 21 Aug 2023 17:00:18 -0700
Message-Id: <20230822000025.501-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230822000025.501-1-gurchetansingh@chromium.org>
References: <20230822000025.501-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42d.google.com
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

The feature can be enabled when a backend wants it.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/display/virtio-gpu-base.c   | 3 +++
 include/hw/virtio/virtio-gpu.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index ca1fb7b16f..4f2b0ba1f3 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -232,6 +232,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     if (virtio_gpu_blob_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
     }
+    if (virtio_gpu_context_init_enabled(g->conf)) {
+        features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
+    }
 
     return features;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 390c4642b8..8377c365ef 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -93,6 +93,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_EDID_ENABLED,
     VIRTIO_GPU_FLAG_DMABUF_ENABLED,
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
+    VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -105,6 +106,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_DMABUF_ENABLED))
 #define virtio_gpu_blob_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
+#define virtio_gpu_context_init_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
 
 struct virtio_gpu_base_conf {
     uint32_t max_outputs;
-- 
2.42.0.rc1.204.g551eb34607-goog


