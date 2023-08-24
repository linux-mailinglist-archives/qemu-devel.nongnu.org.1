Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1FD787C07
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 01:42:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZJwm-0007E1-WC; Thu, 24 Aug 2023 19:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwf-0007C7-VC
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:40:57 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qZJwb-00059n-T5
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 19:40:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68bf27942b2so365445b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 16:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692920452; x=1693525252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bbMOlQfn1lmsJCH/zgi5gBaCiro7jHee+4uxcvIyykU=;
 b=c436JYOG/QCJ1PO6f4c7fLkF7SjEbmhG7zs9vLwH2WVPvOAiyorDmzM72yV6+cxuRc
 hDqPFM9ZvgoRYQWCQ8mhuAzuEttZ9YakFHfr7JlMglRvXlDRBJkYYSvbXAayfAHfonCg
 KQ/WLPldmX1UAr6cbE94ea7Jbe5ZeCO794c0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692920452; x=1693525252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bbMOlQfn1lmsJCH/zgi5gBaCiro7jHee+4uxcvIyykU=;
 b=j556TtclR4bmh5lt++vCcSLXuxYMW4RrMRtkqm8KrZSttjZ6ErOCwC1mZzIOnCGFA9
 DCyA0uCKThkIuy7LK6ob0+CxPNtLSHwOqoUj+e9Pl8Or8Gjz3wxre4nqh7NjoA3+6imj
 z96dmlmM7jBsWa1n6BgNtvpgj70psy4vfswJs1YEaHp5icz9bbDXwye8GoEKH7wi+AJQ
 Rnm94dymO+mySjaIi5mVU0wi7m200OVWj4ILs6XRyN8gVtAERFkXYIXK9xOEItVvF/BC
 r6C4QaItgYTugi93iF6fDS0qga2/olxLcSpbdgw5PPWosFm66DU2CP7QbGhu/5iEUCOS
 zIQw==
X-Gm-Message-State: AOJu0YwlPwmCGbEKpamIrVDvTYYig2LpNcqVZPmQQeG6Wy7hj8KJ48jq
 956Fs1im8Jxmmbf6sU+xWKlvD6sIJ7G6/S5LFMk=
X-Google-Smtp-Source: AGHT+IG22xZGntJdJg6rd2hxKp9YM7xt2SY2oYxUt/VigNgqBgPdps9qD7dEfCoIJ9LH0ThRMDR4Bw==
X-Received: by 2002:a05:6a00:1584:b0:689:f3f1:8523 with SMTP id
 u4-20020a056a00158400b00689f3f18523mr21206988pfk.19.1692920452194; 
 Thu, 24 Aug 2023 16:40:52 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:1fa0:9cd:3c53:231b])
 by smtp.gmail.com with ESMTPSA id
 fe8-20020a056a002f0800b0066a31111cc5sm274798pfb.152.2023.08.24.16.40.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 16:40:51 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v12 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Thu, 24 Aug 2023 16:40:39 -0700
Message-Id: <20230824234046.499-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230824234046.499-1-gurchetansingh@chromium.org>
References: <20230824234046.499-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42a.google.com
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
2.42.0.rc2.253.gd59a3bf2b4-goog


