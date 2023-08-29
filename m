Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E50C878BC26
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 02:38:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qamj0-0007cO-7P; Mon, 28 Aug 2023 20:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qamil-0007bW-85
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:36:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qamii-0007e4-Mf
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 20:36:38 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68c0d4cc3a4so2126336b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 17:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693269395; x=1693874195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IDuQJozv+4gYa7SAFlyIrXJHa1MKLwWYBNlrMvha5Y=;
 b=BiVjRYHF2fuwzM4cqnozg/QFyK9zVQLx0KJnpp/aj4AYQIYkAlqDj9Xy+aStQZ1FIP
 fI021h5IgDSwmGx3mv3MBecC0FJj1FTDhs0SIT8x3U3dZylUqSowRHUBxqU7+H5DOK5L
 oXqyZQoSeYvbmgJ7a4FY2Nit4Mity1Fa4lGW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693269395; x=1693874195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8IDuQJozv+4gYa7SAFlyIrXJHa1MKLwWYBNlrMvha5Y=;
 b=FWacFuiUZ2bjwKxS+4fSnSBtxrjWvZhHGDWVcM8yFFTQUQfEKbu/FyJzNhymhex0nJ
 2TR6nqz+wR2vcnlsw1t66ZKyzRHXforfMxo8JXxG/4nMIquqLIGeI10BbEMyZOjPbdiy
 kZNQskhk72ZlYBb8x91F1SH7Xax9WeT7cAised0gGsLR1DxJGoXBq+qJ1MAwTQEjZhKt
 xdVGO4DyWN7e7HDooKWmiJq3tR4pkn2rgq7tpq32VwSdNYyynb+PMf8F67wVVPJ1xZqd
 aAVCBeJR2YkXx0g1g9Fy7HDGpP/2gbVC8cEv+smDeHp+ZB+Rtd0uyLGbov44Budd0yLh
 SFfw==
X-Gm-Message-State: AOJu0YxTbAQjpqjE3h23I68sWLqPD1NsXsqWp6reaj2cx+C9g3G/blPk
 J36uxNaziaWpydjuVDsXUpQAwWheaUD6beAP52c=
X-Google-Smtp-Source: AGHT+IHWakFVeFBqwDxXVBqP5pM9T2YSlAoXOjN/Yp0bjqJ4Y/ufi2xyFq5kkNbqM7LNsw3Voco2jw==
X-Received: by 2002:a05:6a00:1708:b0:68b:eaad:6c3b with SMTP id
 h8-20020a056a00170800b0068beaad6c3bmr14338531pfc.23.1693269395065; 
 Mon, 28 Aug 2023 17:36:35 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5fa1:f455:2676:5eee])
 by smtp.gmail.com with ESMTPSA id
 c3-20020aa78c03000000b0068890c19c49sm7214782pfd.180.2023.08.28.17.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 17:36:34 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v13 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Mon, 28 Aug 2023 17:36:22 -0700
Message-Id: <20230829003629.410-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230829003629.410-1-gurchetansingh@chromium.org>
References: <20230829003629.410-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42b.google.com
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
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
2.42.0.rc2.253.gd59a3bf2b4-goog


