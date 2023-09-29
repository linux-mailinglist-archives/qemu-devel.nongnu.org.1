Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489CA7B3B1D
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 22:15:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmJsA-0007bw-Jp; Fri, 29 Sep 2023 16:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJs8-0007bZ-Sa
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:14:00 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qmJs0-0004Jo-UX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:14:00 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso3372559b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696018431; x=1696623231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=se6fWVUXglAfgn2bx9AjYw+O1pSmlqb6dDvvl8grVio=;
 b=Jz/cMjnt0CbeNnUz284ikR+wBlVPRRm4L59cO6liM8pk+qy0sK4TTkqj9FFqMEUErM
 fXfR4W04/69BMYvgg+2Ae/4p/eHtS0rWYdE2Pe0dpNm1IGC6G/HEmO9owhAbfsPIEJBw
 jUnWimHpqo9sAVZXXUKY9Svs5SKOQwmDOryd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696018431; x=1696623231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=se6fWVUXglAfgn2bx9AjYw+O1pSmlqb6dDvvl8grVio=;
 b=fOn5/xGVHQ3BCLcEGVJPcj6L9ctChupcvgaYjGRlzKPkpdp2FzFlrlQquS94w7mu8/
 i0B8vJnx7mawCqOo6aW8VovQ12WP+KKoGzvWb8Liycw57n+lzJ991d1Iv4eMcDp0kHLi
 YdoighV6eegO8GvlO65K076PlTkiUvm0GQnKoSZTRuIUpkPWXVQo0IZC3GnTPtMFI8eC
 6NKM2bNSs276S2Gfg+kanBvVkfd9nhAHwWzqNaeug7DTVSf6AbegkoxJGtAbBdHGaz27
 m3PbLyAmwcJw1bjV2TMC3fFR5Ul/63kg9FE4YwIcvgI3KH50VxGD/RkZhMxEJ3G1ogK6
 R2gg==
X-Gm-Message-State: AOJu0YwXjB4jAFWzl2IjBV9OLkS6VKCBW3JZRYj3B6xC4dtI7fqDMwOI
 vhnW8WaBd9kBzQJEA83SDm1ZccTJIj8dYsAdOR4=
X-Google-Smtp-Source: AGHT+IF4f7ly0e/A79NXgPpIVb3E/HbhrSvs+tByMdYWsSx6XcdyEU2C8Wme1w5JujPMaT0w4ylrdQ==
X-Received: by 2002:a05:6a21:9984:b0:159:beec:79ba with SMTP id
 ve4-20020a056a21998400b00159beec79bamr6109064pzb.2.1696018431249; 
 Fri, 29 Sep 2023 13:13:51 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:18fe:3fb1:d86b:1e68])
 by smtp.gmail.com with ESMTPSA id
 t12-20020aa7938c000000b00686236718d8sm15267033pfe.41.2023.09.29.13.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 13:13:50 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH v14 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Fri, 29 Sep 2023 13:13:37 -0700
Message-Id: <20230929201341.332-6-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230929201341.332-1-gurchetansingh@chromium.org>
References: <20230929201341.332-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=gurchetansingh@chromium.org; helo=mail-pf1-x431.google.com
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

This modifies the common virtio-gpu.h file have the fields and
defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Alyssa Ross <hi@alyssa.is>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/virtio/virtio-gpu.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 55973e112f..39018377d2 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_GL)
 #define TYPE_VHOST_USER_GPU "vhost-user-gpu"
 OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)
 
+#define TYPE_VIRTIO_GPU_RUTABAGA "virtio-gpu-rutabaga-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabaga, VIRTIO_GPU_RUTABAGA)
+
 struct virtio_gpu_simple_resource {
     uint32_t resource_id;
     uint32_t width;
@@ -94,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
     VIRTIO_GPU_FLAG_DMABUF_ENABLED,
     VIRTIO_GPU_FLAG_BLOB_ENABLED,
     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
+    VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
 };
 
 #define virtio_gpu_virgl_enabled(_cfg) \
@@ -108,6 +112,8 @@ enum virtio_gpu_base_conf_flags {
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
 #define virtio_gpu_context_init_enabled(_cfg) \
     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
+#define virtio_gpu_rutabaga_enabled(_cfg) \
+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
 #define virtio_gpu_hostmem_enabled(_cfg) \
     (_cfg.hostmem > 0)
 
@@ -232,6 +238,27 @@ struct VhostUserGPU {
     bool backend_blocked;
 };
 
+#define MAX_SLOTS 4096
+
+struct MemoryRegionInfo {
+    int used;
+    MemoryRegion mr;
+    uint32_t resource_id;
+};
+
+struct rutabaga;
+
+struct VirtIOGPURutabaga {
+    VirtIOGPU parent_obj;
+    struct MemoryRegionInfo memory_regions[MAX_SLOTS];
+    uint64_t capset_mask;
+    char *wayland_socket_path;
+    char *wsi;
+    bool headless;
+    uint32_t num_capsets;
+    struct rutabaga *rutabaga;
+};
+
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
         size_t s;                                                       \
         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
-- 
2.42.0.582.g8ccd20d70d-goog


