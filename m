Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2997288FD
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:49:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7LcK-0004LS-TT; Thu, 08 Jun 2023 15:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bob.beckett@collabora.com>)
 id 1q7Ihd-0001it-Q6
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:41:37 -0400
Received: from madras.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e5ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bob.beckett@collabora.com>)
 id 1q7Iha-0002ZA-N8
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:41:37 -0400
Received: from [192.168.178.53] (82-71-8-225.dsl.in-addr.zen.co.uk
 [82.71.8.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: bbeckett)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 16AEE6606EC6;
 Thu,  8 Jun 2023 17:41:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1686242490;
 bh=Rzujm8ZEu4vFHkLsK4BgjWVbvoM14g7ZNrm+vswmQsU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jWgmTkGu1rjEplOwPqxZHUReS50eP89h/htmAUkvtGNCAMCXYAqVHeYmUHwHz2LDX
 /U/GMLG4mBASufKBUXErAHExpIP4BlHJpNZNP5v+YQLkQkOLueACNSk72wLJi0wUsE
 MHU6siynd/dV/cZiyE11QRx9dRqF0aA+OpgoAS2QrmN2W44hdMF/eQknCsIjSRJp3t
 2amueOH5W3tCYW1TlHCVl1IS03QJnPpFrrPFNeNa31WIBaqHrJNhL40N7Y+Nva60z+
 flK15+ndQoMY+sJwl6UPlsDGCVklazd36BHYVS61OsxK3cc4TvzRGQ9auRWDfUZMzE
 n4DuGzs5oQmFA==
Message-ID: <d52c64d6-8c42-373b-7543-ffdcea7dcbc2@collabora.com>
Date: Thu, 8 Jun 2023 17:41:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [QEMU PATCH 1/1] virtgpu: do not destroy resources when guest
 suspend
To: Jiqian Chen <Jiqian.Chen@amd.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Jan Beulich <jbeulich@suse.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 xen-devel@lists.xenproject.org
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
 Huang Rui <Ray.Huang@amd.com>
References: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
 <20230608025655.1674357-2-Jiqian.Chen@amd.com>
Content-Language: en-US
From: Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <20230608025655.1674357-2-Jiqian.Chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1098:0:82:1000:25:2eeb:e5ab;
 envelope-from=bob.beckett@collabora.com; helo=madras.collabora.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 15:48:17 -0400
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


On 08/06/2023 03:56, Jiqian Chen wrote:
> After suspending and resuming guest VM, you will get
> a black screen, and the display can't come back.
>
> This is because when guest did suspending, it called
> into qemu to call virtio_gpu_gl_reset. In function
> virtio_gpu_gl_reset, it destroyed resources and reset
> renderer, which were used for display. As a result,
> guest's screen can't come back to the time when it was
> suspended and only showed black.
>
> So, this patch adds a new ctrl message
> VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from
> guest. If guest is during suspending, it sets freezing
> status of virtgpu to true, this will prevent destroying
> resources and resetting renderer when guest calls into
> virtio_gpu_gl_reset. If guest is during resuming, it sets
> freezing to false, and then virtio_gpu_gl_reset will keep
> its origin actions and has no other impaction.
>
> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>   hw/display/virtio-gpu-gl.c                  |  9 ++++++-
>   hw/display/virtio-gpu-virgl.c               |  3 +++
>   hw/display/virtio-gpu.c                     | 26 +++++++++++++++++++--
>   include/hw/virtio/virtio-gpu.h              |  3 +++
>   include/standard-headers/linux/virtio_gpu.h |  9 +++++++
>   5 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index e06be60dfb..e11ad233eb 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -100,7 +100,14 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>        */
>       if (gl->renderer_inited && !gl->renderer_reset) {
>           virtio_gpu_virgl_reset_scanout(g);
> -        gl->renderer_reset = true;
> +        /*
> +         * If guest is suspending, we shouldn't reset renderer,
> +         * otherwise, the display can't come back to the time when
> +         * it was suspended after guest resumed.
> +         */
> +        if (!g->freezing) {
> +            gl->renderer_reset = true;
> +        }
>       }
>   }
>   
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index 73cb92c8d5..183ec92d53 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -464,6 +464,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>       case VIRTIO_GPU_CMD_GET_EDID:
>           virtio_gpu_get_edid(g, cmd);
>           break;
> +    case VIRTIO_GPU_CMD_STATUS_FREEZING:
> +        virtio_gpu_cmd_status_freezing(g, cmd);
> +        break;
>       default:
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           break;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5e15c79b94..8f235d7848 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -373,6 +373,16 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU *g,
>       QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>   }
>   
> +void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,
> +                         struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_status_freezing sf;
> +
> +    VIRTIO_GPU_FILL_CMD(sf);
> +    virtio_gpu_bswap_32(&sf, sizeof(sf));
> +    g->freezing = sf.freezing;
> +}
> +
>   static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>   {
>       struct virtio_gpu_scanout *scanout = &g->parent_obj.scanout[scanout_id];
> @@ -986,6 +996,9 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>       case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>           virtio_gpu_resource_detach_backing(g, cmd);
>           break;
> +    case VIRTIO_GPU_CMD_STATUS_FREEZING:
> +        virtio_gpu_cmd_status_freezing(g, cmd);
> +        break;
>       default:
>           cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>           break;
> @@ -1344,6 +1357,8 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
>       QTAILQ_INIT(&g->reslist);
>       QTAILQ_INIT(&g->cmdq);
>       QTAILQ_INIT(&g->fenceq);
> +
> +    g->freezing = false;
>   }
>   
>   void virtio_gpu_reset(VirtIODevice *vdev)
> @@ -1352,8 +1367,15 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>       struct virtio_gpu_simple_resource *res, *tmp;
>       struct virtio_gpu_ctrl_command *cmd;
>   
> -    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> -        virtio_gpu_resource_destroy(g, res);
> +    /*
> +     * If guest is suspending, we shouldn't destroy resources,
> +     * otherwise, the display can't come back to the time when
> +     * it was suspended after guest resumed.
> +     */


What should happen if qemu is torn down while the guest is suspended.
Currently there is no other place where the resources will be destroyed. 
While it is likely viable to rely on process auto tear down of mem and 
files from the host cleanup point of view, it feels bad to rely on that.
Perhaps an inverted conditional with destroy loop in 
virtio_gpu_device_unrealize() would suffice?

I am not a qemu expert, but I am assuming that the unrealize call will 
be called during machine destruction if the guest is suspended.
Also if qemu supports (or intends to support in future) hotplugging of 
the device, the would help avoid leaks until qemu exit too.


> +    if (!g->freezing) {
> +        QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> +            virtio_gpu_resource_destroy(g, res);
> +        }
>       }
>   
>       while (!QTAILQ_EMPTY(&g->cmdq)) {
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
> index 2e28507efe..c21c2990fb 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -173,6 +173,7 @@ struct VirtIOGPU {
>   
>       uint64_t hostmem;
>   
> +    bool freezing;
>       bool processing_cmdq;
>       QEMUTimer *fence_poll;
>       QEMUTimer *print_stats;
> @@ -284,5 +285,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>   void virtio_gpu_virgl_reset(VirtIOGPU *g);
>   int virtio_gpu_virgl_init(VirtIOGPU *g);
>   int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
> +void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,
> +                         struct virtio_gpu_ctrl_command *cmd);
>   
>   #endif
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard-headers/linux/virtio_gpu.h
> index 2da48d3d4c..aefffbd751 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -116,6 +116,9 @@ enum virtio_gpu_ctrl_type {
>   	VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
>   	VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
>   	VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
> +
> +	/* status */
> +	VIRTIO_GPU_CMD_STATUS_FREEZING = 0x1300,
>   };
>   
>   enum virtio_gpu_shm_id {
> @@ -453,4 +456,10 @@ struct virtio_gpu_resource_unmap_blob {
>   	uint32_t padding;
>   };
>   
> +/* VIRTIO_GPU_CMD_STATUS_FREEZING */
> +struct virtio_gpu_status_freezing {
> +	struct virtio_gpu_ctrl_hdr hdr;
> +	__u32 freezing;
> +};
> +
>   #endif

