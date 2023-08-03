Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 454D876F659
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 01:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRiA1-0007IA-V7; Thu, 03 Aug 2023 19:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9y-0007Gy-7X
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:14 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qRi9v-0003br-HM
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 19:55:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-687087d8ddaso1363695b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1691106910; x=1691711710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4pjghUqkkj5iU/3obNx6ECThjZubgQpv0iAgQoExCY=;
 b=ZvTnN16hGFSh9f9YIvP/JK3amKVjkLFzzSddzrHo6NqIVkiU92/jQ+JrK5l5QGNbBN
 zVxjV1prjrAtNqsz2uQWJglubxr1bN/ELVlJhVY5mQ6xI4HVRQmDxl8Ukror/l5obMRy
 fywlMdSOA+Qhv1cLjQi0wmV0PLziHmvYSSx1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691106910; x=1691711710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4pjghUqkkj5iU/3obNx6ECThjZubgQpv0iAgQoExCY=;
 b=UbyiVcJLiF6TNK+autal/xMNTvHScMm9d4SlP/o+bjIXfLXq6DOGMCCGcT5VPALrYf
 PLnxHHvYtV2INgRae4bx7rsBIJhhijzH8GxuBhpMXps7flsFqZjtEJ+4qXDRFI5OFS7E
 ZL9LEJFC/hvpA6dc6czDMr5AfxgZBKsPiyd1FyhinQ66xFhJMGvUeC422BCnaZQ0P1wh
 YPHvE5wxDqK5XjiK0cd+uluDp/qC2P3PuqE4oPnQviUbe+PtFKQktKbRAOmp4eobQkq+
 hujSexoXcghmLEmJF5Kpk+1MUqsKohggMrU/Gv51x0c4qDvOs8MAihlPuHqb1nRJiT+U
 r8xQ==
X-Gm-Message-State: AOJu0YwOQ882Ptu3aUm4joNVlyNO+4JSMi8XS2i1SRSRClufVHJS4fPi
 77mT+S8Sx96td+P16eVFUjStfWmHOxsM0ABZ/ZU=
X-Google-Smtp-Source: AGHT+IG8kfsIGareRF7C17y7IBQ417OPan+6pRcXmL+ALxBS1zvxOC93SoYt99pf5o5EN30dGyFFgA==
X-Received: by 2002:a05:6a20:258b:b0:13e:e3aa:d871 with SMTP id
 k11-20020a056a20258b00b0013ee3aad871mr94524pzd.53.1691106909950; 
 Thu, 03 Aug 2023 16:55:09 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9efb:b80c:dd5c:56c9])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a63a708000000b0055387ffef10sm364329pgf.24.2023.08.03.16.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 16:55:09 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
X-Google-Original-From: Gurchetan Singh <gurchetansingh@google.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v3 4/9] virtio-gpu: blob prep
Date: Thu,  3 Aug 2023 16:54:57 -0700
Message-Id: <20230803235502.373-5-gurchetansingh@google.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230803235502.373-1-gurchetansingh@google.com>
References: <20230803235502.373-1-gurchetansingh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x42b.google.com
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

This adds preparatory functions needed to:

     - decode blob cmds
     - tracking iovecs

Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 hw/display/virtio-gpu.c              | 11 +++--------
 include/hw/virtio/virtio-gpu-bswap.h | 18 ++++++++++++++++++
 include/hw/virtio/virtio-gpu.h       |  5 +++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 61e8fcde07..6d19205e00 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -32,16 +32,11 @@
 
 #define VIRTIO_GPU_VM_VERSION 1
 
-static struct virtio_gpu_simple_resource*
-virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
 static struct virtio_gpu_simple_resource *
 virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
                                bool require_backing,
                                const char *caller, uint32_t *error);
 
-static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
-                                       struct virtio_gpu_simple_resource *res);
-
 void virtio_gpu_update_cursor_data(VirtIOGPU *g,
                                    struct virtio_gpu_scanout *s,
                                    uint32_t resource_id)
@@ -114,7 +109,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_gpu_update_cursor *cursor)
                   cursor->resource_id ? 1 : 0);
 }
 
-static struct virtio_gpu_simple_resource *
+struct virtio_gpu_simple_resource *
 virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
 {
     struct virtio_gpu_simple_resource *res;
@@ -902,8 +897,8 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
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
index 4158ccf355..f25f3ce075 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -253,6 +253,9 @@ void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
 void virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
                                    struct virtio_gpu_resp_edid *edid);
 /* virtio-gpu.c */
+struct virtio_gpu_simple_resource *
+virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
+
 void virtio_gpu_ctrl_response(VirtIOGPU *g,
                               struct virtio_gpu_ctrl_command *cmd,
                               struct virtio_gpu_ctrl_hdr *resp,
@@ -271,6 +274,8 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
                                   uint32_t *niov);
 void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
                                     struct iovec *iov, uint32_t count);
+void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
+                                struct virtio_gpu_simple_resource *res);
 void virtio_gpu_process_cmdq(VirtIOGPU *g);
 void virtio_gpu_device_realize(DeviceState *qdev, Error **errp);
 void virtio_gpu_reset(VirtIODevice *vdev);
-- 
2.41.0.585.gd2178a4bd4-goog


