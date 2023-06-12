Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C8D72C4B5
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 14:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8gtC-0005BI-8C; Mon, 12 Jun 2023 08:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8gtA-0005B9-7Y
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:43:16 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8gt7-0003eY-Aw
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 08:43:15 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b1adf27823so50469741fa.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 05:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686573791; x=1689165791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N58B17C5fURhBB5nIx9iUkcEv0MPfPVKFfxs1GVB5Pc=;
 b=gi/gK9K84sIQD5ZZEWlSnHkF5V2H+6IUb6nNFvN4QS+9oB852fmKpBLH0OhYecQNnq
 jJF6VVt/dC1u407uMDyZiz5BfJBpf62ifXHfDGWY8ffXneKYn6j7DghCN7mT2ubxFNYs
 7TmtzVhRhxKfYuMQEixF9mHroawExIcphRBubRQS0UlwU/uKDiHd3Omb8J1zJ0aPISd9
 R3GKn1guN8BhPdlNa045rkQxdQUo83HH2xYmciowzsjexS3qut/pRKqLyqQ4fZ4kCRch
 xKUNSj2vwyg7uoDaS/ldQIue24a7KdeXRPJz6JouPK3DV8mkIQvMD8Al3Qiht1o0zkvC
 c3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686573791; x=1689165791;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N58B17C5fURhBB5nIx9iUkcEv0MPfPVKFfxs1GVB5Pc=;
 b=JtLc7LBf7REUVsOa3c3xPrnDMKbbOZ7uiAq6JPYOcGjmgaxHQP1GDdgZ1UnRMuKxZB
 dE3rRnYMJT/CLt9PwyvlNAIaCqpj9oL9rlm/dn90DCt4nZF1rfCpEONnzy/h/VImjmRL
 tx4kHnXO50S9n/LvJbDijrYBXdB/tgo0GDBjRLieckMg3xz92fGD5uH3StirRZaOKj8P
 wgoUjQkg6Z7/aPmCUYiTREKXyKErNC8JuDVVMExWYRHqpkca0p4kB2OmBYwIvhR5Bmf5
 wgmT+QXVYojRtyTT8nTVnEg2jWD7qW3A8tELFLvQy4+3+rF8l9AdIqLogfhATQJyVS1C
 lK+w==
X-Gm-Message-State: AC+VfDzw0/8/B8O2eocePsi384PSjE4K4NUONtXFxKTaymUYMgkdIghZ
 VFf7YlcmmVYdwrCKKuUHzQ+W1o6rkFKo4JAl/jg=
X-Google-Smtp-Source: ACHHUZ4lFekx0o8+JnU/Vu/KsFWf/lorng1VqvXq6OPSHmxg5Bz4uHFKMgAy71vh88lU55xyyms8qE0RrIl235Tfim8=
X-Received: by 2002:a2e:8e82:0:b0:2b1:b6e8:60b6 with SMTP id
 z2-20020a2e8e82000000b002b1b6e860b6mr2535623ljk.4.1686573790855; Mon, 12 Jun
 2023 05:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
 <20230608025655.1674357-2-Jiqian.Chen@amd.com>
In-Reply-To: <20230608025655.1674357-2-Jiqian.Chen@amd.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2023 14:42:55 +0200
Message-ID: <CAJ+F1CKjTW7zycr2xAW0x+d_7CEy+LxWur2Tqp2dvsb=PoJ5Dw@mail.gmail.com>
Subject: Re: [QEMU PATCH 1/1] virtgpu: do not destroy resources when guest
 suspend
To: Jiqian Chen <Jiqian.Chen@amd.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Damien Hedde <damien.hedde@greensocs.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Jan Beulich <jbeulich@suse.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>, 
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>, qemu-devel@nongnu.org, 
 xen-devel@lists.xenproject.org, Alex Deucher <Alexander.Deucher@amd.com>, 
 Christian Koenig <Christian.Koenig@amd.com>,
 Stewart Hildebrand <Stewart.Hildebrand@amd.com>, 
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 Honglei Huang <Honglei1.Huang@amd.com>, 
 Julia Zhang <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>
Content-Type: multipart/alternative; boundary="000000000000b105e705fdee0f2d"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000b105e705fdee0f2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 8, 2023 at 6:26=E2=80=AFAM Jiqian Chen <Jiqian.Chen@amd.com> wr=
ote:

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
>  hw/display/virtio-gpu-gl.c                  |  9 ++++++-
>  hw/display/virtio-gpu-virgl.c               |  3 +++
>  hw/display/virtio-gpu.c                     | 26 +++++++++++++++++++--
>  include/hw/virtio/virtio-gpu.h              |  3 +++
>  include/standard-headers/linux/virtio_gpu.h |  9 +++++++
>  5 files changed, 47 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index e06be60dfb..e11ad233eb 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -100,7 +100,14 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>       */
>      if (gl->renderer_inited && !gl->renderer_reset) {
>          virtio_gpu_virgl_reset_scanout(g);
> -        gl->renderer_reset =3D true;
> +        /*
> +         * If guest is suspending, we shouldn't reset renderer,
> +         * otherwise, the display can't come back to the time when
> +         * it was suspended after guest resumed.
> +         */
> +        if (!g->freezing) {
> +            gl->renderer_reset =3D true;
> +        }
>      }
>  }
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 73cb92c8d5..183ec92d53 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -464,6 +464,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>      case VIRTIO_GPU_CMD_GET_EDID:
>          virtio_gpu_get_edid(g, cmd);
>          break;
> +    case VIRTIO_GPU_CMD_STATUS_FREEZING:
> +        virtio_gpu_cmd_status_freezing(g, cmd);
> +        break;
>      default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          break;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5e15c79b94..8f235d7848 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -373,6 +373,16 @@ static void virtio_gpu_resource_create_blob(VirtIOGP=
U
> *g,
>      QTAILQ_INSERT_HEAD(&g->reslist, res, next);
>  }
>
> +void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,
> +                         struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_status_freezing sf;
> +
> +    VIRTIO_GPU_FILL_CMD(sf);
> +    virtio_gpu_bswap_32(&sf, sizeof(sf));
> +    g->freezing =3D sf.freezing;
> +}
> +
>  static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)
>  {
>      struct virtio_gpu_scanout *scanout =3D
> &g->parent_obj.scanout[scanout_id];
> @@ -986,6 +996,9 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,
>      case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>          virtio_gpu_resource_detach_backing(g, cmd);
>          break;
> +    case VIRTIO_GPU_CMD_STATUS_FREEZING:
> +        virtio_gpu_cmd_status_freezing(g, cmd);
> +        break;
>      default:
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
>          break;
> @@ -1344,6 +1357,8 @@ void virtio_gpu_device_realize(DeviceState *qdev,
> Error **errp)
>      QTAILQ_INIT(&g->reslist);
>      QTAILQ_INIT(&g->cmdq);
>      QTAILQ_INIT(&g->fenceq);
> +
> +    g->freezing =3D false;
>  }
>
>  void virtio_gpu_reset(VirtIODevice *vdev)
> @@ -1352,8 +1367,15 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>      struct virtio_gpu_simple_resource *res, *tmp;
>      struct virtio_gpu_ctrl_command *cmd;
>
> -    QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> -        virtio_gpu_resource_destroy(g, res);
> +    /*
> +     * If guest is suspending, we shouldn't destroy resources,
> +     * otherwise, the display can't come back to the time when
> +     * it was suspended after guest resumed.
> +     */
> +    if (!g->freezing) {
> +        QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> +            virtio_gpu_resource_destroy(g, res);
> +        }
>      }
>
>      while (!QTAILQ_EMPTY(&g->cmdq)) {
> diff --git a/include/hw/virtio/virtio-gpu.h
> b/include/hw/virtio/virtio-gpu.h
> index 2e28507efe..c21c2990fb 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -173,6 +173,7 @@ struct VirtIOGPU {
>
>      uint64_t hostmem;
>
> +    bool freezing;
>      bool processing_cmdq;
>      QEMUTimer *fence_poll;
>      QEMUTimer *print_stats;
> @@ -284,5 +285,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);
>  void virtio_gpu_virgl_reset(VirtIOGPU *g);
>  int virtio_gpu_virgl_init(VirtIOGPU *g);
>  int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);
> +void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,
> +                         struct virtio_gpu_ctrl_command *cmd);
>
>  #endif
> diff --git a/include/standard-headers/linux/virtio_gpu.h
> b/include/standard-headers/linux/virtio_gpu.h
> index 2da48d3d4c..aefffbd751 100644
> --- a/include/standard-headers/linux/virtio_gpu.h
> +++ b/include/standard-headers/linux/virtio_gpu.h
> @@ -116,6 +116,9 @@ enum virtio_gpu_ctrl_type {
>         VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
>         VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
>         VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
> +
> +       /* status */
> +       VIRTIO_GPU_CMD_STATUS_FREEZING =3D 0x1300,
>  };
>

Adding a new command requires new feature flag (and maybe it should be in
the <0x1000 range instead)

But I am not sure we need a new message at the virtio-gpu level. Gerd, wdyt=
?

Maybe it's not a good place to reset all GPU resources during QEMU reset()
after all, if it's called during s3 and there is no mechanism to restore
it. Damien?

thanks


...

>  enum virtio_gpu_shm_id {
> @@ -453,4 +456,10 @@ struct virtio_gpu_resource_unmap_blob {
>         uint32_t padding;
>  };
>
> +/* VIRTIO_GPU_CMD_STATUS_FREEZING */
> +struct virtio_gpu_status_freezing {
> +       struct virtio_gpu_ctrl_hdr hdr;
> +       __u32 freezing;
> +};
> +
>  #endif
> --
> 2.34.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000b105e705fdee0f2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 8, 2023 at 6:26=E2=80=
=AFAM Jiqian Chen &lt;<a href=3D"mailto:Jiqian.Chen@amd.com">Jiqian.Chen@am=
d.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">After suspending and resuming guest VM, you will get<br>
a black screen, and the display can&#39;t come back.<br>
<br>
This is because when guest did suspending, it called<br>
into qemu to call virtio_gpu_gl_reset. In function<br>
virtio_gpu_gl_reset, it destroyed resources and reset<br>
renderer, which were used for display. As a result,<br>
guest&#39;s screen can&#39;t come back to the time when it was<br>
suspended and only showed black.<br>
<br>
So, this patch adds a new ctrl message<br>
VIRTIO_GPU_CMD_STATUS_FREEZING to get notification from<br>
guest. If guest is during suspending, it sets freezing<br>
status of virtgpu to true, this will prevent destroying<br>
resources and resetting renderer when guest calls into<br>
virtio_gpu_gl_reset. If guest is during resuming, it sets<br>
freezing to false, and then virtio_gpu_gl_reset will keep<br>
its origin actions and has no other impaction.<br>
<br>
Signed-off-by: Jiqian Chen &lt;<a href=3D"mailto:Jiqian.Chen@amd.com" targe=
t=3D"_blank">Jiqian.Chen@amd.com</a>&gt;<br>
---<br>
=C2=A0hw/display/virtio-gpu-gl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++++-<br>
=C2=A0hw/display/virtio-gpu-virgl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 3 +++<br>
=C2=A0hw/display/virtio-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 26 +++++++++++++++++++--<br>
=C2=A0include/hw/virtio/virtio-gpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 3 +++<br>
=C2=A0include/standard-headers/linux/virtio_gpu.h |=C2=A0 9 +++++++<br>
=C2=A05 files changed, 47 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c<br>
index e06be60dfb..e11ad233eb 100644<br>
--- a/hw/display/virtio-gpu-gl.c<br>
+++ b/hw/display/virtio-gpu-gl.c<br>
@@ -100,7 +100,14 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)<br=
>
=C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (gl-&gt;renderer_inited &amp;&amp; !gl-&gt;renderer_=
reset) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_virgl_reset_scanout(g);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_reset =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If guest is suspending, we shouldn&#39=
;t reset renderer,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* otherwise, the display can&#39;t come =
back to the time when<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* it was suspended after guest resumed.<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g-&gt;freezing) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gl-&gt;renderer_reset =3D true;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c<=
br>
index 73cb92c8d5..183ec92d53 100644<br>
--- a/hw/display/virtio-gpu-virgl.c<br>
+++ b/hw/display/virtio-gpu-virgl.c<br>
@@ -464,6 +464,9 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_GPU_CMD_GET_EDID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_get_edid(g, cmd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_STATUS_FREEZING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cmd_status_freezing(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_UNS=
PEC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 5e15c79b94..8f235d7848 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -373,6 +373,16 @@ static void virtio_gpu_resource_create_blob(VirtIOGPU =
*g,<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INSERT_HEAD(&amp;g-&gt;reslist, res, next);<br>
=C2=A0}<br>
<br>
+void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_gpu_status_freezing sf;<br>
+<br>
+=C2=A0 =C2=A0 VIRTIO_GPU_FILL_CMD(sf);<br>
+=C2=A0 =C2=A0 virtio_gpu_bswap_32(&amp;sf, sizeof(sf));<br>
+=C2=A0 =C2=A0 g-&gt;freezing =3D sf.freezing;<br>
+}<br>
+<br>
=C2=A0static void virtio_gpu_disable_scanout(VirtIOGPU *g, int scanout_id)<=
br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_scanout *scanout =3D &amp;g-&gt;paren=
t_obj.scanout[scanout_id];<br>
@@ -986,6 +996,9 @@ void virtio_gpu_simple_process_cmd(VirtIOGPU *g,<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_gpu_resource_detach_backing(g, cmd=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_STATUS_FREEZING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_cmd_status_freezing(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_UNS=
PEC;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -1344,6 +1357,8 @@ void virtio_gpu_device_realize(DeviceState *qdev, Err=
or **errp)<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;g-&gt;reslist);<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;g-&gt;cmdq);<br>
=C2=A0 =C2=A0 =C2=A0QTAILQ_INIT(&amp;g-&gt;fenceq);<br>
+<br>
+=C2=A0 =C2=A0 g-&gt;freezing =3D false;<br>
=C2=A0}<br>
<br>
=C2=A0void virtio_gpu_reset(VirtIODevice *vdev)<br>
@@ -1352,8 +1367,15 @@ void virtio_gpu_reset(VirtIODevice *vdev)<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *res, *tmp;<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd;<br>
<br>
-=C2=A0 =C2=A0 QTAILQ_FOREACH_SAFE(res, &amp;g-&gt;reslist, next, tmp) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_resource_destroy(g, res);<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If guest is suspending, we shouldn&#39;t destroy res=
ources,<br>
+=C2=A0 =C2=A0 =C2=A0* otherwise, the display can&#39;t come back to the ti=
me when<br>
+=C2=A0 =C2=A0 =C2=A0* it was suspended after guest resumed.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!g-&gt;freezing) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QTAILQ_FOREACH_SAFE(res, &amp;g-&gt;reslist, n=
ext, tmp) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_resource_destroy(g, r=
es);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0while (!QTAILQ_EMPTY(&amp;g-&gt;cmdq)) {<br>
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.=
h<br>
index 2e28507efe..c21c2990fb 100644<br>
--- a/include/hw/virtio/virtio-gpu.h<br>
+++ b/include/hw/virtio/virtio-gpu.h<br>
@@ -173,6 +173,7 @@ struct VirtIOGPU {<br>
<br>
=C2=A0 =C2=A0 =C2=A0uint64_t hostmem;<br>
<br>
+=C2=A0 =C2=A0 bool freezing;<br>
=C2=A0 =C2=A0 =C2=A0bool processing_cmdq;<br>
=C2=A0 =C2=A0 =C2=A0QEMUTimer *fence_poll;<br>
=C2=A0 =C2=A0 =C2=A0QEMUTimer *print_stats;<br>
@@ -284,5 +285,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g);<br>
=C2=A0void virtio_gpu_virgl_reset(VirtIOGPU *g);<br>
=C2=A0int virtio_gpu_virgl_init(VirtIOGPU *g);<br>
=C2=A0int virtio_gpu_virgl_get_num_capsets(VirtIOGPU *g);<br>
+void virtio_gpu_cmd_status_freezing(VirtIOGPU *g,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd);<br>
<br>
=C2=A0#endif<br>
diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/standard=
-headers/linux/virtio_gpu.h<br>
index 2da48d3d4c..aefffbd751 100644<br>
--- a/include/standard-headers/linux/virtio_gpu.h<br>
+++ b/include/standard-headers/linux/virtio_gpu.h<br>
@@ -116,6 +116,9 @@ enum virtio_gpu_ctrl_type {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* status */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_CMD_STATUS_FREEZING =3D 0x1300,<br>
=C2=A0};<br></blockquote><div><br></div><div>Adding a new command requires =
new feature flag (and maybe it should be in the &lt;0x1000 range instead) <=
br></div><div><br></div><div>But I am not sure we need a new message at the=
 virtio-gpu level. Gerd, wdyt?<br></div><div><br></div><div>Maybe it&#39;s =
not a good place to reset all GPU resources during QEMU reset() after all, =
if it&#39;s called during s3 and there is no mechanism to restore it. Damie=
n?</div><div><br></div><div>thanks<br></div><div><br></div><div><br></div><=
div>...<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0enum virtio_gpu_shm_id {<br>
@@ -453,4 +456,10 @@ struct virtio_gpu_resource_unmap_blob {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t padding;<br>
=C2=A0};<br>
<br>
+/* VIRTIO_GPU_CMD_STATUS_FREEZING */<br>
+struct virtio_gpu_status_freezing {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_ctrl_hdr hdr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 freezing;<br>
+};<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.34.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000b105e705fdee0f2d--

