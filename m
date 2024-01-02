Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF19821BC4
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 13:40:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKe2p-0007a9-7o; Tue, 02 Jan 2024 07:38:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKe2m-0007a1-Tf
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:38:52 -0500
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKe2k-0008EL-Db
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:38:52 -0500
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7815c5b69e1so421019085a.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 04:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704199129; x=1704803929; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GcbpqKmrxIcVGhe9jtn9l/ecXesNzVaRkKW9DjDnWgo=;
 b=Tn2BQB4jsg9BDo9ggHlgB4d3nxPYDWfQxyG34H1mXkuCFKvXJzkNtWmleQ7xwqk5g4
 4TZ4z/Y5NuhFVnASk8QZiCNLLbPDLLVuZZlAvZdFKS7moKKGusBgYZzyLRKYuHjlP0+O
 RpvDWV0y1zZJUY8zIrjG74c+4VF7Qi1/5pvErWoa8EFLL6uPrp7d4vs8cqSa8hVZ7a8b
 0JZx33PMECBjIRs3HQMc+mTNE3sQxeHcAPNJBTDfSreUE4qTLDdV5ZPWTMmka12kOKcy
 /MDbwIPUN12a67a9ePmKBk1zfEFRyp3w2wIYDITLhA295iC4RVWWMWTAOnFu6v4FP+Pv
 28rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704199129; x=1704803929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GcbpqKmrxIcVGhe9jtn9l/ecXesNzVaRkKW9DjDnWgo=;
 b=UBmX29nHgOFF0S4TwCCl2Ml05oZ1Oi0Lhv7L/DBo2Z46HOR4NU6XvzZktGDPGwRYhO
 3R0b+CmDzvP8eEvQ3kk/mydnAoyg342K0QvEYoh5YDgsUWoQmGB2h/5pHMGikge35Awo
 Wraos1B6erN5BH0fveXaDQUbUnTBoYqBaSeFqvOjIeJKseHXzk+JMDWknbcUicje/ccJ
 yOcVDXOHYrC2WAjxyryGgKiVCvTd2hoECDJocKt8HHMm472zb7vHhvkUErbejwBwj1Mp
 PUgO2iubR02Qd5I2OaD708XoCPiytWG2tKJHRPOetikm8FjvCFon5MjE63zaR1/5tmdX
 DYng==
X-Gm-Message-State: AOJu0Yy0Oadc0KuJ21gjK+0haHq6+3y/g3Pr4r9L+oYDRig5Sou01Lio
 ZCkpQNEMxZdfRYz5bSxhlR8VJJKJOsA6kI0biMk=
X-Google-Smtp-Source: AGHT+IG26kYUFaWjf5uZDH3egMIl6ti9fbtHooLz/bmbTpxtaSMd+ZpifQ3ZfowgyeX7A31OlfuSAlPW2KuImvPJXE8=
X-Received: by 2002:ac8:5906:0:b0:428:272c:a655 with SMTP id
 6-20020ac85906000000b00428272ca655mr3086343qty.2.1704199129149; Tue, 02 Jan
 2024 04:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-8-ray.huang@amd.com>
In-Reply-To: <20231219075320.165227-8-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 16:38:37 +0400
Message-ID: <CAJ+F1CKDJdXFdVx0qLs9mFAdWucrkA3m19XECs6jwN4xH+5j6g@mail.gmail.com>
Subject: Re: [PATCH v6 07/11] virtio-gpu: Handle resource blob commands
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Tue, Dec 19, 2023 at 11:55=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrot=
e:
>
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
>
> Support BLOB resources creation, mapping and unmapping by calling the
> new stable virglrenderer 0.10 interface. Only enabled when available and
> via the blob config. E.g. -device virtio-vga-gl,blob=3Dtrue
>
> Signed-off-by: Antonio Caggiano <antonio.caggiano@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Xenia Ragiadakou <xenia.ragiadakou@amd.com>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> Changes in v6:
> - Use new struct virgl_gpu_resource.
> - Unmap, unref and destroy the resource only after the memory region
>   has been completely removed.
> - In unref check whether the resource is still mapped.
> - In unmap_blob check whether the resource has been already unmapped.
> - Fix coding style
>
>  hw/display/virtio-gpu-virgl.c | 274 +++++++++++++++++++++++++++++++++-
>  hw/display/virtio-gpu.c       |   4 +-
>  meson.build                   |   4 +
>  3 files changed, 276 insertions(+), 6 deletions(-)

Could you split this patch to introduce the new resource
ref/get/put/destroy functions first, before adding the blob commands.
Please explain the rationale of the changes, why they are safe or
equivalent to current code. I'd also suggest documentation and better
naming for the functions, or inlined code as appropriate, as it's
confusing to understand together what should be used and when.

>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index faab374336..5a3a292f79 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -17,6 +17,7 @@
>  #include "trace.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-gpu.h"
> +#include "hw/virtio/virtio-gpu-bswap.h"
>
>  #include "ui/egl-helpers.h"
>
> @@ -24,8 +25,62 @@
>
>  struct virgl_gpu_resource {
>      struct virtio_gpu_simple_resource res;
> +    uint32_t ref;
> +    VirtIOGPU *g;
> +
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    /* only blob resource needs this region to be mapped as guest mmio *=
/
> +    MemoryRegion *region;
> +#endif
>  };
>
> +static void vres_get_ref(struct virgl_gpu_resource *vres)
> +{
> +    uint32_t ref;
> +
> +    ref =3D qatomic_fetch_inc(&vres->ref);
> +    g_assert(ref < INT_MAX);
> +}
> +
> +static void virgl_resource_destroy(struct virgl_gpu_resource *vres)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +    VirtIOGPU *g;
> +
> +    if (!vres) {
> +        return;
> +    }
> +
> +    g =3D vres->g;
> +    res =3D &vres->res;
> +    QTAILQ_REMOVE(&g->reslist, res, next);
> +    virtio_gpu_cleanup_mapping(g, res);
> +    g_free(vres);
> +}
> +
> +static void virgl_resource_unref(struct virgl_gpu_resource *vres)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +
> +    if (!vres) {
> +        return;
> +    }
> +
> +    res =3D &vres->res;
> +    virgl_renderer_resource_detach_iov(res->resource_id, NULL, NULL);
> +    virgl_renderer_resource_unref(res->resource_id);
> +}
> +
> +static void vres_put_ref(struct virgl_gpu_resource *vres)
> +{
> +    g_assert(vres->ref > 0);
> +
> +    if (qatomic_fetch_dec(&vres->ref) =3D=3D 1) {
> +        virgl_resource_unref(vres);
> +        virgl_resource_destroy(vres);
> +    }
> +}
> +
>  static struct virgl_gpu_resource *
>  virgl_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
>  {
> @@ -59,6 +114,8 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g,
>                                         c2d.width, c2d.height);
>
>      vres =3D g_new0(struct virgl_gpu_resource, 1);
> +    vres_get_ref(vres);
> +    vres->g =3D g;
>      vres->res.width =3D c2d.width;
>      vres->res.height =3D c2d.height;
>      vres->res.format =3D c2d.format;
> @@ -91,6 +148,8 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g,
>                                         c3d.width, c3d.height, c3d.depth)=
;
>
>      vres =3D g_new0(struct virgl_gpu_resource, 1);
> +    vres_get_ref(vres);
> +    vres->g =3D g;
>      vres->res.width =3D c3d.width;
>      vres->res.height =3D c3d.height;
>      vres->res.format =3D c3d.format;
> @@ -126,12 +185,21 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>          return;
>      }
>
> -    virgl_renderer_resource_detach_iov(unref.resource_id, NULL, NULL);
> -    virgl_renderer_resource_unref(unref.resource_id);
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    if (vres->region) {
> +        VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(g);
> +        MemoryRegion *mr =3D vres->region;
> +
> +        warn_report("%s: blob resource %d not unmapped",
> +                    __func__, unref.resource_id);
> +        vres->region =3D NULL;
> +        memory_region_set_enabled(mr, false);
> +        memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));
> +    }
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
>
> -    QTAILQ_REMOVE(&g->reslist, &vres->res, next);
> -    virtio_gpu_cleanup_mapping(g, &vres->res);
> -    g_free(vres);
> +    vres_put_ref(vres);
>  }
>
>  static void virgl_cmd_context_create(VirtIOGPU *g,
> @@ -470,6 +538,191 @@ static void virgl_cmd_get_capset(VirtIOGPU *g,
>      g_free(resp);
>  }
>
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +
> +static void virgl_resource_unmap(struct virgl_gpu_resource *vres)
> +{
> +    if (!vres) {
> +        return;
> +    }
> +
> +    virgl_renderer_resource_unmap(vres->res.resource_id);
> +
> +    vres_put_ref(vres);
> +}
> +
> +static void virgl_resource_blob_async_unmap(void *obj)
> +{
> +    MemoryRegion *mr =3D MEMORY_REGION(obj);
> +    struct virgl_gpu_resource *vres =3D mr->opaque;
> +
> +    virgl_resource_unmap(vres);
> +
> +    g_free(obj);
> +}
> +
> +static void virgl_cmd_resource_create_blob(VirtIOGPU *g,
> +                                           struct virtio_gpu_ctrl_comman=
d *cmd)
> +{
> +    struct virgl_gpu_resource *vres;
> +    struct virtio_gpu_resource_create_blob cblob;
> +    struct virgl_renderer_resource_create_blob_args virgl_args =3D { 0 }=
;
> +    int ret;
> +
> +    VIRTIO_GPU_FILL_CMD(cblob);
> +    virtio_gpu_create_blob_bswap(&cblob);
> +    trace_virtio_gpu_cmd_res_create_blob(cblob.resource_id, cblob.size);
> +
> +    if (cblob.resource_id =3D=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed=
\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    vres =3D virgl_gpu_find_resource(g, cblob.resource_id);
> +    if (vres) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n=
",
> +                      __func__, cblob.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    vres =3D g_new0(struct virgl_gpu_resource, 1);
> +    vres_get_ref(vres);
> +    vres->g =3D g;
> +    vres->res.resource_id =3D cblob.resource_id;
> +    vres->res.blob_size =3D cblob.size;
> +
> +    if (cblob.blob_mem !=3D VIRTIO_GPU_BLOB_MEM_HOST3D) {
> +        ret =3D virtio_gpu_create_mapping_iov(g, cblob.nr_entries, sizeo=
f(cblob),
> +                                            cmd, &vres->res.addrs,
> +                                            &vres->res.iov, &vres->res.i=
ov_cnt);
> +        if (!ret) {
> +            g_free(vres);
> +            cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> +            return;
> +        }
> +    }
> +
> +    QTAILQ_INSERT_HEAD(&g->reslist, &vres->res, next);
> +
> +    virgl_args.res_handle =3D cblob.resource_id;
> +    virgl_args.ctx_id =3D cblob.hdr.ctx_id;
> +    virgl_args.blob_mem =3D cblob.blob_mem;
> +    virgl_args.blob_id =3D cblob.blob_id;
> +    virgl_args.blob_flags =3D cblob.blob_flags;
> +    virgl_args.size =3D cblob.size;
> +    virgl_args.iovecs =3D vres->res.iov;
> +    virgl_args.num_iovs =3D vres->res.iov_cnt;
> +
> +    ret =3D virgl_renderer_resource_create_blob(&virgl_args);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: virgl blob create error: %s\=
n",
> +                      __func__, strerror(-ret));
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> +    }
> +}
> +
> +static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
> +                                        struct virtio_gpu_ctrl_command *=
cmd)
> +{
> +    struct virgl_gpu_resource *vres;
> +    struct virtio_gpu_resource_map_blob mblob;
> +    int ret;
> +    void *data;
> +    uint64_t size;
> +    struct virtio_gpu_resp_map_info resp;
> +    VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(g);
> +
> +    VIRTIO_GPU_FILL_CMD(mblob);
> +    virtio_gpu_map_blob_bswap(&mblob);
> +
> +    if (mblob.resource_id =3D=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed=
\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    vres =3D virgl_gpu_find_resource(g, mblob.resource_id);
> +    if (!vres) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n=
",
> +                      __func__, mblob.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (vres->region) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already mapped %d\n=
",
> +                      __func__, mblob.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    ret =3D virgl_renderer_resource_map(vres->res.resource_id, &data, &s=
ize);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource map error: %s\n",
> +                      __func__, strerror(-ret));
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    vres_get_ref(vres);
> +    vres->region =3D g_new0(MemoryRegion, 1);
> +    memory_region_init_ram_ptr(vres->region, OBJECT(g), NULL, size, data=
);
> +    vres->region->opaque =3D vres;
> +    OBJECT(vres->region)->free =3D virgl_resource_blob_async_unmap;
> +    memory_region_add_subregion(&b->hostmem, mblob.offset, vres->region)=
;
> +    memory_region_set_enabled(vres->region, true);
> +
> +    memset(&resp, 0, sizeof(resp));
> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_MAP_INFO;
> +    virgl_renderer_resource_get_map_info(mblob.resource_id, &resp.map_in=
fo);
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +
> +static void virgl_cmd_resource_unmap_blob(VirtIOGPU *g,
> +                                          struct virtio_gpu_ctrl_command=
 *cmd)
> +{
> +    struct virgl_gpu_resource *vres;
> +    struct virtio_gpu_resource_unmap_blob ublob;
> +    VirtIOGPUBase *b =3D VIRTIO_GPU_BASE(g);
> +    MemoryRegion *mr;
> +
> +    VIRTIO_GPU_FILL_CMD(ublob);
> +    virtio_gpu_unmap_blob_bswap(&ublob);
> +
> +    if (ublob.resource_id =3D=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource id 0 is not allowed=
\n",
> +                      __func__);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    vres =3D virgl_gpu_find_resource(g, ublob.resource_id);
> +    if (!vres) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource does not exist %d\n=
",
> +                      __func__, ublob.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    if (!vres->region) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already unmapped %d=
\n",
> +                      __func__, ublob.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    mr =3D vres->region;
> +    vres->region =3D NULL;
> +    memory_region_set_enabled(mr, false);
> +    memory_region_del_subregion(&b->hostmem, mr);
> +    object_unparent(OBJECT(mr));
> +}
> +
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
>  void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cm=
d)
>  {
> @@ -536,6 +789,17 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>      case VIRTIO_GPU_CMD_GET_EDID:
>          virtio_gpu_get_edid(g, cmd);
>          break;
> +#ifdef HAVE_VIRGL_RESOURCE_BLOB
> +    case VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB:
> +        virgl_cmd_resource_create_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB:
> +        virgl_cmd_resource_map_blob(g, cmd);
> +        break;
> +    case VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB:
> +        virgl_cmd_resource_unmap_blob(g, cmd);
> +        break;
> +#endif /* HAVE_VIRGL_RESOURCE_BLOB */
>      default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          break;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 4c3ec9d0ea..8189c392dc 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1449,10 +1449,12 @@ void virtio_gpu_device_realize(DeviceState *qdev,=
 Error **errp)
>              return;
>          }
>
> +#ifndef HAVE_VIRGL_RESOURCE_BLOB
>          if (virtio_gpu_virgl_enabled(g->parent_obj.conf)) {
> -            error_setg(errp, "blobs and virgl are not compatible (yet)")=
;
> +            error_setg(errp, "Linked virglrenderer does not support blob=
 resources");
>              return;
>          }
> +#endif
>      }
>
>      if (!virtio_gpu_base_device_realize(qdev,
> diff --git a/meson.build b/meson.build
> index ea52ef1b9c..629407128e 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1054,6 +1054,10 @@ if not get_option('virglrenderer').auto() or have_=
system or have_vhost_user_gpu
>                           cc.has_function('virgl_renderer_context_create_=
with_flags',
>                                           prefix: '#include <virglrendere=
r.h>',
>                                           dependencies: virgl))
> +    config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB',
> +                         cc.has_function('virgl_renderer_resource_create=
_blob',
> +                                         prefix: '#include <virglrendere=
r.h>',
> +                                         dependencies: virgl))
>    endif
>  endif
>  rutabaga =3D not_found
> --
> 2.25.1
>


--=20
Marc-Andr=C3=A9 Lureau

