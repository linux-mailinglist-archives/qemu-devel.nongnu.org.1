Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 057B872BF1C
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 12:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8epp-0005zx-Qd; Mon, 12 Jun 2023 06:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q8epm-0005zh-TE
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 06:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1q8epk-00036g-IN
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 06:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686565895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BvhHlRKi7+Orr15dGM2wxcNaZvEgKAVvJ57eeG0bsNQ=;
 b=dbphqjeQZ82/elIJyHVIeZ01cUtYTHIzTiNah3Xwv2YMVKUaeENGdeagE2mUhqYYnqpXBo
 2Mp+BOrIQEzc3o8tzavMMOlaLSToBAxfZP7F0pHnGU8FOfSyy8wk1uqfJivLRL8985Ghvw
 A2VKycaidKQ0LE3JUzd9mJB/P4Sj0ZQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-OcVkq4jqOIe5r4480RtJpg-1; Mon, 12 Jun 2023 06:31:33 -0400
X-MC-Unique: OcVkq4jqOIe5r4480RtJpg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51566dc6066so4003851a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 03:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686565890; x=1689157890;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvhHlRKi7+Orr15dGM2wxcNaZvEgKAVvJ57eeG0bsNQ=;
 b=ZvW/X1lZfS/USA3iImNX4LCWciiMh6DoE4JPsQTnVWPC4sYouDp9Vliu5xpTBrdiie
 eQJosyBW96kwqAjm3XZuc3/F175ji6ChjAkIdGo9oyQCeMcXO5FVZRhWu2pg4bTTwEkb
 t+FgQCvdSh+lUPdjz4q1KjjsKajLemMbyN/uIb5ZagQBWfoNunWGCsyCOLKWMjXK3Qzs
 YkoGrU38+HjoCxdvi5gY4VegZmV6XKUJwiOhzyuwmP1LlfcJhusp0zFDpENLE83ZGhfs
 kuk8e47v2jgcYV6Lb02+JbJcLU5hz+iTzo1nKoAIPPT0i00M+8DRTxoIJTR0kLy/v2pF
 Yo5Q==
X-Gm-Message-State: AC+VfDwrBW3e/CSkgs7XDCxCfbnBvFro+42L7446mwvFvfQ2f7nvJ6sS
 g0vCaWX8EF0qR3c1KQeteTRXSk6Em34nclfi7hkU3syuPHoBmHwfvC3c5+k8jc1uBqp+Vzx3fDs
 tjUEQur6jM04u9YmHh9WS2SJEXt1tecKUjMs137E=
X-Received: by 2002:aa7:da81:0:b0:514:9c7c:8a30 with SMTP id
 q1-20020aa7da81000000b005149c7c8a30mr5145626eds.30.1686565890725; 
 Mon, 12 Jun 2023 03:31:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Cn50PRJf2gx+rft8sW9vB2e4BCNJE9DvcQ127QIUAVmNaY8af6y6jOuz5HkRV7fc7aDQT5kkdsdaN8KqOLws=
X-Received: by 2002:aa7:da81:0:b0:514:9c7c:8a30 with SMTP id
 q1-20020aa7da81000000b005149c7c8a30mr5145616eds.30.1686565890427; Mon, 12 Jun
 2023 03:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230607145455.158267-1-ernunes@redhat.com>
 <20230607145455.158267-5-ernunes@redhat.com>
In-Reply-To: <20230607145455.158267-5-ernunes@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 12 Jun 2023 12:31:15 +0200
Message-ID: <CAMxuvaw5mKt1=i++Uxv+9hHWW_0-MQvgEDFAeZ+XzdZkg8f-nQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] vhost-user-gpu: implement get_edid frontend feature
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="000000000000ca227c05fdec3890"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000ca227c05fdec3890
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 7, 2023 at 4:55=E2=80=AFPM Erico Nunes <ernunes@redhat.com> wro=
te:

> Implement the frontend side of the get_edid feature in the qemu
> vhost-user-gpu frontend device.
>
> Signed-off-by: Erico Nunes <ernunes@redhat.com>
> ---
>  hw/display/vhost-user-gpu.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> index 71dfd956b8..184e57dfc7 100644
> --- a/hw/display/vhost-user-gpu.c
> +++ b/hw/display/vhost-user-gpu.c
> @@ -31,6 +31,7 @@ typedef enum VhostUserGpuRequest {
>      VHOST_USER_GPU_UPDATE,
>      VHOST_USER_GPU_DMABUF_SCANOUT,
>      VHOST_USER_GPU_DMABUF_UPDATE,
> +    VHOST_USER_GPU_GET_EDID,
>  } VhostUserGpuRequest;
>
>  typedef struct VhostUserGpuDisplayInfoReply {
> @@ -78,6 +79,10 @@ typedef struct VhostUserGpuDMABUFScanout {
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
> @@ -88,6 +93,8 @@ typedef struct VhostUserGpuMsg {
>          VhostUserGpuScanout scanout;
>          VhostUserGpuUpdate update;
>          VhostUserGpuDMABUFScanout dmabuf_scanout;
> +        VhostUserGpuEdidRequest edid_req;
> +        struct virtio_gpu_resp_edid resp_edid;
>          struct virtio_gpu_resp_display_info display_info;
>          uint64_t u64;
>      } payload;
> @@ -99,6 +106,8 @@ static VhostUserGpuMsg m __attribute__ ((unused));
>
>  #define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4
>
> +#define VHOST_USER_GPU_PROTOCOL_F_EDID 0
> +
>  static void vhost_user_gpu_update_blocked(VhostUserGPU *g, bool blocked)=
;
>
>  static void
> @@ -161,6 +170,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g,
> VhostUserGpuMsg *msg)
>              .request =3D msg->request,
>              .flags =3D VHOST_USER_GPU_MSG_FLAG_REPLY,
>              .size =3D sizeof(uint64_t),
> +            .payload =3D {
> +                .u64 =3D (1 << VHOST_USER_GPU_PROTOCOL_F_EDID)
> +            }
>          };
>
>          vhost_user_gpu_send_msg(g, &reply);
> @@ -184,6 +196,30 @@ vhost_user_gpu_handle_display(VhostUserGPU *g,
> VhostUserGpuMsg *msg)
>          vhost_user_gpu_send_msg(g, &reply);
>          break;
>      }
> +    case VHOST_USER_GPU_GET_EDID: {
> +        VhostUserGpuEdidRequest *m =3D &msg->payload.edid_req;
> +        struct virtio_gpu_resp_edid resp =3D { {} };
> +        int fd =3D qemu_chr_fe_get_msgfd(&g->vhost_chr);
>

The message doesn't have associated FD.


> +        VhostUserGpuMsg reply =3D {
> +            .request =3D msg->request,
> +            .flags =3D VHOST_USER_GPU_MSG_FLAG_REPLY,
> +            .size =3D sizeof(reply.payload.resp_edid),
> +        };
> +
> +        if (m->scanout_id >=3D g->parent_obj.conf.max_outputs) {
> +            error_report("invalid scanout: %d", m->scanout_id);
>

Thus fd will always be -1.


> +            if (fd >=3D 0) {
> +                close(fd);
> +            }
> +            break;
> +        }
> +
> +        resp.hdr.type =3D VIRTIO_GPU_RESP_OK_EDID;
> +        virtio_gpu_base_generate_edid(VIRTIO_GPU_BASE(g), m->scanout_id,
> &resp);
> +        memcpy(&reply.payload.resp_edid, &resp, sizeof(resp));
> +        vhost_user_gpu_send_msg(g, &reply);
> +        break;
> +    }
>      case VHOST_USER_GPU_SCANOUT: {
>          VhostUserGpuScanout *m =3D &msg->payload.scanout;
>
> --
> 2.40.1
>
>

--000000000000ca227c05fdec3890
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 7, 2023 at 4:55=E2=80=
=AFPM Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com">ernunes@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Implement the frontend side of the get_edid feature in the qemu<br>
vhost-user-gpu frontend device.<br>
<br>
Signed-off-by: Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com" target=
=3D"_blank">ernunes@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/display/vhost-user-gpu.c | 36 ++++++++++++++++++++++++++++++++++++=
<br>
=C2=A01 file changed, 36 insertions(+)<br>
<br>
diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c<br>
index 71dfd956b8..184e57dfc7 100644<br>
--- a/hw/display/vhost-user-gpu.c<br>
+++ b/hw/display/vhost-user-gpu.c<br>
@@ -31,6 +31,7 @@ typedef enum VhostUserGpuRequest {<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_UPDATE,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_DMABUF_SCANOUT,<br>
=C2=A0 =C2=A0 =C2=A0VHOST_USER_GPU_DMABUF_UPDATE,<br>
+=C2=A0 =C2=A0 VHOST_USER_GPU_GET_EDID,<br>
=C2=A0} VhostUserGpuRequest;<br>
<br>
=C2=A0typedef struct VhostUserGpuDisplayInfoReply {<br>
@@ -78,6 +79,10 @@ typedef struct VhostUserGpuDMABUFScanout {<br>
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
@@ -88,6 +93,8 @@ typedef struct VhostUserGpuMsg {<br>
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
@@ -99,6 +106,8 @@ static VhostUserGpuMsg m __attribute__ ((unused));<br>
<br>
=C2=A0#define VHOST_USER_GPU_MSG_FLAG_REPLY 0x4<br>
<br>
+#define VHOST_USER_GPU_PROTOCOL_F_EDID 0<br>
+<br>
=C2=A0static void vhost_user_gpu_update_blocked(VhostUserGPU *g, bool block=
ed);<br>
<br>
=C2=A0static void<br>
@@ -161,6 +170,9 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUse=
rGpuMsg *msg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.request =3D msg-&gt;reques=
t,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =3D VHOST_USER_GPU_M=
SG_FLAG_REPLY,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.size =3D sizeof(uint64_t),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .payload =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .u64 =3D (1 &lt;&l=
t; VHOST_USER_GPU_PROTOCOL_F_EDID)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_user_gpu_send_msg(g, &amp;reply);<b=
r>
@@ -184,6 +196,30 @@ vhost_user_gpu_handle_display(VhostUserGPU *g, VhostUs=
erGpuMsg *msg)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vhost_user_gpu_send_msg(g, &amp;reply);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 case VHOST_USER_GPU_GET_EDID: {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserGpuEdidRequest *m =3D &amp;msg-&gt;pa=
yload.edid_req;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_resp_edid resp =3D { {} };<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd =3D qemu_chr_fe_get_msgfd(&amp;g-&gt;vh=
ost_chr);<br></blockquote><div><br></div><div>The message doesn&#39;t have =
associated FD.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserGpuMsg reply =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .request =3D msg-&gt;request,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .flags =3D VHOST_USER_GPU_MSG_FL=
AG_REPLY,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .size =3D sizeof(reply.payload.r=
esp_edid),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (m-&gt;scanout_id &gt;=3D g-&gt;parent_obj.=
conf.max_outputs) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;invalid scano=
ut: %d&quot;, m-&gt;scanout_id);<br>
</blockquote><div><br></div><div>Thus fd will always be -1.</div><div>=C2=
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd &gt;=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 resp.hdr.type =3D VIRTIO_GPU_RESP_OK_EDID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_gpu_base_generate_edid(VIRTIO_GPU_BASE(=
g), m-&gt;scanout_id, &amp;resp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;reply.payload.resp_edid, &amp;resp=
, sizeof(resp));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_gpu_send_msg(g, &amp;reply);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0case VHOST_USER_GPU_SCANOUT: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserGpuScanout *m =3D &amp;msg-&gt;p=
ayload.scanout;<br>
<br>
-- <br>
2.40.1<br>
<br></blockquote><div><br></div><div>=C2=A0<br></div></div></div>

--000000000000ca227c05fdec3890--


