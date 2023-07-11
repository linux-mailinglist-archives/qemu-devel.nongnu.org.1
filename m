Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6C574E48B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3Yi-000364-Dr; Mon, 10 Jul 2023 22:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yg-00035j-3D
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:56:58 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Ye-0005Oj-LZ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:56:57 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6686c74183cso4570019b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689044214; x=1691636214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dBzo1bq6h99IodRaC2j5EZX16T9T2SJRXwAJNicF21M=;
 b=FOX7xg77CgVCaX33v/0u495hvX/N7dPKyFVTRUr5WW3NRoa3IBUcFJFltHoe1D63aT
 T0N/MAoIoEVZAvoerplU6cuyOHvRfMczNbGIn1L4bej6Yy39OmQTnKUugQBcMFezCcRU
 eNfMFxMrOnFLGjIokuGJ/7PxgPesLEA9aYy/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044214; x=1691636214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dBzo1bq6h99IodRaC2j5EZX16T9T2SJRXwAJNicF21M=;
 b=Mmh4or3lIoEgDQqOswJDU7oBhJuOnoo+KRy6wvhWWCLoCWpvIxELw+slNvxcMRR9Yy
 PDdvjiRLVMFTj4S9Qp3u41a+uxlAw/oOoLDYzdI7NfVs+JAhIidLee1x1Ti2PpzSiWFg
 qYR6gV+scBC4Gvqy1kXIZ/e4OX20u6eOWntz2hUN401Yb50O5ifCNP0/LPE5hVmgNUnh
 uv21K77otJ5mcbMcuOPT9nVu44GhV7WUc+p6MpTadcy/CgXQGJhqPszLCnIJOwZO4hFQ
 IvFXAKrQrmOMP2WYX295qzhFQs4SqoX5J0JbId0sO7b+ttiEhv+jzhlwQACXpdO4SU6n
 6uIA==
X-Gm-Message-State: ABy/qLaMwMHmgbjCyJPEbKAZjdJx5jsn5KEosU26nzg6AFsl/75Vs4sm
 yPPxk0X7MuoMnUMhvUPVDtejY7UtOo/1YMgBwuQ=
X-Google-Smtp-Source: APBJJlGygj3hJZf4v+dySp4aZLiYns8ba7v88QdSGB37Ly6RM1THbsVyhB4fFHctZ1zV1XTbbjnNtQ==
X-Received: by 2002:a05:6a00:1825:b0:667:85e6:4d1 with SMTP id
 y37-20020a056a00182500b0066785e604d1mr18175648pfa.33.1689044214715; 
 Mon, 10 Jul 2023 19:56:54 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9292:a9df:b174:f1eb])
 by smtp.gmail.com with ESMTPSA id
 fk13-20020a056a003a8d00b0067903510abbsm474614pfb.163.2023.07.10.19.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 19:56:54 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com
Subject: [PATCH v1 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Mon, 10 Jul 2023 19:56:42 -0700
Message-Id: <20230711025649.708-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230711025649.708-1-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
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
index a29f191aa8..6c5f1f327f 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -215,6 +215,9 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uint64_t features,
     if (virtio_gpu_blob_enabled(g->conf)) {
         features |= (1 << VIRTIO_GPU_F_RESOURCE_BLOB);
     }
+    if (virtio_gpu_context_init_enabled(g->conf)) {
+        features |= (1 << VIRTIO_GPU_F_CONTEXT_INIT);
+    }
 
     return features;
 }
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 7a5f8056ea..8f9b3e4ac6 100644
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
2.41.0.255.g8b1d071c50-goog


