Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E0271F9E9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 08:12:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4y0S-0007CC-IJ; Fri, 02 Jun 2023 02:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q4y06-0007AB-KZ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:11:03 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q4y01-0008Sw-7U
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 02:11:02 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f50a8f6dd7so2241609e87.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685686252; x=1688278252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iLRt5ueyEnOzWanTYR3n2Ri/yZqD/75ZNoWlkEU51dA=;
 b=WmyzyRxg0I63Va2EfytWt0E1uh//EHNC7FcPXj64I6atjwuPqVEKtaxvJEcxyBZ+ld
 VSYAtxsF2M0KsVj8SJaZpLpUkz22dXMhZu5/iL00zpi3HHltejBUXPZXTASVqATzvyRp
 9y+bOv4YUNrxUGmXc5ufFgpKdbpYNVuQOJ7PhNsVniP7nRKe5u+8nw4yLVlpODPg9zz3
 4KrCy1SfFyujJUAAjMyuO4jPVc0P/cLZoVm1PRIy5V6rpUJcu9lYrVsu2LdHSec+kIfN
 l43GK7qpB6O+rmYRifb1/XTNWDeHSpuobT4UYMMD+gsFJcrUFOlyLW8R9ta3DIh6xFaj
 GroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685686252; x=1688278252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iLRt5ueyEnOzWanTYR3n2Ri/yZqD/75ZNoWlkEU51dA=;
 b=LYCEIBNHy6cLRBcyimOhSM6FpWS+X/69MUXlcU8hxNG+biSLFs/hLzGre4fRwM5seI
 17op9dpWx1nf4QnxQ6vImlwQSLBy5TdHrEthygwHBQ3dkSAWy3kIs1Cn1RHpDV161Iat
 KC+9z/jelSQbBObieauVuA7mAdGi6TOb+iPM9X3FiEJpN4rSEoc0BKrWbaAPFg4nayjZ
 vNj6ipQeczNrRFFfCejGI02d8+bbJ7Uy256GRauKzpfk7OA07F4XkOnTlxP/VdoomiBB
 vs++3uJaxBSDNK6WCR8jCYNue5S6+S3b4XuCbajlZlgkkqybFSaoUKcmOEheRuZTAuNk
 r4Vg==
X-Gm-Message-State: AC+VfDzKauN/GT+pYT8dSS2k4HLKkJnQOGR2l7I8mv6Xg9B7WY8PRZGE
 TowljX+km8bezs1OdmlkmraTTsbIPdAkEXN5foc=
X-Google-Smtp-Source: ACHHUZ7y5tMva2UHvuRSKVIxRpynFt5Cr4eTXNrH555395I9fYruAtIRQYxWqWa8eyUHiDBU+uqUf5wE/l3g4qZVaQ8=
X-Received: by 2002:a19:7614:0:b0:4ef:d5cb:18e0 with SMTP id
 c20-20020a197614000000b004efd5cb18e0mr1156628lff.43.1685686252301; Thu, 01
 Jun 2023 23:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230531160631.612893-1-ernunes@redhat.com>
 <20230531160631.612893-3-ernunes@redhat.com>
In-Reply-To: <20230531160631.612893-3-ernunes@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 2 Jun 2023 10:10:40 +0400
Message-ID: <CAJ+F1CJDfBdSNr8jV=tEDL+QAGHVpw-7K-N+Ls4ny8kjU=ZSLQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] docs: vhost-user-gpu: add protocol changes for EDID
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, kraxel@redhat.com
Content-Type: multipart/alternative; boundary="00000000000045717705fd1f6a68"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000045717705fd1f6a68
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, May 31, 2023 at 8:08=E2=80=AFPM Erico Nunes <ernunes@redhat.com> wr=
ote:

> VHOST_USER_GPU_GET_EDID is defined as a message from the backend to the
> frontend to retrieve the EDID data for a given scanout.
>
> The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is defined as a way
> to check whether this new message is supported or not.
>
> Signed-off-by: Erico Nunes <ernunes@redhat.com>
> ---
>  docs/interop/vhost-user-gpu.rst | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/docs/interop/vhost-user-gpu.rst
> b/docs/interop/vhost-user-gpu.rst
> index 1640553729..ab86391aee 100644
> --- a/docs/interop/vhost-user-gpu.rst
> +++ b/docs/interop/vhost-user-gpu.rst
> @@ -141,6 +141,8 @@ In QEMU the vhost-user-gpu message is implemented wit=
h
> the following struct:
>            VhostUserGpuScanout scanout;
>            VhostUserGpuUpdate update;
>            VhostUserGpuDMABUFScanout dmabuf_scanout;
> +          VhostUserGpuEdidRequest edid_req;
>

Please add  VhostUserGpuEdidRequest payload description in "Payload types"
section

+          struct virtio_gpu_resp_edid resp_edid;
>            struct virtio_gpu_resp_display_info display_info;
>            uint64_t u64;
>        } payload;
> @@ -149,10 +151,11 @@ In QEMU the vhost-user-gpu message is implemented
> with the following struct:
>  Protocol features
>  -----------------
>
> -None yet.
> +.. code:: c
> +
> +  #define VHOST_USER_GPU_PROTOCOL_F_EDID 0
>
> -As the protocol may need to evolve, new messages and communication
> -changes are negotiated thanks to preliminary
> +New messages and communication changes are negotiated thanks to the
>  ``VHOST_USER_GPU_GET_PROTOCOL_FEATURES`` and
>  ``VHOST_USER_GPU_SET_PROTOCOL_FEATURES`` requests.
>
> @@ -241,3 +244,12 @@ Message types
>    Note: there is no data payload, since the scanout is shared thanks
>    to DMABUF, that must have been set previously with
>    ``VHOST_USER_GPU_DMABUF_SCANOUT``.
> +
> +``VHOST_USER_GPU_GET_EDID``
> +  :id: 11
> +  :request payload: ``struct VhostUserGpuEdidRequest``
> +  :reply payload: ``struct virtio_gpu_resp_edid`` (from virtio
> specification)
> +
> +  Retrieve the EDID data for a given scanout.
> +  This message requires the ``VHOST_USER_GPU_PROTOCOL_F_EDID`` protocol
> +  feature to be supported.
> --
> 2.40.1
>
>
>
thanks

--=20
Marc-Andr=C3=A9 Lureau

--00000000000045717705fd1f6a68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 31, 2023 at 8:08=E2=80=
=AFPM Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com">ernunes@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">VHOST_USER_GPU_GET_EDID is defined as a message from the backend to the<=
br>
frontend to retrieve the EDID data for a given scanout.<br>
<br>
The VHOST_USER_GPU_PROTOCOL_F_EDID protocol feature is defined as a way<br>
to check whether this new message is supported or not.<br>
<br>
Signed-off-by: Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com" target=
=3D"_blank">ernunes@redhat.com</a>&gt;<br>
---<br>
=C2=A0docs/interop/vhost-user-gpu.rst | 18 +++++++++++++++---<br>
=C2=A01 file changed, 15 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/docs/interop/vhost-user-gpu.rst b/docs/interop/vhost-user-gpu.=
rst<br>
index 1640553729..ab86391aee 100644<br>
--- a/docs/interop/vhost-user-gpu.rst<br>
+++ b/docs/interop/vhost-user-gpu.rst<br>
@@ -141,6 +141,8 @@ In QEMU the vhost-user-gpu message is implemented with =
the following struct:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserGpuScanout scanout;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserGpuUpdate update;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VhostUserGpuDMABUFScanout dmabuf_s=
canout;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VhostUserGpuEdidRequest edid_req;<br></=
blockquote><div><br></div><div>Please add=C2=A0 VhostUserGpuEdidRequest pay=
load description in &quot;Payload types&quot; section<br></div><div><br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct virtio_gpu_resp_edid resp_edid;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct virtio_gpu_resp_display_inf=
o display_info;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t u64;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0} payload;<br>
@@ -149,10 +151,11 @@ In QEMU the vhost-user-gpu message is implemented wit=
h the following struct:<br>
=C2=A0Protocol features<br>
=C2=A0-----------------<br>
<br>
-None yet.<br>
+.. code:: c<br>
+<br>
+=C2=A0 #define VHOST_USER_GPU_PROTOCOL_F_EDID 0<br>
<br>
-As the protocol may need to evolve, new messages and communication<br>
-changes are negotiated thanks to preliminary<br>
+New messages and communication changes are negotiated thanks to the<br>
=C2=A0``VHOST_USER_GPU_GET_PROTOCOL_FEATURES`` and<br>
=C2=A0``VHOST_USER_GPU_SET_PROTOCOL_FEATURES`` requests.<br>
<br>
@@ -241,3 +244,12 @@ Message types<br>
=C2=A0 =C2=A0Note: there is no data payload, since the scanout is shared th=
anks<br>
=C2=A0 =C2=A0to DMABUF, that must have been set previously with<br>
=C2=A0 =C2=A0``VHOST_USER_GPU_DMABUF_SCANOUT``.<br>
+<br>
+``VHOST_USER_GPU_GET_EDID``<br>
+=C2=A0 :id: 11<br>
+=C2=A0 :request payload: ``struct VhostUserGpuEdidRequest``<br>
+=C2=A0 :reply payload: ``struct virtio_gpu_resp_edid`` (from virtio specif=
ication)<br>
+<br>
+=C2=A0 Retrieve the EDID data for a given scanout.<br>
+=C2=A0 This message requires the ``VHOST_USER_GPU_PROTOCOL_F_EDID`` protoc=
ol<br>
+=C2=A0 feature to be supported.<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><div><br></div><div>thanks<br></div><br><span class=3D"g=
mail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signat=
ure">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000045717705fd1f6a68--

