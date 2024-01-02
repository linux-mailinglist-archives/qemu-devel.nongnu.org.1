Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F94821CE3
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 14:41:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKezj-0008Re-6F; Tue, 02 Jan 2024 08:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKezb-0008Qf-71
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 08:39:39 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKezZ-0002Sp-C0
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 08:39:38 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so4192524276.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 05:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704202776; x=1704807576; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HV86xnmwiB7VDINqEd3kWQpMQ8gj64ZmQMvMJnPxJHw=;
 b=jFPWVkp0fv+OLGOHRIgYiSn+i37abrwkN6GingaG+Yq+7qh4X2524BsFw3d9a0ULha
 VvLyH8DBSw3wp/lgfFLqWbwMGGWahqx4215CzDvFM7ljMUdfrd4eJIP3qNrgFwY2uYc5
 mCEZXlkyyP+aG2B0AZVj5LAWp7H41xamrAFm4jT6TCu7Lc2sJBoaQg9tn0BkMCw+ldwy
 hTdi+IRHXL/R2BBG16IQST9MdbxBibXflVx/yqnLA654+Whgcee6HbrPvqV8VlXiAPsR
 Ft7o05rkWHj35/DR8X8xx0tcr+Og9V0KzJ5t/WbWXA7t5QWkq8SSOtnGq+I01TVFIL7P
 lAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704202776; x=1704807576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV86xnmwiB7VDINqEd3kWQpMQ8gj64ZmQMvMJnPxJHw=;
 b=q8c8Jqhp0UForQr0Y+ZWY5Hcs2QzW1Y8/Ru1I1z/PKYbKSoIsinUtdGiiq83C4lyP2
 Ic2Tdgu1xp+h4Psoer/b8EQvi6pOdSG6Kd1hJfT77IxF4qgJrmeFroILPAFvsXkgPQhb
 MGBU4S+TDmupE3jfHpaw2bFut8ByZChL173izipkilEKk3DzXcvswDidn0VwoVhNc4Jy
 8J4Tw+1p1KK8UZGhz3+O81ijcETAN+L7/ARy3THynpB55+SBGBwfbat1kcFQLQV0ITtX
 qDjhsnwOYGSn6sj4w/QAMArOfv2KKtopOuBVRUP4NspCYyU+470CH4mTUUtNZlVPbj2M
 D0FQ==
X-Gm-Message-State: AOJu0YyE4xofUcM0fLNpKtkZv1llouXwxksC+sGag2eyTAMNhQGzrFok
 AkS9bNtTSHo0IJUVAptLRH3rEv9jtZQ2vL8TPgY=
X-Google-Smtp-Source: AGHT+IG+OQYIob6RBPwlMR5/Is7PbLOVZQdhhuLkKJ8r9LQnsDgBQJMOskfpkohbDgZyhVoTqqDc1z++SdXMfyS9huI=
X-Received: by 2002:a05:6902:1207:b0:dbe:346b:b9d with SMTP id
 s7-20020a056902120700b00dbe346b0b9dmr3885495ybu.125.1704202776077; Tue, 02
 Jan 2024 05:39:36 -0800 (PST)
MIME-Version: 1.0
References: <20231221102342.4022630-1-julia.zhang@amd.com>
 <20231221102342.4022630-2-julia.zhang@amd.com>
In-Reply-To: <20231221102342.4022630-2-julia.zhang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 17:39:24 +0400
Message-ID: <CAJ+F1CLEG1+JVrjqe2-+kngMSA7xOZ3xL=1kh3fswRJHkLk2ZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virgl: Implement resource_query_layout
To: Julia Zhang <julia.zhang@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <antonio.caggiano@collabora.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, qemu-devel@nongnu.org, 
 xen-devel@lists.xenproject.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Chen Jiqian <Jiqian.Chen@amd.com>, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb2e.google.com
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

On Thu, Dec 21, 2023 at 3:36=E2=80=AFPM Julia Zhang <julia.zhang@amd.com> w=
rote:
>
> From: Daniel Stone <daniels@collabora.com>
>
> A new ioctl to shuttle information between host and guest about the
> actual buffer allocation, which can be used for interop between GL and
> Vulkan when supporting standard window systems.
>

The command hasn't been added to the kernel yet. The function is not
in the virgl library either.

> Signed-off-by: Daniel Stone <daniels@collabora.com>
> Co-developed-by: Julia Zhang <julia.zhang@amd.com>
> Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> ---
>  hw/display/virtio-gpu-base.c                |  4 +++
>  hw/display/virtio-gpu-virgl.c               | 40 +++++++++++++++++++++
>  include/hw/virtio/virtio-gpu-bswap.h        |  7 ++++
>  include/standard-headers/linux/virtio_gpu.h | 30 ++++++++++++++++
>  meson.build                                 |  4 +++
>  5 files changed, 85 insertions(+)
>
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index 6bcee3882f..09b37f015d 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -240,6 +240,10 @@ virtio_gpu_base_get_features(VirtIODevice *vdev, uin=
t64_t features,
>          features |=3D (1 << VIRTIO_GPU_F_RESOURCE_UUID);
>      }
>
> +#ifdef HAVE_VIRGL_RESOURCE_QUERY_LAYOUT
> +    features |=3D (1 << VIRTIO_GPU_F_RESOURCE_QUERY_LAYOUT);
> +#endif /* HAVE_VIRGL_RESOURCE_QUERY_LAYOUT */
> +
>      return features;
>  }
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index c1e7c6d0c6..b331232fee 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -813,6 +813,40 @@ static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>
>  #endif /* HAVE_VIRGL_RESOURCE_BLOB */
>
> +#ifdef HAVE_VIRGL_RESOURCE_QUERY_LAYOUT
> +static void virgl_cmd_resource_query_layout(VirtIOGPU *g,
> +                                           struct virtio_gpu_ctrl_comman=
d *cmd)
> +{
> +    struct virtio_gpu_resource_query_layout qlayout;
> +    struct virtio_gpu_resp_resource_layout resp;
> +    struct virgl_renderer_resource_layout rlayout;
> +    int ret;
> +    int i;
> +    VIRTIO_GPU_FILL_CMD(qlayout);
> +    virtio_gpu_resource_query_layout_bswap(&qlayout);
> +
> +    ret =3D virgl_renderer_resource_query_layout(qlayout.resource_id, &r=
layout,
> +                                              qlayout.width, qlayout.hei=
ght,
> +                                              qlayout.format, qlayout.bi=
nd);
> +    if (ret !=3D 0) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: resource %d is not externall=
y-allocated\n",
> +                      __func__, qlayout.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
> +    memset(&resp, 0, sizeof(resp));
> +    resp.hdr.type =3D VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT;
> +    resp.num_planes =3D rlayout.num_planes;
> +    resp.modifier =3D rlayout.modifier;
> +    for (i =3D 0; i < resp.num_planes; i++) {
> +        resp.planes[i].offset =3D rlayout.planes[i].offset;
> +        resp.planes[i].stride =3D rlayout.planes[i].stride;
> +    }
> +    virtio_gpu_ctrl_response(g, cmd, &resp.hdr, sizeof(resp));
> +}
> +#endif /* HAVE_VIRGL_RESOURCE_QUERY_LAYOUT */
> +
>  void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cm=
d)
>  {
> @@ -896,6 +930,12 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>          virgl_cmd_set_scanout_blob(g, cmd);
>          break;
>  #endif /* HAVE_VIRGL_RESOURCE_BLOB */
> +
> +#ifdef HAVE_VIRGL_RESOURCE_QUERY_LAYOUT
> +    case VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT:
> +       virgl_cmd_resource_query_layout(g, cmd);
> +       break;
> +#endif /* HAVE_VIRGL_RESOURCE_QUERY_LAYOUT*/
>      default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          break;
> diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/vir=
tio-gpu-bswap.h
> index dd1975e2d4..dea8cf6fd3 100644
> --- a/include/hw/virtio/virtio-gpu-bswap.h
> +++ b/include/hw/virtio/virtio-gpu-bswap.h
> @@ -92,4 +92,11 @@ virtio_gpu_scanout_blob_bswap(struct virtio_gpu_set_sc=
anout_blob *ssb)
>      le32_to_cpus(&ssb->offsets[3]);
>  }
>
> +static inline void
> +virtio_gpu_resource_query_layout_bswap(struct virtio_gpu_resource_query_=
layout *rql)
> +{
> +    virtio_gpu_ctrl_hdr_bswap(&rql->hdr);
> +    le32_to_cpus(&rql->resource_id);
> +}
> +
>  #endif
> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standa=
rd-headers/linux/virtio_gpu.h
> index c621389f3d..c9a2f58237 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -65,6 +65,11 @@
>   */
>  #define VIRTIO_GPU_F_CONTEXT_INIT        4
>
> +/*
> + * VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT
> + */
> +#define VIRTIO_GPU_F_RESOURCE_QUERY_LAYOUT 5
> +
>  enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_UNDEFINED =3D 0,
>
> @@ -95,6 +100,7 @@ enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_CMD_SUBMIT_3D,
>         VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB,
>         VIRTIO_GPU_CMD_RESOURCE_UNMAP_BLOB,
> +       VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT,
>
>         /* cursor commands */
>         VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
> @@ -108,6 +114,7 @@ enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_RESP_OK_EDID,
>         VIRTIO_GPU_RESP_OK_RESOURCE_UUID,
>         VIRTIO_GPU_RESP_OK_MAP_INFO,
> +       VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT,
>
>         /* error responses */
>         VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
> @@ -455,4 +462,27 @@ struct virtio_gpu_resource_unmap_blob {
>         uint32_t padding;
>  };
>
> +
> +/* VIRTIO_GPU_CMD_RESOURCE_QUERY_LAYOUT */
> +struct virtio_gpu_resource_query_layout {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       uint32_t resource_id;
> +       uint32_t width;
> +       uint32_t height;
> +       uint32_t format;
> +       uint32_t bind;
> +};
> +
> +/* VIRTIO_GPU_RESP_OK_RESOURCE_LAYOUT */
> +#define VIRTIO_GPU_RES_MAX_PLANES 4
> +struct virtio_gpu_resp_resource_layout {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       uint64_t modifier;
> +       uint32_t num_planes;
> +       struct virtio_gpu_resource_plane {
> +               uint64_t offset;
> +               uint32_t stride;
> +       } planes[VIRTIO_GPU_RES_MAX_PLANES];
> +};
> +
>  #endif
> diff --git a/meson.build b/meson.build
> index a739a62f2c..72024f5f01 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1058,6 +1058,10 @@ if not get_option('virglrenderer').auto() or have_=
system or have_vhost_user_gpu
>                           cc.has_function('virgl_renderer_resource_create=
_blob',
>                                           prefix: '#include <virglrendere=
r.h>',
>                                           dependencies: virgl))
> +    config_host_data.set('HAVE_VIRGL_RESOURCE_QUERY_LAYOUT',
> +                         cc.has_function('virgl_renderer_resource_query_=
layout',
> +                                         prefix: '#include <virglrendere=
r.h>',
> +                                         dependencies: virgl))
>    endif
>  endif
>  rutabaga =3D not_found
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

