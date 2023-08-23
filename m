Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E4B785AC5
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYovA-0000Ae-V6; Wed, 23 Aug 2023 10:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qYou5-0007EN-JH
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:32:14 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qYou3-0002xZ-FU
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PNlMsoNJ/WOouaEuUl1YufvbKA3/cbDyFmRL/iBxDJA=; b=EWy1fBin3TPLnj0/GAfJ1KIc+E
 vCosrAXYp+rSi/8mrFqs6prK5hzFckwhyO0P/J95BtW2mLfH3iJyPXc0lnA0UbcrNUk4gNXzY7I+4
 Ye2Xm7pFf39aLiAJwfq7odfXqteK01UPnFO3yiH6NdFkv09YWsiBsNOVBeWVePSd2Xz5iPtxniFYG
 dzKB9t6jY0ztTKXqA9GGEa9xT+rvYkDRl6hqFok8Sr6Ko7mkUfj7qC0IWGXve2KOQia5kuth6+bzI
 S/DItJpI8X0XDUCU3VeNompYuadfi9tJpZg2aGOFA8rqg0v06PnntWMLc8Lq6hOAVziOcuT7dmhzw
 fXn5iKZV5PPZdFGFJ5zGgFm900tbGogDBpdAFIrWhaX4HrUltyjqDKUUMsH0DkJn/xKj4iSvGBiix
 YHzqoHFgJjHOkHmQoytci41UudyK7uVC1MH1DXwI47Eo78C47LQ80AZN/OJ1KQ9hg9NAemOL/7k4b
 IxtmpZZnk3bDm7B4MJvckBNmq4njYfjC/3+stacrbP5iXnMIC49sjqX4PyItDCmUlPuKOydsGXRz+
 9KmTk4dQnyvgK6iet8p/84vof8d7PLB8kr1L65qow9CxuIvR+Ue4TvvP1BAd6eqEcb8w03wPUS/VW
 Gp+Q7mIa7mtMObRp6UBTNsImGcjf6oLZ1kAAH/k0k=;
Received: from host81-158-188-207.range81-158.btcentralplus.com
 ([81.158.188.207] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qYotU-0008MB-56; Wed, 23 Aug 2023 15:31:40 +0100
Message-ID: <ab53fab4-0d85-1279-c1fd-982af5fe3a6d@ilande.co.uk>
Date: Wed, 23 Aug 2023 15:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, kraxel@redhat.com, akihiko.odaki@gmail.com,
 ray.huang@amd.com, alex.bennee@linaro.org, shentey@gmail.com, hi@alyssa.is,
 ernunes@redhat.com, manos.pitsidianakis@linaro.org
References: <20230817022322.466-1-gurchetansingh@google.com>
 <20230817022322.466-6-gurchetansingh@google.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230817022322.466-6-gurchetansingh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 81.158.188.207
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v7 5/9] gfxstream + rutabaga prep: added need defintions, 
 fields, and options
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/08/2023 03:23, Gurchetan Singh wrote:

> From: Gurchetan Singh <gurchetansingh@chromium.org>
> 
> This modifies the common virtio-gpu.h file have the fields and
> defintions needed by gfxstream/rutabaga, by VirtioGpuRutabaga.
> 
> Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
> Tested-by: Alyssa Ross <hi@alyssa.is>
> Tested-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
> v1: void *rutabaga --> struct rutabaga *rutabaga (Akihiko)
>      have a separate rutabaga device instead of using GL device (Bernard)
> 
> v2: VirtioGpuRutabaga --> VirtIOGPURutabaga (Akihiko)
>      move MemoryRegionInfo into VirtIOGPURutabaga (Akihiko)
>      remove 'ctx' field (Akihiko)
>      remove 'rutabaga_active'
> 
> v6: remove command from commit message, refer to docs instead (Manos)
> 
>   include/hw/virtio/virtio-gpu.h | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 55973e112f..e2a07e68d9 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -38,6 +38,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPUGL, VIRTIO_GPU_GL)
>   #define TYPE_VHOST_USER_GPU "vhost-user-gpu"
>   OBJECT_DECLARE_SIMPLE_TYPE(VhostUserGPU, VHOST_USER_GPU)
>   
> +#define TYPE_VIRTIO_GPU_RUTABAGA "virtio-gpu-rutabaga-device"
> +OBJECT_DECLARE_SIMPLE_TYPE(VirtIOGPURutabaga, VIRTIO_GPU_RUTABAGA)
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
> @@ -232,6 +238,28 @@ struct VhostUserGPU {
>       bool backend_blocked;
>   };
>   
> +#define MAX_SLOTS 4096
> +
> +struct MemoryRegionInfo {
> +    int used;
> +    MemoryRegion mr;
> +    uint32_t resource_id;
> +};
> +
> +struct rutabaga;
> +
> +struct VirtIOGPURutabaga {
> +    struct VirtIOGPU parent_obj;

The QOM macro should define a typedef for you, so you can drop the "struct" here.

> +
> +    struct MemoryRegionInfo memory_regions[MAX_SLOTS];
> +    char *capset_names;
> +    char *wayland_socket_path;
> +    char *wsi;
> +    bool headless;
> +    uint32_t num_capsets;
> +    struct rutabaga *rutabaga;
> +};
> +

Shouldn't the VIRTIO_GPU_RUTABAGA QOM declaration and this structure be in a separate 
virtio-gpu-rutabaga header file which also includes the header defining struct 
rutabaga? The fact that you're having to pre-declare struct rutabaga in this header 
when rutabaga support is an optional dependency doesn't seem right.

>   #define VIRTIO_GPU_FILL_CMD(out) do {                                   \
>           size_t s;                                                       \
>           s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,          \


ATB,

Mark.


