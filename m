Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F2674E48D
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 04:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ3Ym-000373-HW; Mon, 10 Jul 2023 22:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yk-00036b-3o
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:02 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gurchetansingh@chromium.org>)
 id 1qJ3Yi-0005PV-Mx
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 22:57:01 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-565a8d9d832so3758161eaf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 19:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1689044219; x=1691636219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hV0oWjzm0kcp8B4cPZlT0S5P7GJUJeM8x0R1rodum+I=;
 b=Edgqwm3t9Hmfv45Y3IkcY41b/p6qLmvF4AjY6Q7G1ybh6bd6I+cSXL29MUZ+tDA8RQ
 hYTV8ktsbMHOl0yWEcQFCtywrd7ZZXaQOYjmkywHIhtOe638nQSoKQAZi94KouCU8bf9
 m01GIqXJZtn/588csHKaeprod7QMC+b5DuRz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689044219; x=1691636219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hV0oWjzm0kcp8B4cPZlT0S5P7GJUJeM8x0R1rodum+I=;
 b=RpXVyhxxubx+4HeNCGXPbgQL5j7qhOrViBL4wdiPttu5TJqbQjhSZxOWDbVG92B4fD
 Pdq+/8nk8PbOWML8t4T8ELty9Y8dFz4fi8BJR95ijtEwPWoF/atjJ3jZJbtDEC7NMa23
 /6yj7YW+GbzfM6e6L5uYh0kKEqdFXmqA8Zie1kUCyFG5aW3Z9a6ZPtH55rAo8gJ935gx
 vpZWM9K2nNzS2HXKKR+VNg0qfnriqCWTxTK8VpLk006kbgM8cKnkKMTmw2IXQGknPeBj
 gXTBZS2XlTSSM09sMePB8SZB0So0W4m5TbOXWNPq45KJsA4CL/y7b2A1LK0qc+79IAJb
 gZsg==
X-Gm-Message-State: ABy/qLa2Z866m6tCNYIg+9KwIodj1F3LEe8NoaCLOu9YmuY2NdyI+Quz
 ml1UdBIphHKa2ZMgq03e5UJ1wooXsndzLczxMdg=
X-Google-Smtp-Source: APBJJlFdkZQHKmQQC0Rcfriiq5ggUuSi9oxmQ9bnACYC/8eNhyXFtTGcP76qnCRZDCMKqGW/jkeCOA==
X-Received: by 2002:a05:6808:1918:b0:3a3:eab8:8c40 with SMTP id
 bf24-20020a056808191800b003a3eab88c40mr14764472oib.54.1689044219404; 
 Mon, 10 Jul 2023 19:56:59 -0700 (PDT)
Received: from gurchetansingh0.mtv.corp.google.com
 ([2620:15c:a7:2:9292:a9df:b174:f1eb])
 by smtp.gmail.com with ESMTPSA id
 fk13-20020a056a003a8d00b0067903510abbsm474614pfb.163.2023.07.10.19.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 19:56:58 -0700 (PDT)
From: Gurchetan Singh <gurchetansingh@chromium.org>
To: qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com
Subject: [PATCH v1 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
Date: Mon, 10 Jul 2023 19:56:45 -0700
Message-Id: <20230711025649.708-6-gurchetansingh@chromium.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230711025649.708-1-gurchetansingh@chromium.org>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=gurchetansingh@chromium.org; helo=mail-oo1-xc2f.google.com
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

This modifies the common virtio-gpu.h file have the fields and
defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.

- a colon separated list of capset names, defined in the virtio spec
- a wayland socket path to enable guest Wayland passthrough

The command to run these would be:

-device virtio-vga-rutabaga,capset_names=gfxstream:cross-domain, \
        wayland_socket_path=/run/user/1000/wayland-0,hostmem=8G  \

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
v2: void *rutabaga --> struct rutabaga *rutabaga (Akihiko)
    have a separate rutabaga device instead of using GL device (Bernard)

 include/hw/virtio/virtio-gpu.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 5927ca1864..5a1b15ccb9 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_GL)
 #define TYPE_VHOST_USER_GPU "vhost-user-gpu"
 OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)
 
+#define TYPE_VIRTIO_GPU_RUTABAGA "virtio-gpu-rutabaga-device"
+OBJECT_DECLARE_SIMPLE_TYPE(VirtioGpuRutabaga, VIRTIO_GPU_RUTABAGA)
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
 
@@ -229,6 +235,21 @@ struct VhostUserGPU {
     bool backend_blocked;
 };
 
+struct rutabaga;
+
+struct VirtioGpuRutabaga {
+    struct VirtIOGPU parent_obj;
+
+    bool rutabaga_active;
+    char *capset_names;
+    char *wayland_socket_path;
+    char *wsi;
+    bool headless;
+    uint32_t num_capsets;
+    struct rutabaga *rutabaga;
+    AioContext *ctx;
+};
+
 #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
         size_t s;                                                       \
         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
-- 
2.41.0.255.g8b1d071c50-goog


