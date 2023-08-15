Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D09577C482
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 02:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVi29-0004IL-Ah; Mon, 14 Aug 2023 20:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVi27-0004He-GN
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 20:35:39 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qVi23-0004r2-Qw
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 20:35:38 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso22029395ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 17:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692059733; x=1692664533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykQALckol3YlQVDX327ck49o8JC9p5CCfkWFBwiRZm0=;
 b=A+AWfKI8w2mChW16PbWnVyimR3Tv7T61PKGrnVRmtU+CTC+p1kp0bhbDIegAw6hsCO
 lWZObL5rJeouLCc8GG/kSc27kNlBhDAJ7aW+qrQIpLj9Gd64jZzfVy1NPhxF/eL8cIQW
 +tWDLIb5Dawr/kcIWCZSGQxMsPQzraCWY17FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692059733; x=1692664533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykQALckol3YlQVDX327ck49o8JC9p5CCfkWFBwiRZm0=;
 b=ZY4o66tUA/0fzw5oqJ0Mf3m/pKq+nLI5zigbeI7pXIKxHhaStP7KUSmP46cOOMHyjL
 jDSfjkuJMs+xQvDwDqfkf8Cg1nw8Cd4xg/B/xnQPU400DwbY/AONgTLrV78BBbHEtKMM
 u248H/GIFqFibf5JTXPzPp+R7IStEtVedr1qcjVBoQoBCCTK4Q9GNNB5JqgLBgQgP9XC
 XsQGmnG5LHONLuKtTQXwtacGNyNO0mCR3ih8HVD6oEdObBISqTZeHqfRCknTiet/o+3o
 hPKN6Oa7nlR/vwLRuzFp6YQBwS3EjO6r1b5jnLmHrxPJ927f2ma9Oy3iSNj1oXykndvd
 9pvw==
X-Gm-Message-State: AOJu0YxPCB0GgazfeKf4M/6XFoc113fpSbvzDZYOmH4PNyRBHxrEMqi1
 oP9hOTdp1khuG8MpraNK6dceBGjlvfcJlcPv++c=
X-Google-Smtp-Source: AGHT+IFBfEnR/GYlCfJVzYht+QcI5Cco5AdBVmb0D0OKUoD7SeONNnIz4phQK+X63v4dxlrXn8loiw==
X-Received: by 2002:a17:902:7241:b0:1bb:961e:dfbc with SMTP id
 c1-20020a170902724100b001bb961edfbcmr10251997pll.20.1692059732778; 
 Mon, 14 Aug 2023 17:35:32 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:5e8f:33b0:7163:af34])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a170902e98400b001bdc8a5e96csm2319612plb.169.2023.08.14.17.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 17:35:32 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: [PATCH v5 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Mon, 14 Aug 2023 17:35:19 -0700
Message-Id: <20230815003526.631-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230815003526.631-1-gurchetansingh@chromium.org>
References: <20230815003526.631-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pl1-x62b.google.com
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
2.41.0.694.ge786442a9b-goog


