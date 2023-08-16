Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6718977D795
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 03:19:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW5BP-0002hS-KH; Tue, 15 Aug 2023 21:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qW5BL-0002gE-Hy
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 21:18:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qW5BG-00059e-Vv
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 21:18:42 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso31401025ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 18:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692148717; x=1692753517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=TqdxtOhcytafvoIWfjLCU50x/NDAY0rngCeO/V5K90Y4WU7rBttmMsh5n5BxoGQM6A
 p1HX4dNp+q6TTP5ti+3Bu8kUvEw5e5fubVRPl3iKIntpZ2C64ilPJS9zmm+82i8y9z+N
 Z+TzdFvB2MyENlqMc6njK7KVSOrkSX535Z/y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692148717; x=1692753517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=cj2Tk8UKLpuWrVRSdQMbXir/iOO/T5eR672q5JK8U7Q20LTOLknnEiH+/B98s8rhe4
 gXZQWiYXJf2mLsB1T6sDXqsrKtJPdsyC3GK1R7pA7rZ++WvzCvfPW+/k+RK3zI3ILlZg
 tpQuE2n/OJnvt4DTFNDFkee2tDmOW4qA7ruynVvbWtMVwErPLDM8sKha13uZawQCo86g
 BBpY/SG+H73MlYN2y4I4a9RtQ3j7p5+SD4CCkpZbSiYFk/zlOKoiQPtJu2y+/WnE9xHa
 +xREjXPAAybOqsN852WHh+/+SqGLrTcI8Wn7JqBI7Dy5rWM2qttRiSaDAMKvaq+7v7dV
 ckDw==
X-Gm-Message-State: AOJu0YzwUrsSAUVL+WuL7LmQjoIuPvfYoyi3BSTn5Ur1VWOiu3rgBkfb
 pU+Lf2Oy4MsMbxJ6MPvb2WrwwhO/sYjQVU/htpBSDw==
X-Google-Smtp-Source: AGHT+IFFfllUSKRT7FOSIhKS/nqQjfbFs8goBXwdaUh6oFCS7SB/Q75k7LtJDUZ1dfiZwFQGlG0qfg==
X-Received: by 2002:a17:902:820e:b0:1bd:b3b9:afbf with SMTP id
 x14-20020a170902820e00b001bdb3b9afbfmr575372pln.39.1692148717010; 
 Tue, 15 Aug 2023 18:18:37 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5f11:65df:7276:aadf])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a170902da8200b001bc7306d321sm11723562plx.282.2023.08.15.18.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 18:18:36 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v6 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Tue, 15 Aug 2023 18:18:24 -0700
Message-Id: <20230816011831.599-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230816011831.599-1-gurchetansingh@chromium.org>
References: <20230816011831.599-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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


