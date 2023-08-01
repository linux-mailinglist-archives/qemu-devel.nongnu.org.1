Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF3776A62E
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 03:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQe18-0001aX-O4; Mon, 31 Jul 2023 21:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe15-0001a7-DD
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:39 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qQe13-0003Ek-6L
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 21:17:39 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-563dae89bc9so2997474a12.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 18:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1690852655; x=1691457455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4pjghUqkkj5iU/3obNx6ECThjZubgQpv0iAgQoExCY=;
 b=mzzO7NSVoq7vVtdRWd0HkukwZ3MwwSO4FPVUSJHAjDhMTSNugJgJjpBTfSDrX+Hyc0
 j8+3TZ9A7JemNtAdwr+3NZfup7hQl8eNjl/z6kYXmPfJAapDWxOf9iYrMPJ6AE1L36P+
 ajFZPQbpsN0VZF6v73qsP9tkZ4d6vQrIS9fFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690852655; x=1691457455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T4pjghUqkkj5iU/3obNx6ECThjZubgQpv0iAgQoExCY=;
 b=CdzK3Kyc9xepm/Mdx8DSHZoXRqECxpOe2FPI1uNvxR9H+wQv7BY1BORdKbwmHhjg91
 RWOOhSHNMmGVvtH1i/AizOe6AvlbA7hJDak264O0CB8SQuam66LlIvk3y6WRG2jw6BVS
 r7R8Z1grdYIsKuB+0+4DwFqNJ+Dvsmxh7XsQIfHW2BPLw/apwnmAD0G22g+65K5MlvBt
 rnAndXw4C8L45C/SpwFkb8gDvnlK9aNm+THxxZuLInuxUpBbUNQZ2GgcvV6KIzuIxdUZ
 fkcKv3lupUg5w3NqfAfp47EH1EFn+QplA2+DzYYFtdaRZe1lOz+BYbQWZsVSESZIvCbF
 euHQ==
X-Gm-Message-State: ABy/qLaKsOrvqwrEu6UJUfhPwjLPgTqyPkPbN1NmP5froq9BRM1SeeYi
 kprVGRAf7vK75wTb0mTOGjjc/+P8o4VBtwfFiT8=
X-Google-Smtp-Source: APBJJlEGpAZkGstPX1dt1MYc0pHZS9GXJN27HqApHU702pmeTiKG4r5fDcQTRdtJYD7NJyS4QDJqbA==
X-Received: by 2002:a17:90b:4a07:b0:262:f029:6946 with SMTP id
 kk7-20020a17090b4a0700b00262f0296946mr10448246pjb.9.1690852655225; 
 Mon, 31 Jul 2023 18:17:35 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:cb47:8a0d:6476:3e7b])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a17090a899400b00260a5ecd273sm6657722pjn.1.2023.07.31.18.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 18:17:34 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, hi@alyssa.is
Subject: [PATCH v2 4/9] virtio-gpu: blob prep
Date: Mon, 31 Jul 2023 18:17:18 -0700
Message-Id: <20230801011723.627-5-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230801011723.627-1-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pg1-x52a.google.com
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


