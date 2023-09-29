Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD8D7B3B16
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 22:15:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmJs1-0007ZG-Bt; Fri, 29 Sep 2023 16:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJry-0007Yr-VC
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:51 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJrx-0004Iu-BT
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:13:50 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-692c70bc440so9242220b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696018427; x=1696623227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gnAgBdZxEHcM2Wv5r12p9/EnZfi2baiMmkJIhgiWfNY=;
 b=HGrq1y9JTFTj3QrfB5VTkIFn3w4nx5UGPxd7W8oiAKVrX++/ya9X8loRmfO71H9KxU
 nJQhMLr8dmB5uCEJPAyH6AvTR9o1giPa+bcXhXyNRyhKuudBGJpKIKJxxSUcRWHGg/Ih
 hoRZdLCmy6iT4usR1mdM3fkBXNUL5aLh7tCx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696018427; x=1696623227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnAgBdZxEHcM2Wv5r12p9/EnZfi2baiMmkJIhgiWfNY=;
 b=VoOnIrj5Y8Du/qCdkKBsW6nxFHpkrFzfy6xakacHKWU4/4QX7S59zKdULkWuvDI9kz
 GtIHrFkepoXY4020p+xh1vr8mfxQ0uDHVimlTeZuEO9XrELbprmcBSMTsu49Dsgl3uj6
 V20XB/Ln0xLd++lfO8fzMDo6TSWgEkq7FssWUpN6QrPtjrqN+bT27EHsE1ZTcweB1f0u
 h4E1aOYAOqRVNsRR9U0B2lBmyje7YzjILlC/wo1sXv24ZRqV9xvs0j8l5HnJyFl7I4/q
 Ag4pMbdRw/vQ+zUKKMrL30LxFy7iPMA9VpWJREXjo4JqLofavjn7hWJtA8jS7aFpDFDy
 sD5A==
X-Gm-Message-State: AOJu0YyvXuJUUU+onBcuywdBq9wMqllJKpAHB9vlxvDnWcjlm4/FB6MR
 psVRC0R3w+vEl2iw2jnhuKUhDLwrogtpwMd9RB4=
X-Google-Smtp-Source: AGHT+IH5onPPD+nVyxernlkaoP7D3MdzPg4uas0iiD6N6xiYhTqVM+TAfiK6SUgawe4l/zD2APqiRg==
X-Received: by 2002:a05:6a00:4143:b0:68f:d35d:217e with SMTP id
 bv3-20020a056a00414300b0068fd35d217emr4723432pfb.2.1696018427535; 
 Fri, 29 Sep 2023 13:13:47 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:18fe:3fb1:d86b:1e68])
 by smtp.gmail.com with ESMTPSA id
 t12-20020aa7938c000000b00686236718d8sm15267033pfe.41.2023.09.29.13.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 13:13:47 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v14 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Fri, 29 Sep 2023 13:13:34 -0700
Message-Id: <20230929201341.332-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230929201341.332-1-gurchetansingh@chromium.org>
References: <20230929201341.332-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x429.google.com
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
Tested-by: Huang Rui <ray.huang@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
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
2.42.0.582.g8ccd20d70d-goog


