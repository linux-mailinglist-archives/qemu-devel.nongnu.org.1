Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4DF71FA23
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4yJf-000154-5X; Fri, 02 Jun 2023 02:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q4yJ0-00013p-3M
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:30:34 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q4yIx-0001gl-4D
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:30:33 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f6067a9029so2067639e87.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685687429; x=1688279429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qpeyt8a+NwTQn6KhZSW6wbiv/ThVpI+BoLOg/UF73mE=;
 b=bmF9qVQnPouJMjnTlCA/VtY7HwNTkrABjEjZgcWbaNa3b7dSFqDZ9lSOBHxpX94Mbj
 3JzE1oxULaAtgMmoPihU+Gbc3F4P1Mz24XJfKLP9n6Pi29Z0fumzcqhO14WAKdCiPdxX
 VeaN2NHeYT+feB0DQ4mFPnblZwQ4hRnRznvRpPtYKBNb/N2nxdqDq+28oz9hURUxfRc4
 s2g7u/C569qHPC8D3b6nXMrW1fEXDmaF0r/JDd2fUKAmwhRaZBN/xM0V6OsK7a9mFwaA
 6NZowxnfZDJGV5qFhKf4AYGee9F9NQR2WvVLEnIoQrP+B1rWWu2+GHOCz2PTB6TnuitX
 BGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685687429; x=1688279429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qpeyt8a+NwTQn6KhZSW6wbiv/ThVpI+BoLOg/UF73mE=;
 b=O45EVrlWyKWekKY2kPR6gKPdI/VtOTT5mHKjnHhepSAn+s17RdEpHSya6nsO2f2JIz
 VcbFmu08Aej6VGVehMjf3cPysUCMqJ5aDWerjSnYF1zbNK1zHYyAd2+ybpAASNT+NLrV
 L0bKNMBd6DE6tw+hzoNpTvtt1pluFANBhuMi8A8qtWEeZvA18gPlhscXmlVSg043Q4uh
 /QWvtycduHhqZqnnLCHxh1SEnbKn/e4csKPur8zK0DU5q8MYNVGzRn1PjrXulBw2FBQm
 iYdkag7ymHHDubsjmu0uCumAMW3BYfCjoZg6SmeIE4ahLh6oVYf2JIhSseDFAEhcKTep
 +8Qw==
X-Gm-Message-State: AC+VfDwglRZaP8Nk9zMWriCv04RVUf9MOYkH/eb1Fs5KU+ibDoEL013T
 0VheDOmA/eG6H12DdT2IzrztkVbTFH3OCMTUdSMLPdw9/02gOg==
X-Google-Smtp-Source: ACHHUZ4PKozLmturZ1eMVkkDj3mskUHt1LufnihoKZ9LNp8//pg9YWu2LaiFSaGhFGj3eGCw3H9zYiCSeziagqQXbhM=
X-Received: by 2002:ac2:4824:0:b0:4f4:d584:b426 with SMTP id
 4-20020ac24824000000b004f4d584b426mr1184307lft.3.1685687429053; Thu, 01 Jun
 2023 23:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230531160631.612893-1-ernunes@redhat.com>
 <20230531160631.612893-4-ernunes@redhat.com>
In-Reply-To: <20230531160631.612893-4-ernunes@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 2 Jun 2023 10:30:17 +0400
Message-ID: <CAJ+F1CL-+5GeycxgWHvGhp+1HpTX4Jgw03qK_duZG7h7OEoexw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] contrib/vhost-user-gpu: implement get_edid feature
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="0000000000006940ca05fd1fb031"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x131.google.com
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

--0000000000006940ca05fd1fb031
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, May 31, 2023 at 8:07=E2=80=AFPM Erico Nunes <ernunes@redhat.com> wr=
ote:

> Implement the virtio-gpu feature in contrib/vhost-user-gpu, which was
> unsupported until now.
> In this implementation, the feature is enabled inconditionally to avoid
> creating another optional config argument.
> Similarly to get_display_info, vhost-user-gpu sends a message back to
> the frontend to have access to all the display information. In the
> case of get_edid, it also needs to pass which scanout we should
> retrieve the edid for.
>
> The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is required if the
> frontend sets the VIRTIO_GPU_F_EDID virtio-gpu feature. If the frontend
> sets the virtio-gpu feature but does not support the protocol feature,
> the backend will abort with an error.
>
> Signed-off-by: Erico Nunes <ernunes@redhat.com>
> ---
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 67 +++++++++++++++++++++++--
>  contrib/vhost-user-gpu/virgl.c          |  3 ++
>  contrib/vhost-user-gpu/vugpu.h          | 11 ++++
>  3 files changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c
> b/contrib/vhost-user-gpu/vhost-user-gpu.c
> index bfb8d93cf8..8035dc71d7 100644
> --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> @@ -303,6 +303,53 @@ vg_get_display_info(VuGpu *vg, struct
> virtio_gpu_ctrl_command *cmd)
>      cmd->state =3D VG_CMD_STATE_PENDING;
>  }
>
> +static gboolean
> +get_edid_cb(gint fd, GIOCondition condition, gpointer user_data)
> +{
> +    struct virtio_gpu_resp_edid resp_edid;
> +    VuGpu *vg =3D user_data;
> +    struct virtio_gpu_ctrl_command *cmd =3D QTAILQ_LAST(&vg->fenceq);
> +
> +    g_debug("get edid cb");
> +    assert(cmd->cmd_hdr.type =3D=3D VIRTIO_GPU_CMD_GET_EDID);
> +    if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_EDID,
> +                     sizeof(resp_edid), &resp_edid)) {
> +        return G_SOURCE_CONTINUE;
> +    }
> +
> +    QTAILQ_REMOVE(&vg->fenceq, cmd, next);
> +    vg_ctrl_response(vg, cmd, &resp_edid.hdr, sizeof(resp_edid));
> +
> +    vg->wait_in =3D 0;
> +    vg_handle_ctrl(&vg->dev.parent, 0);
> +
> +    return G_SOURCE_REMOVE;
> +}
> +
> +void
> +vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)
> +{
> +    struct virtio_gpu_cmd_get_edid get_edid;
> +
> +    VUGPU_FILL_CMD(get_edid);
> +    virtio_gpu_bswap_32(&get_edid, sizeof(get_edid));
> +
> +    VhostUserGpuMsg msg =3D {
> +        .request =3D VHOST_USER_GPU_GET_EDID,
> +        .size =3D sizeof(VhostUserGpuEdidRequest),
> +        .payload.edid_req =3D {
> +                .scanout_id =3D get_edid.scanout,
> +        },
> +    };
> +
> +    assert(vg->wait_in =3D=3D 0);
> +
> +    vg_send_msg(vg, &msg, -1);
> +    vg->wait_in =3D g_unix_fd_add(vg->sock_fd, G_IO_IN | G_IO_HUP,
> +                               get_edid_cb, vg);
> +    cmd->state =3D VG_CMD_STATE_PENDING;
> +}
> +
>  static void
>  vg_resource_create_2d(VuGpu *g,
>                        struct virtio_gpu_ctrl_command *cmd)
> @@ -837,8 +884,9 @@ vg_process_cmd(VuGpu *vg, struct
> virtio_gpu_ctrl_command *cmd)
>      case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:
>          vg_resource_detach_backing(vg, cmd);
>          break;
> -    /* case VIRTIO_GPU_CMD_GET_EDID: */
> -    /*     break */
> +    case VIRTIO_GPU_CMD_GET_EDID:
> +        vg_get_edid(vg, cmd);
> +        break;
>      default:
>          g_warning("TODO handle ctrl %x\n", cmd->cmd_hdr.type);
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> @@ -1022,6 +1070,7 @@ vg_queue_set_started(VuDev *dev, int qidx, bool
> started)
>  static gboolean
>  protocol_features_cb(gint fd, GIOCondition condition, gpointer user_data=
)
>  {
> +    const uint64_t protocol_edid =3D (1 << VHOST_USER_GPU_PROTOCOL_F_EDI=
D);
>      VuGpu *g =3D user_data;
>      uint64_t u64;
>      VhostUserGpuMsg msg =3D {
> @@ -1035,13 +1084,19 @@ protocol_features_cb(gint fd, GIOCondition
> condition, gpointer user_data)
>      msg =3D (VhostUserGpuMsg) {
>          .request =3D VHOST_USER_GPU_SET_PROTOCOL_FEATURES,
>          .size =3D sizeof(uint64_t),
> -        .payload.u64 =3D 0
> +        .payload.u64 =3D protocol_edid,
>


You should not set flags unsupported by the frontend (qemu). Use
"protocol_edid & u64". It might be worth renaming the "u64" variable too,
to "protocol_features" for ex. You could reuse that variable and udate with
"protocol_features &=3D (1 << VHOST_USER_GPU_PROTOCOL_F_EDID);"


>      };
>      vg_send_msg(g, &msg, -1);
>
>      g->wait_in =3D 0;
>      vg_handle_ctrl(&g->dev.parent, 0);
>
> +    if (g->edid_inited && !(u64 & protocol_edid)) {
> +        g_printerr("EDID feature set by the frontend but it does not
> support "
> +                   "the EDID vhost-user-gpu protocol.\n");
> +        exit(EXIT_FAILURE);
> +    }
> +
>      return G_SOURCE_REMOVE;
>  }
>
> @@ -1049,7 +1104,8 @@ static void
>  set_gpu_protocol_features(VuGpu *g)
>  {
>      VhostUserGpuMsg msg =3D {
> -        .request =3D VHOST_USER_GPU_GET_PROTOCOL_FEATURES
> +        .request =3D VHOST_USER_GPU_GET_PROTOCOL_FEATURES,
> +        .size =3D sizeof(uint64_t),
>

Why? there is no payload


>      };
>
>      vg_send_msg(g, &msg, -1);
> @@ -1086,6 +1142,7 @@ vg_get_features(VuDev *dev)
>      if (opt_virgl) {
>          features |=3D 1 << VIRTIO_GPU_F_VIRGL;
>      }
> +    features |=3D 1 << VIRTIO_GPU_F_EDID;
>

>      return features;
>  }
> @@ -1103,6 +1160,8 @@ vg_set_features(VuDev *dev, uint64_t features)
>          g->virgl_inited =3D true;
>      }
>
> +    g->edid_inited =3D !!(features & (1 << VIRTIO_GPU_F_EDID));
> +
>      g->virgl =3D virgl;
>  }
>
> diff --git a/contrib/vhost-user-gpu/virgl.c
> b/contrib/vhost-user-gpu/virgl.c
> index 3e45e1bd33..211aa110a9 100644
> --- a/contrib/vhost-user-gpu/virgl.c
> +++ b/contrib/vhost-user-gpu/virgl.c
> @@ -495,6 +495,9 @@ void vg_virgl_process_cmd(VuGpu *g, struct
> virtio_gpu_ctrl_command *cmd)
>      case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:
>          vg_get_display_info(g, cmd);
>          break;
> +    case VIRTIO_GPU_CMD_GET_EDID:
> +        vg_get_edid(g, cmd);
> +        break;
>      default:
>          g_debug("TODO handle ctrl %x\n", cmd->cmd_hdr.type);
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_UNSPEC;
> diff --git a/contrib/vhost-user-gpu/vugpu.h
> b/contrib/vhost-user-gpu/vugpu.h
> index e2864bba68..f0f2069c47 100644
> --- a/contrib/vhost-user-gpu/vugpu.h
> +++ b/contrib/vhost-user-gpu/vugpu.h
> @@ -36,6 +36,7 @@ typedef enum VhostUserGpuRequest {
>      VHOST_USER_GPU_UPDATE,
>      VHOST_USER_GPU_DMABUF_SCANOUT,
>      VHOST_USER_GPU_DMABUF_UPDATE,
> +    VHOST_USER_GPU_GET_EDID,
>  } VhostUserGpuRequest;
>
>  typedef struct VhostUserGpuDisplayInfoReply {
> @@ -83,6 +84,10 @@ typedef struct VhostUserGpuDMABUFScanout {
>      int fd_drm_fourcc;
>  } QEMU_PACKED VhostUserGpuDMABUFScanout;
>
> +typedef struct VhostUserGpuEdidRequest {
> +    uint32_t scanout_id;
> +} QEMU_PACKED VhostUserGpuEdidRequest;
> +
>  typedef struct VhostUserGpuMsg {
>      uint32_t request; /* VhostUserGpuRequest */
>      uint32_t flags;
> @@ -93,6 +98,8 @@ typedef struct VhostUserGpuMsg {
>          VhostUserGpuScanout scanout;
>          VhostUserGpuUpdate update;
>          VhostUserGpuDMABUFScanout dmabuf_scanout;
> +        VhostUserGpuEdidRequest edid_req;
> +        struct virtio_gpu_resp_edid resp_edid;
>          struct virtio_gpu_resp_display_info display_info;
>          uint64_t u64;
>      } payload;
> @@ -104,6 +111,8 @@ static VhostUserGpuMsg m __attribute__ ((unused));
>
>  #define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4
>
> +#define VHOST_USER_GPU_PROTOCOL_F_EDID 0
> +
>  struct virtio_gpu_scanout {
>      uint32_t width, height;
>      int x, y;
> @@ -122,6 +131,7 @@ typedef struct VuGpu {
>
>      bool virgl;
>      bool virgl_inited;
> +    bool edid_inited;
>      uint32_t inflight;
>
>      struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOUTS];
> @@ -171,6 +181,7 @@ int     vg_create_mapping_iov(VuGpu *g,
>                                struct iovec **iov);
>  void    vg_cleanup_mapping_iov(VuGpu *g, struct iovec *iov, uint32_t
> count);
>  void    vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_command
> *cmd);
> +void    vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd);
>
>  void    vg_wait_ok(VuGpu *g);
>
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000006940ca05fd1fb031
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 31, 2023 at 8:07=E2=80=
=AFPM Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com">ernunes@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Implement the virtio-gpu feature in contrib/vhost-user-gpu, which was<br=
>
unsupported until now.<br>
In this implementation, the feature is enabled inconditionally to avoid<br>
creating another optional config argument.<br>
Similarly to get_display_info, vhost-user-gpu sends a message back to<br>
the frontend to have access to all the display information. In the<br>
case of get_edid, it also needs to pass which scanout we should<br>
retrieve the edid for.<br>
<br>
The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is required if the<br>
frontend sets the VIRTIO_GPU_F_EDID virtio-gpu feature. If the frontend<br>
sets the virtio-gpu feature but does not support the protocol feature,<br>
the backend will abort with an error.<br>
<br>
Signed-off-by: Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com" target=
=3D"_blank">ernunes@redhat.com</a>&gt;<br>
---<br>
=C2=A0contrib/vhost-user-gpu/vhost-user-gpu.c | 67 +++++++++++++++++++++++-=
-<br>
=C2=A0contrib/vhost-user-gpu/virgl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 3 ++<br>
=C2=A0contrib/vhost-user-gpu/vugpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 11=
 ++++<br>
=C2=A03 files changed, 77 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-user-g=
pu/vhost-user-gpu.c<br>
index bfb8d93cf8..8035dc71d7 100644<br>
--- a/contrib/vhost-user-gpu/vhost-user-gpu.c<br>
+++ b/contrib/vhost-user-gpu/vhost-user-gpu.c<br>
@@ -303,6 +303,53 @@ vg_get_display_info(VuGpu *vg, struct virtio_gpu_ctrl_=
command *cmd)<br>
=C2=A0 =C2=A0 =C2=A0cmd-&gt;state =3D VG_CMD_STATE_PENDING;<br>
=C2=A0}<br>
<br>
+static gboolean<br>
+get_edid_cb(gint fd, GIOCondition condition, gpointer user_data)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_gpu_resp_edid resp_edid;<br>
+=C2=A0 =C2=A0 VuGpu *vg =3D user_data;<br>
+=C2=A0 =C2=A0 struct virtio_gpu_ctrl_command *cmd =3D QTAILQ_LAST(&amp;vg-=
&gt;fenceq);<br>
+<br>
+=C2=A0 =C2=A0 g_debug(&quot;get edid cb&quot;);<br>
+=C2=A0 =C2=A0 assert(cmd-&gt;cmd_hdr.type =3D=3D VIRTIO_GPU_CMD_GET_EDID);=
<br>
+=C2=A0 =C2=A0 if (!vg_recv_msg(vg, VHOST_USER_GPU_GET_EDID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0sizeof(resp_edid), &amp;resp_edid)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return G_SOURCE_CONTINUE;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 QTAILQ_REMOVE(&amp;vg-&gt;fenceq, cmd, next);<br>
+=C2=A0 =C2=A0 vg_ctrl_response(vg, cmd, &amp;resp_edid.hdr, sizeof(resp_ed=
id));<br>
+<br>
+=C2=A0 =C2=A0 vg-&gt;wait_in =3D 0;<br>
+=C2=A0 =C2=A0 vg_handle_ctrl(&amp;vg-&gt;dev.parent, 0);<br>
+<br>
+=C2=A0 =C2=A0 return G_SOURCE_REMOVE;<br>
+}<br>
+<br>
+void<br>
+vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 struct virtio_gpu_cmd_get_edid get_edid;<br>
+<br>
+=C2=A0 =C2=A0 VUGPU_FILL_CMD(get_edid);<br>
+=C2=A0 =C2=A0 virtio_gpu_bswap_32(&amp;get_edid, sizeof(get_edid));<br>
+<br>
+=C2=A0 =C2=A0 VhostUserGpuMsg msg =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_GPU_GET_EDID,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(VhostUserGpuEdidRequest),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.edid_req =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .scanout_id =3D ge=
t_edid.scanout,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
+=C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 assert(vg-&gt;wait_in =3D=3D 0);<br>
+<br>
+=C2=A0 =C2=A0 vg_send_msg(vg, &amp;msg, -1);<br>
+=C2=A0 =C2=A0 vg-&gt;wait_in =3D g_unix_fd_add(vg-&gt;sock_fd, G_IO_IN | G=
_IO_HUP,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_edid_cb, vg);<br>
+=C2=A0 =C2=A0 cmd-&gt;state =3D VG_CMD_STATE_PENDING;<br>
+}<br>
+<br>
=C2=A0static void<br>
=C2=A0vg_resource_create_2d(VuGpu *g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct virtio_gpu_ctrl_command *cmd)<br>
@@ -837,8 +884,9 @@ vg_process_cmd(VuGpu *vg, struct virtio_gpu_ctrl_comman=
d *cmd)<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vg_resource_detach_backing(vg, cmd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 /* case VIRTIO_GPU_CMD_GET_EDID: */<br>
-=C2=A0 =C2=A0 /*=C2=A0 =C2=A0 =C2=A0break */<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_EDID:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_get_edid(vg, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_warning(&quot;TODO handle ctrl %x\n&quo=
t;, cmd-&gt;cmd_hdr.type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_UNS=
PEC;<br>
@@ -1022,6 +1070,7 @@ vg_queue_set_started(VuDev *dev, int qidx, bool start=
ed)<br>
=C2=A0static gboolean<br>
=C2=A0protocol_features_cb(gint fd, GIOCondition condition, gpointer user_d=
ata)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const uint64_t protocol_edid =3D (1 &lt;&lt; VHOST_USER_GPU_=
PROTOCOL_F_EDID);<br>
=C2=A0 =C2=A0 =C2=A0VuGpu *g =3D user_data;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t u64;<br>
=C2=A0 =C2=A0 =C2=A0VhostUserGpuMsg msg =3D {<br>
@@ -1035,13 +1084,19 @@ protocol_features_cb(gint fd, GIOCondition conditio=
n, gpointer user_data)<br>
=C2=A0 =C2=A0 =C2=A0msg =3D (VhostUserGpuMsg) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.request =3D VHOST_USER_GPU_SET_PROTOCOL_=
FEATURES,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.size =3D sizeof(uint64_t),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.u64 =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload.u64 =3D protocol_edid,<br></blockquot=
e><div><br></div><div><br></div><div>You should not set flags unsupported b=
y the frontend (qemu). Use &quot;protocol_edid &amp; u64&quot;. It might be=
 worth renaming the &quot;u64&quot; variable too, to &quot;protocol_feature=
s&quot; for ex. You could reuse that variable and udate with &quot;protocol=
_features &amp;=3D (1 &lt;&lt; VHOST_USER_GPU_PROTOCOL_F_EDID);&quot;</div>=
<div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0};<br>
=C2=A0 =C2=A0 =C2=A0vg_send_msg(g, &amp;msg, -1);<br>
<br>
=C2=A0 =C2=A0 =C2=A0g-&gt;wait_in =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0vg_handle_ctrl(&amp;g-&gt;dev.parent, 0);<br>
<br>
+=C2=A0 =C2=A0 if (g-&gt;edid_inited &amp;&amp; !(u64 &amp; protocol_edid))=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_printerr(&quot;EDID feature set by the front=
end but it does not support &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;the EDID vhost-user-gpu protocol.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0return G_SOURCE_REMOVE;<br>
=C2=A0}<br>
<br>
@@ -1049,7 +1104,8 @@ static void<br>
=C2=A0set_gpu_protocol_features(VuGpu *g)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0VhostUserGpuMsg msg =3D {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_GPU_GET_PROTOCOL_FEATU=
RES<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D VHOST_USER_GPU_GET_PROTOCOL_FEATU=
RES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(uint64_t),<br></blockquote><d=
iv><br></div><div>Why? there is no payload<br></div><div>=C2=A0<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0vg_send_msg(g, &amp;msg, -1);<br>
@@ -1086,6 +1142,7 @@ vg_get_features(VuDev *dev)<br>
=C2=A0 =C2=A0 =C2=A0if (opt_virgl) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0features |=3D 1 &lt;&lt; VIRTIO_GPU_F_VIR=
GL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 features |=3D 1 &lt;&lt; VIRTIO_GPU_F_EDID; <br></blockquote=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0return features;<br>
=C2=A0}<br>
@@ -1103,6 +1160,8 @@ vg_set_features(VuDev *dev, uint64_t features)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g-&gt;virgl_inited =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 g-&gt;edid_inited =3D !!(features &amp; (1 &lt;&lt; VIRTIO_G=
PU_F_EDID));<br>
+<br>
=C2=A0 =C2=A0 =C2=A0g-&gt;virgl =3D virgl;<br>
=C2=A0}<br>
<br>
diff --git a/contrib/vhost-user-gpu/virgl.c b/contrib/vhost-user-gpu/virgl.=
c<br>
index 3e45e1bd33..211aa110a9 100644<br>
--- a/contrib/vhost-user-gpu/virgl.c<br>
+++ b/contrib/vhost-user-gpu/virgl.c<br>
@@ -495,6 +495,9 @@ void vg_virgl_process_cmd(VuGpu *g, struct virtio_gpu_c=
trl_command *cmd)<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_GPU_CMD_GET_DISPLAY_INFO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vg_get_display_info(g, cmd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case VIRTIO_GPU_CMD_GET_EDID:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vg_get_edid(g, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_debug(&quot;TODO handle ctrl %x\n&quot;=
, cmd-&gt;cmd_hdr.type);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;error =3D VIRTIO_GPU_RESP_ERR_UNS=
PEC;<br>
diff --git a/contrib/vhost-user-gpu/vugpu.h b/contrib/vhost-user-gpu/vugpu.=
h<br>
index e2864bba68..f0f2069c47 100644<br>
--- a/contrib/vhost-user-gpu/vugpu.h<br>
+++ b/contrib/vhost-user-gpu/vugpu.h<br>
@@ -36,6 +36,7 @@ typedef enum VhostUserGpuRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_UPDATE,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_DMABUF_SCANOUT,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_DMABUF_UPDATE,<br>
+=C2=A0 =C2=A0 VHOST_USER_GPU_GET_EDID,<br>
=C2=A0} VhostUserGpuRequest;<br>
<br>
=C2=A0typedef struct VhostUserGpuDisplayInfoReply {<br>
@@ -83,6 +84,10 @@ typedef struct VhostUserGpuDMABUFScanout {<br>
=C2=A0 =C2=A0 =C2=A0int fd_drm_fourcc;<br>
=C2=A0} QEMU_PACKED VhostUserGpuDMABUFScanout;<br>
<br>
+typedef struct VhostUserGpuEdidRequest {<br>
+=C2=A0 =C2=A0 uint32_t scanout_id;<br>
+} QEMU_PACKED VhostUserGpuEdidRequest;<br>
+<br>
=C2=A0typedef struct VhostUserGpuMsg {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t request; /* VhostUserGpuRequest */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t flags;<br>
@@ -93,6 +98,8 @@ typedef struct VhostUserGpuMsg {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserGpuScanout scanout;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserGpuUpdate update;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserGpuDMABUFScanout dmabuf_scanout;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserGpuEdidRequest edid_req;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_resp_edid resp_edid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_resp_display_info displ=
ay_info;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t u64;<br>
=C2=A0 =C2=A0 =C2=A0} payload;<br>
@@ -104,6 +111,8 @@ static VhostUserGpuMsg m __attribute__ ((unused));<br>
<br>
=C2=A0#define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4<br>
<br>
+#define VHOST_USER_GPU_PROTOCOL_F_EDID 0<br>
+<br>
=C2=A0struct virtio_gpu_scanout {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t width, height;<br>
=C2=A0 =C2=A0 =C2=A0int x, y;<br>
@@ -122,6 +131,7 @@ typedef struct VuGpu {<br>
<br>
=C2=A0 =C2=A0 =C2=A0bool virgl;<br>
=C2=A0 =C2=A0 =C2=A0bool virgl_inited;<br>
+=C2=A0 =C2=A0 bool edid_inited;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t inflight;<br>
<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_scanout scanout[VIRTIO_GPU_MAX_SCANOU=
TS];<br>
@@ -171,6 +181,7 @@ int=C2=A0 =C2=A0 =C2=A0vg_create_mapping_iov(VuGpu *g,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovec **iov);<br>
=C2=A0void=C2=A0 =C2=A0 vg_cleanup_mapping_iov(VuGpu *g, struct iovec *iov,=
 uint32_t count);<br>
=C2=A0void=C2=A0 =C2=A0 vg_get_display_info(VuGpu *vg, struct virtio_gpu_ct=
rl_command *cmd);<br>
+void=C2=A0 =C2=A0 vg_get_edid(VuGpu *vg, struct virtio_gpu_ctrl_command *c=
md);<br>
<br>
=C2=A0void=C2=A0 =C2=A0 vg_wait_ok(VuGpu *g);<br>
<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000006940ca05fd1fb031--

