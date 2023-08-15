Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AB777CE3F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 16:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvBB-0007hr-PR; Tue, 15 Aug 2023 10:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVvB9-0007bE-LQ
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:37:51 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVvB7-0002mK-9I
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 10:37:51 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31956020336so2756065f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692110267; x=1692715067;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tZpIwepj5RtCgPNL00KkWVi78H2hFbTjCZXhdO8XeIo=;
 b=R7+7XIIQIGdI2Op27webcwZmfUwU90EjRMDXquhrtE3AbBKIq0c0IQfYP1S0SiA6LG
 OEfjvNripdu8rrUTLp4jNgiOgFamKK7dC+GRdKLfM5CyMwP2q3j7ETWsoFEBDkJXercR
 oAZDqgWkszalHTxHYmewKaNNMSQfhEBhzVAzIYXx4g1yXdJRt5UPvpCh+UWP3P+iAk0l
 +951kZU5TLngPWoDYpcJ72v7KGzDpiDIF4d2Tgf1TdcI8iE1g2DMsQ7NHzHqf7GBqgV0
 5p6QHIyhiKlLjamz2DkEotDuBMWJDKuY+oqPlONHRFEbb8TX/6ls6KFIg5hNYEo2fWUy
 1arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110267; x=1692715067;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZpIwepj5RtCgPNL00KkWVi78H2hFbTjCZXhdO8XeIo=;
 b=hDoqzJPhIEOe7G1SN/ob+4bZkiDXyrYAanf1+Kh00mwSwgMx8MSanpgCpEvxBOVlie
 AnXwaqTDo+353kE1xN1EhkdhAu/dH5ttiUt02SSWYhJjm5YKtBiKh8X68814l9zs2ZO0
 yK6q00vhFBIa0CIQ92ttA3yw8dlG94SJdKUtFyYD/qi/lGh4mMvKOdXKh5GEw9qGXSkG
 0rglc4uY1GP2x7R+Rzt4S/nlV2H9pR7fZqbKCuHHnNUl165CggvtgMJ/WvbhSZyKakgS
 8k0FrwdprR8mthUua1WLpveAI2NEwVy4j518P0nqlMQxWfTHDDDgXqMSGeWlWzmzQsCE
 pozg==
X-Gm-Message-State: AOJu0YxVBx7ce0ywcvaMa0J8dCKib3kzTKV3sYqS5md9B4hc/eJiM+d4
 GqsZbEP3SdIXb/VFc9nuRR3bQDeC/gUPbfOm4QY=
X-Google-Smtp-Source: AGHT+IGeF8vhnZg2i0TTuNaR70EHLksH14+GwutAbMAfwxMQ0wCVuC/w+UsjFUxdcELEz7ninEvUlg==
X-Received: by 2002:adf:e3cc:0:b0:314:385d:3f32 with SMTP id
 k12-20020adfe3cc000000b00314385d3f32mr1725262wrm.29.1692110267549; 
 Tue, 15 Aug 2023 07:37:47 -0700 (PDT)
Received: from meli.delivery (adsl-104.37.6.161.tellas.gr. [37.6.161.104])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a7bc38d000000b003fe2ebf479fsm18134051wmj.36.2023.08.15.07.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:37:47 -0700 (PDT)
Date: Tue, 15 Aug 2023 17:31:04 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>
Cc: marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 ernunes@redhat.com, hi@alyssa.is, shentey@gmail.com
Subject: Re: [PATCH v5 5/9] gfxstream + rutabaga prep: added need defintions,
 fields, and options
User-Agent: meli 0.7.3
References: <20230815003526.631-1-gurchetansingh@chromium.org>
 <20230815003526.631-6-gurchetansingh@chromium.org>
In-Reply-To: <20230815003526.631-6-gurchetansingh@chromium.org>
Message-ID: <zfsmx.r2ideyw7vls1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

On Tue, 15 Aug 2023 03:35, Gurchetan Singh <gurchetansingh@chromium.org> 
wrote:
>This modifies the common virtio-gpu.h file have the fields and
>defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.
>
>The command to run these would be:
>
>Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
>Tested-by: Alyssa Ross <hi@alyssa.is>
>---
>-device virtio-vga-rutabaga,capset_names=gfxstream-vulkan:cross-domain, \
>        wayland_socket_path=/run/user/1000/wayland-0,hostmem=8G  \

I think the commit message got mangled here, the commit trailers got 
between "The command to run these would be:" and the CLI flags.

By the way minor typo, splitting the device+commas argument with 
white-space will not get parsed correctly, "wayland_socket_path..." 
should be immediately after the previous comma.

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

>
>v1: void *rutabaga --> struct rutabaga *rutabaga (Akihiko)
>    have a separate rutabaga device instead of using GL device (Bernard)
>
>v2: VirtioGpuRutabaga --> VirtIOGPURutabaga (Akihiko)
>    move MemoryRegionInfo into VirtIOGPURutabaga (Akihiko)
>    remove 'ctx' field (Akihiko)
>    remove 'rutabaga_active'
>
> include/hw/virtio/virtio-gpu.h | 28 ++++++++++++++++++++++++++++
> 1 file changed, 28 insertions(+)
>
>diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
>index 55973e112f..e2a07e68d9 100644
>--- a/include/hw/virtio/virtio-gpu.h
>+++ b/include/hw/virtio/virtio-gpu.h
>@@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_GL)
> #define TYPE_VHOST_USER_GPU "vhost-user-gpu"
> OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)
> 
>+#define TYPE_VIRTIO_GPU_RUTABAGA "virtio-gpu-rutabaga-device"
>+OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabaga, VIRTIO_GPU_RUTABAGA)
>+
> struct virtio_gpu_simple_resource {
>     uint32_t resource_id;
>     uint32_t width;
>@@ -94,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
>     VIRTIO_GPU_FLAG_DMABUF_ENABLED,
>     VIRTIO_GPU_FLAG_BLOB_ENABLED,
>     VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
>+    VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
> };
> 
> #define virtio_gpu_virgl_enabled(_cfg) \
>@@ -108,6 +112,8 @@ enum virtio_gpu_base_conf_flags {
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
> #define virtio_gpu_context_init_enabled(_cfg) \
>     (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
>+#define virtio_gpu_rutabaga_enabled(_cfg) \
>+    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
> #define virtio_gpu_hostmem_enabled(_cfg) \
>     (_cfg.hostmem > 0)
> 
>@@ -232,6 +238,28 @@ struct VhostUserGPU {
>     bool backend_blocked;
> };
> 
>+#define MAX_SLOTS 4096
>+
>+struct MemoryRegionInfo {
>+    int used;
>+    MemoryRegion mr;
>+    uint32_t resource_id;
>+};
>+
>+struct rutabaga;
>+
>+struct VirtIOGPURutabaga {
>+    struct VirtIOGPU parent_obj;
>+
>+    struct MemoryRegionInfo memory_regions[MAX_SLOTS];
>+    char *capset_names;
>+    char *wayland_socket_path;
>+    char *wsi;
>+    bool headless;
>+    uint32_t num_capsets;
>+    struct rutabaga *rutabaga;
>+};
>+
> #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
>         size_t s;                                                       \
>         s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \
>-- 
>2.41.0.694.ge786442a9b-goog
>
>

