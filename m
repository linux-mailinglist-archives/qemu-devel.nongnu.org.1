Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B0A7B72AF
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:46:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmGh-00082p-NF; Tue, 03 Oct 2023 16:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGX-00081w-Hp
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:13 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qnmGV-0004Zi-K1
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:45:13 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6c4e30a3604so891209a34.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696365909; x=1696970709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=se6fWVUXglAfgn2bx9AjYw+O1pSmlqb6dDvvl8grVio=;
 b=B57Fcetxjp8S0J/7GGsmzjJK1ZtYNd1pR3mAofnX/adgoJShW//1PG+1/jy9uloB6a
 8CmD611duD3VslKdfawma1aHS84KHeZu6pXIcJKae7kq6e34NE0BbRberUZ654Hitw2H
 9Q3epvHsI9hndBa1jtVD3mMIT3EEHbklJol0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365909; x=1696970709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=se6fWVUXglAfgn2bx9AjYw+O1pSmlqb6dDvvl8grVio=;
 b=HjHhlqGMI7NPeIRlcjwLWJ/7OFzffZ61Csjf5aLQd5sL/oLwZ48AzhoUROFqlqg2Ps
 lR1pHWSlvrn+yI3A6mHP7XIg62RawWitgvYWW7cXFjZWyH71zG5EcH0QQyHGSe1B0dXc
 wrVPTf+LSdoo6vy7j/dhRkDuux9tkpH4JuAxF1JH1hTlo/G3wUuhiqTj5vcrsFZa9/gd
 d9yWjsFUnO4pNG2ULUhQ2A0Y9tnLHC8Zude2/8dP8oSzdYDTGVXRqLfbXG4j3QY9Dpwy
 B7b+Spu3H0D7SJBubLI0sIb6Ss3QClfEABuJwGDIo4SIdA27ELMpwHJEy2e4aUNrCO2A
 iwhg==
X-Gm-Message-State: AOJu0YwO7blYpzJ0J7yRA2TiLl/3jcmAulixDZIXV2zJ/DIZxolx2nGc
 MvusYIU6HhqvizlURvAV6AxxTWKg+siYhMsjSNA=
X-Google-Smtp-Source: AGHT+IHnbKGncY9AvlO9f1VKglP4UiJEDYhhjGz2QEklTNlcAE2LoXSSH3T6ZRH3gMsuexNdOiWd2g==
X-Received: by 2002:aca:2808:0:b0:3a8:472b:febf with SMTP id
 8-20020aca2808000000b003a8472bfebfmr567618oix.21.1696365909560; 
 Tue, 03 Oct 2023 13:45:09 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9076:49ec:5f9a:e5ec])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a17090aec1400b002777b8fc74bsm3739pjy.21.2023.10.03.13.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:45:09 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: [PATCH v15 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Tue,  3 Oct 2023 13:44:56 -0700
Message-Id: <20231003204500.518-6-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231003204500.518-1-gurchetansingh@chromium.org>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=gurchetansingh@chromium.org; helo=mail-ot1-x32a.google.com
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


