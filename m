Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2B76F655
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 01:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRiA0-0007H8-2p; Thu, 03 Aug 2023 19:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9w-0007G8-7A
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9u-0003bH-FI
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:11 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686f94328a4so1070525b3a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691106907; x=1691711707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QyKGCKj87BzkektBFZrJ3pntoIdjmC1o6Qhac6dxpqE=;
 b=cqwxsb0+NDAujq6tqVBq+p2ZcxjfP+1OKbYRgxjqqWABKsqsNu0qtkqxWZXKmdUMKK
 BxJlzH40GFYnEe6cls82qhEwwIqsO/3vTnACWyihA5QvwbqHQD+JaBz+FW/q0r6TxTsc
 2x6Ry/fYB6cXmqhqS0vh8urjmKY9jRCWhpkBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691106907; x=1691711707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyKGCKj87BzkektBFZrJ3pntoIdjmC1o6Qhac6dxpqE=;
 b=ZzGMaBIhUlLAxV072fvz3APBrUQuax+QXNony+KhImlAZyaWU4uKEq5mHQ7SbIJmlH
 +RgPQqdJ69hXKJq1AtGn0w0/fmuCRIf6XDw+fKzLomc4SP0GH011yS52kFuc0AeJkBE9
 l5Khy493UPGt+Gn46Rel5qIDCas10l1AE5sAu3WvhvrjGB6shGTcPBzRup/EMD3N0aYi
 9SiWZHrhWC4lvQudcLnBymx5W44pM2AKSXv5ktRwyPaE63SiOD+9eQYLBCwuLyhhZQHc
 Am0mAYmnl5H59ZjkELLhSNfxtAFWiV9QZSEvINItUHZvTADik3s+799Pe2+YDR+WCaeh
 cQEg==
X-Gm-Message-State: AOJu0YwGd+ARACkeOQYBD0qWnr6m2zQi+0DpCclR1flAn9ygG3azN27d
 fdBaH3kZvkizKHVU955YF+elXsjoAcCdxN64J18=
X-Google-Smtp-Source: AGHT+IFtP1l+dtFI/akU5yrSxhoF6bpwIObM198rcZQQcWywnR50BCfBR9nV6RPSw5T6QGJwYkyVuQ==
X-Received: by 2002:a05:6a20:1584:b0:125:3445:8af0 with SMTP id
 h4-20020a056a20158400b0012534458af0mr292017pzj.7.1691106907589; 
 Thu, 03 Aug 2023 16:55:07 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9efb:b80c:dd5c:56c9])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a63a708000000b0055387ffef10sm364329pgf.24.2023.08.03.16.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 16:55:07 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v3 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Thu,  3 Aug 2023 16:54:55 -0700
Message-Id: <20230803235502.373-3-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230803235502.373-1-gurchetansingh@google.com>
References: <20230803235502.373-1-gurchetansingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x430.google.com
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


