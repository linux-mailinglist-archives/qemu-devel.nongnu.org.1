Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA77072BB60
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:55:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dJT-0000lI-7U; Mon, 12 Jun 2023 04:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8dJQ-0000ks-P8
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:54:08 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1q8dJO-00015u-Lt
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 04:54:08 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2b1b66a8fd5so45741811fa.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 01:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686560044; x=1689152044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2pD7RknhGbr6uKkc/L64pl4rqYFDHyRXbI0fGyaf9FE=;
 b=g53DqZSj5iPAMr3xKSamzIq4NCv/YYUrcxlwnvd71fjfuS+HUEo+CcXMCE302JP9MD
 63WAX3R1eaF5pAEFGxrdwAUA/rd9PGRvjf/RBlBDroRFiQcW5QGeSpvs6+zBNdS4APZH
 STNiifm7VYIlNicvx38FMD645ucQB/b03/gM2AfmaSoCzzhfdYn0/1hflNPRLeocg26k
 OsC7kO975ehp7z2rEcLXNRRMiNlAjCYJ+D2gjEBRTdQnlxYt7iDDO48M9ecHRpzGrPNj
 qp0+TfWUHSsQ1ALEwz2r2u4ONFoivZup8m+B0H3q2tZu9UUmmIpYsuO3Irkj51LDzncp
 l/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686560044; x=1689152044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2pD7RknhGbr6uKkc/L64pl4rqYFDHyRXbI0fGyaf9FE=;
 b=AfAbBoiXR+qkTcOS9Vi5qPPPbr9uL+JEiKip3HAR0yohMuD0nnfqHnFxtv4RqGdSuj
 cfdrVBSQZWuqYmK4bCaPtqtF3tZaz133MnrHl17otayjsvtqnq5lm68fVXt22lXo0k+g
 rH9IN/002ZEJRl8pHxD1JDxWthKI8RGabwm8M38CWn3X4bcZc/H4rm258bZ68rK1aIH9
 3g8Msqj2bcQQuvhjpFH1anOOy7QC9Xu7Y2dJgaLQtcMiQzOvmyDarBkZD4oJa95Vjq0h
 hzTq5zf08eNaY0Q2InS5oE61sDPpNHMGMMojW1plH+BKaQhXrHZxy/sAxuNiIviNB8z6
 TrJA==
X-Gm-Message-State: AC+VfDxpBOB8jwJbUze2rz7EzWNVU5yk2ovJHpShuYZpI6CUP9R9IK6b
 e+b8idJwrX+SXWByZhtp4Wdq1WjDfPqdWCpndV0=
X-Google-Smtp-Source: ACHHUZ6ygbwEFX/LUmK9/G+tlJI5cmMdWJhwI7E8oEGCPP2jjXFBwo00mDOc3HcbMgF1Q1Y0MeDFWtJ9RhKaT4Oz+y4=
X-Received: by 2002:a2e:9c83:0:b0:2a8:a859:b5c7 with SMTP id
 x3-20020a2e9c83000000b002a8a859b5c7mr2232451lji.0.1686560044499; Mon, 12 Jun
 2023 01:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230612021358.25068-1-zhukeqian1@huawei.com>
In-Reply-To: <20230612021358.25068-1-zhukeqian1@huawei.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Jun 2023 10:53:49 +0200
Message-ID: <CAJ+F1CKXAs_EGGRRWiWYCN0iDkPHuC7_b7sJkjtn4PEVdb7-BQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: Optimize 2D resource data transfer
To: Keqian Zhu <zhukeqian1@huawei.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 limingwang@huawei.com, 
 zhaoyimin1@huawei.com, wubinfeng@huawei.com, skorodumov.dmitry@huawei.com, 
 wanghaibin.wang@huawei.com
Content-Type: multipart/alternative; boundary="00000000000058457705fdeadc80"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-lj1-x234.google.com
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

--00000000000058457705fdeadc80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Mon, Jun 12, 2023 at 4:15=E2=80=AFAM Keqian Zhu via <qemu-devel@nongnu.o=
rg>
wrote:

> The following points sometimes can reduce much data
> to copy:
> 1. When width matches, we can transfer data with one
> call of iov_to_buf().
> 2. Only the required height need to transfer, not
> whole image.
>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>

lgtm,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/display/virtio-gpu.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 66cddd94d9..af31018ab0 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -438,11 +438,11 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGP=
U
> *g,
>                                             struct virtio_gpu_ctrl_comman=
d
> *cmd)
>  {
>      struct virtio_gpu_simple_resource *res;
> -    int h;
> +    int h, bpp;
>      uint32_t src_offset, dst_offset, stride;
> -    int bpp;
>      pixman_format_code_t format;
>      struct virtio_gpu_transfer_to_host_2d t2d;
> +    void *img_data;
>
>      VIRTIO_GPU_FILL_CMD(t2d);
>      virtio_gpu_t2d_bswap(&t2d);
> @@ -471,23 +471,23 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGP=
U
> *g,
>      format =3D pixman_image_get_format(res->image);
>      bpp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
>      stride =3D pixman_image_get_stride(res->image);
> +    img_data =3D pixman_image_get_data(res->image);
>
> -    if (t2d.offset || t2d.r.x || t2d.r.y ||
> -        t2d.r.width !=3D pixman_image_get_width(res->image)) {
> -        void *img_data =3D pixman_image_get_data(res->image);
> +    if (t2d.r.x || t2d.r.width !=3D pixman_image_get_width(res->image)) =
{
>          for (h =3D 0; h < t2d.r.height; h++) {
>              src_offset =3D t2d.offset + stride * h;
>              dst_offset =3D (t2d.r.y + h) * stride + (t2d.r.x * bpp);
>
>              iov_to_buf(res->iov, res->iov_cnt, src_offset,
> -                       (uint8_t *)img_data
> -                       + dst_offset, t2d.r.width * bpp);
> +                       (uint8_t *)img_data + dst_offset,
> +                       t2d.r.width * bpp);
>          }
>      } else {
> -        iov_to_buf(res->iov, res->iov_cnt, 0,
> -                   pixman_image_get_data(res->image),
> -                   pixman_image_get_stride(res->image)
> -                   * pixman_image_get_height(res->image));
> +        src_offset =3D t2d.offset;
> +        dst_offset =3D t2d.r.y * stride + t2d.r.x * bpp;
> +        iov_to_buf(res->iov, res->iov_cnt, src_offset,
> +                   (uint8_t *)img_data + dst_offset,
> +                   stride * t2d.r.height);
>      }
>  }
>
> --
> 2.20.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000058457705fdeadc80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 12, 2023 at 4:15=E2=80=
=AFAM Keqian Zhu via &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-deve=
l@nongnu.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">The following points sometimes can reduce much data<br>
to copy:<br>
1. When width matches, we can transfer data with one<br>
call of iov_to_buf().<br>
2. Only the required height need to transfer, not<br>
whole image.<br>
<br>
Signed-off-by: Keqian Zhu &lt;<a href=3D"mailto:zhukeqian1@huawei.com" targ=
et=3D"_blank">zhukeqian1@huawei.com</a>&gt;<br></blockquote><div><br></div>=
<div>lgtm, <br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=
=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;=
</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
---<br>
=C2=A0hw/display/virtio-gpu.c | 22 +++++++++++-----------<br>
=C2=A01 file changed, 11 insertions(+), 11 deletions(-)<br>
<br>
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c<br>
index 66cddd94d9..af31018ab0 100644<br>
--- a/hw/display/virtio-gpu.c<br>
+++ b/hw/display/virtio-gpu.c<br>
@@ -438,11 +438,11 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU =
*g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct virtio_gpu_ctrl_command *cmd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_simple_resource *res;<br>
-=C2=A0 =C2=A0 int h;<br>
+=C2=A0 =C2=A0 int h, bpp;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t src_offset, dst_offset, stride;<br>
-=C2=A0 =C2=A0 int bpp;<br>
=C2=A0 =C2=A0 =C2=A0pixman_format_code_t format;<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_gpu_transfer_to_host_2d t2d;<br>
+=C2=A0 =C2=A0 void *img_data;<br>
<br>
=C2=A0 =C2=A0 =C2=A0VIRTIO_GPU_FILL_CMD(t2d);<br>
=C2=A0 =C2=A0 =C2=A0virtio_gpu_t2d_bswap(&amp;t2d);<br>
@@ -471,23 +471,23 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU =
*g,<br>
=C2=A0 =C2=A0 =C2=A0format =3D pixman_image_get_format(res-&gt;image);<br>
=C2=A0 =C2=A0 =C2=A0bpp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);<br>
=C2=A0 =C2=A0 =C2=A0stride =3D pixman_image_get_stride(res-&gt;image);<br>
+=C2=A0 =C2=A0 img_data =3D pixman_image_get_data(res-&gt;image);<br>
<br>
-=C2=A0 =C2=A0 if (t2d.offset || t2d.r.x || t2d.r.y ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 t2d.r.width !=3D pixman_image_get_width(res-&g=
t;image)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *img_data =3D pixman_image_get_data(res-&=
gt;image);<br>
+=C2=A0 =C2=A0 if (t2d.r.x || t2d.r.width !=3D pixman_image_get_width(res-&=
gt;image)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (h =3D 0; h &lt; t2d.r.height; h++) {=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0src_offset =3D t2d.offset +=
 stride * h;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dst_offset =3D (t2d.r.y + h=
) * stride + (t2d.r.x * bpp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iov_to_buf(res-&gt;iov, res=
-&gt;iov_cnt, src_offset,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(uint8_t *)img_data<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+ dst_offset, t2d.r.width * bpp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(uint8_t *)img_data + dst_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0t2d.r.width * bpp);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov_to_buf(res-&gt;iov, res-&gt;iov_cnt, 0,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pixma=
n_image_get_data(res-&gt;image),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pixma=
n_image_get_stride(res-&gt;image)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* pix=
man_image_get_height(res-&gt;image));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 src_offset =3D t2d.offset;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dst_offset =3D t2d.r.y * stride + t2d.r.x * bp=
p;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 iov_to_buf(res-&gt;iov, res-&gt;iov_cnt, src_o=
ffset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(uint=
8_t *)img_data + dst_offset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strid=
e * t2d.r.height);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.20.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000058457705fdeadc80--

