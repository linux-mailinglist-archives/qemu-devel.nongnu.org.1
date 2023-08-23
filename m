Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F52F784E2E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 03:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYcd8-0006wK-UG; Tue, 22 Aug 2023 21:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd7-0006vm-8P
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:53 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qYcd4-0002AA-U2
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 21:25:53 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-44d4d997dcfso1177002137.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 18:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692753949; x=1693358749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AoojSxiI88xJFCZEbY8RgS5lAMpA6dkVdlJeZE1MyMM=;
 b=fbWxc5lb1GIrz+qiI3Lq5sXVxCG+fbsBNvfCZKP/BNL+nJXU1Pzo69FbGNf323l8fZ
 dX8ugIQLtoC9QJRCQDgM5MfdP1GsHlPETYF9YdnPJiQUO8Kxbn80optgwO/qax9wgTRX
 vqlQL1G5rf9Ou3H7O6pf18JesC2Ts3WZLwMro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692753949; x=1693358749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AoojSxiI88xJFCZEbY8RgS5lAMpA6dkVdlJeZE1MyMM=;
 b=jEN9Q9km/7KgBwZO8cg/Va9bppZYp7Ekh0dsbhZ+Z4uL6aRA4EIwTBQfKuOTja/BFd
 hrWNmiOR/WlL57BmYvggrmVw9Ru/3t8AiwvDqSBPdMfv7+S+3FD5jmpLjWU8+60mLCAN
 T8dnEYVQCbI6XW7TSL9haMYUxsEzT7eG5VuyK0/z4P107Hf9eKGzlihFjSKwzvVTiQfj
 uV+wvPSHqswlwYKyOMuN3k4wdD98FBFB0dtowZwSnmJxCXGZm5KvSuabIeqp0Tb6Hhaa
 +77edaeH03cCAzus44dspABBGHzZsrbnQZCKaUVtDXJO3RDJBbWPxNf2F0KJRJBokiKB
 UXYA==
X-Gm-Message-State: AOJu0Yx59WAZuuuiQ+2eEfuIlomAK+t4urVINPVyN4ZlzmXFRHEaoLT+
 avw8BeO4tDP75OVE+M4FfnbDf0oBq3w8lU2PDvg=
X-Google-Smtp-Source: AGHT+IE+LeS+6mETDb2AvcmNFEca4p+t4BELsvuxtTn/XJoE4YWvJWd36GvYPuJ2R4GZ03owg3ukcg==
X-Received: by 2002:a05:6102:3a6a:b0:443:7c69:4743 with SMTP id
 bf10-20020a0561023a6a00b004437c694743mr10002546vsb.16.1692753949300; 
 Tue, 22 Aug 2023 18:25:49 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:a483:9c7e:d68:4057])
 by smtp.gmail.com with ESMTPSA id
 fa14-20020a17090af0ce00b00263ba6a248bsm10291409pjb.1.2023.08.22.18.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 18:25:48 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org
Subject: [PATCH v11 4/9] virtio-gpu: blob prep
Date: Tue, 22 Aug 2023 18:25:36 -0700
Message-Id: <20230823012541.485-5-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230823012541.485-1-gurchetansingh@chromium.org>
References: <20230823012541.485-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=gurchetansingh@chromium.org; helo=mail-vs1-xe29.google.com
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

This adds preparatory functions needed to:

     - decode blob cmds
     - tracking iovecs

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/display/virtio-gpu.c              | 10 +++-------
 include/hw/virtio/virtio-gpu-bswap.h | 18 ++++++++++++++++++
 include/hw/virtio/virtio-gpu.h       |  5 +++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 48ef0d9fad..3e658f1fef 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -33,15 +33,11 @@
 
 #define VIRTIO_GPU_VM_VERSION 1
 
-static struct virtio_gpu_simple_resource*
-virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
                                bool require_backing,
                                const char *caller, uint32_t *error);
 
-static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
-                                       struct virtio_gpu_simple_resource *res);
 static void virtio_gpu_reset_bh(void *opaque);
 
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
@@ -116,7 +112,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_gpu_update_cursor *cursor)
                   cursor->resource_id ? 1 : 0);
 }
 
-static struct virtio_gpu_simple_resource *
+struct virtio_gpu_simple_resource *
 virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
 {
     struct virtio_gpu_simple_resource *res;
@@ -904,8 +900,8 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
     g_free(iov);
 }
 
-static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
-                                       struct virtio_gpu_simple_resource *res)
+void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
+                                struct virtio_gpu_simple_resource *res)
 {
     virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
     res->iov = NULL;
diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/virtio-gpu-bswap.h
index 9124108485..dd1975e2d4 100644
--- a/include/hw/virtio/virtio-gpu-bswap.h
+++ b/include/hw/virtio/virtio-gpu-bswap.h
@@ -63,10 +63,28 @@ virtio_gpu_create_blob_bswap(struct virtio_gpu_resource_create_blob *cblob)
 {
     virtio_gpu_ctrl_hdr_bswap(&cblob->hdr);
     le32_to_cpus(&cblob->resource_id);
+    le32_to_cpus(&cblob->blob_mem);
     le32_to_cpus(&cblob->blob_flags);
+    le32_to_cpus(&cblob->nr_entries);
+    le64_to_cpus(&cblob->blob_id);
     le64_to_cpus(&cblob->size);
 }
 
+static inline void
+virtio_gpu_map_blob_bswap(struct virtio_gpu_resource_map_blob *mblob)
+{
+    virtio_gpu_ctrl_hdr_bswap(&mblob->hdr);
+    le32_to_cpus(&mblob->resource_id);
+    le64_to_cpus(&mblob->offset);
+}
+
+static inline void
+virtio_gpu_unmap_blob_bswap(struct virtio_gpu_resource_unmap_blob *ublob)
+{
+    virtio_gpu_ctrl_hdr_bswap(&ublob->hdr);
+    le32_to_cpus(&ublob->resource_id);
+}
+
 static inline void
 virtio_gpu_scanout_blob_bswap(struct virtio_gpu_set_scanout_blob *ssb)
 {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index de4f624e94..55973e112f 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -257,6 +257,9 @@ void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
 void virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
                                    struct virtio_gpu_resp_edid *edid);
 /* virtio-gpu.c */
+struct virtio_gpu_simple_resource *
+virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
+
 void virtio_gpu_ctrl_response(VirtIOGPU *g,
                               struct virtio_gpu_ctrl_command *cmd,
                               struct virtio_gpu_ctrl_hdr *resp,
@@ -275,6 +278,8 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
                                   uint32_t *niov);
 void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
                                     struct iovec *iov, uint32_t count);
+void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
+                                struct virtio_gpu_simple_resource *res);
 void virtio_gpu_process_cmdq(VirtIOGPU *g);
 void virtio_gpu_device_realize(DeviceState *qdev, Error **errp);
 void virtio_gpu_reset(VirtIODevice *vdev);
-- 
2.42.0.rc1.204.g551eb34607-goog


