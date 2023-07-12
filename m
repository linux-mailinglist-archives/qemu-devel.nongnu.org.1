Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAFC75063C
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 13:37:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJY8p-0002wJ-Av; Wed, 12 Jul 2023 07:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qJY8m-0002vp-LC
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:36:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1qJY8l-0005JI-0X
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 07:36:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b8ad356fe4so37325105ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689161773; x=1691753773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bvSF4OJBDEjBub38b0B+LTWNUxzYWnJkZFO4j3653KY=;
 b=j1weV4yuLdvpmmR+52mOSDgOecnr5wWIo9ot75EuQDojk1+4OOooi59PxKB3FghO7f
 nG55j1GqnOdz0fqboxTCWtmvJnaiCprDC8lhz4dolt7RAO9qUkI4iYdq9uvzYeBXRqql
 p0e4tufJROcDYaQNEeqtTPwU537eJ2bvLD3nCoO8IrPK82M4qs3Zu09/bOEFA/qS9Z7y
 rBtB88DLoEWqBH0CcjngYsXSUxQzxPnzW1CA44jTRP1XAEBLqQZKB0DWKfau55za9QtL
 9vpS7/0Up7cvISBejm/FbdVUAulmYQvZlTk6yoapoD+m8Y58m/r2igh+2BHcGWEHgGaN
 R7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689161773; x=1691753773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvSF4OJBDEjBub38b0B+LTWNUxzYWnJkZFO4j3653KY=;
 b=Z5NSsTSp4GiBcNVjyGtYXFcdNKvenyeV/qCchYnLEV/odk2F3ThCx48sQ8tndwMB37
 Helf+rVIZ0E+wM9sVeI/fdcVhAUC46rwIfAo6BgjbxK82uK8mIgCKCP2o4i6dJCLtTXj
 kwVvZuKpjmYVLjQPszdRZ4YVxwuU8kJRLo2amWykV+dhqkGbIB6VhZ83d/HBkDNEugS2
 DP10PzkImKLJSCwwvAirqdw61s5i10DSt4JReVx6EUogZ7Lu/adjFknVDHRDzsSo/u5s
 7cbE7wKu07r0b8w6NYdv+lB1aAkqB+jupL6FIcFXlBEXkhFaxLQAjiu2rd83MMF00MNF
 in/A==
X-Gm-Message-State: ABy/qLZcFTyyGs/o8e7IPDpVsSI+B8bDzAPhdvWxRbE6BBMDOTD+wvT8
 q/1x+4idS2g345aDTnmS0Sc=
X-Google-Smtp-Source: APBJJlHMd5VnbrMUgjcZEJkSxSyxS8OaTfi7NNPNkuPMgbG1844sTsFXXoLZWR7NKghFRUp9/p708w==
X-Received: by 2002:a17:902:9a4b:b0:1b3:fb75:dd24 with SMTP id
 x11-20020a1709029a4b00b001b3fb75dd24mr14234004plv.48.1689161772933; 
 Wed, 12 Jul 2023 04:36:12 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 ix13-20020a170902f80d00b001b896686c78sm3751850plb.66.2023.07.12.04.36.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 04:36:12 -0700 (PDT)
Message-ID: <924819be-9181-7119-5f3e-6df0aa3e432a@gmail.com>
Date: Wed, 12 Jul 2023 20:36:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 5/9] gfxstream + rutabaga prep: added need defintions, 
 fields, and options
Content-Language: en-US
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: --cc=kraxel@redhat.com, marcandre.lureau@redhat.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <20230711025649.708-6-gurchetansingh@chromium.org>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230711025649.708-6-gurchetansingh@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/07/11 11:56, Gurchetan Singh wrote:
> This modifies the common virtio-gpu.h file have the fields and
> defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.

s/VirtioGpuRutabaga/VirtIOGPURutabaga/g since VirtIOGPU is spelled this 
way everywhere else.

> 
> - a colon separated list of capset names, defined in the virtio spec
> - a wayland socket path to enable guest Wayland passthrough
> 
> The command to run these would be:
> 
> -device virtio-vga-rutabaga,capset_names=gfxstream:cross-domain, \
>          wayland_socket_path=/run/user/1000/wayland-0,hostmem=8G  \
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> ---
> v2: void *rutabaga --> struct rutabaga *rutabaga (Akihiko)
>      have a separate rutabaga device instead of using GL device (Bernard)
> 
>   include/hw/virtio/virtio-gpu.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 5927ca1864..5a1b15ccb9 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_GL)
>   #define TYPE_VHOST_USER_GPU "vhost-user-gpu"
>   OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)
>   
> +#define TYPE_VIRTIO_GPU_RUTABAGA "virtio-gpu-rutabaga-device"
> +OBJECT_DECLARE_SIMPLE_TYPE(VirtioGpuRutabaga, VIRTIO_GPU_RUTABAGA)
> +
>   struct virtio_gpu_simple_resource {
>       uint32_t resource_id;
>       uint32_t width;
> @@ -94,6 +97,7 @@ enum virtio_gpu_base_conf_flags {
>       VIRTIO_GPU_FLAG_DMABUF_ENABLED,
>       VIRTIO_GPU_FLAG_BLOB_ENABLED,
>       VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED,
> +    VIRTIO_GPU_FLAG_RUTABAGA_ENABLED,
>   };
>   
>   #define virtio_gpu_virgl_enabled(_cfg) \
> @@ -108,6 +112,8 @@ enum virtio_gpu_base_conf_flags {
>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_BLOB_ENABLED))
>   #define virtio_gpu_context_init_enabled(_cfg) \
>       (_cfg.flags & (1 << VIRTIO_GPU_FLAG_CONTEXT_INIT_ENABLED))
> +#define virtio_gpu_rutabaga_enabled(_cfg) \
> +    (_cfg.flags & (1 << VIRTIO_GPU_FLAG_RUTABAGA_ENABLED))
>   #define virtio_gpu_hostmem_enabled(_cfg) \
>       (_cfg.hostmem > 0)
>   
> @@ -229,6 +235,21 @@ struct VhostUserGPU {
>       bool backend_blocked;
>   };
>   
> +struct rutabaga;
> +
> +struct VirtioGpuRutabaga {
> +    struct VirtIOGPU parent_obj;
> +
> +    bool rutabaga_active;
> +    char *capset_names;
> +    char *wayland_socket_path;
> +    char *wsi;
> +    bool headless;
> +    uint32_t num_capsets;
> +    struct rutabaga *rutabaga;
> +    AioContext *ctx;
> +};
> +
>   #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
>           size_t s;                                                       \
>           s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \

