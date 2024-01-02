Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C9D821B3C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 12:53:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdJl-0000kd-2w; Tue, 02 Jan 2024 06:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKdJi-0000kQ-Pd
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:52:18 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKdJh-0007EG-1T
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 06:52:18 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3bbebe6191bso2442685b6e.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 03:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704196336; x=1704801136; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFmcKa0V1SXEd2KZZXGrlYbPhOuudVLjDBKA5R7e/lM=;
 b=YQ6B6V5KN517RsXBvjZIZMurjuHgR6Hv6CDKuaxrVH2JQr7JENrIzFRdsUkYS+2aQL
 65ceka6B/leLiDn+LqW+4nACxFGH1JLPSMmMBdb0TW5XZ+Bvr6lppVJn5u/WvuI5FAWu
 1iOLi9l3a6K/2y0OY+peKUJTZ14HH2z9ZpX1iDnCzp5x5L3kgsgb+Zz1BNrerMUPEPOR
 v0jP/Pw0JVMcOsNzYIx4065uelIoTuu+oI/OK8lsvu5yK584d788KGh8Ts20mNY7+MR0
 PhuiBBV0J+LoSj6/vOQH9g3SNEdn3avnHfp+vZry3TyYcnbB0m6Y6k79zG75Nt5qvXHl
 5CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704196336; x=1704801136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFmcKa0V1SXEd2KZZXGrlYbPhOuudVLjDBKA5R7e/lM=;
 b=R2MrY/AUO4gNH1Hoyr0Knp4zNDQHmuBvd2MyG1s4FjH3RIO7rDw9bFd9gEr8nDVBVi
 64AUaAVBVJbSVs6FFj3hsHrr4w7AWCmMLs5gG41yM6W7+iUKSxGt/QWpvd0N4sfp/jPp
 8ajeHTZj875lrNeKc2DkhKglC4vFrRm9fqTGgTylZ8tWjarYGW9Sk/ozzdvFO6qNcF+V
 7s/5kpZhGePhmgM0UCI9cH1aOBoksYFTaZotXje/TitNk3xvXdLSl0maZGuCHLmB8k9Y
 45hA5H/FROK6WVwcUlRYrQKMq4IJAEuXLyBtz155KD/NLyuZ2ZMCe2wh7KT69+BJd0xr
 sU9A==
X-Gm-Message-State: AOJu0YzUPp+cnV/TRyCXFafNKC25oSASOZCXCGT8ld5W4lnZJ2c05Oqf
 zcmuf/hFjjljdPFVd82tbD3gTD1tCeOgk87p9q0=
X-Google-Smtp-Source: AGHT+IHudrFSrTiSo9q3MtaVIl5rejRXuPWYRNchd/Kok95sEO10YWSEraRSZCSSP/MkRfsU8pKG3dNaLS2KbqKkPDk=
X-Received: by 2002:a05:6808:2f1a:b0:3bc:804:580e with SMTP id
 gu26-20020a0568082f1a00b003bc0804580emr4550071oib.99.1704196335863; Tue, 02
 Jan 2024 03:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-6-ray.huang@amd.com>
In-Reply-To: <20231219075320.165227-6-ray.huang@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 15:52:04 +0400
Message-ID: <CAJ+F1CKOsDk835H8j56mfS7e=8BusYjo3mJYwuPbdRPq1MmNzw@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] virtio-gpu: Introduce virgl_gpu_resource
 structure
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
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x231.google.com
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
> Introduce a new virgl_gpu_resource data structure and helper functions
> for virgl. It's used to add new member which is specific for virgl in
> following patches of blob memory support.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>
> New patch:
> - Introduce new struct virgl_gpu_resource to store virgl specific members=
.
> - Move resource initialization from path "virtio-gpu: Resource UUID" here=
.
> - Remove error handling of g_new0, because glib will abort() on OOM.
> - Set iov and iov_cnt in struct virtio_gpu_simple_resource for all types
>   of resources.
>
>  hw/display/virtio-gpu-virgl.c | 84 ++++++++++++++++++++++++++---------
>  1 file changed, 64 insertions(+), 20 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 5bbc8071b2..faab374336 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -22,6 +22,23 @@
>
>  #include <virglrenderer.h>
>
> +struct virgl_gpu_resource {
> +    struct virtio_gpu_simple_resource res;
> +};
> +
> +static struct virgl_gpu_resource *
> +virgl_gpu_find_resource(VirtIOGPU *g, uint32_t resource_id)
> +{
> +    struct virtio_gpu_simple_resource *res;
> +
> +    res =3D virtio_gpu_find_resource(g, resource_id);
> +    if (!res) {
> +        return NULL;
> +    }
> +
> +    return container_of(res, struct virgl_gpu_resource, res);
> +}
> +
>  #if VIRGL_RENDERER_CALLBACKS_VERSION >=3D 4
>  static void *
>  virgl_get_egl_display(G_GNUC_UNUSED void *cookie)
> @@ -35,11 +52,19 @@ static void virgl_cmd_create_resource_2d(VirtIOGPU *g=
,
>  {
>      struct virtio_gpu_resource_create_2d c2d;
>      struct virgl_renderer_resource_create_args args;
> +    struct virgl_gpu_resource *vres;
>
>      VIRTIO_GPU_FILL_CMD(c2d);
>      trace_virtio_gpu_cmd_res_create_2d(c2d.resource_id, c2d.format,
>                                         c2d.width, c2d.height);
>

It should check the resource doesn't already exist (similar to 2d code)

> +    vres =3D g_new0(struct virgl_gpu_resource, 1);
> +    vres->res.width =3D c2d.width;
> +    vres->res.height =3D c2d.height;
> +    vres->res.format =3D c2d.format;
> +    vres->res.resource_id =3D c2d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, &vres->res, next);
> +
>      args.handle =3D c2d.resource_id;
>      args.target =3D 2;
>      args.format =3D c2d.format;
> @@ -59,11 +84,19 @@ static void virgl_cmd_create_resource_3d(VirtIOGPU *g=
,
>  {
>      struct virtio_gpu_resource_create_3d c3d;
>      struct virgl_renderer_resource_create_args args;
> +    struct virgl_gpu_resource *vres;
>
>      VIRTIO_GPU_FILL_CMD(c3d);
>      trace_virtio_gpu_cmd_res_create_3d(c3d.resource_id, c3d.format,
>                                         c3d.width, c3d.height, c3d.depth)=
;
>

same

> +    vres =3D g_new0(struct virgl_gpu_resource, 1);
> +    vres->res.width =3D c3d.width;
> +    vres->res.height =3D c3d.height;
> +    vres->res.format =3D c3d.format;
> +    vres->res.resource_id =3D c3d.resource_id;
> +    QTAILQ_INSERT_HEAD(&g->reslist, &vres->res, next);
> +
>      args.handle =3D c3d.resource_id;
>      args.target =3D c3d.target;
>      args.format =3D c3d.format;
> @@ -82,19 +115,23 @@ static void virgl_cmd_resource_unref(VirtIOGPU *g,
>                                       struct virtio_gpu_ctrl_command *cmd=
)
>  {
>      struct virtio_gpu_resource_unref unref;
> -    struct iovec *res_iovs =3D NULL;
> -    int num_iovs =3D 0;
> +    struct virgl_gpu_resource *vres;
>
>      VIRTIO_GPU_FILL_CMD(unref);
>      trace_virtio_gpu_cmd_res_unref(unref.resource_id);
>
> -    virgl_renderer_resource_detach_iov(unref.resource_id,
> -                                       &res_iovs,
> -                                       &num_iovs);
> -    if (res_iovs !=3D NULL && num_iovs !=3D 0) {
> -        virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
> +    vres =3D virgl_gpu_find_resource(g, unref.resource_id);
> +    if (!vres) {
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
>      }
> +
> +    virgl_renderer_resource_detach_iov(unref.resource_id, NULL, NULL);
>      virgl_renderer_resource_unref(unref.resource_id);
> +
> +    QTAILQ_REMOVE(&g->reslist, &vres->res, next);
> +    virtio_gpu_cleanup_mapping(g, &vres->res);
> +    g_free(vres);
>  }
>
>  static void virgl_cmd_context_create(VirtIOGPU *g,
> @@ -310,44 +347,51 @@ static void virgl_resource_attach_backing(VirtIOGPU=
 *g,
>                                            struct virtio_gpu_ctrl_command=
 *cmd)
>  {
>      struct virtio_gpu_resource_attach_backing att_rb;
> -    struct iovec *res_iovs;
> -    uint32_t res_niov;
> +    struct virgl_gpu_resource *vres;
>      int ret;
>
>      VIRTIO_GPU_FILL_CMD(att_rb);
>      trace_virtio_gpu_cmd_res_back_attach(att_rb.resource_id);
>
> +    vres =3D virgl_gpu_find_resource(g, att_rb.resource_id);
> +    if (!vres) {
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +
>      ret =3D virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(a=
tt_rb),
> -                                        cmd, NULL, &res_iovs, &res_niov)=
;
> +                                        cmd, NULL, &vres->res.iov,
> +                                        &vres->res.iov_cnt);
>      if (ret !=3D 0) {
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          return;
>      }
>
>      ret =3D virgl_renderer_resource_attach_iov(att_rb.resource_id,
> -                                             res_iovs, res_niov);
> +                                             vres->res.iov, vres->res.io=
v_cnt);
>
> -    if (ret !=3D 0)
> -        virtio_gpu_cleanup_mapping_iov(g, res_iovs, res_niov);
> +    if (ret !=3D 0) {
> +        virtio_gpu_cleanup_mapping(g, &vres->res);
> +    }
>  }
>
>  static void virgl_resource_detach_backing(VirtIOGPU *g,
>                                            struct virtio_gpu_ctrl_command=
 *cmd)
>  {
>      struct virtio_gpu_resource_detach_backing detach_rb;
> -    struct iovec *res_iovs =3D NULL;
> -    int num_iovs =3D 0;
> +    struct virgl_gpu_resource *vres;
>
>      VIRTIO_GPU_FILL_CMD(detach_rb);
>      trace_virtio_gpu_cmd_res_back_detach(detach_rb.resource_id);
>
> -    virgl_renderer_resource_detach_iov(detach_rb.resource_id,
> -                                       &res_iovs,
> -                                       &num_iovs);
> -    if (res_iovs =3D=3D NULL || num_iovs =3D=3D 0) {
> +    vres =3D virgl_gpu_find_resource(g, detach_rb.resource_id);
> +    if (!vres) {
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>          return;
>      }
> -    virtio_gpu_cleanup_mapping_iov(g, res_iovs, num_iovs);
> +
> +    virgl_renderer_resource_detach_iov(detach_rb.resource_id, NULL, NULL=
);
> +    virtio_gpu_cleanup_mapping(g, &vres->res);
>  }
>
>
> --
> 2.25.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

