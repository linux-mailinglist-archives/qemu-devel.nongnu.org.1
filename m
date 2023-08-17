Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B23A77EF04
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 04:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWSfh-0006Cv-Rd; Wed, 16 Aug 2023 22:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWSfg-0006CV-SP
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:23:36 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qWSfd-0006oy-FA
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 22:23:36 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bcac140aaaso5857854a34.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692239011; x=1692843811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=eC/PjBvbhn4sfmWJl98td2ZnMSk75Ko4RYJVZ3srKx6A0OPAOseaT+lTP6ni3k3h3S
 PSLDEwqZHKqF6sD+XR7/cNu/MPGzrpmN1K5gYY/6kTSnxusTVdFwmTo6B8HBBw2WlyFA
 7rrep61wjVB1fzghA1ORO9BYWm3+wGX53H03c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692239011; x=1692843811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=FkgBaQbeTTovGoYVAUy65RuyOj5JhHc8WfCaKpWny0M0hZeqe1prImt0SzF7Cl3ayE
 K+Ta6n8g291sNpaJsKZ7rfWoAwY/GsAEp1eq+YvRV1dCtXuHj5qmthr7mfq4rH7OK0aZ
 PV34r9AR4TR8d4LoFeKPKaEu46y/GwH9WcbWs4dw809Mn03bU6gzSqXZ6coDLI8PHWU0
 TmKuWjx+8R5DJX3g7/9gEBbz6U1lzpiuefn88fZN2TxZeL9aw7NSQtEaT2Uqt2KwTgEO
 XsKENANYW6B1yRB5cg9kRvcpiW4VhmGcTi1ulrCYdsRfv+DWe9WpZUYK67mThllQipPJ
 zmOA==
X-Gm-Message-State: AOJu0YxTDkxD9VMjqxPl7xL1F+S+7mEZxjIqn8TZ8PYFhsq+AsbAHV9N
 bcLXb42mExRXGRupgsV14+EvjJvzj0UeugDqFk4=
X-Google-Smtp-Source: AGHT+IG/xLXlc4ivngFrmuhF/ux5hXcW5tfETljQgDrhp8xjuj1YYmR/Qm0XM+DEfg7B3zi49Q1WbA==
X-Received: by 2002:a9d:7d08:0:b0:6bd:a82:8edb with SMTP id
 v8-20020a9d7d08000000b006bd0a828edbmr3645765otn.10.1692239011180; 
 Wed, 16 Aug 2023 19:23:31 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:b7f8:4544:6dd7:85d])
 by smtp.gmail.com with ESMTPSA id
 hg14-20020a17090b300e00b00267eead2f16sm401085pjb.36.2023.08.16.19.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 19:23:30 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
Subject: [PATCH v7 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Wed, 16 Aug 2023 19:23:15 -0700
Message-Id: <20230817022322.466-3-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230817022322.466-1-gurchetansingh@google.com>
References: <20230817022322.466-1-gurchetansingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ot1-x329.google.com
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


