Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ECA784E25
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 03:27:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYcd6-0006vT-RJ; Tue, 22 Aug 2023 21:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd4-0006uI-LB
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:50 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd2-00028I-8s
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:50 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-26d50a832a9so2401982a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 18:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692753946; x=1693358746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=VN2OkeyNF88GxRv2w4BqzMANEosf5frEOtGW7dElStfIk4j8pZHP4l7mosC42Ycsg9
 MYgJj/uvAugjAYuzh+KhOLyxLnBLcdwA19Suso9xesT/V5Y+sYhblT4bL1eL/7OtEd7u
 S35VuyaZy9p4qWn4a6IVcPTsoJWZqIJQI0rpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692753946; x=1693358746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpRrVZiVx2Piz08CcrcJ+tsOuBGRCYO0Zpm63sOcarc=;
 b=QgM7e3MikG/XgrYyuZ0UtVMze0+uBje2rWh7TW8B8Dhea9HAkAQfqJDMDChPSBtn//
 gx1rIqKM8rIHrT+6590FxH+qwpOMxoILr2qj8andwJsJGN2T1zw8b8S71rTqOfRuL0Tp
 Rz9qU9/HbKOGmhRJARnNmC3QIG4lHdQXE+w0UakIE29yCD2yvCXYESkv3087+IJYM7tA
 yad0IrJ+c3+S9PS1ZbEJiBb6C3K9C1jbRmCgE8Bair+ibTkEXVsh1RnB34IVnqteZvCD
 I9RpGNpBX3fFFG2oLy/c4Y4yuYs/D0f8N201qx/nEojq/xteld2UDTBGe5kA5W/W7Hwi
 WIdw==
X-Gm-Message-State: AOJu0YyND15pXpZNIlGruzoh7/GBI3BVUg6V5+IN2OzrRlRiXPvW6kkK
 6yy3PUg/TedEt9TlQ2fcDoLKeivodlyrkBJugBk=
X-Google-Smtp-Source: AGHT+IEJdgw2gRqudK6oopgPgWKnCpt4R2oPRuC0zDKN7HgcYaJP4lleMBwxc7g7USrNNf2PQq5UNw==
X-Received: by 2002:a17:90a:d903:b0:268:314f:8f35 with SMTP id
 c3-20020a17090ad90300b00268314f8f35mr7626620pjv.6.1692753946594; 
 Tue, 22 Aug 2023 18:25:46 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a483:9c7e:d68:4057])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a17090af0ce00b00263ba6a248bsm10291409pjb.1.2023.08.22.18.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 18:25:46 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: [PATCH v11 2/9] virtio-gpu: CONTEXT_INIT feature
Date: Tue, 22 Aug 2023 18:25:34 -0700
Message-Id: <20230823012541.485-3-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230823012541.485-1-gurchetansingh@chromium.org>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pj1-x1029.google.com
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


