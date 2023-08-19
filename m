Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F9781661
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAW7-0003lH-Hf; Fri, 18 Aug 2023 21:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAW5-0003km-Ns
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:12:37 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qXAW3-00017y-Gm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:12:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68879c4cadeso1253909b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692407554; x=1693012354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=nZQCfYa2kNM9+ssGA/JWUtACnvZtsKbVitzRgs8v1GTNwfv7d5EuwA3YJxhr+n+ttp
 UBlkr2sSHKwyPr4gx5BKKuQk2Jp0K/wytOmfAAAx4GXCU+USRDNTeUsvbfYDpeTaVK42
 GEv+A/OaZhciFDPPknhENDrfe7+A8O39Ybt+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692407554; x=1693012354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=g6O6O11/j/M4TFVYDcAmaBrzMMATn5aw/4XeVDEWnnHwUQxVUoB7dCDwhoIzhpfQTD
 lQ/7FOQ3g4PAh/p1njhxWH+oGiEvlM/mBXno8nM69z2vEB6y8Tmwcgq9PXaF2M/5X4q2
 7NClevHDI/MD/Ui+VDKtFyaMA2rXheOJTr5VwwXsk9rwyWdes4rx5g536tADHPSF4M4A
 QWHteVohgXEJqsUlaswJXw5yy3lGuKGR5aT3Z40g1wQq/WGBqH2faU773Z2X73vAeoPm
 P743jtCV9Auh5w9KwCsQga/6gNk1ahysdCUmQGHxdQEOLj8VViXdgZrlJe8p1bThBsp4
 qVYA==
X-Gm-Message-State: AOJu0YzNVh25GxPz4fbkG1R8pmmpaeAY6MNhWwkSSEu2qncOGd/wXlwq
 ZKggy/eV8JWAd9rubaDimORIGV9mp1qhvIxf6Zk=
X-Google-Smtp-Source: AGHT+IFteSSm80fKQAuhJQXqJ8Yk2uB4oM/qsb/UoaYWIm3ynmAxzuGHY2a71rhqqBxzfv/cGSWuTg==
X-Received: by 2002:a05:6a00:c8f:b0:67b:f249:35e3 with SMTP id
 a15-20020a056a000c8f00b0067bf24935e3mr993828pfv.26.1692407553908; 
 Fri, 18 Aug 2023 18:12:33 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:92c9:8bef:2f4d:5ef5])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a056a00165a00b0068a077b21c2sm554810pfc.172.2023.08.18.18.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:12:33 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v9 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Fri, 18 Aug 2023 18:12:22 -0700
Message-Id: <20230819011229.415-2-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230819011229.415-1-gurchetansingh@chromium.org>
References: <20230819011229.415-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


