Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AB977CE1E
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:32:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVv4K-0005nr-FZ; Tue, 15 Aug 2023 10:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVv4G-0005nI-3l
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:30:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVv4B-0001a5-01
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:30:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e7efso49363705e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692109836; x=1692714636;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wMVLaV4x/dls5inmvxJONLne2WJgBiS1OWZAvtrirf0=;
 b=f84GYPQ1AQogZ6LO9aHds7jK5wIunu59peiiRdGufvvyQPU5Dl59AbXlM0yNLDUGrK
 d4CBS7QKOwIfFvBHRALFjkmAZfRqsOs2+AvE2VNsdbHTRve8T4wuCJl7m5a77uqfVeP+
 L8H0FMGt8JgtVAd7C7UDO7quJCM49mdqVD7rc3IguDpU8ZMb7J+TdhSg2DU5JfGWVrwH
 Q5ugL/3VgeokzoLw6xKykFZCp8Q8asbrK7fAumtNpEPdfoC9AFpGp+ajVytabYgXpLQx
 UlaPzoGDLsvtEm9wK3zedae5XgSy4pKM7Gys/3fiv92N99GQ3Yzw+PbDvnqFa+TaiAW0
 tJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692109836; x=1692714636;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wMVLaV4x/dls5inmvxJONLne2WJgBiS1OWZAvtrirf0=;
 b=ar9k3oFoqDegNgV5akbGFY4Ccq7G29kNyuuPl3S2EpBdriTfuF5HKjac2lKC0R2+WL
 xeVQWMuLsYjyBDvFexPNICMgSJSs9/k06zFwgcxBZSqRpaPWVrDG02+lGcvDr+WZg+Ii
 TgSJYo+m1F937eAsQ5fSH8Zi+yI8HtA75G7pqv36dInepB/bGW5PlsFbTw7/S8jOKocl
 PkZfhVwOxC7f7gVLEiW8ic+8J2wRWf2v1LlL9Wpd1Q3XF/RRzxVnAYbd2rmAsAn00OSo
 FPeg/6my+M1R7+PGCur+G+TxW43v8vTOrGLXCe/3wdMQ7iZryjU14C0UyY5y9RICjslb
 nwHQ==
X-Gm-Message-State: AOJu0YxkhJKAjrVeA8kGYX9RxRa/IbFUGWTZ0hfr59Ifx5lFgp1bB6Px
 Trs6D6bPvVJxhJr4vmyEg9FU4VG/tTbKQKr4yL0=
X-Google-Smtp-Source: AGHT+IEmK9a+FpOpAO00RY3+gE60rtCnfhCZ+ege2vKni6Eo5d9Ohdwk9BVqI0QUj9vTXzhFI/Tz1g==
X-Received: by 2002:adf:e3d0:0:b0:319:8cd8:b04e with SMTP id
 k16-20020adfe3d0000000b003198cd8b04emr309979wrm.69.1692109836503; 
 Tue, 15 Aug 2023 07:30:36 -0700 (PDT)
Received: from meli.delivery (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 u16-20020a5d4690000000b00313de682eb3sm18010876wrq.65.2023.08.15.07.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:30:36 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:17:18 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: Re: [PATCH v5 4/9] virtio-gpu: blob prep
User-Agent: meli 0.7.3
References: <20230815003526.631-1-gurchetansingh@chromium.org>
 <20230815003526.631-5-gurchetansingh@chromium.org>
In-Reply-To: <20230815003526.631-5-gurchetansingh@chromium.org>
Message-ID: <zfsax.2t3wcmqvywzk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

On Tue, 15 Aug 2023 03:35, Gurchetan Singh <gurchetansingh@chromium.org> wrote:
>From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
>This adds preparatory functions needed to:
>
>     - decode blob cmds
>     - tracking iovecs
>
>Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
>Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>Tested-by: Alyssa Ross <hi@alyssa.is>
>---
> hw/display/virtio-gpu.c              | 10 +++-------
> include/hw/virtio/virtio-gpu-bswap.h | 18 ++++++++++++++++++
> include/hw/virtio/virtio-gpu.h       |  5 +++++
> 3 files changed, 26 insertions(+), 7 deletions(-)
>
>diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>index 48ef0d9fad..3e658f1fef 100644
>--- a/hw/display/virtio-gpu.c
>+++ b/hw/display/virtio-gpu.c
>@@ -33,15 +33,11 @@
> 
> #define VIRTIO_GPU_VM_VERSION 1
> 
>-static struct virtio_gpu_simple_resource*
>-virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
> static struct virtio_gpu_simple_resource *
> virtio_gpu_find_check_resource(VirtIOGPU *g, uint32_t resource_id,
>                                bool require_backing,
>                                const char *caller, uint32_t *error);
> 
>-static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>-                                       struct virtio_gpu_simple_resource *res);
> static void virtio_gpu_reset_bh(void *opaque);
> 
> void virtio_gpu_update_cursor_data(VirtIOGPU *g,
>@@ -116,7 +112,7 @@ static void update_cursor(VirtIOGPU *g, struct virtio_gpu_update_cursor *cursor)
>                   cursor->resource_id ? 1 : 0);
> }
> 
>-static struct virtio_gpu_simple_resource *
>+struct virtio_gpu_simple_resource *
> virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
> {
>     struct virtio_gpu_simple_resource *res;
>@@ -904,8 +900,8 @@ void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
>     g_free(iov);
> }
> 
>-static void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>-                                       struct virtio_gpu_simple_resource *res)
>+void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>+                                struct virtio_gpu_simple_resource *res)
> {
>     virtio_gpu_cleanup_mapping_iov(g, res->iov, res->iov_cnt);
>     res->iov = NULL;
>diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/virtio-gpu-bswap.h
>index 9124108485..dd1975e2d4 100644
>--- a/include/hw/virtio/virtio-gpu-bswap.h
>+++ b/include/hw/virtio/virtio-gpu-bswap.h
>@@ -63,10 +63,28 @@ virtio_gpu_create_blob_bswap(struct virtio_gpu_resource_create_blob *cblob)
> {
>     virtio_gpu_ctrl_hdr_bswap(&cblob->hdr);
>     le32_to_cpus(&cblob->resource_id);
>+    le32_to_cpus(&cblob->blob_mem);
>     le32_to_cpus(&cblob->blob_flags);
>+    le32_to_cpus(&cblob->nr_entries);
>+    le64_to_cpus(&cblob->blob_id);
>     le64_to_cpus(&cblob->size);
> }
> 
>+static inline void
>+virtio_gpu_map_blob_bswap(struct virtio_gpu_resource_map_blob *mblob)
>+{
>+    virtio_gpu_ctrl_hdr_bswap(&mblob->hdr);
>+    le32_to_cpus(&mblob->resource_id);
>+    le64_to_cpus(&mblob->offset);
>+}
>+
>+static inline void
>+virtio_gpu_unmap_blob_bswap(struct virtio_gpu_resource_unmap_blob *ublob)
>+{
>+    virtio_gpu_ctrl_hdr_bswap(&ublob->hdr);
>+    le32_to_cpus(&ublob->resource_id);
>+}
>+
> static inline void
> virtio_gpu_scanout_blob_bswap(struct virtio_gpu_set_scanout_blob *ssb)
> {
>diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>index de4f624e94..55973e112f 100644
>--- a/include/hw/virtio/virtio-gpu.h
>+++ b/include/hw/virtio/virtio-gpu.h
>@@ -257,6 +257,9 @@ void virtio_gpu_base_fill_display_info(VirtIOGPUBase *g,
> void virtio_gpu_base_generate_edid(VirtIOGPUBase *g, int scanout,
>                                    struct virtio_gpu_resp_edid *edid);
> /* virtio-gpu.c */
>+struct virtio_gpu_simple_resource *
>+virtio_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id);
>+
> void virtio_gpu_ctrl_response(VirtIOGPU *g,
>                               struct virtio_gpu_ctrl_command *cmd,
>                               struct virtio_gpu_ctrl_hdr *resp,
>@@ -275,6 +278,8 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>                                   uint32_t *niov);
> void virtio_gpu_cleanup_mapping_iov(VirtIOGPU *g,
>                                     struct iovec *iov, uint32_t count);
>+void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
>+                                struct virtio_gpu_simple_resource *res);
> void virtio_gpu_process_cmdq(VirtIOGPU *g);
> void virtio_gpu_device_realize(DeviceState *qdev, Error **errp);
> void virtio_gpu_reset(VirtIODevice *vdev);
>-- 
>2.41.0.694.ge786442a9b-goog
>
>

