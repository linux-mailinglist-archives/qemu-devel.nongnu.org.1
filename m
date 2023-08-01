Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5521F76A62B
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQe13-0001Yw-6V; Mon, 31 Jul 2023 21:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe10-0001YQ-Am
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:34 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe0y-0003BI-Rx
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:34 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-56c85b723cfso1346441eaf.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690852651; x=1691457451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyKGCKj87BzkektBFZrJ3pntoIdjmC1o6Qhac6dxpqE=;
 b=OqjPu+F4F+cG8vKaxum8Qsen+TrTX4RhGe9R/s7WUSXMDlJUC5lfXPft6/eI7wUFyG
 f1XlyALb7H7TBXtfAapIHG/qhUKMTrN8N8bOhEW3nHL++88hWyVWE4r9N5slFbbQi0Oj
 zXeHIChf2hjpuVt6ZzTGE45TJ50glC3+LWfF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690852651; x=1691457451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyKGCKj87BzkektBFZrJ3pntoIdjmC1o6Qhac6dxpqE=;
 b=Kie2iX02y3P7QrWGAlgnGqNGME+PQBL3br8SIi4tV3el6LuFfi5Jz9fjxtjlcjN6lZ
 BIDrYvaBn45qrKo8DDjf6jf5K4+LGQeSfkFCvAHUdQP7QqK5l/okRVho6IA0YcscN/m3
 MRFx7YXnSxIFMdP/mjd9rb2YCwuIWuOBA2znerE7fPRsvHkFJbKe8Jk6mCBzYkcAB7LH
 svKJkfCEqiIo0jPi4bSVeGETFLxAFxCBwVnWIFYenA/SK3kZRqxa5+IJrqx5QiTQWmF1
 RYos8K1eVds8OMuWoxAYymf04sqeACcj8Nm6I1TJVJqyv0HCQTahp4+40C2ZOSE7Oqov
 9n0g==
X-Gm-Message-State: ABy/qLaNDEolzJ0c5istUc8xbl5g/9aK7dW+HEmdb1XtX6EFl1Gt2DBT
 EN+Zhy9uqMjsdzoYZk1ovKd8ZPYq/f8XaYbhCVw=
X-Google-Smtp-Source: APBJJlE3M/EADSN/gERfajcPOWSdOFOfhRIt84eUqzj/YBw85v9EpuGBkO4b8AG4LNE+N5t0/XhYvg==
X-Received: by 2002:a05:6808:1a2a:b0:3a7:2120:8bb with SMTP id
 bk42-20020a0568081a2a00b003a7212008bbmr7078055oib.17.1690852651112; 
 Mon, 31 Jul 2023 18:17:31 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:cb47:8a0d:6476:3e7b])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a17090a899400b00260a5ecd273sm6657722pjn.1.2023.07.31.18.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 18:17:30 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v2 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Mon, 31 Jul 2023 18:17:16 -0700
Message-Id: <20230801011723.627-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230801011723.627-1-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oo1-xc2f.google.com
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

From: Antonio Caggiano <antonio.caggiano@collabora.com>

The feature can be enabled when a backend wants it.

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/display/virtio-gpu-base.c   | 3 +++
 include/hw/virtio/virtio-gpu.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7ab7d08d0a..9628e03f93 100644
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
index 7ea8ae2bee..9e44fbdae2 100644
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
2.41.0.585.gd2178a4bd4-goog


